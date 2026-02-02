import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../../domain/entities/invoice_entity.dart';
import '../../cubit/create_invoice_cubit.dart';

/// Screen 4: Items & Amounts
///
/// Manage invoice line items, tax, and discount
class ItemsAmountsScreen extends StatefulWidget {
  final bool showTax;
  final bool showDiscount;
  final bool showNotes;

  const ItemsAmountsScreen({
    super.key,
    this.showTax = true,
    this.showDiscount = true,
    this.showNotes = true,
  });

  @override
  State<ItemsAmountsScreen> createState() => _ItemsAmountsScreenState();
}

class _ItemsAmountsScreenState extends State<ItemsAmountsScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  late TextEditingController _taxController;
  late TextEditingController _discountController;
  late TextEditingController _notesController;

  String get _currencySymbol {
    try {
      final cubit = context.read<CreateInvoiceCubit>();
      if (cubit.invoiceCurrency.isNotEmpty) {
        return _getCurrencySymbol(cubit.invoiceCurrency);
      }
      final state = context.read<AccountCardsSummaryCubit>().state;
      if (state is AccountCardsSummaryLoaded && state.accountSummaries.isNotEmpty) {
        return _getCurrencySymbol(state.accountSummaries.first.currency);
      }
    } catch (_) {}
    return '\$';
  }

  String _getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN': return '₦';
      case 'GBP': return '£';
      case 'EUR': return '€';
      case 'ZAR': return 'R';
      case 'CAD': return 'C\$';
      case 'AUD': return 'A\$';
      case 'INR': return '₹';
      case 'JPY': return '¥';
      case 'USD': return '\$';
      default: return '₦';
    }
  }

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _fadeController.forward();

    // Initialize controllers
    final cubit = context.read<CreateInvoiceCubit>();
    _taxController = TextEditingController(
      text: cubit.taxAmount > 0 ? cubit.taxAmount.toString() : '',
    );
    _discountController = TextEditingController(
      text: cubit.discountAmount > 0 ? cubit.discountAmount.toString() : '',
    );
    _notesController = TextEditingController(text: cubit.notes);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _taxController.dispose();
    _discountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 32.h),
            _buildItemsList(),
            SizedBox(height: 24.h),
            _buildAddItemButton(),
            if (widget.showTax || widget.showDiscount) ...[
              SizedBox(height: 32.h),
              _buildAmountsSection(),
            ] else ...[
              // Always show subtotal/total summary even without tax/discount fields
              SizedBox(height: 24.h),
              _buildSimpleSummary(),
            ],
            if (widget.showNotes) ...[
              SizedBox(height: 32.h),
              _buildNotesSection(),
            ],
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleSummary() {
    return BlocBuilder<CreateInvoiceCubit, dynamic>(
      builder: (context, state) {
        final cubit = context.read<CreateInvoiceCubit>();
        return _buildSummaryRow('Total', cubit.subtotal,
            isTotal: true, color: const Color(0xFF3B82F6));
      },
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Items & Amounts',
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Add line items, tax, and discount to your invoice',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildItemsList() {
    return BlocBuilder<CreateInvoiceCubit, dynamic>(
      builder: (context, state) {
        final cubit = context.read<CreateInvoiceCubit>();
        final items = cubit.items;

        if (items.isEmpty) {
          return Container(
            padding: EdgeInsets.all(32.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.receipt_long,
                  size: 48.sp,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
                SizedBox(height: 12.h),
                Text(
                  'No items added yet',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Tap the button below to add your first item',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            ...items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: _buildItemCard(item, index, cubit),
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildItemCard(InvoiceItem item, int index, CreateInvoiceCubit cubit) {
    final total = item.unitPrice * item.quantity;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                if (item.description?.isNotEmpty == true) ...[
                  SizedBox(height: 4.h),
                  Text(
                    item.description!,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '${item.quantity} × $_currencySymbol${item.unitPrice.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[400],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Flexible(
                      child: Text(
                        '= $_currencySymbol${total.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF3B82F6),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => _showEditItemDialog(item, index),
                icon: Icon(
                  Icons.edit,
                  color: Colors.white.withValues(alpha: 0.6),
                  size: 20.sp,
                ),
              ),
              IconButton(
                onPressed: () => cubit.removeItem(index),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red.shade400,
                  size: 20.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddItemButton() {
    return GestureDetector(
      onTap: _showAddItemDialog,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(
                Icons.add_shopping_cart_rounded,
                color: Colors.white,
                size: 26.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Add Item',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Tap to add a product or service',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountsSection() {
    return BlocBuilder<CreateInvoiceCubit, dynamic>(
      builder: (context, state) {
        final cubit = context.read<CreateInvoiceCubit>();
        final subtotal = cubit.subtotal;
        final tax = cubit.taxAmount;
        final discount = cubit.discountAmount;
        final total = cubit.total;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amounts',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: _buildAmountField(
                    controller: _taxController,
                    label: 'Tax',
                    hint: '0.00',
                    onChanged: (value) {
                      cubit.updateTaxAmount(double.tryParse(value) ?? 0.0);
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildAmountField(
                    controller: _discountController,
                    label: 'Discount',
                    hint: '0.00',
                    onChanged: (value) {
                      cubit.updateDiscountAmount(double.tryParse(value) ?? 0.0);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            _buildSummaryRow('Subtotal', subtotal),
            SizedBox(height: 8.h),
            _buildSummaryRow('Tax', tax, color: Colors.grey[400]),
            SizedBox(height: 8.h),
            if (discount > 0)
              _buildSummaryRow('Discount', discount, color: Colors.red.shade400, prefix: '- '),
            SizedBox(height: 12.h),
            Divider(color: Colors.white.withValues(alpha: 0.2)),
            SizedBox(height: 12.h),
            _buildSummaryRow('Total', total,
                isTotal: true, color: const Color(0xFF3B82F6)),
          ],
        );
      },
    );
  }

  Widget _buildAmountField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[400],
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          onChanged: onChanged,
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
            prefixText: '$_currencySymbol ',
            prefixStyle: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.08),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFF3B82F6),
                width: 1.5,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, double amount,
      {bool isTotal = false, Color? color, String prefix = ''}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: color ?? Colors.grey[300],
          ),
        ),
        Text(
          '$prefix$_currencySymbol${amount.toStringAsFixed(2)}',
          style: GoogleFonts.inter(
            fontSize: isTotal ? 18.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
            color: color ?? Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildNotesSection() {
    final cubit = context.read<CreateInvoiceCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes (Optional)',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
        TextField(
          controller: _notesController,
          maxLines: 3,
          onChanged: (value) => cubit.updateNotes(value),
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Add any additional notes or terms...',
            hintStyle: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.08),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFF3B82F6),
                width: 1.5,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
          ),
        ),
      ],
    );
  }

  void _showAddItemDialog() {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final quantityController = TextEditingController(text: '1');
    final priceController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 20.h,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Add Item',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.h),
              _buildDialogTextField(nameController, 'Item Name *'),
              SizedBox(height: 12.h),
              _buildDialogTextField(descriptionController, 'Description (Optional)'),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: _buildDialogTextField(
                      quantityController,
                      'Quantity *',
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildDialogTextField(
                      priceController,
                      'Unit Price *',
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      prefix: '$_currencySymbol ',
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(sheetContext).pop(),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        final name = nameController.text.trim();
                        final description = descriptionController.text.trim();
                        final quantity = double.tryParse(quantityController.text) ?? 0;
                        final price = double.tryParse(priceController.text) ?? 0;

                        if (name.isEmpty || quantity <= 0 || price <= 0) {
                          return;
                        }

                        final item = InvoiceItem(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: name,
                          description: description.isEmpty ? null : description,
                          quantity: quantity,
                          unitPrice: price,
                          totalPrice: quantity * price,
                        );

                        context.read<CreateInvoiceCubit>().addItem(item);
                        Navigator.of(sheetContext).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            'Add',
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditItemDialog(InvoiceItem item, int index) {
    final nameController = TextEditingController(text: item.name);
    final descriptionController = TextEditingController(text: item.description ?? '');
    final quantityController = TextEditingController(text: item.quantity.toString());
    final priceController = TextEditingController(text: item.unitPrice.toString());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 20.h,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Edit Item',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.h),
              _buildDialogTextField(nameController, 'Item Name *'),
              SizedBox(height: 12.h),
              _buildDialogTextField(descriptionController, 'Description (Optional)'),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: _buildDialogTextField(
                      quantityController,
                      'Quantity *',
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildDialogTextField(
                      priceController,
                      'Unit Price *',
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      prefix: '$_currencySymbol ',
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(sheetContext).pop(),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        final name = nameController.text.trim();
                        final description = descriptionController.text.trim();
                        final quantity = double.tryParse(quantityController.text) ?? 0;
                        final price = double.tryParse(priceController.text) ?? 0;

                        if (name.isEmpty || quantity <= 0 || price <= 0) {
                          return;
                        }

                        final updatedItem = InvoiceItem(
                          id: item.id,
                          name: name,
                          description: description.isEmpty ? null : description,
                          quantity: quantity,
                          unitPrice: price,
                          totalPrice: quantity * price,
                        );

                        context.read<CreateInvoiceCubit>().updateItem(index, updatedItem);
                        Navigator.of(sheetContext).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            'Save',
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDialogTextField(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
    String? prefix,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: GoogleFonts.inter(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.grey[400],
        ),
        prefixText: prefix,
        prefixStyle: GoogleFonts.inter(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.08),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: Color(0xFF3B82F6),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
