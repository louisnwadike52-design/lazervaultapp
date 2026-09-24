import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The account state must be a badge beside the balance, not a banner.
///
/// WHAT IT WAS
/// -----------
/// A full-width, notification-shaped strip at the top of the Overview tab
/// reading "Account Active". Three problems: it looked like something that
/// needed acting on when it was pure status, it consumed a whole row of a screen
/// whose hero card was already tall, and it appeared on ONE tab — so on Members
/// or Activity there was no way to tell a frozen account from a live one, even
/// though a frozen account's balance means something entirely different.
///
/// It is now a compact badge on the hero card, next to the figure it qualifies.
final _src = File(
  'lib/src/features/family_account/presentation/views/family_account_detail_screen.dart',
).readAsStringSync();

String get _code => _src
    .split('\n')
    .where((l) => !l.trimLeft().startsWith('//'))
    .join('\n');

void main() {
  test('every account state has a presentation, exhaustively', () {
    // No `default:` — adding a state to the enum must be a compile error here,
    // not a badge that silently renders as some other state.
    expect(_code,
        contains('(Color, IconData, String) _accountStatePresentation('));
    for (final s in [
      'FamilyAccountStatus.active',
      'FamilyAccountStatus.frozen',
      'FamilyAccountStatus.pendingSetup',
      'FamilyAccountStatus.closed',
    ]) {
      expect(_code, contains('case $s:'), reason: '$s needs its own case');
    }
    expect(
      RegExp(r'_accountStatePresentation\(FamilyAccountStatus s\) \{[\s\S]{0,600}?default:')
          .hasMatch(_code),
      isFalse,
      reason: 'a default clause would absorb a newly added state',
    );
  });

  test('the badge sits beside the balance on the hero card', () {
    expect(_code, contains('_buildAccountStateBadge(account.status)'));
    // Anchored to the amount: the badge must be in the same Row as the figure,
    // which is what makes it qualify that number rather than float loose.
    final heroIdx = _code.indexOf("spendable.toStringAsFixed(2)");
    final badgeIdx = _code.indexOf('_buildAccountStateBadge(account.status)');
    expect(heroIdx, isNot(-1));
    expect(badgeIdx, greaterThan(heroIdx));
    expect(badgeIdx - heroIdx, lessThan(900),
        reason: 'the badge drifted away from the amount it qualifies');
  });

  test('the full-width status banner is gone', () {
    // The old strings only existed in the banner.
    expect(_code.contains("'Account Active'"), isFalse);
    expect(_code.contains("'Account Frozen'"), isFalse);
    expect(_code.contains("'Account Closed'"), isFalse);
  });

  test('the amount scales instead of overflowing beside the badge', () {
    // A large balance plus a badge on one line is the overflow case; FittedBox
    // shrinks the figure rather than throwing a layout error.
    final row = _code.substring(
      _code.indexOf("spendable.toStringAsFixed(2)") - 700,
      _code.indexOf("spendable.toStringAsFixed(2)") + 100,
    );
    expect(row, contains('FittedBox'));
  });
}
