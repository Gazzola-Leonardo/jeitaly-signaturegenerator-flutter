class PhoneNumberHelper {
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return phoneNumber.replaceFirstMapped(RegExp(r'(\d{3})(\d{3})(\d{4})'), (match) => '(${match[1]}) ${match[2]}-${match[3]}');
    }

    return phoneNumber;
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    // Only numbers or + or space
    return RegExp(r'^[0-9\+ ]+$').hasMatch(phoneNumber);
  }
}
