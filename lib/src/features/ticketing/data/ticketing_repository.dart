import 'package:fixnum/fixnum.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart'
    as pb_ts;
import 'package:lazervault/src/generated/ticketing.pbgrpc.dart' as tk;

/// Thin gRPC wrapper around the products-gateway TicketingService.
///
/// AMOUNTS ARE MINOR UNITS (kobo) ON THE WIRE, and no conversion happens here.
/// The proto has no major-unit field at all, so a naira value cannot cross this
/// boundary — formatting to naira is a render-time concern only. (The crowdfund
/// path converts at its boundary because crowdfund stores naira; ticketing does
/// not, and that difference is deliberate.)
///
/// THE FEE IS NEVER COMPUTED HERE. `getEvent` returns the server's own quote
/// for one ticket, from the same engine that charges — an app that applied the
/// commission rules itself would drift from the charge and show a total the
/// buyer is not billed.
class TicketingRepository {
  TicketingRepository({
    required tk.TicketingServiceClient client,
    required GrpcCallOptionsHelper callOptions,
  })  : _client = client,
        _callOptions = callOptions;

  final tk.TicketingServiceClient _client;
  final GrpcCallOptionsHelper _callOptions;

  /// THE OPERATOR'S CREATE-FORM POLICY: the price band, whether a free event
  /// may be listed, and the buyer-facing switches.
  ///
  /// Read when the create form opens rather than compiled in. The form used to
  /// refuse any price at or below zero and impose no ceiling of its own, so
  /// free events were impossible in the app however the operator set
  /// `ticket_free_events_enabled`.
  Future<tk.GetTicketingConfigResponse> config() async {
    return _client.getTicketingConfig(
      tk.GetTicketingConfigRequest(),
      options: await _callOptions.withAuth(),
    );
  }

  // ── Buyer ────────────────────────────────────────────────────────────────

  /// The discover list: events that can actually be bought right now.
  ///
  /// The server excludes drafts, sold-out, closed and past events, so a buy
  /// sheet opened from this list does not meet a refusal at the moment of
  /// payment.
  ///
  /// [organiser] is an EXACT host name and is the host page, not a search: it
  /// narrows the list to one host's programme. Both can be set at once —
  /// the host page keeps its own search box.
  /// [category] and [state] are the browse axes and they COMBINE with each
  /// other and with [search] — "comedy in Lagos" is one query. Both are SLUGS
  /// from the config's own lists; sending a label works too (the server
  /// resolves it) but the picker always has the slug, so the slug is what the
  /// app sends.
  Future<tk.ListTicketEventsResponse> listEvents({
    int page = 1,
    int pageSize = 20,
    String search = '',
    String organiser = '',
    String category = '',
    String state = '',
  }) async {
    return _client.listTicketEvents(
      tk.ListTicketEventsRequest(
          page: page,
          pageSize: pageSize,
          search: search,
          organiser: organiser,
          category: category,
          state: state),
      options: await _callOptions.withAuth(),
    );
  }

  /// One event, WITH the server's commission quote for a single ticket.
  Future<tk.GetTicketEventResponse> getEvent(String eventId) async {
    return _client.getTicketEvent(
      tk.GetTicketEventRequest(eventId: eventId),
      options: await _callOptions.withAuth(),
    );
  }

  /// Buys [quantity] tickets.
  ///
  /// [idempotencyKey] IS REQUIRED AND MUST BE STABLE ACROSS RETRIES — it is
  /// what makes a double tap, or a transport retry, one purchase instead of
  /// two charges. Mint it ONCE when the buy sheet opens, never per attempt.
  ///
  /// [transactionPinToken] IS THE CONTROL, NOT A COURTESY. It is the
  /// single-use token the device mints after the holder enters their PIN, and
  /// financial-products validates it server-side against this same
  /// [idempotencyKey] — so a token minted for one order cannot authorise
  /// another. Required here rather than optional: this call spends money, and
  /// an optional parameter is a call site away from spending it unauthorised.
  /// The PIN itself never leaves the PIN sheet.
  Future<tk.BuyTicketsResponse> buyTickets({
    required String eventId,
    required String buyerAccountId,
    required int quantity,
    required String idempotencyKey,
    required String transactionPinToken,
  }) async {
    return _client.buyTickets(
      tk.BuyTicketsRequest(
        eventId: eventId,
        buyerAccountId: buyerAccountId,
        quantity: quantity,
        idempotencyKey: idempotencyKey,
        transactionPinToken: transactionPinToken,
      ),
      options: await _callOptions.withAuth(),
    );
  }

