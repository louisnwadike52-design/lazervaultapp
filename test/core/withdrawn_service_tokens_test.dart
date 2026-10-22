import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/services.dart';

/// The admin gate key for a quick service is built from the enum's `.name`,
/// NOT from its label:
///
///     quick_service_<AppServiceName.name>_visible
///
/// So the enum name is a wire identifier. Renaming it does not fail to
/// compile, does not fail a build, and does not raise an error at runtime —
/// the key simply stops matching any stored row, the gate reads as UNSET, and
/// unset means VISIBLE. A service deliberately withdrawn would quietly come
/// back for every user, which is the worst direction for this to fail in.
///
/// Two of the four services withdrawn on 2026-10-22 have tokens that do not
/// resemble their labels at all:
///
///     "Lazerfunds"  -> uplift        (its original code name)
///     "Group Funds" -> groupAccount
///
/// Both look exactly like something a later reader would tidy up. This test is
/// the thing that stops them.
///
/// It deliberately asserts the PAIRING, not the configuration. Which services
/// are withdrawn is admin data and may change freely; that these labels are
/// reached by these tokens is a code fact the stored keys depend on.
void main() {
  group('withdrawn-service gate tokens', () {
    // label -> enum name used to build quick_service_<token>_*
    const expected = <String, String>{
      'Group Funds': 'groupAccount',
      'Auto-Save': 'autoSave',
      'Crowdfund': 'crowdfund',
      'Lazerfunds': 'uplift',
    };

    test('each withdrawn service is still reached by the token its keys use', () {
      for (final entry in expected.entries) {
        final matches = AppServiceName.values
            .where((s) => s.displayName == entry.key)
            .toList();

        expect(
          matches,
          hasLength(1),
          reason: 'exactly one service should be labelled "${entry.key}"; '
              'found ${matches.map((s) => s.name).toList()}',
        );
        expect(
          matches.single.name,
          entry.value,
          reason: '"${entry.key}" is gated by '
              'quick_service_${entry.value}_visible in production. Its enum '
              'name is now "${matches.single.name}", so that key no longer '
              'matches, the gate reads as unset, and unset means VISIBLE — '
              'the service is live for everyone again. Rename the stored keys '
              'in payments.system_settings together with the enum, or revert.',
        );
      }
    });

    test('Piggyvault is NOT one of them', () {
      // lockFunds sits next to uplift in the enum and both are "funds"
      // products; withdrawing the wrong one would take a live service off
      // every phone.
      final piggy = AppServiceName.values
          .where((s) => s.displayName == 'Piggyvault')
          .toList();
      expect(piggy, hasLength(1));
      expect(piggy.single.name, 'lockFunds');
      expect(
        expected.values.contains(piggy.single.name),
        isFalse,
        reason: 'Piggyvault (lockFunds) was not asked to be withdrawn',
      );
    });
  });
}
