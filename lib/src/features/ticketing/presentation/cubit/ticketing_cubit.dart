import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/generated/ticketing.pb.dart' as tk;

import '../../data/ticketing_errors.dart';
import '../../data/ticketing_repository.dart';
import 'ticketing_state.dart';

/// Drives the ticketing screens.
///
/// ONE CUBIT PER SCREEN INSTANCE — registered as a FACTORY, not a singleton,
/// for the reason the vendor cubit records: the screen owns it and closes it on
/// pop, and a singleton would be handed back already closed on the second
/// visit.
///
/// THE PURCHASE IS NOT ROUTED THROUGH A STATE EMISSION ALONE. It is awaited by
/// the buy sheet so the result is on screen at the moment it is known, and the
/// cubit is told afterwards — a rebuild between a customer and the answer to
/// "did my money leave?" is the wrong place for one. Same reasoning the vendor
/// scan path uses.
class TicketingCubit extends Cubit<TicketingState> {
  TicketingCubit(this._repo) : super(const TicketingInitial());

  final TicketingRepository _repo;

  /// THE OPERATOR'S CREATE-FORM POLICY.
  ///
  /// DELIBERATELY DOES NOT EMIT. It is read while a form is on screen, and a
  /// state emission would blank that form through the BlocBuilder the create
  /// screen already uses for its draft/confirm machine. The caller holds the
  /// answer in its own setState — the same reason the purchase is awaited
  /// rather than routed through a state.
  ///
  /// Returns null on failure rather than throwing: the form's fallbacks are
  /// the server's own defaults, and the server validates the submission
  /// anyway. A settings read that fails must not stop someone creating an
  /// event.
  Future<tk.GetTicketingConfigResponse?> fetchConfig() async {
    try {
      return await _repo.config();
    } catch (_) {
      return null;
    }
  }

  /// The discover list.
  ///
  /// APPENDS past the first page, so "load more" grows the list instead of
  /// replacing it. Every list here loaded page 1 and nothing could reach page
  /// 2, which left anything past a pageful simply unreachable — `total` was
  /// already on the wire and unused.
  ///
  /// [organiser] narrows to ONE host exactly — the host page. It is carried
  /// into the emitted state so a later "load more" on that page asks for the
  /// same host rather than quietly widening back to everyone.
  /// [category] and [state] are the browse axes, as SLUGS. They COMBINE with
  /// each other and with [search] — "comedy in Lagos" is one query — and the
  /// loaded state carries them back so a "load more" cannot silently drop
  /// them and return the whole catalogue.
  /// PAGES ALREADY BEING FETCHED.
  ///
  /// Needed the moment these lists gained a scroll trigger. A footer that is
  /// only ever tapped is requested once; a scroll notification arrives on
  /// every frame near the bottom, so without this the same page is fetched
  /// dozens of times and every one of them appends — the reader watches the
  /// list grow with copies of what it already had.
  ///
  /// Keyed by list AND page, so paging two tabs at once is not serialised and
  /// a retry of a page that genuinely failed is not refused.
  final Set<String> _paging = <String>{};

  /// Runs [body] unless that exact page is already in flight.
  Future<void> _page(String key, Future<void> Function() body) async {
    if (_paging.contains(key)) return;
    _paging.add(key);
    try {
      await body();
    } finally {
      _paging.remove(key);
    }
  }

  /// Whether any page of [list] is in flight — for a footer spinner.
  bool isPaging(String list) => _paging.any((k) => k.startsWith('$list:'));

  /// Appends [incoming] to [existing], dropping rows already held.
  ///
  /// Pages are offsets into a table that takes new rows while the reader is
  /// paging it, so page two legitimately re-sends the tail of page one.
  /// Appending blind shows the row twice — and for a ticket, a duplicate is
  /// not merely untidy: it reads as a second admission that does not exist.
  static List<T> _appendUnique<T>(
    List<T> existing,
    List<T> incoming,
    String Function(T) id,
  ) {
    final seen = existing.map(id).toSet();
    return [
      ...existing,
      for (final row in incoming)
        if (id(row).isEmpty || seen.add(id(row))) row,
    ];
  }

  Future<void> loadEvents({
    String search = '',
    int page = 1,
    String organiser = '',
    String category = '',
    String state = '',
  }) async {
    if (isClosed) return;
    await _page('events:$page:$search:$organiser:$category:$state', () async {
      final existing = (page > 1 && this.state is TicketEventsLoaded)
          ? (this.state as TicketEventsLoaded).events
          : const <tk.TicketEvent>[];
      if (existing.isEmpty) emit(const TicketingLoading());
      try {
        final resp = await _repo.listEvents(
            search: search,
            page: page,
            organiser: organiser,
            category: category,
            state: state);
        if (isClosed) return;
        emit(TicketEventsLoaded(
          events: _appendUnique(existing, resp.events, (e) => e.id),
          total: resp.total.toInt(),
          search: search,
          page: page,
          organiser: organiser,
          category: category,
          state: state,
        ));
      } catch (e) {
        // A FAILED "load more" MUST NOT DESTROY THE PAGE ALREADY READ.
        if (existing.isNotEmpty) return;
        _fail(e);
      }
    });
  }

