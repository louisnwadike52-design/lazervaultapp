import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_pin_auto_opener.dart';

// THE BUG, ISOLATED
// -----------------
// Two of the five chat surfaces drive the opener from `BlocConsumer.listener`
// (microservice_chat_content.dart:350, service_chat_bottom_sheet.dart:590).
// `listener` is NOT called for a bloc's initial state — only for changes. So
// their FIRST observation is whichever state change arrives first.
//
// The opener's liveness test was "record whatever is in the transcript on the
// first observation, and only open ids that appear later". That is correct only
// if the first observation is empty or history-only. When the first state
// change a surface sees ALREADY carries a fresh prompt — a chat opened with no
// history, or a sheet reinserted while a prompt is live — priming consumed the
// live prompt and nothing ever opened. The card still rendered, so the user got
// the "Enter PIN" CTA and no pad: the reported symptom, exactly.
//
// It was invisible because declining produced no output. The opener's 18 tests
// all passed throughout, because every one of them calls sync() once to prime
// before the prompt arrives — the one ordering the broken surfaces don't use.

Map<String, dynamic> _legacyPrompt({String txId = 'tx-live'}) => {
      'transaction_id': txId,
      'transaction_type': 'transfer',
      'amount': '2000',
      'currency': 'NGN',
      'expires_at':
          DateTime.now().toUtc().add(const Duration(minutes: 5)).toIso8601String(),
    };

Map<String, dynamic> _authoritativePrompt({
  String txId = 'tx-live',
  int seq = 1,
  Duration issuedOffset = const Duration(seconds: 1),
}) =>
    {
      ..._legacyPrompt(txId: txId),
      'issued_at': DateTime.now().toUtc().add(issuedOffset).toIso8601String(),
      'prompt_seq': seq,
    };

