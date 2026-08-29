import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/gift_cards/domain/entities/gift_card_entity.dart';
import 'package:lazervault/src/features/gift_cards/services/gift_card_pdf_service.dart';
import 'package:lazervault/src/features/gift_cards/services/receipt_text.dart';

/// The receipt is the artefact a customer keeps after the money has moved, so
/// the bar is that it renders whatever the provider sends — not whatever the
/// provider sends on a good day.
///
/// The inputs below are the SHAPES the two live providers actually produce:
/// Prestmit sends HTML fragments with the numeric entity's hash missing
/// ("&10;" for a newline), and Reloadly sends brand-authored redemption prose
/// with typographic punctuation in it.
void main() {
  group('receiptProse — provider prose for a receipt', () {
    test('decodes the malformed numeric entity Prestmit sends', () {
      expect(receiptProse('Step one&10;Step two'), 'Step one\nStep two');
    });

    test('keeps the line structure of an instruction list', () {
      const raw = '<ol><li>Visit the site</li><li>Enter the code</li></ol>';
      expect(receiptProse(raw), 'Visit the site\nEnter the code');
    });

    test('drops inline markup without breaking the line', () {
      expect(receiptProse('Use <b>this</b> code'), 'Use this code');
    });

    test('an ampersand that is not an entity survives', () {
      // The whole reason decoding is restricted to complete tokens: a browser
      // resolves "&not" mid-sentence, a gift card must not.
      expect(receiptProse('Terms & notes apply'), 'Terms & notes apply');
    });

    test('a run of block tags is one break, not one per tag', () {
      // "</li><li>" is an item boundary, not two. Breaking on each tag put a
      // blank line between every step of an instruction list.
      expect(receiptProse('A<br><br><br><br>B'), 'A\nB');
    });

    test('a paragraph break sent as an entity survives', () {
      // Prestmit's newline is "&10;", so a real paragraph gap arrives as text
      // rather than as markup — and must not be flattened away with it.
      expect(receiptProse('Para one.&10;&10;Para two.'),
          'Para one.\n\nPara two.');
    });

    test('leaves clean text exactly as it is', () {
      const clean = 'Redeem at checkout.';
      expect(receiptProse(clean), clean);
    });
  });

  group('receiptLine — single-row values', () {
    test('resolves an entity in a brand name', () {
      expect(receiptLine('Barnes &amp; Noble'), 'Barnes & Noble');
    });

    test('flattens a multi-line value into one row', () {
      expect(receiptLine('Amazon<br>Canada'), 'Amazon Canada');
    });
  });

  group('pdfSafe — the net under a missing font', () {
    test('substitutes the punctuation providers actually write', () {
      expect(pdfSafe('Don’t — see “terms”…'),
          "Don't - see \"terms\"...");
    });

    test('spells out a currency sign that Helvetica cannot draw', () {
      expect(pdfSafe('₦1,000'), 'NGN1,000');
    });

    test('drops an undrawable character rather than raising', () {
      expect(pdfSafe('gift \u{1F381} card'), 'gift  card');
    });

    test('preserves newlines, so an instruction list keeps its shape', () {
      expect(pdfSafe('one\ntwo'), 'one\ntwo');
    });

    test('is a no-op on plain ASCII', () {
      const plain = 'Redeem at checkout.';
      expect(pdfSafe(plain), plain);
    });
  });

  group('generateReceipt — the file the customer downloads', () {
    // Plain test(), NOT testWidgets(): generateReceipt does real file I/O, and
    // testWidgets runs its body in a fake-async zone where a real Future never
    // completes — the first version of this file hung for ten minutes rather
    // than failing. path_provider is a plugin, so its channel is answered here
    // with a real temp directory.
    late Directory tempDir;

    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      tempDir = await Directory.systemTemp.createTemp('gc_receipt_test');
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('plugins.flutter.io/path_provider'),
        (call) async => tempDir.path,
      );
    });

    tearDownAll(() async {
      if (await tempDir.exists()) await tempDir.delete(recursive: true);
    });

    // Both providers, same code path: nothing in the receipt may depend on
    // WHICH gateway delivered the card.
    GiftCard card({
      required String brandName,
      String? instructions,
      String senderCurrency = '',
      double senderAmount = 0,
    }) =>
        GiftCard(
          id: 'gc-test',
          brandId: 'brand-test',
          brandName: brandName,
          originalAmount: 25,
          currency: 'USD',
          status: 'available',
          purchaseDate: '2026-08-27T10:00:00Z',
          expiryDate: '2027-08-27T10:00:00Z',
          reference: 'GC-6f1c0c2e',
          providerTransactionId: 'PRV-99001',
          redemptionCode: 'ABCD-EFGH-IJKL',
          redemptionInstructions: instructions,
          countryCode: 'US',
          senderCurrency: senderCurrency,
          senderAmount: senderAmount,
        );

    test('renders provider prose that would break the built-in font', () async {
      final file = await GiftCardPdfService.generateReceipt(
        giftCard: card(
          brandName: 'Barnes &amp; Noble',
          // Every hazard at once: a malformed entity, markup, a curly
          // apostrophe and a trademark sign.
          instructions: '<p>Don’t share this code.&10;'
              'Redeem at Barnes &amp; Noble™ checkout.</p>',
        ),
      );
      expect(await file.exists(), isTrue);
      expect(await file.length(), greaterThan(1000));
    });

    test('renders a cross-currency purchase', () async {
      final file = await GiftCardPdfService.generateReceipt(
        giftCard: card(
          brandName: 'Amazon Canada',
          senderCurrency: 'NGN',
          senderAmount: 41250.75,
        ),
      );
      expect(await file.exists(), isTrue);
      expect(await file.length(), greaterThan(1000));
    });
  });
}
