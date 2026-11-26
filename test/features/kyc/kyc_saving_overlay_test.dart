import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_saving_overlay.dart';

/// THE "UNRESPONSIVE UI" GUARD.
///
/// Reported 2026-11-24: a customer was shown the screen to correct his
/// details, used it, "after which the UI became unresponsive". It was not —
/// `openKycDateOfBirthFix` awaited the profile write with no progress
/// indicator and no time limit, so after the confirm dialog popped there was a
/// plain form on screen with a live button and nothing to say a save was in
/// flight. On a congested cell that is indistinguishable from a tap that did
/// nothing, and the second tap it invites starts another identity write or
/// another billed verification attempt against a three-attempt cap.
///
/// These pin the two halves that matter: something IS on screen while the
/// write runs, and it ALWAYS comes down — on success, on a throw, and on a
/// socket that never answers. A stranded overlay would be a worse version of
/// the same bug.
void main() {
  Future<void> pump(WidgetTester tester, Future<void> Function(BuildContext) run) async {
    late BuildContext ctx;
    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (c) {
        ctx = c;
        return const Scaffold(body: Text('underneath'));
      }),
    ));
    unawaited(run(ctx));
    await tester.pump();
  }

  testWidgets('the overlay is up while the write is in flight', (tester) async {
    final gate = Completer<String>();
    await pump(tester, (ctx) async {
      await runKycSave<String>(ctx,
          message: 'Saving your date of birth…', action: () => gate.future);
    });

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Saving your date of birth…'), findsOneWidget,
        reason: 'the message passed by the caller must actually be shown');

    gate.complete('done');
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('underneath'), findsOneWidget,
        reason: 'the caller\'s own screen must still be there afterwards');
  });

  testWidgets('it comes down when the action THROWS', (tester) async {
    Object? caught;
    await pump(tester, (ctx) async {
      try {
        await runKycSave<void>(ctx,
            message: 'Saving…', action: () => Future.error(StateError('boom')));
      } catch (e) {
        caught = e;
      }
    });
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing,
        reason: 'a thrown error must not strand a non-dismissible overlay');
    expect(caught, isA<StateError>(),
        reason: 'the error still reaches the caller, which decides the copy');
  });

  testWidgets('it comes down on a TIMEOUT, and reports one', (tester) async {
    Object? caught;
    // Never completes — the hung socket this is really about.
    final never = Completer<void>();
    await pump(tester, (ctx) async {
      try {
        await runKycSave<void>(ctx,
            message: 'Saving…',
            action: () => never.future,
            timeout: const Duration(milliseconds: 20));
      } catch (e) {
        caught = e;
      }
    });

    await tester.pump(const Duration(milliseconds: 60));
    await tester.pumpAndSettle();

    expect(caught, isA<TimeoutException>(),
        reason: 'a timeout must be distinguishable from a refusal — the write '
            'may well have landed, so "could not save" would send a customer '
            'to support over a correction that is already applied');
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('underneath'), findsOneWidget);
  });

  testWidgets('OS back cannot dismiss it mid-write', (tester) async {
    final gate = Completer<void>();
    await pump(tester, (ctx) async {
      await runKycSave<void>(ctx, message: 'Saving…', action: () => gate.future);
    });

    final scope = tester.widget<PopScope>(find.byType(PopScope));
    expect(scope.canPop, isFalse,
        reason: 'leaving mid-flight is how a screen resumes on a stale profile');

    gate.complete();
    await tester.pumpAndSettle();
  });

  group('the write paths actually use it', () {
    test('the date-of-birth editor does not await the network bare', () {
      final src = File(
              'lib/src/features/kyc/presentation/widgets/kyc_profile_fix.dart')
          .readAsStringSync();
      expect(src.contains('runKycSave'), isTrue,
          reason: 'the save must run behind a bounded, blocking overlay');
      expect(src.contains('on TimeoutException'), isTrue,
          reason: 'a timeout needs its own wording, not "could not save"');
      expect(src.contains('applyCorrectedDateOfBirth'), isTrue,
          reason: 'the session copy is what the retry and Mono read the date '
              'from; leaving it stale re-sends the OLD date');
    });

    test('the details editor cannot stick on _saving forever', () {
      final src = File(
              'lib/src/features/kyc/presentation/views/kyc_update_details_screen.dart')
          .readAsStringSync();
      expect(src.contains('NetworkTimeouts.interactive'), isTrue,
          reason: '_saving disables every control on the screen and is cleared '
              'only after the await returns');
      expect(src.contains('on TimeoutException'), isTrue);
    });

    test('the post-verification persist cannot hold up the dashboard', () {
      final src = File(
              'lib/src/features/kyc/presentation/views/bvn_signup_screen.dart')
          .readAsStringSync();
      expect(src.contains('NetworkTimeouts.probe'), isTrue,
          reason: 'it is awaited between a SUCCESSFUL verification and the '
              'navigation that follows it');
    });

    test('Tier 2 carries the verified profile to the dashboard', () {
      final src = File(
              'lib/src/features/kyc/presentation/views/bvn_signup_screen.dart')
          .readAsStringSync();
      // Verification adopts the registry's name and raises the tier
      // server-side and tells this screen nothing, so navigating on the copy
      // loaded at login greeted the holder by the replaced name and gated
      // them on the old tier.
      expect(src.contains('refreshProfileQuietly'), isTrue,
          reason: 'the dashboard must see the tier verification just granted');
      expect(src.contains('refreshProfile()'), isFalse,
          reason: 'the EMITTING refresh makes every login surface call '
              'goAfterLogin — a second router replacing the stack a frame '
              'before this screen does');
    });

    test('Tier 3 bounds its profile refreshes', () {
      final src = File(
              'lib/src/features/kyc/presentation/views/bvn_verification_screen.dart')
          .readAsStringSync();
      expect(src.contains('refreshProfile().timeout(NetworkTimeouts.probe)'),
          isTrue,
          reason: 'it is the last thing between a passed verification and the '
              'screen the customer is waiting for');
      expect(
          RegExp(r'refreshProfile\(\);').hasMatch(src), isFalse,
          reason: 'an unbounded refresh holds a verified customer on the KYC '
              'screen for as long as the socket stays open');
    });

    test('the phone editor in the same flow cannot stick on _busy', () {
      final src = File(
              'lib/src/features/profile/presentation/view/change_phone_screen.dart')
          .readAsStringSync();
      // openKycProfileFix routes a phone refusal straight here, and `_busy`
      // disables the button, the country picker and the back control.
      expect(src.split('NetworkTimeouts.interactive').length - 1, 3,
          reason: 'request, verify and resend each need their own bound');
      expect(src.contains('on TimeoutException'), isTrue);
    });
  });
}
