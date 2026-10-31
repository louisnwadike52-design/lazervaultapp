import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/funds/domain/min_balance_policy.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/min_balance_sheet.dart';

/// THE CLIENT AND SERVER MUST AGREE ON WHEN A TRANSFER IS REFUSED.
///
/// The expectations here are the SAME ones locked by the Go tests in
/// microservices/core-payments-service/.../internal/service/transfer_min_balance_test.go.
/// If one side's arithmetic moves, these diverge and one of the two suites fails
/// — which is the point, because a client that refuses where the server allows
/// (or allows where the server refuses) is worse than having no client check.
///
/// `resolve()` reads SharedPreferences and is exercised end-to-end rather than
/// here; these cover the arithmetic and the copy, which is where a mismatch
/// would actually hurt.
void main() {
  const floor = 150000; // ₦1,500 in kobo
  const enforced = MinBalancePolicy(enforced: true, minimumMinor: floor);
  const off = MinBalancePolicy(enforced: false);

  group('blocks', () {
    test('leaving exactly the floor is allowed', () {
      // ₦2,500 − ₦1,000 = ₦1,500, exactly the minimum. The boundary is
      // inclusive on both sides, matching the server.
      expect(
        enforced.blocks(availableMinor: 250000, spendMinor: 100000),
        isFalse,
      );
    });

    test('one kobo under the floor is refused', () {
      expect(
        enforced.blocks(availableMinor: 250000, spendMinor: 100001),
        isTrue,
      );
    });

    test('a wallet already below the floor cannot transfer out', () {
      expect(enforced.blocks(availableMinor: 100000, spendMinor: 1000), isTrue);
    });

    test('an unconfigured policy never blocks', () {
      // The default-off case. If this ever returns true, shipping the app would
      // block transfers for every user with no setting written.
      expect(off.blocks(availableMinor: 100, spendMinor: 100), isFalse);
    });

    test('an unknown balance never blocks', () {
      // The client must not refuse on data it does not have; the server fails
      // open for the same reason.
      expect(enforced.blocks(availableMinor: 0, spendMinor: 100000), isFalse);
      expect(enforced.blocks(availableMinor: 250000, spendMinor: 0), isFalse);
    });

    test('a policy with no amount never blocks', () {
      const halfSet = MinBalancePolicy(enforced: true, minimumMinor: 0);
      expect(
          halfSet.blocks(availableMinor: 250000, spendMinor: 100000), isFalse);
    });
  });

  group('maxSendableMinor', () {
    test('subtracts both the floor and the fee', () {
      // ₦2,500 − ₦1,500 floor − ₦25 fee = ₦975. Same figure as the Go test.
      expect(
        enforced.maxSendableMinor(availableMinor: 250000, feeMinor: 2500),
        97500,
      );
    });

    test('clamps to zero rather than going negative', () {
      // A negative headroom rendered as an amount would read as a bug.
      expect(
          enforced.maxSendableMinor(availableMinor: 150000, feeMinor: 2500), 0);
      expect(enforced.maxSendableMinor(availableMinor: 50000), 0);
    });

    test('returns the whole balance when not enforced', () {
      // So a caller can use it unconditionally.
      expect(off.maxSendableMinor(availableMinor: 250000), 250000);
    });
  });

  group('the refusal copy', () {
    test('names the floor and what can still be sent', () {
      final msg = minBalanceMessage(
        currencySymbol: '₦',
        minimumMinor: floor,
        maxSendableMinor: 97500,
      );
      // "1,500" not "1,500.00" — the format the server uses, pinned here so
      // the app's dialog and the server's snackbar cannot drift apart again.
      expect(msg, contains('1,500'));
      expect(msg, contains('975'));
      expect(msg, isNot(contains('1,500.00')));
    });

    test('says what the retained balance is still for', () {
      // Without this the refusal reads as the money being frozen, which is the
      // opposite of true and the complaint it would otherwise generate.
      final msg = minBalanceMessage(
        currencySymbol: '₦',
        minimumMinor: floor,
        maxSendableMinor: 97500,
      );
      for (final service in ['airtime', 'data', 'gift cards', 'crypto']) {
        expect(msg.toLowerCase(), contains(service));
      }
    });

    test('offers nothing when nothing can be sent', () {
      // "You can transfer up to ₦0.00" reads as a bug, so the zero case gets
      // its own sentence.
      final msg = minBalanceMessage(
        currencySymbol: '₦',
        minimumMinor: floor,
        maxSendableMinor: 0,
      );
      expect(msg, isNot(contains('up to')));
      expect(msg, contains('1,500'));
      // Still tells them the balance is usable.
      expect(msg.toLowerCase(), contains('airtime'));
    });

    test('admin copy replaces the whole sentence', () {
      // So no user-facing policy text is hardcoded.
      const custom = 'Keep ₦1,500 to keep using Lazervault services.';
      expect(
        minBalanceMessage(
          currencySymbol: '₦',
          minimumMinor: floor,
          maxSendableMinor: 97500,
          adminMessage: custom,
        ),
        custom,
      );
    });

    test('blank admin copy falls back rather than showing nothing', () {
      // `upsertSystemSetting(key, "")` is how a cleared field saves, so blank
      // must mean "use the default", not "show an empty dialog".
      final msg = minBalanceMessage(
        currencySymbol: '₦',
        minimumMinor: floor,
        maxSendableMinor: 97500,
        adminMessage: '   ',
      );
      expect(msg, contains('1,500'));
    });

    test('uses the wallet currency symbol it is given', () {
      // A bare number is not a balance; a USD wallet must not be labelled in naira.
      final msg = minBalanceMessage(
        currencySymbol: r'$',
        minimumMinor: floor,
        maxSendableMinor: 97500,
      );
      expect(msg, contains(r'$1,500'));
      expect(msg, isNot(contains('₦')));
    });

    test('names the action, so a withdrawal is not called a transfer', () {
      // withdraw_funds_screen.dart shows this same sheet. Before the action
      // existed it told the user "this transfer can't go through" while they
      // were withdrawing — and banking-service's own refusal said
      // "withdrawal", so the two surfaces disagreed about what was refused.
      final send = minBalanceMessage(
        currencySymbol: '₦',
        minimumMinor: floor,
        maxSendableMinor: 97500,
      );
      expect(send, contains('transfer up to'),
          reason: 'the default must stay a transfer for the send flows');

      final draw = minBalanceMessage(
        currencySymbol: '₦',
        minimumMinor: floor,
        maxSendableMinor: 47500,
        action: MinBalanceAction.withdrawal,
      );
      expect(draw, contains('withdraw up to'));
      expect(draw, isNot(contains('transfer')));

      final drawAtFloor = minBalanceMessage(
        currencySymbol: '₦',
        minimumMinor: floor,
        maxSendableMinor: 0,
        action: MinBalanceAction.withdrawal,
      );
      expect(drawAtFloor, contains("withdrawal can't go through"));
    });
  });

  group('the money format matches the server', () {
    // formatMinorForCopy mirrors FormatMinor in microservices/shared/minbalance.
    // These are the SAME cases that package's Go test pins, so a change on
    // either side fails on both. The app's dialog and the server's fallback
    // snackbar are the same refusal reached two ways; they must read alike.
    test('renders amounts the way people write them', () {
      const cases = <int, String>{
        150000: '1,500',
        100: '1',
        150050: '1,500.50',
        150005: '1,500.05',
        100000000: '1,000,000',
        0: '0',
        99: '0.99',
        -150000: '-1,500',
      };
      cases.forEach((minor, want) {
        expect(formatMinorForCopy(minor), want,
            reason: 'formatMinorForCopy($minor)');
      });
    });
  });
}
