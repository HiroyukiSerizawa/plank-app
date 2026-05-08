import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  // 本番リリース時は実際のIDに差し替える
  static const _bannerId = 'ca-app-pub-3745259041113437/4390642503';

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
}
