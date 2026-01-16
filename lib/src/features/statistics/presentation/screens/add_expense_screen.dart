import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/statistics.pb.dart';
import '../../cubit/statistics_cubit.dart';
import '../../cubit/statistics_state.dart';

/// Screen for adding a new expense
class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _merchantController = TextEditingController();
  final _notesController = TextEditingController();

  ExpenseCategory _selectedCategory = ExpenseCategory.EXPENSE_CATEGORY_FOOD_DINING;
  DateTime _transactionDate = DateTime.now();
  String _currency = 'USD';
  bool _isRecurring = false;

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _merchantController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: BlocListener<StatisticsCubit, StatisticsState>(
        listener: (context, state) {
          if (state is ExpenseCreated) {
            Navigator.pop(context);
          } else if (state is StatisticsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Amount field
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  prefixText: '\$',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  helperText: 'Enter the expense amount',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Category dropdown
              DropdownButtonFormField<ExpenseCategory>(
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: _getCategoryItems(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Description field
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  helperText: 'Brief description of the expense',
                ),
                maxLength: 200,
              ),
              const SizedBox(height: 16),

              // Merchant field
              TextFormField(
                controller: _merchantController,
                decoration: InputDecoration(
                  labelText: 'Merchant (Optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.store),
                ),
              ),
              const SizedBox(height: 16),

              // Transaction date
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today),
                title: const Text('Transaction Date'),
                subtitle: Text(_formatDate(_transactionDate)),
                onTap: _selectTransactionDate,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Theme.of(context).dividerColor),
                ),
              ),
              const SizedBox(height: 16),

              // Currency selector
              DropdownButtonFormField<String>(
                initialValue: _currency,
                decoration: InputDecoration(
                  labelText: 'Currency',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.attach_money),
                ),
                items: const [
                  DropdownMenuItem(value: 'USD', child: Text('USD')),
                  DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                  DropdownMenuItem(value: 'GBP', child: Text('GBP')),
                  DropdownMenuItem(value: 'JPY', child: Text('JPY')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _currency = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Recurring expense checkbox
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Recurring Expense'),
                subtitle: const Text('This expense repeats regularly'),
                value: _isRecurring,
                onChanged: (value) {
                  setState(() {
                    _isRecurring = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Notes field
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: 'Notes (Optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                maxLength: 500,
              ),
              const SizedBox(height: 24),

              // Submit button
              BlocBuilder<StatisticsCubit, StatisticsState>(
                builder: (context, state) {
                  final isLoading = state is ExpenseCreating;

                  return ElevatedButton(
                    onPressed: isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text(
                            'Add Expense',
                            style: TextStyle(fontSize: 16),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<ExpenseCategory>> _getCategoryItems() {
    final categories = {
      ExpenseCategory.EXPENSE_CATEGORY_FOOD_DINING: 'Food & Dining',
      ExpenseCategory.EXPENSE_CATEGORY_TRANSPORTATION: 'Transportation',
      ExpenseCategory.EXPENSE_CATEGORY_SHOPPING: 'Shopping',
      ExpenseCategory.EXPENSE_CATEGORY_ENTERTAINMENT: 'Entertainment',
      ExpenseCategory.EXPENSE_CATEGORY_BILLS_UTILITIES: 'Bills & Utilities',
      ExpenseCategory.EXPENSE_CATEGORY_HEALTHCARE: 'Healthcare',
      ExpenseCategory.EXPENSE_CATEGORY_EDUCATION: 'Education',
      ExpenseCategory.EXPENSE_CATEGORY_TRAVEL: 'Travel',
      ExpenseCategory.EXPENSE_CATEGORY_GROCERIES: 'Groceries',
      ExpenseCategory.EXPENSE_CATEGORY_RENT_MORTGAGE: 'Rent/Mortgage',
      ExpenseCategory.EXPENSE_CATEGORY_INSURANCE: 'Insurance',
      ExpenseCategory.EXPENSE_CATEGORY_INVESTMENTS: 'Investments',
      ExpenseCategory.EXPENSE_CATEGORY_GIFTS_DONATIONS: 'Gifts & Donations',
      ExpenseCategory.EXPENSE_CATEGORY_PERSONAL_CARE: 'Personal Care',
      ExpenseCategory.EXPENSE_CATEGORY_SUBSCRIPTIONS: 'Subscriptions',
      ExpenseCategory.EXPENSE_CATEGORY_OTHER: 'Other',
    };

    return categories.entries
        .map((entry) => DropdownMenuItem(
              value: entry.key,
              child: Text(entry.value),
            ))
        .toList();
  }

  Future<void> _selectTransactionDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _transactionDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        _transactionDate = date;
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);

      context.read<StatisticsCubit>().createExpense(
            amount: amount,
            currency: _currency,
            category: _selectedCategory,
            transactionDate: _transactionDate,
            description: _descriptionController.text.isNotEmpty
                ? _descriptionController.text
                : null,
            merchant: _merchantController.text.isNotEmpty
                ? _merchantController.text
                : null,
            notes: _notesController.text.isNotEmpty
                ? _notesController.text
                : null,
            isRecurring: _isRecurring,
          );
    }
  }
}
