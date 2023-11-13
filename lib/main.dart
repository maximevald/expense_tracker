import 'package:expense_tracker/my_app.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //Initialize hive
  await Hive.initFlutter();

  //Open hive box
  await Hive.openBox("expense_database");

  // await Hive.box("expense_database").clear();

  runApp(const MyApp());
}
