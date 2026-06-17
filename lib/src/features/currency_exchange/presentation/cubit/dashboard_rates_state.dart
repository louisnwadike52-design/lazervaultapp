import 'package:equatable/equatable.dart';

class DashboardCurrencyRate {
  final String currencyCode;
  final String currencyName;
  final String currencySymbol;
  final String countryCode;
  final String flagEmoji;
  final double rate;
  final String baseCurrency;
  final String baseSymbol;

  const DashboardCurrencyRate({
    required this.currencyCode,
    required this.currencyName,
    required this.currencySymbol,
    required this.countryCode,
    required this.flagEmoji,
    required this.rate,
    required this.baseCurrency,
    required this.baseSymbol,
  });
}

abstract class DashboardRatesState extends Equatable {
  const DashboardRatesState();

  @override
  List<Object?> get props => [];
}

class DashboardRatesInitial extends DashboardRatesState {}

class DashboardRatesLoading extends DashboardRatesState {}

class DashboardRatesLoaded extends DashboardRatesState {
  final List<DashboardCurrencyRate> rates;
  final String baseCurrency;
  final DateTime lastUpdated;
  final bool isStale;

  const DashboardRatesLoaded({
    required this.rates,
    required this.baseCurrency,
    required this.lastUpdated,
    this.isStale = false,
  });

  @override
  List<Object?> get props => [rates, baseCurrency, lastUpdated, isStale];
}

class DashboardRatesError extends DashboardRatesState {
  final String message;

  const DashboardRatesError({required this.message});

  @override
  List<Object?> get props => [message];
}
