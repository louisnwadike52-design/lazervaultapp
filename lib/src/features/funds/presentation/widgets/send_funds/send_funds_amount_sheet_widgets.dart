part of 'send_funds_amount_sheet.dart';

/// Result of the short-flow amount sheet: the amount plus the optional
/// note / scheduling / recurring / category the user attached (parity with the
/// long flow). Replaces the old bare `int` return.
class SendFundsAmountResult {
  final int amountMinor;
  final String? note;
  final DateTime? scheduledAt;
  final ServiceCategory? category;
  final RecurringTransferConfig? recurring;

  /// PAY WITH CRYPTO: the asset to sell to fund this transfer, lowercase.
  /// Null means the ordinary wallet-funded transfer, which is every transfer
  /// that existed before this feature.
  final String? fundingAsset;

  const SendFundsAmountResult({
    required this.amountMinor,
    this.note,
    this.scheduledAt,
    this.category,
    this.recurring,
    this.fundingAsset,
  });
}
