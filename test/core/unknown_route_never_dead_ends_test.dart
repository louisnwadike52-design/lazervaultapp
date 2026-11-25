import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A LINK THIS BUILD CANNOT ROUTE MUST STILL GO SOMEWHERE.
///
/// `unknownRoute` rendered an empty purple Scaffold. The purple was
/// deliberate — it matches the native splash, so a misrouted boot does not
/// flash white — but it had no control on it and nothing after it. A customer
/// who tapped a marketing push this build does not know about was left on a
/// blank screen (reported 2026-11-25, with a screenshot).
///
/// The frame is kept for the one frame it is needed; then the customer is
/// moved somewhere real.
void main() {
  final landing =
      File('lib/core/navigation/unknown_route_landing.dart').readAsStringSync();
  final main = File('lib/main.dart').readAsStringSync();

  String code(String src) => src
      .split('\n')
      .where((l) =>
          !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
      .join('\n');

  test('the unknown route is the landing, not a bare empty frame', () {
    final body = code(main);
    expect(body, contains('page: () => const UnknownRouteLanding()'),
        reason: 'unknownRoute must route onward, not sit on a blank screen');
  });

  test('it leaves after the first frame rather than during build', () {
    expect(code(landing), contains('addPostFrameCallback'),
        reason: 'navigating during build throws, and a thrown navigation '
            'reads to the customer as the app being broken');
  });

  test('it replaces the dead route instead of stacking on it', () {
    final body = code(landing);
    expect(body, contains('Get.offNamed('),
        reason: 'toNamed would leave the blank frame on the stack, and the OS '
            'back button would return the customer straight to it');
    expect(body.contains('Get.toNamed('), isFalse);
  });

  test('a logged-out visitor is not dumped on the dashboard', () {
    final body = code(landing);
    expect(body, contains('AppRoutes.signIn'),
        reason: 'sending a signed-out visitor to the dashboard bounces them '
            'through the auth gate and loses the intent');
    expect(body, contains('AppRoutes.dashboard'));
  });

  test('no session, no cubit, still lands — it never throws', () {
    final body = code(landing);
    expect(body, contains('catch (_)'),
        reason: 'a cold boot straight into an unknown route has no cubit yet; '
            'throwing there would restore the dead end');
  });

  test('the splash colour is kept, so a misrouted boot still does not flash', () {
    expect(code(landing), contains('0xFF3D2F8B'));
  });
}
