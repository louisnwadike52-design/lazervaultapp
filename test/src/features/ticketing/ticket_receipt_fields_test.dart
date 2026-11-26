import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/ticketing/utils/ticket_receipt_fields.dart';

/// The payload financial-products stamps on a buyer's purchase leg.
Map<String, dynamic> _purchase({String event = 'purchased'}) => {
      'ticket_event_id': 'e-1',
      'ticket_reference': 'TKT-abc',
      'ticket_event': event,
      'ticket_role': 'buyer',
      'ticket_title': 'Lagos Night',
      'ticket_venue': 'Muri Okunola Park',
      'ticket_currency': 'NGN',
      'ticket_quantity': 3,
      'ticket_unit_price': 500000,
      'ticket_fee': 15000,
      'ticket_fee_payer': 'buyer',
      'ticket_buyer_total': 1515000,
      'ticket_organiser_net': 1500000,
      'ticket_organiser_user_id': 'u-1',
      'ticket_event_at': '2026-12-24T19:00:00Z',
      'business_reference': 'TKT-abc',
    };

Map<String, dynamic> _payout() => {
      'ticket_event_id': 'e-1',
      'ticket_reference': 'TKT-PAYOUT-xyz',
      'ticket_event': 'payout',
      'ticket_role': 'organiser',
      'ticket_title': 'Lagos Night',
      'ticket_currency': 'NGN',
      'ticket_tickets_sold': 43,
      'ticket_gross': 21500000,
      'ticket_fee_total': 645000,
      'ticket_organiser_net': 20855000,
      'ticket_payout_amount': 20855000,
      'business_reference': 'TKT-PAYOUT-xyz',
    };

