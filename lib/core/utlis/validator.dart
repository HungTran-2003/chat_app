class AppValidator {
  static bool validateEmpty(String? input) {
    if (input == null || input.isEmpty) {
      return false;
    }
    return true;
  }

  static String? validatePassword(String input) {
    RegExp regex = RegExp(r'^[a-zA-Z0-9]{8,12}$');
    bool isValid = regex.hasMatch(input);
    if (!isValid) {
      return "8-12 characters. Including letters, numbers";
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (password != confirmPassword) {
      return "Confirm password is not match";
    }
    return null;
  }

  static bool validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null) return false;
    return phoneNumber.replaceAll(RegExp(r'[^0-9]'), '').length >= 10;
  }

  static bool validateCodeToVerifyPhoneNumber(String? code) {
    if (code == null) return false;
    return code.replaceAll(RegExp(r'[^0-9]'), '').isNotEmpty;
  }

  static String? validateEmail(String input) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(input)) {
      return "Invalid email format";
    }
    return null;
  }
}