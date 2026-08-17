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
  const SendFundsAmountResult({
    required this.amountMinor,
    this.note,
    this.scheduledAt,
    this.category,
    this.recurring,
  });
}
