import '../../domain/entities/auto_recharge_entity.dart';
import '../../domain/entities/bill_payment_entity.dart';
import 'package:lazervault/src/generated/electricity_bill.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart' as $timestamp;

class AutoRechargeModel extends AutoRechargeEntity {
  const AutoRechargeModel({
    required super.id,
    required super.userId,
    required super.beneficiaryId,
    required super.providerId,
    required super.providerCode,
    required super.providerName,
    required super.meterNumber,
    required super.customerName,
    required super.meterType,
    required super.amount,
    required super.currency,
    required super.frequency,
    super.dayOfWeek,
    super.dayOfMonth,
    required super.status,
    required super.nextRunDate,
    super.lastRunDate,
    required super.failureCount,
    required super.maxRetries,
    required super.createdAt,
    required super.updatedAt,
  });

  factory AutoRechargeModel.fromProto(pb.AutoRecharge proto) {
    return AutoRechargeModel(
      id: proto.id,
      userId: proto.userId,
      beneficiaryId: proto.beneficiaryId,
      providerId: proto.providerId,
      providerCode: proto.providerCode,
      providerName: proto.providerName,
      meterNumber: proto.meterNumber,
      customerName: proto.customerName,
      meterType: MeterTypeExtension.fromString(proto.meterType),
      amount: proto.amount,
      currency: proto.currency,
      frequency: RechargeFrequencyExtension.fromString(proto.frequency),
      dayOfWeek: proto.hasDayOfWeek() ? proto.dayOfWeek : null,
      dayOfMonth: proto.hasDayOfMonth() ? proto.dayOfMonth : null,
      status: AutoRechargeStatusExtension.fromString(proto.status),
      nextRunDate: proto.nextRunDate.toDateTime(),
      lastRunDate: proto.hasLastRunDate() ? proto.lastRunDate.toDateTime() : null,
      failureCount: proto.failureCount,
      maxRetries: proto.maxRetries,
      createdAt: proto.createdAt.toDateTime(),
      updatedAt: proto.updatedAt.toDateTime(),
    );
  }

  pb.AutoRecharge toProto() {
    final proto = pb.AutoRecharge()
      ..id = id
      ..userId = userId
      ..beneficiaryId = beneficiaryId
      ..providerId = providerId
      ..providerCode = providerCode
      ..providerName = providerName
      ..meterNumber = meterNumber
      ..customerName = customerName
      ..meterType = meterType.name
      ..amount = amount
      ..currency = currency
      ..frequency = frequency.name
      ..status = status.name
      ..nextRunDate = $timestamp.Timestamp.fromDateTime(nextRunDate)
      ..failureCount = failureCount
      ..maxRetries = maxRetries
      ..createdAt = $timestamp.Timestamp.fromDateTime(createdAt)
      ..updatedAt = $timestamp.Timestamp.fromDateTime(updatedAt);

    if (dayOfWeek != null) {
      proto.dayOfWeek = dayOfWeek!;
    }

    if (dayOfMonth != null) {
      proto.dayOfMonth = dayOfMonth!;
    }

    if (lastRunDate != null) {
      proto.lastRunDate = $timestamp.Timestamp.fromDateTime(lastRunDate!);
    }

    return proto;
  }
}
