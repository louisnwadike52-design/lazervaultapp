import 'package:equatable/equatable.dart';

class DataPlanEntity extends Equatable {
  final String variationId;
  final String name;
  final double price;
  final String network;
  final String availability;

  const DataPlanEntity({
    required this.variationId,
    required this.name,
    required this.price,
    required this.network,
    required this.availability,
  });

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
  List<Object?> get props => [variationId, name, price, network, availability];
}
