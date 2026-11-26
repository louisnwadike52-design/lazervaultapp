import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/authentication/utils/login_identifier.dart';

/// "We cannot send a code to your phone right now. Please reset using your
/// email, or try again later" — shown over a field the customer had just typed
/// their EMAIL into, with an "@ Email" badge beside it.
///
/// The flow resolved every identifier down to the account's phone and only
/// ever published an SMS, so "reset using your email" named a route that did
/// not exist. The screen also offered USERNAME, which can receive nothing at
/// all, and said "we'll text a 6-digit code to the phone on your account" no
/// matter what was entered.
void main() {
  String read(String p) {
    final f = File(p);
    expect(f.existsSync(), isTrue, reason: '$p moved — repoint this test');
    return f.readAsStringSync();
  }

  String code(String src) => src
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  const screen =
      'lib/src/features/authentication/presentation/views/forgot_passcode_phone_screen.dart';
  const cubit =
      'lib/src/features/authentication/cubit/passcode_reset_cubit.dart';
  const repo =
      'lib/src/features/authentication/data/repositories/auth_repository.dart';
  const field = 'lib/src/features/widgets/smart_identifier_input.dart';

  group('the reset code goes where the user asked', () {
    test('there are exactly two channels, and a username is not one', () {
      expect(ResetDeliveryChannel.values,
          [ResetDeliveryChannel.phone, ResetDeliveryChannel.email],
          reason: 'a 6-digit code has to arrive somewhere that receives '
              'messages — a handle does not');
      expect(ResetDeliveryChannel.phone.wire, 'sms');
      expect(ResetDeliveryChannel.email.wire, 'email');
    });

    test('the server decides the channel and the app parses it back', () {
      // Unknown/empty must mean phone: that is what every build before this
      // one did, and an older backend sends nothing.
      expect(ResetDeliveryChannel.fromWire('email'), ResetDeliveryChannel.email);
      expect(ResetDeliveryChannel.fromWire('EMAIL'), ResetDeliveryChannel.email);
      expect(ResetDeliveryChannel.fromWire('sms'), ResetDeliveryChannel.phone);
      expect(ResetDeliveryChannel.fromWire(''), ResetDeliveryChannel.phone);
      expect(ResetDeliveryChannel.fromWire(null), ResetDeliveryChannel.phone);
    });

    test('the chosen channel reaches the wire', () {
      final src = code(read(repo));
      expect(src.contains('deliveryChannel: deliveryChannel'), isTrue,
          reason: 'the request no longer carries the channel, so the backend '
              'is back to inferring it for every caller');
      expect(src.contains('deliveryChannel: response.deliveryChannel'), isTrue,
          reason: 'the channel the server ACTUALLY used is dropped, so the '
              'verification screen cannot name where the code went');
    });

    test('the screen sends a channel, not just an identifier', () {
      final src = code(read(screen));
      expect(src.contains('channel: _channel'), isTrue,
          reason: 'requestReset is back to identifier-only');
      expect(src.contains('ResetDeliveryChannel.email'), isTrue);
    });

    test('the channel is a VISIBLE control, not only a detection', () {
      final src = code(read(screen));
      expect(src.contains('_buildChannelSelector'), isTrue,
          reason: 'the number is prefilled from secure storage on almost every '
              'visit, so without chips on screen nothing tells the user an '
              'email is even possible');
      expect(src.contains("'Use my phone'"), isTrue);
      expect(src.contains("'Use my email'"), isTrue);
    });

    test('typing an email moves the selector to Email', () {
      final src = code(read(screen));
      expect(src.contains('final detectedChannel = type == LoginIdentifierType.email'),
          isTrue,
          reason: 'pasting an address into phone mode is a clear instruction; '
              'requiring a second tap for it to be honoured is the gap that '
              'produced an SMS attempt for an email');
    });

    test('username is gone from the reset field', () {
      final src = code(read(screen));
      expect(src.contains('allowUsername: false'), isTrue,
          reason: 'the field offers a third kind the flow cannot deliver to');
      expect(src.contains('LoginIdentifierType.username'), isFalse,
          reason: 'a username branch is back in the reset screen');
      expect(src.contains('isUsernameIdentifier'), isFalse,
          reason: 'the username validation is back');
    });

    test('a username-less field reads letters as an email, like signup', () {
      final src = code(read(field));
      expect(src.contains('!widget.allowUsername &&'), isTrue,
          reason: 'without the collapse, letters flicker through a Username '
              'badge on the way to becoming an email');
      // Login still accepts all three — the flag must default to permissive.
      expect(src.contains('this.allowUsername = true'), isTrue,
          reason: 'restricting the shared field by default would break login');
    });

    test('phone validation stays per-country', () {
      final src = code(read(screen));
      expect(src.contains('country.validateNationalNumber(nsn)'), isTrue,
          reason: 'the locale-aware length/prefix rules are the same ones '
              'signup validates against — a generic digit check is not them');
    });

    test('the copy names the real destination', () {
      final src = code(read(screen));
      expect(
          src.contains(
              "'Enter the 6-digit code we sent to \$destination.'"),
          isTrue,
          reason: 'the OTP step told every user to check their phone');
      expect(src.contains('the phone on your account to confirm'), isFalse,
          reason: 'the phone-only subtitle is back');
      expect(src.contains('showSmsDndHelp: _isPhoneIdentifier'), isTrue,
          reason: 'the DND help is about SMS routing and means nothing on an '
              'emailed code — it sends the user to a phone setting to look '
              'for something in their inbox');
    });

    test('a resend does not silently change channel', () {
      final src = code(read(cubit));
      expect(src.contains('channel: _channel'), isTrue,
          reason: 'resendOtp dropping the channel would text a user who chose '
              'email, after the first code reached them correctly');
    });
  });
}
