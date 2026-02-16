import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/internet_payment_entity.dart';

class InternetPaymentModel extends InternetPaymentEntity {
  const InternetPaymentModel({
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
  });

  factory InternetPaymentModel.fromResponse({
    required pb.BillPayment payment,
    required double newBalance,
    required String renewalDate,
  }) {
    return InternetPaymentModel(
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
    );
  }
}
