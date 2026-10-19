library;

import 'package:get/get.dart';

import 'package:lazervault/core/types/app_routes.dart';

/// GO BACK IF THERE IS A BACK TO GO TO.
///
/// Several money screens wired their back affordance straight to
/// `Get.offAllNamed(AppRoutes.dashboard)`. That is right only for the one
/// case it was written for — the screen opened as the first thing after a
/// deep link, with nothing beneath it — and wrong everywhere else, because
/// it DESTROYS the stack. Reaching Recurring Payments from the send-funds
/// recipient sheet and pressing back dropped the user on the dashboard,
/// losing the recipient, the amount and every screen in between.
///
/// `Get.back()` alone is not the fix either: with an empty stack it pops
/// nothing and can leave the user on a screen with no way out.
///
/// So: pop when something is there to pop, and only reset to the dashboard
/// when the screen really is the bottom of the stack.
void backOrHome({String fallbackRoute = AppRoutes.dashboard}) {
  if (Get.key.currentState?.canPop() ?? false) {
    Get.back();
    return;
  }
  Get.offAllNamed(fallbackRoute);
}
