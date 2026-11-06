import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Two yellow lines appeared under the avatar initials during the
/// settings → My Account transition.
///
/// They are Flutter's debug text style. A Text with no DefaultTextStyle
/// ancestor falls back to red glyphs with a yellow DOUBLE underline, and a
/// style supplied by the widget is MERGED over that fallback — so colour,
/// size and weight were overridden while the decoration was inherited.
///
/// Normally a Material ancestor supplies a real DefaultTextStyle and none of
/// it shows. But this avatar is a Hero child, and for the length of the
/// flight the subtree is lifted into the overlay, away from any Material.
/// That is why it appeared only during the animation.
void main() {
  test('the avatar initials pin their decoration', () {
    final src =
        File('lib/src/features/widgets/user_avatar.dart').readAsStringSync();
    expect(
      src.contains('decoration: TextDecoration.none'),
      isTrue,
      reason: 'without it the Hero flight inherits the debug underline again',
    );
    // It must be on the initials style, not somewhere incidental.
    final at = src.indexOf('decoration: TextDecoration.none');
    final styleAt = src.lastIndexOf('GoogleFonts.inter(', at);
    expect(styleAt, greaterThan(-1),
        reason: 'the decoration must sit in the initials TextStyle');
    expect(at - styleAt, lessThan(400));
  });

  test('the avatar is still used as a Hero child somewhere', () {
    // If the Hero goes away the fix is harmless, but the reason for it should
    // stop being mysterious — this keeps the link visible.
    final settings = File(
            'lib/src/features/settings/presentation/view/settings_screen.dart')
        .readAsStringSync();
    expect(settings.contains('kProfileAvatarHeroTag'), isTrue);
  });
}
