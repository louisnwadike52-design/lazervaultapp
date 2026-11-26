/// THE ONE DEFINITION OF "a complete destination account number".
///
/// Every surface that takes a bare account number and then decides when to
/// resolve it — send funds, batch transfer, split bill, the OCR scan sheet —
/// needs the same answer to "has the payer finished typing?". The rule lived
/// in four separate copies, and a copy that drifts does not fail loudly: the
/// field simply accepts a number nothing ever acts on, or rejects one the
/// payer can see is right.
///
/// WHY 11 AND NOT JUST 10. A NUBAN is ten digits. The fintech wallets — OPay,
/// PalmPay, Moniepoint — assign PHONE-NUMBER-based account numbers, so the
/// same account is written `08012345678` or `8012345678` depending on who
/// wrote it down. core-payments' own `normalizePhoneAccount` makes exactly
/// this allowance and reduces the eleven-digit form to the ten-digit NUBAN, so
/// a field that refuses it is refusing a number the backend would have
/// resolved. The leading zero is required: eleven digits NOT starting with
/// zero is not a wallet form, it is a typo.
library;

/// Longest value a destination-account field should accept.
///
/// Use this for the input limiter rather than a literal, so widening the rule
/// can never leave a field capped below what [isCompleteDestinationAccount]
/// considers valid — a field that cannot hold a complete number is a dead end
/// the payer cannot escape.
const int kDestinationAccountMaxLength = 11;

/// Digits only. Saved rows have been written by several generations of this
/// app and some carry spaces or dashes, so comparing raw strings silently
/// misses them.
String destinationAccountDigits(String v) =>
    v.replaceAll(RegExp(r'[^0-9]'), '');

/// True when [v] is a complete destination account number: a 10-digit NUBAN,
/// or an 11-digit wallet number carrying its leading zero.
///
/// Takes the raw field value — it compacts internally, so callers do not each
/// have to remember to.
bool isCompleteDestinationAccount(String v) {
  final d = destinationAccountDigits(v);
  return d.length == 10 || (d.length == 11 && d.startsWith('0'));
}
