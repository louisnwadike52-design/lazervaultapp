import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';
import 'wallet_transfer_state.dart';
import '../utils/wallet_beam_scope.dart';

class WalletTransferCubit extends Cubit<WalletTransferState> {
  final IPaymentsTransferDataSource paymentsTransferDataSource;

  WalletTransferCubit({
    required this.paymentsTransferDataSource,
  }) : super(WalletTransferInitial());

  Future<void> transferBetweenAccounts({
    required String fromAccountId,
    required String toAccountNumber,
    required String type, // "internal" or "external" - PRIMARY KEY
    required double amount,
    required String description,
    required String transactionId,
    required String verificationToken,
    required String sourceAccountName,
    required String destinationAccountName,
    required String currency,
  }) async {
    try {
      if (isClosed) return;
      emit(WalletTransferLoading());
      final result = await paymentsTransferDataSource.sendFunds(
        fromAccountId: fromAccountId,
        toAccountNumber: toAccountNumber,
        type: type,
        amount: amount,
        description: description,
        transactionId: transactionId,
        verificationToken: verificationToken,
      );
      if (isClosed) return;
      if (result.success) {
        emit(WalletTransferSuccess(
          transferId: result.transferId,
          reference: result.reference,
          sourceAccountName: sourceAccountName,
          destinationAccountName: destinationAccountName,
          amount: amount,
          currency: currency,
          newBalance: result.newBalance,
        ));
      } else {
        emit(WalletTransferError(
          result.errorMessage ?? 'Transfer failed. Please try again.',
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(WalletTransferError(e.toString()));
    }
  }

  Future<void> getRecentWalletTransfers({
    required String accountId,
    int limit = 5,

    /// Every LazerVault account number the user holds.
    ///
    /// Keeps only wallet-to-wallet moves on the Beam tab. Empty means
    /// "unknown" and leaves the list unscoped — see [WalletBeamScope].
    Set<String> ownAccountNumbers = const {},
  }) async {
    try {
      if (isClosed) return;
      emit(WalletTransferHistoryLoading());
      final result = await paymentsTransferDataSource.getPaymentHistory(
        accountId: accountId,
        limit: limit,
        offset: 0,
      );
      if (isClosed) return;
      final scoped =
          WalletBeamScope.filter(result.transfers, ownAccountNumbers);
      emit(WalletTransferHistoryLoaded(
        // `total` drives the count the UI prints, so it must describe the list
        // the user is looking at — the unscoped server total would read
        // "12 transfers" above a list of three.
        transfers: scoped,
        total: scoped.length,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(WalletTransferHistoryError(e.toString()));
    }
  }

  Future<void> getWalletTransferHistory({
    required String accountId,
    int limit = 20,
    int offset = 0,
    Set<String> ownAccountNumbers = const {},
  }) async {
    try {
      if (isClosed) return;
      if (offset == 0) emit(WalletTransferHistoryLoading());
      final result = await paymentsTransferDataSource.getPaymentHistory(
        accountId: accountId,
        limit: limit,
        offset: offset,
      );
      if (isClosed) return;
      final scoped =
          WalletBeamScope.filter(result.transfers, ownAccountNumbers);
      emit(WalletTransferHistoryLoaded(
        transfers: scoped,
        total: scoped.length,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(WalletTransferHistoryError(e.toString()));
    }
  }

  void reset() {
    emit(WalletTransferInitial());
  }
}
