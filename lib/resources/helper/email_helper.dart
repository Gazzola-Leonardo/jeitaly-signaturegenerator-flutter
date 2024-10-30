import 'package:jeitaly_signaturegenerator_flutter/models/signature_model.dart';
import 'package:jeitaly_signaturegenerator_flutter/references.dart';

class EmailHelper {
  static bool isValidEmail(String email) {
    return RegExp(References.emailRegex).hasMatch(email);
  }

  static String? generateEmailFromSignature(final SignatureModel signature) {
    final String predictedEmail = "${signature.name.toLowerCase()}.${signature.surname.replaceAll(" ", "").toLowerCase()}@${References.emailDomain}";

    if (isValidEmail(predictedEmail)) {
      return predictedEmail;
    }

    return null;
  }
}
