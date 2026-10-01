/// The part of someone's name you would actually say out loud.
///
/// WHY
/// ---
/// Money lines in Financial Connections read like speech — "Nnaemeka
/// Christiana sent you ₦2,000", "You sent to Nnaemeka Christiana" — and a
/// full legal name is not how anybody says that. It is also the longest
/// possible string in a single-line, ellipsised row, so on a double-barrelled
/// name the amount got pushed off the end and the one number the line exists
/// to carry was the first thing to go.
///
/// WHAT IT DOES NOT DO
/// -------------------
/// This is for CONVERSATIONAL copy only. Anywhere the name identifies a party
/// to a transaction — a receipt, a beneficiary confirmation, an audit row, a
/// transfer review screen — the full name stays, because that is where
/// telling two people apart matters and where the user is checking the money
/// is going to the right person.
///
/// EDGE CASES IT HAS TO SURVIVE
/// ----------------------------
/// Nigerian display names arrive in every shape the directory allows:
///
///   "Nnaemeka Christiana"      → Nnaemeka
///   "ONAH, Praiz"              → Onah      (comma-ordered, surname first)
///   "Dr. Ada Obi"              → Ada       (honorific skipped)
///   "praiz"                    → praiz     (single token, left alone)
///   "  Ada   Obi  "            → Ada       (collapsed whitespace)
///   "@praiz_o"                 → @praiz_o  (a handle is already short)
///   "Mary-Jane Okafor"         → Mary-Jane (hyphenated given name intact)
///   ""                         → ""        (caller supplies the fallback)
///
/// Case is NOT normalised beyond a comma-ordered surname, because a name is
/// the user's to spell: "chi" stays "chi" and "MOHAMMED" stays "MOHAMMED".
library;

/// Honorifics and titles that are never the name itself.
const _titles = <String>{
  'mr', 'mrs', 'ms', 'miss', 'master', 'mallam', 'malam', 'alhaji', 'alhaja',
  'hajia', 'chief', 'dr', 'prof', 'professor', 'engr', 'barr', 'rev',
  'pastor', 'bishop', 'imam', 'sir', 'lady', 'hon', 'otunba', 'oba', 'eze',
  'igwe', 'arc', 'surv', 'amb',
};

/// The first name in [fullName], or the empty string when there is none.
///
/// Returns the input unchanged when it is a single token, a handle, or
/// anything else with no second part to drop — shortening is only ever a
/// removal, never a rewrite.
String firstNameOf(String? fullName) {
  final raw = (fullName ?? '').trim();
  if (raw.isEmpty) return '';

  // A handle is already the short form and splitting it on punctuation would
  // mangle it ("@praiz_o" is one word, "praiz.o" is a username not two names).
  if (raw.startsWith('@')) return raw;

  // "ONAH, Praiz" — surname first. The given name is after the comma, and the
  // surname is usually shouted in caps, so take the given name and leave its
  // own case alone.
  final comma = raw.indexOf(',');
  if (comma > 0 && comma < raw.length - 1) {
    final given = raw.substring(comma + 1).trim();
    if (given.isNotEmpty) return _firstToken(given);
  }

  return _firstToken(raw);
}

/// First whitespace-separated token, skipping leading honorifics.
String _firstToken(String s) {
  final parts = s.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
  if (parts.isEmpty) return '';
  for (final part in parts) {
    // "Dr." / "Dr" / "ENGR." all strip to the same key.
    final key = part.replaceAll(RegExp(r'[^A-Za-z]'), '').toLowerCase();
    if (key.isEmpty || _titles.contains(key)) continue;
    return part;
  }
  // Every token was a title — vanishingly unlikely, but returning "" here
  // would silently erase the person. Give back what we were handed.
  return parts.first;
}

/// [firstNameOf], with [fallback] when the name is empty or unusable.
String firstNameOr(String? fullName, String fallback) {
  final first = firstNameOf(fullName);
  return first.isEmpty ? fallback : first;
}
