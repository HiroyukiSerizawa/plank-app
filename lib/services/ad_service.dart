import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  // 本番リリース時は実際のIDに差し替える
  static const _testBannerId = 'ca-app-pub-3940256099942544/6300978111';

  static BannerAd createBanner({required void Function(Ad) onLoaded}) {
    return BannerAd(
      adUnitId: _testBannerId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: onLoaded,
        onAdFailedToLoad: (ad, error) => ad.dispose(),
      ),
    )..load();
  }
}
