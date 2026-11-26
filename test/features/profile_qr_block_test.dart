import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/profile/presentation/widgets/profile_qr_block.dart';
import 'package:lazervault/src/features/qr_payment/domain/qr_payload_parser.dart';

/// THE CODE THE DRAWER SHOWS MUST BE THE CODE THE SCANNERS ACCEPT.
///
/// Two different scanners read it — the pay flow and the vendor door scanner
/// — and both go through `QrPayload.parse`. A code this widget builds that
/// parse refuses is worse than no code: the vendor scanner tells the customer
/// theirs is "not a Lazervault profile", which is both wrong and something
/// they cannot act on.
void main() {
  group('the payload round-trips through the real parser', () {
    test('a complete profile produces a RecipientQr', () {
      final payload = buildProfileQrPayload(
        userId: '04595c14-bff2-4ffc-9d83-513b12caf63c',
        username: 'ezekeannemeka',
        fullName: 'Nnaemeka Ezeke',
      );
      expect(payload, isNotNull);

      final parsed = QrPayload.parse(payload!);
      expect(parsed, isA<RecipientQr>(),
          reason: 'this is the exact call both scanners make');
      final r = parsed as RecipientQr;
      expect(r.recipientId, '04595c14-bff2-4ffc-9d83-513b12caf63c');
      expect(r.username, 'ezekeannemeka');
      expect(r.name, 'Nnaemeka Ezeke');
    });

    test('the type is the one the parser switches on', () {
      final payload = buildProfileQrPayload(userId: 'u', username: 'u');
      final decoded = jsonDecode(payload!) as Map<String, dynamic>;
      expect(decoded['type'], 'lazervault_recipient',
          reason: 'any other value falls through to InvalidQr');
      // The parser reads these two names specifically.
      expect(decoded.containsKey('recipientId'), isTrue);
      expect(decoded.containsKey('username'), isTrue);
    });

    test('no name falls back to the username rather than going blank', () {
      final payload = buildProfileQrPayload(userId: 'u1', username: 'tayo');
      final r = QrPayload.parse(payload!) as RecipientQr;
      expect(r.name, 'tayo',
          reason: 'a blank name renders an empty line on the payer\'s screen');
    });
  });

  group('a code that would be REFUSED is never built', () {
    test('no username means no code', () {
      // The parser refuses a RecipientQr without one, and the vendor scanner
      // then blames the customer for it.
      expect(buildProfileQrPayload(userId: 'u1', username: null), isNull);
      expect(buildProfileQrPayload(userId: 'u1', username: ''), isNull);
      expect(buildProfileQrPayload(userId: 'u1', username: '   '), isNull);
    });

    test('no user id means no code', () {
      expect(buildProfileQrPayload(userId: null, username: 'tayo'), isNull);
      expect(buildProfileQrPayload(userId: '  ', username: 'tayo'), isNull);
    });
  });

  group('the Hero flight is wired at both ends', () {
    final src = File('lib/src/features/profile/presentation/widgets/'
            'profile_qr_block.dart')
        .readAsStringSync();

    test('both sizes use one tag', () {
      // A Hero whose two ends disagree does not animate — it cuts, which
      // reads as a bug rather than as a transition.
      expect('kProfileQrHeroTag'.allMatches(src).length, greaterThanOrEqualTo(3),
          reason: 'the constant must be declared and used at both ends');
      expect(src.contains("const String kProfileQrHeroTag"), isTrue);
    });

    test('the flight does not render a scaled QR', () {
      // A QR drawn at a fractional in-between size anti-aliases into
      // something no camera can read, and for ~300ms that is what is on
      // screen. The flight shows a plain card instead.
      expect(src.contains('flightShuttleBuilder'), isTrue,
          reason: 'without this the matrix is interpolated mid-flight');
    });

    test('full screen is a route, not a dialog', () {
      // A dialog takes no part in a Hero flight and swallows the system back
      // gesture — on Android the hardware back would close the drawer under
      // it instead of the code.
      expect(src.contains('PageRouteBuilder'), isTrue);
      expect(src.contains('showDialog'), isFalse);
    });
  });
}
