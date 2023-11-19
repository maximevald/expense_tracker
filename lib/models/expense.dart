import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final DateFormat formatter = DateFormat('dd/MM/yyyy');
// final formatter = DateFormat.yMd();

enum Category {
  food,
  transport,
  work,
  leisure,
  water,
  rent,
  gifts,
}

const expenseIcon = {
  Category.work: Icons.work,
  Category.leisure: Icons.movie,
  Category.food: Icons.lunch_dining,
  Category.transport: Icons.directions_bus_filled,
  Category.water: Icons.water_drop,
  Category.rent: Icons.house,
  Category.gifts: Icons.card_giftcard,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}

class AllExpensesAmount {
  AllExpensesAmount({required this.expenses});
  final List<Expense> expenses;

  double get allAmount {
    double totalAmount = 0;

    for (final expense in expenses) {
      totalAmount += expense.amount;
    }

    return totalAmount;
  }
}
