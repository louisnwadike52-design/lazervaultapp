part of 'contribution_details_screen.dart';

class _UserPaymentGroup extends _UserPaymentGroupBase {
  const _UserPaymentGroup({
    required super.userId,
    required super.userName,
    required super.member,
    required super.payments,
    required super.totalPaid,
    required super.totalInFlight,
    required super.totalRefunded,
    required super.expectedAmount,
    required super.remaining,
    required super.latestPaymentDate,
    required super.currency,
  });

}

/// Thin private alias around the now-public `PaymentGroupCard`.
/// Existing callers in this file pass `_UserPaymentGroup` (which
/// extends `UserPaymentGroup`), so the delegating constructor takes
/// the typed field as-is and forwards to the public widget.
class _PaymentGroupCard extends StatelessWidget {
  final _UserPaymentGroup group;
  final VoidCallback onTap;

  const _PaymentGroupCard({required this.group, required this.onTap});

  @override
  Widget build(BuildContext context) =>
      PaymentGroupCard(group: group, onTap: onTap);
}

/// Thin private alias around the now-public `PaymentBreakdownRow`.
/// Keeps the existing call-sites in this file unchanged while the
/// public widget is reused by the past-contribution sheet too.
class _PaymentBreakdownRow extends StatelessWidget {
  final ContributionPayment payment;
  final VoidCallback onTap;
  const _PaymentBreakdownRow(
      {required this.payment, required this.onTap});
  @override
  Widget build(BuildContext context) =>
      PaymentBreakdownRow(payment: payment, onTap: onTap);
}
