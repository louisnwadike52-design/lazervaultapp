import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/inventory/domain/entities/inventory_adjustment_entity.dart';
import 'package:lazervault/src/features/inventory/domain/entities/inventory_item_entity.dart';
import '../cubit/inventory_cubit.dart';
import '../cubit/inventory_state.dart';
import '../widgets/adjust_quantity_bottom_sheet.dart';

class InventoryItemDetailsScreen extends StatefulWidget {
  final InventoryItemEntity item;

  const InventoryItemDetailsScreen({super.key, required this.item});

  @override
  State<InventoryItemDetailsScreen> createState() =>
      _InventoryItemDetailsScreenState();
}

class _InventoryItemDetailsScreenState
    extends State<InventoryItemDetailsScreen> {
  late InventoryItemEntity _item;
  List<InventoryAdjustmentEntity> _adjustments = [];
  bool _historyLoading = false;
  bool _didChange = false;

  @override
  void initState() {
    super.initState();
    _item = widget.item;
    _loadHistory();
  }

  void _loadHistory() {
    setState(() => _historyLoading = true);
    context.read<InventoryCubit>().getHistory(itemId: _item.id);
  }

  void _refreshItem() {
    context.read<InventoryCubit>().getItem(_item.id);
  }

  void _showAdjustSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<InventoryCubit>(),
        child: AdjustQuantityBottomSheet(item: _item),
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Delete Item',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            'Are you sure you want to delete "${_item.name}"? This action cannot be undone.',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<InventoryCubit>().deleteItem(_item.id);
              },
              child: Text(
                'Delete',
                style: GoogleFonts.inter(
                  color: const Color(0xFFEF4444),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InventoryCubit, InventoryState>(
      listener: (context, state) {
        if (state is ItemDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Item deleted',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
          Get.back(result: true);
        } else if (state is ItemLoaded) {
          setState(() {
            _item = state.item;
            _didChange = true;
          });
          _loadHistory();
        } else if (state is ItemUpdated) {
          setState(() {
            _item = state.item;
            _didChange = true;
          });
          _loadHistory();
        } else if (state is QuantityAdjusted) {
          setState(() {
            _item = state.item;
            _didChange = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Quantity adjusted successfully',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
          _loadHistory();
        } else if (state is HistoryLoaded) {
          setState(() {
            _adjustments = state.adjustments.take(10).toList();
            _historyLoading = false;
          });
        } else if (state is InventoryError) {
          setState(() => _historyLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is InventoryLoading;

        return PopScope(
          canPop: true,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop && _didChange && result == null) {
              // Ensure the list screen knows to refresh
              // result will be null when using system back;
              // we handle this by checking _didChange
            }
          },
          child: Scaffold(
            backgroundColor: const Color(0xFF0A0A0A),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () => Get.back(result: _didChange),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              title: Text(
                'Item Details',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: _showAdjustSheet,
                  icon: Icon(
                    Icons.tune,
                    color: const Color(0xFF3B82F6),
                    size: 22.sp,
                  ),
                  tooltip: 'Adjust Quantity',
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 8.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(),
                          SizedBox(height: 20.h),
                          _buildBasicInfoCard(),
                          SizedBox(height: 16.h),
                          _buildStockCard(),
                          SizedBox(height: 16.h),
                          if (_item.location.isNotEmpty) ...[
                            _buildLocationCard(),
                            SizedBox(height: 16.h),
                          ],
                          _buildAdjustmentHistorySection(),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                  _buildBottomActions(isLoading),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Header
  // ---------------------------------------------------------------------------

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 8.h),
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              color: const Color(0xFF3B82F6),
              size: 32.sp,
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            _item.name,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          _buildStatusBadge(),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color color;
    switch (_item.status) {
      case InventoryItemStatus.active:
        color = const Color(0xFF10B981);
        break;
      case InventoryItemStatus.inactive:
        color = const Color(0xFFFB923C);
        break;
      case InventoryItemStatus.discontinued:
        color = const Color(0xFFEF4444);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        _item.statusDisplay,
        style: GoogleFonts.inter(
          color: color,
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section Cards
  // ---------------------------------------------------------------------------

  Widget _buildBasicInfoCard() {
    return _buildSectionCard(
      title: 'Basic Information',
      icon: Icons.info_outline,
      rows: [
        _DetailRow('Category', _item.category),
        _DetailRow('SKU', _item.sku),
        _DetailRow('Description', _item.description),
        _DetailRow('Notes', _item.notes),
      ],
    );
  }

  Widget _buildStockCard() {
    final quantityColor =
        _item.isLowStock ? const Color(0xFFFB923C) : Colors.white;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warehouse_outlined,
                color: const Color(0xFF3B82F6),
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Stock',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          _buildDetailRow('Quantity',
              '${_item.quantity} ${_item.unit}',
              valueColor: quantityColor),
          if (_item.isLowStock) ...[
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: const Color(0xFFFB923C),
                    size: 14.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Below minimum stock level',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFFB923C),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
          _buildDetailRow('Unit Price', _item.formattedUnitPrice),
          _buildDetailRow(
            'Total Value',
            '\u20A6${_item.totalValue.toStringAsFixed(2)}',
          ),
          _buildDetailRow(
            'Min Stock Level',
            '${_item.minimumStockLevel} ${_item.unit}',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard() {
    return _buildSectionCard(
      title: 'Location',
      icon: Icons.location_on_outlined,
      rows: [
        _DetailRow('Storage', _item.location),
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<_DetailRow> rows,
  }) {
    final visibleRows = rows.where((r) => r.value.isNotEmpty).toList();
    if (visibleRows.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF3B82F6), size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          ...visibleRows.asMap().entries.map((entry) {
            final isLast = entry.key == visibleRows.length - 1;
            return _buildDetailRow(
              entry.value.label,
              entry.value.value,
              isLast: isLast,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isLast = false,
    Color valueColor = Colors.white,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: valueColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Adjustment History
  // ---------------------------------------------------------------------------

  Widget _buildAdjustmentHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.history,
              color: const Color(0xFF3B82F6),
              size: 18.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Adjustment History',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        if (_historyLoading)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: SizedBox(
                height: 20.h,
                width: 20.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFF3B82F6),
                ),
              ),
            ),
          )
        else if (_adjustments.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              'No adjustments yet',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF6B7280),
                fontSize: 14.sp,
              ),
            ),
          )
        else
          ...List.generate(_adjustments.length, (index) {
            return _buildAdjustmentTile(_adjustments[index]);
          }),
      ],
    );
  }

  Widget _buildAdjustmentTile(InventoryAdjustmentEntity adjustment) {
    final isAdd = adjustment.adjustmentType == AdjustmentType.add;
    final isSet = adjustment.adjustmentType == AdjustmentType.set;
    final color = isAdd
        ? const Color(0xFF10B981)
        : isSet
            ? const Color(0xFF3B82F6)
            : const Color(0xFFEF4444);

    final icon = isAdd
        ? Icons.add_circle_outline
        : isSet
            ? Icons.sync_outlined
            : Icons.remove_circle_outline;

    final sign = isAdd ? '+' : isSet ? '' : '-';

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${adjustment.adjustmentTypeDisplay} $sign${adjustment.quantityChange.abs()}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (adjustment.reason.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    adjustment.reason,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${adjustment.quantityBefore} -> ${adjustment.quantityAfter}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                _formatDate(adjustment.createdAt),
                style: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[dt.month - 1]} ${dt.day}, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  // ---------------------------------------------------------------------------
  // Bottom Actions
  // ---------------------------------------------------------------------------

  Widget _buildBottomActions(bool isLoading) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: const BoxDecoration(
        color: Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(color: Color(0xFF2D2D2D)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 48.h,
              child: OutlinedButton(
                onPressed: isLoading ? null : _showDeleteConfirmation,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: isLoading
                        ? const Color(0xFF2D2D2D)
                        : const Color(0xFFEF4444),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Delete',
                  style: GoogleFonts.inter(
                    color: isLoading
                        ? const Color(0xFF6B7280)
                        : const Color(0xFFEF4444),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: SizedBox(
              height: 48.h,
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        final result = await Get.toNamed(
                          '/inventory/items/edit',
                          arguments: _item,
                        );
                        if (result == true && mounted) _refreshItem();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  disabledBackgroundColor:
                      const Color(0xFF3B82F6).withValues(alpha: 0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Edit',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);
}
