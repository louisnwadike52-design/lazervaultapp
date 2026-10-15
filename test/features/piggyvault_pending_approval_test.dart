import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/lock_funds/domain/entities/lock_fund_entity.dart';

/// A Piggyvault plan awaiting approval must never read as live.
///
/// Its deposit is RESERVED — the owner's available balance has already
/// dropped — but the term has not started and it earns nothing. The danger is
/// specific: `_convertProtoLockStatus` ends in `default: return
/// LockStatus.active`, so any status the client does not know about renders
/// as "Active · Your funds are locked and earning interest". Telling somebody
/// their money is earning while a decision is still pending is a plain
/// untruth about their money.
void main() {
  group('the status exists and is distinct', () {
    test('it is not active, and not terminal either', () {
      const s = LockStatus.pendingApproval;
      expect(s.isEarning, isFalse,
          reason: 'nothing accrues until the plan is approved');
      expect(s.isTerminal, isFalse,
          reason: 'it is not finished — a decision is still coming');
      expect(s.awaitingDecision, isTrue);
    });

    test('every other status is settled about whether it earns', () {
      expect(LockStatus.active.isEarning, isTrue);
      expect(LockStatus.matured.isEarning, isFalse,
          reason: 'the term is over; what remains is a payout, not accrual');
      expect(LockStatus.unlocked.isEarning, isFalse);
      expect(LockStatus.cancelled.isEarning, isFalse);
      for (final s in [
        LockStatus.active,
        LockStatus.matured,
        LockStatus.unlocked,
        LockStatus.cancelled,
      ]) {
        expect(s.awaitingDecision, isFalse, reason: '$s is decided');
      }
    });

    test('the copy says the money is set aside, not that it is earning', () {
      final d = LockStatus.pendingApproval.description.toLowerCase();
      expect(d, contains('review'));
      expect(d, isNot(contains('earning interest')),
          reason: 'it is not earning yet, and saying so is the whole bug');
      expect(LockStatus.pendingApproval.displayName, 'Awaiting approval');
    });
  });

  group('the wire mapping is explicit', () {
    String code(String p) => File(p)
        .readAsStringSync()
        .split('\n')
        .where((l) =>
            !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
        .join('\n');

    const model =
        'lib/src/features/lock_funds/data/models/lock_fund_model.dart';

    test('pending_approval is mapped, NOT left to the default', () {
      final s = code(model);
      expect(s, contains('case pb.LockStatus.LOCK_STATUS_PENDING_APPROVAL:'),
          reason: 'the default arm returns LockStatus.active, so an unmapped '
              'pending plan would render as earning interest');
      expect(s, contains('return LockStatus.pendingApproval;'));
    });

    test('it round-trips back to the proto', () {
      final s = code(model);
      expect(s, contains('return pb.LockStatus.LOCK_STATUS_PENDING_APPROVAL;'));
    });
  });

  group('a plan under review offers no actions', () {
    String code(String p) => File(p)
        .readAsStringSync()
        .split('\n')
        .where((l) =>
            !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
        .join('\n');

    const details =
        'lib/src/features/lock_funds/presentation/screens/lock_fund_details_screen.dart';

    test('withdraw is withheld', () {
      // A FLEX plan awaiting approval is the trap: it satisfies `isFlex`, so
      // without this it would offer Withdraw on money the server has
      // reserved against a decision nobody has made — and CanUnlock excludes
      // pending_approval, so the button would exist only to fail.
      final s = code(details);
      expect(s, contains('!lock.status.awaitingDecision'),
          reason: 'canWithdraw must exclude a plan under review');
      expect(s, contains('if (lock.status.awaitingDecision) return receipt;'),
          reason: 'the footer should collapse to the receipt, as it does for '
              'a terminal plan');
    });

    test('the badge is not the live colour', () {
      for (final p in [
        details,
        'lib/src/features/lock_funds/presentation/screens/lock_funds_list_screen.dart',
      ]) {
        final s = code(p);
        final i = s.indexOf('case LockStatus.pendingApproval:');
        expect(i, greaterThan(-1), reason: '$p does not render the status');
        final window = s.substring(i, (i + 160).clamp(0, s.length));
        expect(window, isNot(contains('0xFF6366F1')),
            reason: 'giving it the ACTIVE indigo says the plan is live');
      }
    });
  });
}
