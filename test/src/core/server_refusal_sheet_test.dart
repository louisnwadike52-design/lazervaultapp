import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/shared_widgets/server_refusal_sheet.dart';

/// A refusal is not a failure, and the two need different UI.
///
/// Reported from a device: inviting someone who was already at their Family &
/// Friends cap produced a three-second red snackbar reading "this user is at the
/// 3 family & friends accounts limit…". That sentence does not fit a snackbar, it
/// dismissed itself before it could be read, and it offered nothing to do next —
/// so a clear, actionable explanation from the server arrived as a red flash.
///
/// Every error on these screens now comes through this sheet — the classifier
/// picks the TONE (amber rule vs red breakage), not whether the user gets to read
/// the message. Two reasons that is better than routing failures to a snackbar:
///
///  * a mis-classified refusal used to be downgraded to a three-second flash, and
///    the classifier is a keyword list, so it will always miss some;
///  * a refusal can truthfully say "nothing was changed"; a FAILURE cannot — a
///    dropped response is indistinguishable from a rejected request — and that
///    difference needs a sentence, which a snackbar has no room for.
///
/// Success confirmations are still snackbars. Nothing to read, nothing to decide.

const _realRefusal =
    'This user is already at the 3 family & friends accounts limit. '
    'They need to close one of their own before they can join another.';

