import 'package:intl/intl.dart';

/// Projects a ticketing ledger row's metadata into the rows a receipt shows.
///
/// WHY THIS EXISTS
/// ---------------
/// Ticketing's ledger rows carried their `description` sentence and nothing
/// else — "Tickets: Lagos Night Market" and an amount. So a buyer's receipt
/// could not say how many tickets it was for, what the service fee was, who
/// bore it, or which reference to quote in a complaint; and an organiser's
/// payout row could not say which event it settled or what that event sold.
/// Both got an anonymous, debit-shaped document for two different events.
///
/// financial-products now stamps the whole purchase on the buyer's legs and
/// the whole event on the organiser's payout, from one builder
/// (ticket_receipt_metadata.go), so the two sides of one sale cannot describe
/// it differently.
///
/// Rows written before that payload existed do not match [describes] and keep
/// rendering exactly as they do today. Projecting an empty field set over them
/// would make old receipts WORSE — the rule EscrowReceiptFields and
/// CryptoReceiptFields both follow.
///
/// AMOUNTS IN THE PAYLOAD ARE MINOR UNITS, because that is what the ledger and
/// the whole ticketing path speak. They are divided here, at the point of
/// rendering, and nowhere else.
class TicketReceiptFields {
  const TicketReceiptFields._();

  static final NumberFormat _money = NumberFormat('#,##0.00');
  static final DateFormat _when = DateFormat('d MMM y, h:mm a');

  /// Whether this row is a ticketing leg carrying the canonical payload.
  ///
  /// Keyed on `ticket_event` + a reference rather than on the service type,
  /// for the reason in the class comment: a row predating the payload has the
  /// service type and none of the facts.
  static bool describes(Map<String, dynamic>? metadata) {
    final event = _str(metadata, 'ticket_event').toLowerCase();
    return const {'purchased', 'refunded', 'payout', 'fee'}.contains(event) &&
        _str(metadata, 'ticket_reference').isNotEmpty;
  }

  /// What this leg did, in the viewer's own words.
  ///
  /// A buyer's copy and an organiser's copy of the same event must never read
  /// the same — "Tickets bought" and "Ticket earnings" are different documents
  /// about different money.
  static String headline(Map<String, dynamic>? metadata) {
    if (!describes(metadata)) return '';
    final title = _str(metadata, 'ticket_title');
    switch (_str(metadata, 'ticket_event').toLowerCase()) {
      case 'refunded':
        return title.isEmpty ? 'Ticket refund' : 'Refund: $title';
      case 'payout':
        return title.isEmpty ? 'Ticket earnings' : 'Earnings: $title';
      case 'fee':
        return 'Ticket commission';
      default:
        return title.isEmpty ? 'Tickets bought' : 'Tickets: $title';
    }
  }