  /// The tickets this user holds. Refunded purchases are excluded server-side.
  Future<tk.ListMyTicketsResponse> myTickets({
    int page = 1,
    int pageSize = 20,
  }) async {
    return _client.listMyTickets(
      tk.ListMyTicketsRequest(page: page, pageSize: pageSize),
      options: await _callOptions.withAuth(),
    );
  }

  // ── Organiser ────────────────────────────────────────────────────────────

  /// Creates a DRAFT event. Nothing is sellable until [publishEvent].
  ///
  /// Returns the organiser's net and the commission for ONE ticket alongside
  /// the event, which is exactly what step 2 of the creation sheet confirms.
  ///
  /// [capacity] null means UNLIMITED — not zero, which would mean an event that
  /// sells nothing. Carried as real proto3 field presence, so there is no
  /// companion flag to forget.
  Future<tk.CreateTicketEventResponse> createEvent({
    required String title,
    String description = '',
    String venue = '',
    String flyerUrl = '',
    String currency = 'NGN',
    required int unitPriceMinor,
    int? capacity,
    tk.TicketFeePayer? feePayer,
    DateTime? salesOpenAt,
    DateTime? salesCloseAt,
    required DateTime eventAt,
    String organiserName = '',
    Map<String, String> organiserSocials = const {},
    String category = '',
    String state = '',
  }) async {
    final req = tk.CreateTicketEventRequest(
      title: title,
      description: description,
      venue: venue,
      flyerUrl: flyerUrl,
      currency: currency,
      unitPriceMinor: Int64(unitPriceMinor),
      eventAt: _tsFrom(eventAt),
    );
    // FIELD PRESENCE, not a companion flag: setting the field IS saying there
    // is a capacity, and leaving it unset IS unlimited. There is no second
    // thing to remember, which is why the proto uses `optional`.
    if (capacity != null) req.capacity = capacity;
    // UNSPECIFIED is left alone so the SERVER applies the admin default. An app
    // that picked one here would hardcode a commission setting the operator
    // owns.
    if (feePayer != null) req.feePayer = feePayer;
    if (salesOpenAt != null) req.salesOpenAt = _tsFrom(salesOpenAt);
    if (salesCloseAt != null) req.salesCloseAt = _tsFrom(salesCloseAt);
    // THE HOST IS OPTIONAL AND STAYS EMPTY WHEN IT IS EMPTY. Defaulting it to
    // the account holder's own name would publish personal identity on a page
    // the holder never chose to put it on — the server's comment on this field
    // says the same, and both sides have to agree or one of them wins by
    // accident.
    final host = organiserName.trim();
    if (host.isNotEmpty) req.organiserName = host;
    organiserSocials.forEach((platform, handle) {
      final h = handle.trim();
      // Blank handles are dropped rather than stored as empty strings: the
      // event page renders a row per entry, and an empty one is a link to
      // nowhere. The server validates the rest.
      if (h.isNotEmpty) req.organiserSocials[platform] = h;
    });
    // THE BROWSE AXES, SENT ONLY WHEN CHOSEN. An unknown value is refused by
    // the server, so sending an empty string deliberately means "not
    // categorised yet" rather than risking a refusal on a draft the organiser
    // has not finished.
    final cat = category.trim();
    if (cat.isNotEmpty) req.category = cat;
    final st = state.trim();
    if (st.isNotEmpty) req.state = st;
    return _client.createTicketEvent(req,
        options: await _callOptions.withAuth());
  }

