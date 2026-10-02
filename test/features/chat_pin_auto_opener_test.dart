import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_pin_auto_opener.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_pin_prompt_card.dart';

/// The PIN sheet opens itself now, so the rules about WHEN it may do that are the whole
/// safety story. Each of these is a way an auto-opening modal goes wrong in a way that is
/// worse than never opening at all.
///
/// The opener drives the card through a GlobalKey, so with no card mounted every eligible
/// open is a harmless no-op — which is exactly what makes the decision logic testable on
/// its own. What these assert is the DECISION, via the observable state it keeps.

Map<String, dynamic> prompt(String id, {String? expiresAt}) => {
      'transaction_id': id,
      if (expiresAt != null) 'expires_at': expiresAt,
    };

void main() {
  group('ChatPinAutoOpener', () {
    testWidgets('does not open prompts that were already in the transcript',
        (tester) async {
      // The worst failure this component could have. loadHistory finishes on the SAME
      // success state a live reply does, so a surface keying "live turn" off the state
      // class alone would pop a PIN pad for a transfer completed days ago — and if the
      // user entered it, act on a stale intent.
      final opener = ChatPinAutoOpener();
      late BuildContext ctx;
      await tester.pumpWidget(MaterialApp(home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      })));

      // First observation carries history. Nothing may open.
      opener.sync(
        context: ctx,
        prompts: [prompt('old-1'), prompt('old-2')],
        isLiveTurn: true,
      );
      expect(opener.debugOpened, isEmpty,
          reason: 'historical prompts must never auto-open');

      // Re-emitting the same history still opens nothing.
      opener.sync(
        context: ctx,
        prompts: [prompt('old-1'), prompt('old-2')],
        isLiveTurn: true,
      );
      expect(opener.debugOpened, isEmpty);
    });

    testWidgets('opens a prompt that appears after priming', (tester) async {
      final opener = ChatPinAutoOpener();
      late BuildContext ctx;
      await tester.pumpWidget(MaterialApp(home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      })));

      opener.sync(context: ctx, prompts: const [], isLiveTurn: true);
      opener.sync(context: ctx, prompts: [prompt('tx-1')], isLiveTurn: true);

      expect(opener.debugOpened, contains('tx-1'));
    });

    testWidgets('opens once per transaction, however many rebuilds',
        (tester) async {
      // A chat list rebuilds constantly — typing indicators, scroll, incoming messages.
      // Re-opening on every rebuild would trap the user in a modal.
      final opener = ChatPinAutoOpener();
      late BuildContext ctx;
      await tester.pumpWidget(MaterialApp(home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      })));

      opener.sync(context: ctx, prompts: const [], isLiveTurn: true);
      for (var i = 0; i < 5; i++) {
        opener.sync(context: ctx, prompts: [prompt('tx-1')], isLiveTurn: true);
      }
      expect(opener.debugOpened.where((id) => id == 'tx-1').length, 1);
    });

    testWidgets('never reopens a prompt the user dismissed', (tester) async {
      // Dismissing means "not now". Reopening reads as the app refusing to take no for
      // an answer — and the card's own button is still there, so the choice stays theirs.
      final opener = ChatPinAutoOpener();
      late BuildContext ctx;
      await tester.pumpWidget(MaterialApp(home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      })));

      opener.sync(context: ctx, prompts: const [], isLiveTurn: true);
      opener.noteCancelled('tx-1');
      opener.sync(context: ctx, prompts: [prompt('tx-1')], isLiveTurn: true);

      expect(opener.debugOpened, isNot(contains('tx-1')));
    });

    testWidgets('a corrected amount re-arms, because it is a new transaction',
        (tester) async {
      // "make it 200" produces a NEW transaction_id. That is a fresh intent and must
      // open even though the previous prompt was cancelled — which is precisely why the
      // guards are keyed by transaction id rather than a single boolean.
      final opener = ChatPinAutoOpener();
      late BuildContext ctx;
      await tester.pumpWidget(MaterialApp(home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      })));

      opener.sync(context: ctx, prompts: const [], isLiveTurn: true);
      opener.noteCancelled('tx-500');
      opener.sync(context: ctx, prompts: [prompt('tx-500')], isLiveTurn: true);
      expect(opener.debugOpened, isNot(contains('tx-500')));

      // The corrected prompt arrives beneath the cancelled one.
      opener.sync(
        context: ctx,
        prompts: [prompt('tx-500'), prompt('tx-200')],
        isLiveTurn: true,
      );
      expect(opener.debugOpened, contains('tx-200'));
    });

    testWidgets('only the newest prompt is considered', (tester) async {
      // The superseded ₦500 prompt stays in the transcript above the corrected one.
      // Opening it would ask the user to confirm the amount they just changed.
      final opener = ChatPinAutoOpener();
      late BuildContext ctx;
      await tester.pumpWidget(MaterialApp(home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      })));

      opener.sync(context: ctx, prompts: const [], isLiveTurn: true);
      opener.sync(
        context: ctx,
        prompts: [prompt('tx-old'), prompt('tx-new')],
        isLiveTurn: true,
      );

      expect(opener.debugOpened, contains('tx-new'));
      expect(opener.debugOpened, isNot(contains('tx-old')));
    });

    testWidgets('an expired prompt does not open', (tester) async {
      // It cannot be completed; the sheet could only fail.
      final opener = ChatPinAutoOpener();
      late BuildContext ctx;
      await tester.pumpWidget(MaterialApp(home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      })));

      final past = DateTime.now().toUtc().subtract(const Duration(minutes: 5));
      opener.sync(context: ctx, prompts: const [], isLiveTurn: true);
      opener.sync(
        context: ctx,
        prompts: [prompt('tx-exp', expiresAt: past.toIso8601String())],
        isLiveTurn: true,
      );

      expect(opener.debugOpened, isNot(contains('tx-exp')));
    });

    testWidgets('an unreadable expiry is treated as still valid',
        (tester) async {
      // The server is the authority on expiry. Refusing to open on a timestamp we failed
      // to parse would block a perfectly valid transfer.
      final opener = ChatPinAutoOpener();
      late BuildContext ctx;
      await tester.pumpWidget(MaterialApp(home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      })));

      opener.sync(context: ctx, prompts: const [], isLiveTurn: true);
      opener.sync(
        context: ctx,
        prompts: [prompt('tx-odd', expiresAt: 'not-a-date')],
        isLiveTurn: true,
      );

      expect(opener.debugOpened, contains('tx-odd'));
    });

    testWidgets('a prompt with no transaction id is ignored', (tester) async {
      // There would be nothing to key the card's GlobalKey on, so the open could only
      // ever be a no-op — better to not record it as opened at all.
      final opener = ChatPinAutoOpener();
      late BuildContext ctx;
      await tester.pumpWidget(MaterialApp(home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      })));

      opener.sync(context: ctx, prompts: const [], isLiveTurn: true);
      opener.sync(context: ctx, prompts: [prompt('')], isLiveTurn: true);

      expect(opener.debugOpened, isEmpty);
    });

    testWidgets('reset re-primes for a new conversation', (tester) async {
      // Switching conversations must not carry one session's opened/cancelled ids into
      // another, and the new conversation's own history must prime rather than open.
      final opener = ChatPinAutoOpener();
      late BuildContext ctx;
      await tester.pumpWidget(MaterialApp(home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      })));

      opener.sync(context: ctx, prompts: const [], isLiveTurn: true);
      opener.sync(context: ctx, prompts: [prompt('tx-1')], isLiveTurn: true);
      expect(opener.debugOpened, contains('tx-1'));

      opener.reset();
      expect(opener.debugOpened, isEmpty);

      // The next conversation's history primes and opens nothing.
      opener.sync(context: ctx, prompts: [prompt('tx-2')], isLiveTurn: true);
      expect(opener.debugOpened, isEmpty);
    });

    testWidgets('a repeat of the SAME transfer reopens the pad',
        (tester) async {
      // THE REPORTED BUG. The chat derives transaction_id from
      // (user, kind, amount, counterparty, 60-second bucket) — deliberately, so
      // the saga can refuse a double-send. Asking "send ₦500 to Chris" twice
      // inside one minute therefore produces the SAME id, and the old flag-based
      // guard swallowed the second ask: the assistant said "enter your PIN on the
      // secure pad" and no pad appeared.
      //
      // A re-ask appends a NEW prompt message, so the id occurs twice in the
      // transcript. That is what distinguishes it from a rebuild.
      final opener = ChatPinAutoOpener();
      late BuildContext ctx;
      await tester.pumpWidget(MaterialApp(home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      })));

      opener.sync(context: ctx, prompts: const [], isLiveTurn: true);
      opener.sync(context: ctx, prompts: [prompt('tx-500')], isLiveTurn: true);
      expect(opener.debugOpenCounts['tx-500'], 1);

      // Rebuilds in between must still not reopen.
      for (var i = 0; i < 3; i++) {
        opener.sync(
            context: ctx, prompts: [prompt('tx-500')], isLiveTurn: true);
      }
      expect(opener.debugOpenCounts['tx-500'], 1,
          reason: 'a rebuild passes the same list and must not reopen');

      // The user asks again; the agent emits another prompt with the same id.
      opener.sync(
        context: ctx,
        prompts: [prompt('tx-500'), prompt('tx-500')],
        isLiveTurn: true,
      );
      expect(opener.debugOpenCounts['tx-500'], 2,
          reason:
              'asking again is a new intent even when the derived id repeats');
    });

    testWidgets('a re-ask overrides an earlier dismissal', (tester) async {
      // Dismissing means "not now" and must survive rebuilds. But someone who
      // closes the pad and then asks again has changed their mind, and refusing
      // to reopen strands them with a card they already tried to use.
      final opener = ChatPinAutoOpener();
      late BuildContext ctx;
      await tester.pumpWidget(MaterialApp(home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      })));

      opener.sync(context: ctx, prompts: const [], isLiveTurn: true);
      opener.sync(context: ctx, prompts: [prompt('tx-500')], isLiveTurn: true);
      opener.noteCancelled('tx-500');

      // Rebuilds after the dismissal: still closed.
      for (var i = 0; i < 3; i++) {
        opener.sync(
            context: ctx, prompts: [prompt('tx-500')], isLiveTurn: true);
      }
      expect(opener.debugOpenCounts['tx-500'], 1);

      // Re-asked.
      opener.sync(
        context: ctx,
        prompts: [prompt('tx-500'), prompt('tx-500')],
        isLiveTurn: true,
      );
      expect(opener.debugOpenCounts['tx-500'], 2);
    });

    testWidgets('a repeat already in history does not open on first sight',
        (tester) async {
      // Two identical prompts loaded from history are still history. Priming
      // records them and opens nothing, regardless of how many there are.
      final opener = ChatPinAutoOpener();
      late BuildContext ctx;
      await tester.pumpWidget(MaterialApp(home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      })));

      opener.sync(
        context: ctx,
        prompts: [prompt('tx-old'), prompt('tx-old')],
        isLiveTurn: true,
      );
      opener.sync(
        context: ctx,
        prompts: [prompt('tx-old'), prompt('tx-old')],
        isLiveTurn: true,
      );
      expect(opener.debugOpened, isEmpty);
    });

    testWidgets('reset forgets the counts too', (tester) async {
      // Switching conversation must not leave an id looking "already opened at
      // count 2" in a transcript where it appears once.
      final opener = ChatPinAutoOpener();
      late BuildContext ctx;
      await tester.pumpWidget(MaterialApp(home: Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      })));

      opener.sync(context: ctx, prompts: const [], isLiveTurn: true);
      opener.sync(context: ctx, prompts: [prompt('tx-1')], isLiveTurn: true);
      expect(opener.debugOpenCounts['tx-1'], 1);

      opener.reset();
      expect(opener.debugOpened, isEmpty);
      expect(opener.debugOpenCounts, isEmpty);
    });
  });

