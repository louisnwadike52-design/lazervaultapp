import 'package:lazervault/src/features/data_bundles/domain/entities/data_plan_entity.dart';

/// Grouping data plans by the PROVIDER'S OWN family, and filtering on it.
///
/// WHY THIS EXISTS
/// ---------------
/// The active provider lists 254 data plans across nine families, and MTN alone
/// spans seven of them with 82 plans. They are different products, not labels:
///
///   1GB / 30 days costs ₦880 on cglite, ₦500 on sme and ₦490 on awoofgifting
///   SME volumes are transferable; gifting volumes are not
///   awoof and coupon bundles expire in a day
///
/// Rendered as one flat list — which is all the app has ever been able to do —
/// three rows read "1GB" at three prices with nothing to tell them apart, and the
/// cheapest looks like a mistake. The whole price advantage this provider has on
/// ≤5GB bundles lives inside these families.
///
/// Orthogonal to the existing duration filter (All / Daily / Weekly / Monthly):
/// a customer picks a family AND a duration, and both narrow the same list.

/// One selectable family, derived from what the provider actually returned.
///
/// Built from the DATA rather than a hardcoded list, so a family the provider
/// adds appears on its own the first time it ships instead of being invisible
/// until someone updates the app.
class DataPlanFamily {
  const DataPlanFamily(
      {required this.id, required this.label, required this.count});

  /// The provider's family id, or '' for the synthetic "All" entry.
  final String id;

  /// What the customer reads.
  final String label;

  /// How many plans are in it, shown on the chip so a customer can see at a
  /// glance that a family is worth opening.
  final int count;

  bool get isAll => id.isEmpty;
}

/// The family chips for a list of plans, cheapest-first inside each family.
///
/// Returns an EMPTY list when no plan carries a family, so a provider that
/// publishes none produces no chip row at all rather than a lone "All" chip
/// above an ungrouped list — a filter with one option is a control that cannot
/// do anything.
///
/// Ordering is by plan count, descending, then alphabetically. Count first
/// because the family a customer most likely wants is the one with the most to
/// choose from, and a stable tiebreak so the chip row does not reshuffle between
/// loads of the same catalogue.
List<DataPlanFamily> dataPlanFamilies(List<DataPlanEntity> plans) {
  final counts = <String, int>{};
  final labels = <String, String>{};
  for (final p in plans) {
    if (!p.hasFamily) continue;
    counts[p.planFamily] = (counts[p.planFamily] ?? 0) + 1;
    labels[p.planFamily] = p.familyChipLabel;
  }
  if (counts.isEmpty) return const [];

  final families = counts.keys.toList()
    ..sort((a, b) {
      final byCount = counts[b]!.compareTo(counts[a]!);
      if (byCount != 0) return byCount;
      return (labels[a] ?? a).compareTo(labels[b] ?? b);
    });

  return [
    DataPlanFamily(id: '', label: 'All', count: plans.length),
    for (final f in families)
      DataPlanFamily(id: f, label: labels[f] ?? 'Other', count: counts[f]!),
  ];
}

/// True when [plan] belongs in the [familyId] tab. An empty id is "All".
bool matchesFamily(DataPlanEntity plan, String familyId) =>
    familyId.isEmpty || plan.planFamily == familyId;

/// Sorts plans cheapest-first.
///
/// The reason the families are worth showing is that one of them is cheaper for
/// the same volume, so within a family the cheap end has to be the end a customer
/// sees first. Ties break on name for a stable order.
List<DataPlanEntity> sortedByPrice(List<DataPlanEntity> plans) {
  final out = [...plans];
  out.sort((a, b) {
    final byPrice = a.price.compareTo(b.price);
    return byPrice != 0 ? byPrice : a.name.compareTo(b.name);
  });
  return out;
}
