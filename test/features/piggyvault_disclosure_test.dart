import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// THE DISCLOSURE ALWAYS SHOWS; THE ATTRIBUTION IS THE OPERATOR'S.
///
/// Those two halves have opposite defaults on purpose, and a refactor that
/// treats them as one setting breaks whichever half it merges into.
///
///  * The CTA and its URL are a COMPLIANCE surface — they must never be able
///    to disappear because a field was left blank.
///  * The line "Piggyvault is powered by Swiftlynx." was compiled in. Who
///    provides a product is a commercial fact that changes without a release,
///    so it is operator text and ships EMPTY (operator decision 2026-11-24).
void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.init();
  });

  test('the attribution is empty until an operator writes one', () async {
    expect(FeatureFlags.piggyvaultProviderText, isEmpty,
        reason: 'unset means "say nothing", not "say what we used to say"');

    await FeatureFlags.applyRemoteSnapshot(
        {'piggyvault_provider_text': 'Piggyvault is provided by Acme.'});
    expect(
        FeatureFlags.piggyvaultProviderText, 'Piggyvault is provided by Acme.');
  });

  test('the disclosure URL is never empty', () async {
    expect(FeatureFlags.piggyvaultDisclosureUrl, isNotEmpty,
        reason: 'the CTA must always have somewhere to go');
    await FeatureFlags.applyRemoteSnapshot({'piggyvault_disclosure_url': '  '});
    expect(FeatureFlags.piggyvaultDisclosureUrl, isNotEmpty,
        reason: 'a blank setting must fall back, never blank the CTA');
  });

  group('the footer and the sheet', () {
    final footer = File(
            'lib/src/features/lock_funds/presentation/widgets/piggyvault_disclosure_footer.dart')
        .readAsStringSync();
    final sheet =
        File('lib/core/widgets/partner_disclosure_sheet.dart').readAsStringSync();

    test('no partner name is compiled into the app any more', () {
      final code = footer
          .split('\n')
          .where((l) => !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
          .join('\n');
      expect(code.toLowerCase().contains('swiftlynx'), isFalse,
          reason: 'the attribution comes from piggyvault_provider_text');
    });

    test('the line is omitted entirely when unset, spacing included', () {
      expect(footer, contains('piggyvaultProviderText.isNotEmpty'));
      // A collection-if over BOTH the Text and its SizedBox — otherwise the
      // gap stays behind and the CTA sits oddly low.
      expect(footer, contains('isNotEmpty) ...['));
    });

    test('the CTA renders unconditionally', () {
      // Comments stripped first: the doc comment above the class names the
      // sheet helper, so an index comparison over the raw file compares
      // prose, not code.
      final code = footer
          .split('\n')
          .where((l) =>
              !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
          .join('\n');
      final guardAt = code.indexOf('piggyvaultProviderText.isNotEmpty');
      final guardEnd = code.indexOf('],', guardAt);
      final ctaAt = code.indexOf('showPartnerDisclosureSheet(');
      expect(guardAt, greaterThan(-1));
      expect(ctaAt, greaterThan(guardEnd),
          reason: 'the CTA must sit AFTER the guarded block, not inside it — '
              'otherwise an unset attribution hides the disclosure too');
    });

    test('it opens a sheet at 90%, not a full screen', () {
      expect(sheet, contains('heightFactor = 0.9'));
      expect(footer.contains('PartnerWebViewScreen'), isFalse,
          reason: 'the full-screen route is the wrong shape for a glance');
    });

    test('back unwinds the page before dismissing the sheet', () {
      expect(sheet, contains('canPop: !_pageCanGoBack'),
          reason: 'a disclosure that links onward would otherwise close the '
              'whole sheet on the first back press');
      expect(sheet, contains('_controller.goBack()'));
    });

    test('the page scrolls instead of dragging the sheet', () {
      // A modal sheet claims vertical drags for its dismiss gesture, so the
      // platform view only gets what the arena hands it. Without an explicit
      // recognizer the disclosure rendered and would not scroll — everything
      // past the first screenful unreachable, on the one surface whose whole
      // purpose is to be read to the end.
      expect(sheet, contains('gestureRecognizers:'));
      expect(sheet, contains('VerticalDragGestureRecognizer'));
    });

    test('a failed load offers both ways out', () {
      expect(sheet, contains('Try again'));
      expect(sheet, contains('Open in browser'));
    });
  });
}
