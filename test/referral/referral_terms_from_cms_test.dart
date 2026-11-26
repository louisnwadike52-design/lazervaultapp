import 'package:flutter_test/flutter_test.dart';
import 'dart:io';

/// THE CONDITIONS A REFERRER READS MUST COME FROM THE CMS.
///
/// They used to be one hardcoded sentence about the tier, and it omitted the
/// other condition the allocator actually enforces — the referee must sign up
/// on a device no other account has used. A referrer reading only the tier
/// rule would believe a referral on a shared handset would pay, and it never
/// would.
///
/// A source test because what is being pinned is the ABSENCE of copy in the
/// app, which no runtime assertion can observe.
void main() {
  final card = File(
    'lib/src/features/referral/presentation/widgets/how_it_works_card.dart',
  );
  final flags = File('lib/core/config/feature_flags.dart');

  /// Strips comment lines before checking for banned copy.
  ///
  /// Without this the test fails on its own documentation: the comments here
  /// and in the widget EXPLAIN the condition wording, so a naive substring
  /// search finds it in prose that renders nothing.
  String code(File f) => f
      .readAsLinesSync()
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  test('the referral card renders CMS terms, not its own copy', () {
    final src = code(card);

    expect(src.contains('FeatureFlags.referralTerms()'), isTrue,
        reason: 'the card no longer reads the CMS conditions');

    // No condition sentence written into the widget.
    for (final banned in [
      'must reach Tier',
      'must sign up on a device',
      'before your bonus is paid',
    ]) {
      expect(src.contains(banned), isFalse,
          reason: 'condition copy "$banned" is hardcoded in the app again — '
              'it must come from feature_referral_terms_message');
    }
  });

  test('nothing configured renders nothing, never an invented condition', () {
    final src = card.readAsStringSync();
    expect(
        RegExp(r'terms\.isEmpty\)\s*(\{\s*)?return const SizedBox\.shrink\(\)')
            .hasMatch(src),
        isTrue,
        reason: 'an unset CMS value must render NOTHING — a wrong condition is '
            'worse than a missing one, because the referrer acts on it');
  });

  test('the tier shown is substituted from the enforced setting', () {
    final src = flags.readAsStringSync();
    expect(src.contains("replaceAll('{tier}'"), isTrue,
        reason: 'the {tier} placeholder is no longer substituted, so copy '
            'saying "Tier 3" could outlive a change to the gate');
    expect(src.contains('referralMinKycTier'), isTrue,
        reason: 'the substituted tier must come from the enforced setting, '
            'not a constant');
  });
}
