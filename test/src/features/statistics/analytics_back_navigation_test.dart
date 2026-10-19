import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// BACK FROM AN ANALYTICS SCREEN DID NOTHING WHEN IT WAS THE FIRST SCREEN.
///
/// Every analytics screen is registered as a NAMED ROUTE in app_router.dart,
/// so each can be the first thing on the stack — opened from a notification,
/// a deep link, or a route reset. Their back affordances all called
/// `Get.back()`, which with nothing to pop does nothing at all: the arrow is
/// there, it is tappable, and the user is stuck on the screen.
///
/// `backOrHome()` already existed for exactly this (core/navigation): pop when
/// there is something to pop, and only fall back to the dashboard when the
/// screen really is the bottom of the stack — never the reverse, which
/// destroys the stack and loses the screens in between.
void main() {
  const dir =
      'lib/src/features/statistics/presentation/screens';

  // The seven route-registered screens whose back affordance was unguarded.
  const screens = <String>[
    'budget_ai_insights_screen.dart',
    'budget_detail_screen.dart',
    'budget_list_screen_widgets.dart',
    'budget_reminders_screen.dart',
    'create_budget_screen.dart',
    'financial_goals_screen.dart',
    'recurring_bills_screen.dart',
  ];

  for (final name in screens) {
    test('$name cannot strand the user on a first-screen open', () {
      final src = File('$dir/$name').readAsStringSync();
      expect(
        src.contains('onPressed: () => Get.back(),'),
        isFalse,
        reason: 'an unguarded Get.back() does nothing when this screen is the '
            'bottom of the stack, and every one of these is reachable by name',
      );
      expect(src, contains('backOrHome()'));
    });
  }

  test('a deleted budget still has a way out', () {
    // The not-found state's own button, not just the app bar: a budget opened
    // by deep link and since deleted lands on that state, and its "go back"
    // was the same unguarded pop.
    final src = File('$dir/budget_detail_screen.dart').readAsStringSync();
    expect(
      RegExp(r'backOrHome\(\)').allMatches(src).length,
      greaterThanOrEqualTo(2),
      reason: 'the app bar AND the not-found state both navigate',
    );
  });

  test('dialog dismissals are left alone', () {
    // backOrHome is for NAVIGATION. A dialog's Cancel must keep calling
    // Get.back(), which closes the dialog — routing it through backOrHome
    // would reset the stack to the dashboard when the dialog is the only
    // thing above it.
    final src =
        File('lib/src/features/widgets/statistics.dart').readAsStringSync();
    expect(src, contains('onPressed: () => Get.back()'),
        reason: 'the unlink dialog still dismisses itself');
  });
}
