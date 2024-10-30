class SignatureModel {
  final String name, surname;
  final String email, phoneNumber;
  final String role;

  String get displayName => "$name $surname";

  SignatureModel({
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    required this.role,
  });
}
