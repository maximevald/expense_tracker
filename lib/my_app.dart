import 'package:expense_tracker/entity/app_themes.dart';
import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //Delete
      themeMode: ThemeMode.light,
      //
      title: 'Flutter Demo',
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.commonTheme,
      home: const Expenses(),
    );
  }
}
