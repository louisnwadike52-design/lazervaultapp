/// The company's own name when it appears in a *bank* field.
///
/// WHY THIS EXISTS: the backend writes `"Lazervault"` (see accounts-service
/// recipient_service.go) while the send-funds, batch and P2P screens compared
/// against `'LazerVault'` with a capital V. Every one of those comparisons was
/// therefore false for a real internal recipient, and the flow treated an
/// on-platform payee as an external bank:
///
///   * the balance pre-check added an external fee that is not charged,
///   * "Bank details are incomplete" blocked the transfer outright, because an
///     internal recipient has no sort code,
///   * the fee quote asked for a `domestic` transfer while the request that
///     followed correctly said `internal` — quote and charge disagreed,
///   * the receipt read "External Bank Transfer",
///   * and the P2P connection was never created, so the receiver saw
///     "Unknown User".
///
/// One spelling of a brand should never be able to do that. Nothing compares a
/// bank name to a literal any more; it asks [isOurs].
abstract final class BrandBank {
  /// The one spelling we write in user-facing copy. Normal case — not the
  /// camel-cased `LazerVault`, which is the old logotype and reads as a typo
  /// in a sentence.
  static const String displayName = 'Lazervault';

  /// True when [bankName] names US rather than an external institution.
  ///
  /// Substring, not equality, and deliberately so: the NIBSS registry and the
  /// name-enquiry rails return our account under several spellings
  /// ("LAZERVAULT LTD", "Lazervault- LTD.", "Lazervault MFB"), and no external
  /// institution is called anything containing "lazervault". This is the same
  /// rule `TransferBankDisplay` and `BankLogo` already applied — it is now the
  /// only one.
  static bool isOurs(String? bankName) {
    if (bankName == null) return false;
    return bankName.trim().toLowerCase().contains('lazervault');
  }

  /// Collapses any registry variant to [displayName] for display. Leaves a
  /// genuine external bank untouched.
  ///
  /// For USER-FACING copy only. A ledger or name-enquiry field keeps the
  /// verbatim bank record, which is what the backend's `brandDisplayName`
  /// helpers also observe.
  static String display(String bankName) =>
      isOurs(bankName) ? displayName : bankName;
}
