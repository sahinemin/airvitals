import 'package:airvitals/core/presentation/mixins/validator_mixin.dart';
import 'package:airvitals/core/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';

final class PasswordFormField extends StatelessWidget with ValidatorMixin {
  const PasswordFormField({
    required this.labelText,
    required this.controller,
    this.validator,
    this.textInputAction = TextInputAction.done,
    super.key,
  });

  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      labelText: labelText,
      obscureText: true,
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: textInputAction,
      autofillHints: const [AutofillHints.password],
      validator: (value) {
        final isValid = isValidPassword(value);
        if (isValid != null) {
          return isValid;
        }
        if (validator != null) {
          return validator!(value);
        }
        return null;
      },
    );
  }
}
