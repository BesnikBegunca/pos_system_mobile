import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'DMSans';

  static TextStyle pageTitle({double size = 30}) => TextStyle(
    fontFamily: fontFamily,
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: AppColors.charcoalText,
    height: 1.15,
    letterSpacing: -0.3,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.charcoalText,
  );

  static const TextStyle cardTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.charcoalText,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.charcoalText,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.mediumGreenText,
  );

  static const TextStyle muted = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.lightGreenText,
  );

  static const TextStyle kpiValue = TextStyle(
    fontFamily: fontFamily,
    fontSize: 44,
    fontWeight: FontWeight.w600,
    color: AppColors.charcoalText,
    height: 1.05,
  );
}
