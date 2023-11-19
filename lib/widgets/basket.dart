import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:flutter/material.dart';

class Basket extends StatefulWidget {
  const Basket({
    required this.onAddBasket,
    required this.basketList,
    required this.onRemoveExpense,
    super.key,
  });
  final List<Expense> basketList;
  final void Function(Expense expense) onAddBasket;
  final void Function(Expense expense) onRemoveExpense;

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Expanded(
      child: Center(
        child: Text('Basket is empty'),
      ),
    );

    if (widget.basketList.isNotEmpty) {
      mainContent = Expanded(
        child: ExpensesList(
          expenses: widget.basketList,
          onRemoveExpense: widget.onRemoveExpense,
        ),
      );
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          children: [
            const Text('Removed'),
            mainContent,
          ],
        ),
      ),
    );
  }
}
