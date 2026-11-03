import 'package:flutter/material.dart';

/// A BACK ARROW ONLY WHERE BACK ACTUALLY WORKS.
///
/// Whether a screen can go back is a property of HOW IT WAS ENTERED, not of
/// the screen — the same KYC or signup screen is pushed from one place and
/// made the navigation root (`Get.offAllNamed`, or a cold-boot resume route)
/// from another. A hardcoded arrow is therefore right half the time and inert
/// the other half, and an inert control is worse than an absent one: the
/// customer taps it, nothing happens, and they conclude the app is broken at
/// the moment they are deciding whether to trust it with money.
///
/// `PhoneFlowScaffold` resolves this for the screens it owns. This is the same
/// rule for screens that build their own app bar.
///
/// Returns null when there is nothing to go back to, so a caller can drop it
/// from a `children` list or fall back to a spacer that preserves layout.
Widget? maybeBackButton(
  BuildContext context, {
  VoidCallback? onBack,
  Color color = Colors.white,
  IconData icon = Icons.arrow_back,
}) {
  // A custom handler may navigate without popping (clearing a route, closing
  // a sheet), so it counts as a working back even on an empty stack.
  final canGoBack = onBack != null || Navigator.of(context).canPop();
  if (!canGoBack) return null;
  return IconButton(
    icon: Icon(icon, color: color),
    onPressed: onBack ?? () => Navigator.of(context).maybePop(),
  );
}

/// Whether a back affordance would do anything from here.
///
/// For callers that need the decision without the widget — to choose between
/// a back arrow and a close button, say.
bool canGoBackFrom(BuildContext context, {VoidCallback? onBack}) =>
    onBack != null || Navigator.of(context).canPop();
