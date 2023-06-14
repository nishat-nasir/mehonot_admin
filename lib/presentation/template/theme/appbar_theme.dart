import '../template.dart';

AppBarTheme appBarLightTheme = AppBarTheme(
  elevation: 0,
  iconTheme: const IconThemeData(color: PrsmColorsLight.textColor),
  titleTextStyle: ThemeTextBold.k18.copyWith(
      color: PrsmColorsLight.textColor),
  color: PrsmColorsLight.appBarColor,
);

AppBarTheme appBarDarkTheme = AppBarTheme(
  elevation: 0,
  iconTheme: const IconThemeData(color: PrsmColorsDark.textColor),
  titleTextStyle: ThemeTextBold.k18.copyWith(color: PrsmColorsDark.textColor),
  color: PrsmColorsDark.appBarColor,
);
