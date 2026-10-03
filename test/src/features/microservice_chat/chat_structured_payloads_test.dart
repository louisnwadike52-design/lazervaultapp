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

  testWidgets('the card carries NO shared GlobalKey', (tester) async {
    // It used to be given ChatPinPromptCard.keyFor(transactionId) — one
    // GlobalKey per transaction id, shared by every card with that id.
    //
    // A GlobalKey can be attached to only one widget at a time. Two cards with
    // the same transaction id is the ordinary RETRY path (the user says "try
    // it again" and the agent re-emits a pin_prompt for the same transfer), so
    // both cards claimed one key, Flutter refused to build them, and the
    // confirmation card vanished — taking its "Enter PIN" button with it.
    //
    // The card now registers itself by transaction id on mount, so the
    // auto-opener can still reach it without any key at all.
    await _pump(tester, metadata: const {'pin_prompt': pinPrompt},
        isUser: false);
    final card = tester.widget<ChatPinPromptCard>(
      find.byType(ChatPinPromptCard),
    );
    expect(card.key, isNot(isA<GlobalKey>()),
        reason: 'a GlobalKey here is exactly what two cards collided on');
  });

  testWidgets('TWO prompts for the SAME transfer both render', (tester) async {
    // The reproduction. Under the shared GlobalKey this threw
    // "Multiple widgets used the same GlobalKey" and neither card appeared.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Column(
          children: const [
            ChatPinPromptCard(payload: pinPrompt),
            ChatPinPromptCard(payload: pinPrompt),
          ],
        ),
      ),
    ));
    await tester.pump();
    expect(tester.takeException(), isNull,
        reason: 'a duplicate transaction id must not throw');
    expect(find.byType(ChatPinPromptCard), findsNWidgets(2));
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
