//? flutter-imports
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
//? my-imports
import 'ad_helper.dart';
import 'homepage_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await AppOpenAd.load(
    adUnitId: AdHelper.openAppAdUnitId,
    orientation: AppOpenAd.orientationPortrait,
    request: const AdRequest(),
    adLoadCallback: AppOpenAdLoadCallback(
      onAdLoaded: (ad) async {
        await ad.show();
      },
      onAdFailedToLoad: (error) {
        debugPrint('AppOpenAd failed to load: $error');
        // Handle the error.
      },
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
