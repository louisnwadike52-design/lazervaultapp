import '../../domain/entities/id_pay_entity.dart';
import 'package:lazervault/src/generated/id_pay.pb.dart' as pb;

class IDPayModel extends IDPayEntity {
  const IDPayModel({
    required super.id,
    required super.payId,
    required super.creatorId,
    required super.creatorName,
    required super.creatorUsername,
    required super.type,
    required super.amountMode,
    required super.amount,
    required super.minAmount,
    required super.maxAmount,
    required super.currency,
    required super.description,
    required super.status,
    required super.expiresAt,
    required super.createdAt,
    required super.totalReceived,
    required super.paymentCount,
  });

  factory IDPayModel.fromProto(pb.IDPay proto) {
    return IDPayModel(
      id: proto.id,
      payId: proto.payId,
      creatorId: proto.creatorId,
      creatorName: proto.creatorName,
      creatorUsername: proto.creatorUsername,
      type: _typeFromProto(proto.type),
      amountMode: _amountModeFromProto(proto.amountMode),
      amount: proto.amount,
      minAmount: proto.minAmount,
      maxAmount: proto.maxAmount,
      currency: proto.currency,
      description: proto.description,
      status: _statusFromProto(proto.status),
      expiresAt: proto.expiresAt.toDateTime(),
      createdAt: proto.createdAt.toDateTime(),
      totalReceived: proto.totalReceived,
      paymentCount: proto.paymentCount,
    );
  }

  static IDPayType _typeFromProto(pb.IDPayType type) {
    switch (type) {
      case pb.IDPayType.ID_PAY_RECURRING:
        return IDPayType.recurring;
      default:
        return IDPayType.oneTime;
    }
  }

  static IDPayAmountMode _amountModeFromProto(pb.IDPayAmountMode mode) {
    switch (mode) {
      case pb.IDPayAmountMode.ID_PAY_FLEXIBLE:
        return IDPayAmountMode.flexible;
      default:
        return IDPayAmountMode.fixed;
    }
  }

  static IDPayStatus _statusFromProto(pb.IDPayStatus status) {
    switch (status) {
      case pb.IDPayStatus.ID_PAY_ACTIVE:
        return IDPayStatus.active;
      case pb.IDPayStatus.ID_PAY_PAID:
        return IDPayStatus.paid;
      case pb.IDPayStatus.ID_PAY_EXPIRED:
        return IDPayStatus.expired;
      case pb.IDPayStatus.ID_PAY_CANCELLED:
        return IDPayStatus.cancelled;
      default:
        return IDPayStatus.active;
    }
  }
}
