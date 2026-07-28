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
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/widgets/entity_create_sheet.dart';
import 'package:lazervault/src/features/inventory/domain/entities/supplier_entity.dart';
import 'package:lazervault/src/features/inventory/domain/repositories/inventory_enhanced_repository.dart';

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

  // Supplier interlink — pick the vendor from the supplier list instead of
  // typing it (still allows a custom/one-off vendor). Stores the name in _vendor
  // AND the supplier FK id in _supplierId (empty for a custom/ad-hoc vendor) so
  // the expense keeps referential integrity, not just a name string.
  List<SupplierEntity> _suppliers = const [];
  String _supplierId = '';
  bool _loadingSuppliers = true;

  bool get isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    _loadSuppliers();
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

  Future<void> _loadSuppliers() async {
    try {
      final suppliers =
          await serviceLocator<InventoryEnhancedRepository>().listSuppliers();
      if (!mounted) return;
      setState(() {
        _suppliers = suppliers;
        _loadingSuppliers = false;
      });
    } catch (_) {
      if (mounted) setState(() => _loadingSuppliers = false);
    }
  }

  void _openSupplierPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (ctx, scrollCtrl) {
            return Column(
              children: [
                SizedBox(height: 12.h),
                Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                        color: const Color(0xFF2D2D2D),
                        borderRadius: BorderRadius.circular(2.r))),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Select supplier',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: ListView(
                    controller: scrollCtrl,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    children: [
                      // Create a real supplier inline, then set it as the vendor.
                      _supplierRow(
                        icon: Icons.add_business_rounded,
                        title: 'Add a supplier',
                        subtitle: 'Create a saved supplier and select it',
                        onTap: () {
                          Navigator.of(ctx).pop();
                          _createAndSelectSupplier();
                        },
                      ),
                      _supplierRow(
                        icon: Icons.edit_note_rounded,
                        title: 'Custom vendor…',
                        subtitle: 'Type a one-off vendor name',
                        onTap: () {
                          Navigator.of(ctx).pop();
                          _promptCustomVendor();
                        },
                      ),
                      if (_suppliers.isEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Center(
                            child: Text('No suppliers yet',
                                style: GoogleFonts.inter(
                                    color: const Color(0xFF9CA3AF),
                                    fontSize: 13.sp)),
                          ),
                        )
                      else
                        ..._suppliers.map((s) => _supplierRow(
                              icon: Icons.local_shipping_rounded,
                              title: s.name,
                              subtitle: s.contactName.isNotEmpty
                                  ? s.contactName
                                  : 'Supplier',
                              selected: _vendor.text.trim() == s.name,
                              onTap: () {
                                setState(() {
                                  _vendor.text = s.name;
                                  _supplierId = s.id;
                                });
                                Navigator.of(ctx).pop();
                              },
                            )),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Run the full add-supplier flow in a bottom sheet; on create, prepend it to
  /// the supplier list and set it as this expense's vendor.
  Future<void> _createAndSelectSupplier() async {
    final created = await showCreateSupplierSheet(context);
    if (created == null || !mounted) return;
    setState(() {
      _suppliers = [created, ..._suppliers];
      _vendor.text = created.name;
      _supplierId = created.id;
    });
  }

  void _promptCustomVendor() {
    final ctrl = TextEditingController(text: _vendor.text);
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text('Vendor name',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp)),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          style: GoogleFonts.inter(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'e.g. Corner shop',
            hintStyle: GoogleFonts.inter(color: const Color(0xFF6B7280)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel',
                style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))),
          ),
          TextButton(
            onPressed: () {
              // Custom/one-off vendor — no supplier FK.
              setState(() {
                _vendor.text = ctrl.text.trim();
                _supplierId = '';
              });
              Get.back();
            },
            child: Text('Set',
                style:
                    GoogleFonts.inter(color: const Color(0xFFA78BFA))),
          ),
        ],
      ),
    );
  }

  Widget _supplierRow({
    required IconData icon,
    required String title,
    required String subtitle,
    bool selected = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
              color: selected
                  ? const Color.fromARGB(255, 78, 3, 208)
                  : const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFA78BFA), size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 2.h),
                  Text(subtitle,
                      style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF), fontSize: 11.5.sp)),
                ],
              ),
            ),
            if (selected)
              Icon(Icons.check_circle_rounded,
                  color: const Color.fromARGB(255, 78, 3, 208), size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _vendorSelector() {
    final has = _vendor.text.trim().isNotEmpty;
    return GestureDetector(
      onTap: _loadingSuppliers ? null : _openSupplierPicker,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Icon(Icons.local_shipping_rounded,
                color: const Color(0xFFA78BFA), size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                _loadingSuppliers
                    ? 'Loading suppliers…'
                    : has
                        ? _vendor.text.trim()
                        : 'Vendor / supplier (optional)',
                style: GoogleFonts.inter(
                    color: has ? Colors.white : const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: has ? FontWeight.w600 : FontWeight.w400),
              ),
            ),
            Icon(Icons.expand_more_rounded,
                color: const Color(0xFF9CA3AF), size: 20.sp),
          ],
        ),
      ),
    );
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
        supplierId: _supplierId,
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
        supplierId: _supplierId,
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
                _vendorSelector(),
                SizedBox(height: 12.h),
                _input(_reference, 'Reference / receipt # (optional)'),
                SizedBox(height: 12.h),
                _input(_notes, 'Notes (optional)', maxLines: 3),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: InvoiceThemeColors.primaryPurple,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      isEdit ? 'Save changes' : 'Record expense',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
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
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide:
              const BorderSide(color: InvoiceThemeColors.borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
              color: InvoiceThemeColors.primaryPurpleLight, width: 1.4),
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
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide:
              const BorderSide(color: InvoiceThemeColors.borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
              color: InvoiceThemeColors.primaryPurpleLight, width: 1.4),
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
