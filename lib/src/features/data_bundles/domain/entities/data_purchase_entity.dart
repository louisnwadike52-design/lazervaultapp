import 'package:equatable/equatable.dart';

class DataPurchaseEntity extends Equatable {
  final String id;
  final String userId;
  final String accountId;
  final String reference;
  final double amount;
  final String status;
  final String phoneNumber;
  final String dataPlan;
  final double newBalance;
  final double commissionEarned;
  final String providerReference;
  final String createdAt;

  const DataPurchaseEntity({
    required this.id,
    required this.userId,
    required this.accountId,
    required this.reference,
    required this.amount,
    required this.status,
    required this.phoneNumber,
    required this.dataPlan,
    required this.newBalance,
    required this.commissionEarned,
    required this.providerReference,
    required this.createdAt,
  });

  bool get isCompleted => status == 'completed';
  bool get isFailed => status == 'failed';
  bool get isProcessing => status == 'processing';
  bool get isPending => status == 'pending' || status == 'processing';

  @override
  List<Object?> get props => [id, reference, amount, status, phoneNumber];
}
