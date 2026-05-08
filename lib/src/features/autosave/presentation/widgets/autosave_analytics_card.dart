import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/utils/currency_formatter.dart' as currency_formatter;
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';

/// Analytics ("Quick Stats") card on the All-Rules screen.
///
/// Displays four lifetime aggregates:
///   • Total Saved (all-time)
///   • Active Rules
///   • Avg Per Save (totalSaved / totalTransactions)
///   • Top Performer (most-active rule)
///
/// All four values come from the backend's GetAutoSaveStatistics
/// response — the previous implementation re-summed the (paginated)
/// `rules` array on the client, so once paginated/filtered the totals
/// would silently shrink. With the backend doing the aggregation we
/// always show the lifetime numbers regardless of the current view.
///
/// `rules` is still accepted as a fallback so the card keeps rendering
/// sensible numbers when stats haven't loaded yet (cold cache, network
/// blip). It's only used when [statistics] is null.
class AutoSaveAnalyticsCard extends StatelessWidget {
  final AutoSaveStatisticsEntity? statistics;
  final List<AutoSaveRuleEntity> rules;
  /// True when the user has narrowed the rules list with a pill filter
  /// or search. We then derive every KPI from the filtered `rules`
  /// instead of the backend's lifetime aggregates so the user sees the
  /// numbers that match what's on screen.
  final bool isFiltered;

  const AutoSaveAnalyticsCard({
    super.key,
    required this.rules,
    this.statistics,
    this.isFiltered = false,
  });

  @override
  Widget build(BuildContext context) {
    final stats = statistics;

    final currency = stats?.currency ?? 'NGN';
    // When filters are applied, prefer the filtered list — that's the
    // set of rules the user is looking at, and showing lifetime totals
    // alongside a filtered roster is misleading. When unfiltered, the
    // backend's lifetime aggregates win for accuracy across pagination.
    final useLocal = isFiltered;
    final totalSaved = useLocal
        ? rules.fold<double>(0, (sum, r) => sum + r.totalSaved)
        : (stats?.totalSavedAllTime ??
            rules.fold<double>(0, (sum, r) => sum + r.totalSaved));
    final activeCount = useLocal
        ? rules.where((r) => r.isActive).length
        : (stats?.activeRulesCount ??
            rules.where((r) => r.isActive).length);
    // totalTransactions is not derivable client-side from the rules
    // array (we'd need each rule's full transaction history). When
    // filtering, fall back to summing each rule's trigger_count which
    // approximates the per-rule activity in scope.
    final totalTransactions = useLocal
        ? rules.fold<int>(0, (s, r) => s + r.triggerCount)
        : (stats?.totalTransactions ?? 0);
    // Average per save = total / number of saves. Previously this
    // divided by rules.length (rule count), which is wrong — a rule
    // can fire many times. Use totalTransactions; when no triggers
    // have happened yet show 0 so we never divide by zero.
    final avgPerSave = useLocal
        ? (totalTransactions > 0 ? totalSaved / totalTransactions : 0)
        : (stats?.averageSaveAmount ??
            (totalTransactions > 0 ? totalSaved / totalTransactions : 0));

    // Top performer: prefer the backend-aggregated mostActiveRule
    // (highest trigger_count). Fall back to a client-side scan of
    // the loaded rules by total_saved when stats are absent.
    // Defensive: rules may be List<AutoSaveRuleModel> at runtime even
    // though declared as List<AutoSaveRuleEntity> (the data class
    // extends the entity, and Dart's reified generics preserve the
    // concrete element type). Using `.reduce` directly with a lambda
    // typed against the entity blows up with "(Entity, Entity) =>
    // Entity is not a subtype of (Model, Model) => Model of 'combine'".
    // Pre-walk with fold + a nullable accumulator avoids the variance
    // mismatch entirely.
    final topPerformer = useLocal
        ? rules.fold<AutoSaveRuleEntity?>(
            null,
            (best, r) =>
                best == null || r.totalSaved > best.totalSaved ? r : best,
          )
        : stats?.mostActiveRule ??
            rules.fold<AutoSaveRuleEntity?>(
              null,
          (best, r) =>
              best == null || r.totalSaved > best.totalSaved ? r : best,
        );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 78, 3, 208),
            Color.fromARGB(255, 98, 33, 224),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: Colors.white, size: 24.sp),
              SizedBox(width: 12.w),
              Text(
                'Quick Stats',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (stats == null)
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: SizedBox(
                    width: 12.w,
                    height: 12.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 1.4,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white70),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  label: 'Total Saved',
                  value: currency_formatter.CurrencySymbols
                      .formatAmountWithCurrency(totalSaved, currency),
                  icon: Icons.savings,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  label: 'Active Rules',
                  value: activeCount.toString(),
                  icon: Icons.check_circle,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  label: 'Avg Per Save',
                  value: currency_formatter.CurrencySymbols
                      .formatAmountWithCurrency(
                          avgPerSave.toDouble(), currency),
                  icon: Icons.trending_up,
                  subtitle: totalTransactions > 0
                      ? '$totalTransactions saves'
                      : null,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  label: 'Top Performer',
                  value: topPerformer?.name ?? 'N/A',
                  icon: Icons.star,
                  valueSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required IconData icon,
    double? valueSize,
    String? subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white70, size: 14.sp),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: valueSize ?? 16.sp,
            fontWeight: FontWeight.w700,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (subtitle != null) ...[
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 10.sp,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}
