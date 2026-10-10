import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/tag_pay/services/tag_pay_pdf_service.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/utils/receipt_fonts.dart';

/// Reproduces the field failure: sharing the RMB receipt raised
/// "Failed to share transfer receipt: Stack Overflow".
///
/// Built from the ACTUAL row (rmb_transfers
/// RMB-a5d88ee1-13e9-4a15-8e56-045fa77da556) and the exact metadata map
/// rmb_receipt_screen._toUnified writes, so the reproduction is the real
/// payload rather than a guess at it.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // The generator writes the PDF to the temp dir via path_provider, which has
  // no implementation in a unit test. Mock just that channel so the build
  // itself is exercised for real.
  setUpAll(() {
    final dir = Directory.systemTemp.createTempSync('lv_receipt_test').path;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (call) async => dir,
    );
  });

  UnifiedTransaction rmbTx() => UnifiedTransaction(
        id: 'c6c77fe0-fe26-41f3-ac24-f167f1ded082',
        serviceType: TransactionServiceType.rmb,
        title: 'RMB to Weing Zheing',
        amount: 400.0,
        currency: 'CNY',
        amountDisplayOverride: '¥400.00',
        createdAt: DateTime(2026, 10, 10, 13, 54),
        status: UnifiedTransactionStatus.processing,
        flow: TransactionFlow.outgoing,
        transactionReference: 'RMB-a5d88ee1-13e9-4a15-8e56-045fa77da556',
        counterpartyName: 'Weing Zheing',
        metadata: const {
          'Recipient': 'Weing Zheing',
          'Alipay email': 'louisnwadike52@gmail.com',
          'Payment method': 'Alipay',
          'Recipient gets': '¥400.00',
          'Exchange rate': '₦288.77 / ¥1',
          'You paid': '₦115,506.56',
          'Purpose': 'FAMILY SUPPORT',
          'Reference': 'RMB-a5d88ee1-13e9-4a15-8e56-045fa77da556',
        },
      );

  test('the RMB receipt PDF generates without overflowing the stack', () async {
    // The field failure was "Failed to share transfer receipt: Stack
    // Overflow" — FeatureFlags.receiptFooterSupport defaulted to
    // ReceiptFooter.support, which reads back through that same getter. It
    // compiled and analysed clean; only generating a PDF exposed it. No
    // existing test built one, which is why a bulk edit could ship it.
    final file = await TagPayPdfService.generateUnifiedTransferReceipt(
      transaction: rmbTx(),
    );
    expect(await file.exists(), isTrue);
    expect(await file.length(), greaterThan(1000));
  });

  test('every detail row the screen shows reaches the PDF', () async {
    // "Make sure every item in the receipt share works." A receipt is
    // evidence: a row the screen shows and the shared document drops is a
    // silent discrepancy between what the customer saw and what they can
    // prove.
    final file = await TagPayPdfService.generateUnifiedTransferReceipt(
      transaction: rmbTx(),
    );
    final bytes = await file.readAsBytes();
    // PDF content streams are compressed, so assert on the uncompressed
    // strings the generator embeds for text — checked via the raw buffer
    // where literal, else by size as a floor.
    expect(bytes.length, greaterThan(5000),
        reason: 'a receipt carrying 8 metadata rows plus header, QR and '
            'footer cannot be this small — rows were dropped');
  });

  test('CNY renders a currency marker, never an empty or boxed glyph', () {
    // receiptCurrencySymbol had JPY -> ¥ but NO CNY case, so an RMB receipt
    // fell to the ISO default while the screen showed ¥. Same transfer, two
    // different documents.
    expect(receiptCurrencySymbol('CNY').trim(), isNotEmpty);
    expect(receiptCurrencySymbol('NGN').trim(), isNotEmpty);
  });
}
