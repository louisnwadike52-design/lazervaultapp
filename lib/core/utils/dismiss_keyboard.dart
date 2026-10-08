import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Put the soft keyboard away.
///
/// WHY THIS IS NOT JUST `FocusScope.of(context).unfocus()`
///
/// The call sites that need it most have no `BuildContext` to offer. The
/// inactivity auto-logout fires from a timer inside a `WidgetsBindingObserver`,
/// not from a widget, and it tears the whole navigation stack down with
/// `Get.offAllNamed`. So this reaches for the focus manager directly, which is
/// process-global and needs nothing from the tree.
///
/// WHY IT ALSO TALKS TO THE PLATFORM CHANNEL
///
/// Unfocusing is the correct, framework-level half, and on its own it is what
/// closes the keyboard in the ordinary case. It is not sufficient when the
/// focused `TextField` is DESTROYED in the same frame — which is exactly what
/// a logout does: `offAllNamed` disposes every route, the field holding focus
/// goes with it, and the unfocus notification can be lost in the teardown. iOS
/// then leaves the keyboard standing over the login screen with nothing behind
/// it to dismiss, because the widget that owned it no longer exists.
/// `TextInput.hide` is addressed to the platform's input client rather than to
/// a widget, so it survives that teardown.
///
/// Both halves are safe to call when no keyboard is up: unfocusing a null
/// primary focus is a no-op, and `TextInput.hide` with no active input
/// connection is ignored by the embedder.
void dismissKeyboard() {
  final focus = FocusManager.instance.primaryFocus;
  if (focus != null && focus.hasFocus) {
    focus.unfocus();
  }
  // Fire-and-forget: a platform channel failure must never be the reason a
  // logout does not complete. Logging out is a security action and has to
  // happen whether or not the keyboard cooperated.
  SystemChannels.textInput.invokeMethod<void>('TextInput.hide').catchError(
    (_) {},
  );
}

/// Put away every transient surface floating ABOVE the page stack, then the
/// keyboard. Call this immediately before tearing the stack down on logout.
///
/// WHY A SHARE SHEET NEEDS THIS AND A PAGE DOES NOT
///
/// `Get.offAllNamed` replaces the page stack, so ordinary pages go on their
/// own. A bottom sheet or dialog is not an ordinary page: it is a
/// [PopupRoute] sitting above the stack, and a share sheet left open when the
/// session expires ends up hovering over the login screen — a surface from
/// the previous user's session, on top of an unauthenticated screen, still
/// showing whatever it was sharing (account numbers, a receipt, a payment
/// link). That is the same failure as the keyboard surviving the teardown,
/// and it is worse, because the keyboard leaks nothing.
///
/// Pops ONLY PopupRoutes, so the predicate stops the moment it reaches a real
/// page — a logout can never pop the app down to a blank navigator. GetX
/// snackbars are OverlayRoutes rather than PopupRoutes, so they are closed
/// separately.
///
/// Every step is independently guarded: dismissing UI must never be the
/// reason a security action fails to complete.
void dismissTransientOverlays() {
  try {
    Get.closeAllSnackbars();
  } catch (_) {}
  try {
    // popUntil stops at the first non-popup route, so with no sheet open this
    // is a no-op rather than a pop of the page underneath.
    Get.key.currentState?.popUntil((route) => route is! PopupRoute);
  } catch (_) {}
  dismissKeyboard();
}
