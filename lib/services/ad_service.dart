import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// AdMob 統合サービス。
///
/// 配置方針（CEO決定 2026-05-15）：
/// - **バナー**：タイマー画面・履歴画面・統計画面の下部に常時表示
/// - **App Open**：バックグラウンド復帰時に表示（コールドスタート初回は出さない）
/// - **インターステ**：使用しない（CEO 撤回 2026-05-15。達成感ブロック / 体感が悪い）
///
/// テスト/本番 ID は `kReleaseMode` で自動切替。
class AdService {
  // Google 提供のテストID（ローカル/QA用）。
  // ref: https://developers.google.com/admob/android/test-ads
  static const _testBannerId = 'ca-app-pub-3940256099942544/6300978111';
  static const _testAppOpenId = 'ca-app-pub-3940256099942544/9257395921';

  // 本番ad-unit-ID（リリースビルドのみ）。
  static const _prodBannerId = 'ca-app-pub-3745259041113437/4390642503';
  // TODO(CEO): AdMob コンソールで App Open 用 ad unit を発行し、ここに差し替え。
  static const _prodAppOpenId = 'ca-app-pub-3745259041113437/0000000001';

  static String get _bannerId =>
      kReleaseMode ? _prodBannerId : _testBannerId;
  static String get _appOpenId =>
      kReleaseMode ? _prodAppOpenId : _testAppOpenId;

  // ─── Banner ───
  static BannerAd createBanner({required void Function(Ad) onLoaded}) {
    return BannerAd(
      adUnitId: _bannerId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: onLoaded,
        onAdFailedToLoad: (ad, error) => ad.dispose(),
      ),
    )..load();
  }

  // ─── App Open ───
  static AppOpenAd? _appOpenAd;
  static bool _appOpenLoading = false;
  static bool _appOpenShowing = false;
  // App Open ads expire after ~4 hours. Reload if older.
  static DateTime? _appOpenLoadTime;
  static const _appOpenMaxAge = Duration(hours: 4);

  static void loadAppOpenAd() {
    if (_appOpenAd != null || _appOpenLoading) return;
    _appOpenLoading = true;
    AppOpenAd.load(
      adUnitId: _appOpenId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _appOpenLoadTime = DateTime.now();
          _appOpenLoading = false;
        },
        onAdFailedToLoad: (error) {
          _appOpenAd = null;
          _appOpenLoading = false;
        },
      ),
    );
  }

  /// App Open 広告を表示。バックグラウンド復帰時に呼ぶ想定。
  /// 未ロード・期限切れ・他広告表示中は no-op して次回分を先読み。
  static Future<void> showAppOpenAdIfAvailable() async {
    if (_appOpenShowing) return;
    final ad = _appOpenAd;
    final loaded = _appOpenLoadTime;
    if (ad == null || loaded == null) {
      loadAppOpenAd();
      return;
    }
    if (DateTime.now().difference(loaded) > _appOpenMaxAge) {
      ad.dispose();
      _appOpenAd = null;
      _appOpenLoadTime = null;
      loadAppOpenAd();
      return;
    }
    _appOpenShowing = true;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        _appOpenShowing = false;
        ad.dispose();
        _appOpenAd = null;
        _appOpenLoadTime = null;
        loadAppOpenAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _appOpenShowing = false;
        ad.dispose();
        _appOpenAd = null;
        _appOpenLoadTime = null;
        loadAppOpenAd();
      },
    );
    _appOpenAd = null;
    await ad.show();
  }
}
