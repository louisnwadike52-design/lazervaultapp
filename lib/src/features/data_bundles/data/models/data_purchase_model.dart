import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/data_purchase_entity.dart';

class DataPurchaseModel extends DataPurchaseEntity {
  const DataPurchaseModel({
    required super.id,
    required super.userId,
    required super.accountId,
    required super.reference,
    required super.amount,
    required super.status,
    required super.phoneNumber,
    required super.dataPlan,
    required super.newBalance,
    required super.commissionEarned,
    required super.providerReference,
    required super.createdAt,
    super.billType,
    super.refundSource,
    super.currency,
    super.metadata,
  });

  factory DataPurchaseModel.fromResponse(pb.BuyDataResponse response) {
    final payment = response.payment;
    // A successful gRPC response (no exception) with empty status means completed
    final effectiveStatus = payment.status.isEmpty ? 'completed' : payment.status;
    return DataPurchaseModel(
      id: payment.id,
      userId: payment.userId,
      accountId: payment.accountId,
      reference: payment.reference,
      amount: payment.amount,
      status: effectiveStatus,
      phoneNumber: response.phoneNumber,
      dataPlan: response.dataPlan,
      newBalance: response.newBalance,
      commissionEarned: response.commissionEarned,
      providerReference: response.providerReference,
      createdAt: payment.createdAt,
      billType: payment.billType,
    );
  }

  /// Hydrate from the unified `GetBillPaymentHistory` response. Rows come
  /// in with `bill_type ∈ {data, intl_data}` — we store the raw bill_type
  /// so the entity's `isInternational` flag picks up `intl_data` for free.
  factory DataPurchaseModel.fromBillPaymentProto(pb.BillPayment payment) {
    return DataPurchaseModel(
      id: payment.id,
      userId: payment.userId,
      accountId: payment.accountId,
      reference: payment.reference,
      amount: payment.amount,
      status: payment.status,
      phoneNumber: payment.customerNumber,
      dataPlan: payment.providerId,
      newBalance: 0,
      commissionEarned: 0,
      providerReference: payment.reference,
      createdAt: payment.createdAt,
      billType: payment.billType,
      refundSource:
          payment.hasRefundSource() ? payment.refundSource : '',
      // Metadata carries FX breakdown for intl rows; parsed lazily in
      // the entity via `metadataMap`. Currency (sender_currency) is also
      // embedded there since BillPayment proto has no currency field.
      metadata: payment.hasMetadata() ? payment.metadata : '',
    );
  }
}