  /// One event plus the server's per-ticket quote.
  Future<void> loadEvent(String eventId) async {
    if (isClosed) return;
    emit(const TicketingLoading());
    try {
      final resp = await _repo.getEvent(eventId);
      if (isClosed) return;
      emit(TicketEventDetail(
        event: resp.event,
        buyerTotalPerTicketMinor: resp.buyerTotalMinorPerTicket.toInt(),
        feePerTicketMinor: resp.feeMinorPerTicket.toInt(),
      ));
    } catch (e) {
      _fail(e);
    }
  }

  /// The tickets this user holds. Appends past the first page — see loadEvents.
  Future<void> loadMyTickets({int page = 1}) async {
    if (isClosed) return;
    await _page('mytickets:$page', () async {
      final existing = (page > 1 && state is MyTicketsLoaded)
          ? (state as MyTicketsLoaded).tickets
          : const <tk.MyTicket>[];
      // No Loading state when appending: blanking a list the reader is looking
      // at in order to fetch its tail is worse than the wait.
      if (existing.isEmpty) emit(const TicketingLoading());
      try {
        final resp = await _repo.myTickets(page: page);
        if (isClosed) return;
        emit(MyTicketsLoaded(
          tickets: _appendUnique(existing, resp.tickets, (t) => t.ticketId),
          total: resp.total.toInt(),
          page: page,
          refundsEnabled: resp.refundsEnabled,
          transfersEnabled: resp.transfersEnabled,
          refundCutoffHours: resp.refundCutoffHours,
        ));
      } catch (e) {
        // A FAILED "load more" MUST NOT DESTROY THE PAGE ALREADY READ. Replacing
        // a good list with an error because its tail failed loses the part that
        // worked; the footer stays and the reader can tap again.
        if (existing.isNotEmpty) return;
        _fail(e);
      }
    });
  }

  /// The organiser's own events. Appends past the first page — see loadEvents.
  Future<void> loadMyEvents({int page = 1}) async {
    if (isClosed) return;
    await _page('myevents:$page', () async {
      final existing = (page > 1 && state is MyTicketEventsLoaded)
          ? (state as MyTicketEventsLoaded).events
          : const <tk.TicketEvent>[];
      // No Loading state when appending: blanking a list the reader is looking
      // at in order to fetch its tail is worse than the wait.
      if (existing.isEmpty) emit(const TicketingLoading());
      try {
        final resp = await _repo.myEvents(page: page);
        if (isClosed) return;
        emit(MyTicketEventsLoaded(
          events: _appendUnique(existing, resp.events, (e) => e.id),
          total: resp.total.toInt(),
          page: page,
        ));
      } catch (e) {
        // A FAILED "load more" MUST NOT DESTROY THE PAGE ALREADY READ. Replacing
        // a good list with an error because its tail failed loses the part that
        // worked; the footer stays and the reader can tap again.
        if (existing.isNotEmpty) return;
        _fail(e);
      }
    });
  }

  /// Step 1 → 2 of creation: lands a DRAFT and returns the economics to confirm.
  Future<void> createDraft({
    required String title,
    String description = '',
    String venue = '',
    String flyerUrl = '',
    required int unitPriceMinor,
    int? capacity,
    tk.TicketFeePayer? feePayer,
    DateTime? salesOpenAt,
    DateTime? salesCloseAt,
    required DateTime eventAt,
    String currency = 'NGN',
    String organiserName = '',
    Map<String, String> organiserSocials = const {},

    /// The browse axes, as SLUGS from the config's own lists. Empty means the
    /// organiser has not chosen — the server tolerates that on a draft and
    /// refuses an UNKNOWN value, so an empty string is the safe way to say
    /// "not yet".
    String category = '',
    String state = '',
  }) async {
    if (isClosed) return;
    emit(const TicketingLoading());
    try {
      final resp = await _repo.createEvent(
        title: title,
        description: description,
        venue: venue,
        flyerUrl: flyerUrl,
        currency: currency,
        unitPriceMinor: unitPriceMinor,
        capacity: capacity,
        feePayer: feePayer,
        salesOpenAt: salesOpenAt,
        salesCloseAt: salesCloseAt,
        eventAt: eventAt,
        organiserName: organiserName,
        category: category,
        state: state,
        organiserSocials: organiserSocials,
      );
      if (isClosed) return;
      emit(TicketEventDrafted(
        event: resp.event,
        organiserNetPerTicketMinor: resp.organiserNetMinorPerTicket.toInt(),
        feePerTicketMinor: resp.feeMinorPerTicket.toInt(),
      ));
    } catch (e) {
      _fail(e);
    }
  }

  /// Step 2 of creation: puts the draft on sale.
  Future<void> publish(String eventId) async {
    if (isClosed) return;
    emit(const TicketingLoading());
    try {
      final event = await _repo.publishEvent(eventId);
      if (isClosed) return;
      emit(TicketEventSaved(event));
    } catch (e) {
      _fail(e);
    }
  }

