import 'package:bloc/bloc.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';

import 'package:lazervault/core/offline/mutation_queue.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_state.dart';
import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';
import 'package:lazervault/src/features/funds/domain/entities/transfer_entity.dart';

class TransferCubit extends Cubit<TransferState> {
  final IPaymentsTransferDataSource paymentsTransferDataSource;
  final MutationQueue? mutationQueue;

  /// Cache the last fee lookup result so it can be used when building receipt details
  TransferFeeLoaded? lastFeeLoaded;

  TransferCubit({
    required this.paymentsTransferDataSource,
    this.mutationQueue,
  }) : super(const TransferInitial());

  /// Check if an error is a network-related error that should trigger offline queuing
  bool _isNetworkError(dynamic error) {
    if (error is GrpcError) {
      return error.code == StatusCode.unavailable ||
          error.code == StatusCode.deadlineExceeded ||
          error.code == StatusCode.unknown;
    }
    final errorStr = error.toString().toLowerCase();
    return errorStr.contains('network') ||
        errorStr.contains('connection') ||
        errorStr.contains('timeout') ||
        errorStr.contains('unavailable') ||
        errorStr.contains('failed to connect') ||
        errorStr.contains('socket') ||
        errorStr.contains('unreachable');
  }

  /// Get transfer fee for a given amount, currency, and transfer type.
  /// Internal transfers are always free. External transfers use tiered fees.
  Future<void> getTransferFee({
    required int amountMinorUnits,
    required String currency,
    required String transferType, // "internal", "domestic", "international"
    String? destinationBankCode,
  }) async {
    if (isClosed) return;
    emit(const TransferFeeLoading());

    try {
      // Internal transfers are always free
      if (transferType == 'internal') {
        final feeState = TransferFeeLoaded(
          fee: 0,
          currency: currency,
          feeType: 'flat',
          totalAmount: amountMinorUnits,
          breakdown: const [FeeBreakdownItem(label: 'Transfer Fee', amount: 0)],
        );
        lastFeeLoaded = feeState;
        emit(feeState);
        return;
      }

      // Calculate fee locally (matches backend tiered structure)
      final fee = _calculateTransferFee(amountMinorUnits, currency);

      if (isClosed) return;
      final feeState = TransferFeeLoaded(
        fee: fee,
        currency: currency,
        feeType: 'flat',
        totalAmount: amountMinorUnits + fee,
        breakdown: [FeeBreakdownItem(label: 'Transfer Fee', amount: fee)],
      );
      lastFeeLoaded = feeState;
      emit(feeState);
    } catch (e) {
      if (isClosed) return;
      emit(TransferFeeError(message: 'Failed to get transfer fee: $e'));
    }
  }

  /// Local fee calculation matching backend tiered structure
  int _calculateTransferFee(int amountMinorUnits, String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        final amountNaira = amountMinorUnits ~/ 100;
        if (amountNaira < 5000) return 1000;  // ₦10
        if (amountNaira < 50000) return 2500; // ₦25
        return 5000; // ₦50
      case 'GBP':
        return 50;   // £0.50
      case 'USD':
        return 25;   // $0.25
      case 'GHS':
        return 100;  // GHS 1.00
      case 'KES':
        return 5000; // KES 50
      case 'ZAR':
        return 750;  // ZAR 7.50
      default:
        return 0;
    }
  }

  /// Unified send funds method (works for both internal and external transfers)
  /// Uses Transfer Gateway (port 50076) -> Core-Payment-Service (port 50053)
  /// On network failure, queues the transfer for retry when online.
  Future<void> sendFunds({
    required String fromAccountId,
    required String toAccountNumber,
    required double amount,             // Amount in major units (e.g., 100.50)
    required String description,
    required String transactionId,
    required String verificationToken,
    DateTime? scheduledAt,
  }) async {
    if (isClosed) return;
    emit(const TransferLoading());

    try {
      final result = await paymentsTransferDataSource.sendFunds(
        fromAccountId: fromAccountId,
        toAccountNumber: toAccountNumber,
        amount: amount,
        description: description,
        transactionId: transactionId,
        verificationToken: verificationToken,
        scheduledAt: scheduledAt,
      );

      if (isClosed) return;

      if (result.success) {
        emit(TransferSuccess(response: _toEntity(result)));
      } else {
        emit(TransferFailure(message: result.errorMessage ?? 'Transfer failed'));
      }
    } catch (e) {
      if (isClosed) return;

      // For financial operations, show clear error and let user retry manually
      // NEVER queue payments offline - security tokens expire, balances change
      final errorMessage = e.toString();
      if (_isNetworkError(e)) {
        emit(const TransferFailure(
          message: 'No internet connection. Please check your network and try again.',
        ));
      } else {
        emit(TransferFailure(message: 'Transfer failed: $errorMessage'));
      }
    }
  }

  /// Convert PaymentsTransferResult to TransferEntity for state
  TransferEntity _toEntity(PaymentsTransferResult result) {
    final amountMinor = result.amount ?? 0;
    // Use response fee if available, otherwise fall back to cached fee lookup
    final feeMinor = result.fee ?? lastFeeLoaded?.fee ?? 0;
    return TransferEntity(
      transferId: result.transferId ?? '',  // UUID string, not Int64
      status: result.status ?? 'pending',
      amount: Int64(amountMinor),
      fee: Int64(feeMinor),
      totalAmount: Int64(amountMinor + feeMinor),
      createdAt: result.createdAt ?? DateTime.now(),
      scheduledAt: result.scheduledAt,
    );
  }
}
