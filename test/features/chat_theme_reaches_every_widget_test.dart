import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Picking a chat theme recoloured the header gradient and the user's text
/// bubbles, and nothing else. Everything else in the chat referenced a FIXED
/// palette constant, so choosing "Teal" produced a teal header over a purple
/// chat — which reads as a rendering bug, not a theme, and is what was
/// reported.
///
/// The casualties, by name:
///   * `ai_chat_content.dart` — 31 × `InvoiceThemeColors.primaryPurple` and
///     4 × `gradientPurple`: icons, suggestion chips, avatars, the attach and
///     send buttons, selection highlights, empty-state art, the slider track.
///   * `chat_media_bubble.dart` — the voice-note player was a hardcoded blue
///     for the sender and green for the receiver, independent of the theme
///     entirely. The most visible miss, since a voice note is a large block
///     of colour.
///   * `general_chat_content.dart` — NOVA used its own hardcoded violet, so
///     the same assistant was two different colours depending on which screen
///     you opened it from.
///
/// This test fails if any of them comes back. It greps rather than renders
/// because the defect is "which colour constant is referenced", which is a
/// property of the source, and because pumping these screens needs the whole
/// DI graph.
void main() {
  String read(String p) {
    final f = File(p);
    expect(f.existsSync(), isTrue,
        reason: '$p moved — repoint this test rather than deleting it, or the '
            'theme can silently stop reaching that surface again');
    return f.readAsStringSync();
  }

  /// Strips `//` comments so the explanations above a fix — which legitimately
  /// name the old constants — cannot fail the test that enforces it.
  String code(String src) => src
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  group('the AI chat paints from the accent, not a fixed palette', () {
    const path =
        'lib/src/features/ai_chats/presentation/widgets/ai_chat_content.dart';

    test('no fixed brand purple remains', () {
      final src = code(read(path));
      for (final fixed in [
        'InvoiceThemeColors.primaryPurple',
        'InvoiceThemeColors.gradientPurple',
      ]) {
        expect(src.contains(fixed), isFalse,
            reason: '$fixed is back in $path. It does not follow the user\'s '
                'chosen accent, so whatever it paints will stay purple when '
                'they pick another theme.');
      }
    });

    test('and it actually reads the accent, in many places', () {
      final src = code(read(path));
      final uses = '_accent.'.allMatches(src).length;
      expect(uses, greaterThan(25),
          reason: 'only $uses accent references — the replacement was partly '
              'reverted, or the colours were re-hardcoded as hex literals');
      expect(src.contains('ChatAccent get _accent'), isTrue,
          reason: 'the accent getter is gone');
      // The listener is what makes a theme change land without reopening the
      // screen; without it the user picks a colour and nothing happens.
      expect(src.contains('ChatThemePreference.revision'), isTrue,
          reason: 'nothing rebuilds the chat when the accent changes');
    });
  });

  test('the voice-note bubble follows the accent', () {
    const path =
        'lib/src/features/microservice_chat/presentation/widgets/chat_media_bubble.dart';
    final src = code(read(path));
    // The exact two literals it used to hold.
    expect(src.contains('0xFF3B82F6'), isFalse,
        reason: 'the sender voice note is back on a hardcoded blue');
    expect(src.contains('0xFF10B981'), isFalse,
        reason: 'the receiver voice note is back on a hardcoded green');
    expect(src.contains('ChatThemePreference.accent'), isTrue,
        reason: 'the voice-note player no longer reads the chat accent');
    // Sender and receiver must stay DISTINGUISHABLE. Collapsing both onto one
    // colour would pass the checks above while making your own voice note
    // indistinguishable from the assistant's.
    expect(src.contains('accent.primary'), isTrue);
    expect(src.contains('accent.secondary'), isTrue,
        reason: 'sender and receiver must still differ — one accent colour '
            'for both loses the distinction the blue/green pair had');
  });

  test('the recipient card and candidate list follow the accent', () {
    // Found by sweeping EVERY chat surface after the first pass, not by
    // reading the diff: these two sit in the thread and were the last
    // coloured things in it still on a fixed brand purple. The candidate
    // list had inherited the same constant from the card it lives beside.
    const path =
        'lib/src/features/microservice_chat/presentation/widgets/chat_recipient_card.dart';
    final src = code(read(path));
    expect(src.contains('0xFF4E03D0'), isFalse,
        reason: 'the recipient card is back on a fixed brand purple while the '
            'thread around it follows the user\'s accent');
    expect(src.contains('ChatThemePreference.accent.primary'), isTrue);
    // Verified is a STATUS, not branding. It must stay fixed: a teal chat
    // reporting verification in teal reads as a different state.
    expect(src.contains('0xFF10B981'), isTrue,
        reason: 'the verified badge should NOT follow the theme');
  });

  test('NOVA shares the accent rather than its own violet', () {
    const path =
        'lib/src/features/microservice_chat/presentation/widgets/general_chat_content.dart';
    final src = code(read(path));
    expect(src.contains('0xFF7C3AED'), isFalse,
        reason: 'NOVA is back on its own hardcoded violet, so the same '
            'assistant is two colours depending on the surface');
    expect(src.contains('ChatThemePreference.accent'), isTrue);
  });

  group('input area spacing', () {
    const path =
        'lib/src/features/ai_chats/presentation/widgets/ai_chat_content.dart';

    test('the lift clears the obstruction by an explicit gap', () {
      final src = code(read(path));
      // Both gaps were previously zero: the margin resolved to exactly the
      // keyboard height, or exactly the nav clearance, leaving the input bar
      // flush against each.
      expect(src.contains('_kKeyboardGap'), isTrue,
          reason: 'the keyboard gap constant is gone — the input bar will sit '
              'flush on the top key row again');
      expect(src.contains('_kBottomNavGap'), isTrue,
          reason: 'the bottom-nav gap constant is gone — this is the reported '
              'Android defect, the input stuck to the nav bar');
      expect(src.contains('keyboardInset + _kKeyboardGap'), isTrue);
      expect(src.contains('72.h + _kBottomNavGap'), isTrue,
          reason: 'the nav clearance itself (72.h) was correct; only the gap '
              'was missing. Keep both.');
    });

    test('suggestion chips are a short row, not a band', () {
      final src = code(read(path));
      expect(src.contains('height: 40.h,\n              margin'), isFalse,
          reason: 'the 40.h suggestion strip is back; with its margin that was '
              '52.h above the input on every phone');
      expect(src.contains('height: 30.h'), isTrue,
          reason: 'the trimmed suggestion row height is gone');
    });
  });
}
