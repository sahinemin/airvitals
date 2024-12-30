mixin ValidatorMixin {
  String? isValidEmail(String? value) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
    );
    final isNullOrEmpty = isNullOrEmptyValidator(value);

    if (isNullOrEmpty != null) return isNullOrEmpty;

    if (!emailRegex.hasMatch(value!)) {
      return 'Invalid email address';
    }

    return null;
  }

  String? isValidPassword(String? value) {
    final isNullOrEmpty = isNullOrEmptyValidator(value);

    if (isNullOrEmpty != null) return isNullOrEmpty;
    if (!isAtLeast8Characters(value!)) {
      return 'Password must be at least 8 characters';
    }
    if (!containsUppercase(value)) {
      return 'Password must contain uppercase letters';
    }
    if (!containsLowercase(value)) {
      return 'Password must contain lowercase letters';
    }
    if (!containsSpecialCharacter(value)) {
      return 'Password must contain special characters';
    }
    if (!containsNumber(value)) {
      return 'Password must contain numbers';
    }
    return null;
  }

  bool containsNumber(String password) => RegExp(r'\d').hasMatch(password);
  bool isAtLeast8Characters(String password) => password.length >= 8;
  bool containsUppercase(String password) => RegExp('[A-Z]').hasMatch(password);
  bool containsLowercase(String password) => RegExp('[a-z]').hasMatch(password);
  bool containsSpecialCharacter(String password) =>
      RegExp(r'[\W]').hasMatch(password);

  String? isNullOrEmptyValidator(String? value, {String? message}) {
    message ??= 'This field is required';
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }
}
