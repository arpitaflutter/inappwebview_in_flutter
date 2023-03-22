import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:inappwebview_in_flutter/screens/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class home_screen extends StatefulWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {

  home_provider? hf, ht;

  @override
  Widget build(BuildContext context) {
    hf = Provider.of<home_provider>(context, listen: false);
    ht = Provider.of<home_provider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 60,
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 2,
                      blurRadius: 2
                  )
                ],
              ),
              child: TextField(
                controller: hf!.txtsearch,
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () {
                        var newLink = hf!.txtsearch.text;

                        ht!.inAppWebViewController!.loadUrl(
                            urlRequest: URLRequest(url: Uri.parse(
                                "http://www.google.com/search?q=$newLink")));
                      }, icon: Icon(Icons.search, color: Colors.black45),
                    ),
                    border: InputBorder.none
                ),
              ),
            ),
            LinearProgressIndicator(value: hf!.progress),
            Expanded(
              child: InAppWebView(
                initialUrlRequest:
                URLRequest(url: Uri.parse("https://www.google.com/")),
                onLoadError: (controller, url, code, message) {
                  ht!.inAppWebViewController = controller;
                },
                onLoadStart: (controller, url) {
                  ht!.inAppWebViewController = controller;
                },
                onLoadStop: (controller, url) {
                  ht!.inAppWebViewController = controller;
                },
                onProgressChanged: (controller, progress) {
                  ht!.changeProgress(progress / 100);
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: () {
                    ht!.inAppWebViewController!.goBack();
                  }, icon: Icon(Icons.arrow_back)),
                  IconButton(onPressed: () {
                    ht!.inAppWebViewController!.reload();
                  }, icon: Icon(Icons.refresh)),
                  IconButton(onPressed: () {
                    ht!.inAppWebViewController!.goForward();
                  }, icon: Icon(Icons.arrow_forward))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
