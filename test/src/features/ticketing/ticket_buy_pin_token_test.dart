import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE PIN HAS TO REACH THE SERVER.
///
/// The buy path used to validate the PIN on the device and then call
/// BuyTickets with a session token alone — the PIN sheet was a confirmation
/// step, not an authorisation, and anything holding a JWT could have spent a
/// buyer's money on tickets. financial-products now validates a single-use
/// token server-side against the same idempotency key, and refuses a purchase
/// that carries none (`ticket_buy_pin_required`, default on).
///
/// Source assertions rather than a widget pump: the thing that broke was a
/// callback parameter discarded with `_`, which compiles perfectly and fails
/// only against a live server. Pinning the wiring is what catches that.
void main() {
  late final String sheet;
  late final String repo;
  late final String proto;

  setUpAll(() {
    sheet = File(
      'lib/src/features/ticketing/presentation/widgets/buy_tickets_sheet.dart',
    ).readAsStringSync();
    repo = File(
      'lib/src/features/ticketing/data/ticketing_repository.dart',
    ).readAsStringSync();
    proto = File('lib/src/generated/ticketing.pb.dart').readAsStringSync();
  });

  test('BuyTicketsRequest carries the token field', () {
    expect(
      proto.contains('set transactionPinToken'),
      isTrue,
      reason: 'ticketing.pb.dart predates transaction_pin_token — regenerate '
          'it from services/products-gateway/proto/ticketing.proto. A field '
          'the client does not know about is silently never sent.',
    );
  });

  test('the repository REQUIRES a token on buyTickets', () {
    final buy = repo.substring(repo.indexOf('buyTickets({'));
    final signature = buy.substring(0, buy.indexOf('}) async'));
    expect(
      signature.contains('required String transactionPinToken'),
      isTrue,
      reason: 'an optional PIN token is one call site away from a purchase '
          'that spends money with no authorisation at all',
    );
    expect(
      buy.contains('transactionPinToken: transactionPinToken'),
      isTrue,
      reason: 'the parameter is accepted but never put on the request',
    );
  });

  test('the buy sheet forwards the token the PIN sheet minted', () {
    expect(
      sheet.contains('onPinValidated: (_)'),
      isFalse,
      reason: 'the sheet is discarding the verification token again — that is '
          'exactly how the PIN became a client-side courtesy',
    );
    expect(
      sheet.contains('onPinValidated: (verificationToken) async'),
      isTrue,
    );
    expect(
      sheet.contains('transactionPinToken: verificationToken'),
      isTrue,
      reason: 'the token is captured but not passed to buyTickets',
    );
  });
}
