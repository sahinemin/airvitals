import 'package:airvitals/core/presentation/mixins/validator_mixin.dart';
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
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return ValueListenableBuilder<bool>(
      valueListenable: hasError,
      builder: (context, hasErrorValue, child) {
        final padding = hasErrorValue || widget.helperText != null
            ? const EdgeInsets.only(bottom: Dimensions.sm)
            : EdgeInsets.zero;
        return Container(
          constraints: BoxConstraints(
            maxHeight: Dimensions.inputHeight.h,
            minHeight: Dimensions.inputHeight.h,
          ),
          padding: padding,
          child: ValueListenableBuilder<bool>(
            valueListenable: obscureText,
            builder: (context, obscureTextValue, child) {
              return TextFormField(
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface,
                ),
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
                          context,
                            value,
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
                  filled: true,
                  fillColor: colorScheme.surface,
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: Visibility(
                    visible: widget.obscureText,
                    child: IconButton(
                      icon: Icon(
                        obscureTextValue
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: hasErrorValue
                            ? colorScheme.error
                            : colorScheme.onSurfaceVariant,
                      ),
                      onPressed: () {
                        obscureText.value = !obscureTextValue;
                      },
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadius),
                    borderSide: BorderSide(color: colorScheme.outline),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadius),
                    borderSide: BorderSide(color: colorScheme.outline),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadius),
                    borderSide: BorderSide(
                      color: colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadius),
                    borderSide: BorderSide(color: colorScheme.error),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadius),
                    borderSide: BorderSide(
                      color: colorScheme.error,
                      width: 2,
                    ),
                  ),
                  floatingLabelStyle: textTheme.bodyLarge?.copyWith(
                    color:
                        hasErrorValue ? colorScheme.error : colorScheme.primary,
                  ),
                  helperStyle: textTheme.labelSmall?.copyWith(
                    color: hasErrorValue
                        ? colorScheme.error
                        : colorScheme.onSurfaceVariant,
                  ),
                  labelStyle: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  contentPadding: widget.contentPadding ??
                      EdgeInsets.symmetric(
                        horizontal: Dimensions.md.w,
                        vertical: Dimensions.sm.h,
                      ),
                  labelText: widget.labelText,
                  helperText: hasErrorValue ? widget.helperText : null,
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
