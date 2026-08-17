import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
part 'transaction_filters_widgets.dart';


/// Horizontal filter bar with individual per-category chips.
/// Each chip (Date, Status, Category, Type) opens its own bottom sheet.
class TransactionFilterBar extends StatelessWidget {
  final TransactionFilters? activeFilters;
  final VoidCallback onClearAll;
  final ValueChanged<TransactionFilters> onFiltersChanged;

  const TransactionFilterBar({
    super.key,
    this.activeFilters,
    required this.onClearAll,
    required this.onFiltersChanged,
  });

  bool get _hasDateFilter =>
      activeFilters?.startDate != null || activeFilters?.endDate != null;

  bool get _hasStatusFilter =>
      activeFilters?.statuses != null && activeFilters!.statuses!.isNotEmpty;

  bool get _hasCategoryFilter =>
      activeFilters?.serviceTypes != null && activeFilters!.serviceTypes!.isNotEmpty;

  bool get _hasTypeFilter =>
      activeFilters?.flows != null && activeFilters!.flows!.isNotEmpty;

  bool get _hasAnyFilter =>
      _hasDateFilter || _hasStatusFilter || _hasCategoryFilter || _hasTypeFilter;

  String _dateLabel() {
    if (!_hasDateFilter) return 'Date';
    final start = activeFilters!.startDate;
    final end = activeFilters!.endDate;
    if (start != null && end != null) {
      return '${DateFormat('d MMM').format(start)} - ${DateFormat('d MMM').format(end)}';
    } else if (start != null) {
      return 'From ${DateFormat('d MMM').format(start)}';
    } else {
      return 'Until ${DateFormat('d MMM').format(end!)}';
    }
  }

  String _statusLabel() {
    if (!_hasStatusFilter) return 'Status';
    final statuses = activeFilters!.statuses!;
    if (statuses.length == 1) return statuses.first.displayName;
    return '${statuses.length} statuses';
  }

  String _categoryLabel() {
    if (!_hasCategoryFilter) return 'Category';
    final types = activeFilters!.serviceTypes!;
    if (types.length == 1) return types.first.displayName;
    return '${types.length} categories';
  }

  String _typeLabel() {
    if (!_hasTypeFilter) return 'Type';
    final flows = activeFilters!.flows!;
    if (flows.length == 1) {
      return flows.first == TransactionFlow.incoming ? 'Incoming' : 'Outgoing';
    }
    return 'All types';
  }

  void _openDateSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _DateFilterSheet(
        startDate: activeFilters?.startDate,
        endDate: activeFilters?.endDate,
        onApply: (start, end) {
          final current = activeFilters ?? const TransactionFilters();
          onFiltersChanged(TransactionFilters(
            serviceTypes: current.serviceTypes,
            statuses: current.statuses,
            flows: current.flows,
            startDate: start,
            endDate: end != null
                ? DateTime(end.year, end.month, end.day, 23, 59, 59)
                : null,
            searchQuery: current.searchQuery,
          ));
        },
      ),
    );
  }

  void _openStatusSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _StatusFilterSheet(
        selected: activeFilters?.statuses?.toSet() ?? {},
        onApply: (statuses) {
          final current = activeFilters ?? const TransactionFilters();
          onFiltersChanged(TransactionFilters(
            serviceTypes: current.serviceTypes,
            statuses: statuses.isNotEmpty ? statuses.toList() : null,
            flows: current.flows,
            startDate: current.startDate,
            endDate: current.endDate,
            searchQuery: current.searchQuery,
          ));
        },
      ),
    );
  }

  void _openCategorySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CategoryFilterSheet(
        selected: activeFilters?.serviceTypes?.toSet() ?? {},
        onApply: (types) {
          final current = activeFilters ?? const TransactionFilters();
          onFiltersChanged(TransactionFilters(
            serviceTypes: types.isNotEmpty ? types.toList() : null,
            statuses: current.statuses,
            flows: current.flows,
            startDate: current.startDate,
            endDate: current.endDate,
            searchQuery: current.searchQuery,
          ));
        },
      ),
    );
  }

  void _openTypeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _TypeFilterSheet(
        selectedFlow: activeFilters?.flows?.isNotEmpty == true
            ? activeFilters!.flows!.first
            : null,
        onApply: (flow) {
          final current = activeFilters ?? const TransactionFilters();
          onFiltersChanged(TransactionFilters(
            serviceTypes: current.serviceTypes,
            statuses: current.statuses,
            flows: flow != null ? [flow] : null,
            startDate: current.startDate,
            endDate: current.endDate,
            searchQuery: current.searchQuery,
          ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          _buildFilterChip(
            context,
            label: _dateLabel(),
            icon: Icons.calendar_today_rounded,
            isActive: _hasDateFilter,
            onTap: () => _openDateSheet(context),
          ),
          SizedBox(width: 8.w),
          _buildFilterChip(
            context,
            label: _statusLabel(),
            icon: Icons.circle,
            isActive: _hasStatusFilter,
            onTap: () => _openStatusSheet(context),
          ),
          SizedBox(width: 8.w),
          _buildFilterChip(
            context,
            label: _categoryLabel(),
            icon: Icons.category_rounded,
            isActive: _hasCategoryFilter,
            onTap: () => _openCategorySheet(context),
          ),
          SizedBox(width: 8.w),
          _buildFilterChip(
            context,
            label: _typeLabel(),
            icon: Icons.swap_vert_rounded,
            isActive: _hasTypeFilter,
            onTap: () => _openTypeSheet(context),
          ),
          if (_hasAnyFilter) ...[
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: onClearAll,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Text(
                  'Clear all',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF8E8E93),
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF581CD9).withValues(alpha: 0.15)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: isActive
                ? const Color(0xFF581CD9).withValues(alpha: 0.5)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? const Color(0xFF581CD9) : const Color(0xFF8E8E93),
              size: icon == Icons.circle ? 8.sp : 14.sp,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? Colors.white : const Color(0xFF8E8E93),
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: isActive ? Colors.white70 : const Color(0xFF8E8E93),
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Per-category bottom sheets
// ---------------------------------------------------------------------------

Widget _buildSheetHeader(BuildContext context, String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Container(
          width: 36.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
      ),
      SizedBox(height: 16.h),
      Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontFamily: 'Inter',
        ),
      ),
    ],
  );
}

Widget _buildApplyButton(BuildContext context, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: 50.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF581CD9),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Text(
        'Apply',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontFamily: 'Inter',
        ),
      ),
    ),
  );
}