/// THE REQUEST HAS TO SURVIVE AN UNMOUNTED CARD.
///
/// `autoOpenFor` used to be `state?.openModal()` — a null-safe call that did
/// nothing, and said nothing, when the card was not mounted yet. The opener
/// marks a transaction opened BEFORE its post-frame callback runs and never
/// retries, so one missed attempt was permanent: the sheet never came up for
/// that transaction and the user tapped "Enter PIN" by hand every time.
///
/// The card is routinely unmounted at that moment. The transcript is a lazy
/// list, so a prompt appended below the fold is not built until it scrolls into
/// view, and _scrollToBottom() has not landed when the callback fires. Short
/// conversations fit on screen and worked, which is how it shipped looking fine.

  group('auto-open survives a card that is not mounted yet', () {
    setUp(ChatPinPromptCard.debugResetAutoOpen);
    tearDown(ChatPinPromptCard.debugResetAutoOpen);

    test('a request for an unmounted card is remembered, not dropped', () {
      ChatPinPromptCard.autoOpenFor('tx-below-the-fold');
      expect(
        ChatPinPromptCard.debugPendingAutoOpen,
        contains('tx-below-the-fold'),
        reason: 'the request was dropped — this is the bug: the card mounts a '
            'moment later and never learns it was asked to open',
      );
    });

    test('cancelling drops the queued request so it cannot spring back', () {
      ChatPinPromptCard.autoOpenFor('tx-dismissed');
      ChatPinPromptCard.cancelPendingAutoOpen('tx-dismissed');
      expect(
        ChatPinPromptCard.debugPendingAutoOpen,
        isNot(contains('tx-dismissed')),
        reason: 'dismissing means "not now"; a rebuild must not reopen it',
      );
    });

    test('an empty transaction id is never queued', () {
      ChatPinPromptCard.autoOpenFor('');
      expect(ChatPinPromptCard.debugPendingAutoOpen, isEmpty);
    });

    test('queuing is idempotent — a re-ask does not stack duplicates', () {
      ChatPinPromptCard.autoOpenFor('tx-1');
      ChatPinPromptCard.autoOpenFor('tx-1');
      expect(ChatPinPromptCard.debugPendingAutoOpen.length, 1);
    });
  });
}
