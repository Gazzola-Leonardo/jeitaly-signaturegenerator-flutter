import 'package:flutter/material.dart';

class HtmlHelper {
  final BuildContext context;

  HtmlHelper(this.context);

  double htmlPxToFlutterPx(double px) {
    double scaleFactor = MediaQuery.of(context).devicePixelRatio;
    return px / scaleFactor;
  }

  double flutterPxToHtmlPx(double px) {
    double scaleFactor = MediaQuery.of(context).devicePixelRatio;
    return px * scaleFactor;
  }
}
