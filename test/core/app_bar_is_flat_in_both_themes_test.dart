import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// "Why did the entire app elevation increase?"
///
/// Material 3 defaults an AppBar to `scrolledUnderElevation: 3` plus a
/// surfaceTint overlay. The LIGHT theme set neither value, so every app bar in
/// the app lifted and tinted as soon as content scrolled under it. The dark
/// theme set `elevation: 0` and so never showed it — which is what made an
/// always-asymmetric theme read as a sudden regression.
///
/// `elevation` and `scrolledUnderElevation` are INDEPENDENT in M3: setting the
/// first does not suppress the second, which is why the dark theme was relying
/// on its near-black surface to hide the tint rather than turning it off.
///
/// ASSERTED AGAINST THE SOURCE, not by building the ThemeData. AppTheme's text
/// theme comes from GoogleFonts, which in a unit test either reaches the
/// network or throws `allowRuntimeFetching is false but font Roboto-Regular
/// was not found` — so merely touching `AppTheme.light` fails for reasons that
/// have nothing to do with elevation. The values live in a const block; the
/// file is the honest thing to read.
void main() {
  const path = 'lib/core/theme/app_theme.dart';

  String read() {
    final f = File(path);
    expect(f.existsSync(), isTrue, reason: '$path moved — repoint this test');
    return f.readAsStringSync();
  }

  /// The body of one `appBarTheme: const AppBarTheme( … )` block.
  List<String> appBarThemeBlocks(String src) {
    const marker = 'appBarTheme: const AppBarTheme(';
    final out = <String>[];
    var i = src.indexOf(marker);
    while (i >= 0) {
      var depth = 0;
      final start = i + marker.length - 1; // at the '('
      for (var j = start; j < src.length; j++) {
        if (src[j] == '(') depth++;
        if (src[j] == ')') {
          depth--;
          if (depth == 0) {
            out.add(src.substring(start, j));
            break;
          }
        }
      }
      i = src.indexOf(marker, i + marker.length);
    }
    return out;
  }

  test('both themes declare a flat app bar', () {
    final blocks = appBarThemeBlocks(read());
    expect(blocks.length, 2,
        reason: 'expected one AppBarTheme for light and one for dark — if the '
            'shape changed, repoint this test rather than deleting it');

    for (var i = 0; i < blocks.length; i++) {
      final which = i == 0 ? 'light' : 'dark';
      expect(blocks[i].contains('elevation: 0'), isTrue,
          reason: '$which app bars render a resting shadow');
      expect(blocks[i].contains('scrolledUnderElevation: 0'), isTrue,
          reason: 'M3 defaults scrolledUnderElevation to 3 — unset, every app '
              'bar in the $which theme lifts and tints the moment content '
              'scrolls under it. It is INDEPENDENT of `elevation`.');
    }
  });

  test('both themes are on Material 3, so the default would otherwise apply', () {
    // If this ever goes false the assertions above stop guarding anything,
    // because the M3 scroll-under behaviour is what they exist to pin.
    expect('useMaterial3: true'.allMatches(read()).length, 2);
  });
}
