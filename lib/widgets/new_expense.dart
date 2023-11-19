import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({required this.onAddExpense, super.key});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _formKey = GlobalKey<FormState>();
  String _enteredTitle = '';
  String _enteredAmount = '';
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  Future<void> _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _selectedDate ??= DateTime.now();

      widget.onAddExpense(
        Expense(
          title: _enteredTitle,
          amount: double.tryParse(_enteredAmount)!,
          date: _selectedDate!,
          category: _selectedCategory,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: _enteredTitle,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.text,
              maxLength: 60,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length <= 1 ||
                    value.trim().length > 50) {
                  return 'Incorrect title';
                }
                return null;
              },
              onSaved: (value) {
                _enteredTitle = value!;
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: _enteredAmount,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text('Amount'),
                      suffixText: 'BYN',
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          double.tryParse(value) == null ||
                          double.tryParse(value)! <= 0) {
                        return 'Incorrect amount';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredAmount = value!;
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: _presentDatePicker,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'Select a date'
                              : formatter.format(_selectedDate!),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(Icons.calendar_month),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Row(
                              children: [
                                Text(
                                  category.name.toUpperCase(),
                                ),
                                const SizedBox(width: 10),
                                Icon(expenseIcon[category]),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text(
                          'Save',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
