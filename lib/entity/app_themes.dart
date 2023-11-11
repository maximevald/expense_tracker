import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

class AppTheme {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    colorScheme: kDarkColorScheme,
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: kDarkColorScheme.onPrimaryContainer,
      foregroundColor: kDarkColorScheme.primaryContainer,
    ),
    iconTheme:
        const IconThemeData().copyWith(color: kDarkColorScheme.secondary),
    cardTheme: const CardTheme().copyWith(
      color: kDarkColorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kDarkColorScheme.primaryContainer,
        foregroundColor: kDarkColorScheme.onPrimaryContainer,
      ),
    ),
    textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
              fontWeight: FontWeight.normal,
              color: kDarkColorScheme.onSecondaryContainer,
              fontSize: 20),
          titleMedium: TextStyle(
              fontWeight: FontWeight.bold,
              color: kDarkColorScheme.onSecondaryContainer,
              fontSize: 18),
          labelLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: kDarkColorScheme.onSecondaryContainer,
              fontSize: 18),
        ),
  );

  static ThemeData commonTheme = ThemeData().copyWith(
    useMaterial3: true,
    colorScheme: kColorScheme,
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: kColorScheme.onPrimaryContainer,
      foregroundColor: kColorScheme.primaryContainer,
    ),
    cardTheme: const CardTheme().copyWith(
      color: kColorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kColorScheme.primaryContainer,
      ),
    ),
    textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
              fontWeight: FontWeight.normal,
              color: kColorScheme.onSecondaryContainer,
              fontSize: 20),
        ),
  );
}
