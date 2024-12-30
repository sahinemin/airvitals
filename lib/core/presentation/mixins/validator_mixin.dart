import 'package:airvitals/l10n/l10n.dart';
import 'package:flutter/material.dart';

mixin ValidatorMixin {
  String? isValidEmail(BuildContext context, String? value) {
    final l10n = context.l10n;
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
    );
    final isNullOrEmpty = isNullOrEmptyValidator(context, value);

    if (isNullOrEmpty != null) return isNullOrEmpty;

    if (!emailRegex.hasMatch(value!)) {
      return l10n.invalidEmailError;
    }

    return null;
  }

  String? isValidPassword(BuildContext context, String? value) {
    final l10n = context.l10n;
    final isNullOrEmpty = isNullOrEmptyValidator(context, value);

    if (isNullOrEmpty != null) return isNullOrEmpty;
    if (!isAtLeast8Characters(value!)) {
      return l10n.invalidPasswordError;
    }
    if (!containsUppercase(value)) {
      return l10n.passwordUppercaseError;
    }
    if (!containsLowercase(value)) {
      return l10n.passwordLowercaseError;
    }
    if (!containsSpecialCharacter(value)) {
      return l10n.passwordSpecialCharError;
    }
    if (!containsNumber(value)) {
      return l10n.passwordNumberError;
    }
    return null;
  }

  bool containsNumber(String password) => RegExp(r'\d').hasMatch(password);
  bool isAtLeast8Characters(String password) => password.length >= 8;
  bool containsUppercase(String password) => RegExp('[A-Z]').hasMatch(password);
  bool containsLowercase(String password) => RegExp('[a-z]').hasMatch(password);
  bool containsSpecialCharacter(String password) =>
      RegExp(r'[\W]').hasMatch(password);

  String? isNullOrEmptyValidator(BuildContext context, String? value) {
    final l10n = context.l10n;
    if (value == null || value.isEmpty) {
      return l10n.requiredFieldError;
    }
    return null;
  }
}