void main() {
  testWidgets(
      'REGRESSION: a surface whose FIRST observation carries a live prompt',
      (tester) async {
    late BuildContext ctx;
    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      }),
    ));

    // Legacy payload — no issued_at, no prompt_seq. This is the old behaviour,
    // kept as the fallback for a partial rollout, and it still swallows.
    final legacy = ChatPinAutoOpener();
    legacy.sync(
      context: ctx,
      prompts: [_legacyPrompt()],
      isLiveTurn: true,
    );
    await tester.pump();
    expect(legacy.debugOpened, isEmpty,
        reason: 'documents the old behaviour: the live prompt is treated as '
            'pre-existing and silently never opens');
    expect(legacy.lastDeclineReason, contains('first observation'),
        reason: 'and now it SAYS so, which it never used to');

    // Same ordering, same single observation — but with the server's
    // issued_at + prompt_seq, the opener does not need to have seen the
    // conversation before.
    final authoritative = ChatPinAutoOpener();
    authoritative.sync(
      context: ctx,
      prompts: [_authoritativePrompt()],
      isLiveTurn: true,
    );
    await tester.pump();
    expect(authoritative.debugOpened, contains('tx-live'),
        reason: 'THE FIX: liveness is arithmetic on a server timestamp, so the '
            'first observation can open');
    expect(authoritative.lastDeclineReason, isNull);
  });

  testWidgets('a prompt minted BEFORE we attached is history and never opens',
      (tester) async {
    late BuildContext ctx;
    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      }),
    ));

    final opener = ChatPinAutoOpener();
    opener.sync(
      context: ctx,
      prompts: [
        _authoritativePrompt(
          txId: 'tx-old',
          seq: 7,
          issuedOffset: const Duration(minutes: -2),
        ),
      ],
      isLiveTurn: true,
    );
    await tester.pump();

    expect(opener.debugOpened, isEmpty);
    expect(opener.lastDeclineReason, contains('history, not a live turn'));
  });

  testWidgets('the swap makes a rebuild a no-op and a re-ask an open',
      (tester) async {
    late BuildContext ctx;
    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      }),
    ));

    final opener = ChatPinAutoOpener();
    // A re-ask inside the same minute derives the SAME transaction_id — that is
    // the saga's deliberate double-send guard — so the id cannot distinguish
    // them. The seq can.
    final first = _authoritativePrompt(seq: 4);
    opener.sync(context: ctx, prompts: [first], isLiveTurn: true);
    await tester.pump();
    expect(opener.debugOpenCounts['tx-live'], 1);

    // Rebuild: same list, same seq.
    opener.sync(context: ctx, prompts: [first], isLiveTurn: true);
    await tester.pump();
    expect(opener.debugOpenCounts['tx-live'], 1,
        reason: 'a rebuild must not reopen');
    expect(opener.lastDeclineReason, contains('already handled'));

    // Re-ask: same id, HIGHER seq.
    opener.sync(
      context: ctx,
      prompts: [first, _authoritativePrompt(seq: 5)],
      isLiveTurn: true,
    );
    await tester.pump();
    expect(opener.debugOpenCounts['tx-live'], 2,
        reason: 'a genuine re-ask reopens even though the id is identical');
  });

  testWidgets('a dismissal sticks, and a later prompt still re-arms',
      (tester) async {
    late BuildContext ctx;
    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      }),
    ));

    final opener = ChatPinAutoOpener();
    opener.sync(
      context: ctx,
      prompts: [_authoritativePrompt(seq: 2)],
      isLiveTurn: true,
    );
    await tester.pump();
    expect(opener.debugOpenCounts['tx-live'], 1);

    opener.noteCancelled('tx-live');

    // The same prompt arriving again on a rebuild must stay closed.
    opener.sync(
      context: ctx,
      prompts: [_authoritativePrompt(seq: 2)],
      isLiveTurn: true,
    );
    await tester.pump();
    expect(opener.debugOpenCounts['tx-live'], 1);

    // A NEW prompt is a new intent and opens.
    opener.sync(
      context: ctx,
      prompts: [_authoritativePrompt(seq: 3)],
      isLiveTurn: true,
    );
    await tester.pump();
    expect(opener.debugOpenCounts['tx-live'], 2);
  });

  testWidgets('reset re-attaches, so the next conversation is not history',
      (tester) async {
    late BuildContext ctx;
    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      }),
    ));

    final opener = ChatPinAutoOpener();
    opener.sync(
      context: ctx,
      prompts: [_authoritativePrompt(txId: 'tx-a', seq: 9)],
      isLiveTurn: true,
    );
    await tester.pump();
    expect(opener.debugOpened, contains('tx-a'));

    opener.reset();

    // A LOWER seq after a reset must still open: the swap cell is per
    // conversation, and the server's counter is per process — another
    // conversation's prompt can legitimately carry a smaller number.
    opener.sync(
      context: ctx,
      prompts: [_authoritativePrompt(txId: 'tx-b', seq: 3)],
      isLiveTurn: true,
    );
    await tester.pump();
    expect(opener.debugOpened, contains('tx-b'),
        reason: 'reset clears the swap cell, not just the legacy sets');
  });

  test('both fields are required before the authoritative path is taken', () {
    expect(ChatPinAutoOpener.hasAuthoritativeOrdering(_legacyPrompt()), isFalse);
    expect(
      ChatPinAutoOpener.hasAuthoritativeOrdering({
        ..._legacyPrompt(),
        'prompt_seq': 3,
      }),
      isFalse,
      reason: 'a seq with no issued_at cannot be tested for liveness',
    );
    expect(
      ChatPinAutoOpener.hasAuthoritativeOrdering({
        ..._legacyPrompt(),
        'issued_at': DateTime.now().toUtc().toIso8601String(),
      }),
      isFalse,
      reason: 'an issued_at with no seq cannot be compare-and-swapped',
    );
    expect(
      ChatPinAutoOpener.hasAuthoritativeOrdering(_authoritativePrompt()),
      isTrue,
    );
  });

  test('a string prompt_seq from JSON still parses', () {
    expect(ChatPinAutoOpener.seqOf({'prompt_seq': '12'}), 12);
    expect(ChatPinAutoOpener.seqOf({'prompt_seq': 12}), 12);
    expect(ChatPinAutoOpener.seqOf({'prompt_seq': 'abc'}), 0);
    expect(ChatPinAutoOpener.seqOf(const {}), 0);
  });
}
