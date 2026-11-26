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
///
/// ## WHY THE INSET IS ONLY APPLIED WHEN THE HELPER OWNS THE SURFACE
///
/// Reported 2026-11-26 with a screenshot: the "Account Verified" sheet on the
/// Select Recipient screen floated ABOVE the bottom of the screen, with the
/// page behind it showing through a band under the Confirm button. Every sheet
/// in the app did it.
///
/// The wrap above is why. `SafeArea` pads OUTSIDE the widget it is given, so
/// the sheet's own surface — the white rounded Container most sheets build —
/// got pushed up by the home-indicator inset, and whatever the sheet set as
/// its `backgroundColor` showed in the band underneath. 247 of the ~350 sheets
/// here pass `Colors.transparent` and paint their own surface, so for those the
/// band was transparent and the band showed the page behind. A sheet that does
/// not touch the bottom of the screen does not read as a sheet.
///
/// The distinction that fixes it: WHO PAINTS THE SURFACE.
///
///   * backgroundColor is OPAQUE — showModalBottomSheet paints it behind the
///     whole sheet, including behind this padding. Insetting the content is
///     exactly right and leaves no gap. These keep the SafeArea.
///
///   * backgroundColor is TRANSPARENT — the sheet paints its own surface, and
///     only the sheet knows where that surface ends. Insetting from out here
///     can only move the surface up. These are left alone, and the sheet
///     applies the inset INSIDE its own container, which is what
///     TransactionPinModal already does: `Container(decoration) -> SafeArea ->
///     content`. That shape keeps the surface against the bottom edge AND
///     keeps the buttons clear of the navigation bar. It is the shape to copy.
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
    builder: (ctx) => _insetWhenWeOwnTheSurface(backgroundColor, builder, ctx),
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
    // Same rule as showAppBottomSheet: only inset when WE paint the surface.
    _ownsSurface(backgroundColor)
        ? SafeArea(top: false, child: bottomsheet)
        : bottomsheet,
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

/// True when the SHEET MACHINERY paints the surface, so padding the content
/// in from the bottom cannot expose anything behind it.
///
/// A null or fully transparent colour means the sheet paints its own surface;
/// see the note on [showAppBottomSheet] for why that changes who owns the
/// inset.
bool _ownsSurface(Color? backgroundColor) =>
    backgroundColor != null && backgroundColor.a > 0;

Widget _insetWhenWeOwnTheSurface(
  Color? backgroundColor,
  WidgetBuilder builder,
  BuildContext ctx,
) {
  final child = builder(ctx);
  return _ownsSurface(backgroundColor)
      ? SafeArea(top: false, child: child)
      : child;
}
