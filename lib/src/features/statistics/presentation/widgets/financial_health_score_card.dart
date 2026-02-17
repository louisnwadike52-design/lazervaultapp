import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Data class holding the inputs needed to compute a financial health score.
class FinancialHealthData {
  final double totalIncome;
  final double totalExpenses;
  final double incomeChangePercent;
  final double expenseChangePercent;

  /// Budget items: each has (spentAmount, budgetAmount).
  /// Empty list if no budgets are set.
  final List<({double spent, double budget})> budgetItems;

  const FinancialHealthData({
    required this.totalIncome,
    required this.totalExpenses,
    required this.incomeChangePercent,
    required this.expenseChangePercent,
    this.budgetItems = const [],
  });

  double get savingsRate =>
      totalIncome > 0 ? (totalIncome - totalExpenses) / totalIncome * 100 : 0;
}

/// Breakdown of the financial health score into individual factors.
class _ScoreBreakdown {
  final int total;
  final int savingsScore;
  final int budgetScore;
  final int expenseTrendScore;
  final int incomeTrendScore;

  const _ScoreBreakdown({
    required this.total,
    required this.savingsScore,
    required this.budgetScore,
    required this.expenseTrendScore,
    required this.incomeTrendScore,
  });
}

/// Computes a financial health score (0-100) from multiple factors.
///
/// Scoring weights:
/// - Savings rate: 0-35 points
/// - Budget adherence: 0-25 points
/// - Expense trend: 0-20 points
/// - Income trend: 0-20 points
_ScoreBreakdown _computeScore(FinancialHealthData data) {
  // --- Savings rate factor (0-35) ---
  final sr = data.savingsRate;
  int savingsScore;
  if (sr >= 30) {
    savingsScore = 35;
  } else if (sr >= 20) {
    savingsScore = 30;
  } else if (sr >= 15) {
    savingsScore = 25;
  } else if (sr >= 10) {
    savingsScore = 20;
  } else if (sr >= 5) {
    savingsScore = 12;
  } else if (sr >= 0) {
    savingsScore = 5;
  } else {
    // Negative savings (spending more than earning)
    savingsScore = 0;
  }

  // --- Budget adherence factor (0-25) ---
  int budgetScore;
  if (data.budgetItems.isEmpty) {
    // No budgets set — give partial credit (they haven't overspent anything)
    budgetScore = 15;
  } else {
    int withinBudget = 0;
    for (final item in data.budgetItems) {
      if (item.budget > 0 && item.spent <= item.budget) {
        withinBudget++;
      }
    }
    final adherenceRate = withinBudget / data.budgetItems.length;
    budgetScore = (adherenceRate * 25).round();
  }

  // --- Expense trend factor (0-20) ---
  // Lower/decreasing expenses = better
  final ec = data.expenseChangePercent;
  int expenseTrendScore;
  if (ec <= -10) {
    expenseTrendScore = 20; // Expenses dropped significantly
  } else if (ec <= -5) {
    expenseTrendScore = 18;
  } else if (ec <= 0) {
    expenseTrendScore = 16;
  } else if (ec <= 5) {
    expenseTrendScore = 14; // Slight increase — still OK
  } else if (ec <= 10) {
    expenseTrendScore = 10;
  } else if (ec <= 20) {
    expenseTrendScore = 5;
  } else {
    expenseTrendScore = 0; // Expenses surging
  }

  // --- Income trend factor (0-20) ---
  // Growing/stable income = better
  final ic = data.incomeChangePercent;
  int incomeTrendScore;
  if (ic >= 15) {
    incomeTrendScore = 20;
  } else if (ic >= 10) {
    incomeTrendScore = 18;
  } else if (ic >= 5) {
    incomeTrendScore = 16;
  } else if (ic >= 0) {
    incomeTrendScore = 14;
  } else if (ic >= -5) {
    incomeTrendScore = 10;
  } else if (ic >= -15) {
    incomeTrendScore = 5;
  } else {
    incomeTrendScore = 0;
  }

  final total = savingsScore + budgetScore + expenseTrendScore + incomeTrendScore;
  return _ScoreBreakdown(
    total: total.clamp(0, 100),
    savingsScore: savingsScore,
    budgetScore: budgetScore,
    expenseTrendScore: expenseTrendScore,
    incomeTrendScore: incomeTrendScore,
  );
}

/// Returns a color representing the health score tier.
Color _scoreColor(int score) {
  if (score >= 80) return const Color(0xFF10B981); // Green — Excellent
  if (score >= 60) return const Color(0xFF3B82F6); // Blue — Good
  if (score >= 40) return const Color(0xFFFB923C); // Orange — Fair
  return const Color(0xFFEF4444); // Red — Needs attention
}

