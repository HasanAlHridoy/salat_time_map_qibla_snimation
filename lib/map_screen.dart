import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NearbyMosques extends StatefulWidget {
  const NearbyMosques({Key? key}) : super(key: key);

  @override
  State<NearbyMosques> createState() => _NearbyMosquesState();
}

class _NearbyMosquesState extends State<NearbyMosques> {
  InAppWebViewController? webViewCtrl;
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest:
          URLRequest(url: Uri.parse("https://www.google.com/maps/search/mosque+near+me/@23.7925102,90.403235,16z/data=!3m1!4b1?entry=ttu")),
      onWebViewCreated: (controller) {
        webViewCtrl = controller;
      },
    );
  }
}
