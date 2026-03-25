import 'package:flutter/material.dart';
import '../../core/extensions/material_color_extension.dart';
import '../res/config_imports.dart';

class AppTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.brandPrimary,
      brightness: Brightness.light,
    ).copyWith(
      surface: AppColors.scaffoldBackground,
      onSurface: AppColors.main,
      primary: AppColors.brandPrimary,
      onPrimary: AppColors.buttonText,
      error: AppColors.error,
    );

    return ThemeData(
      colorScheme: colorScheme,
      primarySwatch: AppColors.brandPrimary.toMaterialColor(),
      primaryColor: AppColors.brandPrimary,
      useMaterial3: true,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      fontFamily: ConstantManager.fontFamily,
      bottomSheetTheme: const BottomSheetThemeData(
        modalBackgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
      ),
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.brandPrimary,
        unselectedItemColor: AppColors.navInactive,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.pW4),
          foregroundColor: AppColors.brandPrimary,
          minimumSize: Size(AppSize.sW30, AppSize.sH30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.sH0),
          ),
        ),
      ),
      dialogTheme: const DialogThemeData(surfaceTintColor: Colors.transparent),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.brandPrimary,
        selectionColor: AppColors.brandPrimary.withValues(alpha: 0.2),
        selectionHandleColor: AppColors.brandPrimary,
      ),
      appBarTheme: const AppBarTheme(foregroundColor: AppColors.white),
      iconTheme: const IconThemeData(color: AppColors.white),
      inputDecorationTheme: const InputDecorationTheme(
        prefixIconColor: AppColors.border,
      ),
    );
  }

  static ThemeData get dark {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColorsWithDarkMode.buttonColor,
      brightness: Brightness.dark,
    );

    return ThemeData(
      colorScheme: colorScheme,
      primarySwatch: AppColorsWithDarkMode.buttonColor.toMaterialColor(),
      primaryColor: AppColorsWithDarkMode.buttonColor,
      useMaterial3: true,
      fontFamily: ConstantManager.fontFamily,
      bottomSheetTheme: const BottomSheetThemeData(
        modalBackgroundColor: AppColorsWithDarkMode.white,
      ),
      scaffoldBackgroundColor: AppColorsWithDarkMode.border,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColorsWithDarkMode.white,
        selectedItemColor: AppColorsWithDarkMode.buttonColor,
        unselectedItemColor: AppColorsWithDarkMode.hintText,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.pW4),
          foregroundColor: AppColorsWithDarkMode.buttonColor,
          minimumSize: Size(AppSize.sW30, AppSize.sH30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.sH0),
          ),
        ),
      ),
      dialogTheme: const DialogThemeData(surfaceTintColor: Colors.transparent),
      appBarTheme: const AppBarTheme(
        foregroundColor: AppColorsWithDarkMode.white,
      ),
      iconTheme: const IconThemeData(color: AppColorsWithDarkMode.white),
      inputDecorationTheme: const InputDecorationTheme(
        prefixIconColor: AppColorsWithDarkMode.border,
      ),
    );
  }
}
