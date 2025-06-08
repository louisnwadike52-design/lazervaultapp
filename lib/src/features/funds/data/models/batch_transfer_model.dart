import 'package:equatable/equatable.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';

class BatchTransferRecipientModel extends BatchTransferRecipient {
  const BatchTransferRecipientModel({
    Int64? recipientId,
    Int64? toAccountId,
    required Int64 amount,
    String? reference,
    String? category,
  }) : super(
          recipientId: recipientId,
          toAccountId: toAccountId,
          amount: amount,
          reference: reference,
          category: category,
        );

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
    required Int64 transferId,
    required String status,
    required Int64 amount,
    required Int64 fee,
    String? recipientName,
    String? recipientAccount,
    String? failureReason,
  }) : super(
          transferId: transferId,
          status: status,
          amount: amount,
          fee: fee,
          recipientName: recipientName,
          recipientAccount: recipientAccount,
          failureReason: failureReason,
        );

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
    required Int64 batchId,
    required String status,
    required Int64 totalAmount,
    required Int64 totalFee,
    required Int64 totalAmountWithFee,
    required int successfulTransfers,
    required int failedTransfers,
    required int totalTransfers,
    required List<BatchTransferResult> results,
    required DateTime createdAt,
    DateTime? completedAt,
  }) : super(
          batchId: batchId,
          status: status,
          totalAmount: totalAmount,
          totalFee: totalFee,
          totalAmountWithFee: totalAmountWithFee,
          successfulTransfers: successfulTransfers,
          failedTransfers: failedTransfers,
          totalTransfers: totalTransfers,
          results: results,
          createdAt: createdAt,
          completedAt: completedAt,
        );

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