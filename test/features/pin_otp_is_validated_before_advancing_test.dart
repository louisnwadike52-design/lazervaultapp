import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A WRONG OTP used to walk the user through setting a new PIN.
///
/// The forgot-PIN screen advanced on "six digits typed":
///
///     final code = _getOtpCode();
///     if (code.length == 6) {
///       setState(() { _storedOtpCode = code; _currentStep = 3; });
///     }
///
/// The code was only verified inside completeForgotPin, at the END — so a
/// wrong code took the user to the new-PIN step, had them choose and confirm
/// a PIN, and only then failed. The failure arrived attached to the PIN step,
/// where it reads as if the PIN had been rejected rather than the code.
///
/// Source-level because the defect is WHERE a call happens relative to a step
/// transition, which no stub round-trip can observe.
void main() {
  String code(String p) => File(p)
      .readAsStringSync()
      .split('\n')
      .where((l) =>
          !l.trimLeft().startsWith('//') &&
          !l.trimLeft().startsWith('///') &&
          !l.trimLeft().startsWith('*'))
      .join('\n');

  const screen =
      'lib/src/features/transaction_pin/presentation/views/forgot_pin_screen.dart';
  const cubit = 'lib/src/features/transaction_pin/cubit/pin_management_cubit.dart';
  const service =
      'lib/src/features/transaction_pin/services/transaction_pin_service.dart';

  group('the code is checked on the screen that collected it', () {
    test('typing six digits no longer advances on its own', () {
      final s = code(screen);
      expect(
          s,
          isNot(contains(RegExp(
              r'if \(code\.length == 6\) \{\s*\n\s*setState\(\(\) \{\s*\n\s*_storedOtpCode'))),
          reason: 'six digits typed is not a test of whether the code is right');
      expect(s, contains('_verifyThenAdvance(code)'),
          reason: 'the code must be checked before the step changes');
    });

    test('the step only changes after the server says yes', () {
      final s = code(screen);
      final i = s.indexOf('Future<void> _verifyThenAdvance(');
      expect(i, greaterThan(-1));
      final body = s.substring(i, (i + 1200).clamp(0, s.length));
      final check = body.indexOf('await _cubit.checkOtp(');
      final advance = body.indexOf('_currentStep = 3');
      expect(check, greaterThan(-1), reason: 'nothing checks the code');
      expect(advance, greaterThan(-1), reason: 'the advance moved');
      expect(check, lessThan(advance),
          reason: 'the advance must come AFTER the check, not beside it');
      expect(body, contains('if (!ok) {'),
          reason: 'a rejected code must stop the advance');
    });

    test('the operation type matches the one the code was issued for', () {
      // sendOTP uses 'reset'; the server looks up the active row by
      // (user, operation_type), so a mismatch finds nothing and every correct
      // code would be reported wrong.
      final s = code(screen);
      expect(s, contains("sendOTP(operationType: 'reset'"));
      expect(s, contains("checkOtp(otpCode: code, operationType: 'reset')"));
    });

    test('a re-entrant sixth digit cannot spend two attempts', () {
      // Autofill writes several fields and a paste rewrites them all, so
      // _onOtpChanged can fire more than once with a full code.
      final s = code(screen);
      expect(s, contains('bool _verifyingOtp = false;'));
      expect(s, contains('if (_verifyingOtp) return;'),
          reason: 'without a re-entry guard each duplicate fire costs the '
              "user one of their OTP attempts");
    });

    test('the user sees that something is happening', () {
      final s = code(screen);
      expect(s, contains("'Checking code...'"),
          reason: 'the check deliberately emits no Loading state, so the '
              'screen must show its own feedback or it sits silent');
    });
  });

  group('the check is safe to call', () {
    test('the cubit emits nothing on success', () {
      // Emitting Loading/Success would drive _handleStateChange and move the
      // step machine a second time.
      final s = code(cubit);
      final i = s.indexOf('Future<bool> checkOtp(');
      expect(i, greaterThan(-1));
      final body = s.substring(i, (i + 900).clamp(0, s.length));
      expect(body, contains('if (result.success) return true;'));
      expect(body, isNot(contains('emit(PinManagementSuccess')),
          reason: 'a success emit here would move the step twice');
      expect(body, contains('emit(PinManagementError('),
          reason: 'failures must reuse the existing error rendering, '
              'including the remaining-attempts count');
    });

    test('a transport failure does NOT advance', () {
      // This gate exists to stop a wrong code advancing; a network error must
      // not become an open door.
      final s = code(service);
      final i = s.indexOf('Future<PinOTPVerifyResult> checkPinOtp(');
      expect(i, greaterThan(-1));
      final body = s.substring(i, (i + 1600).clamp(0, s.length));
      expect(body, contains('success: false'),
          reason: 'the error paths must report failure, not throw past the '
              'caller or report success');
    });
  });
}
