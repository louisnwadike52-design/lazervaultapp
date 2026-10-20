import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// RMB TRANSFER IS WITHDRAWN FROM THE GRID UNTIL AN ADMIN TURNS IT ON.
///
/// The rail is in maintenance while its provider sits in sandbox, so the tile
/// was an entry point to something nobody could finish. Hiding it in the app
/// alone would mean a release to bring it back, so it is a flag.
///
/// FIVE LINKS, AND THE CHAIN BREAKS SILENTLY IF ANY IS MISSING — a key can be
/// writable by an admin and readable by a getter and STILL never reach the
/// app, because the snapshot the app polls is built from a separate list.
/// This pins all five.
void main() {
  String code(String path) => File(path).readAsLinesSync().where((l) {
        final t = l.trimLeft();
        return !t.startsWith('//') && !t.startsWith('///');
      }).join('\n');

  const key = 'rmb_transfer_visible';

  test('1. the app declares the key and a getter that defaults to hidden', () {
    final flags = code('lib/core/config/feature_flags.dart');
    expect(flags, contains("rmbTransferVisibleKey = '$key'"));
    expect(flags, contains('static bool get rmbTransferVisible'));
    expect(flags, contains('_prefs?.getBool(rmbTransferVisibleKey) ?? false'),
        reason: 'hidden by default — the rail cannot complete a transfer');
  });

  test('2. the key survives the settings snapshot the app polls', () {
    // The link that has broken repeatedly: without it the value is fetched
    // and then dropped on the floor.
    expect(code('lib/core/services/endpoint_registry.dart'), contains("'$key'"));
  });

  test('3. the tile is hidden at the one chokepoint', () {
    final builder = code('lib/src/features/widgets/app_services_builder.dart');
    expect(builder, contains('if (!FeatureFlags.rmbTransferVisible)'));
    expect(builder, contains('hidden.add(AppServiceName.rmb)'));
  });

  test('4. the admin gateway lets the key be written AND read back', () {
    final write = File(
      '../services/admin-gateway/internal/handlers/voice_agents_admin.go',
    ).readAsStringSync();
    expect(write, contains('"$key": true'),
        reason: 'the write allowlist');

    final list = File(
      '../services/admin-gateway/internal/handlers/voice_agents_admin_part1.go',
    ).readAsStringSync();
    expect(list, contains('"$key"'),
        reason: 'the bulk key set the app snapshot is built from');
  });

  test('5. it is coerced to a bool, not left as a string', () {
    // A flag that arrives as "false" is truthy in the wrong hands.
    final coerce = File(
      '../services/admin-gateway/internal/handlers/voice_agents_admin_part3.go',
    ).readAsStringSync();
    expect(coerce, contains('key == "$key"'));
  });

  test('the admin dashboard exposes it with a reason, not just a switch', () {
    final tab = File(
      '../apps/admin-dashboard/src/app/settings/page/FeatureFlagsTab.tsx',
    ).readAsStringSync();
    expect(tab, contains('key: "$key"'));
    expect(tab, contains('RMB transfer'));
    expect(tab, contains('default: false'));
  });
}
