import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/bvn_lookup_consent_sheet.dart';

void main() {
  group('BvnConsentOutcome', () {
    test('every refusal the sheet cannot fix has its OWN outcome', () {
      // These were briefly collapsed together, which would have shown a
      // customer whose DATE OF BIRTH disagreed a dialog telling them their
      // BVN was "already in use" — a wrong explanation and the wrong remedy.
      final distinct = {
        BvnConsentOutcome.nameMismatch,
        BvnConsentOutcome.dobMismatch,
        BvnConsentOutcome.dobExhausted,
        BvnConsentOutcome.alreadyRegistered,
        BvnConsentOutcome.undeliverable,
        BvnConsentOutcome.sessionExpired,
        BvnConsentOutcome.unavailable,
      };
      expect(distinct.length, 7, reason: 'outcomes must not collapse');
    });

    test('name and date-of-birth refusals are NOT the same outcome', () {
      // Both are now fixable in-app, but by different editors: a name goes to
      // the profile editor, a date of birth to the correction dialog that
      // resumes the HELD session without a second code. Routing them the same
      // way sends one of the two to the wrong screen.
      expect(BvnConsentOutcome.nameMismatch,
          isNot(equals(BvnConsentOutcome.dobMismatch)));
    });

    test('a spent date-of-birth refusal is distinct from a retryable one', () {
      // The server drops the held session once the corrections are gone and
      // says so with IDENTITY_DOB_EXHAUSTED. If the app collapsed that into
      // dobMismatch it would reopen the date picker on a session that no
      // longer exists — a loop that cannot succeed, which a customer reads as
      // the app being broken rather than as being out of tries.
      expect(BvnConsentOutcome.dobExhausted,
          isNot(equals(BvnConsentOutcome.dobMismatch)));
    });

    test('verified and dismissed exist, so every exit is accounted for', () {
      expect(BvnConsentOutcome.values, contains(BvnConsentOutcome.verified));
      expect(BvnConsentOutcome.values, contains(BvnConsentOutcome.dismissed));
      // 10 total: the screen switches exhaustively over them, so adding one
      // without handling it is a compile error rather than a silent no-op.
      // (flutter analyze does NOT catch a non-exhaustive switch — only the
      // compiler does, which is why this count is pinned here as well.)
      //
      // 9 → 10 when `storeRetry` was added: IDENTITY_STORE_RETRY is the
      // registry answering correctly and our own write failing afterwards.
      // It is NOT a refusal and must not be worded as one — the customer's
      // identity checked out and the only honest action is "try again".
      expect(BvnConsentOutcome.values.length, 10);
    });
  });
}
