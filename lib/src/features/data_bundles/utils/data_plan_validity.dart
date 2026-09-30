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

// e.g. "30 days", "1 Month", "7day", "24 hrs", "1 year", "2-Day", "3-Month".
//
// The separator allows a HYPHEN, not just whitespace. Both providers name
// plans that way — "1.5GB 2-Day Plan", "4GB 2-Days Plan", "480GB 3-Month
// Plan" — and a whitespace-only separator matched none of them.
final RegExp _validityRe = RegExp(
  // The unit must END on a word boundary, and the one-letter `d` / two-letter
  // `mo` abbreviations are gone. Without both, "N500 Data Bundle" parsed as
  // 500 DAYS — the `d` matched the D of "Data" — and "100 More" as 3000. No
  // plan in either live catalogue triggers it today, which is exactly why it
  // would have been found by a customer rather than by us.
  r'(\d+)[\s-]*(days|day|weeks|week|wk|months|month|hours|hour|hrs|hr|years|year|yrs|yr)\b',
  caseSensitive: false,
);

// A period named as a WORD, with no number in front: "Daily Plan", "Weekly
// Plan", "16.5GB + 10mins Monthly Plan".
//
// MEASURED, not hypothetical: with the numeric pattern alone the filter pills
// dropped 28 of 36 Nomba MTN plans and 22 of 50 VTpass MTN plans — more than
// half the catalogue — so tapping "Monthly" hid most of the monthly bundles.
// A filter that quietly omits the plan someone is looking for is worse than
// no filter, because they conclude we do not sell it.
final RegExp _periodWordRe = RegExp(
  r'\b(daily|weekly|fortnightly|monthly|quarterly|yearly|annual)\b',
  caseSensitive: false,
);

int? _daysForPeriodWord(String word) => switch (word.toLowerCase()) {
      'daily' => 1,
      'weekly' => 7,
      'fortnightly' => 14,
      'monthly' => 30,
      'quarterly' => 90,
      'yearly' || 'annual' => 365,
      _ => null,
    };

/// Best-effort number of days a plan is valid for, parsed from its [name].
/// Returns null when no duration token is present (those plans show only under
/// the "All" pill). Multipliers: day=1, week=7, month=30, year=365; hours ≥24
/// round to whole days, otherwise count as 1 day (a same-day plan).
int? parseValidityDays(String name) {
  final m = _validityRe.firstMatch(name);
  if (m == null) {
    // No "<n> <unit>" anywhere. Fall back to a bare period word, which is how
    // the majority of both providers' plans are actually named.
    final w = _periodWordRe.firstMatch(name);
    return w == null ? null : _daysForPeriodWord(w.group(1) ?? '');
  }
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
