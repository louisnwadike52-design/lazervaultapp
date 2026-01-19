/// Account verification result entity.
///
/// Represents the result of verifying a bank account via Paystack API.
/// Contains account details fetched from the verification service.
class AccountVerificationResult {
  final String accountNumber;
  final String accountName;
  final String bankName;
  final String bankCode;
  final String verificationStatus;

  const AccountVerificationResult({
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
    required this.bankCode,
    required this.verificationStatus,
  });

  /// Create from JSON response.
  factory AccountVerificationResult.fromJson(Map<String, dynamic> json) {
    return AccountVerificationResult(
      accountNumber: json['account_number'] as String,
      accountName: json['account_name'] as String,
      bankName: json['bank_name'] as String,
      bankCode: json['bank_code'] as String,
      verificationStatus: json['verification_status'] as String? ?? 'verified',
    );
  }

  /// Convert to JSON.
  Map<String, dynamic> toJson() {
    return {
      'account_number': accountNumber,
      'account_name': accountName,
      'bank_name': bankName,
      'bank_code': bankCode,
      'verification_status': verificationStatus,
    };
  }

  /// Check if verification was successful.
  bool get isVerified => verificationStatus == 'verified';

  /// Copy with new values.
  AccountVerificationResult copyWith({
    String? accountNumber,
    String? accountName,
    String? bankName,
    String? bankCode,
    String? verificationStatus,
  }) {
    return AccountVerificationResult(
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
      bankName: bankName ?? this.bankName,
      bankCode: bankCode ?? this.bankCode,
      verificationStatus: verificationStatus ?? this.verificationStatus,
    );
  }

  @override
  String toString() {
    return 'AccountVerificationResult(accountNumber: $accountNumber, accountName: $accountName, bankName: $bankName, bankCode: $bankCode, verificationStatus: $verificationStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AccountVerificationResult &&
        other.accountNumber == accountNumber &&
        other.accountName == accountName &&
        other.bankName == bankName &&
        other.bankCode == bankCode &&
        other.verificationStatus == verificationStatus;
  }

  @override
  int get hashCode {
    return accountNumber.hashCode ^
        accountName.hashCode ^
        bankName.hashCode ^
        bankCode.hashCode ^
        verificationStatus.hashCode;
  }
}
