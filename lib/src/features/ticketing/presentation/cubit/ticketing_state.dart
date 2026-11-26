import 'package:equatable/equatable.dart';
import 'package:lazervault/src/generated/ticketing.pb.dart' as tk;

/// Ticketing screen states.
///
/// THE GENERATED PROTO MESSAGES ARE THE MODEL. No hand-written entity layer
/// sits between them and the screens, deliberately: every field on them is
/// already the server's own answer, and a parallel entity would be one more
/// place for a field to be forgotten — which on this surface means a money
/// column silently rendering as zero.
sealed class TicketingState extends Equatable {
  const TicketingState();
  @override
  List<Object?> get props => const [];
}

final class TicketingInitial extends TicketingState {
  const TicketingInitial();
}

final class TicketingLoading extends TicketingState {
  const TicketingLoading();
}

/// The discover list.
final class TicketEventsLoaded extends TicketingState {
  const TicketEventsLoaded({
    required this.events,
    required this.total,
    this.search = '',
    this.page = 1,
    this.organiser = '',
    this.category = '',
    this.state = '',
  });

  final List<tk.TicketEvent> events;

  /// How many match in total, not how many are loaded — which is what makes
  /// "there is more" answerable without a sentinel page that comes back empty.
  final int total;
  final String search;

  /// The exact host this listing is narrowed to, empty on the discover list.
  /// Carried on the state so "load more" and pull-to-refresh keep the filter —
  /// a footer that silently widens the list back to everyone is worse than no
  /// footer.
  final String organiser;

  /// The browse axes this listing is narrowed to, as SLUGS. Empty means "not
  /// narrowed on this axis".
  ///
  /// CARRIED ON THE STATE for the same reason [organiser] is: "load more" and
  /// pull-to-refresh re-issue the query, and a footer that silently widens a
  /// filtered list back to the whole catalogue is worse than no footer.
  final String category;
  final String state;

  /// The highest page loaded, so the footer knows what to ask for next.
  final int page;

  bool get hasMore => events.length < total;

  @override
  // THE FILTERS BELONG IN props. Equatable suppresses a rebuild when props
  // match, so a state that differed only by category would not repaint — the
  // chips would show the new selection and the list would still be the old
  // one, which reads as the filter not working.
  List<Object?> get props => [
        events.map((e) => e.id).toList(),
        total,
        search,
        page,
        organiser,
        category,
        state,
      ];
}

/// One event, with the server's commission quote for a single ticket.
final class TicketEventDetail extends TicketingState {
  const TicketEventDetail({
    required this.event,
    required this.buyerTotalPerTicketMinor,
    required this.feePerTicketMinor,
  });

  final tk.TicketEvent event;

  /// WHAT THE BUYER PAYS for one ticket, quoted by the server's own fee engine.
  /// Never computed in the app: a locally-applied commission drifts from the
  /// charge and shows a total the buyer is not billed.
  final int buyerTotalPerTicketMinor;
  final int feePerTicketMinor;

  @override
  List<Object?> get props => [
        event.id,
        event.ticketsSold,
        buyerTotalPerTicketMinor,
        feePerTicketMinor
      ];
}

/// The organiser's own events.
final class MyTicketEventsLoaded extends TicketingState {
  const MyTicketEventsLoaded(
      {required this.events, required this.total, this.page = 1});
  final List<tk.TicketEvent> events;
  final int total;
  final int page;
  bool get hasMore => events.length < total;
  @override
  List<Object?> get props => [events.map((e) => e.id).toList(), total, page];
}

/// The tickets this user holds.
final class MyTicketsLoaded extends TicketingState {
  const MyTicketsLoaded({
    required this.tickets,
    required this.total,
    this.page = 1,
    this.refundsEnabled = false,
    this.transfersEnabled = false,
    this.refundCutoffHours = 0,
  });
  final List<tk.MyTicket> tickets;
  final int total;
  final int page;

  /// WHICH ACTIONS THE SERVER WILL ACCEPT, so the screen hides one rather
  /// than offering it into a refusal. Both default FALSE here as well as on
  /// the server: a response that could not be read must not show buttons.
  final bool refundsEnabled;
  final bool transfersEnabled;

  /// How long BEFORE the event refund requests close. 0 = until sales close.
  final int refundCutoffHours;

