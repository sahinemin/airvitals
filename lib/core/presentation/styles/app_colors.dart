import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand Colors
  static const primary = Color(0xFF13B9FF);
  static const primaryLight = Color(0xFF4CCAFF);
  static const primaryDark = Color(0xFF0D8BC2);

  static const secondary = Color(0xFF6C757D);
  static const secondaryLight = Color(0xFF8C959E);
  static const secondaryDark = Color(0xFF495057);

  // Semantic Colors
  static const error = Color(0xFFDC3545);
  static const errorLight = Color(0xFFE35D6A);
  static const errorDark = Color(0xFFB02A37);

  static const success = Color(0xFF28A745);
  static const successLight = Color(0xFF34CE57);
  static const successDark = Color(0xFF1E7E34);

  static const warning = Color(0xFFFFC107);
  static const warningLight = Color(0xFFFFCD39);
  static const warningDark = Color(0xFFD39E00);

  static const info = Color(0xFF17A2B8);
  static const infoLight = Color(0xFF1FC8E3);
  static const infoDark = Color(0xFF117A8B);

  // Neutral Colors
  static const background = Color(0xFFFFFFFF);
  static const surface = Color(0xFFF8F9FA);
  static const surfaceVariant = Color(0xFFE9ECEF);

  // Gray Scale
  static const gray50 = Color(0xFFF8F9FA);
  static const gray100 = Color(0xFFE9ECEF);
  static const gray200 = Color(0xFFDEE2E6);
  static const gray300 = Color(0xFFCED4DA);
  static const gray400 = Color(0xFFADB5BD);
  static const gray500 = Color(0xFF6C757D);
  static const gray600 = Color(0xFF495057);
  static const gray700 = Color(0xFF343A40);
  static const gray800 = Color(0xFF212529);
  static const gray900 = Color(0xFF121416);

  // Text Colors
  static const textPrimary = Color(0xFF212529);
  static const textSecondary = Color(0xFF6C757D);
  static const textDisabled = Color(0xFFADB5BD);
  static const textInverse = Color(0xFFFFFFFF);

  // Status Colors
  static const online = Color(0xFF28A745);
  static const offline = Color(0xFFDC3545);
  static const away = Color(0xFFFFC107);
  static const busy = Color(0xFFE83E8C);

  // Overlay Colors
  static const overlay = Color(0x80000000);
  static const overlayLight = Color(0x0D000000);
  static const overlayDark = Color(0xCC000000);

  // Gradients
  static const primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
