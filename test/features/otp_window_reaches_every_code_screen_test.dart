import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A SCREEN THAT COLLECTS A CODE MUST SAY WHEN THAT CODE DIES.
///
/// Three separate surfaces asked for a one-time code while showing only the
/// RESEND COOLDOWN — a different clock answering a different question — and
/// one of them showed no clock at all:
///
///  * the transaction-PIN reset (settings) received the real window from
///    auth-service and dropped it on the floor, showing "Resend in 57s" as the
///    only number on screen;
///  * the 2FA LOGIN screen had neither a countdown nor a resend, so a code
///    that expired after ~120 seconds left the customer choosing between a
///    backup code and abandoning the login;
///  * the 2FA SETUP screen's resend was live immediately, inside the server's
///    own 90-second refusal window, so an impatient tap spent a code from the
///    customer's budget and sent nothing.
///
/// Underneath all three: `SendTwoFactorCodeResponse.expires_in` was on the
/// wire and the repository returned `void`, so no 2FA screen could have shown
/// the window even if it had wanted to.
///
/// Source-text, matching the house guards beside it: the defect is not a
/// behaviour a widget test reaches, it is a value someone drops again.
void main() {
  String read(String path) {
    final f = File(path);
    expect(f.existsSync(), isTrue,
        reason: '$path is missing — this guard needs updating');
    return f.readAsStringSync();
  }

  /// Comments name the old numbers on purpose, so a check about code must not
  /// read them.
  String code(String src) => src
      .split('\n')
      .where((l) =>
          !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
      .join('\n');

  test('the 2FA repository returns the window instead of discarding it', () {
    final iface = code(read(
        'lib/src/features/authentication/domain/repositories/i_auth_repository.dart'));
    final impl = code(read(
        'lib/src/features/authentication/data/repositories/auth_repository.dart'));

    expect(iface, contains('Future<Either<Failure, int>> sendTwoFactorLoginCode'),
        reason: 'returning void here is what left every 2FA screen with no '
            'window to show; expires_in was on the wire the whole time');
    expect(impl, contains('Right(response.expiresIn.toInt())'),
        reason: 'the implementation must hand back what the server reported, '
            'not a constant and not nothing');
  });

  test('a refused 2FA send does not become a silent success', () {
    final impl = code(read(
        'lib/src/features/authentication/data/repositories/auth_repository.dart'));
    // The response carries success + message; ignoring them meant a rate
    // limited send still armed a countdown over a code never issued.
    expect(impl, contains('if (!response.success)'),
        reason: 'a send the server refused must surface as a Failure, so the '
            'screens do not ask for a code that was never sent');
  });

  test('the 2FA cubit distinguishes "refused" from "no window given"', () {
    final cubit = code(read(
        'lib/src/features/authentication/cubit/authentication_cubit.dart'));
    expect(cubit, contains('Future<int?> sendTwoFactorCode'),
        reason: 'a bool cannot carry the window; null must stay available for '
            '"nothing was sent", which is not the same as "sent, no window"');
  });

  test('every code-entry surface renders the code\'s own countdown', () {
    const surfaces = <String>[
      // settings → transaction PIN reset
      'lib/src/features/transaction_pin/presentation/views/forgot_pin_screen.dart',
      // login → 2FA step-up
      'lib/src/features/authentication/presentation/views/two_factor_verification_screen.dart',
      // settings → enable 2FA
      'lib/src/features/authentication/presentation/views/two_factor_setup_screen.dart',
      // settings → disable 2FA / regenerate backup codes (shared sheet)
      'lib/src/features/authentication/presentation/widgets/two_factor_widgets.dart',
      // the original: passcode reset
      'lib/src/features/authentication/presentation/views/forgot_passcode_phone_screen.dart',
      // settings → profile → change phone number. The repository stopped
      // discarding expires_in, and the screen still showed only the cooldown —
      // a half-fix of exactly the defect its own header note describes.
      'lib/src/features/profile/presentation/view/change_phone_screen.dart',
    ];
    final missing = <String>[];
    for (final path in surfaces) {
      if (!code(read(path)).contains('OtpExpiryCountdown')) missing.add(path);
    }
    expect(missing, isEmpty,
        reason: 'these collect a one-time code with no statement of when it '
            'stops working:\n  ${missing.join('\n  ')}');
  });

  test('the PIN OTP result does not invent a window the server did not give',
      () {
    final body = code(read(
        'lib/src/features/transaction_pin/services/transaction_pin_service_widgets.dart'));
    final fabricated =
        RegExp(r'expiresInSeconds\s*=\s*([1-9]\d+)').firstMatch(body);
    expect(fabricated, isNull,
        reason: 'defaulted to ${fabricated?.group(1)} seconds for a code whose '
            'window is the admin dial — when nobody has said, the honest '
            'countdown is no countdown (0)');
  });

  test('the countdown re-arms per send, so a resend cannot expire a new code',
      () {
    // OtpExpiryCountdown only re-arms when `seconds` CHANGES. A resend that
    // returns the same window (120 → 120) would leave the dead code's clock
    // running, so each mount is keyed on a per-send counter instead.
    const keyed = <String>[
      'lib/src/features/transaction_pin/presentation/views/forgot_pin_screen.dart',
      'lib/src/features/authentication/presentation/views/two_factor_verification_screen.dart',
      'lib/src/features/authentication/presentation/views/two_factor_setup_screen.dart',
      'lib/src/features/authentication/presentation/views/forgot_passcode_phone_screen.dart',
      'lib/src/features/profile/presentation/view/change_phone_screen.dart',
    ];
    final unkeyed = <String>[];
    for (final path in keyed) {
      final body = code(read(path));
      final mount = body.indexOf('OtpExpiryCountdown(');
      if (mount < 0) {
        unkeyed.add('$path (no countdown at all)');
        continue;
      }
      final window = body.substring(mount, (mount + 260).clamp(0, body.length));
      if (!window.contains('key:')) unkeyed.add(path);
    }
    expect(unkeyed, isEmpty,
        reason: 'an unkeyed countdown survives a resend and expires a code '
            'that was just issued:\n  ${unkeyed.join('\n  ')}');
  });
}
