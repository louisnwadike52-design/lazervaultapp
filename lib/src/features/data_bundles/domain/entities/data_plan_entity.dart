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

  @override
  List<Object?> get props => [variationId, name, price, network, availability];
}
