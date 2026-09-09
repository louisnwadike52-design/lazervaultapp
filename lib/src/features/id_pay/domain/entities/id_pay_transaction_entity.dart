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

  /// Platform fee (major units), borne by the RECIPIENT (creator). The payer
  /// is debited exactly [amount]; the creator keeps [netAmount].
  final double fee;
  final double netAmount;

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
    this.fee = 0,
    this.netAmount = 0,
  });

  /// What the creator actually keeps — legacy rows carry netAmount 0 with
  /// fee 0, which means "everything".
  double get creatorReceives =>
      (netAmount == 0 && fee == 0) ? amount : netAmount;

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
        fee,
        netAmount,
      ];
}
