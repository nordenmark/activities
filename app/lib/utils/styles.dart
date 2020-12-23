import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  // Colors based on this scheme: https://coolors.co/d3dbeb-a0a4b8-7293a0-0e1f3a-4e3d42-49111c
  static Color lavender = Color.fromRGBO(211, 219, 235, 1);
  static Color manatee = Color.fromRGBO(160, 164, 184, 1);
  static Color lightSlateGray = Color.fromRGBO(114, 147, 160, 1);
  static Color oxfordBlue = Color.fromRGBO(14, 31, 58, 1);
  static Color oldBurgundy = Color.fromRGBO(78, 61, 66, 1);
  static Color darkSienna = Color.fromRGBO(73, 17, 28, 1);
  static Color burntSienna = Color.fromRGBO(221, 110, 66, 1);
  static Color black = Color.fromRGBO(0, 0, 0, 1);
  static Color darkGray = Color.fromRGBO(40, 40, 40, 1);
  static Color white = Color.fromRGBO(255, 255, 255, 1);

  // App colors
  static Color appBackgroundColor = lavender.withAlpha(255);
  static Color overlayBgColor = Colors.white;
  static Color appPrimaryColor = oxfordBlue;
  static Color appAccentColor = burntSienna;
  static Color appDiscreteColor = manatee;
  static Color shadowColor = darkGray.withOpacity(0.1);
  static Color borderColor = Colors.blueGrey[100];

  // Text
  static Color textColor = appPrimaryColor;

  static ThemeData themeData(context) {
    final textTheme = Theme.of(context).textTheme;

    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Styles.appBackgroundColor,
      primaryColor: Styles.appPrimaryColor,
      accentColor: Styles.appAccentColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            buttonColor: Styles.appPrimaryColor,
            splashColor: Styles.appDiscreteColor,
            textTheme: ButtonTextTheme.primary,
          ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(primary: Styles.appPrimaryColor)),
      textTheme: GoogleFonts.openSansTextTheme(textTheme).apply(
        bodyColor: Styles.textColor,
      ),
      appBarTheme: AppBarTheme(
          color: Styles.appPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                bodyColor: Styles.white,
              ),
          elevation: 1.0,
          iconTheme: IconThemeData(color: Styles.white)),
    );
  }
}
