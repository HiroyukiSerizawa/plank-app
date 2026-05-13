import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SFX再生サービス。
///
/// `AudioPool` を採用：短尺SFX専用APIで、`create()` 時にサンプルをRAMに完全
/// 展開し、Audio HAL とのコネクションも確立する。これにより `start()` 呼び
/// 出し時のコールド起動遅延（"3" の頭が切れる現象）を回避する。
///
/// プリロード対象は v1.0.4 で実使用する 7 ファイル（5, 4, 3, 2, 1, go, done）
/// のみ。10-6.mp3 は同梱されているが将来の長尺セッション向け予約のため
/// メモリには載せない。
class SoundService {
  SoundService._();
  static final SoundService instance = SoundService._();

  static const _prefsKey = 'sound_enabled';
  static const _preloadAssets = [
    '5.mp3',
    '4.mp3',
    '3.mp3',
    '2.mp3',
    '1.mp3',
    'go.mp3',
    'done.mp3',
  ];

  final Map<String, AudioPool> _pools = {};
  // play() ごとに AudioPool.start() が返す「この再生を止める関数」を控える。
  // AudioPool は内部で複数プレイヤー管理しており、明示的に止める手段はこれ
  // のみ。abort時に呼び出す。
  final Map<String, Future<void> Function()> _lastStops = {};

  bool _enabled = true;
  bool _initialized = false;

  bool get enabled => _enabled;

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    final prefs = await SharedPreferences.getInstance();
    _enabled = prefs.getBool(_prefsKey) ?? true;
    for (final name in _preloadAssets) {
      _pools[name] = await AudioPool.create(
        source: AssetSource('sounds/$name'),
        maxPlayers: 2,
      );
    }
    // Audio HAL kick: 1サンプルだけ音量0で発火しておく。AudioPool は事前
    // ロード済みだが、Android のオーディオ出力ハードウェア層は実音を出すまで
    // 完全起動しないため、最初のユーザートリガが頭切れする。"go.mp3" は
    // 短いので採用。
    await _pools['go.mp3']?.start(volume: 0.0);
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> setEnabled(bool value) async {
    _enabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, value);
  }

  /// 指定アセットを即時再生。SFXがOFFまたはプリロード対象外なら何もしない。
  Future<void> play(String asset) async {
    if (!_enabled) return;
    final pool = _pools[asset];
    if (pool == null) return;
    // Fire-and-forget: タイマーコールバックをブロックしない。
    unawaited(pool.start().then((stopFn) => _lastStops[asset] = stopFn));
  }

  /// 全プレイヤー停止。Abort / GiveUp 時に呼ぶ。
  Future<void> stopAll() async {
    for (final stopFn in _lastStops.values) {
      await stopFn();
    }
    _lastStops.clear();
  }

  Future<void> dispose() async {
    for (final pool in _pools.values) {
      await pool.dispose();
    }
    _pools.clear();
    _lastStops.clear();
    _initialized = false;
  }
}
