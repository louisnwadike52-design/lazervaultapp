import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/invoice_entity.dart';
import '../../cubit/create_invoice_cubit.dart';

/// Screen 4: Items & Amounts
///
/// Manage invoice line items, tax, and discount
class ItemsAmountsScreen extends StatefulWidget {
  const ItemsAmountsScreen({super.key});

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
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 32.h),
            _buildItemsList(),
            SizedBox(height: 24.h),
            _buildAddItemButton(),
            SizedBox(height: 32.h),
            _buildAmountsSection(),
            SizedBox(height: 32.h),
            _buildNotesSection(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
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
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1.5,
              ),
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
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1.5,
        ),
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
                    Text(
                      '${item.quantity} × \$${item.unitPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      '= \$${total.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF3B82F6),
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
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Add Item',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
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
            _buildSummaryRow('Discount', -discount, color: Colors.red.shade400),
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
            prefixText: '\$ ',
            prefixStyle: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFF3B82F6),
                width: 2,
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
      {bool isTotal = false, Color? color}) {
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
          '\$${amount.toStringAsFixed(2)}',
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
            fillColor: Colors.white.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFF3B82F6),
                width: 2,
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

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Add Item',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildDialogTextField(
                        priceController,
                        'Unit Price *',
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        prefix: '\$ ',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[400],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
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
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Add',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF3B82F6),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEditItemDialog(InvoiceItem item, int index) {
    final nameController = TextEditingController(text: item.name);
    final descriptionController = TextEditingController(text: item.description ?? '');
    final quantityController = TextEditingController(text: item.quantity.toString());
    final priceController = TextEditingController(text: item.unitPrice.toString());

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Edit Item',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildDialogTextField(
                        priceController,
                        'Unit Price *',
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        prefix: '\$ ',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[400],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
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
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Save',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF3B82F6),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogTextField(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
    String? prefix,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
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
        fillColor: Colors.white.withValues(alpha: 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: Color(0xFF3B82F6),
            width: 2,
          ),
        ),
      ),
    );
  }
}
