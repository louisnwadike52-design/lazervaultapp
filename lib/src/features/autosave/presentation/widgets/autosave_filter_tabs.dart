import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';

class AutoSaveFilterTabs extends StatelessWidget {
  final AutoSaveStatus? selectedStatus;
  final Function(AutoSaveStatus?) onStatusChanged;
  final Map<AutoSaveStatus, int> counts;

  const AutoSaveFilterTabs({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
    this.counts = const {},
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          _buildFilterChip('All', null),
          SizedBox(width: 8.w),
          _buildFilterChip('Active', AutoSaveStatus.active),
          SizedBox(width: 8.w),
          _buildFilterChip('Paused', AutoSaveStatus.paused),
          SizedBox(width: 8.w),
          _buildFilterChip('Completed', AutoSaveStatus.completed),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, AutoSaveStatus? status) {
    final isSelected = selectedStatus == status;
    final count = status == null
        ? counts.values.fold(0, (sum, count) => sum + count)
        : (counts[status] ?? 0);

    return GestureDetector(
      onTap: () => onStatusChanged(status),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 78, 3, 208)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 78, 3, 208)
                : const Color(0xFF2D2D2D),
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            if (count > 0) ...[
              SizedBox(width: 6.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.2)
                      : const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
