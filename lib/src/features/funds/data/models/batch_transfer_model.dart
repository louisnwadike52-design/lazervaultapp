import 'package:fixnum/fixnum.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/generated/payments.pb.dart' as payments;

class BatchTransferResultModel extends BatchTransferResult {
  const BatchTransferResultModel({
    required super.transferId,
    required super.status,
    required super.amount,
    required super.fee,
    super.recipientName,
    super.recipientAccount,
    super.failureReason,
    super.reference,
    super.destinationBankCode,
    super.destinationBankName,
    super.transferType,
    super.beneficiaryName,
  });

  factory BatchTransferResultModel.fromPaymentsProto(
      payments.BatchTransferResultItem proto) {
    return BatchTransferResultModel(
      transferId: proto.transferId,
      status: proto.status,
      amount: Int64((proto.amount * 100).round()),
      fee: Int64((proto.fee * 100).round()),
      recipientName:
          proto.recipientName.isNotEmpty ? proto.recipientName : null,
      recipientAccount:
          proto.recipientAccount.isNotEmpty ? proto.recipientAccount : null,
      failureReason:
          proto.failureReason.isNotEmpty ? proto.failureReason : null,
      reference: proto.reference.isNotEmpty ? proto.reference : null,
      destinationBankCode:
          proto.destinationBankCode.isNotEmpty ? proto.destinationBankCode : null,
      destinationBankName:
          proto.destinationBankName.isNotEmpty ? proto.destinationBankName : null,
      transferType:
          proto.transferType.isNotEmpty ? proto.transferType : 'internal',
      beneficiaryName:
          proto.beneficiaryName.isNotEmpty ? proto.beneficiaryName : null,
    );
  }
}

class BatchTransferHistoryModel extends BatchTransferHistoryEntity {
  const BatchTransferHistoryModel({
    required super.batchId,
    required super.totalRecipients,
    required super.successful,
    required super.failed,
    required super.totalAmount,
    required super.totalFees,
    required super.status,
    required super.createdAt,
    required super.currency,
  });

  factory BatchTransferHistoryModel.fromProto(payments.BatchTransferSummary proto) {
    return BatchTransferHistoryModel(
      batchId: proto.batchId,
      totalRecipients: proto.totalRecipients,
      successful: proto.successful,
      failed: proto.failed,
      totalAmount: proto.totalAmount,
      totalFees: proto.totalFees,
      status: proto.status,
      createdAt: proto.createdAt.isNotEmpty
          ? DateTime.tryParse(proto.createdAt)?.toLocal() ?? DateTime.now()
          : DateTime.now(),
      currency: proto.currency.isNotEmpty ? proto.currency : 'NGN',
    );
  }
}

class BatchTransferDetailModel extends BatchTransferDetailEntity {
  const BatchTransferDetailModel({
    required super.summary,
    required super.items,
    required super.sourceAccountNumber,
    required super.sourceAccountName,
  });

  factory BatchTransferDetailModel.fromProto(payments.GetBatchTransferDetailResponse proto) {
    final summary = proto.hasSummary()
        ? BatchTransferHistoryModel.fromProto(proto.summary)
        : BatchTransferHistoryModel(
            batchId: '',
            totalRecipients: 0,
            successful: 0,
            failed: 0,
            totalAmount: 0,
            totalFees: 0,
            status: 'unknown',
            createdAt: DateTime.now(),
            currency: 'NGN',
          );

    final items = proto.items
        .map((item) => BatchTransferResultModel.fromPaymentsProto(item))
        .toList();

    return BatchTransferDetailModel(
      summary: summary,
      items: items,
      sourceAccountNumber: proto.sourceAccountNumber,
      sourceAccountName: proto.sourceAccountName,
    );
  }
}

class InitiateBatchTransferResponseModel extends BatchTransferEntity {
  const InitiateBatchTransferResponseModel({
    required super.batchId,
    required super.status,
    required super.totalAmount,
    required super.totalFee,
    required super.totalAmountWithFee,
    required super.successfulTransfers,
    required super.failedTransfers,
    required super.totalTransfers,
    required super.results,
    required super.newBalance,
    required super.message,
    required super.createdAt,
    super.completedAt,
  });

  factory InitiateBatchTransferResponseModel.fromPaymentsProto(
      payments.BatchTransferResponse proto) {
    final results = proto.results
        .map((r) => BatchTransferResultModel.fromPaymentsProto(r))
        .toList();

    final totalAmountMinor = Int64((proto.totalAmount * 100).round());
    final totalFeeMinor = Int64((proto.totalFee * 100).round());

    return InitiateBatchTransferResponseModel(
      batchId: proto.batchId,
      status: proto.status,
      totalAmount: totalAmountMinor,
      totalFee: totalFeeMinor,
      totalAmountWithFee: totalAmountMinor + totalFeeMinor,
      successfulTransfers: proto.successfulTransfers,
      failedTransfers: proto.failedTransfers,
      totalTransfers: proto.totalTransfers,
      results: results,
      newBalance: proto.newBalance,
      message: proto.message,
      createdAt: proto.createdAt.isNotEmpty
          ? DateTime.tryParse(proto.createdAt)?.toLocal() ?? DateTime.now()
          : DateTime.now(),
      completedAt: proto.completedAt.isNotEmpty
          ? DateTime.tryParse(proto.completedAt)?.toLocal()
          : null,
    );
  }
}
