import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Phone banking is authorised by the transaction PIN already in the user's
/// profile, not by a second phone-only secret.
///
/// The separate PIN was a worse credential than the one beside it. Used rarely,
/// so it is the one people forget — and a forgotten PIN on a call cannot be
/// recovered mid-call, it just ends the conversation. It had to exist before the
/// channel was any use, an extra step in front of a feature most people try
/// once. And a user who changed their transaction PIN after losing their phone
/// reasonably believed they had locked everything down, while the phone channel
/// kept honouring a PIN they last thought about months ago.
///
/// The server resolves telephony to the app PIN and refuses to create a phone
/// one, so the UI must not offer it — a control that creates a credential the
/// channel never reads is worse than no control, because it looks like the thing
/// guarding money on a call.
void main() {
  String read(String path) {
    final f = File(path);
    expect(f.existsSync(), isTrue, reason: '$path moved — update this test');
    return f.readAsStringSync();
  }

  group('the phone banking screen', () {
    late String source;

    setUpAll(() {
      source = read('lib/src/features/channel_management/presentation/'
          'screens/phone_banking_channel_screen.dart');
    });

    test('offers no phone-specific PIN', () {
      expect(source, isNot(contains('Create phone PIN')));
      expect(source, isNot(contains('Change phone PIN')));
      expect(source, isNot(contains('ChannelPinSetupScreen')),
          reason: 'the server refuses to create a telephony PIN, so a control '
              'that tries would fail on submit');
    });

    test('says which PIN actually authorises a call', () {
      expect(source, contains('transaction PIN'));
      expect(source, isNot(contains('separate from your app PIN')),
          reason: 'that was the old model and is now false');
    });

    test('the only action offered is setting the real transaction PIN', () {
      expect(source, contains('AppRoutes.transactionPinSetup'));
      expect(source, contains('Set up your transaction PIN'));
    });
  });

  group('the activation flow', () {
    late String source;

    setUpAll(() {
      source = read('lib/src/features/channel_management/presentation/'
          'screens/channel_activation_screen.dart');
    });

    test('sends telephony to the transaction PIN, not a channel PIN', () {
      // Without this the flow pushes a phone-PIN screen that fails on submit,
      // immediately after telling the user their line was verified.
      // Anchored on the BRANCH, not the bare comparison — line 34 has a
      // getter using the same expression, and matching that would test nothing.
      final idx =
          source.indexOf("} else if (widget.channelType == 'telephony') {");
      expect(idx, greaterThan(-1),
          reason: 'telephony needs its own branch after OTP verification');
      expect(source.substring(idx, idx + 1400),
          contains('AppRoutes.transactionPinSetup'));
    });

    test('a channel that DOES keep its own PIN still reaches the setup screen',
        () {
      // WhatsApp is deliberately unchanged; this must not have been removed
      // along with the telephony path.
      expect(source, contains('ChannelPinSetupScreen'));
    });
  });
}
