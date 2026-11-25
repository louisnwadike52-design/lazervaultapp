import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE DATE-OF-BIRTH CORRECTION CHAIN, END TO END.
///
/// A customer whose BVN is right but whose stored date of birth is wrong is on
/// the LAST screen of onboarding. The recovery is four links long and every
/// one of them has to hold:
///
///   1. the mismatch offers the editor        (_offerDobEdit)
///   2. the editor saves the new date         (updateUserProfile)
///   3. the SESSION copy learns it            (applyCorrectedDateOfBirth)
///   4. the retry reads the session copy      (_profile -> currentProfile)
///
/// Link 3 is the one that was missing, and the failure was invisible: the save
/// succeeded, the screen said so, and the retry re-sent the OLD date — so the
/// customer got the identical refusal from the one action that was supposed to
/// fix it. Worse, the backend reuses an in-flight Prove session when the
/// identity is UNCHANGED, so the stale date matched the previous session and
/// reused it: no new session, no cooldown notice, no explanation.
///
/// Link 4 is the one that could break NEXT, and it is subtle:
/// applyCorrectedDateOfBirth writes the cubit's FIELD without emitting, which
/// is correct only while the screen reads that field. A refactor to read the
/// emitted state instead would compile, pass every existing test, and silently
/// restore the dead end.
void main() {
  String read(String path) => File(path).readAsStringSync();

  const bvnScreen =
      'lib/src/features/kyc/presentation/views/bvn_signup_screen.dart';
  const editor = 'lib/src/features/kyc/presentation/widgets/kyc_profile_fix.dart';
  const cubit =
      'lib/src/features/authentication/cubit/authentication_cubit.dart';

  test('link 1: a date-of-birth mismatch opens the editor, not a support ticket',
      () {
    final src = read(bvnScreen);
    expect(src.contains('openKycProfileFix'), isTrue,
        reason: 'the refusal must carry the fix; "Try Again" against an '
            'unchanged profile reproduces the identical refusal');
    expect(src.contains('KycProfileField.dateOfBirth'), isTrue);
  });

  test('link 2 and 3: the editor saves, then teaches the session copy', () {
    final src = read(editor);
    final save = src.indexOf('updateUserProfile(dateOfBirth:');
    final tell = src.indexOf('applyCorrectedDateOfBirth');
    expect(save, greaterThan(-1), reason: 'the editor no longer writes the date');
    expect(tell, greaterThan(-1),
        reason: 'the session copy is what the retry and Mono read the date '
            'from; leaving it stale re-sends the OLD date');
    expect(tell, greaterThan(save),
        reason: 'the session copy must be updated AFTER the server confirms, '
            'or a refused save would still leave the app believing the new date');
  });

  test('link 3: the cubit writes the field the screens read', () {
    final src = read(cubit);
    final i = src.indexOf('void applyCorrectedDateOfBirth');
    expect(i, greaterThan(-1));
    final body = src.substring(i, i + 500);
    expect(body.contains('_currentProfile ='), isTrue,
        reason: 'it must write the field; emitting alone would not reach '
            '_profile(), which reads currentProfile directly');
    expect(body.contains('copyWith(dateOfBirth:'), isTrue);
  });

  test('link 4: the retry reads the session copy, not the emitted state', () {
    final src = read(bvnScreen);
    expect(
      src.contains('context.read<AuthenticationCubit>().currentProfile'),
      isTrue,
      reason: 'applyCorrectedDateOfBirth updates the FIELD without emitting. '
          'A screen reading the emitted state would never see the correction, '
          'and the retry would re-send the old date — silently, exactly as '
          'before the fix.',
    );
  });

  test('the chain closes: a successful edit retries verification', () {
    final src = read(bvnScreen);
    final i = src.indexOf('Future<void> _offerDobEdit');
    expect(i, greaterThan(-1));
    final body = src.substring(i, i + 1200);
    expect(body.contains('if (changed)'), isTrue,
        reason: 'the retry must be conditional on the edit having succeeded — '
            'retrying after a refused save spends a billed lookup on an '
            'unchanged profile');
    expect(body.contains('_submit()'), isTrue,
        reason: 'a saved correction that does not retry leaves the customer on '
            'the failing screen having done everything right');
  });

  test('a verified identity is still beyond the holder, and says so', () {
    final src = read(editor);
    expect(src.contains('_dobLockedByVerification'), isTrue,
        reason: 'once matched against the registry the date is not the '
            "holder's to edit; the server enforces this and the app must not "
            'offer an edit that will be refused');
    expect(src.contains('_openDobSupportTicket'), isTrue,
        reason: 'a locked date needs a human, and the ticket must describe the '
            'right problem');
  });
}
