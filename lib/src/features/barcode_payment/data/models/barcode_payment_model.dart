import '../../domain/entities/barcode_payment_entity.dart';
import 'package:lazervault/src/grpc_generated/barcode_payment.pb.dart' as pb;
import 'package:lazervault/src/grpc_generated/google/protobuf/timestamp.pb.dart' as $timestamp;

class BarcodePaymentModel extends BarcodePaymentEntity {
  const BarcodePaymentModel({
    required super.id,
    required super.userId,
    required super.username,
    required super.fullName,
    required super.barcodeCode,
    required super.amount,
    required super.currency,
    required super.description,
    required super.status,
    required super.createdAt,
    required super.expiresAt,
    super.paidAt,
  });

  factory BarcodePaymentModel.fromProto(pb.BarcodePayment proto) {
    return BarcodePaymentModel(
      id: proto.id,
      userId: proto.userId,
      username: proto.username,
      fullName: proto.fullName,
      barcodeCode: proto.barcodeCode,
      amount: proto.amount,
      currency: proto.currency,
      description: proto.description,
      status: BarcodePaymentStatusExtension.fromString(proto.status),
      createdAt: proto.createdAt.toDateTime(),
      expiresAt: proto.expiresAt.toDateTime(),
      paidAt: proto.hasPaidAt() ? proto.paidAt.toDateTime() : null,
    );
  }

  pb.BarcodePayment toProto() {
    final proto = pb.BarcodePayment()
      ..id = id
      ..userId = userId
      ..username = username
      ..fullName = fullName
      ..barcodeCode = barcodeCode
      ..amount = amount
      ..currency = currency
      ..description = description
      ..status = status.name
      ..createdAt = $timestamp.Timestamp.fromDateTime(createdAt)
      ..expiresAt = $timestamp.Timestamp.fromDateTime(expiresAt);

    if (paidAt != null) {
      proto.paidAt = $timestamp.Timestamp.fromDateTime(paidAt!);
    }

    return proto;
  }
}
