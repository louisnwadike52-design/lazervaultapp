import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/settings/presentation/view/settings_search_vocabulary.dart';

/// Settings search filters in TWO stages, and the first one was hiding the
/// second.
///
/// `_SectionSpec.matches` decides whether a SECTION renders at all; only then
/// does `_filterableColumn` filter the tiles inside it. So a tile could
/// declare perfectly good keywords and still be unreachable, because its
/// section's hand-written keyword list had never been told about it.
///
/// That is what had happened to Customize. Dashboard Layout, Adaptive quick
/// services, Deposit balance tips, Lazerfunds guides, Voice tips and Payment
/// reminders each carried sensible keywords, and typing "dashboard" into the
/// settings search bar returned **no results at all** — the section was
/// filtered out one stage earlier and the tile filter never ran.
///
/// These assertions run against the REAL lists the screen uses, which is why
/// the vocabulary lives in its own library rather than as a private class
/// inside the `part of` file.
void main() {
  /// The haystack the Customize section is matched on: its title plus the
  /// composed keyword list. Mirrors `_SectionSpec.matches`, which passes
  /// `[title, subtitle, ...keywords]`.
  bool customizeFinds(String query) => settingsQueryMatches(
        query,
        ['Customize', '', ...SettingsSearchVocabulary.customize],
      );

  group('every customization tile is reachable from the search bar', () {
    // One realistic query per tile — the word somebody actually types.
    const perTile = <String, String>{
      'Dashboard Layout': 'dashboard',
      'Dashboard Layout (two words)': 'dashboard layout',
      'Adaptive quick services': 'adaptive',
      'Adaptive quick services (phrase)': 'quick services',
      'Deposit balance tips': 'deposit tips',
      'Lazerfunds guides': 'lazerfunds',
      'Voice tips': 'voice tips',
      'Payment reminders on launch': 'payment reminders',
      'Send Funds': 'transfer style',
      'Login Method': 'login method',
    };

    perTile.forEach((tile, query) {
      test('"$query" reveals $tile', () {
        expect(customizeFinds(query), isTrue,
            reason: 'the Customize section is filtered out before the tile '
                'filter runs, so "$query" would return nothing at all');
      });
    });
  });

  group('the composition is what makes that true', () {
    test('every tile list is actually folded into the section list', () {
      // The guard above could be satisfied by retyping the words beside the
      // section — which is the drift that caused this. These assert the
      // COMPOSITION, so adding a keyword to a tile adds it to its section in
      // the same edit.
      const tileLists = <String, List<String>>{
        'sendFunds': SettingsSearchVocabulary.sendFunds,
        'loginMethod': SettingsSearchVocabulary.loginMethod,
        'dashboardLayout': SettingsSearchVocabulary.dashboardLayout,
        'adaptiveServices': SettingsSearchVocabulary.adaptiveServices,
        'depositTips': SettingsSearchVocabulary.depositTips,
        'lazerfundsGuides': SettingsSearchVocabulary.lazerfundsGuides,
        'voiceTips': SettingsSearchVocabulary.voiceTips,
        'pendingPrompt': SettingsSearchVocabulary.pendingPrompt,
      };
      final section = SettingsSearchVocabulary.customize.toSet();
      tileLists.forEach((name, terms) {
        for (final t in terms) {
          expect(section, contains(t),
              reason: '"$t" is on the $name tile but not in the section list, '
                  'so searching it would hide the tile that owns it');
        }
      });
    });

    test('no tile list is empty', () {
      // An empty list would satisfy the superset check vacuously.
      for (final l in [
        SettingsSearchVocabulary.dashboardLayout,
        SettingsSearchVocabulary.adaptiveServices,
        SettingsSearchVocabulary.depositTips,
        SettingsSearchVocabulary.lazerfundsGuides,
        SettingsSearchVocabulary.voiceTips,
        SettingsSearchVocabulary.pendingPrompt,
      ]) {
        expect(l, isNotEmpty);
      }
    });
  });

  group('the matcher itself', () {
    test('an empty query matches everything — the unfiltered screen', () {
      expect(settingsQueryMatches('', const ['anything']), isTrue);
      expect(settingsQueryMatches('   ', const ['anything']), isTrue);
    });

    test('every token must appear, in any order', () {
      const hay = ['Dashboard Layout', 'showcase classic'];
      expect(settingsQueryMatches('layout dashboard', hay), isTrue,
          reason: 'word order must not matter');
      expect(settingsQueryMatches('dashboard showcase', hay), isTrue,
          reason: 'tokens may come from different parts of the haystack');
      expect(settingsQueryMatches('dashboard crypto', hay), isFalse,
          reason: 'a token that matches nothing must fail the whole query');
    });

    test('partial words match, because people type as they think', () {
      expect(settingsQueryMatches('dash', const ['dashboard']), isTrue);
      expect(settingsQueryMatches('adapt', const ['adaptive']), isTrue);
    });

    test('case and padding do not matter', () {
      expect(settingsQueryMatches('  DASHBOARD  ', const ['dashboard']), isTrue);
    });

    test('an unrelated query still finds nothing', () {
      // The fix must not have been "match everything".
      expect(customizeFinds('bvn'), isFalse);
      expect(customizeFinds('airtime'), isFalse);
      expect(customizeFinds('crypto'), isFalse);
    });
  });
}
