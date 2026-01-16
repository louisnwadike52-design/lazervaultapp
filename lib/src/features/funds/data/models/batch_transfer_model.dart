import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';

class BatchTransferRecipientModel extends BatchTransferRecipient {
  const BatchTransferRecipientModel({
    super.recipientId,
    super.toAccountId,
    required super.amount,
    super.reference,
    super.category,
  });

  factory BatchTransferRecipientModel.fromProto(dynamic protoRecipient) {
    return BatchTransferRecipientModel(
      recipientId: protoRecipient.recipientId,
      toAccountId: protoRecipient.toAccountId,
      amount: protoRecipient.amount,
      reference: protoRecipient.reference,
      category: protoRecipient.category,
    );
  }

  Map<String, dynamic> toProto() {
    return {
      'recipientId': recipientId,
      'toAccountId': toAccountId,
      'amount': amount,
      'reference': reference ?? '',
      'category': category ?? '',
    };
  }
}

class BatchTransferResultModel extends BatchTransferResult {
  const BatchTransferResultModel({
    required super.transferId,
    required super.status,
    required super.amount,
    required super.fee,
    super.recipientName,
    super.recipientAccount,
    super.failureReason,
  });

  factory BatchTransferResultModel.fromProto(dynamic protoResult) {
    return BatchTransferResultModel(
      transferId: protoResult.transferId,
      status: protoResult.status,
      amount: protoResult.amount,
      fee: protoResult.fee,
      recipientName: protoResult.recipientName,
      recipientAccount: protoResult.recipientAccount,
      failureReason: protoResult.failureReason,
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
    required super.createdAt,
    super.completedAt,
  });

  factory InitiateBatchTransferResponseModel.fromProto(dynamic protoResponse) {
    final results = (protoResponse.results as List)
        .map((result) => BatchTransferResultModel.fromProto(result))
        .toList();

    return InitiateBatchTransferResponseModel(
      batchId: protoResponse.batchId,
      status: protoResponse.status,
      totalAmount: protoResponse.totalAmount,
      totalFee: protoResponse.totalFee,
      totalAmountWithFee: protoResponse.totalAmountWithFee,
      successfulTransfers: protoResponse.successfulTransfers,
      failedTransfers: protoResponse.failedTransfers,
      totalTransfers: protoResponse.totalTransfers,
      results: results,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        protoResponse.createdAt.seconds.toInt() * 1000 +
            (protoResponse.createdAt.nanos / 1000000).round(),
        isUtc: true,
      ),
      completedAt: protoResponse.completedAt != null
          ? DateTime.fromMillisecondsSinceEpoch(
              protoResponse.completedAt.seconds.toInt() * 1000 +
                  (protoResponse.completedAt.nanos / 1000000).round(),
              isUtc: true,
            )
          : null,
    );
  }
} 