/// Normalizes user input for LazerVault user search (username, email, phone).
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
  }
  return q;
}
