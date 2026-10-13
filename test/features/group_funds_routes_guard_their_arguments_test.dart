import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Group Funds routes must not cast `Get.arguments` bare.
///
/// `Get.arguments` is GLOBAL in GetX, not per-route: a modal, a sheet or
/// another navigation can leave it null by the time a page builder runs.
/// `null as String` then throws INSIDE the builder, and a builder that throws
/// paints a blank grey screen with no way back — reported after paying a due
/// contribution from the dashboard and pressing back, where the payment
/// flow's own routes and sheets sit between setting the argument and the
/// rebuild.
///
/// contributionDetails and makePayment were already guarded for exactly this.
/// groupDetails was not, and it is the one the post-payment path navigates to.
///
/// Scoped to the Group Funds family on purpose. 59 routes in this file still
/// cast bare; fixing them all needs a per-route decision about the right
/// fallback, so this pins the ones that are done rather than failing on the
/// ones that are not.
void main() {
  late List<String> lines;

  setUpAll(() {
    lines = File('lib/src/features/presentation/app_router.dart')
        .readAsLinesSync();
  });

  /// The body of the GetPage registered under [routeConst].
  String pageBodyFor(String routeConst) {
    final start = lines.indexWhere((l) => l.contains('name: $routeConst,'));
    expect(start, isNot(-1), reason: '$routeConst is no longer registered');
    final after = lines.sublist(start + 1);
    final end = after.indexWhere((l) => l.contains('GetPage('));
    final body = end == -1 ? after : after.sublist(0, end);
    // Comments stripped FIRST. The guards carry comments that quote the very
    // pattern being banned ("`Get.arguments as Map<String, dynamic>` throws
    // inside the page builder"), and a raw substring check failed on the
    // fixed route because it matched the explanation instead of the code.
    // Same mistake as the receipt-route guard; verified the same way.
    return body.where((l) => !l.trimLeft().startsWith('//')).join('\n');
  }

  const guarded = [
    'AppRoutes.groupDetails',
    'AppRoutes.contributionDetails',
    'AppRoutes.makePayment',
  ];

  for (final route in guarded) {
    test('$route does not cast Get.arguments bare', () {
      final body = pageBodyFor(route);

      expect(
        RegExp(r'Get\.arguments as [A-Za-z]').hasMatch(body),
        isFalse,
        reason: '$route casts Get.arguments directly. Get.arguments is global '
            'and can be null when this builder runs; the throw renders as a '
            'blank grey screen the user cannot escape. Read it defensively '
            'and call popMissingArgs when it is unusable.',
      );

      expect(
        body.contains('popMissingArgs'),
        isTrue,
        reason: '$route has no popMissingArgs fallback, so an unusable '
            'argument leaves the user on a dead screen instead of being '
            'popped with an explanation.',
      );
    });
  }
}
