import 'package:airvitals/core/presentation/mixins/validator_mixin.dart';
import 'package:airvitals/core/presentation/styles/app_colors.dart';
import 'package:airvitals/core/presentation/values/dimensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'mixins/custom_form_field_mixin.dart';

@immutable
final class CustomFormField extends StatefulWidget {
  const CustomFormField({
    required this.labelText,
    required this.controller,
    this.helperText,
    this.contentPadding,
    this.inputFormatters,
    this.textInputAction = TextInputAction.next,
    this.keyboardType,
    this.autofillHints,
    this.focusNode,
    this.maxLines = 1,
    super.key,
    this.maxLength,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.onFieldSubmitted,
    this.autoFocus = false,
    this.isOptional = false,
    this.emptyFieldMessage,
  });

  final String? emptyFieldMessage;
  final FocusNode? focusNode;
  final String? helperText;
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;
  final bool autoFocus;
  final bool isOptional;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLines;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField>
    with ValidatorMixin, CustomFormFieldMixin {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: hasError,
      builder: (context, hasErrorValue, child) {
        final padding = hasErrorValue || widget.helperText != null
            ? const EdgeInsets.only(bottom: Dimensions.sm)
            : EdgeInsets.zero;
        return Container(
          constraints: BoxConstraints(
            maxHeight: 76.h,
            minHeight: Dimensions.inputHeight.h,
          ),
          padding: padding,
          child: ValueListenableBuilder<bool>(
            valueListenable: obscureText,
            builder: (context, obscureTextValue, child) {
              return TextFormField(
                obscureText: obscureTextValue,
                maxLines: widget.maxLines,
                maxLength: widget.maxLength,
                focusNode: widget.focusNode,
                autofocus: !kIsWeb && widget.autoFocus,
                keyboardType: widget.keyboardType,
                autofillHints: widget.autofillHints,
                textAlignVertical: TextAlignVertical.center,
                validator: (value) {
                  final result = widget.isOptional
                      ? widget.validator?.call(value)
                      : isNullOrEmptyValidator(
                            value,
                            message: widget.emptyFieldMessage,
                          ) ??
                          widget.validator?.call(value);
                  hasError.value = result != null;
                  return result;
                },
                controller: widget.controller,
                textInputAction: widget.textInputAction,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                onChanged: (value) {
                  if (hasError.value) {
                    hasError.value = false;
                  }
                },
                decoration: InputDecoration(
                  suffixIcon: Visibility(
                    visible: widget.obscureText,
                    child: IconButton(
                      icon: Icon(
                        obscureTextValue
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () {
                        obscureText.value = !obscureTextValue;
                      },
                    ),
                  ),
                  floatingLabelStyle:
                      Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: hasError.value
                                ? AppColors.error
                                : AppColors.primary,
                          ),
                  helperStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: hasError.value
                            ? AppColors.error
                            : AppColors.textSecondary,
                      ),
                  labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                  contentPadding: widget.contentPadding ??
                      EdgeInsets.symmetric(
                        horizontal: Dimensions.md.w,
                        vertical: Dimensions.sm.h,
                      ),
                  labelText: widget.labelText,
                  helperText: hasError.value ? widget.helperText : null,
                ),
                onFieldSubmitted: widget.onFieldSubmitted,
                inputFormatters: widget.inputFormatters,
              );
            },
          ),
        );
      },
    );
  }
}
