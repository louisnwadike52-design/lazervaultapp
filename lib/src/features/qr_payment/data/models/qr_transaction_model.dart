import '../../domain/entities/qr_transaction_entity.dart';
import 'package:lazervault/src/generated/qr_pay.pb.dart' as pb;
import 'package:lazervault/src/generated/qr_pay.pbenum.dart' as pbenum;

class QRTransactionModel extends QRTransactionEntity {
  const QRTransactionModel({
    required super.id,
    required super.qrId,
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

  factory QRTransactionModel.fromProto(pb.QRTransaction proto) {
    return QRTransactionModel(
      id: proto.id,
      qrId: proto.qrId,
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
      status: _statusFromProto(proto.status),
      createdAt: proto.createdAt.toDateTime(),
    );
  }

  static QRTransactionStatus _statusFromProto(pbenum.QRStatus status) {
    switch (status) {
      case pbenum.QRStatus.QR_STATUS_PAID:
        return QRTransactionStatus.completed;
      default:
        return QRTransactionStatus.failed;
    }
  }
}
