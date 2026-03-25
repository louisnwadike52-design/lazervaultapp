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
            (_) => emit(const DashboardRatesError(message: 'No currencies available')),
          );
        }
        return;
      }

      currencies = resolved;
      _cachedCurrencies = currencies;
    }

    final targets = currencies.where((c) => c.code != _baseCurrency).toList();
    if (targets.isEmpty) {
      if (!isRefresh && !isClosed) {
        emit(const DashboardRatesError(message: 'No target currencies available'));
      }
      return;
    }

    // Fetch all rates in parallel
    final rateFutures = targets.map((target) => _repository.getExchangeRate(
          fromCurrency: _baseCurrency,
          toCurrency: target.code,
        ));

    final results = await Future.wait(rateFutures);
    if (isClosed) return;

    final dashboardRates = <DashboardCurrencyRate>[];

    for (int i = 0; i < targets.length; i++) {
      results[i].fold(
        (_) {},
        (exchangeRate) {
          final target = targets[i];
          final invertedRate =
              exchangeRate.rate > 0 ? 1.0 / exchangeRate.rate : 0.0;

          dashboardRates.add(DashboardCurrencyRate(
            currencyCode: target.code,
            currencyName: target.name,
            currencySymbol: target.symbol,
            countryCode: target.country,
            flagEmoji: _flagEmojis[target.country] ?? '',
            rate: invertedRate,
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
