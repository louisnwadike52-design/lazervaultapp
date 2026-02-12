import 'package:equatable/equatable.dart';
import 'education_pin_entity.dart';

class EducationPurchaseEntity extends Equatable {
  final String id;
  final String userId;
  final String accountId;
  final String billType;
  final String providerId;
  final String reference;
  final double amount;
  final String status;
  final String customerNumber;
  final String metadata;
  final String createdAt;
  final double newBalance;
  final List<EducationPinEntity> pins;
  final String message;

  const EducationPurchaseEntity({
    required this.id,
    required this.userId,
    required this.accountId,
    required this.billType,
    required this.providerId,
    required this.reference,
    required this.amount,
    required this.status,
    required this.customerNumber,
    required this.metadata,
    required this.createdAt,
    required this.newBalance,
    required this.pins,
    required this.message,
  });

  bool get isCompleted => status == 'completed';
  bool get isFailed => status == 'failed';

  @override
  List<Object?> get props => [id, userId, accountId, billType, providerId, reference, amount, status, customerNumber, metadata, createdAt, newBalance, pins, message];
}
