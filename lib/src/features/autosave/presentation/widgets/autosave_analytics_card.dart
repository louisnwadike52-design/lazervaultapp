import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';

class AutoSaveAnalyticsCard extends StatelessWidget {
  final List<AutoSaveRuleEntity> rules;

  const AutoSaveAnalyticsCard({
    super.key,
    required this.rules,
  });

  @override
  Widget build(BuildContext context) {
    final totalSaved =
        rules.fold<double>(0, (sum, rule) => sum + rule.totalSaved);
    final activeCount = rules.where((r) => r.isActive).length;
    final avgSaved = rules.isNotEmpty ? totalSaved / rules.length : 0;
    final bestPerformer = rules.isNotEmpty
        ? rules.reduce((a, b) => a.totalSaved > b.totalSaved ? a : b)
        : null;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 78, 3, 208),
            Color.fromARGB(255, 98, 33, 224),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: Colors.white, size: 24.sp),
              SizedBox(width: 12.w),
              Text(
                'Quick Stats',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  label: 'Total Saved',
                  value: '\$${totalSaved.toStringAsFixed(2)}',
                  icon: Icons.savings,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  label: 'Active Rules',
                  value: activeCount.toString(),
                  icon: Icons.check_circle,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  label: 'Avg Per Rule',
                  value: '\$${avgSaved.toStringAsFixed(2)}',
                  icon: Icons.trending_up,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  label: 'Top Performer',
                  value: bestPerformer?.name ?? 'N/A',
                  icon: Icons.star,
                  valueSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required IconData icon,
    double? valueSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white70, size: 14.sp),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: valueSize ?? 16.sp,
            fontWeight: FontWeight.w700,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
