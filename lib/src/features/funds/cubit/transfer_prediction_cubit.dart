import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';
import 'transfer_prediction_state.dart';

/// Fetches the informational, READ-ONLY transfer success prediction for an
/// EXTERNAL transfer. Non-blocking: any failure resolves to
/// [TransferPredictionUnavailable] so the transfer flow is never interrupted.
class TransferPredictionCubit extends Cubit<TransferPredictionState> {
  final IPaymentsTransferDataSource paymentsTransferDataSource;

  TransferPredictionCubit({
    required this.paymentsTransferDataSource,
  }) : super(const TransferPredictionInitial());

  /// Fetch once the destination bank code + account number are known.
  Future<void> fetch({
    required String bankCode,
    required String accountNumber,
  }) async {
    if (bankCode.isEmpty || accountNumber.isEmpty) {
      if (!isClosed) emit(const TransferPredictionUnavailable());
      return;
    }

    if (!isClosed) emit(const TransferPredictionLoading());

    final prediction = await paymentsTransferDataSource.getTransferSuccessPrediction(
      bankCode: bankCode,
      accountNumber: accountNumber,
    );

    if (isClosed) return;

    if (prediction == null || prediction.isUnknown) {
      emit(const TransferPredictionUnavailable());
      return;
    }

    emit(TransferPredictionLoaded(prediction));
  }

  void reset() {
    if (!isClosed) emit(const TransferPredictionInitial());
  }
}
