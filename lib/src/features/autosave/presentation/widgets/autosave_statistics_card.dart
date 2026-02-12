import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';

class AutoSaveStatisticsCard extends StatelessWidget {
  final AutoSaveStatisticsEntity statistics;

  const AutoSaveStatisticsCard({
    super.key,
    required this.statistics,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: CurrencySymbols.currencySymbolStream,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1A1A3E),
                Color(0xFF0A0E27),
                Color(0xFF0F0F23),
              ],
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              Icon(
                Icons.savings,
                size: 48.sp,
                color: const Color(0xFF4E03D0),
              ),
              SizedBox(height: 16.h),
              Text(
                'Savings Overview',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMetricItem(
                    label: 'Active Rules',
                    value: statistics.activeRulesCount.toString(),
                  ),
                  Container(
                    width: 1,
                    height: 40.h,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  _buildMetricItem(
                    label: 'Total Saved',
                    value: statistics.formattedTotalSavedAllTime,
                  ),
                  Container(
                    width: 1,
                    height: 40.h,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  _buildMetricItem(
                    label: 'This Month',
                    value: statistics.formattedTotalSavedThisMonth,
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              // Secondary stats row
              Row(
                children: [
                  Expanded(
                    child: _buildSecondaryStatItem(
                      'This Week',
                      statistics.formattedTotalSavedThisWeek,
                      Icons.date_range,
                      const Color(0xFFF59E0B),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildSecondaryStatItem(
                      'Transactions',
                      statistics.totalTransactions.toString(),
                      Icons.receipt,
                      const Color(0xFF14B8A6),
                    ),
                  ),
                ],
              ),
              if (statistics.averageSaveAmount > 0) ...[
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.analytics,
                        color: const Color(0xFF3B82F6),
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Average per Save',
                              style: GoogleFonts.inter(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              statistics.formattedAverageSaveAmount,
                              style: GoogleFonts.inter(
                                color: const Color(0xFF3B82F6),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildMetricItem({required String label, required String value}) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSecondaryStatItem(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18.sp),
          SizedBox(height: 8.h),
          Text(
            value,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
