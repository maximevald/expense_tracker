import 'package:expense_tracker/models/expense.dart';
import 'package:hive/hive.dart';

class HiveDataBase {
  //reference our box
  static late final Box<Map<dynamic, dynamic>> _myBox;

  static Future<void> remove() async {
    await Hive.deleteBoxFromDisk('expense_database');
  }

  //write data
  Future<void> saveData(List<Expense> allExpense) async {
    for (final expense in allExpense) {
      final expenseFormatted = {
        'id': expense.id,
        'title': expense.title,
        'amount': expense.amount,
        'category': expense.category.name,
        'date': expense.date,
      };
      await _myBox.put(expense.id, expenseFormatted);
      
    }
  }

  void deleteData(Expense expense) {
    _myBox.delete(expense.id);
  }

  //read data
  List<Expense> readData() {
    final savedExpenses = _myBox.values;
    final allExpenses = <Expense>[];

    for (final expenseJSON in savedExpenses) {
      final id = expenseJSON['id'];
      final title = expenseJSON['title'];
      final amount = expenseJSON['amount'];
      final category = expenseJSON['category'];
      final dateTime = expenseJSON['date'];

      final expense = Expense(
        id: id as String,
        title: title as String,
        amount: amount as double,
        date: dateTime as DateTime,
        category: Category.values.byName(category as String),
      );

      allExpenses.add(expense);
    }
    return allExpenses;
  }

  static Future<void> init() async {
    await Hive.openBox<Map<dynamic, dynamic>>('expense_database');
    _myBox = Hive.box<Map<dynamic, dynamic>>('expense_database');
  }
}
