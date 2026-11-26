import 'package:flutter_test/flutter_test.dart';
import 'dart:io';

/// THE THREE WAYS INTO FINANCIAL CONNECTIONS MUST AGREE.
///
/// There are exactly three entry points — the dashboard tile, the send-funds
/// sheet, and the icon in the corner of the quick-services grid. Two opened
/// the messaging page; the third opened the linked-banks list, under a
/// `mark_unread_chat_alt` glyph. A customer tapping a message icon and landing
/// on a list of banks has to work out for themselves that they took a wrong
/// turn.
///
/// Asserted against the SOURCE because there is no widget harness that drives
/// Get.toNamed from the grid, and the failure is a one-word difference that
/// reads as correct.
void main() {
  String read(String p) => File(p).readAsStringSync();

  test('the quick-services icon opens the messaging page, not linked banks', () {
    // WHOLE FILE, not a sliced method body.
    //
    // The CTA was split across two methods when the unread badge was added,
    // and a window bounded by "the next Widget" then ended BEFORE the tap
    // handler — the guard failed while the code was correct. This file has
    // no other reason to mention linked banks, so asserting across all of it
    // is both stronger and immune to how the widget is factored.
    final body = read('lib/src/features/widgets/app_services_builder.dart');
    expect(body.contains('_buildFinancialConnectionsCta'), isTrue,
        reason: 'the CTA builder was renamed');

    expect(body.contains('Get.toNamed(AppRoutes.financialConnections)'), isTrue,
        reason: 'the corner icon must open the financial-connections '
            'messaging page, the same as the dashboard and send-funds entries');
    expect(body.contains('AppRoutes.linkedBanks'), isFalse,
        reason: 'the corner icon must not open the linked-banks list — its '
            'glyph is a conversation, and the other two entries go elsewhere');
  });

  test('the named-service navigation agrees with it', () {
    final src = read('lib/src/features/widgets/app_service_navigation.dart');
    final i = src.indexOf('case AppServiceName.financialConnections:');
    expect(i, greaterThan(-1));
    final branch = src.substring(i, src.indexOf('break;', i));
    expect(branch.contains('AppRoutes.financialConnections'), isTrue,
        reason: 'tapping the service by name must reach the same page as the icon');
  });

  /// A deep link must be refused by the same switch that hides the tile, or
  /// the gate is decorative. resolver_social.dart lands three notification
  /// kinds on this route, so an ungated entry is a real bypass and not a
  /// theoretical one.
  test('both financial-connections surfaces are behind the service gate', () {
    final map = read('lib/core/types/route_service_map.dart');
    expect(
        map.contains(
            'AppRoutes.financialConnections: AppServiceName.financialConnections'),
        isTrue,
        reason: 'the messaging page is reachable from push notifications and '
            'from the grid; without a gate entry both bypass the switch');
    expect(
        map.contains('AppRoutes.linkedBanks: AppServiceName.financialConnections'),
        isTrue,
        reason: 'the linked-banks page stays gated by the same switch');
  });
}
