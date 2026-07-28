/// A single bank suggestion for a bare account number, returned by the
/// account-number-first send-funds UX. Codes are already in the active
/// verification provider's scheme, so [bankCode] can be handed straight back to
/// verification / the transfer flow. [accountName] is already resolved, so
/// selecting a suggestion needs no second verify round-trip.
class AccountSuggestion {
  final String bankCode;
  final String bankName;
  final String accountName;
  final String accountNumber;

  const AccountSuggestion({
    required this.bankCode,
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
  });
}
