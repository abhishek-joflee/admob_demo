import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_helper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NativeAd? _nativeAd;
  // bool _isAdLoaded = false;
  int _counter = 0;

  _createNativeAD() {
    var _ad = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _nativeAd = ad as NativeAd;
          });
          debugPrint('Ad loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          debugPrint('Ad failed to load: $error');
        },
        onAdOpened: (Ad ad) => debugPrint('Ad opened.'),
        onAdImpression: (Ad ad) => debugPrint('Ad impression.'),
        onNativeAdClicked: (NativeAd ad) => debugPrint('Ad clicked.'),
        onAdClosed: (Ad ad) => debugPrint('Ad closed.'),
      ),
    );
    _ad.load();
  }

  @override
  void initState() {
    super.initState();
    _createNativeAD();
  }

  @override
  void dispose() {
    _nativeAd!.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // _createNativeAD();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _nativeAd == null
                ? Container(
                    height: 100.0,
                    width: double.infinity,
                    color: Colors.green,
                  )
                : Container(
                    height: 100.0,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: AdWidget(ad: _nativeAd!),
                  ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
