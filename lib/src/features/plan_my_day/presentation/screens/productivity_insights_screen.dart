import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductivityInsightsScreen extends StatelessWidget {
  const ProductivityInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
        title: const Text(
          'Productivity Insights',
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Productivity Score Card
            _buildProductivityScoreCard(),
            SizedBox(height: 20.h),

            // Weekly Trend
            _buildWeeklyTrendCard(),
            SizedBox(height: 20.h),

            // Strength Areas
            _buildAreasCard(
              title: 'Strength Areas',
              icon: Icons.star,
              iconColor: const Color(0xFFF59E0B),
              areas: [
                {'name': 'Task Completion', 'value': '85%', 'trend': '+12%'},
                {'name': 'Focus Time', 'value': '6.2h/day', 'trend': '+8%'},
                {'name': 'Consistency', 'value': '5 day streak', 'trend': 'Personal best!'},
              ],
            ),
            SizedBox(height: 20.h),

            // Improvement Areas
            _buildAreasCard(
              title: 'Areas to Improve',
              icon: Icons.trending_up,
              iconColor: const Color(0xFFEF4444),
              areas: [
                {'name': 'Meeting Efficiency', 'value': '62%', 'trend': '-5%'},
                {'name': 'Break Taking', 'value': '1.2/day', 'trend': 'Too few'},
                {'name': 'Task Estimation', 'value': 'Off by 30%', 'trend': 'Needs work'},
              ],
            ),
            SizedBox(height: 20.h),

            // AI Suggestions
            _buildSuggestionsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductivityScoreCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Productivity Score',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '78',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        width: 80.w,
                        height: 80.w,
                        child: CircularProgressIndicator(
                          value: 0.78,
                          strokeWidth: 8,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Icon(Icons.arrow_upward, color: Colors.white, size: 16),
              SizedBox(width: 4.w),
              Text(
                '+8 points from last week',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyTrendCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Trend',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 150.h,
            child: _buildSimpleChart(),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleChart() {
    // Simple bar chart using containers
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final values = [65, 78, 82, 70, 85, 60, 45];
    final maxVal = 100.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(days.length, (index) {
        final value = values[index] / maxVal;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24.w,
              height: 100.h * value,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF3B82F6),
                    value > 0.7 ? const Color(0xFF10B981) : const Color(0xFF8B5CF6),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(4.r),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              days[index],
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12.sp,
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildAreasCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<Map<String, String>> areas,
  }) {
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
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              SizedBox(width: 12.w),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...areas.map((area) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: _buildAreaItem(area),
              )),
        ],
      ),
    );
  }

  Widget _buildAreaItem(Map<String, String> area) {
    return Row(
      children: [
        Expanded(
          child: Text(
            area['name']!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        ),
        Text(
          area['value']!,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: area['trend']!.contains('+')
                ? const Color(0xFF10B981).withOpacity(0.2)
                : area['trend']!.contains('-')
                    ? const Color(0xFFEF4444).withOpacity(0.2)
                    : const Color(0xFF3B82F6).withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            area['trend']!,
            style: TextStyle(
              color: area['trend']!.contains('+')
                  ? const Color(0xFF10B981)
                  : area['trend']!.contains('-')
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF3B82F6),
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
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
              Icon(
                Icons.psychology_outlined,
                color: const Color(0xFF8B5CF6),
                size: 24,
              ),
              SizedBox(width: 12.w),
              Text(
                'AI-Powered Suggestions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildSuggestionItem(
            'Schedule deep work sessions',
            'Your peak productivity is 9-11 AM. Block this time for important tasks.',
            Icons.access_time,
          ),
          SizedBox(height: 12.h),
          _buildSuggestionItem(
            'Take more breaks',
            'You\'ve been working 2+ hours without breaks. Try the Pomodoro technique.',
            Icons.free_breakfast,
          ),
          SizedBox(height: 12.h),
          _buildSuggestionItem(
            'Rebalance your week',
            'You\'re overloading Thursdays. Consider moving some tasks to Tuesday.',
            Icons.balance,
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionItem(String title, String description, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: const Color(0xFF8B5CF6).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: const Color(0xFF8B5CF6), size: 18),
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
}
