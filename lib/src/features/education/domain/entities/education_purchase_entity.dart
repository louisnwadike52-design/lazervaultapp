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
  // Async backend returns 'processing'/'awaiting_webhook' for an in-flight
  // purchase whose PINs haven't been generated yet — treat these as pending so
  // the result screen renders a pending state (and reconciles) instead of the
  // misleading "Purchase Successful! / 0 PINs generated".
  bool get isPending =>
      status == 'pending' ||
      status == 'processing' ||
      status == 'awaiting_webhook';

  @override
  List<Object?> get props => [id, userId, accountId, billType, providerId, reference, amount, status, customerNumber, metadata, createdAt, newBalance, pins, message];
}
