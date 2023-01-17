import 'package:flutter/material.dart';

import './color_palettes.dart';

ThemeData appTheme = ThemeData(
  primaryColor: ColorPalettes.primary,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  dividerColor: ColorPalettes.smokeGray,
  dividerTheme: const DividerThemeData(
    space: 1.0,
    thickness: 1.0,
  ),
  unselectedWidgetColor: ColorPalettes.gray100,
  colorScheme: const ColorScheme.light(primary: ColorPalettes.primary),
  fontFamily: 'Inter',
  textTheme: ThemeData.light().textTheme.copyWith(
        headline1: const TextStyle(
          fontSize: 28,
          height: 32 / 28,
          fontWeight: FontWeight.bold,
          color: ColorPalettes.darkGray,
          letterSpacing: 0,
        ),
        headline2: const TextStyle(
          fontSize: 20,
          height: 24 / 20,
          color: ColorPalettes.darkGray,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
        ),
        headline3: const TextStyle(
          fontSize: 16,
          height: 24 / 16,
          color: ColorPalettes.darkGray,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
        ),
        bodyText1: const TextStyle(
          fontSize: 16,
          height: 24 / 16,
          fontWeight: FontWeight.w400,
          color: ColorPalettes.darkGray,
          letterSpacing: 0,
        ),
        bodyText2: const TextStyle(
          fontSize: 16,
          height: 24 / 16,
          fontWeight: FontWeight.w500,
          color: ColorPalettes.darkGray,
          letterSpacing: 0,
        ),
        caption: const TextStyle(
          fontSize: 14,
          height: 20 / 14,
          fontWeight: FontWeight.w400,
          color: ColorPalettes.darkGray,
          letterSpacing: 0,
        ),
        overline: const TextStyle(
          fontSize: 12,
          height: 16 / 12,
          fontWeight: FontWeight.w400,
          color: ColorPalettes.darkGray,
          letterSpacing: 0,
        ),
      ),
  textSelectionTheme:
      const TextSelectionThemeData(cursorColor: ColorPalettes.cursorPrimary),
  scaffoldBackgroundColor: Colors.white,
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    ),
    side: const BorderSide(color: ColorPalettes.blue400),
  ),
);
