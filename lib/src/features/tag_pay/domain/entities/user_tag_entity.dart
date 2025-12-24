import 'package:equatable/equatable.dart';

enum TagStatus {
  pending,
  paid,
  cancelled,
}

class UserTagEntity extends Equatable {
  final String id;
  final String taggerId;
  final String taggerTagPay;
  final String taggerName;
  final String taggedUserId;
  final String taggedUserTagPay;
  final String taggedUserName;
  final double amount;
  final String currency;
  final String description;
  final TagStatus status;
  final DateTime createdAt;
  final DateTime? paidAt;

  const UserTagEntity({
    required this.id,
    required this.taggerId,
    required this.taggerTagPay,
    required this.taggerName,
    required this.taggedUserId,
    required this.taggedUserTagPay,
    required this.taggedUserName,
    required this.amount,
    required this.currency,
    required this.description,
    required this.status,
    required this.createdAt,
    this.paidAt,
  });

  String get formattedAmount => '$currency ${amount.toStringAsFixed(2)}';

  @override
  List<Object?> get props => [
        id,
        taggerId,
        taggerTagPay,
        taggerName,
        taggedUserId,
        taggedUserTagPay,
        taggedUserName,
        amount,
        currency,
        description,
        status,
        createdAt,
        paidAt,
      ];
}
