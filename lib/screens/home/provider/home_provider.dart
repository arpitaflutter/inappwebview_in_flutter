import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class home_provider extends ChangeNotifier
{

  double progress = 0;
  TextEditingController txtsearch = TextEditingController();
  InAppWebViewController? inAppWebViewController;

  void changeProgress(double ps)
  {
    progress = ps;
    notifyListeners();
  }

}