import 'package:lazervault/src/generated/lock_funds.pb.dart' as pb;
import '../../domain/entities/lock_fund_entity.dart';

class LockFundModel {
  /// Convert protobuf LockFund to domain entity
  static LockFund fromProto(pb.LockFund proto) {
    return LockFund(
      id: proto.id,
      userId: proto.userId.toString(),
      lockType: _convertProtoLockType(proto.lockType),
      amount: proto.amount,
      currency: proto.currency,
      lockDurationDays: proto.lockDurationDays,
      interestRate: proto.interestRate,
      lockedAt: proto.lockedAt.toDateTime(),
      unlockAt: proto.unlockAt.toDateTime(),
      status: _convertProtoLockStatus(proto.status),
      autoRenew: proto.autoRenew,
      goalName: proto.goalName.isEmpty ? null : proto.goalName,
      goalDescription: proto.goalDescription.isEmpty ? null : proto.goalDescription,
      earlyUnlockPenaltyPercent: proto.earlyUnlockPenaltyPercent,
      accruedInterest: proto.accruedInterest,
      paymentMethod: proto.paymentMethod.isEmpty ? null : proto.paymentMethod,
      transactionId: proto.transactionId.isEmpty ? null : proto.transactionId,
      createdAt: proto.createdAt.toDateTime(),
      updatedAt: proto.updatedAt.toDateTime(),
      daysRemaining: proto.daysRemaining,
      progressPercent: proto.progressPercent,
      totalValue: proto.totalValue,
      canUnlockEarly: proto.canUnlockEarly,
    );
  }

  /// Convert domain LockType to protobuf
  static pb.LockType convertLockTypeToProto(LockType type) {
    switch (type) {
      case LockType.savings:
        return pb.LockType.LOCK_TYPE_SAVINGS;
      case LockType.investment:
        return pb.LockType.LOCK_TYPE_INVESTMENT;
      case LockType.emergencyFund:
        return pb.LockType.LOCK_TYPE_EMERGENCY_FUND;
      case LockType.goalBased:
        return pb.LockType.LOCK_TYPE_GOAL_BASED;
    }
  }

  /// Convert protobuf LockType to domain
  static LockType _convertProtoLockType(pb.LockType type) {
    switch (type) {
      case pb.LockType.LOCK_TYPE_SAVINGS:
        return LockType.savings;
      case pb.LockType.LOCK_TYPE_INVESTMENT:
        return LockType.investment;
      case pb.LockType.LOCK_TYPE_EMERGENCY_FUND:
        return LockType.emergencyFund;
      case pb.LockType.LOCK_TYPE_GOAL_BASED:
        return LockType.goalBased;
      default:
        return LockType.savings;
    }
  }

  /// Convert domain LockStatus to protobuf
  static pb.LockStatus convertLockStatusToProto(LockStatus status) {
    switch (status) {
      case LockStatus.active:
        return pb.LockStatus.LOCK_STATUS_ACTIVE;
      case LockStatus.matured:
        return pb.LockStatus.LOCK_STATUS_MATURED;
      case LockStatus.unlocked:
        return pb.LockStatus.LOCK_STATUS_UNLOCKED;
      case LockStatus.cancelled:
        return pb.LockStatus.LOCK_STATUS_CANCELLED;
    }
  }

  /// Convert protobuf LockStatus to domain
  static LockStatus _convertProtoLockStatus(pb.LockStatus status) {
    switch (status) {
      case pb.LockStatus.LOCK_STATUS_ACTIVE:
        return LockStatus.active;
      case pb.LockStatus.LOCK_STATUS_MATURED:
        return LockStatus.matured;
      case pb.LockStatus.LOCK_STATUS_UNLOCKED:
        return LockStatus.unlocked;
      case pb.LockStatus.LOCK_STATUS_CANCELLED:
        return LockStatus.cancelled;
      default:
        return LockStatus.active;
    }
  }

  /// Create CreateLockFundRequest from parameters
  static pb.CreateLockFundRequest toCreateRequest({
    required LockType lockType,
    required double amount,
    required String currency,
    required int lockDurationDays,
    bool autoRenew = false,
    String? goalName,
    String? goalDescription,
    required String paymentMethod,
  }) {
    return pb.CreateLockFundRequest()
      ..lockType = convertLockTypeToProto(lockType)
      ..amount = amount
      ..currency = currency
      ..lockDurationDays = lockDurationDays
      ..autoRenew = autoRenew
      ..goalName = goalName ?? ''
      ..goalDescription = goalDescription ?? ''
      ..paymentMethod = paymentMethod;
  }

  /// Convert protobuf LockTransaction to domain entity
  static LockTransaction transactionFromProto(pb.LockTransaction proto) {
    return LockTransaction(
      id: proto.id,
      lockFundId: proto.lockFundId,
      userId: proto.userId.toString(),
      transactionType: proto.transactionType,
      amount: proto.amount,
      currency: proto.currency,
      paymentMethod: proto.paymentMethod.isEmpty ? null : proto.paymentMethod,
      status: proto.status,
      transactionDate: proto.transactionDate.toDateTime(),
      description: proto.description,
    );
  }

  /// Convert protobuf InterestCalculation to domain entity
  static InterestCalculation interestFromProto(pb.CalculateInterestResponse proto, {double principalAmount = 0.0}) {
    return InterestCalculation(
      interestRate: proto.interestRate,
      estimatedInterest: proto.estimatedInterest,
      totalReturn: proto.totalReturn,
      apy: proto.apy,
      principalAmount: principalAmount,
      interestAmount: proto.estimatedInterest,
      totalAmount: proto.totalReturn,
    );
  }
}
