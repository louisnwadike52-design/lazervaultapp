import 'dart:convert';

import '../../domain/entities/intl_airtime_operator.dart';

class IntlAirtimeOperatorModel extends IntlAirtimeOperator {
  const IntlAirtimeOperatorModel({
    required super.id,
    required super.countryCode,
    required super.countryName,
    required super.operatorName,
    super.reloadlyOperatorId,
    super.vtpassOperatorId,
    super.denominationType,
    super.senderCurrencyCode,
    super.destCurrencyCode,
    super.fxRate,
    super.minAmount,
    super.maxAmount,
    super.localMinAmount,
    super.localMaxAmount,
    super.fixedAmounts,
    super.localFixedAmounts,
    super.supportsLocalAmounts,
    super.logoUrl,
    super.isActive,
  });

  /// Deserializes from JSON produced by the commerce-gateway HTTP/JSON endpoint.
  /// Field names match proto snake_case JSON serialization.
  factory IntlAirtimeOperatorModel.fromJson(Map<String, dynamic> json) {
    // Fixed amounts may arrive as a JSON list or as a pre-encoded string.
    String _encodeAmounts(dynamic raw) {
      if (raw == null) return '[]';
      if (raw is String) return raw.isEmpty ? '[]' : raw;
      if (raw is List) return jsonEncode(raw);
      return '[]';
    }

    return IntlAirtimeOperatorModel(
      id: json['id'] as String? ?? '',
      countryCode: json['country_code'] as String? ?? '',
      countryName: json['country_name'] as String? ?? '',
      operatorName: json['operator_name'] as String? ?? '',
      reloadlyOperatorId: json['reloadly_operator_id'] as String? ?? '',
      vtpassOperatorId: json['vtpass_operator_id'] as String? ?? '',
      denominationType: json['denomination_type'] as String? ?? 'RANGE',
      senderCurrencyCode: json['sender_currency_code'] as String? ?? '',
      destCurrencyCode: json['dest_currency_code'] as String? ?? '',
      fxRate: (json['fx_rate'] as num?)?.toDouble() ?? 1.0,
      minAmount: (json['min_amount'] as num?)?.toDouble() ?? 0.0,
      maxAmount: (json['max_amount'] as num?)?.toDouble() ?? 0.0,
      localMinAmount: (json['local_min_amount'] as num?)?.toDouble() ?? 0.0,
      localMaxAmount: (json['local_max_amount'] as num?)?.toDouble() ?? 0.0,
      fixedAmounts: _encodeAmounts(json['fixed_amounts']),
      localFixedAmounts: _encodeAmounts(json['local_fixed_amounts']),
      supportsLocalAmounts: json['supports_local_amounts'] as bool? ?? false,
      logoUrl: json['logo_url'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country_code': countryCode,
      'country_name': countryName,
      'operator_name': operatorName,
      'reloadly_operator_id': reloadlyOperatorId,
      'vtpass_operator_id': vtpassOperatorId,
      'denomination_type': denominationType,
      'sender_currency_code': senderCurrencyCode,
      'dest_currency_code': destCurrencyCode,
      'fx_rate': fxRate,
      'min_amount': minAmount,
      'max_amount': maxAmount,
      'local_min_amount': localMinAmount,
      'local_max_amount': localMaxAmount,
      'fixed_amounts': fixedAmounts,
      'local_fixed_amounts': localFixedAmounts,
      'supports_local_amounts': supportsLocalAmounts,
      'logo_url': logoUrl,
      'is_active': isActive,
    };
  }

  @override
  IntlAirtimeOperatorModel copyWith({
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
    return IntlAirtimeOperatorModel(
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
}
