import 'package:equatable/equatable.dart';

class InternetPackageEntity extends Equatable {
  final String id;
  final String name;
  final String variationCode;
  final double amount;
  final String providerId;
  final String validity;

  const InternetPackageEntity({
    required this.id,
    required this.name,
    required this.variationCode,
    required this.amount,
    required this.providerId,
    required this.validity,
  });

  @override
  List<Object?> get props => [id, name, variationCode, amount, providerId, validity];
}