  /// The ordered rows, label → value.
  ///
  /// [fiatSymbol] is passed in rather than read from a locale singleton so
  /// this stays testable on its own, exactly as the escrow and crypto
  /// projections do.
  static List<MapEntry<String, String>> rows(
    Map<String, dynamic>? metadata, {
    required String fiatSymbol,
    String? reference,
  }) {
    if (!describes(metadata)) return const [];
    final event = _str(metadata, 'ticket_event').toLowerCase();
    final out = <MapEntry<String, String>>[];

    void money(String label, String key) {
      final v = _int(metadata, key);
      if (v == null) return;
      out.add(MapEntry(label, '$fiatSymbol${_money.format(v / 100)}'));
    }

    final title = _str(metadata, 'ticket_title');
    if (title.isNotEmpty) out.add(MapEntry('Event', title));
    final venue = _str(metadata, 'ticket_venue');
    if (venue.isNotEmpty) out.add(MapEntry('Venue', venue));
    final when = _date(metadata, 'ticket_event_at');
    if (when != null) out.add(MapEntry('Event date', _when.format(when)));

    if (event == 'payout') {
      // THE ORGANISER'S DOCUMENT answers "which event is this money from, and
      // what did it sell?" — so it carries the event's totals, not one order's.
      final sold = _int(metadata, 'ticket_tickets_sold');
      if (sold != null) out.add(MapEntry('Tickets sold', '$sold'));
      money('Collected from buyers', 'ticket_gross');
      money('Platform commission', 'ticket_fee_total');
      money('Refunded to buyers', 'ticket_refunded');
      money('Your earnings', 'ticket_organiser_net');
      money('Paid out', 'ticket_payout_amount');
    } else {
      // THE BUYER'S DOCUMENT itemises the order. The fee is NAMED rather than
      // folded into the total: a customer shown one figure here and an
      // itemised one later concludes they were overcharged.
      final qty = _int(metadata, 'ticket_quantity');
      if (qty != null) out.add(MapEntry('Tickets', '$qty'));
      money('Price each', 'ticket_unit_price');
      final fee = _int(metadata, 'ticket_fee');
      if (fee != null && fee > 0) {
        money('Service fee', 'ticket_fee');
        final payer = _str(metadata, 'ticket_fee_payer').toLowerCase();
        if (payer.isNotEmpty) {
          out.add(MapEntry(
            'Fee paid by',
            switch (payer) {
              'buyer' => 'You',
              'organiser' => 'The organiser',
              'split' => 'Split with the organiser',
              _ => payer,
            },
          ));
        }
      }
      if (event == 'refunded') {
        // WHAT CAME BACK, NOT WHAT WAS PAID.
        //
        // Under the retain fee policy the platform keeps its commission, so a
        // refund is PARTIAL — and this used to label `ticket_buyer_total`,
        // the ORIGINAL figure, as "Refunded". A buyer who paid ₦5,200 and
        // received ₦5,000 was handed a document saying ₦5,200 came back.
        //
        // `ticket_refund_amount` is absent on rows written before it existed,
        // so the original total is still the fallback — a legacy receipt keeps
        // rendering, which is the rule this whole file is built on.
        money('Originally paid', 'ticket_buyer_total');
        final kept = _int(metadata, 'ticket_refund_fee_kept');
        if (kept != null && kept > 0) {
          money('Booking fee kept', 'ticket_refund_fee_kept');
        }
        if (_int(metadata, 'ticket_refund_amount') != null) {
          money('Refunded', 'ticket_refund_amount');
        } else {
          money('Refunded', 'ticket_buyer_total');
        }
      } else {
        money('Total paid', 'ticket_buyer_total');
      }
    }

    final ref = _str(metadata, 'ticket_reference');
    if (ref.isNotEmpty) out.add(MapEntry('Ticket reference', ref));
    // The platform-wide reference, only when it DIFFERS — repeating one string
    // under two labels reads as a rendering bug.
    final txRef = (reference ?? '').trim();
    if (txRef.isNotEmpty && txRef != ref) {
      out.add(MapEntry('Transaction reference', txRef));
    }
    return out;
  }

  /// The event this row belongs to, for a "view the event" action.
  static String eventId(Map<String, dynamic>? metadata) =>
      _str(metadata, 'ticket_event_id');

  // ── readers ────────────────────────────────────────────────────────────
  //
  // Each tolerates a missing key, a wrong type and a numeric string: the
  // payload crosses a gRPC hop as free-form JSON, so `3` and `"3"` are both
  // reachable. A receipt must never throw — a value that cannot be read is
  // omitted, not an exception over a document the user asked to see.

  static String _str(Map<String, dynamic>? m, String k) {
    final v = m?[k];
    return v == null ? '' : v.toString().trim();
  }

  static int? _int(Map<String, dynamic>? m, String k) {
    final v = m?[k];
    if (v == null) return null;
    if (v is int) return v;
    if (v is num) return v.round();
    return int.tryParse(v.toString().trim());
  }

  static DateTime? _date(Map<String, dynamic>? m, String k) {
    final raw = _str(m, k);
    if (raw.isEmpty) return null;
    return DateTime.tryParse(raw)?.toLocal();
  }
}
