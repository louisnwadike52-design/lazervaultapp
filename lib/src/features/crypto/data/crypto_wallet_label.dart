/// Names the Lazervault account a crypto trade settles on.
///
/// Receipts used to say "LazerVault Wallet". That names nothing the user can
/// find anywhere else in the app — there is no screen, balance or statement
/// called a "wallet" — and it was the only place in the product still spelling
/// the brand in PascalCase.
///
/// There is exactly one account it can be: crypto buys debit, and sells credit,
/// the user's PERSONAL fiat account. crypto_withdraw_saga replaces any
/// client-supplied account id with the server-resolved personal NGN account, so
/// naming any other account would be a guess the server would overrule.
///
/// Pass the live account type when the surface has one loaded (the fiat pill
/// reads it from AccountCardsSummary); the receipt built from a history row has
/// no account on it, and falls back to the same answer the server enforces.
String cryptoSettlementAccountLabel([String? accountType]) {
  final t = (accountType ?? '').trim();
  if (t.isEmpty) return 'Personal account';
  return '${t[0].toUpperCase()}${t.substring(1).toLowerCase()} account';
}

/// Case-insensitive match for a settlement-account label, for the surfaces that
/// still switch on the payment-method string. Accepts the retired
/// "Lazervault Wallet" spellings so an in-flight receipt built by an older
/// build still resolves instead of falling through to a generic branch.
bool isCryptoSettlementAccount(String paymentMethod) {
  final m = paymentMethod.trim().toLowerCase();
  return m.endsWith(' account') || m.endsWith('wallet');
}
