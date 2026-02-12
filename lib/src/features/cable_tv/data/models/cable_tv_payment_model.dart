import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/cable_tv_payment_entity.dart';

class CableTVPaymentModel extends CableTVPaymentEntity {
  const CableTVPaymentModel({
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
    required super.renewalDate,
    required super.customerName,
  });

  factory CableTVPaymentModel.fromResponse({
    required pb.BillPayment payment,
    required double newBalance,
    required String renewalDate,
    required String customerName,
  }) {
    return CableTVPaymentModel(
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
      renewalDate: renewalDate,
      customerName: customerName,
    );
  }
}
