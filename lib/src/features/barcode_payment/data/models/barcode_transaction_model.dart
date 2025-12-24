import '../../domain/entities/barcode_transaction_entity.dart';
import 'package:lazervault/src/grpc_generated/barcode_payment.pb.dart' as pb;
import 'package:lazervault/src/grpc_generated/google/protobuf/timestamp.pb.dart' as $timestamp;

class BarcodeTransactionModel extends BarcodeTransactionEntity {
  const BarcodeTransactionModel({
    required super.id,
    required super.barcodeId,
    required super.payerId,
    required super.payerUsername,
    required super.payerName,
    required super.recipientId,
    required super.recipientUsername,
    required super.recipientName,
    required super.amount,
    required super.currency,
    required super.description,
    required super.referenceNumber,
    required super.status,
    required super.createdAt,
  });

  factory BarcodeTransactionModel.fromProto(pb.BarcodeTransaction proto) {
    return BarcodeTransactionModel(
      id: proto.id,
      barcodeId: proto.barcodeId,
      payerId: proto.payerId,
      payerUsername: proto.payerUsername,
      payerName: proto.payerName,
      recipientId: proto.recipientId,
      recipientUsername: proto.recipientUsername,
      recipientName: proto.recipientName,
      amount: proto.amount,
      currency: proto.currency,
      description: proto.description,
      referenceNumber: proto.referenceNumber,
      status: BarcodeTransactionStatusExtension.fromString(proto.status),
      createdAt: proto.createdAt.toDateTime(),
    );
  }

  pb.BarcodeTransaction toProto() {
    return pb.BarcodeTransaction()
      ..id = id
      ..barcodeId = barcodeId
      ..payerId = payerId
      ..payerUsername = payerUsername
      ..payerName = payerName
      ..recipientId = recipientId
      ..recipientUsername = recipientUsername
      ..recipientName = recipientName
      ..amount = amount
      ..currency = currency
      ..description = description
      ..referenceNumber = referenceNumber
      ..status = status.name
      ..createdAt = $timestamp.Timestamp.fromDateTime(createdAt);
  }
}
