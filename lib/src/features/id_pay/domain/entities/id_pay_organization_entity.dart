import 'package:equatable/equatable.dart';

class IDPayOrganizationEntity extends Equatable {
  final String id;
  final String creatorId;
  final String name;
  final String description;
  final String logoUrl;
  final String accountId;
  final double totalReceived;
  final int totalPaymentCount;
  final int activeIdPayCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const IDPayOrganizationEntity({
    required this.id,
    required this.creatorId,
    required this.name,
    required this.description,
    required this.logoUrl,
    required this.accountId,
    required this.totalReceived,
    required this.totalPaymentCount,
    required this.activeIdPayCount,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        creatorId,
        name,
        description,
        logoUrl,
        accountId,
        totalReceived,
        totalPaymentCount,
        activeIdPayCount,
        createdAt,
        updatedAt,
      ];
}
