import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// "UPDATE YOUR INFORMATION" HAS TO REACH EVERYTHING A CHECK COMPARES.
///
/// A registry verification compares the NAME, the DATE OF BIRTH and — once an
/// SMS provider is active — the PHONE NUMBER. Editors for all three exist, and
/// the failure path already routes to them: `openKycProfileFix` classifies a
/// refusal and opens the editor for the field it named.
///
/// But that path only opens AFTER a verification has failed, with wording
/// specific to that field. Someone who opens "Update your information"
/// because they already know their date of birth is wrong found names only —
/// and had to spend a billed verification, and get exactly the right error
/// message back, to be shown an editor that was there the whole time.
///
/// These assert the screen links to the editors rather than reimplementing
/// them. Two implementations of "change a phone number" would be two places
/// for the OTP rule to drift.
void main() {
  final src = File(
    'lib/src/features/kyc/presentation/views/kyc_update_details_screen.dart',
  ).readAsStringSync();

  test('the date-of-birth editor is reachable', () {
    expect(src.contains('openKycDateOfBirthFix()'), isTrue,
        reason: 'the screen must open the existing DOB editor, not grow its '
            'own date field — that editor has its own confirm-and-save step');
  });

  test('the phone editor is reachable', () {
    expect(src.contains('ChangePhoneScreen()'), isTrue,
        reason: 'the screen must open the existing phone editor; a phone '
            'cannot be a plain text field here because changing it re-runs an '
            'OTP against the new handset');
  });

  /// With no SMS provider the OTP cannot be delivered, so the change can never
  /// complete. The row stays visible and says why, rather than vanishing —
  /// someone whose number is genuinely wrong should not be left hunting for an
  /// option that is switched off.
  test('the phone row is gated on SMS being deliverable, and explains itself',
      () {
    expect(src.contains('SmsPolicy.canChangePhoneNumber'), isTrue,
        reason: 'the phone row must be gated on SMS availability');
    expect(src.contains('SmsPolicy.unavailableReason'), isTrue,
        reason: 'and must show the reason when it is unavailable');
  });

  /// A change in either editor closes this screen with `true`, which is the
  /// caller's cue to re-run verification — the same contract the name save
  /// already uses. Without it the customer fixes the thing that was wrong and
  /// is left on a screen with no indication that retrying would now work.
  test('a change in either editor closes the screen with true', () {
    final closes = RegExp(r'changed == true && mounted\) Get\.back\(result: true\)')
        .allMatches(src)
        .length;
    expect(closes, greaterThanOrEqualTo(2),
        reason: 'both the DOB and the phone editor must report a real change '
            'back to the caller so verification is re-run');
  });
}
