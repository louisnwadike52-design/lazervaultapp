import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:lazervault/src/features/microservice_chat/cubit/general_chat_state.dart';
import 'package:lazervault/src/features/microservice_chat/domain/entities/general_chat_message_entity.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_pin_auto_opener.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_pin_prompt_card.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/transaction_pin/widgets/transaction_pin_modal.dart';

import 'chat_pin_fakes.dart';

// WHAT THIS REPRODUCES
// --------------------
// The opener's own 18 tests pass and the card's own 5 tests pass, yet the pad
// does not appear in the app. Both suites test a HALF: the opener's tests feed
// it hand-built lists and assert its decision; the card's tests call
// autoOpenFor directly. Neither runs the sequence the cubit actually emits.
//
// So this harness is the real shape of general_chat_content: a BlocBuilder that
// calls sync() from its builder, rendering real ChatPinPromptCards from
// metadata['pin_prompt'], driven through the cubit's genuine emission order —
// which matters because loadHistory() finishes on GeneralChatSuccess, the SAME
// state a live reply uses (general_chat_cubit.dart:231 vs :428).

class _Harness extends Cubit<GeneralChatState> {
  _Harness() : super(const GeneralChatInitial(messages: []));
  void push(GeneralChatState s) => emit(s);
}

GeneralChatMessageEntity _bot({
  required String text,
  Map<String, dynamic>? pinPrompt,
  DateTime? at,
}) =>
    GeneralChatMessageEntity(
      text: text,
      isUser: false,
      timestamp: at ?? DateTime.now(),
      metadata: {
        if (pinPrompt != null) 'pin_prompt': pinPrompt,
      },
    );

GeneralChatMessageEntity _user(String text, {DateTime? at}) =>
    GeneralChatMessageEntity(
      text: text,
      isUser: true,
      timestamp: at ?? DateTime.now(),
    );

/// A faithful stand-in for general_chat_content's body.
class _ChatSurface extends StatefulWidget {
  const _ChatSurface();

  @override
  State<_ChatSurface> createState() => _ChatSurfaceState();
}

class _ChatSurfaceState extends State<_ChatSurface> {
  final ChatPinAutoOpener _pinAutoOpener = ChatPinAutoOpener();

  List<Map<String, dynamic>> _pinPromptsIn(List<dynamic> messages) {
    final out = <Map<String, dynamic>>[];
    for (final m in messages) {
      try {
        if (m.isUser == true) continue;
        final raw = m.metadata?['pin_prompt'];
        if (raw is Map) out.add(Map<String, dynamic>.from(raw));
      } catch (_) {}
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_Harness, GeneralChatState>(
      builder: (context, state) {
        _pinAutoOpener.sync(
          context: context,
          prompts: _pinPromptsIn(state.messages),
          isLiveTurn: state is GeneralChatSuccess,
        );
        return ListView(
          children: [
            for (final m in state.messages)
              if (m.metadata?['pin_prompt'] is Map)
                ChatPinPromptCard(
                  payload:
                      Map<String, dynamic>.from(m.metadata!['pin_prompt'] as Map),
                  onCancelled: () => _pinAutoOpener.noteCancelled(
                    ChatPinAutoOpener.transactionIdOf(
                      Map<String, dynamic>.from(
                          m.metadata!['pin_prompt'] as Map),
                    ),
                  ),
                )
              else
                ListTile(title: Text(m.text)),
          ],
        );
      },
    );
  }
}

void main() {
  late _Harness harness;

  setUpAll(() {
    final view =
        TestWidgetsFlutterBinding.ensureInitialized().platformDispatcher.views.first;
    view.physicalSize = const Size(1170, 2532);
    view.devicePixelRatio = 3.0;
    addTearDown(() {
      view.resetPhysicalSize();
      view.resetDevicePixelRatio();
    });
  });

  setUp(() {
    ChatPinPromptCard.debugResetAutoOpen();
    harness = _Harness();
    final gi = GetIt.I;
    if (gi.isRegistered<ITransactionPinService>()) {
      gi.unregister<ITransactionPinService>();
    }
    gi.registerSingleton<ITransactionPinService>(FakePinService());
  });

  tearDown(() async {
    await harness.close();
    ChatPinPromptCard.debugResetAutoOpen();
    if (GetIt.I.isRegistered<ITransactionPinService>()) {
      GetIt.I.unregister<ITransactionPinService>();
    }
  });

  Future<void> pump(WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, __) => MaterialApp(
          home: BlocProvider<_Harness>.value(
            value: harness,
            child: const Scaffold(body: _ChatSurface()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('THE REPORTED BUG: a live prompt after history does not open',
      (tester) async {
    await pump(tester);

    // 1. History load finishes on GeneralChatSuccess — the same state a live
    //    reply uses. It carries an old, EXPIRED prompt.
    harness.push(GeneralChatSuccess(messages: [
      _user('send 500 to Chris', at: DateTime(2026, 9, 1, 10)),
      _bot(
        text: 'Enter your PIN to confirm 500 NGN.',
        at: DateTime(2026, 9, 1, 10, 1),
        pinPrompt: pinPayload(
          txId: 'tx-old',
          expiresAt: DateTime(2026, 9, 1, 10, 6).toUtc().toIso8601String(),
        ),
      ),
    ]));
    await tester.pumpAndSettle();
    expect(find.byType(TransactionPinModal), findsNothing,
        reason: 'a replayed historical prompt must never open the pad');

    // 2. User asks for a new transfer. Loading carries only the user message.
    harness.push(GeneralChatLoading(messages: [
      _user('send 500 to Chris', at: DateTime(2026, 9, 1, 10)),
      _bot(
        text: 'Enter your PIN to confirm 500 NGN.',
        at: DateTime(2026, 9, 1, 10, 1),
        pinPrompt: pinPayload(
          txId: 'tx-old',
          expiresAt: DateTime(2026, 9, 1, 10, 6).toUtc().toIso8601String(),
        ),
      ),
      _user('send 2000 to Ada'),
    ]));
    await tester.pumpAndSettle();

    // 3. The live reply arrives with a FRESH prompt.
    harness.push(GeneralChatSuccess(messages: [
      _user('send 500 to Chris', at: DateTime(2026, 9, 1, 10)),
      _bot(
        text: 'Enter your PIN to confirm 500 NGN.',
        at: DateTime(2026, 9, 1, 10, 1),
        pinPrompt: pinPayload(
          txId: 'tx-old',
          expiresAt: DateTime(2026, 9, 1, 10, 6).toUtc().toIso8601String(),
        ),
      ),
      _user('send 2000 to Ada'),
      _bot(
        text: 'Enter your PIN to confirm 2000 NGN.',
        pinPrompt: pinPayload(txId: 'tx-new', amount: '2000'),
      ),
    ]));
    await tester.pumpAndSettle();

    expect(
      find.byType(TransactionPinModal),
      findsOneWidget,
      reason: 'THIS is the reported failure: the card renders with its '
          '"Enter PIN" CTA but the secure pad never opens by itself',
    );
  });

  testWidgets('a fresh conversation: the very first prompt opens',
      (tester) async {
    await pump(tester);

    harness.push(GeneralChatLoading(messages: [_user('send 2000 to Ada')]));
    await tester.pumpAndSettle();

    harness.push(GeneralChatSuccess(messages: [
      _user('send 2000 to Ada'),
      _bot(
        text: 'Enter your PIN to confirm 2000 NGN.',
        pinPrompt: pinPayload(txId: 'tx-new', amount: '2000'),
      ),
    ]));
    await tester.pumpAndSettle();

    expect(find.byType(TransactionPinModal), findsOneWidget);
  });
}
