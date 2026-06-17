import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/exchange_prediction_remote_data_source.dart';
import 'exchange_prediction_state.dart';

/// Fetches the informational, READ-ONLY exchange success prediction shown on
/// the international transfer confirmation step. Non-blocking: any failure
/// resolves to [ExchangePredictionUnavailable] so the transfer flow is never
/// interrupted.
class ExchangePredictionCubit extends Cubit<ExchangePredictionState> {
  final IExchangePredictionRemoteDataSource _dataSource;

  ExchangePredictionCubit({
    required IExchangePredictionRemoteDataSource dataSource,
  })  : _dataSource = dataSource,
        super(const ExchangePredictionInitial());

  /// Fetch once the destination country + account/IBAN + currency pair are
  /// known. Safe to call multiple times — the cubit emits Loading first so
  /// re-fetches don't strand a stale Loaded state in the UI.
  ///
  /// [country] ISO-3166-1 alpha-2 (e.g. "GB", "US", "DE")
  /// [accountOrIban] IBAN for EUR, otherwise the account number / NUBAN
  /// [currencyPair] underscore-joined, e.g. "NGN_USD"
  Future<void> fetch({
    required String country,
    required String accountOrIban,
    required String currencyPair,
  }) async {
    if (country.isEmpty || accountOrIban.isEmpty || currencyPair.isEmpty) {
      if (!isClosed) emit(const ExchangePredictionUnavailable());
      return;
    }

    if (!isClosed) emit(const ExchangePredictionLoading());

    final prediction = await _dataSource.getRecipientTrust(
      country: country,
      accountOrIban: accountOrIban,
      currencyPair: currencyPair,
    );

    if (isClosed) return;

    if (prediction == null || prediction.isUnknown) {
      emit(const ExchangePredictionUnavailable());
      return;
    }

    emit(ExchangePredictionLoaded(prediction));
  }

  void reset() {
    if (!isClosed) emit(const ExchangePredictionInitial());
  }
}
