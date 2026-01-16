import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/statistics.pb.dart';
import '../../cubit/statistics_cubit.dart';
import '../../cubit/statistics_state.dart';

/// Screen for creating a new budget
class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({super.key});

  @override
  State<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends State<AddBudgetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _alertThresholdController = TextEditingController(text: '80');

  BudgetPeriod _selectedPeriod = BudgetPeriod.BUDGET_PERIOD_MONTHLY;
  ExpenseCategory? _selectedCategory;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 30));
  String _currency = 'USD';

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _alertThresholdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Budget'),
      ),
      body: BlocListener<StatisticsCubit, StatisticsState>(
        listener: (context, state) {
          if (state is BudgetCreated) {
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
              // Budget name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Budget Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  helperText: 'e.g., "Monthly Groceries" or "Q1 Entertainment"',
                  prefixIcon: const Icon(Icons.label),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a budget name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Amount field
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Budget Amount',
                  prefixText: '\$',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  helperText: 'Maximum amount for this budget',
                  prefixIcon: const Icon(Icons.attach_money),
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

              // Currency selector
              DropdownButtonFormField<String>(
                initialValue: _currency,
                decoration: InputDecoration(
                  labelText: 'Currency',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.currency_exchange),
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

              // Budget period
              DropdownButtonFormField<BudgetPeriod>(
                initialValue: _selectedPeriod,
                decoration: InputDecoration(
                  labelText: 'Budget Period',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.calendar_view_month),
                ),
                items: _getPeriodItems(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedPeriod = value;
                      _updateEndDateBasedOnPeriod();
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Category dropdown (optional)
              DropdownButtonFormField<ExpenseCategory?>(
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Category (Optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  helperText: 'Leave empty for general budget',
                  prefixIcon: const Icon(Icons.category),
                ),
                items: _getCategoryItems(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Start date
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.date_range),
                title: const Text('Start Date'),
                subtitle: Text(_formatDate(_startDate)),
                onTap: () => _selectDate(isStartDate: true),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Theme.of(context).dividerColor),
                ),
              ),
              const SizedBox(height: 16),

              // End date
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.event),
                title: const Text('End Date'),
                subtitle: Text(_formatDate(_endDate)),
                onTap: () => _selectDate(isStartDate: false),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Theme.of(context).dividerColor),
                ),
              ),
              const SizedBox(height: 16),

              // Alert threshold
              TextFormField(
                controller: _alertThresholdController,
                decoration: InputDecoration(
                  labelText: 'Alert Threshold (%)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  helperText: 'Get notified when spending reaches this percentage',
                  suffixText: '%',
                  prefixIcon: const Icon(Icons.notifications_active),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final threshold = int.tryParse(value);
                    if (threshold == null || threshold < 1 || threshold > 100) {
                      return 'Please enter a value between 1 and 100';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description (Optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignLabelWithHint: true,
                  prefixIcon: const Icon(Icons.description),
                ),
                maxLines: 3,
                maxLength: 300,
              ),
              const SizedBox(height: 24),

              // Submit button
              BlocBuilder<StatisticsCubit, StatisticsState>(
                builder: (context, state) {
                  final isLoading = state is BudgetCreating;

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
                            'Create Budget',
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

  List<DropdownMenuItem<BudgetPeriod>> _getPeriodItems() {
    final periods = {
      BudgetPeriod.BUDGET_PERIOD_DAILY: 'Daily',
      BudgetPeriod.BUDGET_PERIOD_WEEKLY: 'Weekly',
      BudgetPeriod.BUDGET_PERIOD_MONTHLY: 'Monthly',
      BudgetPeriod.BUDGET_PERIOD_QUARTERLY: 'Quarterly',
      BudgetPeriod.BUDGET_PERIOD_YEARLY: 'Yearly',
      BudgetPeriod.BUDGET_PERIOD_CUSTOM: 'Custom',
    };

    return periods.entries
        .map((entry) => DropdownMenuItem(
              value: entry.key,
              child: Text(entry.value),
            ))
        .toList();
  }

  List<DropdownMenuItem<ExpenseCategory?>> _getCategoryItems() {
    final categories = {
      null: 'None (General Budget)',
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

  void _updateEndDateBasedOnPeriod() {
    final now = _startDate;
    switch (_selectedPeriod) {
      case BudgetPeriod.BUDGET_PERIOD_DAILY:
        _endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
        break;
      case BudgetPeriod.BUDGET_PERIOD_WEEKLY:
        _endDate = now.add(const Duration(days: 7));
        break;
      case BudgetPeriod.BUDGET_PERIOD_MONTHLY:
        _endDate = DateTime(now.year, now.month + 1, 0);
        break;
      case BudgetPeriod.BUDGET_PERIOD_QUARTERLY:
        _endDate = now.add(const Duration(days: 90));
        break;
      case BudgetPeriod.BUDGET_PERIOD_YEARLY:
        _endDate = DateTime(now.year + 1, now.month, 0);
        break;
      default:
        _endDate = now.add(const Duration(days: 30));
    }
  }

  Future<void> _selectDate({required bool isStartDate}) async {
    final date = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: isStartDate ? DateTime.now() : _startDate,
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );

    if (date != null) {
      setState(() {
        if (isStartDate) {
          _startDate = date;
          if (_endDate.isBefore(_startDate)) {
            _updateEndDateBasedOnPeriod();
          }
        } else {
          _endDate = date;
        }
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);
      final alertThreshold = _alertThresholdController.text.isNotEmpty
          ? double.parse(_alertThresholdController.text)
          : null;

      context.read<StatisticsCubit>().createBudget(
            name: _nameController.text,
            amount: amount,
            currency: _currency,
            period: _selectedPeriod,
            startDate: _startDate,
            endDate: _endDate,
            category: _selectedCategory,
            alertThreshold: alertThreshold,
            description: _descriptionController.text.isNotEmpty
                ? _descriptionController.text
                : null,
          );
    }
  }
}
