import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE ACCOUNT IS ALREADY KNOWN — DON'T MAKE THEM RETYPE IT.
///
/// Both recovery screens asked for an identifier this device already had.
/// Passcode reset prefilled the PHONE only — the Email chip handed the user an
/// empty box, so the one channel they switched to deliberately was the one
/// that could not be prefilled. Password recovery prefilled NEITHER tab.
///
/// Every retype is also a chance to typo into somebody else's account and send
/// THEM a reset, which is why the field is locked once it holds the remembered
/// account.
void main() {
  String read(String p) => File(p).readAsStringSync();

  group('passcode reset', () {
    late final String src;
    setUpAll(() => src = read(
        'lib/src/features/authentication/presentation/views/forgot_passcode_phone_screen.dart'));

    test('prefills EMAIL as well as phone', () {
      expect(src.contains("read(key: 'stored_email')"), isTrue,
          reason: 'it only ever read stored_phone');
      expect(src.contains('_prefilledEmail'), isTrue);
    });

    test('switching channel restores that channel\'s prefill', () {
      expect(src.contains('_identifier = _prefilledEmail'), isTrue,
          reason: 'Email used to start empty even when the device knew it');
      expect(src.contains('_identifier = _prefilledPhoneE164'), isTrue,
          reason: 'switching back must restore the E.164 the cubit sends, '
              'not just the digits the field shows');
    });

    test('the field is locked while it holds the remembered account', () {
      expect(src.contains('readOnly: _identityLocked'), isTrue);
    });
  });

  group('password recovery', () {
    late final String src;
    setUpAll(
        () => src = read('lib/src/features/widgets/password_recovery.dart'));

    test('prefills both tabs — it prefilled neither', () {
      expect(src.contains("read(key: 'stored_email')"), isTrue);
      expect(src.contains("read(key: 'stored_phone')"), isTrue);
      expect(src.contains('controller: _emailController'), isTrue);
      expect(src.contains('controller: _phoneController'), isTrue);
    });

    test('both fields lock together', () {
      expect(RegExp(r'readOnly: _identityLocked').allMatches(src).length, 2);
    });

    test('a storage failure costs the prefill, never the screen', () {
      expect(src.contains('} catch (_) {'), isTrue,
          reason: 'the user must still be able to type their address');
    });
  });

  group('locking without an escape is a LOCKOUT', () {
    // The prefill comes from this device's stored identity, which can belong
    // to a different person (shared or second-hand handset) or to nobody.
    // Recovery is the last path a user has.
    for (final f in const {
      'passcode reset':
          'lib/src/features/authentication/presentation/views/forgot_passcode_phone_screen.dart',
      'password recovery': 'lib/src/features/widgets/password_recovery.dart',
    }.entries) {
      test('${f.key} offers "Not you?"', () {
        final src = read(f.value);
        expect(src.contains('Not you? Use a different account'), isTrue,
            reason: 'without this, a handset remembering someone else can '
                'never recover its actual owner\'s account');
        expect(src.contains('_identityLocked = false'), isTrue,
            reason: 'the escape must actually unlock the field');
      });

      test('${f.key} hides the escape once unlocked', () {
        final src = read(f.value);
        expect(src.contains('if (!_identityLocked) return const SizedBox.shrink();'),
            isTrue,
            reason: 'it has done its job — leaving it invites a change nobody '
                'needed');
      });
    }
  });
}
