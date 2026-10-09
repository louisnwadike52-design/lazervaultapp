import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/active_account_snapshot.dart';

/// Reported: the Commit funds screen printed "Balance NGN 2491.91" and then
/// accepted ₦5,000 straight into the PIN sheet. The user authenticates, the
/// server refuses, and they have spent a PIN entry — on a shared device,
/// exposed it — to be told something the screen already knew.
///
/// `covers()` is the predicate the screen now gates on. These pin its
/// behaviour; the screen-level wiring (button disabled, reason shown beside
/// the field, re-checked in _confirm because the balance is a snapshot) is
/// the other half.
ActiveAccountSnapshot _acct({
  double balance = 2491.91,
  bool spendable = true,
  bool provisioning = false,
  String currency = 'NGN',
}) =>
    ActiveAccountSnapshot(
      id: 'a1',
      display: 'Personal •••• 8852',
      currency: currency,
      balanceMajor: balance,
      accountNumber: '0123458852',
      accountNumberLast4: '8852',
      isSpendable: spendable,
      isProvisioning: provisioning,
    );

void main() {
  group('covers', () {
    test('the reported case: 5000 against 2491.91', () {
      expect(_acct().covers(5000), false);
    });

    test('exactly the balance is allowed', () {
      // Refusing the full balance would make it impossible to empty a wallet
      // into a fund, which is a legitimate thing to want to do.
      expect(_acct(balance: 2491.91).covers(2491.91), true);
    });

    test('a penny over is not', () {
      expect(_acct(balance: 2491.91).covers(2491.92), false);
    });

    test('a comfortable amount passes', () {
      expect(_acct().covers(1000), true);
    });

    test('a provisioning account holds no money yet', () {
      // The balance can read as positive while the wallet is still being
      // created upstream; committing from it would fail server-side.
      expect(_acct(provisioning: true).covers(10), false);
    });

    test('a non-spendable account is refused whatever the balance', () {
      expect(_acct(balance: 1000000, spendable: false).covers(10), false);
    });
  });
}
