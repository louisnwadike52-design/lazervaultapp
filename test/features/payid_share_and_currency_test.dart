import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/id_pay/domain/entities/id_pay_entity.dart';
import 'package:lazervault/src/features/id_pay/services/id_pay_pdf_service.dart';

/// Two defects reported from the same screenshots.
///
/// 1. **Share did nothing.** Both PayID screens called the legacy
///    `Share.share(...)` with no `sharePositionOrigin`, and share_plus 11 on
///    iOS throws `PlatformException(sharePositionOrigin: argument must be set,
///    {{0,0},{0,0}} must be non-zero)` — the sheet never opened and the
///    failure was swallowed. They also sent one line of text, not the invoice
///    PDF the details bottom sheet has always sent.
/// 2. **A currency picker on creation.** It offered NGN/USD/GBP/EUR whatever
///    the profile holds. A PayID collects into the dashboard-active wallet, so
///    the currency is that wallet's — and a mismatch made `_onCreate` drop the
///    receiving account entirely.
void main() {
  String code(String p) => File(p)
      .readAsStringSync()
      .split('\n')
      .where((l) =>
          !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
      .join('\n');

  const created =
      'lib/src/features/id_pay/presentation/view/id_pay_created_screen.dart';
  const details =
      'lib/src/features/id_pay/presentation/view/id_pay_details_screen.dart';
  const sheet =
      'lib/src/features/id_pay/presentation/widgets/id_pay_details_bottom_sheet.dart';
  const service = 'lib/src/features/id_pay/services/id_pay_pdf_service.dart';
  const create =
      'lib/src/features/id_pay/presentation/view/create_id_pay_screen.dart';

  IDPayEntity payId({
    IDPayAmountMode mode = IDPayAmountMode.fixed,
    double amount = 2500,
    String description = 'Studio session',
    bool neverExpires = false,
    Duration left = const Duration(hours: 5),
    String creatorName = 'Ada Obi',
  }) =>
      IDPayEntity(
        id: 'id-1',
        payId: 'A1B2C3',
        creatorId: 'u-1',
        creatorName: creatorName,
        creatorUsername: 'ada',
        type: IDPayType.oneTime,
        amountMode: mode,
        amount: amount,
        minAmount: 0,
        maxAmount: 0,
        currency: 'NGN',
        description: description,
        status: IDPayStatus.active,
        expiresAt: DateTime.now().add(left),
        createdAt: DateTime.now(),
        totalReceived: 0,
        paymentCount: 0,
        neverExpires: neverExpires,
      );

  group('every PayID share goes through the invoice service', () {
    test('no screen still uses the anchor-less legacy call', () {
      for (final p in [created, details, sheet]) {
        expect(code(p), isNot(contains('Share.share(')),
            reason: '$p shares via a call share_plus 11 rejects on iOS');
      }
    });

    test('both screens share the invoice with an anchor', () {
      for (final p in [created, details]) {
        final s = code(p);
        final i = s.indexOf('IDPayPdfService.shareInvoice(');
        expect(i, greaterThan(-1),
            reason: '$p must send the PDF, not a bare line of text');
        // Scoped to shareInvoice's OWN arguments: searching the whole file is
        // satisfied by the text fallback's anchor, which left the real call
        // unanchored and the iOS sheet still refusing to open.
        final args = s.substring(i, s.indexOf(');', i));
        expect(args, contains('sharePositionOrigin:'),
            reason: '$p passes no popover anchor, so iOS refuses the sheet');
      }
    });

    test('the anchor is captured before the share is awaited', () {
      // The rect comes from the tapped widget. Reading it after an await — or
      // after any navigation — returns null, because the render box is gone.
      for (final p in [created, details]) {
        final s = code(p);
        final captured = s.indexOf('IDPayPdfService.shareOriginFromContext(');
        final shared = s.indexOf('await IDPayPdfService.shareInvoice(');
        expect(captured, greaterThan(-1), reason: '$p captures no anchor');
        expect(shared, greaterThan(captured),
            reason: '$p reads the render box after the await');
      }
    });

    test('a PDF failure still shares the request, and is not swallowed', () {
      for (final p in [created, details]) {
        final s = code(p);
        final i = s.indexOf('await IDPayPdfService.shareInvoice(');
        final tail = s.substring(i);
        expect(tail, contains('} catch (_) {'),
            reason: '$p lets a PDF failure abort the share');
        final fallback = tail.indexOf('IDPayPdfService.shareMessageFor(');
        expect(fallback, greaterThan(-1),
            reason: '$p falls back to nothing, which is the old silent fail');
      }
    });
  });

  group('the share message is legible without opening the app', () {
    test('a fixed request names who, what, how much and the code', () {
      final msg = IDPayPdfService.shareMessageFor(payId());
      expect(msg, contains('Ada Obi is requesting a payment'));
      expect(msg, contains('For: Studio session'));
      expect(msg, contains('Amount: ₦2,500.00'),
          reason: 'the share text must not depend on whether a PDF font '
              'happened to be embedded first');
      expect(msg, contains('PayID: PAY-A1B2C3'));
      expect(msg, contains('Expires in 4 hour(s)'));
    });

    test('a flexible request says the payer chooses, never ₦0.00', () {
      final msg = IDPayPdfService.shareMessageFor(
          payId(mode: IDPayAmountMode.flexible, amount: 0));
      expect(msg, contains('Amount: you choose'));
      expect(msg, isNot(contains('0.00')),
          reason: 'a zero amount reads as "nothing to pay"');
    });

    test('a never-expiring PayID claims no expiry', () {
      // expiresAt is non-nullable and holds a far-future placeholder, so a
      // date comparison would print "Expires in 36500 day(s)".
      final msg = IDPayPdfService.shareMessageFor(
          payId(neverExpires: true, left: const Duration(days: 36500)));
      expect(msg, isNot(contains('Expires')));
      expect(msg, isNot(contains('Expired')));
    });

    test('an empty description omits the line rather than printing "For: "',
        () {
      final msg = IDPayPdfService.shareMessageFor(payId(description: '  '));
      expect(msg, isNot(contains('For:')));
    });

    test('a nameless creator still reads as a Lazervault request', () {
      final msg = IDPayPdfService.shareMessageFor(payId(creatorName: ' '));
      expect(msg, contains('Payment request via Lazervault.'));
      expect(msg, isNot(startsWith(' is requesting')));
    });
  });

  group('the share anchor is never zero', () {
    test('the service resolves its own fallback', () {
      final s = code(service);
      final i = s.indexOf('static Rect _resolveShareOrigin(');
      expect(i, greaterThan(-1));
      final body = s.substring(i, s.indexOf('\n  }', i));
      expect(body, contains('width > 0'));
      expect(body, contains('height > 0'),
          reason: 'a rect with zero height is exactly what iOS refuses');
      expect(body, contains('Rect.fromLTWH(0, 0, 1, 1)'),
          reason: 'with no anchor there must still be a non-zero rect');
    });

    test('both share paths run the anchor through it', () {
      final s = code(service);
      expect(s.split('_resolveShareOrigin(sharePositionOrigin)').length - 1, 2,
          reason: 'a share path that passes the raw rect can pass a zero one');
    });
  });

  group('PayID creation takes the currency, it does not ask', () {
    test('the picker is gone', () {
      final s = code(create);
      expect(s, isNot(contains('_currencies')),
          reason: 'the dropdown source list is still present');
      // The symbol mapper legitimately still knows every currency — what must
      // be gone is the CONTROL that lets the user pick one.
      expect(s, isNot(contains('value: _selectedCurrency')),
          reason: 'a dropdown is still bound to the currency');
      expect(s, isNot(contains('_selectedCurrency = value')),
          reason: 'the currency is still user-writable');
      expect(s, isNot(contains("'Currency',\n            style:")),
          reason: 'the Currency field label still renders');
    });

    test('it is seeded from the dashboard locale, not hardcoded NGN', () {
      final s = code(create);
      expect(s, contains('_selectedCurrency = LocaleGating.currentCurrency'),
          reason: 'a hardcoded seed mints an NGN request for a USD wallet');
    });

    test('it is corrected to the active wallet once summaries load', () {
      // The synchronous snapshot answers null until the account summaries
      // load, which is the normal case when this screen is opened by deep
      // link rather than through the dashboard.
      final s = code(create);
      final i = s.indexOf('Future<void> _syncCurrencyFromActiveAccount()');
      expect(i, greaterThan(-1));
      final body = s.substring(i, s.indexOf('\n  }', i));
      expect(body, contains('await ensureActiveAccountSnapshot()'),
          reason: 'the synchronous read leaves deep-link opens on the locale');
      expect(body, contains('resolved.isEmpty'),
          reason: 'a half-loaded summary would blank the currency');
      expect(body, contains('mounted'));
      expect(code(create), contains('_syncCurrencyFromActiveAccount();'),
          reason: 'the resolver is never called');
    });
  });
}
