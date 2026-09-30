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
