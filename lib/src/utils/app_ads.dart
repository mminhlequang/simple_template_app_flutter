import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'utils.dart';

String adUnitIdRewardedAd = kDebugMode
    ? Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/5224354917'
        : 'ca-app-pub-3940256099942544/1712485313'
    : Platform.isAndroid
        ? 'ca-app-pub-6190294097703418/9642139346'
        : 'ca-app-pub-6190294097703418/8417807144';

String adUnitIdBanner = kDebugMode
    ? Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/6300978111'
        : 'ca-app-pub-3940256099942544/2934735716'
    : Platform.isAndroid
        ? 'ca-app-pub-6190294097703418/6726948387'
        : 'ca-app-pub-6190294097703418/6702897658';

String _adUnitIdInterstitial = kDebugMode
    ? Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/1033173712'
        : 'ca-app-pub-3940256099942544/4411468910'
    : Platform.isAndroid
        ? 'ca-app-pub-6190294097703418/6595324126'
        : 'ca-app-pub-6190294097703418/5473814149';

bool get isAdsEnable => isMobile;

Future adsInitialize() async {
  if (isAdsEnable) {
    await MobileAds.instance.initialize();
    _loadInterstitialAd();
  }
}

/// Loads an interstitial ad.
AdManagerInterstitialAd? _interstitialAd;
void _loadInterstitialAd() {
  AdManagerInterstitialAd.load(
    adUnitId: _adUnitIdInterstitial,
    request: const AdManagerAdRequest(),
    adLoadCallback: AdManagerInterstitialAdLoadCallback(
      // Called when an ad is successfully received.
      onAdLoaded: (ad) {
        // appSentryCaptureMessage(
        //     where: 'AdManagerInterstitialAd', msg: 'onAdLoaded: loaded');
        ad.fullScreenContentCallback = FullScreenContentCallback(
            // Called when the ad showed the full screen content.
            onAdShowedFullScreenContent: (ad) {},
            // Called when an impression occurs on the ad.
            onAdImpression: (ad) {},
            // Called when the ad failed to show full screen content.
            onAdFailedToShowFullScreenContent: (ad, err) async {
              // Dispose the ad here to free resources.
              await ad.dispose();
              _loadInterstitialAd();
              appSentryCaptureMessage(
                  where: 'AdManagerInterstitialAd',
                  msg: 'onAdFailedToShowFullScreenContent: ${err.message}');
            },
            // Called when the ad dismissed full screen content.
            onAdDismissedFullScreenContent: (ad) async {
              // Dispose the ad here to free resources.
              await ad.dispose();
              _loadInterstitialAd();
            },
            // Called when a click is recorded for an ad.
            onAdClicked: (ad) {});

        // Keep a reference to the ad so you can show it later.
        _interstitialAd = ad;
      },
      // Called when an ad request failed.
      onAdFailedToLoad: (LoadAdError error) {
        // appSentryCaptureMessage(
        //     where: 'AdManagerInterstitialAd', msg: 'onAdFailedToLoad: $error');
      },
    ),
  );
}

int _indexClick = 0;
showInterstitialAd() async {
  if (!isAdsEnable) return;
  if (_interstitialAd == null) {
    _loadInterstitialAd();
  } else {
    _indexClick++;
    if (_indexClick % 3 != 0) return;
    await _interstitialAd?.show();
  }
}
