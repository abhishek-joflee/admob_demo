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
  late RewardedAd _rewardedAd;
  bool _isRewardedAdReady = false;

  int _counter = 0;

  void _loadRewardedAd() {
    debugPrint("loading..,, rewarded ad");
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              debugPrint("full screen dismissed...");
              setState(() {
                _isRewardedAdReady = false;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            _isRewardedAdReady = true;
          });
        },
        onAdFailedToLoad: (err) {
          debugPrint('Failed to load a rewarded ad: ${err.message}');
          setState(() {
            _isRewardedAdReady = false;
          });
        },
      ),
    );
  }

  @override
  void initState() {
    // _loadRewardedAd();
    super.initState();
  }

  @override
  void dispose() {
    _rewardedAd.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    if (_counter % 2 == 0) {
      _loadRewardedAd();
    }

    if (_isRewardedAdReady && _counter % 3 == 0) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Need a hint?'),
            content: const Text('Watch an Ad to get a hint!'),
            actions: [
              TextButton(
                child: Text('cancel'.toUpperCase()),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('ok'.toUpperCase()),
                onPressed: () {
                  Navigator.pop(context);
                  _rewardedAd.show(
                    onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
                      debugPrint("reward earned !!");
                      // _loadRewardedAd();
                    },
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('At multiple of 3, You\'ll ask for ad.[if loaded]'),
            const SizedBox(height: 20.0),
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
