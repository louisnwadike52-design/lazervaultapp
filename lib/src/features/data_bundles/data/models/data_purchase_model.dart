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
    );
  }
}
