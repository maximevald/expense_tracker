import 'package:expense_tracker/models/expense.dart';
import 'package:hive/hive.dart';

class HiveDataBase {
  //reference our box
  final _myBox = Hive.box("expense_database");

  // void remove() {
  //   _myBox.deleteFromDisk();
  // }

  //write data
  void saveData(List<Expense> allExpense) {
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.title,
        expense.amount,
        expense.category.name,
        expense.date,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }
    _myBox.put("ALL_EXPENSES", allExpensesFormatted);
  }

  //read data
  List<Expense> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<Expense> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      // String id = savedExpenses[i][0];
      String title = savedExpenses[i][0];
      double amount = savedExpenses[i][1];
      String category = savedExpenses[i][2];
      DateTime dateTime = savedExpenses[i][3];

      Expense expense = Expense(
        title: title,
        amount: amount,
        date: dateTime,
        category: Category.values.byName(category),
      );

      allExpenses.add(expense);
    }
    return allExpenses;
  }
}
