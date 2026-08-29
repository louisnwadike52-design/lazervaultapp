import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/gift_cards/domain/entities/gift_card_entity.dart';
import 'package:lazervault/src/features/gift_cards/services/gift_card_pdf_service.dart';

/// Writes one real receipt PDF to a fixed path so its TEXT can be read back
/// with pdftotext — proof that the entities and markup are gone from the
/// finished document, not merely from the string that went into it.
///
/// Kept out of the normal suite name (`*_probe.dart`, not `*_test.dart`) so it
/// only runs when asked for.
void main() {
  test('write a receipt to /tmp for text extraction', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final out = Directory('/tmp/gc_receipt_probe')..createSync(recursive: true);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (call) async => out.path,
    );

    final file = await GiftCardPdfService.generateReceipt(
      giftCard: const GiftCard(
        id: 'gc-probe',
        brandId: 'brand-probe',
        brandName: 'Barnes &amp; Noble',
        originalAmount: 25,
        currency: 'USD',
        status: 'available',
        purchaseDate: '2026-08-27T10:00:00Z',
        expiryDate: '2027-08-27T10:00:00Z',
        reference: 'GC-6f1c0c2e',
        providerTransactionId: 'PRV-99001',
        redemptionCode: 'ABCD-EFGH-IJKL',
        redemptionPin: '4821',
        redemptionInstructions:
            '<ol><li>Visit barnesandnoble.com</li><li>Don’t share this code.&10;'
            'Enter it at checkout.</li></ol>',
        countryCode: 'US',
        senderCurrency: 'NGN',
        senderAmount: 41250.75,
        recipientName: 'Chris O’Brien',
      ),
    );
    File(file.path).copySync('/tmp/gc_receipt_probe/receipt.pdf');
    expect(await file.exists(), isTrue);
  });
}
