import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// An admin feature flag is only real if ALL of its links are wired.
///
/// The recipe has six, and the one that gets forgotten is
/// EndpointRegistry._persistedNonUrlKeys: nonUrlSnapshot() emits only keys in
/// that set, so a flag missing from it never reaches the app and sits on its
/// code default for ever — while single-key GET/PUT in the dashboard appear to
/// work perfectly. That is exactly how intl_payout_enabled shipped broken.
///
/// This asserts every link for uplift_remove_cta_visible at once.
void main() {
  const key = 'uplift_remove_cta_visible';
  String read(String p) => File(p).readAsStringSync();

  test('LINK 3 — the key is in the persisted snapshot set', () {
    expect(read('lib/core/services/endpoint_registry.dart'), contains("'$key'"),
        reason: 'without this the flag never reaches the app, and the '
            'dashboard toggle looks like it works while changing nothing');
  });

  test('the Flutter flag is declared, hydrated and readable', () {
    final f = read('lib/core/config/feature_flags.dart');
    expect(f, contains("static const String upliftRemoveCtaVisible = '$key'"));
    expect(f, contains('upliftRemoveCtaVisible,'),
        reason: 'it must be in the boolean-hydration list or the stored value '
            'is never applied');
    expect(f, contains('static bool get upliftRemoveCta'));
  });

  test('it defaults to VISIBLE', () {
    // The control shipped visible. Unset keys are omitted by the bulk read,
    // so the code default is what applies until an admin flips it — a false
    // default would silently remove a button nobody asked to remove.
    expect(read('lib/core/config/feature_flags.dart'),
        contains('_prefs?.getBool(upliftRemoveCtaVisible) ?? true'));
  });

  test('the screen reads the flag, ANDed with the settled check', () {
    final screen = read(
        'lib/src/features/uplift/presentation/views/uplift_detail_screen.dart');
    expect(screen, contains('FeatureFlags.upliftRemoveCta &&'),
        reason: 'the flag must NARROW the existing condition, never replace '
            'it — the server refuses Remove on an unsettled pool, so turning '
            'the flag on must not be able to expose a button that can only fail');
    expect(screen, contains('f.refundedTotal.toInt() <='),
        reason: 'the settled check must survive');
  });

  test('admin-gateway allows, validates and RETURNS the key', () {
    const gw = '../services/admin-gateway/internal/handlers';
    expect(read('$gw/voice_agents_admin.go'), contains('"$key": true'),
        reason: 'not allowlisted → writes are refused');
    expect(read('$gw/voice_agents_admin_part3.go'), contains('key == "$key"'),
        reason: 'not validated → a non-boolean value can be stored');
    expect(read('$gw/voice_agents_admin_part1.go'), contains('"$key",'),
        reason: 'missing from the bulk ListSettings key list → the app never '
            'sees it, even though single-key GET/PUT work');
  });

  test('the dashboard exposes a toggle for it', () {
    expect(
        read(
            '../apps/admin-dashboard/src/app/settings/page/FeatureFlagsTab.tsx'),
        contains('key: "$key"'),
        reason: 'a flag with no control is only togglable by hand in SQL');
  });
}
