import '../template.dart';

AppBarTheme appBarLightTheme = AppBarTheme(
  elevation: 0,
  iconTheme: const IconThemeData(color: MehonotColorsLight.textColor),
  titleTextStyle: ThemeTextBold.k18.copyWith(color: MehonotColorsLight.textColor),
  color: MehonotColorsLight.appBarColor,
);

AppBarTheme appBarDarkTheme = AppBarTheme(
  elevation: 0,
  iconTheme: const IconThemeData(color: MehonotColorsDark.textColor),
  titleTextStyle: ThemeTextBold.k18.copyWith(color: MehonotColorsDark.textColor),
  color: MehonotColorsDark.appBarColor,
);