/// Returns a label for the health score tier.
String _scoreLabel(int score) {
  if (score >= 80) return 'Excellent';
  if (score >= 60) return 'Good';
  if (score >= 40) return 'Fair';
  return 'Needs Attention';
}

/// Financial Health Score Card
///
/// Displays a composite financial health score (0-100) with animated circular
/// progress, color-coded rating, and a breakdown of contributing factors.
class FinancialHealthScoreCard extends StatefulWidget {
  final FinancialHealthData data;
  final VoidCallback? onTap;

  const FinancialHealthScoreCard({
    super.key,
    required this.data,
    this.onTap,
  });

  @override
  State<FinancialHealthScoreCard> createState() =>
      _FinancialHealthScoreCardState();
}

class _FinancialHealthScoreCardState extends State<FinancialHealthScoreCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  _ScoreBreakdown? _previousBreakdown;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _controller.forward();
  }

  @override
  void didUpdateWidget(FinancialHealthScoreCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldScore = _computeScore(oldWidget.data).total;
    final newScore = _computeScore(widget.data).total;
    if (oldScore != newScore) {
      _previousBreakdown = _computeScore(oldWidget.data);
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final breakdown = _computeScore(widget.data);
    final score = breakdown.total;
    final color = _scoreColor(score);
    final label = _scoreLabel(score);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            // Header row
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.favorite, color: color, size: 18.sp),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Financial Health',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        label,
                        style: TextStyle(
                          color: color,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.onTap != null)
                  Icon(
                    Icons.chevron_right,
                    color: const Color(0xFF9CA3AF),
                    size: 20.sp,
                  ),
              ],
            ),
            SizedBox(height: 20.h),

            // Score ring + factors
            Row(
              children: [
                // Animated circular score
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    final prevScore = _previousBreakdown?.total ?? 0;
                    final animatedScore = _previousBreakdown != null
                        ? (prevScore + (score - prevScore) * _animation.value)
                        : score * _animation.value;
                    return SizedBox(
                      width: 100.w,
                      height: 100.w,
                      child: CustomPaint(
                        painter: _ScoreRingPainter(
                          score: animatedScore,
                          color: color,
                          trackColor: Colors.white.withValues(alpha: 0.08),
                          strokeWidth: 8.w,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                animatedScore.round().toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.bold,
                                  height: 1,
                                ),
                              ),
                              Text(
                                'of 100',
                                style: TextStyle(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 11.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(width: 20.w),

                // Score factors
                Expanded(
                  child: Column(
                    children: [
                      _ScoreFactor(
                        label: 'Savings Rate',
                        score: breakdown.savingsScore,
                        maxScore: 35,
                        color: const Color(0xFF10B981),
                      ),
                      SizedBox(height: 8.h),
                      _ScoreFactor(
                        label: 'Budget Adherence',
                        score: breakdown.budgetScore,
                        maxScore: 25,
                        color: const Color(0xFF3B82F6),
                      ),
                      SizedBox(height: 8.h),
                      _ScoreFactor(
                        label: 'Expense Trend',
                        score: breakdown.expenseTrendScore,
                        maxScore: 20,
                        color: const Color(0xFFF59E0B),
                      ),
                      SizedBox(height: 8.h),
                      _ScoreFactor(
                        label: 'Income Trend',
                        score: breakdown.incomeTrendScore,
                        maxScore: 20,
                        color: const Color(0xFF8B5CF6),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Renders a single score factor row with label, mini progress bar, and points.
class _ScoreFactor extends StatelessWidget {
  final String label;
  final int score;
  final int maxScore;
  final Color color;

  const _ScoreFactor({
    required this.label,
    required this.score,
    required this.maxScore,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = maxScore > 0 ? (score / maxScore).clamp(0.0, 1.0) : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
              ),
            ),
            Text(
              '$score/$maxScore',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 3.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(2.r),
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: 4.h,
            backgroundColor: Colors.white.withValues(alpha: 0.08),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

/// Custom painter for the circular score ring.
class _ScoreRingPainter extends CustomPainter {
  final double score;
  final Color color;
  final Color trackColor;
  final double strokeWidth;

  _ScoreRingPainter({
    required this.score,
    required this.color,
    required this.trackColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    const startAngle = -math.pi / 2; // Start from top
    final sweepAngle = (score / 100) * 2 * math.pi;

    // Track (background ring)
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    // Score arc
    if (score > 0) {
      final scorePaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        scorePaint,
      );
    }
  }

  @override
  bool shouldRepaint(_ScoreRingPainter oldDelegate) =>
      oldDelegate.score != score || oldDelegate.color != color;
}
