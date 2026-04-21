import 'package:equatable/equatable.dart';

/// A purchasable international data bundle. Flattened from
/// Reloadly's `fixedAmounts` + `fixedAmountsDescriptions` on the
/// operator. `amount` is what the user pays in sender currency;
/// `localAmount` is what the recipient gets in destination currency.
class IntlDataBundle extends Equatable {
  final String id; // Backend-assigned stable ID: operatorID-amount
  final String operatorId;
  final double amount;
  final double localAmount;
  final String description; // "1GB 30 Days" style label
  final String destCurrencyCode;
  final String senderCurrencyCode;
  /// Live Reloadly FX rate snapshotted when the bundles were listed:
  /// multiplying [localAmount] by this yields what the user's wallet
  /// will be debited in the active locale currency. Zero when Reloadly
  /// didn't return a rate for the operator (callers fall back to the
  /// operator-level rate).
  final double fxRate;

  const IntlDataBundle({
    required this.id,
    required this.operatorId,
    required this.amount,
    required this.localAmount,
    required this.description,
    required this.destCurrencyCode,
    required this.senderCurrencyCode,
    this.fxRate = 0,
  });

  @override
  List<Object?> get props => [id, operatorId, amount, fxRate];
}
