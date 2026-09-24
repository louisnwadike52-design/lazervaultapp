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
/// This sheet is for that first kind of message. Transient failures stay in
/// snackbars, which is what a snackbar is for.

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

    test('transient failures are NOT routed to the sheet', () {
      // These belong in a snackbar: short, not the user's fault, fixed by a
      // retry. A modal sheet for a dropped connection is noise.
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
}
