/// Centralized airtime service fee configuration.
///
/// Toggle [serviceFeeEnabled] to match the backend AIRTIME_SERVICE_FEE_ENABLED flag.
/// When disabled, all fee calculations return 0.0 and fee UI rows are hidden.
class AirtimeFeeConfig {
  AirtimeFeeConfig._();

  /// Master toggle. Set to `true` when backend `AIRTIME_SERVICE_FEE_ENABLED=true`.
  static const bool serviceFeeEnabled = false;

  /// Calculate service fee for a given [amount] and [countryCode].
  /// Returns 0.0 when [serviceFeeEnabled] is false.
  static double calculateFee(double amount, String countryCode) {
    if (!serviceFeeEnabled) return 0.0;

    double feePercent;
    double minFee;
    double maxFee;

    switch (countryCode.toUpperCase()) {
      case 'NG':
        feePercent = 0.01;
        minFee = 5.0;
        maxFee = 100.0;
      case 'US':
        feePercent = 0.02;
        minFee = 1.0;
        maxFee = 10.0;
      case 'GB':
        feePercent = 0.015;
        minFee = 0.5;
        maxFee = 5.0;
      case 'IN':
        feePercent = 0.01;
        minFee = 2.0;
        maxFee = 50.0;
      case 'ZA':
        feePercent = 0.015;
        minFee = 1.0;
        maxFee = 20.0;
      case 'KE':
        feePercent = 0.01;
        minFee = 5.0;
        maxFee = 100.0;
      case 'GH':
        feePercent = 0.02;
        minFee = 0.5;
        maxFee = 10.0;
      default:
        feePercent = 0.02;
        minFee = 1.0;
        maxFee = 10.0;
    }

    final fee = amount * feePercent;
    return fee.clamp(minFee, maxFee);
  }
}