void main() {
  group('describes', () {
    test('matches a ticketing leg carrying the payload', () {
      expect(TicketReceiptFields.describes(_purchase()), isTrue);
      expect(TicketReceiptFields.describes(_payout()), isTrue);
    });

    test('ROWS PREDATING THE PAYLOAD ARE LEFT ALONE', () {
      // The rule EscrowReceiptFields and CryptoReceiptFields both follow:
      // projecting an empty field set over an old row makes that receipt
      // WORSE than leaving it to render the way it does today.
      expect(TicketReceiptFields.describes(null), isFalse);
      expect(TicketReceiptFields.describes({}), isFalse);
      expect(
        TicketReceiptFields.describes({'business_reference': 'TKT-old'}),
        isFalse,
        reason: 'the one key every ledger row has always carried is not '
            'evidence of the new payload',
      );
      // An event name without a reference is not the payload either.
      expect(
        TicketReceiptFields.describes({'ticket_event': 'purchased'}),
        isFalse,
      );
    });
  });

  group('headline', () {
    test('a buyer and an organiser never read the same', () {
      expect(TicketReceiptFields.headline(_purchase()),
          'Tickets: Lagos Night');
      expect(TicketReceiptFields.headline(_payout()),
          'Earnings: Lagos Night');
      expect(TicketReceiptFields.headline(_purchase(event: 'refunded')),
          'Refund: Lagos Night');
    });

    test('degrades without a title rather than printing a dangling colon', () {
      final md = _purchase()..remove('ticket_title');
      expect(TicketReceiptFields.headline(md), 'Tickets bought');
    });

    test('an unmatched row has no headline to give', () {
      expect(TicketReceiptFields.headline({}), '');
    });
  });

  group('rows', () {
    test("a buyer's rows itemise the order, fee named", () {
      final rows = Map.fromEntries(
          TicketReceiptFields.rows(_purchase(), fiatSymbol: '₦'));

      expect(rows['Event'], 'Lagos Night');
      expect(rows['Venue'], 'Muri Okunola Park');
      expect(rows['Tickets'], '3');
      expect(rows['Price each'], '₦5,000.00');
      // THE FEE IS NAMED. A customer shown one figure here and an itemised
      // one later concludes they were overcharged.
      expect(rows['Service fee'], '₦150.00');
      expect(rows['Fee paid by'], 'You');
      expect(rows['Total paid'], '₦15,150.00');
      expect(rows['Ticket reference'], 'TKT-abc');
    });

    test('the fee rows disappear when there is no fee', () {
      final md = _purchase();
      md['ticket_fee'] = 0;
      final rows = Map.fromEntries(
          TicketReceiptFields.rows(md, fiatSymbol: '₦'));
      expect(rows.containsKey('Service fee'), isFalse,
          reason: 'a ₦0.00 fee row reads as a charge the buyer should query');
      expect(rows.containsKey('Fee paid by'), isFalse);
    });

    test('who bore the fee is spelled out, not echoed as a code', () {
      for (final (payer, label) in [
        ('buyer', 'You'),
        ('organiser', 'The organiser'),
        ('split', 'Split with the organiser'),
      ]) {
        final md = _purchase()..['ticket_fee_payer'] = payer;
        final rows =
            Map.fromEntries(TicketReceiptFields.rows(md, fiatSymbol: '₦'));
        expect(rows['Fee paid by'], label);
      }
    });

    test('a refund says REFUNDED, not "total paid"', () {
      final rows = Map.fromEntries(TicketReceiptFields.rows(
          _purchase(event: 'refunded'),
          fiatSymbol: '₦'));
      expect(rows['Refunded'], '₦15,150.00');
      expect(rows.containsKey('Total paid'), isFalse);
    });

    test("an organiser's rows describe the EVENT, not one order", () {
      final rows =
          Map.fromEntries(TicketReceiptFields.rows(_payout(), fiatSymbol: '₦'));
      expect(rows['Tickets sold'], '43');
      expect(rows['Collected from buyers'], '₦215,000.00');
      expect(rows['Platform commission'], '₦6,450.00');
      expect(rows['Paid out'], '₦208,550.00');
      // One ORDER's fields have no place on a payout document.
      expect(rows.containsKey('Tickets'), isFalse);
      expect(rows.containsKey('Price each'), isFalse);
    });

    test('the transaction reference is only added when it DIFFERS', () {
      final same = Map.fromEntries(TicketReceiptFields.rows(_purchase(),
          fiatSymbol: '₦', reference: 'TKT-abc'));
      expect(same.containsKey('Transaction reference'), isFalse,
          reason: 'one string under two labels reads as a rendering bug');

      final differs = Map.fromEntries(TicketReceiptFields.rows(_purchase(),
          fiatSymbol: '₦', reference: 'PLATFORM-999'));
      expect(differs['Transaction reference'], 'PLATFORM-999');
    });

    test('an unmatched row yields nothing at all', () {
      expect(TicketReceiptFields.rows(null, fiatSymbol: '₦'), isEmpty);
      expect(
          TicketReceiptFields.rows({'business_reference': 'x'},
              fiatSymbol: '₦'),
          isEmpty);
    });
  });

  group('the payload crosses a JSON hop, so the readers must tolerate it', () {
    test('numeric STRINGS parse, because JSON makes both reachable', () {
      final md = _purchase();
      md['ticket_quantity'] = '3';
      md['ticket_buyer_total'] = '1515000';
      final rows =
          Map.fromEntries(TicketReceiptFields.rows(md, fiatSymbol: '₦'));
      expect(rows['Tickets'], '3');
      expect(rows['Total paid'], '₦15,150.00');
    });

    test('junk is OMITTED, never thrown — a receipt must always render', () {
      final md = _purchase();
      md['ticket_quantity'] = 'not a number';
      md['ticket_event_at'] = 'not a date';
      late final List<MapEntry<String, String>> rows;
      expect(
          () => rows = TicketReceiptFields.rows(md, fiatSymbol: '₦'),
          returnsNormally);
      final m = Map.fromEntries(rows);
      expect(m.containsKey('Tickets'), isFalse);
      expect(m.containsKey('Event date'), isFalse);
      // The rest of the document still renders.
      expect(m['Total paid'], '₦15,150.00');
    });

    test('a double amount rounds rather than truncating', () {
      final md = _purchase()..['ticket_buyer_total'] = 1515000.6;
      final rows =
          Map.fromEntries(TicketReceiptFields.rows(md, fiatSymbol: '₦'));
      expect(rows['Total paid'], '₦15,150.01');
    });
  });

  test('eventId is exposed for a "view the event" action', () {
    expect(TicketReceiptFields.eventId(_purchase()), 'e-1');
    expect(TicketReceiptFields.eventId(null), '');
  });
}
