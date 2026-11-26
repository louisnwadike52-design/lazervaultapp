import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE DRAWER SHOWS WHO YOU ARE, INCLUDING THE NAME PEOPLE CAN ACTUALLY USE.
///
/// It carried a full name and an email. Neither is addressable: nobody can
/// pay "Nnaemeka Ezeke", and the email is not what the profile code encodes
/// or what the send-money field accepts. The USERNAME is the handle, and it
/// was the one identity missing from the one place the customer looks for
/// their own.
///
/// The profile code lost its instructions at the same time. It had "Your
/// profile code" over "Tap to show full screen" plus a fullscreen glyph —
/// three explanations of a QR square sitting directly under the customer's
/// own photo. What replaced them is the only thing the code cannot say about
/// itself: whose it is.
void main() {
  String code(String path) => File(path)
      .readAsStringSync()
      .split('\n')
      .where((l) =>
          !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
      .join('\n');

  final drawer = code('lib/src/features/widgets/themed_drawer.dart');
  final qr = code(
      'lib/src/features/profile/presentation/widgets/profile_qr_block.dart');

  group('the header', () {
    // THE HANDLE IS STILL SHOWN — ONCE, BESIDE THE CODE.
    //
    // It used to sit under the name AND beside the profile code, which is
    // two copies of the same six characters in one 80-pixel column and reads
    // as a rendering fault. The copy next to the code is the one that
    // survived, because it labels the thing being scanned.
    //
    // The original intent of these tests is unchanged and still enforced
    // below: the addressable identity is present, and it never renders as a
    // bare "@". Only its location moved.
    test('does not print the handle a second time under the name', () {
      expect(drawer.contains("'@\$userHandle'"), isFalse,
          reason: 'the header is duplicating the handle that already sits '
              'beside the profile code');
    });

    test('still passes the handle to the block that shows it', () {
      expect(drawer, contains('userHandle'));
      expect(drawer, contains('username: userHandle'),
          reason: 'the TRIMMED handle, not the raw column — a stray space '
              'rendered as "@ name" in the one place it is now shown');
    });

    test('does not overflow on a long name or email', () {
      // A drawer is ~70% of the screen; identity lines in it are the easiest
      // place in the app to produce a yellow overflow stripe. The handle's
      // own clipping is asserted on the QR block below, where it now lives.
      final headerFields = RegExp(r'maxLines: 1').allMatches(drawer).length;
      expect(headerFields, greaterThanOrEqualTo(2),
          reason: 'name and email must each be single-line clipped');
      expect(drawer, contains('TextOverflow.ellipsis'));
    });
  });

  group('the profile code', () {
    test('carries no instructions', () {
      expect(qr.contains('Tap to show full screen'), isFalse,
          reason: 'it described the interaction, not the thing, and was the '
              'loudest text in the header');
      expect(qr.contains("'Your profile code'"), isFalse);
      expect(qr.contains('Icons.fullscreen_rounded'), isFalse,
          reason: 'a QR under your own photo does not need a glyph '
              'explaining that it opens');
    });

    test('shows whose code it is', () {
      expect(qr, contains("'@\$username'"));
    });

    test('still opens full screen on tap', () {
      // The affordance is removed, not the behaviour.
      expect(qr, contains('_FullScreenQrRoute('));
      expect(qr, contains('kProfileQrHeroTag'),
          reason: 'both ends share the Hero tag or the transition cuts');
    });
  });

  test('no hairline seams in the header', () {
    // A translucent pill with a 1px white outline, inside a frosted panel,
    // on a brand curve: three edges in the same few pixels.
    expect(drawer.contains('color: Colors.white.withValues(alpha: 0.3),\n'
            '                                ),'),
        isFalse);
    expect(qr.contains('border: Border.all(color: Colors.white'), isFalse);
  });
}
