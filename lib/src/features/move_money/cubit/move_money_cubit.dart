import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/utils/debouncer.dart';

import '../data/datasources/move_money_grpc_datasource.dart';
import 'move_money_state.dart';

/// Cubit for managing move money feature state
class MoveMoneyCubit extends Cubit<MoveMoneyState> {
  final MoveMoneyGrpcDataSource _dataSource;
  final Debouncer _feeDebouncer = Debouncer.search(); // 500ms

  MoveMoneyCubit(this._dataSource) : super(MoveMoneyInitial());

  /// Calculate fee for a given amount (debounced)
  void calculateFeeDebounced(int amountKobo) {
    _feeDebouncer.run(() => calculateFee(amountKobo));
  }

  /// Calculate fee breakdown
  Future<void> calculateFee(int amountKobo) async {
    if (amountKobo <= 0) return;

    try {
      final feeCalc = await _dataSource.calculateMoveFee(amount: amountKobo);
      emit(MoveMoneyFeeCalculated(feeCalculation: feeCalc));
    } catch (e) {
      emit(MoveMoneyError(message: 'Failed to calculate fees: ${e.toString()}'));
    }
  }

  /// Initiate a move money transfer
  Future<void> initiateMoveTransfer({
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
    emit(MoveMoneyLoading());

    try {
      final transfer = await _dataSource.initiateMoveTransfer(
        userId: userId,
        sourceLinkedAccountId: sourceLinkedAccountId,
        destinationLinkedAccountId: destinationLinkedAccountId,
        amount: amount,
        currency: currency,
        narration: narration,
        transactionPin: transactionPin,
        idempotencyKey: idempotencyKey,
        verificationToken: verificationToken,
        transactionId: transactionId,
      );

      emit(MoveTransferInitiated(
        transfer: transfer,
        message: transfer.needsAuthorization
            ? 'Please complete authorization'
            : 'Transfer initiated successfully',
        requiresAuthorization: transfer.needsAuthorization,
        paymentUrl: transfer.paymentUrl,
      ));
    } catch (e) {
      emit(MoveMoneyError(message: 'Transfer failed: ${e.toString()}'));
    }
  }

  /// Get transfer status
  Future<void> getTransferStatus({
    required String transferId,
    required String userId,
  }) async {
    try {
      final transfer = await _dataSource.getMoveTransferStatus(
        transferId: transferId,
        userId: userId,
      );
      emit(MoveTransferStatusLoaded(transfer: transfer));
    } catch (e) {
      emit(MoveMoneyError(message: 'Failed to get transfer status: ${e.toString()}'));
    }
  }

  /// Get transfer history
  Future<void> getTransfers({
    required String userId,
    int limit = 20,
    int offset = 0,
    String? statusFilter,
  }) async {
    emit(MoveMoneyLoading());

    try {
      final (transfers, total) = await _dataSource.getMoveTransfers(
        userId: userId,
        limit: limit,
        offset: offset,
        statusFilter: statusFilter,
      );
      emit(MoveTransfersLoaded(transfers: transfers, total: total));
    } catch (e) {
      emit(MoveMoneyError(message: 'Failed to load transfers: ${e.toString()}'));
    }
  }

  @override
  Future<void> close() {
    _feeDebouncer.dispose();
    return super.close();
  }
}
