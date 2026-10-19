library;

import 'package:equatable/equatable.dart';

/// One payout a creator took out of a campaign wallet.
///
/// Read from ListCrowdfundWithdrawals, which already existed on the backend
/// and was already proxied by products-gateway — Flutter simply never called
/// it. That matters: it means the creator-side "Withdrawn" badge is backed by
/// the audit table rather than inferred from a pot that happens to read zero,
/// which would also be true of a campaign nobody funded.
///
/// Non-admin callers are clamped server-side to their OWN rows, and
/// `crowdfund_id` is optional, so one call returns every withdrawal the
/// signed-in creator has made across all of their campaigns.
class CrowdfundWithdrawalRecord extends Equatable {
  const CrowdfundWithdrawalRecord({
    required this.id,
    required this.crowdfundId,
    required this.amount,
    required this.feeAmount,
    required this.netAmount,
    required this.currency,
    required this.status,
    required this.createdAt,
  });

  final String id;
  final String crowdfundId;

  /// Gross taken out of the campaign, in major units.
  final double amount;

  /// Platform commission, in major units.
  final double feeAmount;

  /// What reached the creator, in major units. Zero when no fee applied —
  /// the server only fills it alongside a booked fee.
  final double netAmount;

  final String currency;

  /// "pending" | "completed" | "failed" | "reversed".
  final String status;

  final DateTime createdAt;

  /// Only a completed payout means money actually left the campaign. A
  /// pending or failed row must not put a "Withdrawn" badge on a campaign
  /// whose funds are all still there.
  bool get isSettled => status.toLowerCase() == 'completed';

  /// What the creator actually received. Falls back to gross because
  /// netAmount is only populated when a fee is booked.
  double get received =>
      feeAmount > 0 && netAmount > 0 ? netAmount : amount;

  @override
  List<Object?> get props =>
      [id, crowdfundId, amount, feeAmount, netAmount, currency, status, createdAt];
}
