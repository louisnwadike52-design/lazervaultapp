import 'package:equatable/equatable.dart';

class InternetProviderEntity extends Equatable {
  final String id;
  final String name;
  final String serviceId;
  final String logoUrl;
  final bool isActive;
  final double commissionRate;

  const InternetProviderEntity({
    required this.id,
    required this.name,
    required this.serviceId,
    required this.logoUrl,
    required this.isActive,
    required this.commissionRate,
  });

  @override
  List<Object?> get props => [id, name, serviceId, logoUrl, isActive, commissionRate];
}
