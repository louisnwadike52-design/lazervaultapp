import '../../domain/entities/id_pay_transaction_entity.dart';
import 'package:lazervault/src/generated/id_pay.pb.dart' as pb;

class IDPayTransactionModel extends IDPayTransactionEntity {
  const IDPayTransactionModel({
    required super.id,
    required super.payId,
    required super.payerId,
    required super.payerName,
    required super.payerUsername,
    required super.recipientId,
    required super.recipientName,
    required super.amount,
    required super.currency,
    required super.reference,
    required super.status,
    required super.createdAt,
  });

  factory IDPayTransactionModel.fromProto(pb.IDPayTransaction proto) {
    return IDPayTransactionModel(
      id: proto.id,
      payId: proto.payId,
      payerId: proto.payerId,
      payerName: proto.payerName,
      payerUsername: proto.payerUsername,
      recipientId: proto.recipientId,
      recipientName: proto.recipientName,
      amount: proto.amount,
      currency: proto.currency,
      reference: proto.reference,
      status: proto.status,
      createdAt: proto.createdAt.toDateTime(),
    );
  }
}
