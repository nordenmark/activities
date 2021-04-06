import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  // Colors based on this scheme: https://coolors.co/d3dbeb-a0a4b8-7293a0-0e1f3a-4e3d42-49111c
  static const Color lavender = Color.fromRGBO(211, 219, 235, 1);
  static const Color manatee = Color.fromRGBO(160, 164, 184, 1);
  static const Color lightSlateGray = Color.fromRGBO(114, 147, 160, 1);
  static const Color oxfordBlue = Color.fromRGBO(14, 31, 58, 1);
  static const Color oldBurgundy = Color.fromRGBO(78, 61, 66, 1);
  static const Color darkSienna = Color.fromRGBO(73, 17, 28, 1);
  static const Color burntSienna = Color.fromRGBO(221, 110, 66, 1);
  static const Color black = Color.fromRGBO(0, 0, 0, 1);
  static const Color darkGray = Color.fromRGBO(40, 40, 40, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);

  // App colors
  static Color appBackgroundColor = lavender.withAlpha(255);
  static const Color overlayBgColor = Colors.white;
  static const Color appPrimaryColor = oxfordBlue;
  static const Color appAccentColor = burntSienna;
  static const Color appDiscreteColor = manatee;

  static Color shadowColor = darkGray.withOpacity(0.1);
  static Color borderColor = Colors.blueGrey[100];
  static Color subtleColor = manatee.withOpacity(0.4);

  // Text
  static Color textColor = appPrimaryColor;

  static TextStyle baseStyle = TextStyle(fontSize: 16, color: appPrimaryColor);
  static TextStyle discreteStyle =
      TextStyle(fontSize: 16, color: appDiscreteColor);

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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Styles.appPrimaryColor,
        ),
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
