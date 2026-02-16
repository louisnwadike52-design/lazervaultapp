import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/entities/bill_payment_entity.dart';
import 'package:lazervault/src/generated/electricity_bill.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart' as $timestamp;

class BillBeneficiaryModel extends BillBeneficiaryEntity {
  const BillBeneficiaryModel({
    required super.id,
    required super.userId,
    required super.providerId,
    required super.providerCode,
    required super.providerName,
    required super.meterNumber,
    required super.customerName,
    super.customerAddress,
    super.phoneNumber,
    required super.meterType,
    required super.nickname,
    required super.isDefault,
    required super.createdAt,
    required super.updatedAt,
    super.lastUsedAt,
  });

  factory BillBeneficiaryModel.fromProto(pb.BillBeneficiary proto) {
    return BillBeneficiaryModel(
      id: proto.id,
      userId: proto.userId,
      providerId: proto.providerId,
      providerCode: proto.providerCode,
      providerName: proto.providerName,
      meterNumber: proto.meterNumber,
      customerName: proto.customerName,
      customerAddress: proto.hasCustomerAddress() ? proto.customerAddress : null,
      phoneNumber: proto.hasPhoneNumber() ? proto.phoneNumber : null,
      meterType: MeterTypeExtension.fromString(proto.meterType),
      nickname: proto.nickname,
      isDefault: proto.isDefault,
      createdAt: proto.createdAt.toDateTime(),
      updatedAt: proto.updatedAt.toDateTime(),
      lastUsedAt: proto.hasLastUsedAt() ? proto.lastUsedAt.toDateTime() : null,
    );
  }

  pb.BillBeneficiary toProto() {
    final proto = pb.BillBeneficiary()
      ..id = id
      ..userId = userId
      ..providerId = providerId
      ..providerCode = providerCode
      ..providerName = providerName
      ..meterNumber = meterNumber
      ..customerName = customerName
      ..meterType = meterType.name
      ..nickname = nickname
      ..isDefault = isDefault
      ..createdAt = $timestamp.Timestamp.fromDateTime(createdAt)
      ..updatedAt = $timestamp.Timestamp.fromDateTime(updatedAt);

    if (customerAddress != null) {
      proto.customerAddress = customerAddress!;
    }

    if (phoneNumber != null) {
      proto.phoneNumber = phoneNumber!;
    }

    if (lastUsedAt != null) {
      proto.lastUsedAt = $timestamp.Timestamp.fromDateTime(lastUsedAt!);
    }

    return proto;
  }
}
