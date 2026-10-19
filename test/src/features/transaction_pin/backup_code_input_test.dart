import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/transaction_pin/presentation/utils/backup_code_input.dart';

/// THE PIN-RESET SCREEN COULD NOT ACCEPT A BACKUP CODE.
///
/// The authenticator path's backend check falls back to the user's unused 2FA
/// backup codes — the exact thing they exist for, since someone resetting a
/// transaction PIN because they lost their phone lost the authenticator with
/// it. But the UI renders six single-character boxes with digitsOnly, and a
/// backup code is EIGHT uppercase HEX characters (A3F91B2C, shown A3F9-1B2C).
/// The backend accepted what the screen made impossible to type.
///
/// Normalisation is load-bearing, not cosmetic: codes are stored HASHED over
/// the UNDASHED UPPERCASE form (FormatBackupCode adds the dash for display
/// only), and verification is password.Verify(code, hash). A user typing what
/// they were SHOWN must have it normalised, or a valid code is rejected and
/// one of their ten is burned on the retry.
void main() {
  group('normalise produces the form the server hashed', () {
    test('the displayed, dashed form', () {
      expect(BackupCodeInput.normalise('A3F9-1B2C'), 'A3F91B2C');
    });

    test('lower case, as a phone keyboard offers it', () {
      expect(BackupCodeInput.normalise('a3f9-1b2c'), 'A3F91B2C');
    });

    test('a paste with spaces and stray whitespace', () {
      expect(BackupCodeInput.normalise('  A3F9 1B2C \n'), 'A3F91B2C');
    });

    test('non-hex characters are dropped, not kept', () {
      // A PDF or password-manager copy can bring punctuation with it.
      expect(BackupCodeInput.normalise('A3F9–1B2C'), 'A3F91B2C');
      expect(BackupCodeInput.normalise('"A3F91B2C"'), 'A3F91B2C');
    });

    test('digits-only codes survive — hex includes 0-9', () {
      expect(BackupCodeInput.normalise('1234-5678'), '12345678');
    });
  });

  group('well-formedness is a shape check, not a verdict', () {
    test('accepts the real shape in every spelling', () {
      for (final s in ['A3F91B2C', 'a3f9-1b2c', 'A3F9 1B2C', '12345678']) {
        expect(BackupCodeInput.isWellFormed(s), isTrue, reason: s);
      }
    });

    test('refuses the wrong length before spending a round trip', () {
      expect(BackupCodeInput.isWellFormed('A3F91B2'), isFalse);
      expect(BackupCodeInput.isWellFormed('A3F91B2CD'), isFalse);
      expect(BackupCodeInput.isWellFormed(''), isFalse);
    });

    test('refuses a 6-digit TOTP code, which is the other channel', () {
      expect(BackupCodeInput.isWellFormed('123456'), isFalse);
    });

    test('G-Z are not hex, so they cannot pad a short code to length', () {
      // 'GHIJKLMN' normalises to '' — it must not read as 8 characters.
      expect(BackupCodeInput.isWellFormed('GHIJKLMN'), isFalse);
    });
  });

  test('format echoes back what enrolment displayed', () {
    expect(BackupCodeInput.format('a3f91b2c'), 'A3F9-1B2C');
    // Not yet complete — do not pretend it is.
    expect(BackupCodeInput.format('a3f9'), 'A3F9');
  });

  group('telling the two codes apart', () {
    test('six digits is a TOTP code', () {
      expect(BackupCodeInput.looksLikeTotp('123456'), isTrue);
    });

    test('eight hex is not', () {
      expect(BackupCodeInput.looksLikeTotp('A3F91B2C'), isFalse);
    });

    test('six HEX characters is not a TOTP code either', () {
      // 'A3F91B' is six characters but not six digits.
      expect(BackupCodeInput.looksLikeTotp('A3F91B'), isFalse);
    });
  });
}
