import 'package:equatable/equatable.dart';

class EducationProviderEntity extends Equatable {
  final String id;
  final String name;
  final String serviceId;
  final String logoUrl;
  final bool isActive;
  final double amount;
  final String description;

  const EducationProviderEntity({
    required this.id,
    required this.name,
    required this.serviceId,
    required this.logoUrl,
    required this.isActive,
    required this.amount,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, serviceId, logoUrl, isActive, amount, description];
}
