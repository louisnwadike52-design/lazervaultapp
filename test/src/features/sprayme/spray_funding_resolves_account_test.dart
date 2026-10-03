import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/active_account_snapshot.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';

// Reported repeatedly: Lazerspray's "Fund wallet" sheet showed
// "From account: No account selected" and could not be funded — while the
// spray balance above it rendered NGN 100 perfectly well.
//
// The two come from different places. The balance is the sprayme repository's
// own call. The source account came from activeAccountSnapshot(), which reads
// AccountCardsSummaryCubit SYNCHRONOUSLY and answers null whenever that cubit
// has not loaded. Nothing in the whole sprayme feature ever loaded it — the
// dashboard does, so the sheet worked if you had been there first and never
// worked if you went straight to Lazerspray. Reading once in initState made
// that permanent: summaries arriving a moment later changed nothing.

AccountSummaryEntity account({
  String id = 'acc-1',
  String type = 'personal',
  String last4 = '3589',
  double balance = 5000,
  double available = 4500,
  String status = 'active',
  bool family = false,
  String? virtualAccountId,
}) =>
    AccountSummaryEntity(
      id: id,
      accountType: type,
      currency: 'NGN',
      balance: balance,
      availableBalance: available,
      accountNumberLast4: last4,
      trendPercentage: 0,
      status: status,
      isFamilyAccount: family,
      virtualAccountId: virtualAccountId,
    );

void main() {
  test('the snapshot carries the id the funding debit actually needs', () {
    final snap = snapshotOf(account());
    expect(snap.id, 'acc-1');
    expect(snap.currency, 'NGN');
    expect(snap.balanceMajor, 4500,
        reason: 'available, not balance — reserved money cannot be sprayed');
    expect(snap.isSpendable, isTrue);
    expect(snap.display, isNotEmpty,
        reason: 'an empty display is what rendered as "No account selected"');
  });

  test('a family wallet spends from its virtual account, not the group id', () {
    final snap = snapshotOf(
        account(id: 'grp-1', family: true, virtualAccountId: 'va-9'));
    expect(snap.id, 'va-9');
    expect(snap.isProvisioning, isFalse);
  });

  test('an unprovisioned family wallet is flagged, not silently spendable', () {
    final snap = snapshotOf(account(id: 'grp-2', family: true));
    expect(snap.isProvisioning, isTrue,
        reason: 'a debit here fails server-side; the sheet must block first');
    expect(snap.covers(1), isFalse);
  });

  test('the display is never empty even with no account number', () {
    expect(snapshotOf(account(last4: '')).display.trim(), isNotEmpty,
        reason: 'the label alone must show, or the row reads as "no account"');
  });

  test('a frozen account still resolves but cannot be spent', () {
    final snap = snapshotOf(account(status: 'frozen'));
    expect(snap.display, isNotEmpty,
        reason: '"no account selected" would be a lie — it exists');
    expect(snap.isSpendable, isFalse);
    expect(snap.covers(1), isFalse);
  });

  test('covers() stops at the available balance, not the headline one', () {
    final snap = snapshotOf(account(balance: 10000, available: 100));
    expect(snap.covers(100), isTrue);
    expect(snap.covers(101), isFalse);
  });
}