Future<void> pumpSheet(
  WidgetTester tester, {
  required String message,
  ServerRefusalTone tone = ServerRefusalTone.refusal,
  String? actionLabel,
  VoidCallback? onAction,
  String? hint,
}) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          body: Builder(
            // A TextButton, deliberately: the sheet's action button is an
            // ElevatedButton, and a trigger of the same type would still be in
            // the tree behind the sheet and defeat the "no action button"
            // assertion below.
            builder: (context) => TextButton(
              onPressed: () => showServerRefusal(
                context,
                title: "Couldn't send that invitation",
                message: message,
                tone: tone,
                actionLabel: actionLabel,
                onAction: onAction,
                hint: hint,
              ),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

void main() {
  group('the refusal reaches the user intact', () {
    testWidgets('the whole server message is rendered, not a truncation',
        (tester) async {
      await pumpSheet(tester, message: _realRefusal);
      expect(find.text(_realRefusal), findsOneWidget);
      expect(find.text("Couldn't send that invitation"), findsOneWidget);
    });

    testWidgets('a long message scrolls instead of overflowing',
        (tester) async {
      await pumpSheet(tester, message: List.filled(40, _realRefusal).join(' '));
      // A render overflow would be reported as an exception here.
      expect(tester.takeException(), isNull);
      expect(find.byType(SingleChildScrollView), findsWidgets);
    });

    testWidgets('it stays on screen — there is no auto-dismiss timer',
        (tester) async {
      await pumpSheet(tester, message: _realRefusal);
      // Well past the three seconds the snackbar gave.
      await tester.pump(const Duration(seconds: 10));
      expect(find.text(_realRefusal), findsOneWidget);
    });

    testWidgets('a hint about what was changed is shown when given',
        (tester) async {
      await pumpSheet(
        tester,
        message: _realRefusal,
        hint: 'Nothing was changed.',
      );
      expect(find.text('Nothing was changed.'), findsOneWidget);
    });

    testWidgets('an empty server message still says something actionable',
        (tester) async {
      // A blank body would otherwise render an empty sheet, which is worse than
      // the snackbar it replaced. sanitizeUserFacingError substitutes its own
      // line, so the sheet never has to guard for this itself.
      await pumpSheet(tester, message: '   ');
      expect(
          find.text('Something went wrong. Please try again.'), findsOneWidget);
    });

    testWidgets('raw transport noise is not shown verbatim', (tester) async {
      // The sheet shows the SERVER'S words, but not when those words are a
      // stack trace or an HTTP status line.
      await pumpSheet(
        tester,
        message: 'HTTP connection completed with 502 instead of 200',
      );
      expect(find.textContaining('502'), findsNothing);
    });
  });

  group('dismiss and action', () {
    testWidgets('dismiss closes it', (tester) async {
      await pumpSheet(tester, message: _realRefusal);
      await tester.tap(find.text('Got it'));
      await tester.pumpAndSettle();
      expect(find.text(_realRefusal), findsNothing);
    });

    testWidgets('no action button when no action was supplied', (tester) async {
      await pumpSheet(tester, message: _realRefusal);
      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('the action fires and the sheet closes', (tester) async {
      var fired = 0;
      await pumpSheet(
        tester,
        message: _realRefusal,
        actionLabel: 'Buy a slot',
        onAction: () => fired++,
      );
      await tester.tap(find.text('Buy a slot'));
      await tester.pumpAndSettle();
      expect(fired, 1);
      // Popped BEFORE the callback runs, so a navigating action cannot strand
      // the sheet over the screen it pushed.
      expect(find.text(_realRefusal), findsNothing);
    });
  });

  group('tone', () {
    testWidgets('a refusal is amber and informational, not red',
        (tester) async {
      await pumpSheet(tester, message: _realRefusal);
      // Red on every "no" trains people to read a rule as a breakage.
      expect(find.byIcon(Icons.info_outline_rounded), findsOneWidget);
      expect(find.byIcon(Icons.error_outline_rounded), findsNothing);
    });

    testWidgets('a failure is red', (tester) async {
      await pumpSheet(
        tester,
        message: 'Something went wrong on our side.',
        tone: ServerRefusalTone.failure,
      );
      expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);
    });
  });

  group('looksLikeServerRefusal picks the right messages', () {
    test('the reported message is recognised', () {
      expect(looksLikeServerRefusal(_realRefusal), isTrue);
    });

    test('business-rule refusals are recognised', () {
      for (final m in <String>[
        'only the creator can delete the family account',
        'You have reached the maximum number of accounts',
        'This member already exists in the family',
        'Insufficient balance to allocate that amount',
        'That would exceed the pool balance',
        'Permission denied',
        'You must be an admin to do that',
        'This invitation is no longer valid',
      ]) {
        expect(looksLikeServerRefusal(m), isTrue, reason: m);
      }
    });

    test('transient failures are classified as failures, not refusals', () {
      // Still shown in the sheet — but in the red failure tone, with copy that
      // does not claim nothing was changed, and with no one-tap retry.
      for (final m in <String>[
        'Network error',
        'Request timed out',
        'Service unavailable',
        'Something went wrong',
      ]) {
        expect(looksLikeServerRefusal(m), isFalse, reason: m);
      }
    });

    test('matching is case-insensitive', () {
      expect(looksLikeServerRefusal('ACCOUNT LIMIT REACHED'), isTrue);
    });
  });

  group('it cannot stack', () {
    /// Fires the sheet twice from ONE callback — a cubit emitting the same error
    /// state twice, which is what a failed retry or a double rebuild looks like.
    /// Tapping the trigger a second time would not reproduce it: the sheet's
    /// barrier is over the button and would swallow or dismiss instead.
    Future<void> pumpDouble(WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          builder: (_, __) => MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => TextButton(
                  onPressed: () {
                    showServerRefusal(
                      context,
                      title: "Couldn't send that invitation",
                      message: _realRefusal,
                    );
                    showServerRefusal(
                      context,
                      title: "Couldn't send that invitation",
                      message: _realRefusal,
                    );
                  },
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
    }

    testWidgets('two reports in one frame produce one sheet', (tester) async {
      await pumpDouble(tester);
      // Two sheets would mean the user dismisses the same sentence twice, and the
      // one underneath reads as the app having got stuck.
      expect(find.text(_realRefusal), findsOneWidget);
      expect(find.text('Got it'), findsOneWidget);
    });

    testWidgets('dismissing it leaves nothing behind', (tester) async {
      await pumpDouble(tester);
      await tester.tap(find.text('Got it'));
      await tester.pumpAndSettle();
      expect(find.text(_realRefusal), findsNothing);
    });

    testWidgets('an abandoned sheet does not silence the next one',
        (tester) async {
      // THE LEAK THIS GUARD MUST NOT HAVE. showModalBottomSheet's future
      // completes on pop, so a tree torn down with the sheet still up never
      // completes it and never runs the cleanup. A plain boolean would stay set
      // and every later refusal would silently do nothing — which is strictly
      // worse than the snackbar this replaced.
      await pumpSheet(tester, message: _realRefusal);
      expect(find.text(_realRefusal), findsOneWidget);

      // Discard the tree WITHOUT dismissing — a host screen popped underneath,
      // a stack replacement, a logout.
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();

      await pumpSheet(tester, message: _realRefusal);
      expect(find.text(_realRefusal), findsOneWidget,
          reason: 'the stale flag must self-heal on the unmounted context');
    });
  });

  group('the family screens route every error here', () {
    for (final path in const [
      'lib/src/features/family_account/presentation/views/'
          'family_add_member_screen.dart',
      'lib/src/features/family_account/presentation/views/'
          'family_invite_member_flow_screen.dart',
    ]) {
      test('${path.split('/').last} has no error snackbar left', () {
        final source = File(path).readAsStringSync();
        expect(source, contains('ServerRefusalTone.failure'),
            reason: 'the failure branch must use the sheet, not a red flash');
        // The only snackbar left is the green success one.
        expect(source, isNot(contains('backgroundColor: Colors.red')),
            reason: 'a red error snackbar here means an error path still '
                'bypasses the sheet');
        expect(source, contains('Colors.green'),
            reason: 'success stays a snackbar — there is nothing to read');
      });
    }

    test('the failure copy does not claim nothing was changed', () {
      // The one thing the sheet must not do on a failure: assert an outcome it
      // cannot know. A dropped response looks exactly like a rejection.
      final source = File(
        'lib/src/features/family_account/presentation/views/'
        'family_add_member_screen.dart',
      ).readAsStringSync();
      final idx = source.indexOf('ServerRefusalTone.failure');
      expect(idx, greaterThan(-1));
      final branch = source.substring(idx, idx + 700);
      expect(branch, isNot(contains('Nothing was changed')));
      expect(branch, contains('will already be there as pending'),
          reason: 'it should tell the user how to check, since it cannot say');
    });
  });
}
