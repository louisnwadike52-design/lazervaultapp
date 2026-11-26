import 'package:grpc/grpc.dart';

/// The server's refusal codes, turned into something the holder of the phone
/// can act on.
///
/// EACH CODE KEEPS ITS OWN SENTENCE, and whether it is RETRYABLE is part of the
/// answer. "Sold out" and "sales are still open" fail identically on a retry,
/// so a screen that offers "Try again" on them is inviting the customer to tap
/// until they give up. Same split the transfer surface makes between a refusal
/// and a failure.
///
/// The codes come from ticketErrorToStatus in financial-products-service. A
/// code with no case here still produces a usable sentence through the fallback
/// — but it loses the retryable distinction, which is why the guard test pins
/// the two lists against each other.
class TicketRefusal {
  const TicketRefusal(this.message, {this.isRetryable = false});
  final String message;
  final bool isRetryable;
}

const Map<String, TicketRefusal> ticketRefusals = {
  'EVENT_NOT_FOUND': TicketRefusal(
    'That event could not be found.',
  ),
  'SOLD_OUT': TicketRefusal(
    'This event is sold out.',
  ),
  'NOT_ON_SALE': TicketRefusal(
    'This event is not on sale right now.',
  ),
  'OVER_PER_BUYER_LIMIT': TicketRefusal(
    'That is more tickets than one person can hold for this event. '
    'Try a smaller number.',
  ),
  'OWN_EVENT': TicketRefusal(
    // The organiser's own money would leave their wallet, enter the pool, and
    // come back to them minus a commission. Non-retryable: nothing about
    // tapping again changes whose event it is.
    'This is your own event, so there is nothing to buy. Open it from My '
    'events to see its sales.',
  ),
  'NOT_A_DRAFT': TicketRefusal(
    'This event is already on sale, so it cannot be changed here.',
  ),
  'SALES_STILL_OPEN': TicketRefusal(
    'You can withdraw once sales close.',
  ),
  'PAYOUTS_DISABLED': TicketRefusal(
    'Withdrawals are paused right now. Your earnings are safe and still owed '
    'to you.',
  ),
  'NOTHING_TO_WITHDRAW': TicketRefusal(
    'There is nothing to withdraw on this event yet.',
  ),
  'EVENT_CANCELLED': TicketRefusal(
    'This event was cancelled. Its buyers are being refunded.',
  ),
  'TICKET_ALREADY_USED': TicketRefusal(
    'This ticket has already been used.',
  ),
  'TICKET_NOT_FOUND': TicketRefusal(
    'That code is not a ticket for this event.',
  ),
  'ORDER_REFUNDED': TicketRefusal(
    // At a door: the code is real, the money went back. Naming the refund is
    // the difference between "the scanner is broken" and a conversation the
    // steward can actually have.
    'This order was refunded, so this ticket is no longer valid.',
  ),

  // ── Buyer-initiated refunds ────────────────────────────────────────────
  'ORDER_NOT_FOUND': TicketRefusal(
    // Also what a caller gets for somebody else's order — deliberately
    // indistinguishable, so the response confirms nothing about ids they
    // guessed.
    'That order could not be found.',
  ),
  'REFUNDS_DISABLED': TicketRefusal(
    'Refund requests are not available for this event. Contact the organiser.',
  ),
  'REFUND_WINDOW_PASSED': TicketRefusal(
    'It is too late to refund this ticket.',
  ),
  'ALREADY_REFUNDED': TicketRefusal(
    'This order was already refunded.',
  ),
  'TICKET_ALREADY_ADMITTED': TicketRefusal(
    // Somebody went in on this order. Refunding it now would be giving back
    // money for an event they attended.
    'A ticket on this order has already been used, so it cannot be refunded.',
  ),

  // ── Transfers ──────────────────────────────────────────────────────────
  'TRANSFERS_DISABLED': TicketRefusal(
    'Giving tickets away is not available right now.',
  ),
  'TRANSFER_TO_SELF': TicketRefusal(
    'That ticket is already yours.',
  ),
  'NOT_TRANSFERABLE': TicketRefusal(
    // Used, refunded, or the event has been and gone. Non-retryable: none of
    // those change by tapping again.
    'That ticket can no longer be given away.',
  ),
};

/// What to show for [error], and whether to offer a retry.
TicketRefusal ticketError(Object error) {
  final raw = error is GrpcError ? (error.message ?? '') : error.toString();
  final known = ticketRefusals[raw];
  if (known != null) return known;

  if (error is GrpcError) {
    switch (error.code) {
      case StatusCode.unavailable:
      case StatusCode.deadlineExceeded:
        // A TRANSPORT FAILURE ON A PURCHASE IS THE AMBIGUOUS CASE: the request
        // may have been carried out and the answer lost. The copy must not
        // claim nothing happened, and the retry is SAFE because the buy carries
        // a stable idempotency key — the server returns the original order
        // rather than charging again.
        return const TicketRefusal(
          'Could not reach Lazervault. If you were buying, check My tickets '
          'before trying again — a purchase that went through will be '
          'there.',
          isRetryable: true,
        );
      case StatusCode.unauthenticated:
        return const TicketRefusal(
          'Your session has expired. Please sign in again.',
        );
      case StatusCode.invalidArgument:
      case StatusCode.failedPrecondition:
        // The service writes these for the organiser ("raise the price", "the
        // title is too long"), so the sentence is the useful part. Not
        // retryable: the input has to change first.
        final msg = (error.message ?? '').trim();
        if (msg.isNotEmpty && !msg.contains('_')) {
          return TicketRefusal(_strip(msg));
        }
        break;
      default:
        break;
    }
  }
  return const TicketRefusal(
    'Something went wrong. Please try again.',
    isRetryable: true,
  );
}

/// Drops the service's own `tickets: ` prefix, which is a log convention and
/// not something to read aloud to a customer.
String _strip(String m) {
  const prefix = 'tickets: ';
  final out = m.startsWith(prefix) ? m.substring(prefix.length) : m;
  if (out.isEmpty) return out;
  return out[0].toUpperCase() + out.substring(1);
}
