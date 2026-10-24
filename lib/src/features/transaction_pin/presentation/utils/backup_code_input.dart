library;

/// Accepting a 2FA BACKUP CODE where the PIN-reset screen only took digits.
///
/// Resetting a transaction PIN can be verified three ways: email OTP, SMS OTP,
/// or the authenticator. The backend's authenticator check falls back to the
/// user's unused 2FA **backup codes** — the very thing backup codes exist for,
/// since someone resetting a PIN because they lost their phone has also lost
/// the authenticator on it.
///
/// But the reset UI renders six single-character boxes with
/// `FilteringTextInputFormatter.digitsOnly`, and a backup code is EIGHT
/// uppercase HEX characters (`%08X`, e.g. `A3F91B2C`, displayed as
/// `A3F9-1B2C`). So the backend accepted something the screen made
/// unenterable, and the only route left was email or SMS — exactly the
/// channels a lost phone may also take with it.
///
/// ## Normalisation is not cosmetic here
///
/// Backup codes are stored **hashed** (`password.Hash` over the value from
/// `GenerateBackupCodes`), and verification is `password.Verify(code, hash)`.
/// The hashed value is the UNDASHED, UPPERCASE form — `FormatBackupCode` adds
/// the dash for display only. So the exact string matters: a user who types
/// what they see (`a3f9-1b2c`) must have it normalised to `A3F91B2C` or a
/// perfectly valid code is rejected and one of their ten is wasted on a retry.
class BackupCodeInput {
  BackupCodeInput._();

  /// How many characters a backup code has (totp.BackupCodeLength).
  static const length = 8;

  static const _hex = '0123456789ABCDEF';

  /// Strips formatting and upper-cases, yielding the form the server hashed.
  ///
  /// Everything that is not a hex digit is dropped — the display dash, spaces
  /// from a paste, and the invisible characters a password manager or a PDF
  /// copy can bring with it.
  static String normalise(String raw) {
    final buf = StringBuffer();
    for (final ch in raw.toUpperCase().split('')) {
      if (_hex.contains(ch)) buf.write(ch);
    }
    return buf.toString();
  }

  /// Whether [raw] normalises to something that could BE a backup code.
  ///
  /// Only a shape check — the server decides whether it is a real one. The
  /// point is to refuse before spending a round trip, not to pre-judge it.
  static bool isWellFormed(String raw) => normalise(raw).length == length;

  /// Display form: `A3F9-1B2C`. Matches totp.FormatBackupCode so what the user
  /// was shown at enrolment is what the field echoes back.
  static String format(String raw) {
    final n = normalise(raw);
    if (n.length != length) return n;
    return '${n.substring(0, 4)}-${n.substring(4)}';
  }

  /// A TOTP code is six DIGITS; a backup code is eight HEX characters. Used to
  /// tell the user which of the two they appear to be typing.
  static bool looksLikeTotp(String raw) {
    final t = raw.trim();
    if (t.length != 6) return false;
    return t
        .split('')
        .every((c) => c.codeUnitAt(0) >= 0x30 && c.codeUnitAt(0) <= 0x39);
  }
}