  /// Edits an event.
  ///
  /// EVERY FIELD IS PAIRED WITH ITS update_* FLAG, which is why each parameter
  /// is nullable and only a non-null one sets the flag: proto3 cannot tell ""
  /// from unset, so sending a bare field would blank everything the caller did
  /// not mention.
  ///
  /// The commercial terms (price, capacity, commission, dates) are refused by
  /// the server once a ticket has been sold. [clearCapacity] expresses "make it
  /// unlimited", which is distinct from "leave capacity alone".
  Future<tk.TicketEvent> updateEvent({
    required String eventId,
    String? title,
    String? description,
    String? venue,
    String? flyerUrl,
    int? unitPriceMinor,
    int? capacity,
    bool clearCapacity = false,
    tk.TicketFeePayer? feePayer,
    DateTime? salesOpenAt,
    bool clearSalesOpenAt = false,
    DateTime? salesCloseAt,
    bool clearSalesCloseAt = false,
    DateTime? eventAt,
    String? organiserName,
    Map<String, String>? organiserSocials,

    /// The browse axes. Non-null means "change it"; an empty string with the
    /// flag set is a deliberate CLEAR, which is why these are nullable rather
    /// than defaulted to ''.
    String? category,
    String? state,
  }) async {
    final req = tk.UpdateTicketEventRequest(eventId: eventId);
    if (title != null) {
      req.title = title;
      req.updateTitle = true;
    }
    if (description != null) {
      req.description = description;
      req.updateDescription = true;
    }
    if (venue != null) {
      req.venue = venue;
      req.updateVenue = true;
    }
    if (flyerUrl != null) {
      req.flyerUrl = flyerUrl;
      req.updateFlyerUrl = true;
    }
    if (unitPriceMinor != null) {
      req.unitPriceMinor = Int64(unitPriceMinor);
      req.updateUnitPrice = true;
    }
    if (capacity != null || clearCapacity) {
      // updateCapacity + a set capacity -> that number.
      // updateCapacity + an unset capacity -> unlimited.
      req.updateCapacity = true;
      if (capacity != null) req.capacity = capacity;
    }
    if (organiserName != null) {
      // Empty is a legitimate value here — it CLEARS the host — which is why
      // this is gated on null rather than on isNotEmpty.
      req.organiserName = organiserName;
      req.updateOrganiserName = true;
    }
    if (organiserSocials != null) {
      // REPLACES whatever is stored. A merge would make removing a handle
      // impossible: an absent key and a key the caller chose not to send are
      // indistinguishable on the wire.
      req.updateOrganiserSocials = true;
      organiserSocials.forEach((platform, handle) {
        final h = handle.trim();
        if (h.isNotEmpty) req.organiserSocials[platform] = h;
      });
    }
    // THE BROWSE AXES. Each paired with its flag, like every other field
    // here: sending the value without the flag is a silent no-op, which reads
    // to the organiser exactly like the edit not saving.
    if (category != null) {
      req.updateCategory = true;
      req.category = category.trim();
    }
    if (state != null) {
      req.updateState = true;
      req.state = state.trim();
    }
    if (feePayer != null) {
      req.feePayer = feePayer;
      req.updateFeePayer = true;
    }
    if (salesOpenAt != null || clearSalesOpenAt) {
      req.updateSalesOpenAt = true;
      if (salesOpenAt != null) req.salesOpenAt = _tsFrom(salesOpenAt);
    }
    if (salesCloseAt != null || clearSalesCloseAt) {
      req.updateSalesCloseAt = true;
      if (salesCloseAt != null) req.salesCloseAt = _tsFrom(salesCloseAt);
    }
    if (eventAt != null) {
      req.eventAt = _tsFrom(eventAt);
      req.updateEventAt = true;
    }
    final resp = await _client.updateTicketEvent(req,
        options: await _callOptions.withAuth());
    return resp.event;
  }

  Future<tk.TicketEvent> publishEvent(String eventId) async {
    final resp = await _client.publishTicketEvent(
      tk.PublishTicketEventRequest(eventId: eventId),
      options: await _callOptions.withAuth(),
    );
    return resp.event;
  }

  /// Stops sales and KEEPS every purchase, so the organiser can withdraw.
  /// Distinct from [cancelEvent], which refunds the buyers.
  Future<tk.TicketEvent> closeSales(String eventId) async {
    final resp = await _client.closeTicketEventSales(
      tk.CloseTicketEventSalesRequest(eventId: eventId),
      options: await _callOptions.withAuth(),
    );
    return resp.event;
  }

