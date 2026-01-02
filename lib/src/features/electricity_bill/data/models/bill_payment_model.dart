import '../../domain/entities/bill_payment_entity.dart';
import 'package:lazervault/src/generated/electricity_bill.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart' as $timestamp;

class BillPaymentModel extends BillPaymentEntity {
  const BillPaymentModel({
    required super.id,
    required super.userId,
    required super.providerId,
    required super.providerCode,
    required super.providerName,
    required super.meterNumber,
    required super.customerName,
    super.customerAddress,
    required super.meterType,
    required super.amount,
    required super.currency,
    required super.serviceFee,
    required super.totalAmount,
    required super.status,
    super.token,
    super.units,
    required super.paymentGateway,
    required super.referenceNumber,
    super.gatewayReference,
    super.errorMessage,
    required super.createdAt,
    required super.updatedAt,
    super.completedAt,
    super.failedAt,
  });

  factory BillPaymentModel.fromProto(pb.BillPayment proto) {
    return BillPaymentModel(
      id: proto.id,
      userId: proto.userId,
      providerId: proto.hasProviderId() ? proto.providerId : '',
      providerCode: proto.providerCode,
      providerName: proto.providerName,
      meterNumber: proto.meterNumber,
      customerName: proto.customerName,
      customerAddress: proto.hasCustomerAddress() ? proto.customerAddress : null,
      meterType: MeterTypeExtension.fromString(proto.meterType),
      amount: proto.amount,
      currency: proto.currency,
      serviceFee: proto.serviceFee,
      totalAmount: proto.totalAmount,
      status: BillPaymentStatusExtension.fromString(proto.status),
      token: proto.hasToken() ? proto.token : null,
      units: proto.hasUnits() ? proto.units : null,
      paymentGateway: proto.paymentGateway,
      referenceNumber: proto.referenceNumber,
      gatewayReference: proto.hasGatewayReference() ? proto.gatewayReference : null,
      errorMessage: proto.hasErrorMessage() ? proto.errorMessage : null,
      createdAt: proto.createdAt.toDateTime(),
      updatedAt: proto.updatedAt.toDateTime(),
      completedAt: proto.hasCompletedAt() ? proto.completedAt.toDateTime() : null,
      failedAt: proto.hasFailedAt() ? proto.failedAt.toDateTime() : null,
    );
  }

  pb.BillPayment toProto() {
    final proto = pb.BillPayment()
      ..id = id
      ..userId = userId
      ..providerCode = providerCode
      ..providerName = providerName
      ..meterNumber = meterNumber
      ..customerName = customerName
      ..meterType = meterType.name
      ..amount = amount
      ..serviceFee = serviceFee
      ..totalAmount = totalAmount
      ..currency = currency
      ..status = status.name
      ..paymentGateway = paymentGateway
      ..referenceNumber = referenceNumber
      ..createdAt = $timestamp.Timestamp.fromDateTime(createdAt)
      ..updatedAt = $timestamp.Timestamp.fromDateTime(updatedAt);

    if (providerId.isNotEmpty) {
      proto.providerId = providerId;
    }

    if (customerAddress != null) {
      proto.customerAddress = customerAddress!;
    }

    if (token != null) {
      proto.token = token!;
    }

    if (units != null) {
      proto.units = units!;
    }

    if (gatewayReference != null) {
      proto.gatewayReference = gatewayReference!;
    }

    if (errorMessage != null) {
      proto.errorMessage = errorMessage!;
    }

    if (completedAt != null) {
      proto.completedAt = $timestamp.Timestamp.fromDateTime(completedAt!);
    }

    if (failedAt != null) {
      proto.failedAt = $timestamp.Timestamp.fromDateTime(failedAt!);
    }

    return proto;
  }
}
