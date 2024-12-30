import 'package:airvitals/core/presentation/mixins/validator_mixin.dart';
import 'package:airvitals/core/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';

final class EmailFormField extends StatelessWidget with ValidatorMixin {
  const EmailFormField({
    required this.emailController,
    this.labelText,
    this.textInputAction = TextInputAction.next,
    super.key,
  });

  final TextEditingController emailController;
  final TextInputAction textInputAction;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      labelText: labelText ?? 'Email',
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      autofillHints: const [AutofillHints.email],
      validator: isValidEmail,
      textInputAction: textInputAction,
    );
  }
}
