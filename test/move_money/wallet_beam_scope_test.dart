import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';
import 'package:lazervault/src/features/move_money/utils/wallet_beam_scope.dart';

PaymentsTransferResult _tx(String? destAccount) => PaymentsTransferResult(
      success: true,
      amount: 1000,
      counterpartyAccount: destAccount,
    );

void main() {
  const own = {'0279098300', '1234567890'};

  group('WalletBeamScope', () {
    test('keeps moves to the user\'s own wallets', () {
      final out = WalletBeamScope.filter(
        [_tx('0279098300'), _tx('1234567890')],
        own,
      );
      expect(out.length, 2);
    });

    test('drops money sent to other people', () {
      // The actual reported defect: the Beam tab listed every payment from the
      // account, so transfers to third parties appeared under Beam branding.
      final out = WalletBeamScope.filter(
        [_tx('0279098300'), _tx('9999999999'), _tx('0000000001')],
        own,
      );
      expect(out.length, 1);
      expect(out.single.counterpartyAccount, '0279098300');
    });

    test('matches regardless of formatting', () {
      // The same account arrives formatted differently depending on the
      // writer; a string mismatch would silently empty the tab, which is
      // indistinguishable from "no transfers yet".
      final out = WalletBeamScope.filter([_tx('027 909 8300')], own);
      expect(out.length, 1);
    });

    test('an unknown account set leaves the list UNSCOPED, not empty', () {
      // Showing slightly too much beats a confident, wrong "no transfers yet".
      final all = [_tx('0279098300'), _tx('9999999999')];
      expect(WalletBeamScope.filter(all, const {}).length, 2);
      expect(WalletBeamScope.filter(all, const {'', '   '}).length, 2);
    });

    test('rows with no destination account are excluded when scoping', () {
      final out = WalletBeamScope.filter([_tx(null), _tx('')], own);
      expect(out, isEmpty);
    });
  });
}
