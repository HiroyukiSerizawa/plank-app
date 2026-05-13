import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SFX再生サービス。
///
/// プリロード対象は v1.0.4 で実使用する 7 ファイル
/// （5, 4, 3, 2, 1, go, done）のみ。10-6.mp3 は同梱されているが
/// 将来の長尺セッション向け予約のためメモリには載せない。
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

  final Map<String, AudioPlayer> _players = {};
  bool _enabled = true;
  bool _initialized = false;

  bool get enabled => _enabled;

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    final prefs = await SharedPreferences.getInstance();
    _enabled = prefs.getBool(_prefsKey) ?? true;
    for (final name in _preloadAssets) {
      final player = AudioPlayer()..setReleaseMode(ReleaseMode.stop);
      await player.setSource(AssetSource('sounds/$name'));
      _players[name] = player;
    }
  }

  Future<void> setEnabled(bool value) async {
    _enabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, value);
  }

  /// 指定アセットを即時再生。SFXがOFFまたはプリロード対象外なら何もしない。
  Future<void> play(String asset) async {
    if (!_enabled) return;
    final player = _players[asset];
    if (player == null) return;
    await player.stop();
    await player.seek(Duration.zero);
    await player.resume();
  }

  /// 全プレイヤー停止。Abort / GiveUp 時に呼ぶ。
  Future<void> stopAll() async {
    for (final player in _players.values) {
      await player.stop();
    }
  }

  Future<void> dispose() async {
    for (final player in _players.values) {
      await player.dispose();
    }
    _players.clear();
    _initialized = false;
  }
}
