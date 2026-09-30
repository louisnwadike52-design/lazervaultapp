import 'package:flutter_test/flutter_test.dart';

import 'package:lazervault/src/features/payroll/presentation/views/pay_run_funding_check.dart';

/// A pay run that outruns the balance must be caught BEFORE the PIN.
///
/// Praiz processed one and the screen came back "failed" — after the PIN,
/// after the commitment, with no figure saying how short the account was.
/// The arithmetic is trivial; where it happens is the whole point.
void main() {
  group('shortfall', () {
    test('null when the balance covers the run', () {
      expect(
        PayRunFundingCheck.shortfall(totalNet: 50000, availableBalance: 80000),
        isNull,
      );
    });

    test('exactly enough is funded, not short', () {
      // A payroll that spends the account to zero is legal. Calling it short
      // would block a run the server would have accepted.
      expect(
        PayRunFundingCheck.shortfall(totalNet: 80000, availableBalance: 80000),
        isNull,
      );
      expect(
        PayRunFundingCheck.isFunded(totalNet: 80000, availableBalance: 80000),
        isTrue,
      );
    });

    test('names the exact gap', () {
      expect(
        PayRunFundingCheck.shortfall(totalNet: 92400, availableBalance: 80000),
        12400.0,
      );
    });

    test('an empty account is short by the whole run', () {
      expect(
        PayRunFundingCheck.shortfall(totalNet: 1000, availableBalance: 0),
        1000.0,
      );
    });

    test('float drift does not invent a shortfall', () {
      // Payroll totals are sums of many net figures, so 117.27 + 10.75 style
      // drift is routine. Compared as doubles this run reads as short by a
      // fraction of a kobo and the payroll is blocked for a rounding
      // artefact.
      const total = 117.29 + 10.75; // 128.04000000000002, not 128.04
      expect(
        PayRunFundingCheck.shortfall(totalNet: total, availableBalance: 128.04),
        isNull,
        reason: 'the account holds exactly the total; the extra 2e-14 is '
            'binary rounding, not a debt',
      );
    });

    test('a real one-kobo gap is still a gap', () {
      final short = PayRunFundingCheck.shortfall(
        totalNet: 128.03,
        availableBalance: 128.02,
      );
      expect(short, isNotNull);
      expect(short!, closeTo(0.01, 1e-9));
    });
  });
}
