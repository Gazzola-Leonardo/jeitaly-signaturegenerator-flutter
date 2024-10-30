import 'package:jeitaly_signaturegenerator_flutter/references.dart';

class SignatureModel {
  final String name, surname;
  final String emailName, phoneNumber;
  final String role;

  String get displayName => "$name $surname";

  String get displayPhoneNumber => "${References.phonePrefix} $phoneNumber";

  String get displayEmail => "$emailName@${References.emailDomain}";

  SignatureModel({
    required this.name,
    required this.surname,
    required this.emailName,
    required this.phoneNumber,
    required this.role,
  });
}
