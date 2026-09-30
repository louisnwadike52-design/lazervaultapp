import 'package:equatable/equatable.dart';

class DataPlanEntity extends Equatable {
  final String variationId;
  final String name;
  final double price;
  final String network;
  final String availability;

  /// The provider's own plan family id, verbatim: sme, gifting, awoofgifting,
  /// specialdata, datacoupons, cglite, directdata, …
  ///
  /// Empty for a provider that publishes none, in which case the plan sheet
  /// renders one ungrouped list exactly as it always did.
  final String planFamily;

  /// The customer-facing name for [planFamily], resolved server-side so the app,
  /// the chat agent and the voice agent all use the same word. Empty for a
  /// family the backend does not yet have a label for.
  final String familyLabel;

  const DataPlanEntity({
    required this.variationId,
    required this.name,
    required this.price,
    required this.network,
    required this.availability,
    this.planFamily = '',
    this.familyLabel = '',
  });

  /// The chip a plan is filed under.
  ///
  /// A family the backend has no label for still gets a GROUP rather than being
  /// dropped or folded into a neighbour — a plan the provider has just started
  /// selling must remain visible and buyable even before we have named it.
  String get familyChipLabel {
    if (familyLabel.isNotEmpty) return familyLabel;
    if (planFamily.isNotEmpty) return 'Other';
    return '';
  }

  /// True when this plan belongs to a family at all. Providers without families
  /// must not produce a lone "Other" chip over a list that has no groups.
  bool get hasFamily => planFamily.isNotEmpty;

  /// Price formatted for display — Naira by default since all data plans
  /// are currently NG-scoped. Two decimals when there are sub-naira values,
  /// whole naira otherwise.
  String get displayPrice {
    if (price == price.truncateToDouble()) {
      return '\u20A6${price.toStringAsFixed(0)}';
    }
    return '\u20A6${price.toStringAsFixed(2)}';
  }

  @override
  List<Object?> get props =>
      [variationId, name, price, network, availability, planFamily, familyLabel];
}
