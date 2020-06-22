import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

class Themed {
  // static ThemeData primary = ThemeData(
  //   fontFamily: ThemedFonts.primary().fontFamily,
  // accentColor: ThemedColors.red,
  // splashFactory: InkRipple.splashFactory,
  // );

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    accentColor: ThemedColors.red,
    splashFactory: InkRipple.splashFactory,
    primaryColor: ThemedColors.primary,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      subtitle1: TextStyle(
        fontFamily: ThemedFonts.primary().fontFamily,
        color: Colors.black,
      ),
      subtitle2: TextStyle(
        fontFamily: ThemedFonts.primary().fontFamily,
        color: Colors.black,
      ),
      headline6: TextStyle(
        fontFamily: ThemedFonts.primary().fontFamily,
        color: Colors.black,
      ),
    ),
    dividerColor: Colors.grey[300],
  );

  static ThemeData dark = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    accentColor: Colors.tealAccent,
    splashFactory: InkRipple.splashFactory,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      subtitle1: TextStyle(
        fontFamily: ThemedFonts.primary().fontFamily,
        color: Colors.white,
      ),
      subtitle2: TextStyle(
        fontFamily: ThemedFonts.primary().fontFamily,
        color: Colors.white,
      ),
    ),
    dividerColor: Colors.grey[900],
  );
}
