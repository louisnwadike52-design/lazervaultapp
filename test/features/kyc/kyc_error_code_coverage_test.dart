import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/kyc/domain/pending_signup_identity.dart';

/// EVERY REFUSAL MUST LEAD SOMEWHERE THE CUSTOMER CAN GO.
///
/// Audited 2026-11-24. The KYC backends return ~30 error codes; the app
/// branched on a third of them and sent the rest to a generic "check it and
/// try again" with a Try Again link. For a typo that is right. For an outage,
/// a spent OTP, or a switched-off provider it is a dead end dressed as advice
/// — the customer is told to fix something that was never wrong, on a gate
/// with no skip and no back.
void main() {
  String code(String path) {
    final f = File(path);
    if (!f.existsSync()) fail('missing file: $path');
    return f.readAsLinesSync().where((l) {
      final t = l.trimLeft();
      return !t.startsWith('//') && !t.startsWith('///');
    }).join('\n');
  }

  group('an outage is never reported as the customer\'s mistake', () {
    // The two services spell the SAME condition differently, and only one
    // spelling was listed — so a provider that is switched off was reported
    // as a bad number, forever.
    for (final c in const [
      'PROVIDER_UNAVAILABLE', // banking-service
      'PROVIDER_NOT_AVAILABLE', // auth-service — the one that was missing
      'PROVIDER_ERROR',
      'IDENTITY_CHECK_UNAVAILABLE', // our database, not their number
      'IDENTITY_STORE_RETRY', // verified; only our write failed
      'VERIFICATION_UPDATE_FAILED', // verified; only the profile write failed
    ]) {
      test('$c counts as infrastructure', () {
        expect(isIdentityInfrastructureFailure(c), isTrue,
            reason: '$c is our problem. Telling the customer to re-check a '
                'number they typed correctly is the wrong instruction, and '
                'the retry can never succeed.');
      });
    }

    test('a genuine mismatch is NOT swept in', () {
      // The flip side: if everything were "infrastructure" the customer would
      // never be told about a fixable problem.
      expect(isIdentityInfrastructureFailure('IDENTITY_DETAILS_MISMATCH'),
          isFalse);
      expect(isIdentityInfrastructureFailure('IDENTITY_DOB_MISMATCH'), isFalse);
      expect(isIdentityInfrastructureFailure('BVN_ALREADY_REGISTERED'), isFalse);
    });
  });

  test('a stashed-NIN date mismatch clears the stash', () {
    // It fell to `default` → unavailable, which says nothing AND leaves the
    // stash in place — so every later attempt ran another BILLED lookup that
    // failed identically, silently, for ever.
    final src = code('lib/src/features/kyc/domain/pending_signup_identity.dart');
    expect(src.contains("case 'IDENTITY_DOB_MISMATCH':"), isTrue,
        reason: 'an unhandled DOB mismatch re-bills a NIN lookup on every '
            'attempt and never tells the customer what is wrong');
  });

  test('the OTP sheet never shows a spent-OTP retry as a wrong code', () {
    final src = code(
        'lib/src/features/kyc/presentation/widgets/bvn_lookup_consent_sheet.dart');
    expect(src.contains("code == 'IDENTITY_STORE_RETRY'"), isTrue,
        reason: 'the check PASSED and our write failed. Rendering that under '
            'the OTP field reads as "your code is wrong" on a code that was '
            'right — and the next tap burns a date-of-birth attempt instead');
    expect(src.contains("code == 'IDENTITY_CHECK_UNAVAILABLE'"), isTrue);
  });

  test('a silent session expiry always carries a message', () {
    final src =
        code('lib/src/features/kyc/presentation/views/bvn_signup_screen.dart');
    // The retry affordance is gated on _inlineError being non-null, so a bare
    // _inlineRetryable leaves the screen pixel-identical — the literal
    // "nothing happened" a customer reports as a frozen app.
    expect(
      src.contains('setState(() => _inlineRetryable = true);'),
      isFalse,
      reason: 'setting the retry flag without a message renders NOTHING: the '
          'affordance is gated on the message being present',
    );
  });

  test('a new lookup session restores the correction budget', () {
    final src =
        code('lib/src/features/kyc/presentation/views/bvn_signup_screen.dart');
    expect(src.contains('_dobCorrectionsUsed = 0;'), isTrue,
        reason: 'the server replaces the session on initiate, so a customer '
            'who paid for a SECOND lookup gets three fresh tries. Carrying '
            'the old tally sent them to support without opening the picker');
  });

  test('internal Go error strings never reach a customer', () {
    final src = code(
        'lib/src/features/kyc/data/services/prove_kyc_http_service.dart');
    for (final c in const [
      'PROVE_INITIATE_FAILED',
      'PROVE_COMPLETE_FAILED',
      'NOT_CONFIGURED',
    ]) {
      expect(src.contains(c), isTrue,
          reason: '$c carries err.Error() verbatim — a raw Go string beside a '
              'Try Again button tells the customer nothing');
    }
  });
}
