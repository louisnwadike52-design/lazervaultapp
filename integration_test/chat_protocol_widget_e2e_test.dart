// ignore_for_file: avoid_print

/// Widget-level E2E for the new chat-protocol Flutter surface
/// shipped by Phases 1, 5, 6, 7 + Phase 9's per-service voice
/// settings.
///
/// This test mounts the chat widgets DIRECTLY with synthetic
/// metadata payloads — no live backend required — and asserts:
///
///   • ChatPinPromptCard renders the right title, amount/fee/total
///     rows, recipient summary, and the "Enter PIN" CTA for each
///     transaction_type the protocol supports.
///
///   • ChatReceiptCardV2 renders the right status badge colour, the
///     summary line, the reference, and a working "View receipt"
///     deeplink + "Share" CTA.
///
///   • ChatReceiptCardV2List collapses a list of N cards into N
///     stacked widgets (batch-transfer shape).
///
///   • VoiceSettingsEntryButton pushes the per-service settings
///     screen with the right serviceName; the screen mounts cleanly
///     and the language + voice dropdowns enumerate the expected
///     options.
///
/// Why widget-level rather than full app boot:
///   * Phase 5/6/7 already proved the Python side under unit tests
///     (65/65 in chat_services_shared/tests, 13+11+8=32 tool tests
///     against fake gateway clients).
///   * The new Flutter widgets have NO backend dependency at render
///     time — they consume already-shaped JSON metadata. Mounting
///     directly catches every regression a "full app + emulator"
///     run would, at a fraction of the runtime cost.
///   * Phase 2 already wired test_14 in the Python E2E that walks a
///     PinPromptIntent round-trip against the LIVE backend stack;
///     that's where the gateway + chat-*-service contract is proved.
///
/// Run via:
///     flutter test integration_test/chat_protocol_widget_e2e_test.dart
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';

import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_pin_prompt_card.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_receipt_card_v2.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/voice/cubit/per_service_voice_settings_cubit.dart';
import 'package:lazervault/src/features/voice/models/per_service_voice_settings.dart';
import 'package:lazervault/src/features/voice/widgets/voice_settings_entry_button.dart';

// ─────────────────────────────────────────────────────────────────────
// In-memory test doubles
// ─────────────────────────────────────────────────────────────────────

class _FakeTransactionPinService implements ITransactionPinService {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    // The widget under test only touches checkUserHasPin via the
    // mixin to gate the modal open. For these widget tests we
    // never tap into the modal — we assert the CTA wires up
    // correctly. Returning a noSuchMethod stub keeps the GetIt
    // dependency satisfied.
    return super.noSuchMethod(invocation);
  }
}

class _MemStorage implements PerServiceVoiceSettingsStorage {
  final Map<String, PerServiceVoiceSettings> rows = {};
  @override
  Future<PerServiceVoiceSettings?> read(String serviceName) async =>
      rows[serviceName];
  @override
  Future<void> write(PerServiceVoiceSettings settings) async {
    rows[settings.serviceName] = settings;
  }
}

