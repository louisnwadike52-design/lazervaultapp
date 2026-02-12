import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_state.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/expense_category_helpers.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;

/// Create/Edit Budget Screen
class CreateBudgetScreen extends StatefulWidget {
  const CreateBudgetScreen({super.key});

  @override
  State<CreateBudgetScreen> createState() => _CreateBudgetScreenState();
}

class _CreateBudgetScreenState extends State<CreateBudgetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  pb.ExpenseCategory? _selectedCategory;
  pb.BudgetPeriod _selectedPeriod = pb.BudgetPeriod.BUDGET_PERIOD_MONTHLY;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _enableAlerts = true;
  double _alertThreshold = 80.0;

  bool get _isEditMode {
    final args = Get.arguments as Map<String, dynamic>?;
    return args?.containsKey('budget') ?? false;
  }

  pb.BudgetMessage? get _editingBudget {
    final args = Get.arguments as Map<String, dynamic>?;
    return args?['budget'] as pb.BudgetMessage?;
  }

  @override
  void initState() {
    super.initState();

    // Check if editing
    if (_isEditMode && _editingBudget != null) {
      _nameController.text = _editingBudget!.name;
      _amountController.text = _editingBudget!.amount.toString();
      _selectedCategory = _editingBudget!.category;
      _selectedPeriod = _editingBudget!.period;
      _enableAlerts = _editingBudget!.enableAlerts;
      _alertThreshold = _editingBudget!.alertThreshold;
      _startDate = _editingBudget!.startDate.toDateTime();
      _endDate = _editingBudget!.endDate.toDateTime();
    } else {
      // Set default dates based on period
      _setDefaultDates();
    }
  }

  void _setDefaultDates() {
    final now = DateTime.now();
    switch (_selectedPeriod) {
      case pb.BudgetPeriod.BUDGET_PERIOD_DAILY:
        _startDate = now;
        _endDate = now;
        break;
      case pb.BudgetPeriod.BUDGET_PERIOD_WEEKLY:
        _startDate = now.subtract(Duration(days: now.weekday - 1));
        _endDate = _startDate!.add(const Duration(days: 6));
        break;
      case pb.BudgetPeriod.BUDGET_PERIOD_MONTHLY:
        _startDate = DateTime(now.year, now.month, 1);
        _endDate = DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));
        break;
      case pb.BudgetPeriod.BUDGET_PERIOD_QUARTERLY:
        final quarter = ((now.month - 1) ~/ 3) + 1;
        _startDate = DateTime(now.year, (quarter - 1) * 3 + 1, 1);
        _endDate = DateTime(now.year, quarter * 3 + 1, 1).subtract(const Duration(days: 1));
        break;
      case pb.BudgetPeriod.BUDGET_PERIOD_YEARLY:
        _startDate = DateTime(now.year, 1, 1);
        _endDate = DateTime(now.year, 12, 31);
        break;
      default:
        _startDate = DateTime(now.year, now.month, 1);
        _endDate = DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _saveBudget() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      Get.snackbar(
        'Error',
        'Please enter a valid amount',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
      );
      return;
    }

    if (_selectedCategory == null) {
      Get.snackbar(
        'Error',
        'Please select a category',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
      );
      return;
    }

    if (_isEditMode && _editingBudget != null) {
      context.read<BudgetCubit>().updateBudget(
        budgetId: _editingBudget!.id,
        name: _nameController.text.isNotEmpty ? _nameController.text : null,
        amount: amount > 0 ? amount : null,
        period: _selectedPeriod,
        startDate: _startDate,
        endDate: _endDate,
        enableAlerts: _enableAlerts,
        alertThreshold: _alertThreshold,
      );
    } else {
      context.read<BudgetCubit>().createBudget(
        name: _nameController.text,
        amount: amount,
        currency: 'NGN',
        category: _selectedCategory!,
        period: _selectedPeriod,
        startDate: _startDate,
        endDate: _endDate,
        enableAlerts: _enableAlerts,
        alertThreshold: _alertThreshold,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BudgetCubit, BudgetState>(
      listener: (context, state) {
        if (state is BudgetCreated || state is BudgetUpdated) {
          Get.snackbar(
            'Success',
            state is BudgetCreated ? state.message : (state as BudgetUpdated).message,
            backgroundColor: const Color(0xFF10B981),
            colorText: Colors.white,
          );
          Get.back();
        } else if (state is BudgetError) {
          Get.snackbar(
            'Error',
            state.message,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            _isEditMode ? 'Edit Budget' : 'Create Budget',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                // Budget Name
                _buildSectionTitle('Budget Name'),
                _buildNameField(),
                SizedBox(height: 24.h),

                // Amount
                _buildSectionTitle('Amount'),
                _buildAmountField(),
                SizedBox(height: 24.h),

                // Category
                _buildSectionTitle('Category'),
                _buildCategorySelector(),
                SizedBox(height: 24.h),

                // Period
                _buildSectionTitle('Period'),
                _buildPeriodSelector(),
                SizedBox(height: 24.h),

                // Date Range (for custom period)
                if (_selectedPeriod == pb.BudgetPeriod.BUDGET_PERIOD_CUSTOM) ...[
                  _buildSectionTitle('Date Range'),
                  _buildDateRangeSelector(),
                  SizedBox(height: 24.h),
                ],

                // Alerts
                _buildSectionTitle('Alerts'),
                _buildAlertSettings(),
                SizedBox(height: 32.h),

                // Save Button
                _buildSaveButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'e.g., Groceries',
        hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF3B82F6)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFEF4444)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Budget name is required';
        }
        return null;
      },
    );
  }

  Widget _buildAmountField() {
    return TextFormField(
      controller: _amountController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: '0.00',
        hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
        prefixText: '₦ ',
        prefixStyle: const TextStyle(color: Colors.white, fontSize: 18),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF3B82F6)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Amount is required';
        }
        final amount = double.tryParse(value);
        if (amount == null || amount <= 0) {
          return 'Please enter a valid amount';
        }
        return null;
      },
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<pb.ExpenseCategory>(
          value: _selectedCategory,
          isExpanded: true,
          dropdownColor: const Color(0xFF1F1F1F),
          style: const TextStyle(color: Colors.white, fontSize: 16),
          iconEnabledColor: const Color(0xFF9CA3AF),
          hint: const Text(
            'Select Category',
            style: TextStyle(color: Color(0xFF9CA3AF)),
          ),
          items: ExpenseCategoryHelpers.getAllCategories().map((category) {
            return DropdownMenuItem<pb.ExpenseCategory>(
              value: category,
              child: Row(
                children: [
                  Icon(
                    ExpenseCategoryHelpers.getCategoryIcon(category),
                    color: ExpenseCategoryHelpers.getCategoryColor(category),
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    ExpenseCategoryHelpers.getCategoryDisplayName(category),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedCategory = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Wrap(
      spacing: 8.w,
      children: pb.BudgetPeriod.values
          .where((p) => p != pb.BudgetPeriod.BUDGET_PERIOD_UNSPECIFIED)
          .map((period) {
        final isSelected = _selectedPeriod == period;
        return ChoiceChip(
          label: Text(
            ExpenseCategoryHelpers.getPeriodDisplayName(period),
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
              fontSize: 14,
            ),
          ),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedPeriod = period;
              if (period != pb.BudgetPeriod.BUDGET_PERIOD_CUSTOM) {
                _setDefaultDates();
              }
            });
          },
          selectedColor: const Color(0xFF3B82F6),
          backgroundColor: const Color(0xFF1F1F1F),
          side: BorderSide(
            color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF2D2D2D),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDateRangeSelector() {
    return Row(
      children: [
        Expanded(
          child: _buildDateField(
            label: 'Start Date',
            date: _startDate,
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _startDate ?? DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (picked != null) {
                setState(() => _startDate = picked);
              }
            },
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _buildDateField(
            label: 'End Date',
            date: _endDate,
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _endDate ?? DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (picked != null) {
                setState(() => _endDate = picked);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Text(
              date != null ? DateFormat('yyyy-MM-dd').format(date) : 'Select',
              style: TextStyle(
                color: date != null ? Colors.white : const Color(0xFF9CA3AF),
                fontSize: 16,
              ),
            ),
            SizedBox(width: 8.w),
            const Icon(
              Icons.calendar_today,
              color: Color(0xFF9CA3AF),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertSettings() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile.adaptive(
            title: const Text(
              'Enable Alerts',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: const Text(
              'Get notified when you approach your budget limit',
              style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
            ),
            value: _enableAlerts,
            onChanged: (value) {
              setState(() => _enableAlerts = value);
            },
            activeColor: const Color(0xFF3B82F6),
          ),
          if (_enableAlerts) ...[
            SizedBox(height: 16.h),
            Text(
              'Alert Threshold: ${_alertThreshold.toInt()}%',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            SizedBox(height: 8.h),
            Slider(
              value: _alertThreshold,
              min: 50,
              max: 100,
              divisions: 10,
              activeColor: const Color(0xFF3B82F6),
              onChanged: (value) {
                setState(() => _alertThreshold = value);
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    final state = context.watch<BudgetCubit>();
    final isLoading = state is BudgetLoading;

    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : _saveBudget,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B82F6),
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                _isEditMode ? 'Update Budget' : 'Create Budget',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
