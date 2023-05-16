import 'package:flutter/material.dart';

import 'colors.dart';

class Themes {
  static ThemeData commonThemeData(BuildContext context) {
    return ThemeData(
      fontFamily: 'NotoSansJP',
      primaryColor: ColorsRes.primary,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      iconTheme: const IconThemeData(color: ColorsRes.contentLightTheme),
      colorScheme: const ColorScheme.light(
        primary: ColorsRes.primary,
        secondary: ColorsRes.secondary,
        error: ColorsRes.error,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: ColorsRes.contentLightTheme.withOpacity(0.7),
        unselectedItemColor: ColorsRes.contentLightTheme.withOpacity(0.32),
        selectedIconTheme: const IconThemeData(color: ColorsRes.primary),
        showUnselectedLabels: true,
      ),
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: ColorsRes.white),
    );
  }
}

extension BuildContextExtension on BuildContext {
  TextStyle get headline1 =>
      Theme.of(this).textTheme.headline1?.copyWith(
            fontSize: 62,
            color: Colors.black,
          ) ??
      const TextStyle();

  TextStyle get headline2 =>
      Theme.of(this).textTheme.headline2 ?? const TextStyle();

  TextStyle get headline3 =>
      Theme.of(this).textTheme.headline3 ?? const TextStyle();

  TextStyle get headline4 =>
      Theme.of(this).textTheme.headline4 ?? const TextStyle();

  TextStyle get headline5 =>
      Theme.of(this).textTheme.headline5 ?? const TextStyle();

  TextStyle get headline6 =>
      Theme.of(this).textTheme.headline6 ?? const TextStyle();

  TextStyle get button => Theme.of(this).textTheme.button ?? const TextStyle();

  TextStyle get subtitle1 =>
      Theme.of(this).textTheme.subtitle1 ?? const TextStyle();

  TextStyle get subtitle2 =>
      Theme.of(this).textTheme.subtitle2 ?? const TextStyle();

  TextStyle get overLine =>
      Theme.of(this).textTheme.overline ?? const TextStyle();

  TextStyle get bodyText1 =>
      Theme.of(this).textTheme.bodyText1 ?? const TextStyle();
}
