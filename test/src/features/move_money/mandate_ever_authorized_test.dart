import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/move_money/domain/entities/mandate_entity.dart';

// Reported live by a user part-way through Direct Debit setup on ALAT by WEMA:
// the deposit card still showed the "One-time" chip, yet the sheet offered
// "Re-authorize Direct Debit" for a "saved Direct Debit" — which reads as
// "you are already set up" to someone who has never finished setting up.
//
// Measured against production on 2026-10-02: ALL 14 mandates ever created had
// authorized_at NULL, ready_to_debit_at NULL and debit_count 0. Not one Direct
// Debit has ever been authorized, so the terminal statuses these surfaces keyed
// off were reached ONLY by abandoned setups — making "re-authorize" wrong for
// every user who has ever seen it.

MandateEntity mandate({
  required MandateStatus status,
  DateTime? authorizedAt,
  DateTime? readyAt,
  DateTime? lastDebitAt,
  int debitCount = 0,
  int totalDebited = 0,
  bool isExpired = false,
}) =>
    MandateEntity(
      id: 'm-1',
      monoMandateId: 'mmc_test',
      userId: 'u-1',
      linkedAccountId: 'la-1',
      status: status,
      isExpired: isExpired,
      authorizedAt: authorizedAt,
      readyAt: readyAt,
      lastDebitAt: lastDebitAt,
      debitCount: debitCount,
      totalDebited: totalDebited,
      startDate: DateTime(2026, 1, 1),
      endDate: DateTime(2027, 1, 1),
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  group('everAuthorized', () {
    test('a mandate that never reached the bank is NOT ever-authorized', () {
      // The exact production shape: every column that would prove
      // authorization is empty.
      for (final status in [
        MandateStatus.cancelled,
        MandateStatus.expired,
        MandateStatus.rejected,
        MandateStatus.awaitingAuthorization,
        MandateStatus.pending,
      ]) {
        expect(mandate(status: status).everAuthorized, isFalse,
            reason: 'status $status with no evidence must not count');
      }
    });

    test('any single piece of evidence is enough', () {
      final at = DateTime(2026, 5, 1);
      expect(mandate(status: MandateStatus.expired, authorizedAt: at)
          .everAuthorized, isTrue);
      expect(
          mandate(status: MandateStatus.expired, readyAt: at).everAuthorized,
          isTrue);
      expect(
          mandate(status: MandateStatus.cancelled, lastDebitAt: at)
              .everAuthorized,
          isTrue);
      expect(mandate(status: MandateStatus.cancelled, debitCount: 1)
          .everAuthorized, isTrue);
      expect(mandate(status: MandateStatus.rejected, totalDebited: 500)
          .everAuthorized, isTrue);
    });

    test('a status unreachable without authorization counts on its own', () {
      // Belt and braces: if a timestamp column were ever missed in mapping,
      // the status still proves it.
      for (final status in [
        MandateStatus.authorized,
        MandateStatus.active,
        MandateStatus.readyToDebit,
        MandateStatus.paused,
      ]) {
        expect(mandate(status: status).everAuthorized, isTrue,
            reason: '$status cannot be reached without authorizing');
      }
    });
  });

  group('which prompt the user is shown', () {
    test('an abandoned setup asks the user to FINISH, not to re-authorize', () {
      for (final status in [
        MandateStatus.cancelled,
        MandateStatus.expired,
        MandateStatus.rejected,
      ]) {
        final m = mandate(status: status);
        expect(m.needsNewAuthorization, isTrue,
            reason: 'still needs a prompt');
        expect(m.setupNeverCompleted, isTrue);
        expect(m.needsReauthorization, isFalse,
            reason: 'nothing was ever authorized to re-authorize');
      }
    });

    test('a mandate that really did work says re-authorize', () {
      final m = mandate(
        status: MandateStatus.expired,
        authorizedAt: DateTime(2026, 2, 1),
        readyAt: DateTime(2026, 2, 2),
        debitCount: 7,
      );
      expect(m.needsNewAuthorization, isTrue);
      expect(m.needsReauthorization, isTrue);
      expect(m.setupNeverCompleted, isFalse);
    });

    test('the end-date expiry field is honoured as well as the status', () {
      // isExpired is a separate server-computed field; a mandate can be past
      // its end date while its status still says active.
      final m = mandate(status: MandateStatus.active, isExpired: true);
      expect(m.needsNewAuthorization, isTrue);
      expect(m.needsReauthorization, isTrue,
          reason: 'active is unreachable without authorizing');
    });

    test('the two prompts are mutually exclusive and cover the branch', () {
      for (final status in MandateStatus.values) {
        for (final authorized in [true, false]) {
          final m = mandate(
            status: status,
            authorizedAt: authorized ? DateTime(2026, 2, 1) : null,
          );
          expect(m.needsReauthorization && m.setupNeverCompleted, isFalse,
              reason: 'never both');
          expect(m.needsReauthorization || m.setupNeverCompleted,
              m.needsNewAuthorization,
              reason: 'exactly one whenever a prompt is due');
        }
      }
    });

    test('a healthy mandate is prompted for nothing', () {
      final m = mandate(
        status: MandateStatus.active,
        authorizedAt: DateTime(2026, 2, 1),
      );
      expect(m.needsNewAuthorization, isFalse);
      expect(m.needsReauthorization, isFalse);
      expect(m.setupNeverCompleted, isFalse);
    });
  });

  test('authorization evidence is part of equality, so the copy rebuilds', () {
    // These getters now choose user-visible wording; if they were not in
    // props, a mandate that just became authorized would keep rendering
    // "Finish setting up".
    final before = mandate(status: MandateStatus.expired);
    final after =
        mandate(status: MandateStatus.expired, authorizedAt: DateTime(2026, 2, 1));
    expect(before == after, isFalse);
  });
}
