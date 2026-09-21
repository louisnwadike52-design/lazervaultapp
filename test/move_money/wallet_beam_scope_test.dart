import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';
import 'package:lazervault/src/features/move_money/utils/wallet_beam_scope.dart';

PaymentsTransferResult _tx(String? destAccount) => PaymentsTransferResult(
      success: true,
      amount: 1000,
      counterpartyAccount: destAccount,
    );

void main() {
  // The user's own accounts, as the screens now build them.
  final own = WalletBeamScope.identities(
    fullNumbers: const ['0279098300', '1234567890'],
    last4s: const ['8300', '7890'],
  );

  group('WalletBeamScope.identities', () {
    test('a NULL full number does not leave the set empty', () {
      // THE REGRESSION THIS EXISTS FOR.
      //
      // AccountSummaryEntity.accountNumber is the full NUBAN and is NULLABLE —
      // it is absent until a virtual account has been provisioned. The first
      // version of this filter keyed on it alone, so for those users the set
      // came back empty, and an empty set falls through to "return everything".
      // The Beam tab therefore still listed every payment from the account,
      // which is exactly the bug the filter was written to fix.
      final ids = WalletBeamScope.identities(
        fullNumbers: const [null, null],
        last4s: const ['7890', '4321'],
      );
      expect(ids.isEmpty, isFalse,
          reason: 'accountNumberLast4 is non-nullable and must carry the scope');
      expect(ids.full, isEmpty);
      expect(ids.last4, containsAll(<String>['7890', '4321']));
    });

    test('a full number also yields its own last four', () {
      final ids = WalletBeamScope.identities(
        fullNumbers: const ['0279098300'],
        last4s: const [],
      );
      expect(ids.full, contains('0279098300'));
      expect(ids.last4, contains('8300'));
    });

    test('formatting differences are normalised away', () {
      final ids = WalletBeamScope.identities(
        fullNumbers: const ['027 909 8300'],
        last4s: const [],
      );
      expect(ids.full, contains('0279098300'));
    });

    test('a four-digit "full" number is treated as a suffix, not an exact id',
        () {
      // Matching four digits exactly would claim a large share of all
      // counterparties as the user's own wallet.
      final ids = WalletBeamScope.identities(
        fullNumbers: const ['8300'],
        last4s: const [],
      );
      expect(ids.full, isEmpty);
    });
  });

  group('WalletBeamScope.filter', () {
    test("keeps moves to the user's own wallets", () {
      final out =
          WalletBeamScope.filter([_tx('0279098300'), _tx('1234567890')], own);
      expect(out.length, 2);
    });

    test('drops money sent to other people', () {
      // The reported defect: the Beam tab listed every payment from the
      // account, so transfers to third parties appeared under Beam branding.
      final out = WalletBeamScope.filter(
        [_tx('0279098300'), _tx('9999999999'), _tx('0000000001')],
        own,
      );
      expect(out.length, 1);
      expect(out.single.counterpartyAccount, '0279098300');
    });

    test('matches regardless of formatting', () {
      // A string mismatch would silently empty the tab, which is
      // indistinguishable from "no transfers yet".
      expect(WalletBeamScope.filter([_tx('027 909 8300')], own).length, 1);
    });

    test('rows with no destination account are excluded when scoping', () {
      expect(WalletBeamScope.filter([_tx(null), _tx('')], own), isEmpty);
    });

    test('suffix matching applies only when NO full number is known', () {
      final suffixOnly = WalletBeamScope.identities(
        fullNumbers: const [null],
        last4s: const ['8300'],
      );
      expect(
        WalletBeamScope.filter([_tx('0279098300')], suffixOnly).length,
        1,
        reason: 'with nothing better available, the suffix is the only signal',
      );

      // But once a full number IS known, a stranger whose last four happen to
      // collide must not be claimed as the user's own wallet.
      final withFull = WalletBeamScope.identities(
        fullNumbers: const ['0279098300'],
        last4s: const [],
      );
      expect(WalletBeamScope.filter([_tx('5555558300')], withFull), isEmpty);
    });

    test('a genuinely empty identity set leaves the list UNSCOPED', () {
      // Preserved deliberately: we cannot judge, and showing slightly too much
      // beats a confident, wrong "no transfers yet". The fix is that this path
      // is now unreachable in practice, not that it changed.
      final all = [_tx('0279098300'), _tx('9999999999')];
      expect(
        WalletBeamScope.filter(all, WalletBeamIdentities.empty).length,
        2,
      );
      expect(
        WalletBeamScope
            .filter(
              all,
              WalletBeamScope.identities(
                fullNumbers: const ['', '   '],
                last4s: const ['', 'abc'],
              ),
            )
            .length,
        2,
      );
    });
  });
}
