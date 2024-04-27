import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tu/tu.dart';

class RFView extends StatefulWidget {
  const RFView({super.key});

  @override
  State<RFView> createState() => _RFViewState();
}

class _RFViewState extends State<RFView> with WidgetsBindingObserver {
  AdSize _adSize = const AdSize(width: 0, height: 0);
  final adUnitId = "ca-app-pub-6998775064333809/4570771915";
  BannerAd? _bannerAd;

  void _loadAd() {
    final bannerAd = BannerAd(
      size: _adSize,
      adUnitId: adUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    // Start loading.
    bannerAd.load();
  }

  void _setupAd() {
    setState(() {
      _adSize = AdSize(width: screenSize(context).width.toInt(), height: 45);
    });

    _loadAd();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _setupAd();
    });
    //
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _setupAd();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RF")),
      body: Column(children: [
        Expanded(
            child: Container(
          color: Colors.red,
        )),
        _bannerAd.isNotNull
            ? SizedBox(height: 45, child: AdWidget(ad: _bannerAd!))
            : none()
      ]),
    );
  }
}
