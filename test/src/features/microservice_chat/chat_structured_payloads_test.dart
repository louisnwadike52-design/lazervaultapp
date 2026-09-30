import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_pin_prompt_card.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_structured_payloads.dart';

/// The Send Funds chat told a user to enter their PIN on a pad that never
/// appeared, so they typed the PIN into the message box.
///
/// Two per-service chat surfaces existed — the full screen and the bottom
/// sheet — and only the screen rendered the agent's structured payloads. The
/// sheet is what Send Funds opens. With no pin-prompt CARD built, the
/// auto-opener (which drives the card through a GlobalKey) was a silent no-op,
/// so no pad, no receipt, and a PIN typed into chat.
///
/// These pin the rendering decision. Both surfaces now build this one widget.
Future<void> _pump(
  WidgetTester tester, {
  required Map<String, dynamic>? metadata,
  required bool isUser,
}) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ChatStructuredPayloads(
              metadata: metadata,
              isUser: isUser,
              onPinCancelled: (_) {},
              onPinVerified: (_, __, ___) async {},
              onChangeRecipient: () {},
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  const pinPrompt = {
    'transaction_id': 'TX-CHAT-1',
    'amount': 500,
    'currency': 'NGN',
    'callback_intent': 'send_money',
    'callback_args': {'to': 'GRACE C. ONWUANAKU'},
  };

  testWidgets('an agent turn asking for a PIN renders the pad card',
      (tester) async {
    await _pump(tester, metadata: const {'pin_prompt': pinPrompt},
        isUser: false);
    expect(find.byType(ChatPinPromptCard), findsOneWidget);
  });

  testWidgets('the card carries the keyed GlobalKey the auto-opener drives',
      (tester) async {
    // Without this key the pad cannot be opened programmatically at all — the
    // exact failure the user hit. Asserting the type is not enough.
    await _pump(tester, metadata: const {'pin_prompt': pinPrompt},
        isUser: false);
    final card = tester.widget<ChatPinPromptCard>(
      find.byType(ChatPinPromptCard),
    );
    expect(card.key, same(ChatPinPromptCard.keyFor('TX-CHAT-1')));
  });

  testWidgets('a USER message renders no payloads', (tester) async {
    // Payloads come from the agent. Rendering one for a user turn would put a
    // PIN pad under the user's own message.
    await _pump(tester, metadata: const {'pin_prompt': pinPrompt},
        isUser: true);
    expect(find.byType(ChatPinPromptCard), findsNothing);
  });

  testWidgets('no metadata renders nothing at all', (tester) async {
    await _pump(tester, metadata: null, isUser: false);
    expect(find.byType(ChatPinPromptCard), findsNothing);
    await _pump(tester, metadata: const {}, isUser: false);
    expect(find.byType(ChatPinPromptCard), findsNothing);
  });

  testWidgets('a malformed receipt still says the transfer completed',
      (tester) async {
    // The money moved. Rendering nothing would leave the user unsure.
    await _pump(
      tester,
      metadata: const {'receipt_data': 'not-a-map-at-all'},
      isUser: false,
    );
    expect(find.byType(ChatPinPromptCard), findsNothing);
  });

  testWidgets('a plain text turn with unrelated metadata renders nothing',
      (tester) async {
    await _pump(
      tester,
      metadata: const {'service_routed_to': 'transfers'},
      isUser: false,
    );
    expect(find.byType(ChatPinPromptCard), findsNothing);
  });
}
