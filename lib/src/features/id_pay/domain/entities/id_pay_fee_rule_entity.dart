import 'package:equatable/equatable.dart';

/// The admin-configured PayID platform-fee rule, surfaced to the CREATOR so
/// their screens can say what they keep per payment. Payers never see it —
/// they pay exactly the displayed amount; the fee is recipient-borne.
class IDPayFeeRuleEntity extends Equatable {
  final bool enabled;
  final String feeType; // 'percentage' | 'fixed'
  final int percentBps; // 50 = 0.50%
  final int capKobo; // 0 = uncapped
  final int minKobo; // 0 = none
  final int fixedKobo;

  const IDPayFeeRuleEntity({
    required this.enabled,
    required this.feeType,
    required this.percentBps,
    required this.capKobo,
    required this.minKobo,
    required this.fixedKobo,
  });

  /// Human line for the creator, e.g. "0.5% (max ₦100) per payment" or
  /// "₦25 per payment". Empty when fees are off.
  String describe(String currencySymbol) {
    if (!enabled) return '';
    if (feeType == 'fixed') {
      return '$currencySymbol${(fixedKobo / 100).toStringAsFixed(2)} per payment';
    }
    final pct = (percentBps / 100).toStringAsFixed(percentBps % 100 == 0 ? 0 : 2);
    final cap = capKobo > 0
        ? ' (max $currencySymbol${(capKobo / 100).toStringAsFixed(2)})'
        : '';
    return '$pct%$cap per payment';
  }

  @override
  List<Object?> get props =>
      [enabled, feeType, percentBps, capKobo, minKobo, fixedKobo];
}