  /// Stops sales and REFUNDS every buyer from the ticket pool.
  ///
  /// Moves no money itself — the server's reconciler does the refunds, under
  /// each buyer's own key, so a partial sweep resumes instead of paying twice.
  /// The returned note says so, and the UI should show it.
  Future<tk.CancelTicketEventResponse> cancelEvent(
      String eventId, String reason) async {
    return _client.cancelTicketEvent(
      tk.CancelTicketEventRequest(eventId: eventId, reason: reason),
      options: await _callOptions.withAuth(),
    );
  }

  Future<tk.ListMyTicketEventsResponse> myEvents({
    int page = 1,
    int pageSize = 20,
  }) async {
    return _client.listMyTicketEvents(
      tk.ListMyTicketEventsRequest(page: page, pageSize: pageSize),
      options: await _callOptions.withAuth(),
    );
  }

  /// One event's money, including whether a withdrawal would succeed right now
  /// and — when it would not — the reason to show instead of a dead button.
  Future<tk.GetEventEarningsResponse> earnings(String eventId) async {
    return _client.getEventEarnings(
      tk.GetEventEarningsRequest(eventId: eventId),
      options: await _callOptions.withAuth(),
    );
  }

  /// Withdraws an event's earnings.
  ///
  /// No idempotency key on the wire: the SERVER derives one from the event id,
  /// so a double-tapped Withdraw collides on the unique index instead of paying
  /// twice. `alreadyPaid` on the response tells the UI it was a replay.
  Future<tk.WithdrawEventEarningsResponse> withdraw(String eventId) async {
    return _client.withdrawEventEarnings(
      tk.WithdrawEventEarningsRequest(eventId: eventId),
      options: await _callOptions.withAuth(),
    );
  }

  /// Admits one holder at the door.
  ///
  /// An already-used ticket comes back as a RESPONSE, not an error, carrying
  /// when it was used — a steward needs that on screen, and a gRPC error has
  /// no fields to put it in.
  Future<tk.CheckInTicketResponse> checkIn({
    required String eventId,
    required String code,
    String checkedInBy = '',
  }) async {
    return _client.checkInTicket(
      tk.CheckInTicketRequest(
          eventId: eventId, code: code, checkedInBy: checkedInBy),
      options: await _callOptions.withAuth(),
    );
  }

  /// The organiser's DOOR LIST: one row per admission, not per order.
  ///
  /// A purchase of four is four people through a gate, so a list that showed
  /// one row saying "4" could not be ticked off as they arrived. Carries no
  /// buyer contact details — only a user id, which the app resolves through
  /// the same payee lookup (and the same search-privacy rules) as anywhere
  /// else, so a buyer who has hidden themselves stays hidden here.
  Future<tk.ListEventAttendeesResponse> attendees(
    String eventId, {
    int page = 1,
    int pageSize = 50,
  }) async {
    return _client.listEventAttendees(
      tk.ListEventAttendeesRequest(
          eventId: eventId, page: page, pageSize: pageSize),
      options: await _callOptions.withAuth(),
    );
  }

  // ── Buyer-initiated, both behind admin switches that default OFF ─────────

  /// Refunds one of the caller's OWN orders.
  ///
  /// `alreadyRefunded` means the order was refunded before and the server
  /// reported that rather than paying twice — say "you were already refunded"
  /// instead of showing a second receipt. The refund can be PARTIAL:
  /// `feeKeptMinor` is what the platform retained under the refund fee policy,
  /// so the amount shown must be `amountMinor`, never the original total.
  Future<tk.RequestTicketRefundResponse> requestRefund(
      String purchaseId) async {
    return _client.requestTicketRefund(
      tk.RequestTicketRefundRequest(purchaseId: purchaseId),
      options: await _callOptions.withAuth(),
    );
  }

  /// Gives one admission to another Lazervault user.
  ///
  /// NO MONEY MOVES — the order, the pool, the commission and the organiser's
  /// net are untouched, which is why there is no amount on this call and
  /// nothing to confirm with a PIN.
  Future<tk.TransferTicketResponse> transferTicket({
    required String ticketId,
    required String toUserId,
  }) async {
    return _client.transferTicket(
      tk.TransferTicketRequest(ticketId: ticketId, toUserId: toUserId),
      options: await _callOptions.withAuth(),
    );
  }

  static pb_ts.Timestamp _tsFrom(DateTime d) =>
      pb_ts.Timestamp.fromDateTime(d.toUtc());
}
