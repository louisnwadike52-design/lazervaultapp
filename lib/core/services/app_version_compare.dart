/// Compares two app version strings the way humans mean them.
///
/// ## Why not just compare the strings
///
/// `"1.0.10".compareTo("1.0.9")` is NEGATIVE — '1' sorts before '9' — so a
/// string compare says 1.0.10 is older than 1.0.9 and the tenth patch release
/// would never prompt anyone. Any version scheme that reaches double digits
/// hits this, and it does so silently.
///
/// ## Why the app needs it at all
///
/// The update check prefers the BUILD number, which is a single integer and
/// unambiguous. But the build cannot always decide:
///
///   * `app_latest_build_ios` is 0 whenever nothing has been released there
///     yet, and the App Store's own lookup answers with a version STRING, not
///     a build — so on iOS the version is often the only comparable value.
///   * A release can raise the version (1.0.1 → 1.0.2, or → 1.1.0) and an
///     operator may set only the version field.
///
/// So: build decides when both sides have one, and this decides otherwise.
///
/// ## The rule
///
/// Returns <0 when [a] is older than [b], 0 when equal, >0 when newer.
/// Segments are compared numerically, left to right; a missing segment counts
/// as 0, so "1.1" == "1.1.0" rather than being treated as older. Anything
/// non-numeric in a segment (a "-beta" suffix, a stray letter) is reduced to
/// its leading digits, because a pre-release tag must not make a version look
/// NEWER than the release it precedes.
int compareAppVersions(String a, String b) {
  final sa = _segments(a);
  final sb = _segments(b);
  final len = sa.length > sb.length ? sa.length : sb.length;
  for (var i = 0; i < len; i++) {
    final x = i < sa.length ? sa[i] : 0;
    final y = i < sb.length ? sb[i] : 0;
    if (x != y) return x < y ? -1 : 1;
  }
  return 0;
}

/// The numeric segments of [v], or EMPTY when it contains no version at all.
///
/// The empty answer matters more than the parsing. A value with no digits
/// ("abc", "unknown", a placeholder someone typed) used to reduce to [0] —
/// i.e. 0.0.0 — which compares as OLDER THAN EVERY REAL VERSION. An app that
/// could not read its own version would then prompt every user to update, for
/// ever. Returning empty lets the caller refuse to answer instead of
/// confidently answering wrong.
List<int> _segments(String v) {
  final trimmed = v.trim();
  if (trimmed.isEmpty) return const [];
  // Drop any build metadata the store may append ("1.0.1+499", "1.0.1 (499)").
  final core = trimmed.split(RegExp(r'[+( ]')).first;
  var sawDigit = false;
  final parts = core.split('.').map((part) {
    final digits = RegExp(r'^\d+').firstMatch(part.trim())?.group(0);
    if (digits != null && digits.isNotEmpty) sawDigit = true;
    return int.tryParse(digits ?? '') ?? 0;
  }).toList();
  // No digits anywhere: this is not a version, and must not be treated as the
  // lowest one.
  return sawDigit ? parts : const [];
}

/// Whether [latest] is strictly newer than [installed].
///
/// STRICTLY. Equal versions must never prompt: telling someone to update to
/// what they already have is the single fastest way to make an update prompt
/// feel broken, and it is what an operator sees the moment they set the latest
/// version to the build they are themselves running.
///
/// An empty or unparseable value on either side answers FALSE — an update we
/// cannot establish is not an update we should interrupt someone for.
bool isNewerAppVersion({required String installed, required String latest}) {
  if (installed.trim().isEmpty || latest.trim().isEmpty) return false;
  if (_segments(installed).isEmpty || _segments(latest).isEmpty) return false;
  return compareAppVersions(installed, latest) < 0;
}
