import 'package:expense_tracker/data/hive_database.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/basket.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({
    super.key,
  });

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> _registeredExpenses = [];
  final List<Expense> _basket = [];

  //Show saved expenses from box in InitState below
  final db = HiveDataBase();
  void prepareData() {
    if (db.readData().isNotEmpty) {
      _registeredExpenses = db.readData();
    }
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.insert(0, expense);
    });
    db.saveData(_registeredExpenses);
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
      _addToBasket(expense);
    });
    db.deleteData(expense);
    db.saveData(_registeredExpenses);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Expense «${expense.title}» removed'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
              _basket.remove(expense);
            });
            db.saveData(_registeredExpenses);
          },
        ),
      ),
    );
  }

  void _openBasket() {
    ScaffoldMessenger.of(context).clearSnackBars();
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Basket(
        onAddBasket: _addToBasket,
        basketList: _basket,
        onRemoveExpense: _removeFromBasket,
      ),
    );
  }

  void _addToBasket(Expense expense) {
    setState(() {
      _basket.add(expense);
    });
  }

  void _removeFromBasket(Expense expense) {
    setState(() {
      _basket.remove(expense);
      _registeredExpenses.add(expense);
    });
  }

  @override
  void initState() {
    super.initState();
    prepareData();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'No expenses found',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'tap + to add',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses List'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: _openBasket,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registeredExpenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
