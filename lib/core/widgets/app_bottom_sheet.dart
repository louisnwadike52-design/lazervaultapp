import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// [showModalBottomSheet], WITH THE PHONE'S NAVIGATION BAR ACCOUNTED FOR.
///
/// ## Why this exists rather than a note telling everyone to remember
///
/// From Android 15 (API 35) every app is laid out EDGE TO EDGE: the window
/// reaches under the status bar and under the navigation bar, and insetting
/// the app's own chrome became the app's job. A sheet whose content ends in a
/// fixed `EdgeInsets.fromLTRB(20, 12, 20, 24)` now puts its last row — the
/// Cancel, the Confirm, the last option in a list — underneath the phone's
/// back / home / recents buttons. Reported with a screenshot of the dashboard
/// quick-actions sheet with its "Cancel" half-swallowed.
///
/// There are over two hundred sheets in this app and nine of them had thought
/// about it. A rule nobody can see is not a rule, so the fix is in the call
/// everybody already makes.
///
/// ## What it does
///
/// Exactly what [showModalBottomSheet] does, with the builder's widget wrapped
/// in `SafeArea(top: false)`.
///
/// `top: false` because the sheet's own top is already handled — it is
/// anchored to the bottom, and Flutter removes the top padding from a sheet's
/// MediaQuery anyway. The bottom padding is NOT removed, which is what makes
/// the SafeArea read the real inset.
///
/// It collapses to zero while the keyboard is up (padding is view padding
/// minus the keyboard), so a sheet with a text field does not grow a dead band
/// above the keys.
///
/// Flutter's own `useSafeArea: true` does NOT solve this — read its source and
/// it is `SafeArea(bottom: false)`, for the status bar on a tall sheet. It is
/// forwarded unchanged.
Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
  String? barrierLabel,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
  BoxConstraints? constraints,
  Color? barrierColor,
  bool isScrollControlled = false,
  double scrollControlDisabledMaxHeightRatio = 9.0 / 16.0,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  bool? showDragHandle,
  bool useSafeArea = false,
  RouteSettings? routeSettings,
  AnimationController? transitionAnimationController,
  Offset? anchorPoint,
  AnimationStyle? sheetAnimationStyle,
  bool? requestFocus,
}) {
  return showModalBottomSheet<T>(
    context: context,
    builder: (ctx) => SafeArea(top: false, child: builder(ctx)),
    backgroundColor: backgroundColor,
    barrierLabel: barrierLabel,
    elevation: elevation,
    shape: shape,
    clipBehavior: clipBehavior,
    constraints: constraints,
    barrierColor: barrierColor,
    isScrollControlled: isScrollControlled,
    scrollControlDisabledMaxHeightRatio: scrollControlDisabledMaxHeightRatio,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    showDragHandle: showDragHandle,
    useSafeArea: useSafeArea,
    routeSettings: routeSettings,
    transitionAnimationController: transitionAnimationController,
    anchorPoint: anchorPoint,
    sheetAnimationStyle: sheetAnimationStyle,
    requestFocus: requestFocus,
  );
}

/// `Get.bottomSheet`, with the same inset handling as [showAppBottomSheet].
///
/// GetX's own route removes the TOP padding (`removeTop: ignoreSafeArea ??
/// true`) and leaves the bottom padding in place, so `SafeArea(top: false)`
/// reads the navigation bar correctly here too.
Future<T?> showAppGetBottomSheet<T>(
  Widget bottomsheet, {
  Color? backgroundColor,
  double? elevation,
  bool persistent = true,
  ShapeBorder? shape,
  Clip? clipBehavior,
  Color? barrierColor,
  bool? ignoreSafeArea,
  bool isScrollControlled = false,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  RouteSettings? settings,
  Duration? enterBottomSheetDuration,
  Duration? exitBottomSheetDuration,
}) {
  return Get.bottomSheet<T>(
    SafeArea(top: false, child: bottomsheet),
    backgroundColor: backgroundColor,
    elevation: elevation,
    persistent: persistent,
    shape: shape,
    clipBehavior: clipBehavior,
    barrierColor: barrierColor,
    ignoreSafeArea: ignoreSafeArea,
    isScrollControlled: isScrollControlled,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    settings: settings,
    enterBottomSheetDuration: enterBottomSheetDuration,
    exitBottomSheetDuration: exitBottomSheetDuration,
  );
}
