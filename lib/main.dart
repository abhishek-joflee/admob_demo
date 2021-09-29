//? flutter-imports
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
//? my-imports
import 'app_open_ad_manager.dart';
import 'homepage_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  appOpenAdManager.showAdIfAvailable();
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
