import 'package:lazervault/src/features/funds/domain/entities/saved_batch_entity.dart';
import 'package:lazervault/src/generated/payments_saved_batches.pb.dart'
    as sb_proto;

DateTime? _tryParseTs(String s) {
  if (s.isEmpty) return null;
  return DateTime.tryParse(s)?.toLocal();
}

class SavedBatchItemModel extends SavedBatchItemEntity {
  const SavedBatchItemModel({
    required super.id,
    required super.savedBatchId,
    required super.recipientType,
    required super.recipientUserId,
    required super.bankCode,
    required super.accountNumber,
    required super.beneficiaryName,
    required super.amount,
    required super.narration,
    required super.sortOrder,
    super.createdAt,
    super.updatedAt,
  });

  factory SavedBatchItemModel.fromProto(sb_proto.SavedBatchItem proto) {
    return SavedBatchItemModel(
      id: proto.id,
      savedBatchId: proto.savedBatchId,
      recipientType:
          proto.recipientType.isEmpty ? 'external_bank' : proto.recipientType,
      recipientUserId: proto.recipientUserId,
      bankCode: proto.bankCode,
      accountNumber: proto.accountNumber,
      beneficiaryName: proto.beneficiaryName,
      amount: proto.amount,
      narration: proto.narration,
      sortOrder: proto.sortOrder,
      createdAt: _tryParseTs(proto.createdAt),
      updatedAt: _tryParseTs(proto.updatedAt),
    );
  }
}

class SavedBatchModel extends SavedBatchEntity {
  const SavedBatchModel({
    required super.id,
    required super.userId,
    required super.name,
    required super.currency,
    required super.sourceAccountId,
    required super.totalAmount,
    required super.itemCount,
    required super.items,
    super.createdAt,
    super.updatedAt,
  });

  factory SavedBatchModel.fromProto(sb_proto.SavedBatch proto) {
    final items = proto.items
        .map<SavedBatchItemEntity>(
            (item) => SavedBatchItemModel.fromProto(item))
        .toList(growable: false);
    return SavedBatchModel(
      id: proto.id,
      userId: proto.userId,
      name: proto.name,
      currency: proto.currency.isEmpty ? 'NGN' : proto.currency,
      sourceAccountId: proto.sourceAccountId,
      totalAmount: proto.totalAmount,
      itemCount: proto.itemCount,
      items: items,
      createdAt: _tryParseTs(proto.createdAt),
      updatedAt: _tryParseTs(proto.updatedAt),
    );
  }
}

class BatchReceiptItemModel extends BatchReceiptItemEntity {
  const BatchReceiptItemModel({
    required super.itemId,
    required super.status,
    required super.amount,
    required super.fee,
    required super.currency,
    required super.reference,
    required super.recipientName,
    required super.recipientAccount,
    required super.bankCode,
    required super.bankName,
    required super.transferType,
    required super.narration,
    required super.failureReason,
    required super.providerName,
    required super.providerRef,
    required super.providerStatus,
    required super.paymentId,
    required super.paymentStatus,
    required super.paymentReference,
    super.createdAt,
    super.updatedAt,
    super.transactionDate,
  });

  factory BatchReceiptItemModel.fromProto(sb_proto.BatchReceiptItem proto) {
    return BatchReceiptItemModel(
      itemId: proto.itemId,
      status: proto.status,
      amount: proto.amount,
      fee: proto.fee,
      currency: proto.currency,
      reference: proto.reference,
      recipientName: proto.recipientName,
      recipientAccount: proto.recipientAccount,
      bankCode: proto.bankCode,
      bankName: proto.bankName,
      transferType: proto.transferType,
      narration: proto.narration,
      failureReason: proto.failureReason,
      providerName: proto.providerName,
      providerRef: proto.providerRef,
      providerStatus: proto.providerStatus,
      paymentId: proto.paymentId,
      paymentStatus: proto.paymentStatus,
      paymentReference: proto.paymentReference,
      createdAt: _tryParseTs(proto.createdAt),
      updatedAt: _tryParseTs(proto.updatedAt),
      transactionDate: _tryParseTs(proto.transactionDate),
    );
  }
}

class BatchReceiptModel extends BatchReceiptEntity {
  const BatchReceiptModel({
    required super.batchId,
    required super.userId,
    required super.status,
    required super.currency,
    required super.totalTransfers,
    required super.successfulTransfers,
    required super.failedTransfers,
    required super.totalAmount,
    required super.totalFees,
    required super.sourceAccountId,
    required super.sourceAccountNumber,
    required super.sourceAccountName,
    required super.items,
    super.createdAt,
    super.updatedAt,
    super.finalizedAt,
  });

  factory BatchReceiptModel.fromProto(sb_proto.BatchReceipt proto) {
    final items = proto.items
        .map<BatchReceiptItemEntity>(
            (it) => BatchReceiptItemModel.fromProto(it))
        .toList(growable: false);
    return BatchReceiptModel(
      batchId: proto.batchId,
      userId: proto.userId,
      status: proto.status,
      currency: proto.currency,
      totalTransfers: proto.totalTransfers,
      successfulTransfers: proto.successfulTransfers,
      failedTransfers: proto.failedTransfers,
      totalAmount: proto.totalAmount,
      totalFees: proto.totalFees,
      sourceAccountId: proto.sourceAccountId,
      sourceAccountNumber: proto.sourceAccountNumber,
      sourceAccountName: proto.sourceAccountName,
      items: items,
      createdAt: _tryParseTs(proto.createdAt),
      updatedAt: _tryParseTs(proto.updatedAt),
      finalizedAt: _tryParseTs(proto.finalizedAt),
    );
  }
}

class BatchItemReceiptModel extends BatchItemReceiptEntity {
  const BatchItemReceiptModel({
    required super.batchId,
    required super.batchStatus,
    required super.sourceAccountId,
    required super.sourceAccountNumber,
    required super.sourceAccountName,
    required super.item,
  });

  factory BatchItemReceiptModel.fromProto(sb_proto.BatchItemReceipt proto) {
    return BatchItemReceiptModel(
      batchId: proto.batchId,
      batchStatus: proto.batchStatus,
      sourceAccountId: proto.sourceAccountId,
      sourceAccountNumber: proto.sourceAccountNumber,
      sourceAccountName: proto.sourceAccountName,
      item: BatchReceiptItemModel.fromProto(proto.item),
    );
  }
}
