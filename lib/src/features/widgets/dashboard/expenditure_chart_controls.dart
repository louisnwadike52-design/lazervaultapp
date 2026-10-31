import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'expenditure_chart.dart';
import 'expenditure_chart_type.dart';

/// The chart-shape cycle button.
///
/// A single tap advances to the next shape the data can draw, which is what
/// makes this a CTA rather than a menu: the user discovers the shapes by
/// using it, with no list to read first. It shows the shape it will become —
/// not the current one — because a button that displays the present state
/// reads as a status chip and gets ignored.
class ExpenditureChartCta extends StatelessWidget {
  const ExpenditureChartCta({
    super.key,
    required this.next,
    required this.onTap,
    this.onLongPress,
  });

  /// The shape a tap will switch TO.
  final ExpenditureChartType next;
  final VoidCallback onTap;

  /// Long-press opens the full picker. Optional, because the tap cycle is the
  /// documented interaction and this is a shortcut for someone who has
  /// already worked out that there are several.
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Change chart to ${next.label}',
      child: Tooltip(
        message: 'Show as ${next.label}',
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(20.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(next.icon, size: 14.sp, color: Colors.white),
                SizedBox(width: 5.w),
                Text(
                  next.label,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The info affordance beside the CTA.
class ExpenditureChartInfoButton extends StatelessWidget {
  const ExpenditureChartInfoButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'What this chart shows',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Padding(
          padding: EdgeInsets.all(6.w),
          child: Icon(
            Icons.info_outline_rounded,
            size: 17.sp,
            color: Colors.white.withValues(alpha: 0.75),
          ),
        ),
      ),
    );
  }
}

/// Colour key for a category chart.
///
/// Only shown for the share shapes: a trend chart has one series, and a legend
/// reading "Spending" beside a single white line is noise. For the share
/// shapes it is load-bearing — the pie hides the percentage on any slice under
/// 8% (printing it would overlap its neighbours), so without this the small
/// categories would have no label anywhere.
///
/// Colour comes from [expenditureCategoryColor] by INDEX, the same call the
/// chart makes, so a category cannot be one colour in the pie and another in
/// the key.
class ExpenditureChartLegend extends StatelessWidget {
  const ExpenditureChartLegend({
    super.key,
    required this.categories,
    required this.currencySymbol,
    this.maxItems = 6,
  });

  final List<ExpenditureSlice> categories;
  final String currencySymbol;

  /// Beyond this, the tail is summarised as "+N more" rather than wrapping the
  /// legend into three rows and pushing the card taller than the chart.
  final int maxItems;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();
    final shown = categories.take(maxItems).toList();
    final hidden = categories.length - shown.length;

