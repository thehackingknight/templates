import 'dart:io';
import 'package:isar/isar.dart';
import 'package:path/path.dart' as pth;
import 'package:path_provider/path_provider.dart';
import 'package:tu/tu.dart';
import '../models/settings.dart';
import 'constants.dart';

const appLovinBannerId = "";
/* 
class TuAppLovin {
  static Future config() async {
    try {
      await AppLovinMAX.initialize(
          "1tu7Mkwbm9nZmmC2Rtkh2bnxPBLl5VdRbHC3Uvx1NV_XazIn42DeRH0iS7VpkoJZTLaz_T4BzmT1m4VWRFJSDh");
      MainApp.appCtrl.applovinReady = true;
    } catch (e) {
      clog('Failed to init AppLovin');
      clog(e);
    }
  }

  static String interstitialId = "25ef0c5769b8a0b0";

  static initializeInterstitialAds() {
    var interstitialRetryAttempt = 0;
    AppLovinMAX.setInterstitialListener(
        InterstitialListener(onAdLoadedCallback: (ad) {
      // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialReady(_interstitialId) will now return 'true'
      clog('Interstitial ad loaded from ${ad.networkName}');

      // Reset retry attempt
      interstitialRetryAttempt = 0;
    }, onAdLoadFailedCallback: (adUnitId, error) {
      // Interstitial ad failed to load
      // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
      interstitialRetryAttempt = interstitialRetryAttempt + 1;

      int retryDelay = pow(2, min(6, interstitialRetryAttempt)).toInt();

      clog(
          'Interstitial ad failed to load with code ${error.code} - retrying in ${retryDelay}s');

      Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
        AppLovinMAX.loadInterstitial(interstitialId);
      });
    }, onAdDisplayedCallback: (ad) {
      clog("Ad Displayed");
    }, onAdDisplayFailedCallback: (adUnitId, error) {
      clog("Ad Failed");
      clog(error);
    }, onAdClickedCallback: (ad) {
      clog("Ad clicked");
    }, onAdHiddenCallback: (ad) {
      clog("Ad hidden");
    }, onAdRevenuePaidCallback: (ad) {
      clog("Revenue paid");
    }));

    // Load the first interstitial
    AppLovinMAX.loadInterstitial(interstitialId);
  }
}
 */
Future configIsar() async {
  final dir = isMobile
      ? await getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();

  final String mPath = pth.join(
      dir!.path + (!isMobile ? "TunedBass/${Tu.appCtrl.title}" : ""), "db");
  final realDir = Directory.fromUri(Uri.directory(mPath));
  // Create directory if it does not exist already on desktop
  clog("THE DIR IS: $realDir");
  if (!(await realDir.exists())) {
    realDir.createSync(recursive: true);
    clog("DIRECTORY CREATED");
  }

  isar =
      await Isar.open([SettingsSchema], name: "app", directory: realDir.path);
  clog(isar.path);
  clog("ISAR CONFIGURED");
}
