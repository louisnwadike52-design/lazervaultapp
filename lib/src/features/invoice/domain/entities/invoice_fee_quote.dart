/// The invoice service fee for the user's active account, resolved by the
/// backend (admin-configured base fee, FX-converted into the account's
/// currency). Never hardcoded on the client.
class InvoiceFeeQuote {
  final double amount; // major units of [currency]
  final String currency; // account currency the fee is charged in
  final bool enabled; // false when admin has disabled the fee

  const InvoiceFeeQuote({
    required this.amount,
    required this.currency,
    required this.enabled,
  });
}
