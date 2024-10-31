import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:jeitaly_signaturegenerator_flutter/models/signature_model.dart';

class SignatureProvider {
  final SignatureModel signature;

  SignatureProvider(this.signature);

  static Future<String> getEmptySignature() async {
    return await rootBundle.loadString('assets/formatted.html');
  }

  Future<String> getCompiledSignature() async {
    String htmlSignature = await getEmptySignature();

    htmlSignature = htmlSignature.replaceAll("{{displayName}}", signature.displayName);
    htmlSignature = htmlSignature.replaceAll("{{role}}", signature.role);
    htmlSignature = htmlSignature.replaceAll("{{email}}", signature.displayEmail);
    htmlSignature = htmlSignature.replaceAll("{{phoneNumber}}", signature.displayPhoneNumber);

    return htmlSignature;
  }
}
