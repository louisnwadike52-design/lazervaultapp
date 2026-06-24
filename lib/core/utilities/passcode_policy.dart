/// Shared weak-code policy for numeric login passcodes (6-digit) and
/// transaction PINs (4-digit). Rejects trivially guessable codes:
///   - all-same digit (e.g. 111111, 0000)
///   - strictly ascending or descending runs (e.g. 123456, 4321, 654321)
///
/// Used by the signup setup screens, the Settings change flows, and the PIN
/// flows so the rule is consistent everywhere. Length is validated separately
/// by each caller (this only judges predictability).
bool isWeakNumericCode(String code) {
  if (code.length < 4) return false;
  if (!RegExp(r'^\d+$').hasMatch(code)) return false;

  // All same digit.
  if (code.split('').every((c) => c == code[0])) return true;

  // Sequential ascending or descending (each step ±1).
  var asc = true;
  var desc = true;
  for (var i = 1; i < code.length; i++) {
    final prev = int.parse(code[i - 1]);
    final cur = int.parse(code[i]);
    if (cur != prev + 1) asc = false;
    if (cur != prev - 1) desc = false;
  }
  return asc || desc;
}
