import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/payroll/presentation/views/pay_run_funding_check.dart';

void main() {
  // NET PAY IS NOT THE COST OF A PAY RUN.
  //
  // The business is charged gross — net plus everything withheld from the
  // employees — PLUS whatever employer contributions it owes on top. That is
  // what payroll-service's own pre-flight refuses an underfunded run against
  // (RunCost.Total() = NetPay + Withheld + EmployerContributions, and
  // net + withheld IS gross).
  //
  // The screen used to compare the balance against totalNet alone, so a run
  // could pass the client check and be refused server-side with a figure the
  // user had never been shown.
  group('total cost', () {
    // One employee on ₦1,000: gross ₦1,000, employer 12% = ₦120.
    test('is gross plus employer contributions', () {
      expect(
        PayRunFundingCheck.totalCost(
            totalGross: 1000.0, totalEmployerContributions: 120.0),
        1120.0,
      );
    });

    // An operator can switch employer contributions off for a business that is
    // exempt (pension needs 15+ employees under PRA 2014 s.2; NSITF and ITF
    // 5+). The run then costs exactly gross, and asking for more would refuse
    // a run the business can afford.
    test('is exactly gross when the employer owes nothing on top', () {
      expect(
        PayRunFundingCheck.totalCost(
            totalGross: 1000.0, totalEmployerContributions: 0.0),
        1000.0,
      );
    });

    test('never comes out below gross', () {
      for (final employer in [0.0, 0.01, 120.0, 99999.0]) {
        expect(
          PayRunFundingCheck.totalCost(
              totalGross: 1000.0, totalEmployerContributions: employer),
          greaterThanOrEqualTo(1000.0),
        );
      }
    });
  });

  group('shortfall', () {
    test('null when the balance covers the full cost', () {
      final cost = PayRunFundingCheck.totalCost(
          totalGross: 1000.0, totalEmployerContributions: 120.0);
      expect(
        PayRunFundingCheck.shortfall(
            totalNet: cost, availableBalance: 1120.0),
        isNull,
      );
      expect(
        PayRunFundingCheck.shortfall(
            totalNet: cost, availableBalance: 5000.0),
        isNull,
      );
    });

    // The case the old check waved through: enough for net, not enough for the
    // employer's 12%. The server refuses it; the user must hear it here first.
    test('catches a balance that covers net but not the statutory cost', () {
      final cost = PayRunFundingCheck.totalCost(
          totalGross: 1000.0, totalEmployerContributions: 120.0);
      final short =
          PayRunFundingCheck.shortfall(totalNet: cost, availableBalance: 1000.0);
      expect(short, isNotNull);
      expect(short, closeTo(120.0, 0.001));
    });

    test('names the exact amount to add', () {
      expect(
        PayRunFundingCheck.shortfall(totalNet: 1120.0, availableBalance: 900.5),
        closeTo(219.5, 0.001),
      );
    });

    // Compared in kobo, not in doubles: 0.1 + 0.2 != 0.3 in binary floating
    // point, and a run refused for a third of a kobo is a run nobody can fix.
    test('an exact match is not a shortfall', () {
      expect(
        PayRunFundingCheck.shortfall(
            totalNet: 0.1 + 0.2, availableBalance: 0.3),
        isNull,
      );
    });
  });
}
