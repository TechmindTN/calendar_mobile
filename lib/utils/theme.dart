import 'package:flutter/material.dart';

class ThemeClass {
  Color outlineColor = const Color.fromARGB(255, 29, 41, 59);
  Color primaryColor = const Color.fromARGB(255, 56, 77, 109);
  Color secondaryColor = const Color.fromARGB(255, 125, 145, 175);
  Color backgroundColor = 
  const Color.fromARGB(255, 187, 192, 200);
  
  
  static ThemeData lightTheme = ThemeData(
     scrollbarTheme: ScrollbarThemeData(
      interactive: true,
      trackVisibility: MaterialStateProperty.all<bool>(true),
          thumbVisibility: MaterialStateProperty.all<bool>(true),
        ),
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light().copyWith(
        primary: _themeClass.primaryColor,
        secondary: _themeClass.secondaryColor,
        background: _themeClass.backgroundColor,
        outline: _themeClass.outlineColor),
  );
}

ThemeClass _themeClass = ThemeClass();
