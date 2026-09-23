import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_pin_auto_opener.dart';

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

    testWidgets('opens once per transaction, however many rebuilds', (tester) async {
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

    testWidgets('an unreadable expiry is treated as still valid', (tester) async {
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
  });
}
