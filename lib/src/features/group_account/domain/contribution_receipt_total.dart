library;

import 'entities/group_entities.dart';

/// THE FIGURE A CONTRIBUTION RECEIPT CALLS "NEW TOTAL".
///
/// It lives here, as a plain function, because TWO surfaces print it — the
/// confirmation screen and the PDF that screen generates — and they disagreed.
/// The screen printed `contribution.currentAmount`; the PDF printed
/// `currentAmount + payment.amount`. Same payment, same receipt, two numbers.
///
/// Both were wrong in the same direction as well, because `currentAmount` is
/// the LIVE POT: a rotating-savings payout sweeps it to that cycle's receiver,
/// so a member who had just paid NGN 200 into a NGN 400 cycle was handed a
/// receipt reading "New total NGN 0.00 · Remaining NGN 400.00 · Progress 0%"
/// for the payment that had just succeeded (measured on prod, 2026-10-19).
///
/// [Contribution.amountRaised] is what the CYCLE collected, which survives the
/// sweep.
///
/// ## Why [cameFromPayment] decides whether to add the payment
///
/// The contribution object reaching the receipt is NOT re-read after the
/// debit: `make_payment_screen` and `contribution_payment_processing_screen`
/// each forward the `widget.contribution` they were opened with, captured
/// before the money moved. So on that path this payment is missing from
/// `amountRaised` and must be added.
///
/// The "Generate receipt" action on a past payment row
/// (`cameFromPayment == false`) passes the contribution currently on screen,
/// which already counts it — adding again would overstate the pot to the
/// person reading their own receipt.
double contributionReceiptTotal({
  required Contribution contribution,
  required double paymentAmount,
  required bool cameFromPayment,
}) {
  final raised = contribution.amountRaised;
  return cameFromPayment ? raised + paymentAmount : raised;
}

/// What is still owed on the cycle, never negative: paying past the target is
/// overfunding, not negative money outstanding.
double contributionReceiptRemaining({
  required double target,
  required double total,
}) =>
    target > total ? target - total : 0.0;

/// Progress as a percentage of the target, or null when there is no target to
/// measure against. Null rather than 0 so an open-ended pot omits the row
/// instead of printing "Progress 0%", which reads as a failed payment.
double? contributionReceiptProgress({
  required double target,
  required double total,
}) {
  if (target <= 0) return null;
  return ((total / target) * 100).clamp(0.0, 100.0);
}
