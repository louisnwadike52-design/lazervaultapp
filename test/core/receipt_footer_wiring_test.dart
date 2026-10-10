import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// The four-link chain an admin-tunable value must traverse to reach a phone:
///   admin-gateway allowlist → admin-gateway bulk read → EndpointRegistry
///   ._persistedNonUrlKeys → FeatureFlags.applyRemoteSnapshot
///
/// Link 3 is the one that gets forgotten. `intl_payout_enabled` had links 1, 2
/// and 4 and was missing from _persistedNonUrlKeys, so nonUrlSnapshot() never
/// emitted it: the operator switched Send Abroad on, saw it stored, and the
/// app said "not available" indefinitely. Six more keys were dead the same way
/// when that was found.
///
/// A source test, not a behavioural one, because the failure is a MISSING
/// entry in a list — there is no runtime path that notices, which is exactly
/// why it keeps happening.
void main() {
  final flags = File('lib/core/config/feature_flags.dart').readAsStringSync();
  final registry = File('lib/core/services/endpoint_registry.dart').readAsStringSync();

  const keys = [
    'receipt_footer_company',
    'receipt_footer_disclaimer',
    'receipt_footer_support',
  ];

  group('receipt footer keys reach the app', () {
    for (final k in keys) {
      test('$k is persisted by EndpointRegistry', () {
        // Without this, nonUrlSnapshot() drops the value between the registry
        // cache and FeatureFlags and the hardcoded default wins every launch.
        expect(registry.contains("'$k'"), isTrue,
            reason: '$k missing from _persistedNonUrlKeys — the admin value '
                'would be stored, shown as saved, and never reach a receipt');
      });

      test('$k is hydrated by FeatureFlags', () {
        expect(flags.contains("'$k'"), isTrue,
            reason: '$k has no const in feature_flags.dart');
      });
    }

    test('all three are in the verbatim-string hydration list', () {
      // They are prose, so they must be mirrored verbatim rather than coerced
      // to bool — a bool coercion would silently store `false`.
      final block = flags.substring(flags.indexOf('applyRemoteSnapshot'));
      for (final name in [
        'receiptFooterCompanyKey',
        'receiptFooterDisclaimerKey',
        'receiptFooterSupportKey',
      ]) {
        expect(block.contains(name), isTrue,
            reason: '$name not hydrated in applyRemoteSnapshot');
      }
    });
  });

  group('the legal name is corrected everywhere', () {
    test('no receipt surface still says "Lazervault Technologies"', () {
      // The registered company is "Lazervault LTD". Receipts named a company
      // that does not exist, across 31 files.
      final offenders = <String>[];
      for (final f in Directory('lib').listSync(recursive: true)) {
        if (f is! File || !f.path.endsWith('.dart')) continue;
        // The two config files explain the correction in prose.
        if (f.path.endsWith('receipt_footer.dart') ||
            f.path.endsWith('feature_flags.dart')) continue;
        if (f.readAsStringSync().contains('Lazervault Technologies')) {
          offenders.add(f.path);
        }
      }
      expect(offenders, isEmpty,
          reason: 'these still print a company that is not registered');
    });
  });
}
