import 'package:flutter/material.dart';
import 'package:mehonot_admin/presentation/template/theme/theme_color.dart';
import 'appbar_theme.dart';

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    canvasColor: PrsmColorsLight.canvasColor,
    primaryColor: PrsmColorsLight.primaryColor,
    appBarTheme: appBarLightTheme,
    fontFamily: 'PoppinsRegular',
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: PrsmColorsLight.primaryColor),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1)));

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: PrsmColorsDark.primaryColor,
  canvasColor: PrsmColorsDark.canvasColor,
  appBarTheme: appBarDarkTheme,
  fontFamily: 'PoppinsRegular',
  inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1)),
);
