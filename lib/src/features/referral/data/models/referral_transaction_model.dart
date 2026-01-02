import 'package:lazervault/src/features/referral/domain/entities/referral_transaction_entity.dart';
import 'package:lazervault/src/generated/referral.pb.dart' as proto;

class ReferralTransactionModel extends ReferralTransactionEntity {
  const ReferralTransactionModel({
    required super.id,
    required super.referrerUserId,
    required super.refereeUserId,
    required super.referralCodeUsed,
    required super.status,
    required super.referrerRewardAmount,
    required super.refereeRewardAmount,
    required super.currency,
    required super.createdAt,
    super.completedAt,
    super.failureReason,
  });

  /// Create ReferralTransactionModel from protobuf ReferralTransaction
  factory ReferralTransactionModel.fromProto(proto.ReferralTransaction protoTransaction) {
    return ReferralTransactionModel(
      id: protoTransaction.id.toInt(),
      referrerUserId: protoTransaction.referrerUserId.toInt(),
      refereeUserId: protoTransaction.refereeUserId.toInt(),
      referralCodeUsed: protoTransaction.referralCodeUsed,
      status: _mapProtoStatus(protoTransaction.status),
      referrerRewardAmount: protoTransaction.referrerRewardAmount.toInt(),
      refereeRewardAmount: protoTransaction.refereeRewardAmount.toInt(),
      currency: protoTransaction.currency,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        protoTransaction.createdAt.seconds.toInt() * 1000,
      ),
      completedAt: protoTransaction.hasCompletedAt()
          ? DateTime.fromMillisecondsSinceEpoch(
              protoTransaction.completedAt.seconds.toInt() * 1000,
            )
          : null,
      failureReason: protoTransaction.failureReason.isNotEmpty
          ? protoTransaction.failureReason
          : null,
    );
  }

  /// Map proto ReferralStatus to domain ReferralStatus
  static ReferralStatus _mapProtoStatus(proto.ReferralStatus protoStatus) {
    switch (protoStatus) {
      case proto.ReferralStatus.REFERRAL_STATUS_PENDING:
        return ReferralStatus.pending;
      case proto.ReferralStatus.REFERRAL_STATUS_COMPLETED:
        return ReferralStatus.completed;
      case proto.ReferralStatus.REFERRAL_STATUS_FAILED:
        return ReferralStatus.failed;
      case proto.ReferralStatus.REFERRAL_STATUS_CANCELLED:
        return ReferralStatus.cancelled;
      default:
        return ReferralStatus.pending;
    }
  }
}
