import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// NO OTP SCREEN MAY COMPILE IN ITS OWN RESEND COOLDOWN.
///
/// The wait is an admin dial — `auth_otp_resend_cooldown_seconds` — and
/// auth-service enforces it. A screen that hardcodes a different number
/// unlocks its button at the wrong moment: 60 was written into three screens
/// while the dial read 90, so the control went live thirty seconds early and
/// every tap in that window was refused. Worse, each refused tap still spent
/// one of the customer's three codes, so three impatient taps locked them out
/// for half an hour having received a single message.
///
/// Source-text, like auth-service's own otp_window_is_never_hardcoded_test.go,
/// and for the same reason: the mistake is not a behaviour a widget test
/// reaches, it is a literal someone types back in.
void main() {
  test('no OTP screen hardcodes a resend cooldown', () {
    final screens = <String>[
      'lib/src/features/authentication/presentation/views/phone_verification_screen.dart',
      'lib/src/features/authentication/presentation/views/email_verification_screen.dart',
      'lib/src/features/authentication/presentation/views/phone_email_verification_screen.dart',
      'lib/src/features/authentication/presentation/views/forgot_passcode_phone_screen.dart',
      'lib/src/features/authentication/presentation/views/phone_otp_screen.dart',
      'lib/src/features/authentication/presentation/views/login_otp_screen.dart',
      'lib/src/features/profile/presentation/view/change_phone_screen.dart',
      'lib/src/features/widgets/resend_code_button.dart',
    ];

    // A literal assigned to, or returned as, anything that names a resend or
    // cooldown. `= 0` is allowed: it means "no wait", not a duration.
    final offender = RegExp(
      r'(_?resend[A-Za-z]*(Seconds|Initial[A-Za-z]*)?|_?cooldown[A-Za-z]*)\s*=\s*([1-9]\d+)\b',
      caseSensitive: false,
    );
    final badReturn = RegExp(r'return\s+([1-9]\d+)\s*;');

    final failures = <String>[];
    for (final path in screens) {
      final file = File(path);
      if (!file.existsSync()) {
        failures.add('$path is missing — this guard needs updating');
        continue;
      }
      final lines = file.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i];
        if (line.trimLeft().startsWith('//') || line.trimLeft().startsWith('///')) {
          continue;
        }
        if (offender.hasMatch(line)) {
          failures.add('$path:${i + 1}  ${line.trim()}');
        }
        // A bare `return <number>;` inside an onResend closure is the exact
        // shape that shipped: it hands the button a cooldown the server never
        // agreed to.
        if (badReturn.hasMatch(line) &&
            lines
                .sublist((i - 12).clamp(0, i), i)
                .any((l) => l.contains('onResend') || l.contains('_resendCode'))) {
          failures.add('$path:${i + 1}  ${line.trim()}  (inside a resend handler)');
        }
      }
    }

    expect(
      failures,
      isEmpty,
      reason: 'these read a compiled-in cooldown instead of '
          'endpointRegistry.otpResendCooldownSeconds (the key auth-service '
          'reads):\n  ${failures.join('\n  ')}',
    );
  });
}
