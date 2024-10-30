import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class SignatureProvider {
  static Future<String> getEmptySignature() async {
    return await rootBundle.loadString('assets/formatted.html');
  }
}
