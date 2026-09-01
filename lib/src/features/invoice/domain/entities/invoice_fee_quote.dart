/// The invoice service fee for the user's active account, resolved by the
/// backend (admin-configured, priced per region: base fee in the base
/// currency, flat foreign fee in any other). Never hardcoded on the client.
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

/// ISO-4217 zero-decimal currencies (¥1/₩1 — no cents). Mirrors the backend's
/// set in invoice-service currency_exponent.go.
const Set<String> _zeroDecimalCurrencies = {
  'BIF', 'CLP', 'DJF', 'GNF', 'ISK', 'JPY', 'KMF', 'KRW',
  'PYG', 'RWF', 'UGX', 'VND', 'VUV', 'XAF', 'XOF', 'XPF',
};

/// Formats a fee amount with the right fraction digits for its currency:
/// whole units for zero-decimal currencies (¥10, never ¥10.00), two decimals
/// for everything else (₦99.00, $9.99).
String formatFeeAmount(double amount, String currency) =>
    _zeroDecimalCurrencies.contains(currency.trim().toUpperCase())
        ? amount.toStringAsFixed(0)
        : amount.toStringAsFixed(2);
