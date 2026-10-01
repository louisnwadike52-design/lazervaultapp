/// Can the source account cover this pay run?
///
/// A pay run that outruns the balance used to be discovered the hard way: the
/// user entered their transaction PIN, the run went out, and the screen came
/// back "failed" — after the PIN, after the commitment, with no figure saying
/// how short they were. Praiz hit exactly that.
///
/// The arithmetic is trivial; the point is WHERE it happens. Checked at the
/// transaction sheet, before a PIN is asked for, it is a fact the user can act
/// on ("you are ₦12,400.00 short"). Checked after, it is a failure report.
class PayRunFundingCheck {
  const PayRunFundingCheck._();

  /// Shortfall in MAJOR units, or null when the balance covers the run.
  ///
  /// Compared in minor units: payroll totals are sums of many net figures and
  /// `12_400.00 + 0.10` style drift is routine in doubles. A run that exactly
  /// equals the balance is fundable — treating it as short by a rounding
  /// artefact would block a legitimate payroll.
  /// What the business must actually have, in major units.
  ///
  /// NET PAY IS NOT THE COST OF A PAY RUN. The business is charged gross
  /// (net + everything withheld from the employees) PLUS whatever employer
  /// contributions it owes on top — pension, NSITF, ITF — which is what
  /// payroll-service's own pre-flight checks before it pays anybody.
  ///
  /// Checking net alone let a run pass here and then be refused server-side
  /// with a figure the user had never been shown. The two checks now compute
  /// the same number: RunCost.Total() in payroll_statutory_funding.go is
  /// NetPay + Withheld + EmployerContributions, and net + withheld IS gross.
  ///
  /// [totalEmployerContributions] is zero when an operator has switched the
  /// employer contributions off, so an exempt business is not asked for money
  /// it does not owe.
  static double totalCost({
    required double totalGross,
    required double totalEmployerContributions,
  }) =>
      totalGross + totalEmployerContributions;

  static double? shortfall({
    required double totalNet,
    required double availableBalance,
  }) {
    final need = (totalNet * 100).round();
    final have = (availableBalance * 100).round();
    if (need <= have) return null;
    return (need - have) / 100.0;
  }

  /// True when the run can be processed from this balance.
  static bool isFunded({
    required double totalNet,
    required double availableBalance,
  }) =>
      shortfall(totalNet: totalNet, availableBalance: availableBalance) == null;
}
