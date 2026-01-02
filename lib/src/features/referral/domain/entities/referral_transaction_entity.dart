import 'package:equatable/equatable.dart';

enum ReferralStatus {
  pending,
  completed,
  failed,
  cancelled,
}

class ReferralTransactionEntity extends Equatable {
  final int id;
  final int referrerUserId;
  final int refereeUserId;
  final String referralCodeUsed;
  final ReferralStatus status;
  final int referrerRewardAmount;
  final int refereeRewardAmount;
  final String currency;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? failureReason;

  const ReferralTransactionEntity({
    required this.id,
    required this.referrerUserId,
    required this.refereeUserId,
    required this.referralCodeUsed,
    required this.status,
    required this.referrerRewardAmount,
    required this.refereeRewardAmount,
    required this.currency,
    required this.createdAt,
    this.completedAt,
    this.failureReason,
  });

  ReferralTransactionEntity copyWith({
    int? id,
    int? referrerUserId,
    int? refereeUserId,
    String? referralCodeUsed,
    ReferralStatus? status,
    int? referrerRewardAmount,
    int? refereeRewardAmount,
    String? currency,
    DateTime? createdAt,
    DateTime? completedAt,
    String? failureReason,
  }) {
    return ReferralTransactionEntity(
      id: id ?? this.id,
      referrerUserId: referrerUserId ?? this.referrerUserId,
      refereeUserId: refereeUserId ?? this.refereeUserId,
      referralCodeUsed: referralCodeUsed ?? this.referralCodeUsed,
      status: status ?? this.status,
      referrerRewardAmount: referrerRewardAmount ?? this.referrerRewardAmount,
      refereeRewardAmount: refereeRewardAmount ?? this.refereeRewardAmount,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      failureReason: failureReason ?? this.failureReason,
    );
  }

  @override
  List<Object?> get props => [
        id,
        referrerUserId,
        refereeUserId,
        referralCodeUsed,
        status,
        referrerRewardAmount,
        refereeRewardAmount,
        currency,
        createdAt,
        completedAt,
        failureReason,
      ];

  @override
  String toString() {
    return 'ReferralTransactionEntity(id: $id, referrerUserId: $referrerUserId, refereeUserId: $refereeUserId, code: $referralCodeUsed, status: $status, referrerReward: $referrerRewardAmount, refereeReward: $refereeRewardAmount, currency: $currency)';
  }
}
