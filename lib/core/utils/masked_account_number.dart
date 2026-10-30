/// The app's ONE spelling for a partially hidden account number.
///
/// `RecipientModel.maskedAccount` established the shape (`•••• 7890`) and the
/// rule that goes with it: only a REAL account number may be masked. An
/// internal Lazervault payee created from a chat or a username carries the
/// user-id UUID in its account-number field purely to satisfy send-flow
/// validation, and masking that produces a meaningless `•••• 4f2a` which
/// reads to the user as "this is the account your money is going to".
///
/// This helper exists so the search and bank-suggestion surfaces — which show
/// a bare string rather than a `RecipientModel` — apply the same rule instead
/// of each re-deriving it.
library;

/// True when [value] is a real, maskable account number: contiguous digits,
/// long enough to have a meaningful tail. A UUID (hyphens), an `@handle` or a
/// bare label fails this.
bool isRealAccountNumber(String? value) {
  final v = (value ?? '').trim();
  if (v.length < 4) return false;
  return RegExp(r'^[0-9]+$').hasMatch(v);
}

/// `•••• 7890` for a real account number, otherwise ''.
///
/// Returning empty rather than the raw value is deliberate: a caller that
/// prints this straight into a subtitle then shows nothing where it has
/// nothing, instead of printing a UUID fragment as if it were an account.
String maskedAccountNumber(String? value) {
  final v = (value ?? '').trim();
  if (!isRealAccountNumber(v)) return '';
  return '•••• ${v.substring(v.length - 4)}';
}
