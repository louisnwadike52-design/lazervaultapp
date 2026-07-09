import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class ProductivityInsightsScreen extends StatefulWidget {
  const ProductivityInsightsScreen({super.key});

  @override
  State<ProductivityInsightsScreen> createState() =>
      _ProductivityInsightsScreenState();
}

class _ProductivityInsightsScreenState
    extends State<ProductivityInsightsScreen> {
  String _period = 'week';
  Map<String, dynamic>? _insights; // real data from the planning backend

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    context.read<PlanMyDayCubit>().loadProductivityInsights(period: _period);
  }

  // Map the backend score band ("low"/"medium"/"high") or numeric score to a
  // 0..1 progress value for the ring.
  double _scoreFraction() {
    final score = _insights?['productivity_score'];
    if (score is num) {
      // numeric 0..100
      return (score / 100).clamp(0.0, 1.0);
    }
    switch ((score ?? '').toString().toLowerCase()) {
      case 'high':
        return 0.85;
      case 'medium':
        return 0.55;
      case 'low':
        return 0.25;
      default:
        return 0.0;
    }
  }

  String _scoreLabel() {
    final score = _insights?['productivity_score'];
    if (score is num) return score.round().toString();
    final s = (score ?? '').toString();
    if (s.isEmpty) return '0';
    return s[0].toUpperCase() + s.substring(1);
  }

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
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.tune, color: Colors.white),
            color: const Color(0xFF1F1F1F),
            onSelected: (value) {
              setState(() => _period = value);
              _load();
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 'week',
                child: Text('This Week', style: TextStyle(color: Colors.white)),
              ),
              PopupMenuItem(
                value: 'month',
                child:
                    Text('This Month', style: TextStyle(color: Colors.white)),
              ),
              PopupMenuItem(
                value: 'quarter',
                child: Text('This Quarter',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
      body: BlocListener<PlanMyDayCubit, PlanMyDayState>(
        listener: (context, state) {
          if (state is ProductivityInsightsLoaded) {
            setState(() => _insights = state.insights);
          }
        },
        child: BlocBuilder<PlanMyDayCubit, PlanMyDayState>(
          builder: (context, state) {
            if (state is PlanMyDayLoading && _insights == null) {
              return const Center(
                child: LazerVaultLoader.small(),
              );
            }
            if (state is PlanMyDayError && _insights == null) {
              return _buildError(state.message);
            }
            if (_insights == null) {
              return _buildEmpty();
            }
            return _buildContent();
          },
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Color(0xFFEF4444), size: 48),
            SizedBox(height: 16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: _load,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.insights_outlined,
                color: Colors.grey[600], size: 48),
            SizedBox(height: 16.h),
            Text(
              'Not enough activity yet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Complete tasks and plan your days to unlock productivity insights.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[400], fontSize: 13.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    final strengths =
        (_insights?['strength_areas'] as List?)?.cast<dynamic>() ?? const [];
    final improvements =
        (_insights?['improvement_areas'] as List?)?.cast<dynamic>() ?? const [];
    final insightCards =
        (_insights?['insights'] as List?)?.cast<dynamic>() ?? const [];

    return RefreshIndicator(
      color: const Color(0xFF10B981),
      backgroundColor: const Color(0xFF1F1F1F),
      onRefresh: () async => _load(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductivityScoreCard(),
            SizedBox(height: 20.h),
            if (strengths.isNotEmpty) ...[
              _buildListCard(
                title: 'Strength Areas',
                icon: Icons.star,
                iconColor: const Color(0xFFF59E0B),
                items: strengths.map((e) => e.toString()).toList(),
              ),
              SizedBox(height: 20.h),
            ],
            if (improvements.isNotEmpty) ...[
              _buildListCard(
                title: 'Areas to Improve',
                icon: Icons.trending_up,
                iconColor: const Color(0xFFEF4444),
                items: improvements.map((e) => e.toString()).toList(),
              ),
              SizedBox(height: 20.h),
            ],
            if (insightCards.isNotEmpty)
              _buildInsightsCard(insightCards)
            else
              _buildNoInsightsHint(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductivityScoreCard() {
    final trend = (_insights?['score_trend'] ?? '').toString();
    final period = (_insights?['period'] ?? _period).toString();
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
                    _scoreLabel(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'for this $period',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 100.w,
                height: 100.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 88.w,
                      height: 88.w,
                      child: CircularProgressIndicator(
                        value: _scoreFraction(),
                        strokeWidth: 8,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    Text(
                      '${(_scoreFraction() * 100).round()}%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (trend.trim().isNotEmpty) ...[
            SizedBox(height: 16.h),
            Row(
              children: [
                const Icon(Icons.trending_up, color: Colors.white, size: 16),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    trend,
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildListCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<String> items,
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
          ...items.map((item) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 6.h),
                      child: Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: BoxDecoration(
                          color: iconColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildInsightsCard(List<dynamic> insightCards) {
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
              const Icon(
                Icons.psychology_outlined,
                color: Color(0xFF8B5CF6),
                size: 24,
              ),
              SizedBox(width: 12.w),
              Text(
                'Insights & Suggestions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...insightCards.map((raw) {
            final card = (raw as Map).cast<String, dynamic>();
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: _buildInsightItem(
                (card['title'] ?? '').toString(),
                (card['description'] ?? '').toString(),
                (card['actionable_tip'] ?? '').toString(),
                (card['type'] ?? 'suggestion').toString(),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildNoInsightsHint() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb_outline, color: Colors.grey[500], size: 22),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Keep planning your days. Tailored suggestions appear once there is enough activity to analyze.',
              style: TextStyle(color: Colors.grey[400], fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(
      String title, String description, String tip, String type) {
    final color = switch (type.toLowerCase()) {
      'achievement' => const Color(0xFF10B981),
      'warning' => const Color(0xFFEF4444),
      'pattern' => const Color(0xFF3B82F6),
      _ => const Color(0xFF8B5CF6),
    };
    final icon = switch (type.toLowerCase()) {
      'achievement' => Icons.emoji_events_outlined,
      'warning' => Icons.warning_amber_outlined,
      'pattern' => Icons.insights_outlined,
      _ => Icons.tips_and_updates_outlined,
    };
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title.isNotEmpty)
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (description.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Text(
                    description,
                    style: TextStyle(color: Colors.grey[400], fontSize: 12.sp),
                  ),
                ),
              if (tip.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    tip,
                    style: TextStyle(
                      color: color,
                      fontSize: 12.sp,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
