/// Configuration for the exchange feature.
/// Controls which optional UI elements are shown in the exchange flow.
class ExchangeFeatureConfig {
  /// Whether to display the service fee breakdown to users.
  /// Default: false (no fee shown — users see zero fees).
  final bool showServiceFee;

  /// Whether to require transaction PIN before executing exchanges.
  /// Default: true (PIN required for security).
  final bool requireTransactionPin;

  const ExchangeFeatureConfig({
    this.showServiceFee = false,
    this.requireTransactionPin = true,
  });

  /// Default production config: no fee displayed, PIN required.
  static const ExchangeFeatureConfig defaultConfig = ExchangeFeatureConfig();
}
