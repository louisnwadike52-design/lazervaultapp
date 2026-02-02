import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/unified_transaction.dart';

/// Horizontal month selector chips — Revolut-style
class MonthFilterChips extends StatelessWidget {
  final int? selectedMonth; // 1-12, null = "All"
  final int? selectedYear;
  final ValueChanged<({int? month, int? year})> onChanged;

  const MonthFilterChips({
    super.key,
    this.selectedMonth,
    this.selectedYear,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final months = <({String label, int? month, int? year})>[
      (label: 'All', month: null, year: null),
    ];

    // Show last 12 months, current first
    for (int i = 0; i < 12; i++) {
      final date = DateTime(now.year, now.month - i, 1);
      months.add((
        label: DateFormat('MMM').format(date),
        month: date.month,
        year: date.year,
      ));
    }

    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: months.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final item = months[index];
          final isSelected = item.month == selectedMonth && item.year == selectedYear;

          return GestureDetector(
            onTap: () => onChanged((month: item.month, year: item.year)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF581CD9)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Text(
                item.label,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.white : const Color(0xFF8E8E93),
                  fontFamily: 'Inter',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Status filter row — "All" / "Completed" / "Pending" / "Failed" text tabs
class StatusFilterRow extends StatelessWidget {
  final UnifiedTransactionStatus? selectedStatus; // null = "All"
  final ValueChanged<UnifiedTransactionStatus?> onChanged;

  const StatusFilterRow({
    super.key,
    this.selectedStatus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = <({String label, UnifiedTransactionStatus? status})>[
      (label: 'All', status: null),
      (label: 'Completed', status: UnifiedTransactionStatus.completed),
      (label: 'Pending', status: UnifiedTransactionStatus.pending),
      (label: 'Failed', status: UnifiedTransactionStatus.failed),
    ];

    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: tabs.length,
        separatorBuilder: (_, __) => SizedBox(width: 20.w),
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = tab.status == selectedStatus;

          return GestureDetector(
            onTap: () => onChanged(tab.status),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tab.label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? Colors.white : const Color(0xFF8E8E93),
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  height: 2.h,
                  width: 24.w,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF581CD9)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(1.r),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Revolut-style search bar — pill-shaped
class TransactionSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback? onClear;

  const TransactionSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 44.h,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: const Color(0xFF8E8E93),
            size: 20.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
              ),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: const Color(0xFF8E8E93),
                  fontSize: 14.sp,
                  fontFamily: 'Inter',
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10.h),
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            GestureDetector(
              onTap: onClear,
              child: Icon(
                Icons.clear_rounded,
                color: const Color(0xFF8E8E93),
                size: 18.sp,
              ),
            ),
        ],
      ),
    );
  }
}
