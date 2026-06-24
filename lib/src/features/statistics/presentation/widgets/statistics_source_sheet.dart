import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/statistics_state.dart';

/// Bottom sheet that lets the user pick which money source the budgeting /
/// statistics content reflects: LazerVault wallet, linked banks, or both.
/// Returns the picked [StatisticsSource] (or null if dismissed).
Future<StatisticsSource?> showStatisticsSourceSheet(
  BuildContext context, {
  required StatisticsSource current,
}) {
  return showModalBottomSheet<StatisticsSource>(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xFF1F1F1F),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (ctx) => _StatisticsSourceSheet(current: current),
  );
}

class _StatisticsSourceSheet extends StatelessWidget {
  const _StatisticsSourceSheet({required this.current});

  final StatisticsSource current;

  static const _options = <(StatisticsSource, IconData, String)>[
    (StatisticsSource.lazervault, Icons.account_balance_wallet_rounded,
        'Spending and income from your Lazervault wallet only'),
    (StatisticsSource.bank, Icons.account_balance_rounded,
        'Activity from your linked external bank accounts only'),
    (StatisticsSource.both, Icons.dashboard_rounded,
        'Everything combined across Lazervault and your banks'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              'Show data from',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Filter the budgeting content by money source',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 16.h),
            ..._options.map((o) => _OptionTile(
                  source: o.$1,
                  icon: o.$2,
                  description: o.$3,
                  selected: o.$1 == current,
                  onTap: () => Navigator.of(context).pop(o.$1),
                )),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.source,
    required this.icon,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  final StatisticsSource source;
  final IconData icon;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF3B82F6);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: selected ? accent.withValues(alpha: 0.12) : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: selected ? accent : Colors.white.withValues(alpha: 0.08),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: (selected ? accent : Colors.white).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: selected ? accent : Colors.white, size: 20.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    source.label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    description,
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            if (selected) Icon(Icons.check_circle_rounded, color: accent, size: 22.sp),
          ],
        ),
      ),
    );
  }
}
