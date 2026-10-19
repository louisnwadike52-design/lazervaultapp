import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/friendly_error.dart';

/// A DATABASE ERROR WAS SHOWN TO THE PERSON CLOSING THEIR ACCOUNT.
///
/// Closing a Family & Friends account writes `status = 'archived'`, but the
/// check_status_valid constraint permitted only active / frozen / closed /
/// pending_setup, so accounts-service returned the Postgres error verbatim and
/// FamilyAccountCubit emitted `failure.message` straight into a red banner.
/// The creator was shown our table name, our constraint name and an SQLSTATE.
///
/// That one was caught only INCIDENTALLY, by the `error:` marker, because
/// Postgres prefixes "ERROR:". The driver's own shape does not — a bare
/// `pq: duplicate key value violates unique constraint` carries no "error:",
/// no "exception" and no JSON, and friendly_error.dart's own comments record
/// that exact string reaching a user in testing.
void main() {
  group('a Postgres error never reaches the user', () {
    test('the real family-close failure is replaced', () {
      // Verbatim from accounts-service, 2026-10-19.
      const raw =
          'failed to archive family account: ERROR: new row for relation '
          '"family_accounts" violates check constraint "check_status_valid" '
          '(SQLSTATE 23514)';
      final out = sanitizeUserFacingError(raw);
      expect(out, isNot(contains('check_status_valid')));
      expect(out, isNot(contains('family_accounts')));
      expect(out, isNot(contains('SQLSTATE')));
      expect(out, 'Something went wrong. Please try again.');
    });

    test('the bare driver shape is caught too, with no "ERROR:" to rely on',
        () {
      const raw =
          'pq: duplicate key value violates unique constraint "idx_accounts_ref"';
      expect(looksTechnical(raw), isTrue);
      expect(sanitizeUserFacingError(raw), isNot(contains('idx_accounts_ref')));
    });

    test('every DB vocabulary marker is caught', () {
      const leaks = [
        'SQLSTATE 23505',
        'pq: relation "family_members" does not exist',
        'new row for relation "accounts" violates check constraint "x"',
        'null value in column "status" violates not-null constraint',
        'update or delete on table violates foreign key constraint "fk_x"',
        'column "archived_at" of relation "family_accounts" does not exist',
      ];
      for (final raw in leaks) {
        expect(looksTechnical(raw), isTrue, reason: 'not caught: $raw');
      }
    });
  });

  group('the sanitizer does not eat real product messages', () {
    test('a business refusal passes through unchanged', () {
      // The close flow's own validations must still reach the user — being
      // told "Something went wrong" when the real reason is a wrong
      // confirmation code is worse than the leak.
      for (final msg in [
        'Confirmation code is incorrect',
        'Return the pool balance before closing this account',
        'Only the creator can close this account',
        'You have reached your limit of 3 family accounts',
      ]) {
        expect(sanitizeUserFacingError(msg), msg, reason: 'mangled: $msg');
      }
    });

    test('"violates" and "constraint" alone are not markers', () {
      // Deliberately not matched: a limits message may legitimately use them,
      // and over-matching would hide a real reason behind a generic line.
      const msg = 'This transfer violates your daily limit';
      expect(looksTechnical(msg), isFalse);
      expect(sanitizeUserFacingError(msg), msg);
    });
  });
}