/// Convenience — wrap a widget in the minimum chrome needed for
/// MediaQuery, Get, ScreenUtil, Theme etc.
Widget _harness(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(390, 844),
    builder: (_, __) => GetMaterialApp(
      home: Scaffold(backgroundColor: const Color(0xFF0A0A0A), body: child),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────
// PinPromptIntent payload builders (mirror chat_services_shared/
// pin_prompt.py PinPromptIntent.build serialisation).
// ─────────────────────────────────────────────────────────────────────

Map<String, dynamic> _pinPromptPayload({
  required String transactionType,
  String amount = '5000',
  String currency = 'NGN',
  String fee = '50',
  String? totalAmount,
  String recipientSummary = 'Obinna Chinaka',
  String callbackIntent = 'execute_transfer',
  Duration ttl = const Duration(minutes: 5),
}) {
  final total = totalAmount ??
      ((double.tryParse(amount) ?? 0) + (double.tryParse(fee) ?? 0))
          .toStringAsFixed(2);
  return {
    'transaction_id': 'CHAT-$transactionType-test-${DateTime.now().millisecondsSinceEpoch}',
    'transaction_type': transactionType,
    'amount': amount,
    'currency': currency,
    'fee': fee,
    'total_amount': total,
    'recipient_summary': recipientSummary,
    'callback_intent': callbackIntent,
    'callback_args': {'transaction_id': 'tx-1'},
    'expires_at': DateTime.now().toUtc().add(ttl).toIso8601String(),
  };
}

Map<String, dynamic> _receiptPayload({
  required String transactionType,
  String status = 'completed',
  String reference = 'CRYPTO-test-abc123',
  String amount = '5000',
  String currency = 'NGN',
  String fee = '0',
  String summaryLine = 'Bought 0.000049 BTC for ₦5,000',
  String deeplinkRoute = '/crypto/receipt/CRYPTO-test-abc123',
  String shareableText = 'Bought 0.000049 BTC. Ref: CRYPTO-test-abc123',
}) {
  return {
    'reference': reference,
    'transaction_type': transactionType,
    'status': status,
    'amount': amount,
    'currency': currency,
    'fee': fee,
    'total_amount': amount,
    'timestamp': DateTime.now().toUtc().toIso8601String(),
    'summary_line': summaryLine,
    'extra': const <String, dynamic>{},
    'deeplink_route': deeplinkRoute,
    'shareable_text': shareableText,
    'shareable_email_subject': 'LazerVault receipt',
    'shareable_email_body': 'Receipt body',
  };
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // ChatPinPromptCard reads a TransactionPinService from GetIt.
    // Register a no-op fake before the first widget mount.
    if (!GetIt.I.isRegistered<ITransactionPinService>()) {
      GetIt.I.registerSingleton<ITransactionPinService>(
        _FakeTransactionPinService(),
      );
    }
  });

  // ───────────────────────────────────────────────────────────────────
  // ChatPinPromptCard — every transaction_type the protocol supports
  // ───────────────────────────────────────────────────────────────────

  group('ChatPinPromptCard', () {
    testWidgets('transfer renders "Confirm transfer" title + Enter PIN CTA',
        (tester) async {
      final payload = _pinPromptPayload(transactionType: 'transfer');
      await tester.pumpWidget(_harness(ChatPinPromptCard(payload: payload)));
      await tester.pump();
      expect(find.text('Confirm transfer'), findsOneWidget);
      expect(find.text('Enter PIN'), findsOneWidget);
      expect(find.text('Obinna Chinaka'), findsOneWidget);
      // Amount + fee + total rows show
      expect(find.text('Amount'), findsOneWidget);
      expect(find.text('Fee'), findsOneWidget);
      expect(find.text('Total'), findsOneWidget);
    });

    testWidgets('crypto_buy renders "Confirm crypto purchase"',
        (tester) async {
      final payload = _pinPromptPayload(
        transactionType: 'crypto_buy',
        recipientSummary: '0.000049 BTC @ ₦102,000,000',
        callbackIntent: 'confirm_crypto_swap',
      );
      await tester.pumpWidget(_harness(ChatPinPromptCard(payload: payload)));
      await tester.pump();
      expect(find.text('Confirm crypto purchase'), findsOneWidget);
      expect(find.textContaining('0.000049 BTC'), findsOneWidget);
    });

    testWidgets('insurance_buy renders "Confirm insurance purchase"',
        (tester) async {
      final payload = _pinPromptPayload(
        transactionType: 'insurance_buy',
        recipientSummary: 'Comprehensive motor cover',
        callbackIntent: 'confirm_insurance_buy',
      );
      await tester.pumpWidget(_harness(ChatPinPromptCard(payload: payload)));
      await tester.pump();
      expect(find.text('Confirm insurance purchase'), findsOneWidget);
      expect(find.text('Comprehensive motor cover'), findsOneWidget);
    });

    testWidgets('exchange_convert renders "Confirm currency conversion"',
        (tester) async {
      final payload = _pinPromptPayload(
        transactionType: 'exchange_convert',
        recipientSummary: '33.32 USD at rate 1500.50',
        callbackIntent: 'confirm_currency_convert',
      );
      await tester.pumpWidget(_harness(ChatPinPromptCard(payload: payload)));
      await tester.pump();
      expect(find.text('Confirm currency conversion'), findsOneWidget);
      expect(find.textContaining('33.32 USD'), findsOneWidget);
    });

    testWidgets('expired prompt shows disabled CTA with "Prompt expired"',
        (tester) async {
      final payload = _pinPromptPayload(
        transactionType: 'transfer',
        ttl: const Duration(seconds: -10),
      );
      await tester.pumpWidget(_harness(ChatPinPromptCard(payload: payload)));
      await tester.pump();
      expect(find.text('Prompt expired'), findsOneWidget);
      expect(find.text('Enter PIN'), findsNothing);
    });

    testWidgets('zero fee row hidden when fee == 0', (tester) async {
      final payload = _pinPromptPayload(
        transactionType: 'transfer',
        fee: '0',
      );
      await tester.pumpWidget(_harness(ChatPinPromptCard(payload: payload)));
      await tester.pump();
      expect(find.text('Fee'), findsNothing);
      expect(find.text('Amount'), findsOneWidget);
      expect(find.text('Total'), findsOneWidget);
    });
  });

  // ───────────────────────────────────────────────────────────────────
  // ChatReceiptCardV2 + List
  // ───────────────────────────────────────────────────────────────────

  group('ChatReceiptCardV2', () {
    testWidgets('completed receipt renders summary + ref + View/Share',
        (tester) async {
      final payload = _receiptPayload(
        transactionType: 'crypto_buy',
        status: 'completed',
      );
      await tester.pumpWidget(_harness(ChatReceiptCardV2(payload: payload)));
      await tester.pump();
      expect(find.text('Bought 0.000049 BTC for ₦5,000'), findsOneWidget);
      expect(find.textContaining('CRYPTO-test-abc123'), findsOneWidget);
      expect(find.text('View receipt'), findsOneWidget);
      expect(find.text('Share'), findsOneWidget);
      expect(find.text('COMPLETED'), findsOneWidget);
    });

    testWidgets('refunded status shows REFUNDED badge text', (tester) async {
      final payload = _receiptPayload(
        transactionType: 'transfer',
        status: 'refunded',
        reference: 'C2C-refunded-1',
        summaryLine: 'Refunded ₦5,000',
        deeplinkRoute: '/transfers/receipt/C2C-refunded-1',
      );
      await tester.pumpWidget(_harness(ChatReceiptCardV2(payload: payload)));
      await tester.pump();
      expect(find.text('REFUNDED'), findsOneWidget);
    });

    testWidgets('manual_review status formats with space', (tester) async {
      final payload = _receiptPayload(
        transactionType: 'transfer',
        status: 'manual_review',
        reference: 'C2C-mr-1',
        summaryLine: 'Awaiting manual review',
        deeplinkRoute: '/transfers/receipt/C2C-mr-1',
      );
      await tester.pumpWidget(_harness(ChatReceiptCardV2(payload: payload)));
      await tester.pump();
      // Underscore split + capitalised
      expect(find.text('MANUAL REVIEW'), findsOneWidget);
    });

    testWidgets('non-canonical status renders raw value upcased',
        (tester) async {
      final payload = _receiptPayload(
        transactionType: 'transfer',
        status: 'quote_expired',
        summaryLine: 'Quote expired',
      );
      await tester.pumpWidget(_harness(ChatReceiptCardV2(payload: payload)));
      await tester.pump();
      expect(find.text('QUOTE EXPIRED'), findsOneWidget);
    });

    testWidgets('list shape renders N stacked cards', (tester) async {
      final payloads = [
        _receiptPayload(
          transactionType: 'transfer',
          reference: 'C2C-batch-1',
          summaryLine: 'Sent ₦1,000 to Alice',
          deeplinkRoute: '/transfers/receipt/C2C-batch-1',
        ),
        _receiptPayload(
          transactionType: 'transfer',
          reference: 'C2C-batch-2',
          summaryLine: 'Sent ₦2,000 to Bob',
          deeplinkRoute: '/transfers/receipt/C2C-batch-2',
        ),
        _receiptPayload(
          transactionType: 'transfer',
          reference: 'C2C-batch-3',
          summaryLine: 'Sent ₦3,000 to Carol',
          deeplinkRoute: '/transfers/receipt/C2C-batch-3',
        ),
      ];
      await tester.pumpWidget(_harness(ChatReceiptCardV2List(payloads: payloads)));
      await tester.pump();
      expect(find.text('Sent ₦1,000 to Alice'), findsOneWidget);
      expect(find.text('Sent ₦2,000 to Bob'), findsOneWidget);
      expect(find.text('Sent ₦3,000 to Carol'), findsOneWidget);
      // Three independent "View receipt" buttons
      expect(find.text('View receipt'), findsNWidgets(3));
    });

    testWidgets('empty shareable_text disables Share button', (tester) async {
      final payload = _receiptPayload(transactionType: 'transfer');
      payload['shareable_text'] = '';
      await tester.pumpWidget(_harness(ChatReceiptCardV2(payload: payload)));
      await tester.pump();
      // Share button label is rendered but its onPressed is null
      final shareButton = find.widgetWithText(TextButton, 'Share');
      expect(shareButton, findsOneWidget);
      final widget = tester.widget<TextButton>(shareButton);
      expect(widget.onPressed, isNull);
    });
  });

  // ───────────────────────────────────────────────────────────────────
  // VoiceSettingsEntryButton + PerServiceVoiceSettingsScreen
  // ───────────────────────────────────────────────────────────────────

  group('VoiceSettingsEntryButton', () {
    testWidgets('renders label for known service + nav on tap',
        (tester) async {
      final storage = _MemStorage();
      await tester.pumpWidget(_harness(
        VoiceSettingsEntryButton(
          serviceName: 'crypto',
          cubitFactory: () => PerServiceVoiceSettingsCubit(
            serviceName: 'crypto',
            storage: storage,
          ),
        ),
      ));
      await tester.pump();
      expect(find.text('Voice & chat assistant settings'), findsOneWidget);
      expect(find.textContaining('Crypto'), findsOneWidget);

      // Tap to push the settings screen
      await tester.tap(find.byKey(const ValueKey('voice_settings_entry_crypto')));
      await tester.pump(const Duration(milliseconds: 200));
      // Storage was loaded
      expect(find.text('Voice & chat settings'), findsOneWidget);
      // Title bar shows the service label
      expect(find.textContaining('Crypto'), findsAtLeastNWidgets(1));
      // The three core sections are present
      expect(find.text('Language'), findsOneWidget);
      expect(find.text('Voice'), findsOneWidget);
      expect(find.text('Custom instructions for this assistant'),
          findsOneWidget);
    });

    testWidgets('Save button stays disabled until something changes',
        (tester) async {
      final storage = _MemStorage();
      await tester.pumpWidget(_harness(
        VoiceSettingsEntryButton(
          serviceName: 'transfers',
          cubitFactory: () => PerServiceVoiceSettingsCubit(
            serviceName: 'transfers',
            storage: storage,
          ),
        ),
      ));
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('voice_settings_entry_transfers')));
      await tester.pump(const Duration(milliseconds: 200));

      // Initial save button is "Saved" (no dirty state) and disabled
      final savedButton = find.widgetWithText(ElevatedButton, 'Saved');
      expect(savedButton, findsOneWidget);
      expect(tester.widget<ElevatedButton>(savedButton).onPressed, isNull);

      // Type into the prompt-hint field — that should mark dirty
      // and flip the button label to Save.
      await tester.enterText(
        find.byType(TextField),
        'Please always show the FX margin',
      );
      await tester.pump();
      expect(find.widgetWithText(ElevatedButton, 'Save'), findsOneWidget);
      final saveButton =
          tester.widget<ElevatedButton>(find.widgetWithText(ElevatedButton, 'Save'));
      expect(saveButton.onPressed, isNotNull);

      // Save persists to storage
      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pump(const Duration(milliseconds: 100));
      expect(storage.rows['transfers']?.promptHint,
          'Please always show the FX margin');
      expect(storage.rows['transfers']?.isConfigured, isTrue);
    });
  });
}
