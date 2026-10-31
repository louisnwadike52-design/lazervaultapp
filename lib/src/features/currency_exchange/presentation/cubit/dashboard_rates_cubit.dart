import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/i_exchange_repository.dart';
import 'dashboard_rates_state.dart';

class DashboardRatesCubit extends Cubit<DashboardRatesState> {
  final IExchangeRepository _repository;
  Timer? _refreshTimer;
  String _baseCurrency = 'NGN';

  // Cache currencies locally so refreshes don't re-fetch them
  List<SupportedCurrencyInfo>? _cachedCurrencies;

  static const _flagEmojis = {
    'NG': '\u{1F1F3}\u{1F1EC}',
    'US': '\u{1F1FA}\u{1F1F8}',
    'GB': '\u{1F1EC}\u{1F1E7}',
    'EU': '\u{1F1EA}\u{1F1FA}',
    'GH': '\u{1F1EC}\u{1F1ED}',
    'KE': '\u{1F1F0}\u{1F1EA}',
    'ZA': '\u{1F1FF}\u{1F1E6}',
    'UG': '\u{1F1FA}\u{1F1EC}',
    'TZ': '\u{1F1F9}\u{1F1FF}',
    'RW': '\u{1F1F7}\u{1F1FC}',
  };

  static const _currencySymbols = {
    'NGN': '\u20A6',
    'USD': '\$',
    'GBP': '\u00A3',
    'EUR': '\u20AC',
    'GHS': '\u20B5',
    'KES': 'KSh',
    'ZAR': 'R',
    'UGX': 'USh',
    'TZS': 'TSh',
    'RWF': 'RF',
  };

  DashboardRatesCubit({
    required IExchangeRepository repository,
  })  : _repository = repository,
        super(DashboardRatesInitial());

  Future<void> loadRates(String baseCurrency) async {
    _baseCurrency = baseCurrency;
    emit(DashboardRatesLoading());

    await _fetchRates();
    if (!isClosed) _startAutoRefresh();
  }

  Future<void> _fetchRates({bool isRefresh = false}) async {
    // Use cached currencies on refresh to avoid redundant gRPC call.
    // getSupportedCurrencies() already has a 10-min cache in the repository,
    // but we also keep a local reference to avoid even the cache lookup overhead.
    List<SupportedCurrencyInfo>? currencies = _cachedCurrencies;

    if (currencies == null || currencies.isEmpty) {
      final currenciesResult = await _repository.getSupportedCurrencies();
      if (isClosed) return;

      final resolved = currenciesResult.fold(
        (failure) => null,
        (data) => data,
      );

      if (resolved == null || resolved.isEmpty) {
        if (!isRefresh && !isClosed) {
          currenciesResult.fold(
            (failure) => emit(DashboardRatesError(message: failure.message)),
            (_) => emit(
                const DashboardRatesError(message: 'No currencies available')),
          );
        }
        return;
      }

      currencies = resolved;
      _cachedCurrencies = currencies;
    }

    // ONLY CURRENCIES THE ACTIVE PROVIDER CAN ACTUALLY CONVERT.
    //
    // This filtered on `code != base` alone, so the dashboard printed a rate
    // card for every currency GetSupportedCurrencies returned — including the
    // international-only ones (CAD, PHP) that the provider's virtual accounts
    // do not cover and which therefore cannot be converted at all. A rate on
    // the dashboard is an invitation to exchange, so quoting one for a pair
    // that would be refused is the reported defect.
    //
    // `supportsConversion` is the backend's own capability flag, re-read on
    // every fetch (10-minute repository cache), so switching provider changes
    // this list with no release — the exchange screen's destination picker
    // reads the same flag.
    final targets = currencies
        .where((c) => c.code != _baseCurrency && c.supportsConversion)
        .toList();
    if (targets.isEmpty) {
      if (!isRefresh && !isClosed) {
        emit(const DashboardRatesError(
            message: 'No target currencies available'));
      }
      return;
    }

    // FETCH THE DIRECTION WE DISPLAY. CountryRateCard renders
    // "1 <target> = <baseSymbol><rate>", so the rate wanted is target→base.
    //
    // This used to ask for base→target and then invert the answer with
    // `1.0 / rate`. That is not the same number. A quoted rate carries a
    // spread, and the reciprocal of a spread-inclusive rate is not the
    // spread-inclusive rate of the opposite pair — it leans the margin the
    // wrong way. So the dashboard and the exchange screen, both reading the
    // same gRPC endpoint, printed different figures for the same pair, which
    // is the reported "the rates don't match".
    //
    // Asking for the direction we show means the dashboard's number IS the
    // exchange screen's number for that pair, with no client-side arithmetic
    // in between that could drift.
    final rateFutures = targets.map((target) => _repository.getExchangeRate(
          fromCurrency: target.code,
          toCurrency: _baseCurrency,
        ));

    final results = await Future.wait(rateFutures);
    if (isClosed) return;

    final dashboardRates = <DashboardCurrencyRate>[];

    for (int i = 0; i < targets.length; i++) {
      results[i].fold(
        (_) {},
        (exchangeRate) {
          final target = targets[i];
          // Used as returned. No inversion — see the fetch above.
          final rate = exchangeRate.rate;
          // A non-positive rate is not a rate. Dropping the row leaves the
          // card out rather than printing "1 USD = ₦0.00", which reads as a
          // collapsed currency rather than as missing data.
          if (rate <= 0) return;

          dashboardRates.add(DashboardCurrencyRate(
            currencyCode: target.code,
            currencyName: target.name,
            currencySymbol: target.symbol,
            countryCode: target.country,
            flagEmoji: _flagEmojis[target.country] ?? '',
            rate: rate,
            baseCurrency: _baseCurrency,
            baseSymbol: _currencySymbols[_baseCurrency] ?? _baseCurrency,
          ));
        },
      );
    }

    if (isClosed) return;

    if (dashboardRates.isEmpty && !isRefresh) {
      emit(const DashboardRatesError(message: 'No exchange rates available'));
      return;
    }

    if (dashboardRates.isNotEmpty) {
      emit(DashboardRatesLoaded(
        rates: dashboardRates,
        baseCurrency: _baseCurrency,
        lastUpdated: DateTime.now(),
      ));
    }
  }

  void _startAutoRefresh() {
    _refreshTimer?.cancel();
    // 120s refresh: rates are cached 30s in repository, so this fires every
    // other cache cycle — still fresh enough for a dashboard display while
    // cutting gRPC calls in half.
    _refreshTimer = Timer.periodic(const Duration(seconds: 120), (_) {
      _refreshRates();
    });
  }

  Future<void> _refreshRates() async {
    if (isClosed) return;
    final currentState = state;
    if (currentState is DashboardRatesLoaded) {
      emit(DashboardRatesLoaded(
        rates: currentState.rates,
        baseCurrency: currentState.baseCurrency,
        lastUpdated: currentState.lastUpdated,
        isStale: true,
      ));
    }

    await _fetchRates(isRefresh: true);
  }

  @override
  Future<void> close() {
    _refreshTimer?.cancel();
    return super.close();
  }
}
