import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
