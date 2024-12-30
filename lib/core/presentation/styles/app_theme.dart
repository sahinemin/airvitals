import 'package:airvitals/core/presentation/styles/app_colors.dart';
import 'package:airvitals/core/presentation/styles/app_typography.dart';
import 'package:airvitals/core/presentation/values/dimensions.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final baseTheme = FlexThemeData.light(
      scheme: FlexScheme.custom,
      // Primary & Secondary colors
      primary: AppColors.primary,
      primaryContainer: AppColors.primaryLight,
      secondary: AppColors.secondary,
      secondaryContainer: AppColors.secondaryLight,
      // Semantic colors
      error: AppColors.error,
      errorContainer: AppColors.errorLight,
      // Surface & Background colors
      surface: AppColors.surface,
      // Text colors
      onPrimary: AppColors.textInverse,
      onSecondary: AppColors.textInverse,
      onError: AppColors.textInverse,
      onSurface: AppColors.textPrimary,
      // Component themes
      subThemesData: const FlexSubThemesData(
        // Input fields
        inputDecoratorRadius: Dimensions.borderRadius,
        inputDecoratorUnfocusedBorderIsColored: false,
        inputDecoratorFocusedBorderWidth: 2,
        // Buttons
        buttonMinSize: Size(0, Dimensions.buttonHeight),
        buttonPadding: EdgeInsets.symmetric(horizontal: 16),
        elevatedButtonRadius: Dimensions.borderRadius,
        filledButtonRadius: Dimensions.borderRadius,
        outlinedButtonRadius: Dimensions.borderRadius,
        textButtonRadius: Dimensions.borderRadius,
        // Cards
        cardRadius: Dimensions.borderRadius,
        // Dialogs
        dialogRadius: Dimensions.borderRadius,
        // Bottom sheets
        bottomSheetRadius: Dimensions.borderRadius,
        // Toggles
        switchSchemeColor: SchemeColor.primary,
        checkboxSchemeColor: SchemeColor.primary,
        radioSchemeColor: SchemeColor.primary,
        // Sliders
        sliderBaseSchemeColor: SchemeColor.primary,
        // Progress indicators
        inputDecoratorSchemeColor: SchemeColor.primary,
      ),
    );

    return baseTheme.copyWith(
      textTheme: const TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
      ),
      // Custom color extensions
      extensions: const <ThemeExtension<dynamic>>[
        CustomColors(
          success: AppColors.success,
          successLight: AppColors.successLight,
          successDark: AppColors.successDark,
          warning: AppColors.warning,
          warningLight: AppColors.warningLight,
          warningDark: AppColors.warningDark,
          info: AppColors.info,
          infoLight: AppColors.infoLight,
          infoDark: AppColors.infoDark,
        ),
      ],
    );
  }

  static ThemeData get dark {
    final baseTheme = FlexThemeData.dark(
      scheme: FlexScheme.custom,
      // Primary & Secondary colors
      primary: AppColors.primary,
      primaryContainer: AppColors.primaryDark,
      secondary: AppColors.secondary,
      secondaryContainer: AppColors.secondaryDark,
      // Semantic colors
      error: AppColors.error,
      errorContainer: AppColors.errorDark,
      // Surface & Background colors
      surface: AppColors.gray800,
      // Text colors
      onPrimary: AppColors.textInverse,
      onSecondary: AppColors.textInverse,
      onError: AppColors.textInverse,
      onSurface: AppColors.textInverse,
      // Component themes
      subThemesData: const FlexSubThemesData(
        // Input fields
        inputDecoratorRadius: Dimensions.borderRadius,
        inputDecoratorUnfocusedBorderIsColored: false,
        // Buttons
        buttonMinSize: Size(0, Dimensions.buttonHeight),
        buttonPadding: EdgeInsets.symmetric(horizontal: 16),
        elevatedButtonRadius: Dimensions.borderRadius,
        filledButtonRadius: Dimensions.borderRadius,
        outlinedButtonRadius: Dimensions.borderRadius,
        textButtonRadius: Dimensions.borderRadius,
        // Cards
        cardRadius: Dimensions.borderRadius,
        // Dialogs
        dialogRadius: Dimensions.borderRadius,
        // Bottom sheets
        bottomSheetRadius: Dimensions.borderRadius,
        // Toggles
        switchSchemeColor: SchemeColor.primary,
        checkboxSchemeColor: SchemeColor.primary,
        radioSchemeColor: SchemeColor.primary,
        // Sliders
        sliderBaseSchemeColor: SchemeColor.primary,
        // Progress indicators
      ),
    );

    return baseTheme.copyWith(
      textTheme: const TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
      ),
      // Custom color extensions
      extensions: const <ThemeExtension<dynamic>>[
        CustomColors(
          success: AppColors.success,
          successLight: AppColors.successLight,
          successDark: AppColors.successDark,
          warning: AppColors.warning,
          warningLight: AppColors.warningLight,
          warningDark: AppColors.warningDark,
          info: AppColors.info,
          infoLight: AppColors.infoLight,
          infoDark: AppColors.infoDark,
        ),
      ],
    );
  }
}

// Custom colors extension to access additional colors through theme
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.success,
    required this.successLight,
    required this.successDark,
    required this.warning,
    required this.warningLight,
    required this.warningDark,
    required this.info,
    required this.infoLight,
    required this.infoDark,
  });

  final Color success;
  final Color successLight;
  final Color successDark;
  final Color warning;
  final Color warningLight;
  final Color warningDark;
  final Color info;
  final Color infoLight;
  final Color infoDark;

  @override
  CustomColors copyWith({
    Color? success,
    Color? successLight,
    Color? successDark,
    Color? warning,
    Color? warningLight,
    Color? warningDark,
    Color? info,
    Color? infoLight,
    Color? infoDark,
  }) {
    return CustomColors(
      success: success ?? this.success,
      successLight: successLight ?? this.successLight,
      successDark: successDark ?? this.successDark,
      warning: warning ?? this.warning,
      warningLight: warningLight ?? this.warningLight,
      warningDark: warningDark ?? this.warningDark,
      info: info ?? this.info,
      infoLight: infoLight ?? this.infoLight,
      infoDark: infoDark ?? this.infoDark,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      success: Color.lerp(success, other.success, t)!,
      successLight: Color.lerp(successLight, other.successLight, t)!,
      successDark: Color.lerp(successDark, other.successDark, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningLight: Color.lerp(warningLight, other.warningLight, t)!,
      warningDark: Color.lerp(warningDark, other.warningDark, t)!,
      info: Color.lerp(info, other.info, t)!,
      infoLight: Color.lerp(infoLight, other.infoLight, t)!,
      infoDark: Color.lerp(infoDark, other.infoDark, t)!,
    );
  }
}
