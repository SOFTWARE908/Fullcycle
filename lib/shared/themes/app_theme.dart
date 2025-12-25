import 'package:flutter/material.dart';

import '../../core/resources/colors.dart';

class AppThemes {
  /// =====================
  /// Light / White Theme
  /// =====================
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'IBMPlexSansArabic',
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.blackColor,
    cardColor: AppColors.whiteColor,
    hintColor: AppColors.blackColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.white,
      brightness: Brightness.light,
    ),
    dividerTheme: const DividerThemeData(color: Colors.transparent),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(color: Colors.black),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.blackColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        foregroundColor: WidgetStateProperty.all(AppColors.blackColor),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.whiteColor,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textColor,
        fontFamily: 'IBMPlexSansArabic',
      ),
      iconTheme: IconThemeData(color: AppColors.blackColor),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.blackColor),
      titleMedium: TextStyle(color: AppColors.blackColor),
      titleSmall: TextStyle(color: AppColors.blackColor),
      bodyLarge: TextStyle(color: AppColors.blackColor),
      bodyMedium: TextStyle(color: AppColors.blackColor),
      bodySmall: TextStyle(color: AppColors.blackColor),
    ),
  );

  /// =====================
  /// Dark Theme
  /// =====================
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'IBMPlexSansArabic',
    scaffoldBackgroundColor: AppColors.blackColor,
    primaryColor: AppColors.whiteColor,
    cardColor: const Color(0xFF1E1E1E),
    hintColor: AppColors.whiteColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.blackColor,
      brightness: Brightness.dark,
    ),
    dividerTheme: const DividerThemeData(color: Colors.transparent),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(color: Colors.white),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(const Color(0xFF1E1E1E)),
        foregroundColor: WidgetStateProperty.all(Colors.white),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xFF121212),
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontFamily: 'IBMPlexSansArabic',
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      titleSmall: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white70),
    ),
  );
}
