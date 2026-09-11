import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/move_money/domain/entities/mandate_entity.dart';

// Reported live: a Direct Debit setup for ALAT by WEMA was created at 14:58 and
// resumed at 15:29. Mono had served its NIBSS activation screen — "transfer
// NGN 50 to Parallex Bank, expires in 29:52" — so by the time the user came
// back the link was dead. Reopening it answered "This link is incorrect or the
// transaction is already completed", which reads as the user's mistake and
// left them with no way forward.
//
// Mono returns no expiry on create, so staleness is measured from the only
// thing we hold: when the mandate was made.

MandateEntity mandate({
  required MandateStatus status,
  required Duration age,
  Duration? authAttemptedAgo,
}) =>
    MandateEntity(
      id: 'm-1',
      monoMandateId: 'mmc_test',
      userId: 'u-1',
      linkedAccountId: 'la-1',
      status: status,
      startDate: DateTime(2026, 1, 1),
      endDate: DateTime(2027, 1, 1),
      createdAt: DateTime.now().subtract(age),
      authAttemptedAt: authAttemptedAgo == null
          ? null
          : DateTime.now().subtract(authAttemptedAgo),
    );

void main() {
  test('a link older than the window is stale', () {
    final m = mandate(
      status: MandateStatus.awaitingAuthorization,
      age: const Duration(minutes: 31),
    );
    expect(m.authLinkStale, isTrue);
  });

  test('a fresh link is NOT stale', () {
    // Re-minting on every resume would burn a mandate each time and lose a
    // perfectly good link the user is still working through.
    final m = mandate(
      status: MandateStatus.awaitingAuthorization,
      age: const Duration(minutes: 2),
    );
    expect(m.authLinkStale, isFalse);
  });

  test('the window is held UNDER Mono\'s observed ~30 minutes', () {
    // Erring early costs one extra mandate; erring late dead-ends the user.
    expect(MandateEntity.authLinkWindow.inMinutes, lessThan(30));
  });

  test('an already-authorized mandate is never treated as stale', () {
    // That link is spent for a DIFFERENT reason — the bank is confirming it.
    // The right response is to poll, not to mint a second mandate and throw
    // away an authorization the user already completed.
    final m = mandate(
      status: MandateStatus.awaitingAuthorization,
      age: const Duration(minutes: 35),
      authAttemptedAgo: const Duration(minutes: 5),
    );
    expect(m.authAttemptedRecently, isTrue);
    expect(m.authLinkStale, isFalse);
  });

  terminalStates();

  test('a live mandate is never stale whatever its age', () {
    // Staleness is about an UNUSED authorization link, not about the mandate.
    for (final s in [MandateStatus.active, MandateStatus.paused]) {
      expect(
        mandate(status: s, age: const Duration(days: 30)).authLinkStale,
        isFalse,
        reason: '$s',
      );
    }
  });
}

// A poll that only stops on success runs forever on every other outcome. The
// abandonment path now starts a poll whenever the user leaves the bank sheet,
// so "forever" became "on a route users actually take" — a 60s timer against
// the backend for the rest of the session, for a mandate that is already dead.
void terminalStates() {
  test('rejected, cancelled and expired all read as terminal', () {
    for (final s in [
      MandateStatus.rejected,
      MandateStatus.cancelled,
      MandateStatus.expired,
    ]) {
      expect(
        mandate(status: s, age: const Duration(minutes: 5)).isTerminal,
        isTrue,
        reason: '$s must stop the poll',
      );
    }
  });

  test('states that can still progress are NOT terminal', () {
    for (final s in [
      MandateStatus.pending,
      MandateStatus.awaitingAuthorization,
      MandateStatus.active,
      MandateStatus.paused,
    ]) {
      expect(
        mandate(status: s, age: const Duration(minutes: 5)).isTerminal,
        isFalse,
        reason: '$s must keep polling',
      );
    }
  });
}
