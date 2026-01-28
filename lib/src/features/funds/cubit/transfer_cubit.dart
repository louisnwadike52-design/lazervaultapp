import 'package:bloc/bloc.dart';
import 'package:fixnum/fixnum.dart';

import 'package:lazervault/src/features/funds/cubit/transfer_state.dart';
import 'package:lazervault/src/features/funds/data/datasources/banking_transfer_data_source.dart';
import 'package:lazervault/src/features/funds/domain/entities/transfer_entity.dart';

class TransferCubit extends Cubit<TransferState> {
  final IBankingTransferDataSource bankingTransferDataSource;

  TransferCubit({required this.bankingTransferDataSource})
      : super(const TransferInitial());

  /// Initiate a domestic bank transfer (to external bank account)
  Future<void> initiateDomesticTransfer({
    required String userId,
    required String sourceAccountId,
    required int amount, // minor units
    required String destinationAccount,
    required String destinationBankCode,
    required String destinationName,
    String? currency,
    String? narration,
    String? reference,
  }) async {
    if (isClosed) return;
    emit(const TransferLoading());

    try {
      final result = await bankingTransferDataSource.initiateDomesticTransfer(
        userId: userId,
        sourceAccountId: sourceAccountId,
        amount: amount,
        destinationAccount: destinationAccount,
        destinationBankCode: destinationBankCode,
        destinationName: destinationName,
        currency: currency,
        narration: narration,
        reference: reference,
      );

      if (isClosed) return;

      if (result.success) {
        emit(TransferSuccess(response: _toEntity(result, amount)));
      } else {
        emit(TransferFailure(
            message: result.errorMessage ?? 'Transfer failed'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(TransferFailure(message: 'Transfer failed: ${e.toString()}'));
    }
  }

  /// Initiate an internal C2C transfer between LazerVault users
  Future<void> initiateInternalTransfer({
    required String fromUserId,
    required String toUserId,
    required int amount, // minor units
    String? currency,
    String? narration,
  }) async {
    if (isClosed) return;
    emit(const TransferLoading());

    try {
      final result = await bankingTransferDataSource.initiateInternalTransfer(
        fromUserId: fromUserId,
        toUserId: toUserId,
        amount: amount,
        currency: currency,
        narration: narration,
      );

      if (isClosed) return;

      if (result.success) {
        emit(TransferSuccess(response: _toEntity(result, amount)));
      } else {
        emit(TransferFailure(
            message: result.errorMessage ?? 'Transfer failed'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(TransferFailure(message: 'Transfer failed: ${e.toString()}'));
    }
  }

  /// Convert BankingTransferResult to TransferEntity for state
  TransferEntity _toEntity(BankingTransferResult result, int amountMinor) {
    return TransferEntity(
      transferId: Int64.parseInt(result.transferId ?? '0'),
      status: result.status ?? 'pending',
      amount: Int64(result.amount ?? amountMinor),
      fee: Int64(result.fee ?? 0),
      totalAmount: Int64((result.amount ?? amountMinor) + (result.fee ?? 0)),
      createdAt: result.createdAt ?? DateTime.now(),
    );
  }
}
