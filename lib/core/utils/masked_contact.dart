/// Detects the privacy-masked contact strings that user SEARCH returns.
///
/// auth-service's SearchUsers deliberately masks email and phone — its proto
/// says so on the field ("Email (masked for privacy)") — so that nobody can
/// harvest contact details by typing names into a search box. A search result's
/// `email` is therefore `ez***@gmail.com`, never a usable address.
///
/// Payroll's Add Employee screen prefilled that value straight into its Email
/// field. The form then rejected its own prefill with "Enter a valid email
/// address", on a field labelled optional, and the only way past it was for the
/// employer to notice and clear a value the app had put there.
///
/// The masking is correct and stays. What was wrong was treating a field the
/// contract calls masked as if it held real data. A screen that wants a real
/// address asks the person for it.
library;

/// True when [value] is a masked contact rather than a usable one.
///
/// The mask is a run of asterisks standing in for the elided characters, and no
/// legitimate email or phone number contains one — RFC 5321 allows `*` only
/// inside a quoted local part, which no real mailbox uses and no keyboard on
/// this platform produces. So the test is simply: does it contain an asterisk.
///
/// Intentionally not a strict pattern match. `ez***@gmail.com`, `***1234` and
/// `j*@x.co` are all masked, and a stricter rule would pass whichever shape the
/// server changes to next while the caller kept believing the value was real.
bool isMaskedContact(String? value) {
  if (value == null) return false;
  return value.contains('*');
}

/// [value] when it is safe to prefill into an editable field, otherwise ''.
///
/// Use at every point a search result's contact details seed a form. Returning
/// empty rather than the mask leaves the field blank and the placeholder
/// visible, which reads as "we don't have this, type it if you want" — the
/// truth — instead of as a broken value the user has to clean up.
String prefillableContact(String? value) {
  final v = value?.trim() ?? '';
  return isMaskedContact(v) ? '' : v;
}
