import 'package:bloc/bloc.dart';
import 'package:fixnum/fixnum.dart';

import 'package:lazervault/src/features/funds/cubit/transfer_state.dart';
import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';
import 'package:lazervault/src/features/funds/domain/entities/transfer_entity.dart';

class TransferCubit extends Cubit<TransferState> {
  final IPaymentsTransferDataSource paymentsTransferDataSource;

  TransferCubit({required this.paymentsTransferDataSource})
      : super(const TransferInitial());

  /// Unified send funds method (works for both internal and external transfers)
  /// Uses Transfer Gateway (port 50076) -> Core-Payment-Service (port 50053)
  Future<void> sendFunds({
    required String fromAccountId,
    required String toAccountNumber,
    required double amount,             // Amount in major units (e.g., 100.50)
    required String description,
    required String transactionId,
    required String verificationToken,
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
      );

      if (isClosed) return;

      if (result.success) {
        emit(TransferSuccess(response: _toEntity(result)));
      } else {
        emit(TransferFailure(message: result.errorMessage ?? 'Transfer failed'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(TransferFailure(message: 'Transfer failed: ${e.toString()}'));
    }
  }

  /// Convert PaymentsTransferResult to TransferEntity for state
  TransferEntity _toEntity(PaymentsTransferResult result) {
    final amountMinor = result.amount ?? 0;
    return TransferEntity(
      transferId: result.transferId ?? '',  // UUID string, not Int64
      status: result.status ?? 'pending',
      amount: Int64(amountMinor),
      fee: Int64(result.fee ?? 0),
      totalAmount: Int64(amountMinor + (result.fee ?? 0)),
      createdAt: result.createdAt ?? DateTime.now(),
    );
  }
}
