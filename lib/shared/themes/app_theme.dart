import 'package:flutter/material.dart';

import '../../core/resources/colors.dart';

class AppThemes {
  static final whiteTheme = ThemeData(
    dropdownMenuTheme:
        const DropdownMenuThemeData(textStyle: TextStyle(color: Colors.black)),
    hintColor: AppColors.blackColor,
    dividerTheme: const DividerThemeData(color: Colors.transparent),
    fontFamily: 'IBMPlexSansArabic',
    primaryColor: AppColors.blackColor,
    scaffoldBackgroundColor: Colors.white,
    cardColor: AppColors.whiteColor,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.resolveWith((states) => Colors.white)),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: AppColors.blackColor,
        fontFamily: 'IBMPlexSansArabic',
      ),
      titleMedium: TextStyle(
        color: AppColors.blackColor,
        fontFamily: 'IBMPlexSansArabic',
      ),
      titleSmall: TextStyle(
        color: AppColors.blackColor,
        fontFamily: 'IBMPlexSansArabic',
      ),
      bodyLarge: TextStyle(
        color: AppColors.blackColor,
        fontFamily: 'IBMPlexSansArabic',
      ),
      bodyMedium: TextStyle(
        color: AppColors.blackColor,
        fontFamily: 'IBMPlexSansArabic',
      ),
      bodySmall: TextStyle(
        color: AppColors.blackColor,
        fontFamily: 'IBMPlexSansArabic',
      ),
    ),
    splashColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      // iconTheme: IconThemeData(size: 13.sp),
      titleSpacing: 0,

      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textColor,
        fontFamily: 'IBMPlexSansArabic',
      ),
      elevation: 0,
      backgroundColor: AppColors.whiteColor,
    ),
    secondaryHeaderColor: AppColors.whiteColor,
    highlightColor: Colors.transparent,
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: AppColors.blackColor),
    hoverColor: Colors.transparent,
  );
}
