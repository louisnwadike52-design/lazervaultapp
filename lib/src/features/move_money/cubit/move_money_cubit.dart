import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/utils/debouncer.dart';

import '../data/datasources/move_money_grpc_datasource.dart';
import 'move_money_state.dart';

/// Cubit for managing move money feature state
class MoveMoneyCubit extends Cubit<MoveMoneyState> {
  final MoveMoneyGrpcDataSource _dataSource;
  final Debouncer _feeDebouncer = Debouncer.search(); // 500ms
  Timer? _pollTimer;
  int _pollAttempts = 0;
  static const int _maxPollAttempts = 60; // 5 minutes at 5s intervals
  int _feeRetryCount = 0;
  static const int _maxFeeRetries = 3;

  MoveMoneyCubit(this._dataSource) : super(MoveMoneyInitial());

  /// Calculate fee for a given amount (debounced)
  void calculateFeeDebounced(int amountKobo) {
    _feeRetryCount = 0;
    _feeDebouncer.run(() => calculateFee(amountKobo));
  }

  /// Calculate fee breakdown
  Future<void> calculateFee(int amountKobo) async {
    if (amountKobo <= 0) return;

    try {
      final feeCalc = await _dataSource.calculateMoveFee(amount: amountKobo);
      _feeRetryCount = 0;
      emit(MoveMoneyFeeCalculated(feeCalculation: feeCalc));
    } catch (e) {
      emit(MoveMoneyFeeError(
        message: 'Failed to calculate fees. Tap to retry.',
        lastAmount: amountKobo,
        retryCount: _feeRetryCount,
      ));
    }
  }

  /// Retry fee calculation with exponential backoff
  Future<void> retryFeeCalculation(int amountKobo) async {
    if (_feeRetryCount >= _maxFeeRetries) {
      emit(MoveMoneyFeeError(
        message: 'Fee calculation unavailable. Please try again later.',
        lastAmount: amountKobo,
        retryCount: _feeRetryCount,
      ));
      return;
    }

    _feeRetryCount++;
    // Exponential backoff: 1s, 2s, 4s
    final delay = Duration(milliseconds: pow(2, _feeRetryCount - 1).toInt() * 1000);
    await Future.delayed(delay);
    if (isClosed) return;
    await calculateFee(amountKobo);
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
    } on MoveMoneyException catch (e) {
      _emitTypedError(e, sourceLinkedAccountId);
    } catch (e) {
      emit(MoveMoneyError(message: 'Transfer failed: ${e.toString()}'));
    }
  }

  /// Emit typed error state based on backend error code
  void _emitTypedError(MoveMoneyException e, String sourceAccountId) {
    switch (e.code) {
      case 'INSUFFICIENT_FUNDS':
        emit(MoveMoneyInsufficientFunds(
          message: e.message,
          availableBalance: 0,
          requiredAmount: 0,
        ));
      case 'REAUTHORIZATION_REQUIRED':
        emit(MoveMoneyNeedsReauth(
          accountId: sourceAccountId,
          message: e.message,
        ));
      case 'MANDATE_NOT_ACTIVE' || 'MANDATE_EXPIRED':
        emit(MoveMoneyMandateRequired(
          accountId: sourceAccountId,
          message: e.message,
        ));
      case 'RATE_LIMIT_EXCEEDED':
        // Try to extract retry-after seconds from message (e.g., "... try again in 30s")
        final retrySeconds = _parseRetryAfterSeconds(e.message);
        emit(MoveMoneyRateLimited(
          retryAfter: Duration(seconds: retrySeconds),
          message: e.message,
        ));
      case 'AMOUNT_BELOW_MINIMUM':
        emit(MoveMoneyError(
          message: 'Minimum transfer amount is NGN 1,500.',
          errorCode: e.code,
        ));
      case 'AMOUNT_ABOVE_MAXIMUM':
        emit(MoveMoneyError(
          message: 'Maximum transfer amount is NGN 5,000,000.',
          errorCode: e.code,
        ));
      case 'CROSS_CURRENCY':
        emit(MoveMoneyError(
          message: 'Source and destination accounts must use the same currency.',
          errorCode: e.code,
        ));
      case 'SAME_ACCOUNT':
        emit(MoveMoneyError(
          message: 'Source and destination cannot be the same account.',
          errorCode: e.code,
        ));
      case 'ACCOUNT_FROZEN':
        emit(MoveMoneyError(
          message: 'This account is restricted. Please contact support.',
          errorCode: e.code,
        ));
      case 'DUPLICATE_TRANSACTION':
        emit(MoveMoneyError(
          message: 'This transfer is already being processed.',
          errorCode: e.code,
        ));
      case 'SERVICE_UNAVAILABLE' || 'PROVIDER_ERROR':
        emit(MoveMoneyError(
          message: 'Bank service is temporarily unavailable. Please try again later.',
          errorCode: e.code,
        ));
      case 'PIN_VALIDATION_FAILED':
        emit(MoveMoneyError(message: e.message, errorCode: e.code));
      default:
        emit(MoveMoneyError(message: e.message, errorCode: e.code));
    }
  }

  /// Parse retry-after seconds from error message. Falls back to 30s.
  int _parseRetryAfterSeconds(String message) {
    final match = RegExp(r'(\d+)\s*s').firstMatch(message);
    if (match != null) {
      final seconds = int.tryParse(match.group(1)!);
      if (seconds != null && seconds > 0 && seconds <= 300) return seconds;
    }
    return 30; // Default 30 seconds
  }

  /// Poll transfer status with timeout
  void startPollingTransferStatus({
    required String transferId,
    required String userId,
  }) {
    _pollAttempts = 0;
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (isClosed) {
        timer.cancel();
        return;
      }

      _pollAttempts++;
      if (_pollAttempts > _maxPollAttempts) {
        timer.cancel();
        emit(MoveMoneyTransferTimeout(
          transferId: transferId,
          reference: '',
        ));
        return;
      }

      try {
        final transfer = await _dataSource.getMoveTransferStatus(
          transferId: transferId,
          userId: userId,
        );

        if (isClosed) {
          timer.cancel();
          return;
        }

        emit(MoveTransferStatusLoaded(transfer: transfer));

        // Stop polling on terminal states
        if (transfer.status.isTerminal || transfer.needsAuthorization) {
          timer.cancel();
        }
      } catch (_) {
        // Continue polling on transient errors
      }
    });
  }

  /// Stop polling
  void stopPolling() {
    _pollTimer?.cancel();
    _pollTimer = null;
    _pollAttempts = 0;
  }

  /// Get transfer status (single call)
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
    _pollTimer?.cancel();
    return super.close();
  }
}
