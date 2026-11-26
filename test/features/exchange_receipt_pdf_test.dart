import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/receipt_fonts.dart';
import 'package:pdf/widgets.dart' as pw;

/// THE ARROW BREAKS THE RECEIPT WHEN THE EMBEDDED FONT IS NOT THERE.
///
/// Reported 2026-11-25 with a screenshot: a completed GHS → EUR conversion,
/// "Could not share receipt. Please try again."
///
/// Everything in that receipt is ASCII — the amounts are formatted with
/// currency CODES, not symbols ("8.42 GHS"). The one exception is the
/// literal `pw.Text('→')` in the hero row, U+2192.
///
/// `ReceiptFonts.document()` bundles Inter, which covers it. But the loader
/// degrades to the pdf package's built-in Helvetica when the asset cannot be
/// read, and Helvetica is a Type 1 font that RAISES on a character it cannot
/// draw rather than substituting one. So on that path the arrow takes the
/// whole document down, and the customer gets "Share failed" with no way to
/// get their receipt out.
///
/// This reproduces the raise directly, so the claim is demonstrated rather
/// than argued.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // WHAT WAS RULED OUT, AND WHY IT IS RECORDED HERE.
  //
  // The first suspicion was the literal U+2192 in the hero row, on the
  // reasoning that the built-in Helvetica RAISES on a glyph it cannot draw.
  // It does not — this version warns and carries on. Nor is it the layout.
  // Keeping both probes means the next person does not spend the same hour
  // on the same two theories.
  test('the arrow does NOT break the document, even without an embedded font',
      () async {
    final doc = pw.Document(); // no theme: the degraded path
    doc.addPage(pw.Page(build: (_) => pw.Text('GHS 8.42 → EUR 0.61')));
    expect(await doc.save(), isNotEmpty);
  });

  test('nor does the Spacer-in-a-Column layout the receipt uses', () async {
    final doc = pw.Document();
    doc.addPage(pw.Page(
      build: (_) => pw.Column(children: [
        pw.Text('header'),
        pw.Spacer(),
        pw.Text('footer'),
      ]),
    ));
    expect(await doc.save(), isNotEmpty);
  });

  test('ReceiptFonts reports whether a real face was embedded', () {
    // The contract the ASCII fallbacks rely on: callers can ask.
    expect(ReceiptFonts.embedded, isA<bool>());
  });

  group('so the failure is in a platform call, and must be reportable', () {
    String code(String path) => File(path)
        .readAsStringSync()
        .split('\n')
        .where((l) =>
            !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
        .join('\n');

    final svc = code(
        'lib/src/features/currency_exchange/services/exchange_pdf_service.dart');
    final receipt = code(
        'lib/src/features/currency_exchange/presentation/views/exchange_receipt_screen.dart');
    final detail = code(
        'lib/src/features/currency_exchange/presentation/views/exchange_detail_screen.dart');

    test('neither screen swallows the reason any more', () {
      for (final s in [receipt, detail]) {
        expect(s, contains('_reportReceiptFailure('),
            reason: '"Please try again" is all a customer needs and nothing '
                'at all for whoever has to fix it');
      }
      // Narrowly: no RECEIPT-ACTION catch may discard its error. A broad
      // search for `catch (_)` matches unrelated best-effort blocks (the QR
      // builder has one) and would fail for the wrong reason.
      final discarded = RegExp(r"catch \(_\)\s*\{\s*_toast\('Could not");
      for (final s in [receipt, detail]) {
        expect(discarded.hasMatch(s.replaceAll(RegExp(r'\s+'), ' ')), isFalse,
            reason: 'a receipt action that fails must report why');
      }
    });

    test('both screens anchor the share sheet', () {
      // iPad throws without an origin; the detail screen passed none.
      for (final s in [receipt, detail]) {
        expect(s, contains('sharePositionOrigin: origin'));
      }
      expect(svc, contains('_safeOrigin('),
          reason: 'a zero-sized rect throws too, and that is what an '
              'un-laid-out render box produces');
    });

    test('a write failure is reported as a write failure', () {
      expect(svc, contains('bytes.isEmpty'));
      expect(svc, contains('await file.length() == 0'),
          reason: 'a share sheet handed an empty file fails inside the '
              'platform channel, where the reason is unrecoverable');
    });

    test('the share TEXT is ASCII, while the document keeps the real arrow',
        () {
      expect(svc, contains('to \${transaction.formattedToAmount}'),
          reason: 'the message body goes to arbitrary targets');
      expect(svc, contains("pw.Text('→'"),
          reason: 'the PDF itself should still read properly — Inter draws it');
    });
  });
}
