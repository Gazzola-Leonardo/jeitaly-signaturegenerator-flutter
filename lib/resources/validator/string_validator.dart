import 'package:jeitaly_signaturegenerator_flutter/references.dart';
import 'package:jeitaly_signaturegenerator_flutter/resources/helper/email_helper.dart';
import 'package:jeitaly_signaturegenerator_flutter/resources/helper/phone_number_helper.dart';

class StringValidator {
  static String? requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Campo obbligatorio";
    }

    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Campo obbligatorio";
    }

    if (!EmailHelper.isValidEmail(value + "@${References.emailDomain}")) {
      return "Email non valida";
    }

    return null;
  }

  static String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Campo obbligatorio";
    }

    if (!PhoneNumberHelper.isValidPhoneNumber(value)) {
      return "Numero di telefono non valido";
    }

    return null;
  }
}
