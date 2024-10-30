import 'package:jeitaly_signaturegenerator_flutter/references.dart';

class SignatureModel {
  final String name, surname;
  final String email, phoneNumber;
  final String role;

  String get displayName => "$name $surname";

  String get displayPhoneNumber => "${References.phonePrefix} $phoneNumber";

  SignatureModel({
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    required this.role,
  });
}
