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
        final currencySymbol = snapshot.data ?? CurrencySymbols.getSymbol(statistics.currency);

        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey[800]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Auto-Save Statistics',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16.h),
              _buildStatsGrid(currencySymbol),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatsGrid(String currencySymbol) {
    return Column(
      children: [
        // Main featured stat - Total Saved All Time
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF10B981),
                const Color(0xFF059669),
              ],
            ),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF10B981).withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.savings,
                  color: Colors.white,
                  size: 28.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Saved',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      statistics.formattedTotalSavedAllTime,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        // First row of stats
        Row(
          children: [
            Expanded(
              child: _buildStatItem(
                'Active Rules',
                statistics.activeRulesCount.toString(),
                Icons.rule,
                const Color(0xFF3B82F6),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatItem(
                'This Month',
                statistics.formattedTotalSavedThisMonth,
                Icons.calendar_month,
                const Color(0xFF8B5CF6),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        // Second row of stats
        Row(
          children: [
            Expanded(
              child: _buildStatItem(
                'This Week',
                statistics.formattedTotalSavedThisWeek,
                Icons.date_range,
                const Color(0xFFF59E0B),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatItem(
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
          // Average save amount
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
              ),
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
                          color: Colors.grey[400],
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
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 18.sp,
          ),
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
              color: Colors.grey[400],
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
