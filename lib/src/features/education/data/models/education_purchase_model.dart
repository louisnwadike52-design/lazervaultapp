import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/education_purchase_entity.dart';
import 'education_pin_model.dart';

class EducationPurchaseModel extends EducationPurchaseEntity {
  const EducationPurchaseModel({
    required super.id,
    required super.userId,
    required super.accountId,
    required super.billType,
    required super.providerId,
    required super.reference,
    required super.amount,
    required super.status,
    required super.customerNumber,
    required super.metadata,
    required super.createdAt,
    required super.newBalance,
    required super.pins,
    required super.message,
  });

  factory EducationPurchaseModel.fromProto({
    required pb.BillPayment payment,
    required double newBalance,
    required List<pb.EducationPinResult> pins,
    required String message,
  }) {
    return EducationPurchaseModel(
      id: payment.id,
      userId: payment.userId,
      accountId: payment.accountId,
      billType: payment.billType,
      providerId: payment.providerId,
      reference: payment.reference,
      amount: payment.amount,
      status: payment.status,
      customerNumber: payment.customerNumber,
      metadata: payment.metadata,
      createdAt: payment.createdAt,
      newBalance: newBalance,
      pins: pins.map((pin) => EducationPinModel.fromProto(pin)).toList(),
      message: message,
    );
  }
}
