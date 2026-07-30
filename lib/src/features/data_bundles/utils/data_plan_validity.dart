// Client-side parsing of a data plan's validity/duration, used to power the
// Daily / Weekly / Monthly filter pills on the plan sheets.
//
// There is NO duration field on DataPlanEntity — validity is embedded in the
// plan `name` (e.g. "1GB - 30 days", "1GB - 1 Month", "N100 75MB Daily Plan
// (1 day)", "2GB - 7 days"). This mirrors the backend's authoritative parser
// (utility-payments-service .../internal/service/subscription_validity.go
// ParseValidityDays) so the client and server agree on how a plan's period is
// read.
import 'package:lazervault/src/features/data_bundles/domain/entities/data_plan_entity.dart';

// e.g. "30 days", "1 Month", "7day", "24 hrs", "1 year".
final RegExp _validityRe = RegExp(
  r'(\d+)\s*(day|days|d|week|weeks|wk|month|months|mo|hour|hours|hr|hrs|year|years|yr)',
  caseSensitive: false,
);

/// Best-effort number of days a plan is valid for, parsed from its [name].
/// Returns null when no duration token is present (those plans show only under
/// the "All" pill). Multipliers: day=1, week=7, month=30, year=365; hours ≥24
/// round to whole days, otherwise count as 1 day (a same-day plan).
int? parseValidityDays(String name) {
  final m = _validityRe.firstMatch(name);
  if (m == null) return null;
  final n = int.tryParse(m.group(1) ?? '');
  if (n == null || n <= 0) return null;
  final unit = (m.group(2) ?? '').toLowerCase();
  if (unit.startsWith('week') || unit == 'wk') return n * 7;
  if (unit.startsWith('month') || unit == 'mo') return n * 30;
  if (unit.startsWith('year') || unit == 'yr') return n * 365;
  if (unit.startsWith('hour') || unit == 'hr' || unit == 'hrs') {
    return n >= 24 ? (n / 24).round() : 1;
  }
  // day / days / d
  return n;
}

/// The duration buckets exposed as filter pills. [all] shows everything.
enum DataPlanDuration { all, daily, weekly, monthly }

extension DataPlanDurationLabel on DataPlanDuration {
  String get label => switch (this) {
        DataPlanDuration.all => 'All',
        DataPlanDuration.daily => 'Daily',
        DataPlanDuration.weekly => 'Weekly',
        DataPlanDuration.monthly => 'Monthly',
      };
}

/// Whether [plan] belongs in [filter]. Buckets are non-overlapping and cover
/// every plan with a parseable duration (Daily ≤3d, Weekly 4–13d, Monthly ≥14d
/// — so 30-day and longer/mega plans land under Monthly, the longest bucket).
/// A plan whose duration can't be parsed matches ONLY [DataPlanDuration.all].
bool matchesDuration(DataPlanEntity plan, DataPlanDuration filter) {
  if (filter == DataPlanDuration.all) return true;
  final days = parseValidityDays(plan.name);
  if (days == null) return false;
  return switch (filter) {
    DataPlanDuration.all => true,
    DataPlanDuration.daily => days <= 3,
    DataPlanDuration.weekly => days >= 4 && days <= 13,
    DataPlanDuration.monthly => days >= 14,
  };
}
