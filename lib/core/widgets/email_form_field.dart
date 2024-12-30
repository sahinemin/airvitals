import 'package:airvitals/core/presentation/mixins/validator_mixin.dart';
import 'package:airvitals/core/widgets/custom_form_field.dart';
import 'package:airvitals/l10n/l10n.dart';
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
      labelText: labelText ?? context.l10n.emailLabel,
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      autofillHints: const [AutofillHints.email],
      validator: (value) => isValidEmail(context, value),
      textInputAction: textInputAction,
    );
  }
}
