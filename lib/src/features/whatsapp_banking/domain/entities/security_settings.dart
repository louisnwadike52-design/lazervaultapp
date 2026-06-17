class SecuritySettings {
  final double dailyTransactionLimit;
  final double perTransactionLimit;
  final bool requirePinForAll;
  final double biometricThreshold;

  const SecuritySettings({
    required this.dailyTransactionLimit,
    required this.perTransactionLimit,
    required this.requirePinForAll,
    required this.biometricThreshold,
  });

  SecuritySettings copyWith({
    double? dailyTransactionLimit,
    double? perTransactionLimit,
    bool? requirePinForAll,
    double? biometricThreshold,
  }) {
    return SecuritySettings(
      dailyTransactionLimit: dailyTransactionLimit ?? this.dailyTransactionLimit,
      perTransactionLimit: perTransactionLimit ?? this.perTransactionLimit,
      requirePinForAll: requirePinForAll ?? this.requirePinForAll,
      biometricThreshold: biometricThreshold ?? this.biometricThreshold,
    );
  }
}
