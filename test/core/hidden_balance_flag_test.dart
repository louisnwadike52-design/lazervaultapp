import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/core/config/feature_flags.dart';

/// Per-account balance visibility on the dashboard cards.
///
/// The interesting cases are all about WHOSE setting it is and what happens
/// when the store cannot answer, because both failure directions are visible
/// to the user: leaking a balance they hid, or blanking every card so it looks
/// like the balances were lost.
void main() {
  const alice = 'user-alice';
  const bob = 'user-bob';
  const acctA = 'acct-1';
  const acctB = 'acct-2';

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    // NOT init(): it is `_prefs ??=`, so it keeps the binding from the previous
    // test while setMockInitialValues has swapped the store underneath. Reads
    // then answer from a store nothing is writing to. debugResetForTest exists
    // for exactly this and rebinds.
    await FeatureFlags.debugResetForTest();
  });

  test('balances are visible by default', () {
    expect(FeatureFlags.hiddenBalanceAccounts(alice), isEmpty);
    expect(FeatureFlags.isBalanceHidden(alice, acctA), isFalse);
  });

  test('toggling hides, and toggling again reveals', () async {
    expect(await FeatureFlags.toggleBalanceHidden(alice, acctA), isTrue);
    expect(FeatureFlags.isBalanceHidden(alice, acctA), isTrue);

    expect(await FeatureFlags.toggleBalanceHidden(alice, acctA), isFalse);
    expect(FeatureFlags.isBalanceHidden(alice, acctA), isFalse);
  });

  test('hiding one account leaves the others alone', () async {
    await FeatureFlags.toggleBalanceHidden(alice, acctA);
    expect(FeatureFlags.isBalanceHidden(alice, acctA), isTrue);
    expect(FeatureFlags.isBalanceHidden(alice, acctB), isFalse);
  });

  // The user-switch gap. Two people share a device; whoever signs in second
  // must not inherit the first one's hidden cards, and must not write their
  // own toggles under the first one's key.
  test('settings do not leak between users', () async {
    await FeatureFlags.toggleBalanceHidden(alice, acctA);

    expect(FeatureFlags.isBalanceHidden(bob, acctA), isFalse,
        reason: "bob inherited alice's hidden account");

    await FeatureFlags.toggleBalanceHidden(bob, acctB);
    expect(FeatureFlags.hiddenBalanceAccounts(alice), {acctA});
    expect(FeatureFlags.hiddenBalanceAccounts(bob), {acctB});
  });

  test('the choice is written to the backing store, not just memory', () async {
    await FeatureFlags.toggleBalanceHidden(alice, acctA);
    // Read the raw key the way a cold start would, rather than re-binding
    // (debugResetForTest clears, so it cannot stand in for a restart).
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getStringList(FeatureFlags.hiddenBalanceAccountsKey(alice)),
        contains(acctA));
  });

  test('several hidden accounts all persist', () async {
    await FeatureFlags.toggleBalanceHidden(alice, acctA);
    await FeatureFlags.toggleBalanceHidden(alice, acctB);
    expect(FeatureFlags.hiddenBalanceAccounts(alice), {acctA, acctB});

    await FeatureFlags.toggleBalanceHidden(alice, acctA);
    expect(FeatureFlags.hiddenBalanceAccounts(alice), {acctB});
  });

  test('an empty uid never reads another user\'s settings', () async {
    await FeatureFlags.toggleBalanceHidden(alice, acctA);
    // Signed out / not yet resolved: show nothing as hidden rather than
    // borrowing whatever the last user chose.
    expect(FeatureFlags.isBalanceHidden('', acctA), isFalse);
  });
}
