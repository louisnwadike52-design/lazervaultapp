import 'dart:convert';

import 'package:equatable/equatable.dart';

class IntlAirtimeOperator extends Equatable {
  final String id;
  final String countryCode;
  final String countryName;
  final String operatorName;
  final String reloadlyOperatorId;
  final String vtpassOperatorId;

  /// "RANGE" or "FIXED"
  final String denominationType;

  final String senderCurrencyCode;
  final String destCurrencyCode;
  final double fxRate;
  final double minAmount;
  final double maxAmount;
  final double localMinAmount;
  final double localMaxAmount;

  /// JSON-encoded list of fixed sender amounts, e.g. "[5.0, 10.0, 20.0]"
  final String fixedAmounts;

  /// JSON-encoded list of fixed local (destination) amounts
  final String localFixedAmounts;

  final bool supportsLocalAmounts;
  final String logoUrl;
  final bool isActive;

  const IntlAirtimeOperator({
    required this.id,
    required this.countryCode,
    required this.countryName,
    required this.operatorName,
    this.reloadlyOperatorId = '',
    this.vtpassOperatorId = '',
    this.denominationType = 'RANGE',
    this.senderCurrencyCode = '',
    this.destCurrencyCode = '',
    this.fxRate = 1.0,
    this.minAmount = 0.0,
    this.maxAmount = 0.0,
    this.localMinAmount = 0.0,
    this.localMaxAmount = 0.0,
    this.fixedAmounts = '[]',
    this.localFixedAmounts = '[]',
    this.supportsLocalAmounts = false,
    this.logoUrl = '',
    this.isActive = true,
  });

  /// Parses [fixedAmounts] JSON string into a typed list of doubles.
  List<double> get parsedFixedAmounts {
    try {
      final decoded = jsonDecode(fixedAmounts);
      if (decoded is List) {
        return decoded.map((e) => (e as num).toDouble()).toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  /// Parses [localFixedAmounts] JSON string into a typed list of doubles.
  List<double> get parsedLocalFixedAmounts {
    try {
      final decoded = jsonDecode(localFixedAmounts);
      if (decoded is List) {
        return decoded.map((e) => (e as num).toDouble()).toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  bool get isRange => denominationType.toUpperCase() == 'RANGE';
  bool get isFixed => denominationType.toUpperCase() == 'FIXED';

  IntlAirtimeOperator copyWith({
    String? id,
    String? countryCode,
    String? countryName,
    String? operatorName,
    String? reloadlyOperatorId,
    String? vtpassOperatorId,
    String? denominationType,
    String? senderCurrencyCode,
    String? destCurrencyCode,
    double? fxRate,
    double? minAmount,
    double? maxAmount,
    double? localMinAmount,
    double? localMaxAmount,
    String? fixedAmounts,
    String? localFixedAmounts,
    bool? supportsLocalAmounts,
    String? logoUrl,
    bool? isActive,
  }) {
    return IntlAirtimeOperator(
      id: id ?? this.id,
      countryCode: countryCode ?? this.countryCode,
      countryName: countryName ?? this.countryName,
      operatorName: operatorName ?? this.operatorName,
      reloadlyOperatorId: reloadlyOperatorId ?? this.reloadlyOperatorId,
      vtpassOperatorId: vtpassOperatorId ?? this.vtpassOperatorId,
      denominationType: denominationType ?? this.denominationType,
      senderCurrencyCode: senderCurrencyCode ?? this.senderCurrencyCode,
      destCurrencyCode: destCurrencyCode ?? this.destCurrencyCode,
      fxRate: fxRate ?? this.fxRate,
      minAmount: minAmount ?? this.minAmount,
      maxAmount: maxAmount ?? this.maxAmount,
      localMinAmount: localMinAmount ?? this.localMinAmount,
      localMaxAmount: localMaxAmount ?? this.localMaxAmount,
      fixedAmounts: fixedAmounts ?? this.fixedAmounts,
      localFixedAmounts: localFixedAmounts ?? this.localFixedAmounts,
      supportsLocalAmounts: supportsLocalAmounts ?? this.supportsLocalAmounts,
      logoUrl: logoUrl ?? this.logoUrl,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [
        id,
        countryCode,
        operatorName,
        reloadlyOperatorId,
        vtpassOperatorId,
        denominationType,
        senderCurrencyCode,
        destCurrencyCode,
        fxRate,
        minAmount,
        maxAmount,
        localMinAmount,
        localMaxAmount,
        fixedAmounts,
        localFixedAmounts,
        supportsLocalAmounts,
        logoUrl,
        isActive,
      ];
}
