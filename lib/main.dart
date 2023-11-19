import 'package:expense_tracker/data/hive_database.dart';
import 'package:expense_tracker/my_app.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //Initialize hive
  await Hive.initFlutter();
  // await HiveDataBase.remove();
  //Open hive box
  await HiveDataBase.init();

  runApp(const MyApp());
}
