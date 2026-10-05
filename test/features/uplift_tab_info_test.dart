import 'package:flutter_test/flutter_test.dart';
import 'dart:io';

// The per-tab explainer was a FIRST-RUN card: dismiss it, or turn the set off,
// and the copy became unreachable. The moment someone wants to know what "My
// Funds" means is rarely the first second they land on it.
//
// The header's existing "?" opens the whole-feature guide sheet, which is a
// different thing — it does not answer "what is THIS tab".
void main() {
  String codeOf(String p) => File(p)
      .readAsStringSync()
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
      .join('\n');

  const card =
      'lib/src/features/uplift/presentation/widgets/uplift_guide_card.dart';
  const home =
      'lib/src/features/uplift/presentation/views/uplift_home_screen.dart';

  group('per-tab info stays reachable', () {
    test('dismissing the card leaves an info link, not nothing', () {
      final code = codeOf(home);
      expect(code, contains('UpliftTabInfoLink(tabId: tab)'),
          reason: 'a dismissed guide used to return SizedBox.shrink(), making '
              'the copy unreachable for good');
      expect(code, isNot(contains('if (_showGuide[tab] != true) return const SizedBox.shrink();')),
          reason: 'the vanishing branch is the bug');
    });

    test('the dialog exists and takes focus', () {
      final code = codeOf(card);
      expect(code, contains('Future<void> showUpliftTabInfo('));
      expect(code, contains('showDialog<void>'),
          reason: 'an explainer the user ASKED for should take focus; one that '
              'appears on its own must not');
    });

    test('dialog and banner share ONE copy source', () {
      // Two copies of the words drift, and then the banner and the dialog
      // describe the same tab differently.
      final code = codeOf(card);
      expect(code, contains('UpliftGuideCopy.byTab[tabId]'));
      // The dialog must not hardcode any tab wording of its own.
      for (final phrase in [
        'Businesses raising funds',
        'Money you have committed',
        'Funding you have asked for',
      ]) {
        expect(RegExp(RegExp.escape(phrase)).allMatches(code).length, 1,
            reason: '"$phrase" appears more than once — the dialog is '
                'duplicating the card copy instead of reading it');
      }
    });

    test('every tab the card covers is reachable from the dialog', () {
      final code = codeOf(card);
      for (final t in ['tabDiscover', 'tabMyFunds', 'tabMyApplications']) {
        expect(code, contains('UpliftGuidePreference.$t'),
            reason: '$t has no copy, so its info link would render nothing');
      }
    });

    test('an unknown tab renders nothing rather than an empty dialog', () {
      final code = codeOf(card);
      expect(code, contains('if (copy == null) return const SizedBox.shrink();'));
      expect(code, contains('if (copy == null) return Future<void>.value();'));
    });

    test('the comment strip actually strips (self-check)', () {
      const commented = '// UpliftTabInfoLink(tabId: tab)\n  final x = 1;\n';
      final stripped = commented
          .split('\n')
          .where((l) => !l.trimLeft().startsWith('//'))
          .join('\n');
      expect(stripped, isNot(contains('UpliftTabInfoLink')));
      expect(stripped, contains('final x = 1;'));
    });
  });
}