    return Wrap(
      spacing: 10.w,
      runSpacing: 6.h,
      children: [
        for (var i = 0; i < shown.length; i++)
          _swatch(
            color: expenditureCategoryColor(i),
            label: shown[i].name,
            amount: compactMoney(shown[i].amount, currencySymbol),
          ),
        if (hidden > 0)
          Text(
            '+$hidden more',
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.white.withValues(alpha: 0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  Widget _swatch({
    required Color color,
    required String label,
    required String amount,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 5.w),
        // Capped so one long category name cannot push the amount off the row.
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 96.w),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.white.withValues(alpha: 0.85),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          amount,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

/// Bottom sheet explaining the chart currently on screen.
///
/// Follows the same shape as `statistics_source_sheet` — dark ground, grab
/// handle, title, then rows — so the dashboard and the budgeting tab explain
/// themselves the same way.
///
/// It answers the three questions the card itself cannot: what this shape is
/// for, what the colours mean, and where the figures come from. The last one
/// matters more than it looks: the card is scoped to the ACTIVE account and
/// its currency, so a user swiping to a GBP wallet is seeing different data
/// from a moment ago and nothing on the card says so.
Future<void> showExpenditureChartInfoSheet(
  BuildContext context, {
  required ExpenditureChartType type,
  required List<ExpenditureSlice> categories,
  required String currencySymbol,
  required String periodTitle,
  required String dateRange,
  required int transactionCount,
  required double totalSpent,
  required List<ExpenditureChartType> available,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xFF1F1F1F),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (ctx) => _InfoSheet(
      type: type,
      categories: categories,
      currencySymbol: currencySymbol,
      periodTitle: periodTitle,
      dateRange: dateRange,
      transactionCount: transactionCount,
      totalSpent: totalSpent,
      available: available,
    ),
  );
}

class _InfoSheet extends StatelessWidget {
  const _InfoSheet({
    required this.type,
    required this.categories,
    required this.currencySymbol,
    required this.periodTitle,
    required this.dateRange,
    required this.transactionCount,
    required this.totalSpent,
    required this.available,
  });

  final ExpenditureChartType type;
  final List<ExpenditureSlice> categories;
  final String currencySymbol;
  final String periodTitle;
  final String dateRange;
  final int transactionCount;
  final double totalSpent;
  final List<ExpenditureChartType> available;

  static const _dim = Color(0xFF9CA3AF);

  @override
  Widget build(BuildContext context) {
    final total = categories.fold<double>(0, (a, c) => a + c.amount);

    return SafeArea(
      child: ConstrainedBox(
        // The category list can be long; the sheet scrolls rather than
        // growing past the screen.
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              Row(
                children: [
                  Icon(type.icon, color: Colors.white, size: 18.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      '${type.label} chart',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Text(
                type.explanation,
                style: TextStyle(color: _dim, fontSize: 13.sp, height: 1.45),
              ),
              SizedBox(height: 18.h),

              _sectionTitle('This period'),
              SizedBox(height: 8.h),
              _row('Period', '$periodTitle · $dateRange'),
              _row('Total spent', compactMoney(totalSpent, currencySymbol)),
              _row('Transactions', '$transactionCount'),
              _row(
                'Shown in',
                '$currencySymbol — your active account’s currency',
              ),
              SizedBox(height: 6.h),
              Text(
                // The single most confusing thing about this card, said plainly.
                'The figures follow the account you have selected on the '
                'dashboard. Swipe to another account and this card reloads for '
                'that wallet and its currency.',
                style: TextStyle(color: _dim, fontSize: 11.5.sp, height: 1.4),
              ),

              if (categories.isNotEmpty) ...[
                SizedBox(height: 20.h),
                _sectionTitle('What the colours mean'),
                SizedBox(height: 4.h),
                Text(
                  type.isCategoryChart
                      ? 'Each category keeps the same colour across the pie, '
                          'donut and radar.'
                      : 'These are the categories behind the trend. Switch to '
                          'Pie or Donut to see them plotted by share.',
                  style: TextStyle(color: _dim, fontSize: 11.5.sp),
                ),
                SizedBox(height: 10.h),
                for (var i = 0; i < categories.length; i++)
                  _categoryRow(i, categories[i], total),
              ],

              SizedBox(height: 20.h),
              _sectionTitle('Chart shapes available'),
              SizedBox(height: 4.h),
              Text(
                // Explains the absences rather than leaving them a mystery:
                // "why is there no pie today" is otherwise unanswerable.
                'Tap the button on the card to cycle through these. A shape '
                'only appears when this period has the data it needs — a pie '
                'needs categories, a radar needs at least '
                '$kRadarMinCategories.',
                style: TextStyle(color: _dim, fontSize: 11.5.sp, height: 1.4),
              ),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  for (final t in ExpenditureChartType.values)
                    _shapeChip(t, enabled: available.contains(t)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) => Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 13.sp,
          fontWeight: FontWeight.w700,
        ),
      );

  Widget _row(String label, String value) => Padding(
        padding: EdgeInsets.only(bottom: 6.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 96.w,
              child: Text(
                label,
                style: TextStyle(color: _dim, fontSize: 12.sp),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _categoryRow(int index, ExpenditureSlice slice, double total) {
    final pct = total <= 0 ? 0 : (slice.amount / total * 100);
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: expenditureCategoryColor(index),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              slice.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            '${pct.toStringAsFixed(pct >= 10 ? 0 : 1)}%',
            style: TextStyle(color: _dim, fontSize: 11.sp),
          ),
          SizedBox(width: 10.w),
          Text(
            compactMoney(slice.amount, currencySymbol),
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _shapeChip(ExpenditureChartType t, {required bool enabled}) {
    final isCurrent = t == type;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isCurrent
            ? const Color(0xFF4E03D0).withValues(alpha: 0.35)
            : Colors.white.withValues(alpha: enabled ? 0.08 : 0.03),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isCurrent
              ? const Color(0xFF8B5CF6)
              : Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            t.icon,
            size: 13.sp,
            color: Colors.white.withValues(alpha: enabled ? 0.9 : 0.3),
          ),
          SizedBox(width: 5.w),
          Text(
            t.label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
              color: Colors.white.withValues(alpha: enabled ? 0.9 : 0.3),
            ),
          ),
          if (!enabled) ...[
            SizedBox(width: 4.w),
            Text(
              'n/a',
              style: TextStyle(
                fontSize: 9.sp,
                color: Colors.white.withValues(alpha: 0.3),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
