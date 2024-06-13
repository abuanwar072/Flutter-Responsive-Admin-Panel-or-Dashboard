import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/app_text_form_field_theme.dart';

class AppTheme {
  static ThemeData light(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.bgLight,
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.bgSecondayLight,
        surfaceTintColor: AppColors.bgSecondayLight,
      ),
      primaryColor: AppColors.primary,
      textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
          .apply(
              bodyColor: AppColors.titleLight,
              displayColor: AppColors.titleLight)
          .copyWith(
            bodyLarge: const TextStyle(color: AppColors.textLight),
            bodyMedium: const TextStyle(color: AppColors.textLight),
            bodySmall: const TextStyle(color: AppColors.textLight),
          ),
      iconTheme: const IconThemeData(color: AppColors.iconLight),
      dividerColor: AppColors.highlightLight,
      dividerTheme: const DividerThemeData(
        thickness: 1,
        color: AppColors.highlightLight,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(100, 56),
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppDefaults.borderRadius),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.titleLight,
          minimumSize: const Size(100, 56),
          padding: const EdgeInsets.symmetric(
              horizontal: AppDefaults.padding, vertical: AppDefaults.padding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDefaults.borderRadius),
          ),
          side: BorderSide(color: AppColors.highlightLight, width: 2),
        ),
      ),
      inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
      expansionTileTheme:
          const ExpansionTileThemeData(shape: const RoundedRectangleBorder()),
      badgeTheme:
          BadgeThemeData(backgroundColor: AppColors.error, smallSize: 8),
    );
  }
}
