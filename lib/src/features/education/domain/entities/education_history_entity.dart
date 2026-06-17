import 'education_pin_entity.dart';

class EducationHistoryEntity {
  final String id;
  final String providerId;
  final String providerName;
  final String serviceId;
  final String variationCode;
  final int quantity;
  final double amount;
  final String status;
  final String reference;
  final String createdAt;
  final List<EducationPinEntity> pins;
  final String phoneNumber;
  final String billersCode;

  const EducationHistoryEntity({
    required this.id,
    required this.providerId,
    required this.providerName,
    required this.serviceId,
    required this.variationCode,
    required this.quantity,
    required this.amount,
    required this.status,
    required this.reference,
    required this.createdAt,
    required this.pins,
    required this.phoneNumber,
    required this.billersCode,
  });
}
