part of '../custom_form_field.dart';

mixin CustomFormFieldMixin on State<CustomFormField> {
  late ValueNotifier<bool> obscureText;
  late ValueNotifier<bool> hasError;

  @override
  void initState() {
    obscureText = ValueNotifier<bool>(widget.obscureText);
    hasError = ValueNotifier<bool>(false);
    super.initState();
  }

  @override
  void dispose() {
    obscureText.dispose();
    hasError.dispose();
    super.dispose();
  }
}
