/// Normalizes user input for Lazervault user search (username, email, phone).
///
/// Strips leading `$` (TagPay-style) and leading `@` handles (e.g. `@@user` → `user`).
/// Does not remove `@` from email local parts (e.g. `name@domain.com` unchanged).
String normalizeLazerVaultUserSearchQuery(String raw) {
  var q = raw.trim();
  while (q.startsWith(r'$')) {
    q = q.substring(1).trim();
  }
  while (q.startsWith('@')) {
    q = q.substring(1).trim();
  }
  // Emails: collapse internal whitespace and lowercase so search matches DB LOWER(TRIM(...)).
  if (q.contains('@')) {
    q = q.replaceAll(RegExp(r'\s+'), ' ').toLowerCase();
  } else {
    // Usernames are stored + looked up lowercase on the backend, so a @handle
    // typed in mixed case must be lowercased before the lookup/compare (a case
    // mismatch could otherwise miss a transfer-by-username recipient). Phone
    // input is digits/+, so lowercasing it is a harmless no-op.
    q = q.toLowerCase();
  }
  return q;
}
