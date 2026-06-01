import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/expense_entity.dart';
import '../cubit/expense_cubit.dart';
import '../cubit/expense_state.dart';

/// Add a new expense. Calls `createExpense()` on the cubit and pops
/// with `true` so the list screen reloads.
class AddExpenseScreen extends StatefulWidget {
  final ExpenseEntity? existing;
  const AddExpenseScreen({super.key, this.existing});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _description;
  late final TextEditingController _amount;
  late final TextEditingController _vendor;
  late final TextEditingController _reference;
  late final TextEditingController _notes;
  late ExpenseCategory _category;
  late ExpensePaymentMethod _method;
  late DateTime _date;

  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _description = TextEditingController(text: e?.description ?? '');
    _amount = TextEditingController(
      text: e == null ? '' : (e.amountMinor / 100).toStringAsFixed(2),
    );
    _vendor = TextEditingController(text: e?.vendor ?? '');
    _reference = TextEditingController(text: e?.reference ?? '');
    _notes = TextEditingController(text: e?.notes ?? '');
    _category = e?.category ?? ExpenseCategory.office;
    _method = e?.paymentMethod ?? ExpensePaymentMethod.cash;
    _date = e?.expenseDate ?? DateTime.now();
  }

  @override
  void dispose() {
    _description.dispose();
    _amount.dispose();
    _vendor.dispose();
    _reference.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final amountMajor = double.parse(_amount.text.trim());
    final amountMinor = (amountMajor * 100).round();
    final cubit = context.read<ExpenseCubit>();
    if (isEdit) {
      await cubit.updateExpense(
        expenseId: widget.existing!.id,
        description: _description.text.trim(),
        amountMinor: amountMinor,
        category: _category,
        paymentMethod: _method,
        expenseDate: DateFormat('yyyy-MM-dd').format(_date),
        vendor: _vendor.text.trim(),
        reference: _reference.text.trim(),
        notes: _notes.text.trim(),
      );
    } else {
      await cubit.createExpense(
        description: _description.text.trim(),
        amountMinor: amountMinor,
        category: _category,
        paymentMethod: _method,
        expenseDate: DateFormat('yyyy-MM-dd').format(_date),
        vendor: _vendor.text.trim(),
        reference: _reference.text.trim(),
        notes: _notes.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseCubit, ExpenseState>(
      listener: (context, state) {
        if (state is ExpenseCreated || state is ExpenseUpdated) {
          Get.back(result: true);
          Get.snackbar(
            'Saved',
            isEdit ? 'Expense updated' : 'Expense recorded',
            backgroundColor: const Color(0xFF10B981),
            colorText: Colors.white,
          );
        } else if (state is ExpenseError) {
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
            isEdit ? 'Edit Expense' : 'New Expense',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(20.w),
              children: [
                _input(_description, 'Description',
                    validator: _required),
                SizedBox(height: 12.h),
                _input(
                  _amount,
                  'Amount (₦, major units)',
                  keyboard: TextInputType.numberWithOptions(decimal: true),
                  formatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  validator: _amountValidator,
                ),
                SizedBox(height: 12.h),
                _dropdown<ExpenseCategory>(
                  label: 'Category',
                  value: _category,
                  items: ExpenseCategory.values
                      .map((c) => DropdownMenuItem(
                            value: c,
                            child: Text(c.label,
                                style: const TextStyle(color: Colors.white)),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => _category = v!),
                ),
                SizedBox(height: 12.h),
                _dropdown<ExpensePaymentMethod>(
                  label: 'Payment method',
                  value: _method,
                  items: ExpensePaymentMethod.values
                      .map((m) => DropdownMenuItem(
                            value: m,
                            child: Text(m.label,
                                style: const TextStyle(color: Colors.white)),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => _method = v!),
                ),
                SizedBox(height: 12.h),
                _datePicker(),
                SizedBox(height: 12.h),
                _input(_vendor, 'Vendor (optional)'),
                SizedBox(height: 12.h),
                _input(_reference, 'Reference / receipt # (optional)'),
                SizedBox(height: 12.h),
                _input(_notes, 'Notes (optional)', maxLines: 3),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    isEdit ? 'Save changes' : 'Record expense',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Required' : null;
  String? _amountValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    final n = double.tryParse(v.trim());
    if (n == null || n <= 0) return 'Enter a positive amount';
    return null;
  }

  Widget _input(
    TextEditingController c,
    String label, {
    TextInputType? keyboard,
    int maxLines = 1,
    List<TextInputFormatter>? formatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: c,
      keyboardType: keyboard,
      maxLines: maxLines,
      inputFormatters: formatters,
      validator: validator,
      style: GoogleFonts.inter(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _dropdown<T>({
    required String label,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF1F1F1F),
          iconEnabledColor: Colors.white,
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _datePicker() {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _date,
          firstDate: DateTime(2000),
          lastDate: DateTime.now().add(const Duration(days: 1)),
        );
        if (picked != null) setState(() => _date = picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Expense date',
          labelStyle: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
          filled: true,
          fillColor: const Color(0xFF1F1F1F),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          suffixIcon: const Icon(Icons.calendar_today, color: Colors.white70),
        ),
        child: Text(
          DateFormat('yMMMd').format(_date),
          style: GoogleFonts.inter(color: Colors.white),
        ),
      ),
    );
  }
}
