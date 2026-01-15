import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/types/unified_transaction.dart';

/// Service type filter chips widget
class ServiceFilterChips extends StatelessWidget {
  final List<TransactionServiceType> availableServices;
  final List<TransactionServiceType> selectedServices;
  final Function(List<TransactionServiceType>) onSelectionChanged;

  const ServiceFilterChips({
    super.key,
    required this.availableServices,
    required this.selectedServices,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: availableServices.length,
        itemBuilder: (context, index) {
          final service = availableServices[index];
          final isSelected = selectedServices.contains(service);

          return Container(
            margin: EdgeInsets.only(right: 8.w),
            child: FilterChip(
              label: Text(
                service.displayName,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                final newSelection = List<TransactionServiceType>.from(selectedServices);
                if (selected) {
                  newSelection.add(service);
                } else {
                  newSelection.remove(service);
                }
                onSelectionChanged(newSelection);
              },
              backgroundColor: Colors.white.withOpacity(0.1),
              selectedColor: service.color.withValues(alpha: 0.3),
              checkmarkColor: Colors.white,
              side: BorderSide(
                color: isSelected ? service.color : Colors.white.withOpacity(0.1),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              avatar: isSelected
                  ? Icon(
                      service.icon,
                      size: 16.sp,
                      color: service.color,
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}

/// Status filter chips widget
class StatusFilterChips extends StatelessWidget {
  final List<UnifiedTransactionStatus> selectedStatuses;
  final Function(List<UnifiedTransactionStatus>) onSelectionChanged;

  const StatusFilterChips({
    super.key,
    required this.selectedStatuses,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final statuses = [
      UnifiedTransactionStatus.completed,
      UnifiedTransactionStatus.pending,
      UnifiedTransactionStatus.failed,
      UnifiedTransactionStatus.processing,
    ];

    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: statuses.length,
        itemBuilder: (context, index) {
          final status = statuses[index];
          final isSelected = selectedStatuses.contains(status);

          return Container(
            margin: EdgeInsets.only(right: 8.w),
            child: FilterChip(
              label: Text(
                status.displayName,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                final newSelection = List<UnifiedTransactionStatus>.from(selectedStatuses);
                if (selected) {
                  newSelection.add(status);
                } else {
                  newSelection.remove(status);
                }
                onSelectionChanged(newSelection);
              },
              backgroundColor: Colors.white.withOpacity(0.1),
              selectedColor: status.color.withValues(alpha: 0.3),
              checkmarkColor: Colors.white,
              side: BorderSide(
                color: isSelected ? status.color : Colors.white.withOpacity(0.1),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Search bar widget for transactions
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: Colors.white.withOpacity(0.6),
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'Search transactions...',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            GestureDetector(
              onTap: onClear,
              child: Icon(
                Icons.clear_rounded,
                color: Colors.white.withOpacity(0.6),
                size: 20.sp,
              ),
            ),
        ],
      ),
    );
  }
}

/// Date range picker button
class DateRangeFilterButton extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final VoidCallback onTap;

  const DateRangeFilterButton({
    super.key,
    this.startDate,
    this.endDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasFilter = startDate != null || endDate != null;

    return Container(
      margin: EdgeInsets.only(right: 8.w),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: 14.sp,
              color: hasFilter ? Colors.white : Colors.white.withOpacity(0.7),
            ),
            SizedBox(width: 4.w),
            Text(
              _getDateLabel(),
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: hasFilter ? FontWeight.w600 : FontWeight.w500,
                color: hasFilter ? Colors.white : Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
        selected: hasFilter,
        onSelected: (_) => onTap(),
        backgroundColor: Colors.white.withOpacity(0.1),
        selectedColor: Colors.blue.withValues(alpha: 0.3),
        checkmarkColor: Colors.white,
        side: BorderSide(
          color: hasFilter ? Colors.blue : Colors.white.withOpacity(0.1),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  String _getDateLabel() {
    if (startDate != null && endDate != null) {
      return '${_formatDate(startDate!)} - ${_formatDate(endDate!)}';
    } else if (startDate != null) {
      return 'Since ${_formatDate(startDate!)}';
    } else if (endDate != null) {
      return 'Until ${_formatDate(endDate!)}';
    }
    return 'Date Range';
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}';
  }
}

/// Clear filters button
class ClearFiltersButton extends StatelessWidget {
  final VoidCallback onClear;
  final bool isActive;

  const ClearFiltersButton({
    super.key,
    required this.onClear,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!isActive) return const SizedBox.shrink();

    return TextButton.icon(
      onPressed: onClear,
      icon: Icon(
        Icons.clear_all_rounded,
        size: 16.sp,
        color: Colors.white.withOpacity(0.7),
      ),
      label: Text(
        'Clear All',
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white.withOpacity(0.7),
        ),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
