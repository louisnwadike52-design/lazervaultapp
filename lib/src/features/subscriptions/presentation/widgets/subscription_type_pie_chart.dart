import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

/// Spending breakdown by subscription type shown as a pie chart with legend.
class SubscriptionTypePieChart extends StatelessWidget {
  final Map<String, double> byType;

  const SubscriptionTypePieChart({super.key, required this.byType});

  static const Map<String, Color> _typeColors = {
    'data': Color(0xFF3B82F6),
    'cable_tv': Color(0xFF8B5CF6),
    'internet': Color(0xFFF59E0B),
    'electricity': Color(0xFFEF4444),
    'airtime': Color(0xFF10B981),
  };

  static Color _colorForType(String type) {
    return _typeColors[type.toLowerCase()] ?? const Color(0xFF9CA3AF);
  }

  static String _displayName(String type) {
    switch (type.toLowerCase()) {
      case 'data':
        return 'Data';
      case 'cable_tv':
        return 'Cable TV';
      case 'internet':
        return 'Internet';
      case 'electricity':
        return 'Electricity';
      case 'airtime':
        return 'Airtime';
      default:
        return type;
    }
  }

  @override
  Widget build(BuildContext context) {
    final entries = byType.entries.where((e) => e.value > 0).toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    if (entries.isEmpty) {
      return Container(
        height: 200.h,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Text(
            'No spending data by category',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ),
      );
    }

    final total = entries.fold<double>(0.0, (sum, e) => sum + e.value);
    final formatter = NumberFormat('#,##0.00');

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Spending by Category',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 180.h,
            child: Row(
              children: [
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 36.r,
                      sections: entries.map((entry) {
                        final percentage = total > 0
                            ? (entry.value / total * 100)
                            : 0.0;
                        return PieChartSectionData(
                          color: _colorForType(entry.key),
                          value: entry.value,
                          title: '${percentage.toStringAsFixed(0)}%',
                          titleStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          radius: 40.r,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: entries.map((entry) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          children: [
                            Container(
                              width: 10.w,
                              height: 10.w,
                              decoration: BoxDecoration(
                                color: _colorForType(entry.key),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                _displayName(entry.key),
                                style: TextStyle(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 12.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              '${CurrencySymbols.currentSymbol}${formatter.format(entry.value)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
