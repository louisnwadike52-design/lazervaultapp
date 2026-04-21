import 'package:equatable/equatable.dart';

/// International data operator. Mirrors the intl_airtime equivalent
/// but filtered to operators where data==true at the provider. Backed
/// by Reloadly's /operators endpoint per their public API docs.
class IntlDataOperator extends Equatable {
  final String id; // Reloadly operatorId as string
  final String countryCode;
  final String countryName;
  final String operatorName;
  final String senderCurrencyCode;
  final String destCurrencyCode;
  final double fxRate;
  final String logoUrl;
  final bool isActive;
  final int bundleCount;

  const IntlDataOperator({
    required this.id,
    required this.countryCode,
    required this.countryName,
    required this.operatorName,
    required this.senderCurrencyCode,
    required this.destCurrencyCode,
    required this.fxRate,
    this.logoUrl = '',
    this.isActive = true,
    this.bundleCount = 0,
  });

  @override
  List<Object?> get props => [id, operatorName, countryCode];
}
