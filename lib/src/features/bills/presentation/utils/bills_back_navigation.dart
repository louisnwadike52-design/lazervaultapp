import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// Backing out of a bills/utility LANDING screen.
///
/// THE BUG THIS REPLACES. Every utility landing page hardcoded its back button
/// to `Get.offAllNamed(AppRoutes.billsHub)`. There are two ways into these
/// screens — the Bills Hub tile and the dashboard quick-service tile — and both
/// PUSH (`Get.toNamed`). So a user who tapped Airtime on the dashboard pressed
/// back and landed in Bills Hub: a screen they had never opened, reached by a
/// call that also wiped the rest of their stack. Going "back" to somewhere you
/// have never been is the clearest possible sign the app has lost track of
/// where you came from.
///
/// Popping is the whole fix. Because both entry points push, the stack already
/// holds the truthful answer — dashboard or Bills Hub — and `Get.back()`
/// returns to whichever it actually was. No origin argument has to be threaded
/// through navigation, and nothing has to be kept in sync.
///
/// NOT FOR RESULT/RECEIPT SCREENS. Those deliberately use `offAllNamed`,
/// because after a completed purchase the payment form must not be behind the
/// back button. education_pin_result_screen says so in as many words:
/// "receipt is a terminal screen, there's no meaningful previous step to
/// restore." Leave them alone.
///
/// [fallbackRoute] is used only when there is genuinely nothing to pop — a
/// notification deep link or a cold start straight into the service, where the
/// service's own hub is the sensible parent.
void popBillsLandingScreen({String fallbackRoute = AppRoutes.billsHub}) {
  // Ask the navigator, not a flag we maintain. `canPop` is false exactly when
  // this screen is the only route, which is the deep-link case.
  final canPop = Get.key.currentState?.canPop() ?? false;
  if (canPop) {
    Get.back();
    return;
  }
  Get.offAllNamed(fallbackRoute);
}

/// The [PopScope.onPopInvokedWithResult] half of the same decision, for screens
/// that intercept the OS/Android back gesture too.
///
/// `didPop == true` means the framework already popped and there is nothing
/// left to do — acting again would pop a second route the user never asked to
/// leave. Only the `didPop == false` case needs us, and it means the pop was
/// blocked or impossible, so we fall back.
void onBillsLandingPopInvoked(bool didPop,
    {String fallbackRoute = AppRoutes.billsHub}) {
  if (didPop) return;
  popBillsLandingScreen(fallbackRoute: fallbackRoute);
}
