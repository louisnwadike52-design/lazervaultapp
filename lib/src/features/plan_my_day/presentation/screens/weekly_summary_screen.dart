import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/plan_my_day/domain/entities/daily_summary.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_state.dart';

class WeeklySummaryScreen extends StatefulWidget {
  const WeeklySummaryScreen({super.key});

  @override
  State<WeeklySummaryScreen> createState() => _WeeklySummaryScreenState();
}

class _WeeklySummaryScreenState extends State<WeeklySummaryScreen> {
  late DateTime _currentWeekStart;

  @override
  void initState() {
    super.initState();
    _currentWeekStart = _getStartOfWeek(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
        title: const Text(
          'Weekly Summary',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.white),
            onPressed: () {
              setState(() {
                _currentWeekStart = _currentWeekStart.subtract(const Duration(days: 7));
              });
            },
          ),
          Text(
            _formatWeekRange(),
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 14.sp,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: Colors.white),
            onPressed: () {
              setState(() {
                _currentWeekStart = _currentWeekStart.add(const Duration(days: 7));
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<PlanMyDayCubit, PlanMyDayState>(
        builder: (context, state) {
          // Show loading or weekly summary data
          return _buildWeeklySummary();
        },
      ),
    );
  }

  Widget _buildWeeklySummary() {
    // Generate daily summaries for the week
    final dailySummaries = List.generate(7, (index) {
      final date = _currentWeekStart.add(Duration(days: index));
      return {
        'date': date,
        'dayName': DateFormat('E').format(date),
        'isToday': _isSameDay(date, DateTime.now()),
      };
    });

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Weekly Overview Card
          _buildWeeklyOverviewCard(),
          SizedBox(height: 20.h),

          // Daily Progress
          Text(
            'Daily Progress',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          ...dailySummaries.map((dayData) => _buildDayRow(dayData)).toList(),
          SizedBox(height: 20.h),

          // Productivity Insights
          _buildProductivityInsights(),
        ],
      ),
    );
  }

  Widget _buildWeeklyOverviewCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF3B82F6).withOpacity(0.2), const Color(0xFF8B5CF6).withOpacity(0.2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF3B82F6).withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.bar_chart,
                  color: const Color(0xFF3B82F6),
                  size: 24,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'This Week',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '12 of 18 tasks completed',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Progress bar
          Container(
            height: 8.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.67,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Focus Time', '18h 30m', Icons.timer_outlined),
              _buildStatItem('Events', '8', Icons.event),
              _buildStatItem('Streak', '5 days', Icons.local_fire_department),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF3B82F6), size: 20),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildDayRow(Map<String, dynamic> dayData) {
    final date = dayData['date'] as DateTime;
    final dayName = dayData['dayName'] as String;
    final isToday = dayData['isToday'] as bool;

    // Simulated completion data (in real app, fetch from API)
    final completion = _getSimulatedCompletion(date);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isToday ? const Color(0xFF2D2D2D).withOpacity(0.5) : const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: isToday
            ? Border.all(color: const Color(0xFF3B82F6).withOpacity(0.5))
            : null,
      ),
      child: Row(
        children: [
          // Day indicator
          Container(
            width: 40.w,
            alignment: Alignment.center,
            child: Text(
              dayName.substring(0, 1),
              style: TextStyle(
                color: isToday ? const Color(0xFF3B82F6) : Colors.grey[400],
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Date
          Text(
            '${date.day}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(width: 16.w),
          // Progress bar
          Expanded(
            child: Container(
              height: 6.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(3.r),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: completion,
                child: Container(
                  decoration: BoxDecoration(
                    color: completion >= 0.8
                        ? const Color(0xFF10B981)
                        : completion >= 0.5
                            ? const Color(0xFFF59E0B)
                            : const Color(0xFFEF4444),
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          // Percentage
          Text(
            '${(completion * 100).toInt()}%',
            style: TextStyle(
              color: completion >= 0.8
                  ? const Color(0xFF10B981)
                  : completion >= 0.5
                      ? const Color(0xFFF59E0B)
                      : const Color(0xFFEF4444),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductivityInsights() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: const Color(0xFFF59E0B),
                size: 24,
              ),
              SizedBox(width: 12.w),
              Text(
                'Productivity Insights',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildInsightItem(
            icon: Icons.trending_up,
            color: const Color(0xFF10B981),
            title: 'Great momentum!',
            description: 'You\'re 20% more productive than last week',
          ),
          SizedBox(height: 12.h),
          _buildInsightItem(
            icon: Icons.schedule,
            color: const Color(0xFF3B82F6),
            title: 'Peak hours: 9 AM - 12 PM',
            description: 'Schedule important tasks during this time',
          ),
          SizedBox(height: 12.h),
          _buildInsightItem(
            icon: Icons.category,
            color: const Color(0xFF8B5CF6),
            title: 'Top category: Work',
            description: '12 tasks completed this week',
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem({
    required IconData icon,
    required Color color,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  DateTime _getStartOfWeek(DateTime date) {
    final day = date.weekday;
    final startOfWeek = date.subtract(Duration(days: day - 1));
    return DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String _formatWeekRange() {
    final endOfWeek = _currentWeekStart.add(const Duration(days: 6));
    return '${DateFormat('MMM d').format(_currentWeekStart)} - ${DateFormat('MMM d').format(endOfWeek)}';
  }

  double _getSimulatedCompletion(DateTime date) {
    // Simulated completion rates for demo
    final dayOfWeek = date.weekday;
    final completions = [0.8, 0.6, 0.9, 0.5, 0.7, 0.4, 0.3];
    return completions[dayOfWeek - 1];
  }
}
