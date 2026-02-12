import '../../domain/entities/qr_payment_entity.dart';
import 'package:lazervault/src/generated/qr_pay.pb.dart' as pb;

class QRPaymentModel extends QRPaymentEntity {
  const QRPaymentModel({
    required super.id,
    required super.userId,
    required super.username,
    required super.fullName,
    required super.qrCode,
    required super.amount,
    required super.currency,
    required super.description,
    required super.qrType,
    required super.status,
    required super.createdAt,
    required super.expiresAt,
    super.paidAt,
  });

  factory QRPaymentModel.fromProto(pb.QRCode proto) {
    return QRPaymentModel(
      id: proto.id,
      userId: proto.userId,
      username: proto.username,
      fullName: proto.fullName,
      qrCode: proto.qrCode,
      amount: proto.amount,
      currency: proto.currency,
      description: proto.description,
      qrType: proto.qrType == pb.QRType.QR_TYPE_STATIC
          ? QRPaymentType.static
          : QRPaymentType.dynamic,
      status: _statusFromProto(proto.status),
      createdAt: proto.createdAt.toDateTime(),
      expiresAt: proto.expiresAt.toDateTime(),
      paidAt: proto.hasPaidAt() ? proto.paidAt.toDateTime() : null,
    );
  }

  static QRPaymentStatus _statusFromProto(pb.QRStatus status) {
    switch (status) {
      case pb.QRStatus.QR_STATUS_PENDING:
        return QRPaymentStatus.pending;
      case pb.QRStatus.QR_STATUS_PAID:
        return QRPaymentStatus.paid;
      case pb.QRStatus.QR_STATUS_CANCELLED:
        return QRPaymentStatus.cancelled;
      case pb.QRStatus.QR_STATUS_EXPIRED:
        return QRPaymentStatus.expired;
      default:
        return QRPaymentStatus.pending;
    }
  }
}