  Future<void> closeSales(String eventId) async {
    if (isClosed) return;
    emit(const TicketingLoading());
    try {
      final event = await _repo.closeSales(eventId);
      if (isClosed) return;
      emit(TicketEventSaved(event));
    } catch (e) {
      _fail(e);
    }
  }

  Future<void> cancel(String eventId, String reason) async {
    if (isClosed) return;
    emit(const TicketingLoading());
    try {
      final resp = await _repo.cancelEvent(eventId, reason);
      if (isClosed) return;
      emit(TicketEventCancelled(resp.note));
    } catch (e) {
      _fail(e);
    }
  }

  Future<void> saveEdits({
    required String eventId,
    String? title,
    String? description,
    String? venue,
    String? flyerUrl,
    int? unitPriceMinor,
    int? capacity,
    bool clearCapacity = false,
    DateTime? eventAt,
    DateTime? salesCloseAt,
    String? organiserName,
    Map<String, String>? organiserSocials,

    /// The browse axes. Non-null means "change it"; an empty string is a
    /// deliberate CLEAR, which is why these are nullable rather than ''.
    ///
    /// EDITABLE AFTER SALE, unlike the price and the dates: they carry no
    /// money and appear on no purchase row, so an organiser who filed a
    /// comedy night under Music can fix it while tickets are selling — which
    /// is exactly when somebody will notice.
    String? category,
    String? state,
  }) async {
    if (isClosed) return;
    emit(const TicketingLoading());
    try {
      final event = await _repo.updateEvent(
        eventId: eventId,
        title: title,
        description: description,
        venue: venue,
        flyerUrl: flyerUrl,
        unitPriceMinor: unitPriceMinor,
        capacity: capacity,
        clearCapacity: clearCapacity,
        eventAt: eventAt,
        salesCloseAt: salesCloseAt,
        organiserName: organiserName,
        organiserSocials: organiserSocials,
        category: category,
        state: state,
      );
      if (isClosed) return;
      emit(TicketEventSaved(event));
    } catch (e) {
      _fail(e);
    }
  }

  Future<void> loadEarnings(String eventId) async {
    if (isClosed) return;
    emit(const TicketingLoading());
    try {
      final resp = await _repo.earnings(eventId);
      if (isClosed) return;
      emit(TicketEarningsLoaded(resp));
    } catch (e) {
      _fail(e);
    }
  }

  Future<void> withdraw(String eventId) async {
    if (isClosed) return;
    emit(const TicketingLoading());
    try {
      final resp = await _repo.withdraw(eventId);
      if (isClosed) return;
      emit(TicketPayoutMade(resp));
    } catch (e) {
      _fail(e);
    }
  }

  /// The organiser's door list. APPENDS past page 1, like every list here.
  Future<void> loadAttendees(String eventId, {int page = 1}) async {
    if (isClosed) return;
    await _page('attendees:$eventId:$page', () async {
      final current = state;
      final existing = (page > 1 &&
              current is TicketAttendeesLoaded &&
              current.eventId == eventId)
          ? current.attendees
          : const <tk.EventAttendee>[];
      if (existing.isEmpty) emit(const TicketingLoading());
      try {
        final resp = await _repo.attendees(eventId, page: page);
        if (isClosed) return;
        emit(TicketAttendeesLoaded(
          eventId: eventId,
          attendees: _appendUnique(existing, resp.attendees, (a) => a.ticketId),
          total: resp.total.toInt(),
          page: page,
        ));
      } catch (e) {
        // THE ONLY ONE OF THESE FOUR that used to destroy the list when its
        // tail failed. An organiser checking the door loses the guests they
        // had already pulled up because page three timed out — and at a door,
        // that list is the thing being used.
        if (existing.isNotEmpty) return;
        _fail(e);
      }
    });
  }

  /// Refunds one of this buyer's OWN orders.
  Future<void> requestRefund(String purchaseId) async {
    if (isClosed) return;
    emit(const TicketingLoading());
    try {
      final resp = await _repo.requestRefund(purchaseId);
      if (isClosed) return;
      emit(TicketOrderRefunded(resp));
    } catch (e) {
      _fail(e);
    }
  }

  /// Gives one admission to another Lazervault user.
  ///
  /// No PIN gate and no amount: a transfer moves no money, so there is nothing
  /// for a transaction PIN to authorise. What it DOES do is irreversible from
  /// the sender's side, which is the confirmation the sheet asks for instead.
  Future<void> transferTicket({
    required String ticketId,
    required String toUserId,
  }) async {
    if (isClosed) return;
    emit(const TicketingLoading());
    try {
      final resp =
          await _repo.transferTicket(ticketId: ticketId, toUserId: toUserId);
      if (isClosed) return;
      emit(TicketTransferred(resp));
    } catch (e) {
      _fail(e);
    }
  }

  /// Records a purchase the buy sheet already awaited and displayed.
  void notePurchase(tk.BuyTicketsResponse purchase) {
    if (isClosed) return;
    emit(TicketPurchased(purchase));
  }

  void _fail(Object e) {
    if (isClosed) return;
    final refusal = ticketError(e);
    emit(TicketingFailure(refusal.message, isRetryable: refusal.isRetryable));
  }
}
