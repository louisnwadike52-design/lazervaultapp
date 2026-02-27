import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import '../../cubit/open_banking_cubit.dart';
import '../../cubit/open_banking_state.dart';
import '../../domain/entities/credit_score.dart';
import '../../domain/entities/credit_score_ai_insights.dart';

class CreditScoreScreen extends StatefulWidget {
  final String userId;
  final bool showAllSources;

  const CreditScoreScreen({
    super.key,
    required this.userId,
    this.showAllSources = false,
  });

  @override
  State<CreditScoreScreen> createState() => _CreditScoreScreenState();
}

class _CreditScoreScreenState extends State<CreditScoreScreen>
    with TickerProviderStateMixin {
  late AnimationController _gaugeController;
  late Animation<double> _gaugeAnimation;
  TabController? _tabController;
  MultiSourceCreditScores? _multiSourceScores;

  @override
  void initState() {
    super.initState();
    _gaugeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _gaugeAnimation = CurvedAnimation(
      parent: _gaugeController,
      curve: Curves.easeOutCubic,
    );

    if (widget.showAllSources) {
      _tabController = TabController(length: 3, vsync: this);
      _tabController!.addListener(() {
        if (!_tabController!.indexIsChanging) {
          _gaugeController.forward(from: 0);
        }
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.showAllSources) {
        context.read<OpenBankingCubit>().fetchMultiSourceCreditScores(
              userId: widget.userId,
            );
      } else {
        context.read<OpenBankingCubit>().fetchCreditScore(userId: widget.userId);
      }
    });
  }

  @override
  void dispose() {
    _gaugeController.dispose();
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Credit Score',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: widget.showAllSources && _tabController != null
            ? TabBar(
                controller: _tabController,
                indicatorColor: const Color(0xFF3B82F6),
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xFF9CA3AF),
                labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyle(fontSize: 13.sp),
                tabs: const [
                  Tab(text: 'LazerVault'),
                  Tab(text: 'External'),
                  Tab(text: 'Combined'),
                ],
              )
            : null,
      ),
      body: BlocConsumer<OpenBankingCubit, OpenBankingState>(
        listener: (context, state) {
          if (state is CreditScoreLoaded) {
            _gaugeController.forward(from: 0);
            context.read<OpenBankingCubit>().fetchCreditScoreHistory(
                  userId: widget.userId,
                );
            context.read<OpenBankingCubit>().fetchAICreditInsights(state.creditScore);
          }
          if (state is MultiSourceCreditScoresLoaded) {
            _multiSourceScores = state.scores;
            _gaugeController.forward(from: 0);
            // Fetch AI insights for the primary score (lazervault)
            context.read<OpenBankingCubit>().fetchAICreditInsights(
                  state.scores.lazervaultScore,
                );
          }
          if (state is OpenBankingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        buildWhen: (previous, current) =>
            current is CreditScoreLoaded ||
            current is MultiSourceCreditScoresLoaded ||
            current is CreditScoreHistoryLoaded ||
            current is CreditScoreRefreshing ||
            current is CreditScoreAIInsightsLoading ||
            current is CreditScoreAIInsightsLoaded ||
            current is CreditScoreAIInsightsError ||
            current is OpenBankingLoading ||
            current is OpenBankingError,
        builder: (context, state) {
          if (state is OpenBankingLoading || state is CreditScoreRefreshing) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (state is OpenBankingError) {
            return _buildErrorState(state);
          }

          // Multi-source tabbed view
          if (widget.showAllSources && _multiSourceScores != null) {
            return _buildTabbedContent(_multiSourceScores!);
          }
          if (state is MultiSourceCreditScoresLoaded) {
            _multiSourceScores = state.scores;
            return _buildTabbedContent(state.scores);
          }

          if (state is CreditScoreLoaded) {
            return _buildContent(state.creditScore, null);
          }

          if (state is CreditScoreHistoryLoaded) {
            return _buildContent(null, state.history);
          }

          // AI insights states - show content with cached score
          if (state is CreditScoreAIInsightsLoading ||
              state is CreditScoreAIInsightsLoaded ||
              state is CreditScoreAIInsightsError) {
            if (_multiSourceScores != null) {
              return _buildTabbedContent(_multiSourceScores!);
            }
            return _buildContent(null, null);
          }

          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        },
      ),
    );
  }

  // Keep track of last loaded score for when history loads
  CreditScoreEntity? _lastScore;

  Widget _buildTabbedContent(MultiSourceCreditScores scores) {
    return TabBarView(
      controller: _tabController,
      children: [
        // LazerVault tab — always available
        _buildScoreTab(scores.lazervaultScore),
        // External tab
        scores.externalScore != null
            ? _buildScoreTab(scores.externalScore!)
            : _buildLinkBankCTA(),
        // Combined tab
        scores.combinedScore != null
            ? _buildScoreTab(scores.combinedScore!)
            : _buildLinkBankCTA(),
      ],
    );
  }

  Widget _buildScoreTab(CreditScoreEntity score) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<OpenBankingCubit>().fetchMultiSourceCreditScores(
              userId: widget.userId,
            );
      },
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(16.r),
        children: [
          _buildGaugeCard(score),
          SizedBox(height: 20.h),
          _buildBreakdownCard(score),
          SizedBox(height: 20.h),
          if (score.tips.isNotEmpty) ...[
            _buildTipsSection(score.tips),
            SizedBox(height: 20.h),
          ],
          _buildAIInsightsSection(),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildLinkBankCTA() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_balance_outlined,
              color: const Color(0xFF9CA3AF),
              size: 64.r,
            ),
            SizedBox(height: 16.h),
            Text(
              'No Linked Bank Account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Link an external bank account to see your credit score from external transactions.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.add),
              label: const Text('Link a Bank Account'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(CreditScoreEntity? score, CreditScoreHistoryEntity? history) {
    if (score != null) _lastScore = score;
    final displayScore = score ?? _lastScore;

    if (displayScore == null) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<OpenBankingCubit>().refreshCreditScore(
              userId: widget.userId,
              linkedAccountId: displayScore.linkedAccountId,
            );
      },
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(16.r),
        children: [
          _buildGaugeCard(displayScore),
          SizedBox(height: 20.h),
          _buildBreakdownCard(displayScore),
          SizedBox(height: 20.h),
          if (history != null) ...[
            _buildHistoryChart(history),
            SizedBox(height: 20.h),
          ],
          if (displayScore.tips.isNotEmpty) ...[
            _buildTipsSection(displayScore.tips),
            SizedBox(height: 20.h),
          ],
          _buildAIInsightsSection(),
          _buildRefreshButton(displayScore),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildGaugeCard(CreditScoreEntity score) {
    final ratingColor = _getRatingColor(score.rating);

    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1F1F1F),
            ratingColor.withValues(alpha: 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 200.r,
            width: 200.r,
            child: AnimatedBuilder(
              animation: _gaugeAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: _CreditScoreGaugePainter(
                    score: score.score,
                    animationValue: _gaugeAnimation.value,
                    ratingColor: ratingColor,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${(score.score * _gaugeAnimation.value).round()}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 42.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'out of 850',
                          style: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: ratingColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              score.ratingLabel,
              style: TextStyle(
                color: ratingColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            score.sourceLabel.isNotEmpty
                ? score.sourceLabel
                : 'Based on ${score.bankName}',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '${score.transactionsAnalyzed} transactions · ${score.monthsOfData} months of data',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownCard(CreditScoreEntity score) {
    final factors = [
      _FactorData('Payment History', score.paymentHistoryScore, 35, Icons.payment),
      _FactorData('Income Stability', score.incomeStabilityScore, 25, Icons.trending_up),
      _FactorData('Spending Discipline', score.spendingDisciplineScore, 20, Icons.savings),
      _FactorData('Account Age', score.accountAgeScore, 10, Icons.calendar_today),
      _FactorData('Balance Consistency', score.balanceConsistencyScore, 10, Icons.account_balance),
    ];

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Score Breakdown',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),
          ...factors.map((f) => _buildFactorBar(f)),
        ],
      ),
    );
  }

  Widget _buildFactorBar(_FactorData factor) {
    final barColor = _getFactorColor(factor.score);

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        children: [
          Row(
            children: [
              Icon(factor.icon, color: barColor, size: 18.r),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  factor.label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Text(
                '${factor.score.round()}/100',
                style: TextStyle(
                  color: barColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '(${factor.weight}%)',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: (factor.score / 100).clamp(0.0, 1.0),
              backgroundColor: Colors.white.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation(barColor),
              minHeight: 6.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryChart(CreditScoreHistoryEntity history) {
    if (history.history.isEmpty) return const SizedBox.shrink();

    final spots = history.history.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.score.toDouble());
    }).toList();

    final minScore = history.history.map((h) => h.score).reduce(math.min).toDouble();
    final maxScore = history.history.map((h) => h.score).reduce(math.max).toDouble();
    final chartMin = (minScore - 50).clamp(300.0, 850.0);
    final chartMax = (maxScore + 50).clamp(300.0, 850.0);

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Score History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: history.scoreChange >= 0
                      ? const Color(0xFF10B981).withValues(alpha: 0.2)
                      : const Color(0xFFEF4444).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '${history.scoreChange >= 0 ? '+' : ''}${history.scoreChange} pts',
                  style: TextStyle(
                    color: history.scoreChange >= 0
                        ? const Color(0xFF10B981)
                        : const Color(0xFFEF4444),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 200.h,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: (chartMax - chartMin) > 0 ? (chartMax - chartMin) / 4 : 50,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.white.withValues(alpha: 0.05),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40.w,
                      getTitlesWidget: (value, meta) => Text(
                        value.toInt().toString(),
                        style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: history.history.length > 6
                          ? (history.history.length / 4).ceilToDouble()
                          : 1,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= history.history.length) {
                          return const SizedBox.shrink();
                        }
                        final point = history.history[index];
                        final months = [
                          'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                        ];
                        return Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            months[point.date.month - 1],
                            style: TextStyle(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 10.sp,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minY: chartMin,
                maxY: chartMax,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: const Color(0xFF3B82F6),
                    barWidth: 3,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) =>
                          FlDotCirclePainter(
                        radius: 3,
                        color: const Color(0xFF3B82F6),
                        strokeWidth: 2,
                        strokeColor: Colors.white,
                      ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
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

  Widget _buildTipsSection(List<CreditScoreTipEntity> tips) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Improvement Tips',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          ...tips.map((tip) => _buildTipCard(tip)),
        ],
      ),
    );
  }

  Widget _buildTipCard(CreditScoreTipEntity tip) {
    final categoryIcon = _getTipCategoryIcon(tip.category);
    final categoryColor = _getTipCategoryColor(tip.category);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: categoryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: categoryColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: categoryColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(categoryIcon, color: categoryColor, size: 20.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        tip.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '+${tip.potentialImpact} pts',
                        style: TextStyle(
                          color: const Color(0xFF10B981),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  tip.description,
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIInsightsSection() {
    return BlocBuilder<OpenBankingCubit, OpenBankingState>(
      buildWhen: (prev, curr) =>
          curr is CreditScoreAIInsightsLoading ||
          curr is CreditScoreAIInsightsLoaded ||
          curr is CreditScoreAIInsightsError,
      builder: (context, state) {
        // Loading shimmer
        if (state is CreditScoreAIInsightsLoading) {
          return Container(
            margin: EdgeInsets.only(bottom: 20.h),
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.auto_awesome, color: const Color(0xFF3B82F6), size: 20.r),
                    SizedBox(width: 8.w),
                    Text(
                      'AI Insights',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                ...[80.0, 60.0, 40.0].map((width) => Container(
                      height: 14.h,
                      width: width.w * 2,
                      margin: EdgeInsets.only(bottom: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    )),
                SizedBox(height: 8.h),
                Center(
                  child: SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: const CircularProgressIndicator(
                      color: Color(0xFF3B82F6),
                      strokeWidth: 2,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // Error state
        if (state is CreditScoreAIInsightsError) {
          return const SizedBox.shrink();
        }

        // Loaded state
        if (state is CreditScoreAIInsightsLoaded) {
          final insights = state.insights;
          return Column(
            children: [
              // Personalized summary card
              Container(
                margin: EdgeInsets.only(bottom: 20.h),
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF1F1F1F),
                      const Color(0xFF3B82F6).withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome, color: const Color(0xFF3B82F6), size: 20.r),
                        SizedBox(width: 8.w),
                        Text(
                          'AI Insights',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      insights.personalizedSummary,
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Factor analysis cards
              if (insights.factorAnalysis.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Factor Analysis',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      ...insights.factorAnalysis.map((fa) => _buildFactorAnalysisCard(fa)),
                    ],
                  ),
                ),

              // Recommendations
              if (insights.actionableRecommendations.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recommendations',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      ...insights.actionableRecommendations.asMap().entries.map(
                        (entry) => Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 24.r,
                                height: 24.r,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Center(
                                  child: Text(
                                    '${entry.key + 1}',
                                    style: TextStyle(
                                      color: const Color(0xFF3B82F6),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  entry.value,
                                  style: TextStyle(
                                    color: const Color(0xFF9CA3AF),
                                    fontSize: 13.sp,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Score projection & risk assessment
              if (insights.scoreProjection.isNotEmpty || insights.riskAssessment.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (insights.scoreProjection.isNotEmpty) ...[
                        Row(
                          children: [
                            Icon(Icons.trending_up, color: const Color(0xFF10B981), size: 18.r),
                            SizedBox(width: 8.w),
                            Text(
                              'Score Projection',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          insights.scoreProjection,
                          style: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 13.sp,
                            height: 1.4,
                          ),
                        ),
                      ],
                      if (insights.scoreProjection.isNotEmpty && insights.riskAssessment.isNotEmpty)
                        Divider(
                          color: Colors.white.withValues(alpha: 0.1),
                          height: 24.h,
                        ),
                      if (insights.riskAssessment.isNotEmpty) ...[
                        Row(
                          children: [
                            Icon(Icons.shield_outlined, color: const Color(0xFFFB923C), size: 18.r),
                            SizedBox(width: 8.w),
                            Text(
                              'Risk Assessment',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          insights.riskAssessment,
                          style: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 13.sp,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
            ],
          );
        }

        // Check for cached insights from cubit
        final cachedInsights = context.read<OpenBankingCubit>().cachedAIInsights;
        if (cachedInsights != null) {
          // Re-emit to rebuild with cached data
          return const SizedBox.shrink();
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildFactorAnalysisCard(FactorAnalysis fa) {
    final barColor = _getFactorColor(fa.score);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: barColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: barColor.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                fa.factor,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${fa.score.round()}/100',
                style: TextStyle(
                  color: barColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            fa.analysis,
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
              height: 1.4,
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb_outline, color: const Color(0xFFFB923C), size: 14.r),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  fa.recommendation,
                  style: TextStyle(
                    color: const Color(0xFFFB923C),
                    fontSize: 12.sp,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRefreshButton(CreditScoreEntity score) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          context.read<OpenBankingCubit>().refreshCreditScore(
                userId: widget.userId,
                linkedAccountId: score.linkedAccountId,
              );
        },
        icon: const Icon(Icons.refresh),
        label: const Text('Refresh Score'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B82F6),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(OpenBankingError state) {
    final isNoLinkedBank = state.message.toLowerCase().contains('no linked bank') ||
        state.message.toLowerCase().contains('linked account');

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isNoLinkedBank ? Icons.account_balance_rounded : Icons.error_outline,
              color: isNoLinkedBank ? const Color(0xFF3B82F6) : Colors.white60,
              size: 48.r,
            ),
            SizedBox(height: 16.h),
            Text(
              isNoLinkedBank
                  ? 'Link a bank account to generate your credit score'
                  : state.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
            if (isNoLinkedBank) ...[
              SizedBox(height: 8.h),
              Text(
                'We analyze your transaction history to calculate a personalized credit score with insights and tips.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF6B7280),
                  fontSize: 12.sp,
                ),
              ),
            ],
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () {
                if (isNoLinkedBank) {
                  Navigator.of(context).pop();
                } else {
                  context.read<OpenBankingCubit>().fetchCreditScore(
                        userId: widget.userId,
                      );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isNoLinkedBank
                    ? const Color(0xFF10B981)
                    : const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
              child: Text(isNoLinkedBank ? 'Go Back & Link Bank' : 'Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRatingColor(String rating) {
    return switch (rating) {
      'excellent' => const Color(0xFF10B981),
      'good' => const Color(0xFF3B82F6),
      'fair' => const Color(0xFFFB923C),
      'poor' => const Color(0xFFEF4444),
      _ => const Color(0xFF9CA3AF),
    };
  }

  Color _getFactorColor(double score) {
    if (score >= 80) return const Color(0xFF10B981);
    if (score >= 60) return const Color(0xFF3B82F6);
    if (score >= 40) return const Color(0xFFFB923C);
    return const Color(0xFFEF4444);
  }

  IconData _getTipCategoryIcon(String category) {
    return switch (category) {
      'payment' => Icons.payment,
      'income' => Icons.trending_up,
      'spending' => Icons.savings,
      'balance' => Icons.account_balance,
      _ => Icons.lightbulb_outline,
    };
  }

  Color _getTipCategoryColor(String category) {
    return switch (category) {
      'payment' => const Color(0xFF3B82F6),
      'income' => const Color(0xFF10B981),
      'spending' => const Color(0xFFFB923C),
      'balance' => const Color(0xFF8B5CF6),
      _ => const Color(0xFF9CA3AF),
    };
  }
}

class _FactorData {
  final String label;
  final double score;
  final int weight;
  final IconData icon;

  const _FactorData(this.label, this.score, this.weight, this.icon);
}

class _CreditScoreGaugePainter extends CustomPainter {
  final int score;
  final double animationValue;
  final Color ratingColor;

  _CreditScoreGaugePainter({
    required this.score,
    required this.animationValue,
    required this.ratingColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 12;

    // Background arc
    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    const startAngle = 2.4; // ~137 degrees
    const sweepAngle = 4.3; // ~246 degrees (total arc)

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      bgPaint,
    );

    // Score arc
    final scorePercent = ((score - 300) / 550).clamp(0.0, 1.0);
    final scoreSweep = sweepAngle * scorePercent * animationValue;

    final scorePaint = Paint()
      ..shader = SweepGradient(
        center: Alignment.center,
        colors: [
          ratingColor.withValues(alpha: 0.6),
          ratingColor,
        ],
        startAngle: startAngle,
        endAngle: startAngle + scoreSweep,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    if (scoreSweep > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        scoreSweep,
        false,
        scorePaint,
      );
    }

    // Scale labels
    final textStyle = TextStyle(
      color: Colors.white.withValues(alpha: 0.4),
      fontSize: 10,
    );
    final labels = ['300', '450', '600', '750', '850'];
    final angles = [startAngle, startAngle + sweepAngle * 0.27, startAngle + sweepAngle * 0.545, startAngle + sweepAngle * 0.818, startAngle + sweepAngle];
    final labelRadius = radius + 20;

    for (var i = 0; i < labels.length; i++) {
      final x = center.dx + labelRadius * math.cos(angles[i]);
      final y = center.dy + labelRadius * math.sin(angles[i]);
      final tp = TextPainter(
        text: TextSpan(text: labels[i], style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant _CreditScoreGaugePainter oldDelegate) {
    return oldDelegate.score != score ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.ratingColor != ratingColor;
  }
}
