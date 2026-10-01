import 'package:lazervault/src/features/data_bundles/domain/entities/data_plan_entity.dart';

/// Filtering data plans by HOW MUCH DATA they give.
///
/// WHY A RANGE AND NOT AN EXACT VOLUME
/// -----------------------------------
/// The live catalogue has **87 distinct volumes** across 254 plans — 40MB, 45MB,
/// 75MB, 110MB, 125MB, 180MB, 235MB, 1.4GB, 1.5GB, 1.6GB, 2.2GB, 2.3GB, 2.44GB,
/// 2.6GB, 2.7GB … A chip per volume is 87 chips, which is not a filter.
///
/// Ranges keep the control usable and match how someone actually shops: "about a
/// gig", not "exactly 1,638.4 MB". Measured distribution across all networks:
/// <1GB 31 · 1–2GB 36 · 2–5GB 62 · 5–10GB 26 · 10–50GB 39 · 50GB+ 38.
///
/// PLANS WITH NO VOLUME ARE NOT DROPPED. 22 rows carry no size at all — Smile's
/// "UnlimitedLite for 30days", Spectranet's "Freedom 3Mbps" — and they stay
/// reachable under "All". Selecting a size range legitimately excludes them;
/// silently losing them from every view would not.

/// One volume range the user can filter to.
class DataVolumeBucket {
  const DataVolumeBucket({
    required this.label,
    required this.minMb,
    required this.maxMb,
    this.count = 0,
  });

  final String label;

  /// Inclusive lower bound in MB.
  final double minMb;

  /// EXCLUSIVE upper bound in MB. [double.infinity] for the open top range.
  final double maxMb;

  /// How many plans fall in this range, shown on the chip.
  final int count;

  bool contains(double mb) => mb >= minMb && mb < maxMb;

  DataVolumeBucket withCount(int c) =>
      DataVolumeBucket(label: label, minMb: minMb, maxMb: maxMb, count: c);
}

const double _gb = 1024;

/// The ranges, sized to the live catalogue so each one holds a usable number of
/// plans rather than being empty or holding almost everything.
const List<DataVolumeBucket> dataVolumeBuckets = [
  DataVolumeBucket(label: 'Under 1GB', minMb: 0, maxMb: _gb),
  DataVolumeBucket(label: '1–2GB', minMb: _gb, maxMb: 2 * _gb),
  DataVolumeBucket(label: '2–5GB', minMb: 2 * _gb, maxMb: 5 * _gb),
  DataVolumeBucket(label: '5–10GB', minMb: 5 * _gb, maxMb: 10 * _gb),
  DataVolumeBucket(label: '10–50GB', minMb: 10 * _gb, maxMb: 50 * _gb),
  DataVolumeBucket(label: '50GB+', minMb: 50 * _gb, maxMb: double.infinity),
];

/// Matches the FIRST size token in a plan name: `1GB`, `500MB`, `1.5 GB`, `2TB`.
///
/// Anchored on a word boundary so the `5` in "5 Days" or the `100` in
/// "100 Naira" cannot be read as a size — the catalogue is full of both, and a
/// looser pattern files "Airtel Data - 100 Naira - 100MB - 1 Day" under the
/// wrong range.
final RegExp _volumeToken = RegExp(
  r'(\d+(?:\.\d+)?)\s*(TB|GB|MB)\b',
  caseSensitive: false,
);

/// The plan's data volume in MB, or null when the name states none.
///
/// Null is a real answer, not a parse failure: an unlimited or speed-tiered plan
/// genuinely has no size, and treating it as 0 would file every one of them
/// under "Under 1GB" where they do not belong.
double? dataPlanVolumeMb(DataPlanEntity plan) {
  final m = _volumeToken.firstMatch(plan.name);
  if (m == null) return null;
  final value = double.tryParse(m.group(1)!);
  if (value == null || value <= 0) return null;
  switch (m.group(2)!.toUpperCase()) {
    case 'TB':
      return value * 1024 * 1024;
    case 'GB':
      return value * 1024;
    default:
      return value;
  }
}

/// True when [plan] belongs in [bucket]. A null bucket is "All".
///
/// A plan with no stated volume matches ONLY "All" — it cannot honestly be
/// claimed to be under 1GB or over 50GB.
bool matchesVolume(DataPlanEntity plan, DataVolumeBucket? bucket) {
  if (bucket == null) return true;
  final mb = dataPlanVolumeMb(plan);
  if (mb == null) return false;
  return bucket.contains(mb);
}

/// The volume chips to show for a list of plans, counted and EMPTY ONES DROPPED.
///
/// Built from the data for the same reason the family chips are: a range with no
/// plans is a control that does nothing, and a network whose catalogue is all
/// small bundles should not offer a "50GB+" chip that leads to an empty list.
///
/// Returns an empty list when fewer than two ranges are populated — one chip
/// plus "All" cannot narrow anything.
List<DataVolumeBucket> dataVolumeChips(List<DataPlanEntity> plans) {
  final counts = <String, int>{};
  for (final p in plans) {
    final mb = dataPlanVolumeMb(p);
    if (mb == null) continue;
    for (final b in dataVolumeBuckets) {
      if (b.contains(mb)) {
        counts[b.label] = (counts[b.label] ?? 0) + 1;
        break;
      }
    }
  }
  final populated = [
    for (final b in dataVolumeBuckets)
      if ((counts[b.label] ?? 0) > 0) b.withCount(counts[b.label]!),
  ];
  return populated.length < 2 ? const [] : populated;
}