  bool get hasMore => tickets.length < total;
  @override
  List<Object?> get props => [
        tickets.map((t) => t.ticketId).toList(),
        total,
        page,
        refundsEnabled,
        transfersEnabled,
        refundCutoffHours,
      ];
}

/// A draft was created. Carries the per-ticket economics step 2 confirms.
final class TicketEventDrafted extends TicketingState {
  const TicketEventDrafted({
    required this.event,
    required this.organiserNetPerTicketMinor,
    required this.feePerTicketMinor,
  });
  final tk.TicketEvent event;
  final int organiserNetPerTicketMinor;
  final int feePerTicketMinor;
  @override
  List<Object?> get props =>
      [event.id, organiserNetPerTicketMinor, feePerTicketMinor];
}

final class TicketEventSaved extends TicketingState {
  const TicketEventSaved(this.event);
  final tk.TicketEvent event;
  @override
  List<Object?> get props => [event.id, event.status, event.ticketsSold];
}

/// One event's money, including whether a withdrawal is possible right now.
final class TicketEarningsLoaded extends TicketingState {
  const TicketEarningsLoaded(this.earnings);
  final tk.GetEventEarningsResponse earnings;
  @override
  List<Object?> get props =>
      [earnings.eventId, earnings.outstandingMinor, earnings.withdrawable];
}

final class TicketPurchased extends TicketingState {
  const TicketPurchased(this.purchase);
  final tk.BuyTicketsResponse purchase;
  @override
  List<Object?> get props => [purchase.purchaseId, purchase.alreadyPurchased];
}

final class TicketPayoutMade extends TicketingState {
  const TicketPayoutMade(this.payout);
  final tk.WithdrawEventEarningsResponse payout;
  @override
  List<Object?> get props => [payout.payoutId, payout.alreadyPaid];
}

final class TicketEventCancelled extends TicketingState {
  const TicketEventCancelled(this.note);

  /// The SERVER'S note, which says the refunds happen automatically. Shown
  /// rather than replaced: an organiser who sees only "cancelled" assumes the
  /// refunds have already completed.
  final String note;
  @override
  List<Object?> get props => [note];
}

/// The organiser's door list — ONE ROW PER ADMISSION, not per order.
final class TicketAttendeesLoaded extends TicketingState {
  const TicketAttendeesLoaded({
    required this.eventId,
    required this.attendees,
    required this.total,
    this.page = 1,
  });
  final String eventId;
  final List<tk.EventAttendee> attendees;
  final int total;
  final int page;
  bool get hasMore => attendees.length < total;

  /// How many have come through the gate. Counted from the rows on screen,
  /// which is honest about what this page knows — the authoritative figure is
  /// ticketsAdmitted on the earnings response, computed over the whole event.
  int get admittedOnThisPage => attendees
      .where((a) =>
          a.status == tk.TicketAdmissionStatus.TICKET_ADMISSION_STATUS_USED)
      .length;

  @override
  List<Object?> get props =>
      [eventId, attendees.map((a) => a.ticketId).toList(), total, page];
}

/// A buyer got their own money back.
final class TicketOrderRefunded extends TicketingState {
  const TicketOrderRefunded(this.refund);
  final tk.RequestTicketRefundResponse refund;

  /// True when the platform kept its commission — the refund is PARTIAL and
  /// the screen must say so rather than implying the full total came back.
  bool get isPartial => refund.feeKeptMinor > 0;

  @override
  List<Object?> get props =>
      [refund.purchaseId, refund.amountMinor, refund.alreadyRefunded];
}

/// A ticket changed hands. NO MONEY MOVED.
final class TicketTransferred extends TicketingState {
  const TicketTransferred(this.transfer);
  final tk.TransferTicketResponse transfer;
  @override
  List<Object?> get props => [transfer.ticketId, transfer.transferCount];
}

final class TicketingFailure extends TicketingState {
  const TicketingFailure(this.message, {this.isRetryable = true});
  final String message;

  /// False for a REFUSAL — sold out, sales still open, over the per-buyer
  /// limit. Retrying one of those fails identically, so the screen must not
  /// offer "Try again".
  final bool isRetryable;
  @override
  List<Object?> get props => [message, isRetryable];
}
