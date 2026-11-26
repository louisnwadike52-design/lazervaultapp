import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE BACK ARROW, THE TITLE AND THE ACTIONS WERE ALL INVISIBLE HERE.
///
/// Every ticketing screen sets a dark `backgroundColor` on its AppBar and
/// nothing else, so the foreground came from the ACTIVE APP THEME — and the
/// light theme's appBarTheme sets no foregroundColor, leaving Material's
/// default `onSurface`: near-black, on a near-black bar.
///
/// The titles compound it: they are `GoogleFonts.inter(fontSize:…,
/// fontWeight:…)` with no colour, so they inherit the same default. The
/// screens looked right in dark mode and vanished in light mode, which is why
/// it was reported as "the back buttons are not visible, and for most items,
/// they are not visible" rather than as one missing property.
///
/// A per-screen property is a property somebody forgets on screen ten, so this
/// checks all of them.
void main() {
  final dir = Directory('lib/src/features/ticketing/presentation/screens');
  final screens = dir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  _cardEdgeGuards();

  test('there are ticketing screens to check', () {
    expect(screens, isNotEmpty,
        reason: 'the screens moved — this guard needs its path updated, '
            'otherwise it passes by checking nothing');
  });

  for (final f in screens) {
    final name = f.path.split('/').last;
    test('$name gives its AppBar a visible foreground', () {
      final src = f.readAsStringSync();
      if (!src.contains('AppBar(')) return; // no bar, nothing to colour

      expect(src.contains('foregroundColor'), isTrue,
          reason: 'without it the leading arrow, the title and every action '
              'icon take the light theme\'s near-black default and disappear '
              'against this feature\'s dark ground');
    });

    // THE SAME INHERITANCE, ON A DIFFERENT CONTROL.
    //
    // A FloatingActionButton with a backgroundColor and no foregroundColor
    // takes its label and icon colour from the THEME, so the ticketing CTAs
    // rendered the light theme's dark foreground on a filled purple button.
    // A filled control has to state both halves of its own contrast.
    test('$name gives any filled FAB an explicit foreground', () {
      final src = f.readAsStringSync();
      if (!src.contains('FloatingActionButton')) return;
      expect(src.contains('foregroundColor'), isTrue,
          reason: 'the FAB sets a backgroundColor but lets its label and icon '
              'inherit — the same way the app bars disappeared');
    });

    test('$name does not paint pure black', () {
      final src = f.readAsStringSync();
      expect(src.contains('backgroundColor: Colors.black'), isFalse,
          reason: 'every other flow uses the shared 0A0A0A ground; a #000 '
              'screen reads as a different app the moment you arrive from one '
              'that does not');
    });
  }
}

/// CARDS NEED AN EDGE ON THIS GROUND.
///
/// The feature paints #1F1F1F cards on a #0A0A0A page. That is a small step in
/// luminance, and every pay-flow and vendor card in the app draws a
/// PayFlowTheme.border edge for exactly that reason — without one the cards
/// read as vague blocks rather than tiles, which is what "the screens are not
/// tiled to the theme" was describing.
///
/// Ticketing defined the border token and used it only for dividers: thirteen
/// card-coloured containers, two edges between them.
void _cardEdgeGuards() {
  test('every ticketing card carries the theme edge', () {
    final dir = Directory('lib/src/features/ticketing/presentation');
    final offenders = <String>[];

    for (final f in dir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))) {
      final src = f.readAsStringSync();
      // A CARD is the card colour plus a fully-rounded radius. A sheet
      // (BorderRadius.vertical) is excluded on purpose: it sits against a
      // dimmed scrim, where an edge would be a seam rather than a definition.
      final re = RegExp(
        r'color:\s*TicketingTheme\.card,\s*\n\s*borderRadius:\s*BorderRadius\.circular\([^)]*\),\s*\n(?!\s*(//|border:))',
      );
      if (re.hasMatch(src)) offenders.add(f.path.split('/').last);
    }

    expect(offenders, isEmpty,
        reason: 'these draw a card with no edge, so on the near-black ground '
            'they read as vague blocks instead of tiles: $offenders');
  });
}
