part of 'lock_fund_details_screen.dart';

/// Cancel-reason enum entry: short code shipped to the backend
/// (so analytics groups by category) + human-readable label for
/// the radio chip on the cancel modal.
class _CancelReason {
  final String code;
  final String label;
  const _CancelReason(this.code, this.label);
}
