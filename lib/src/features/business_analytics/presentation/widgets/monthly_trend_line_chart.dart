import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;

class MonthlyTrendLineChart extends StatelessWidget {
  final accounts_pb.GetExpenseTimeSeriesResponse timeSeries;

  const MonthlyTrendLineChart({super.key, required this.timeSeries});

  @override
  Widget build(BuildContext context) {
    final dataPoints = timeSeries.dataPoints;
    if (dataPoints.isEmpty) return _buildEmptyState();

    final maxY = dataPoints.fold<double>(
        0, (max, p) => p.amount > max ? p.amount : max);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Expense Trend',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Avg/Day',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                  Text(
                    'NGN ${_formatAmount(timeSeries.dailyAverage)}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFB923C),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 180.h,
            child: LineChart(
              LineChartData(
                maxY: maxY * 1.2,
                minY: 0,
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => const Color(0xFF2D2D2D),
                    getTooltipItems: (spots) {
                      return spots.map((spot) {
                        final idx = spot.x.toInt();
                        final date =
                            idx < dataPoints.length ? dataPoints[idx].date : '';
                        return LineTooltipItem(
                          '$date\nNGN ${_formatAmount(spot.y)}',
                          TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: (dataPoints.length / 5).ceilToDouble(),
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx < 0 || idx >= dataPoints.length) {
                          return const SizedBox.shrink();
                        }
                        final date = dataPoints[idx].date;
                        final day =
                            date.length >= 10 ? date.substring(8, 10) : '';
                        return Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            day,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50.w,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          _formatAmount(value),
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color(0xFF9CA3AF),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: const Color(0xFF2D2D2D),
                    strokeWidth: 1,
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(dataPoints.length, (i) {
                      return FlSpot(i.toDouble(), dataPoints[i].amount);
                    }),
                    isCurved: true,
                    curveSmoothness: 0.3,
                    color: const Color(0xFFFB923C),
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFFFB923C).withValues(alpha: 0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Text(
          'No expense data available',
          style: TextStyle(fontSize: 13.sp, color: const Color(0xFF9CA3AF)),
        ),
      ),
    );
  }

  String _formatAmount(double value) {
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(0)}K';
    return value.toStringAsFixed(0);
  }
}
