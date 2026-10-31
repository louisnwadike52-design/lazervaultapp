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

/// The [PopScope.onPopInvokedWithResult] half of the same decision, for
/// screens that also intercept the OS/Android back gesture.
///
/// `didPop == true` means the framework already popped and there is nothing
/// left to do — acting again would pop a SECOND route the user never asked to
/// leave. Only `didPop == false` needs us, and it means the pop was blocked or
/// impossible, so we fall back.
void backOrHomeOnPopInvoked(bool didPop,
    {String fallbackRoute = AppRoutes.dashboard}) {
  if (didPop) return;
  backOrHome(fallbackRoute: fallbackRoute);
}

/// Backing out of a bills/utility LANDING screen — [backOrHome] with the
/// Bills Hub as the fallback instead of the dashboard.
///
/// THE BUG THIS REPLACED. Every utility landing page hardcoded its back button
/// to `Get.offAllNamed(AppRoutes.billsHub)`. There are several ways into these
/// screens — the Bills Hub tile, the dashboard quick service, and now the
/// minimum-balance refusal sheet — and all of them PUSH. So a user who tapped
/// Airtime on the dashboard pressed back and landed in Bills Hub: a screen
/// they had never opened, reached by a call that also wiped the rest of their
/// stack.
///
/// Popping is the whole fix. Because every entry point pushes, the stack
/// already holds the truthful answer, and `Get.back()` returns to whichever it
/// actually was — no origin argument threaded through navigation, nothing to
/// keep in sync, and a new entry point works without being told about.
///
/// A SEPARATE NAME, NOT A SEPARATE IMPLEMENTATION. This is [backOrHome] with a
/// different default; the logic lives in one place. The two were genuinely
/// written twice, in `bills_back_navigation.dart` and here, with identical
/// bodies and near-identical doc comments — merged on 31 Oct 2026.
///
/// NOT FOR RESULT/RECEIPT SCREENS. Those deliberately use `offAllNamed`,
/// because after a completed purchase the payment form must not be behind the
/// back button. Leave them alone.
void popServiceLandingScreen({String fallbackRoute = AppRoutes.billsHub}) =>
    backOrHome(fallbackRoute: fallbackRoute);

/// The [PopScope] half of [popServiceLandingScreen].
void onServiceLandingPopInvoked(bool didPop,
        {String fallbackRoute = AppRoutes.billsHub}) =>
    backOrHomeOnPopInvoked(didPop, fallbackRoute: fallbackRoute);
