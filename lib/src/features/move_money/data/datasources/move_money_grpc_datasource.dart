import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/banking.pbgrpc.dart' as banking;
import 'package:lazervault/src/generated/banking.pb.dart' as banking_pb;

import '../../domain/entities/move_transfer.dart';
import '../../domain/entities/move_fee_calculation.dart';

/// gRPC data source for Move Money operations
class MoveMoneyGrpcDataSource {
  final banking.BankingServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  MoveMoneyGrpcDataSource(this._client, this._callOptionsHelper);

  /// Initiate a move money transfer
  Future<MoveTransfer> initiateMoveTransfer({
    required String userId,
    required String sourceLinkedAccountId,
    required String destinationLinkedAccountId,
    required int amount,
    String currency = 'NGN',
    String? narration,
    String? transactionPin,
    String? idempotencyKey,
    String? verificationToken,
    String? transactionId,
  }) async {
    final response = await _callOptionsHelper.executeWithTokenRotation(() async {
      final callOptions = await _callOptionsHelper.withAuth();
      return await _client.initiateMoveTransfer(
        banking_pb.InitiateMoveTransferRequest(
          userId: userId,
          sourceLinkedAccountId: sourceLinkedAccountId,
          destinationLinkedAccountId: destinationLinkedAccountId,
          amount: Int64(amount),
          currency: currency,
          narration: narration ?? '',
          transactionPin: transactionPin ?? '',
          idempotencyKey: idempotencyKey ?? '',
          verificationToken: verificationToken ?? '',
          transactionId: transactionId ?? '',
        ),
        options: callOptions.mergedWith(
          CallOptions(timeout: const Duration(seconds: 30)),
        ),
      );
    });

    if (!response.success) {
      throw Exception(
        response.errorMessage.isNotEmpty ? response.errorMessage : 'Transfer failed',
      );
    }

    return _moveTransferFromProto(response.transfer);
  }

  /// Get move transfer status
  Future<MoveTransfer> getMoveTransferStatus({
    required String transferId,
    required String userId,
  }) async {
    final callOptions = await _callOptionsHelper.withAuth();
    final response = await _client.getMoveTransferStatus(
      banking_pb.GetMoveTransferStatusRequest(
        transferId: transferId,
        userId: userId,
      ),
      options: callOptions.mergedWith(
        CallOptions(timeout: const Duration(seconds: 15)),
      ),
    );

    if (!response.success) {
      throw Exception(
        response.errorMessage.isNotEmpty ? response.errorMessage : 'Transfer not found',
      );
    }

    return _moveTransferFromProto(response.transfer);
  }

  /// Get move transfer history
  Future<(List<MoveTransfer>, int)> getMoveTransfers({
    required String userId,
    int limit = 20,
    int offset = 0,
    String? statusFilter,
  }) async {
    final callOptions = await _callOptionsHelper.withAuth();
    final response = await _client.getMoveTransfers(
      banking_pb.GetMoveTransfersRequest(
        userId: userId,
        limit: limit,
        offset: offset,
        statusFilter: statusFilter ?? '',
      ),
      options: callOptions.mergedWith(
        CallOptions(timeout: const Duration(seconds: 15)),
      ),
    );

    if (!response.success) {
      throw Exception(
        response.errorMessage.isNotEmpty ? response.errorMessage : 'Failed to fetch transfers',
      );
    }

    final transfers = response.transfers.map(_moveTransferFromProto).toList();
    return (transfers, response.total);
  }

  /// Calculate move fee
  Future<MoveFeeCalculation> calculateMoveFee({
    required int amount,
    String countryCode = 'NG',
  }) async {
    final callOptions = await _callOptionsHelper.withAuth();
    final response = await _client.calculateMoveFee(
      banking_pb.CalculateMoveFeeRequest(
        amount: Int64(amount),
        countryCode: countryCode,
      ),
      options: callOptions.mergedWith(
        CallOptions(timeout: const Duration(seconds: 10)),
      ),
    );

    if (!response.success) {
      throw Exception(
        response.errorMessage.isNotEmpty ? response.errorMessage : 'Fee calculation failed',
      );
    }

    return MoveFeeCalculation(
      amount: response.amount.toInt(),
      debitFee: response.debitFee.toInt(),
      transferFee: response.transferFee.toInt(),
      stampDuty: response.stampDuty.toInt(),
      serviceFee: response.serviceFee.toInt(),
      totalFee: response.totalFee.toInt(),
      totalDebit: response.totalDebit.toInt(),
      currency: response.currency,
      breakdown: response.breakdown
          .map((item) => MoveFeeItem(
                label: item.label,
                amount: item.amount.toInt(),
              ))
          .toList(),
      minAmount: response.minAmount.toInt(),
      maxAmount: response.maxAmount.toInt(),
    );
  }

  /// Convert proto MoveTransfer to domain entity
  MoveTransfer _moveTransferFromProto(banking_pb.MoveTransfer pb) {
    return MoveTransfer(
      id: pb.id,
      userId: pb.userId,
      sourceLinkedAccountId: pb.sourceLinkedAccountId,
      sourceBankName: pb.sourceBankName,
      sourceAccountNumber: pb.sourceAccountNumber,
      sourceAccountName: pb.sourceAccountName,
      destinationLinkedAccountId: pb.destinationLinkedAccountId,
      destinationBankName: pb.destinationBankName,
      destinationAccountNumber: pb.destinationAccountNumber,
      destinationAccountName: pb.destinationAccountName,
      amount: pb.amount.toInt(),
      debitFee: pb.debitFee.toInt(),
      transferFee: pb.transferFee.toInt(),
      stampDuty: pb.stampDuty.toInt(),
      serviceFee: pb.serviceFee.toInt(),
      totalFee: pb.totalFee.toInt(),
      totalDebit: pb.totalDebit.toInt(),
      status: MoveTransferStatus.fromString(pb.status),
      reference: pb.reference,
      debitReference: pb.debitReference.isEmpty ? null : pb.debitReference,
      payoutReference: pb.payoutReference.isEmpty ? null : pb.payoutReference,
      failureCode: pb.failureCode.isEmpty ? null : pb.failureCode,
      failureReason: pb.failureReason.isEmpty ? null : pb.failureReason,
      failureStage: pb.failureStage.isEmpty ? null : pb.failureStage,
      paymentUrl: pb.paymentUrl.isEmpty ? null : pb.paymentUrl,
      paymentId: pb.paymentId.isEmpty ? null : pb.paymentId,
      currency: pb.currency,
      narration: pb.narration.isEmpty ? null : pb.narration,
      createdAt: pb.createdAt.toDateTime(),
      debitCompletedAt: pb.hasDebitCompletedAt() ? pb.debitCompletedAt.toDateTime() : null,
      payoutCompletedAt: pb.hasPayoutCompletedAt() ? pb.payoutCompletedAt.toDateTime() : null,
      completedAt: pb.hasCompletedAt() ? pb.completedAt.toDateTime() : null,
      failedAt: pb.hasFailedAt() ? pb.failedAt.toDateTime() : null,
    );
  }
}
