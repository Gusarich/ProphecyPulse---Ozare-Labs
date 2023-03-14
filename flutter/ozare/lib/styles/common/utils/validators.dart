import 'package:get/get.dart';

class Validators {
  static String? phoneValidator(String? value) {
    if (value!.isEmpty) {
      return "Required";
    } else if (!GetUtils.isPhoneNumber(value)) {
      return "Invalid Phone Number";
    }
    return null;
  }

  static String? defaultValidator(String value) {
    if (value.isEmpty) {
      return "Required";
    }
    return null;
  }

  static String? passwordValidator(String value) {
    if (value.isEmpty) {
      return "Required";
    } else if (value.length < 8) {
      return "Password too short";
    } else {
      return null;
    }
  }

  static String? confirmPasswordValidator(
      String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return "Required";
    } else if (confirmPassword.length < 8) {
      return "Password too short";
    } else if (confirmPassword != password) {
      return "Password do not match";
    } else {
      return null;
    }
  }

  static String? usernameValidator(String value) {
    if (value.isEmpty) {
      return "Required";
    } else if (!GetUtils.isUsername(value)) {
      return "Invalid Username";
    } else {
      return null;
    }
  }

  static String? emailValidator(String value) {
    if (value.isEmpty) {
      return "Required";
    } else if (!GetUtils.isEmail(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }
}
