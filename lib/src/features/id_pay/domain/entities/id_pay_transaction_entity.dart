import 'package:equatable/equatable.dart';

class IDPayTransactionEntity extends Equatable {
  final String id;
  final String payId;
  final String payerId;
  final String payerName;
  final String payerUsername;
  final String recipientId;
  final String recipientName;
  final double amount;
  final String currency;
  final String reference;
  final String status;
  final DateTime createdAt;

  const IDPayTransactionEntity({
    required this.id,
    required this.payId,
    required this.payerId,
    required this.payerName,
    required this.payerUsername,
    required this.recipientId,
    required this.recipientName,
    required this.amount,
    required this.currency,
    required this.reference,
    required this.status,
    required this.createdAt,
  });

  bool get isCompleted => status == 'completed';

  @override
  List<Object?> get props => [
        id,
        payId,
        payerId,
        payerName,
        payerUsername,
        recipientId,
        recipientName,
        amount,
        currency,
        reference,
        status,
        createdAt,
      ];
}
