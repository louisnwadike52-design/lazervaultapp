import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/core/config/feature_flags.dart';

/// WHERE THE PAGE-TURN CONTROL LIVES IS AN OPERATOR DECISION, NOT A RELEASE.
///
/// "bottom" (the default) puts it on the indicator row's trailing edge and
/// moves Financial Connections to the leading edge, so the two bracket the
/// dots. "grid" restores the original cell in the grid and gives Financial
/// Connections its old corner back.
///
/// The placement and the icon's side are ONE decision — expressing them as two
/// switches invites the combination nobody wants, both controls in the same
/// corner — so one key drives both.
void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.debugResetForTest();
  });

  Future<void> setPlacement(String? v) async {
    final prefs = await SharedPreferences.getInstance();
    if (v == null) {
      await prefs.remove(FeatureFlags.quickServicesMorePlacementKey);
    } else {
      await prefs.setString(FeatureFlags.quickServicesMorePlacementKey, v);
    }
  }

  test('DEFAULT is the bottom row, not the grid', () async {
    await setPlacement(null);
    expect(FeatureFlags.quickServicesMoreInGrid, isFalse,
        reason: 'the operator asked for the bottom arrangement by default; an '
            'unset key must not restore the grid cell it replaced');
  });

  test('"grid" puts it back in the grid, with no release', () async {
    await setPlacement('grid');
    expect(FeatureFlags.quickServicesMoreInGrid, isTrue);
  });

  test('"bottom" is explicit and matches the default', () async {
    await setPlacement('bottom');
    expect(FeatureFlags.quickServicesMoreInGrid, isFalse);
  });

  test('case and padding are tolerated', () async {
    await setPlacement('  GRID  ');
    expect(FeatureFlags.quickServicesMoreInGrid, isTrue,
        reason: 'an operator typing Grid in a text field means grid');
  });

  // A MISTYPED VALUE MUST FALL BACK TO THE CHOSEN DEFAULT, not to the layout
  // it replaced. Being wrong toward the old grid cell would quietly undo the
  // operator's arrangement and look like the setting never saved.
  test('anything unrecognised falls back to the bottom row', () async {
    for (final junk in ['', '   ', 'true', 'GRIDD', 'left', 'nonsense']) {
      await setPlacement(junk);
      expect(FeatureFlags.quickServicesMoreInGrid, isFalse,
          reason: 'junk value ${junk.isEmpty ? "(empty)" : junk} must not '
              'enable the grid arrangement');
    }
  });

  // The key has to survive BOTH hops or the dashboard writes a value no phone
  // ever reads — the gap that left the whole SMS chain dead.
  test('the key is ingested as a STRING and persisted by the registry', () {
    final flags = _read('lib/core/config/feature_flags.dart');
    final registry = _read('lib/core/services/endpoint_registry.dart');

    expect(flags.contains('quickServicesMorePlacementKey,'), isTrue,
        reason: 'absent from applyRemoteSnapshot the operator value is dropped');
    expect(registry.contains("'quick_services_more_placement'"), isTrue,
        reason: 'absent from _persistedNonUrlKeys, nonUrlSnapshot() emits '
            'nothing for it and FeatureFlags never sees it');
  });
}

String _read(String path) => File(path).readAsStringSync();
