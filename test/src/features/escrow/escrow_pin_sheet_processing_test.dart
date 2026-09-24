import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/escrow/presentation/cubit/escrow_action_exception.dart';

/// No blank screen between the PIN and the receipt.
///
/// Reported from a device: accepting an EscrowPay deal so the funds move dropped
/// the user onto a blank loading screen after they entered their PIN. Both money
/// paths passed `showProcessingPhase: false`, closed the sheet on "PIN Verified",
/// and only THEN called the settlement RPC — so the whole time the money was
/// actually moving there was nothing on screen at all.
///
/// The settlement now runs inside the PIN sheet, which stays open through
/// Verifying → Processing → Released and hands straight off to the receipt.
///
/// THE TRAP THAT CAME WITH THAT FIX: the sheet decides between its success and
/// failure beats by whether its callback THREW, and EscrowCubit.fundOffer and
/// validateRelease both swallow their errors, emit EscrowError and return null.
/// Moving the call inside the callback naively would have made the sheet announce
/// "Funds released" over a release that never happened. The callbacks re-raise;
/// these tests are what keep them re-raising.
void main() {
  group('EscrowActionException carries the cubit message through', () {
    test('its own message is used verbatim', () {
      // The cubit already cleaned this message; replacing it with generic
      // transfer copy would throw away the only specific thing we know.
      expect(
        escrowActionFailureMessage(
          const EscrowActionException('Deal is no longer fundable'),
          fallback: 'generic',
        ),
        'Deal is no longer fundable',
      );
    });

    test('a blank message falls back rather than showing an empty failure', () {
      expect(
        escrowActionFailureMessage(
          const EscrowActionException('   '),
          fallback: 'We couldn’t release the funds.',
        ),
        'We couldn’t release the funds.',
      );
    });

    test('an unrelated error falls back', () {
      // Could just as easily be a transport error as a business one, so it does
      // not get to speak for itself on a money screen.
      expect(
        escrowActionFailureMessage(
          StateError('grpc: unavailable'),
          fallback: 'We couldn’t release the funds.',
        ),
        'We couldn’t release the funds.',
      );
    });

    test('toString is the message, so a stray interpolation stays readable',
        () {
      expect(const EscrowActionException('nope').toString(), 'nope');
    });
  });

  group('the release path', () {
    late String source;

    setUpAll(() {
      final file = File(
        'lib/src/features/escrow/presentation/view/'
        'escrow_deal_detail_screen.dart',
      );
      expect(file.existsSync(), isTrue,
          reason: 'escrow_deal_detail_screen.dart moved — update this test');
      source = file.readAsStringSync();
    });

    test('no longer closes the sheet before settling', () {
      expect(source.contains('showProcessingPhase: false'), isFalse,
          reason: 'this is what produced the blank screen: the sheet closed on '
              '"PIN Verified" and the settlement ran with nothing on screen');
    });

    test('the settlement runs inside onPinValidated', () {
      final idx = source.indexOf('onPinValidated: (t) async {');
      expect(idx, greaterThan(-1),
          reason: 'the callback must do the work, not just capture the token');
      // validateRelease has to be inside that callback, not after the sheet.
      final body = source.substring(idx, idx + 900);
      expect(body, contains('cubit.validateRelease('));
    });

    test('a null result is re-raised so the sheet shows failure', () {
      expect(source, contains('throw EscrowActionException('),
          reason:
              'validateRelease returns null on failure; without a throw the '
              'sheet would announce success over a release that did not happen');
    });

    test('the failure message comes from the cubit', () {
      expect(source, contains('escrowActionFailureMessage('));
    });

    test('the receipt navigation is ordered after the sheet, once', () {
      expect(source, contains('_releaseOwnedByPinSheet'),
          reason: 'the cubit emits success from inside the sheet, so the '
              'BlocListener would otherwise push the receipt over a live sheet');
      // And the flag must always clear, or the listener stays muted for the
      // rest of the screen's life.
      expect(source,
          contains('} finally {\n      _releaseOwnedByPinSheet = false;'));
    });
  });

  group('the fund path', () {
    late String source;

    setUpAll(() {
      final file = File(
        'lib/src/features/escrow/presentation/widgets/'
        'escrow_offer_fund_sheet.dart',
      );
      expect(file.existsSync(), isTrue,
          reason: 'escrow_offer_fund_sheet.dart moved — update this test');
      source = file.readAsStringSync();
    });

    test('no longer closes the sheet before funding', () {
      expect(source.contains('showProcessingPhase: false'), isFalse);
    });

    test('the funding runs inside onPinValidated', () {
      final idx = source.indexOf('onPinValidated: (t) async {');
      expect(idx, greaterThan(-1));
      expect(source.substring(idx, idx + 900), contains('cubit.fundOffer('));
    });

    test('a null deal is re-raised rather than reported as funded', () {
      expect(source, contains('throw EscrowActionException('),
          reason: 'fundOffer returns null on failure, and "Locked in escrow" '
              'over an unfunded deal is the worst possible outcome here');
    });

    test('only a funded deal is handed back to the caller', () {
      expect(source, contains('if (funded != null && mounted)'),
          reason:
              'popping with a null deal would let the caller treat a failed '
              'funding as a created one');
    });
  });
}
