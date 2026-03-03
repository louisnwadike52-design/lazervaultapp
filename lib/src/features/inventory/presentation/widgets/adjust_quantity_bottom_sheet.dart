import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/inventory/domain/entities/inventory_item_entity.dart';
import '../cubit/inventory_cubit.dart';
import '../cubit/inventory_state.dart';

class AdjustQuantityBottomSheet extends StatefulWidget {
  final InventoryItemEntity item;

  const AdjustQuantityBottomSheet({super.key, required this.item});

  @override
  State<AdjustQuantityBottomSheet> createState() =>
      _AdjustQuantityBottomSheetState();
}

class _AdjustQuantityBottomSheetState extends State<AdjustQuantityBottomSheet> {
  AdjustmentType _adjustmentType = AdjustmentType.add;
  final _quantityController = TextEditingController();
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _quantityController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _submit() {
    final quantity = int.tryParse(_quantityController.text.trim());
    if (quantity == null || quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Enter a valid quantity',
            style: GoogleFonts.inter(color: Colors.white),
          ),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
      return;
    }

    if (_adjustmentType == AdjustmentType.remove &&
        quantity > widget.item.quantity) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Cannot remove more than current stock (${widget.item.quantity})',
            style: GoogleFonts.inter(color: Colors.white),
          ),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
      return;
    }

    context.read<InventoryCubit>().adjustQuantity(
          itemId: widget.item.id,
          adjustmentType: _adjustmentType,
          quantity: quantity,
          reason: _reasonController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InventoryCubit, InventoryState>(
      listener: (context, state) {
        if (state is QuantityAdjusted || state is ItemUpdated) {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 16.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // Title
                Text(
                  'Adjust Quantity',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.item.name,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                  ),
                ),

                SizedBox(height: 16.h),

                // Current stock display
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A0A0A),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Current Stock',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 14.sp,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.item.quantity}',
                            style: GoogleFonts.inter(
                              color: widget.item.isLowStock
                                  ? const Color(0xFFFB923C)
                                  : Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            widget.item.unit,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // Add / Remove toggle
                Text(
                  'Adjustment Type',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    _buildToggleOption(
                      label: 'Add',
                      icon: Icons.add,
                      type: AdjustmentType.add,
                      color: const Color(0xFF10B981),
                    ),
                    SizedBox(width: 10.w),
                    _buildToggleOption(
                      label: 'Remove',
                      icon: Icons.remove,
                      type: AdjustmentType.remove,
                      color: const Color(0xFFEF4444),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Quantity field
                Text(
                  'Quantity',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                TextFormField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  autofocus: true,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: 'e.g. 25',
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0xFF6B7280),
                      fontSize: 15.sp,
                    ),
                    prefixIcon: Icon(
                      Icons.numbers,
                      color: const Color(0xFF9CA3AF),
                      size: 20.sp,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF0A0A0A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                  ),
                ),

                SizedBox(height: 14.h),

                // Reason field
                Text(
                  'Reason',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                TextFormField(
                  controller: _reasonController,
                  maxLines: 2,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: 'e.g. Restocked from supplier',
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0xFF6B7280),
                      fontSize: 15.sp,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Icon(
                        Icons.notes_outlined,
                        color: const Color(0xFF9CA3AF),
                        size: 20.sp,
                      ),
                    ),
                    filled: true,
                    fillColor: const Color(0xFF0A0A0A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                // Submit button
                BlocBuilder<InventoryCubit, InventoryState>(
                  builder: (context, state) {
                    final isLoading = state is InventoryLoading;
                    return SizedBox(
                      width: double.infinity,
                      height: 52.h,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                          disabledBackgroundColor:
                              const Color(0xFF3B82F6).withValues(alpha: 0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          elevation: 0,
                        ),
                        child: isLoading
                            ? SizedBox(
                                height: 22.h,
                                width: 22.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : Text(
                                'Adjust',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleOption({
    required String label,
    required IconData icon,
    required AdjustmentType type,
    required Color color,
  }) {
    final isSelected = _adjustmentType == type;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _adjustmentType = type),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected
                ? color.withValues(alpha: 0.15)
                : const Color(0xFF0A0A0A),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isSelected ? color : const Color(0xFF2D2D2D),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? color : const Color(0xFF9CA3AF),
                  size: 18.sp),
              SizedBox(width: 6.w),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: isSelected ? color : const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
