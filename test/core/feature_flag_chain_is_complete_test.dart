import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Every admin-tunable flag must survive the whole chain, and the ONLY reliable
/// way to know is to count it.
///
/// The chain is six links: the gateway's write allowlist, its value validator,
/// its bulk-read LIKE filter, EndpointRegistry's persisted-key set, the
/// FeatureFlags hydration list, and the screen. Link 4 is the one that gets
/// forgotten, because missing it fails SILENTLY and in the most misleading way
/// available: single-key GET and PUT keep working, the dashboard shows the
/// value stored, and the app goes on using its hardcoded default forever.
///
/// `intl_payout_enabled` shipped that way — an operator could turn Send Abroad
/// on, watch it save, and the app said "not available" indefinitely. When that
/// was found, SIX more flags were dead identically, and `bottom_nav_*` (every
/// nav switch and every nav whitelist) was dead the same way after that.
///
/// A checklist did not prevent any of them. This test is the checklist.
void main() {
  final flagsSrc =
      File('lib/core/config/feature_flags.dart').readAsStringSync();
  final registrySrc =
      File('lib/core/services/endpoint_registry.dart').readAsStringSync();

  /// Strip `//` comment lines before matching.
  ///
  /// Both files EXPLAIN this bug at length and quote the key names while doing
  /// it, so a scan over raw text would find `intl_payout_enabled` inside a
  /// paragraph about it being missing and conclude all was well — a guard that
  /// passes by matching its own explanation. That has happened here before.
  String stripComments(String src) => src
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  final flags = stripComments(flagsSrc);
  final registry = stripComments(registrySrc);

  /// `static const String fooBar = 'foo_bar';` → {fooBar: foo_bar}
  final keyByConst = <String, String>{
    for (final m in RegExp(
            r"static\s+const\s+String\s+(\w+)\s*=\s*\n?\s*'([a-z0-9_]+)'")
        .allMatches(flags))
      m.group(1)!: m.group(2)!,
  };

  /// The identifiers listed inside applyRemoteSnapshot's boolean loop.
  Set<String> hydratedBoolConsts() {
    final start = flags.indexOf('applyRemoteSnapshot');
    expect(start, greaterThan(-1), reason: 'applyRemoteSnapshot not found');
    final listStart = flags.indexOf('for (final key in <String>[', start);
    final listEnd = flags.indexOf(']) {', listStart);
    expect(listStart, greaterThan(-1));
    expect(listEnd, greaterThan(listStart));
    return flags
        .substring(listStart, listEnd)
        .split(RegExp(r'[,\[\]\n]'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty && keyByConst.containsKey(e))
        .toSet();
  }

  Set<String> literalSet(String fieldName) {
    final i = registry.indexOf(fieldName);
    expect(i, greaterThan(-1), reason: '$fieldName not found');
    final open = registry.indexOf('{', i);
    final close = registry.indexOf('};', open);
    return RegExp(r"'([a-z0-9_]+)'")
        .allMatches(registry.substring(open, close))
        .map((m) => m.group(1)!)
        .toSet();
  }

  test('every hydrated flag is actually transported to the app', () {
    final persistedKeys = literalSet('_persistedNonUrlKeys');
    final persistedPrefixes = literalSet('_persistedNonUrlKeyPrefixes');

    final missing = <String>[];
    for (final constName in hydratedBoolConsts()) {
      final key = keyByConst[constName]!;
      final covered = persistedKeys.contains(key) ||
          persistedPrefixes.any(key.startsWith);
      if (!covered) missing.add('$constName ($key)');
    }

    expect(
      missing,
      isEmpty,
      reason: 'These flags are hydrated by FeatureFlags.applyRemoteSnapshot but '
          'are in neither _persistedNonUrlKeys nor _persistedNonUrlKeyPrefixes '
          'in EndpointRegistry.\n\n'
          'nonUrlSnapshot() emits ONLY those, so the admin value is dropped '
          'between the registry cache and FeatureFlags and the hardcoded '
          'default wins on every launch. Nothing errors; the operator sees the '
          'value saved and the app ignores it forever.\n\n'
          'Add each key to _persistedNonUrlKeys (or cover it with a prefix):\n'
          '  ${missing.join('\n  ')}',
    );
  });

  test('the prefix families the app depends on are transported', () {
    final prefixes = literalSet('_persistedNonUrlKeyPrefixes');
    // Each of these is a family whose key names are not knowable in advance,
    // so only a prefix can carry them. bottom_nav_ was absent for the whole
    // life of the feature, which made every nav switch and nav whitelist inert.
    for (final required in const [
      'quick_service_',
      'bottom_nav_',
      'feature_',
      'chat_icon_',
      'voice_agent_',
    ]) {
      expect(prefixes, contains(required),
          reason: '$required is hydrated by applyRemoteSnapshot but not '
              'emitted by nonUrlSnapshot() — the whole family is inert.');
    }
  });

  test('the scan itself detects a missing key', () {
    // Guards that pass on broken code are worse than no guards. Prove the
    // matcher can actually see a gap by removing a known-covered key from the
    // registry text and re-running the same comparison.
    final persistedKeys = literalSet('_persistedNonUrlKeys')
      ..remove('intl_payout_enabled');
    final persistedPrefixes = literalSet('_persistedNonUrlKeyPrefixes');
    final covered = persistedKeys.contains('intl_payout_enabled') ||
        persistedPrefixes.any('intl_payout_enabled'.startsWith);
    expect(covered, isFalse,
        reason: 'the coverage check cannot distinguish present from absent');
  });
}
