import 'package:flutter/widgets.dart';

/// WHAT IS ACTUALLY ON THE NAVIGATOR STACK.
///
/// Flutter's [Navigator] keeps its history private and GetX only publishes the
/// CURRENT route, so nothing in the app could answer the one question the back
/// button depends on: "is the dashboard still underneath me?"
///
/// It matters because `Get.offAllNamed(x)` leaves a stack of exactly ONE
/// route. The in-app back arrow on that screen still works — it is wired to a
/// route of its own — but the OS back button and the iOS edge swipe pop the
/// only route there is, and Android then CLOSES THE APP. Reported on tag pay:
/// create a tag, press the phone's back button, and the user is on their home
/// screen.
///
/// Registering this observer is cheap — two list operations per navigation —
/// and it turns that question into a lookup, so [offAllKeepingHome] can keep
/// the dashboard beneath a completed flow without rebuilding it when it is
/// already there.
class NavStackObserver extends NavigatorObserver {
  /// Bottom-first. Routes with no name (anonymous dialogs, sheets pushed by
  /// `Get.dialog`) are recorded as null so positions still line up.
  static final List<String?> _stack = <String?>[];

  /// A read-only view, bottom first.
  static List<String?> get stack => List.unmodifiable(_stack);

  /// Whether [routeName] is somewhere on the stack.
  static bool contains(String routeName) => _stack.contains(routeName);

  /// How many routes are on the stack. 1 means the OS back button exits.
  static int get depth => _stack.length;

  /// TEST SEAM. The observer is only driven by a real Navigator, so tests that
  /// exercise the decision rather than the widget tree set the stack directly.
  @visibleForTesting
  static void debugSetStack(List<String?> names) {
    _stack
      ..clear()
      ..addAll(names);
  }

  static String? _name(Route<dynamic>? route) => route?.settings.name;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _stack.add(_name(route));
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _removeLast(_name(route));
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _removeLast(_name(route));
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final i = _stack.lastIndexOf(_name(oldRoute));
    if (i >= 0) {
      _stack[i] = _name(newRoute);
      return;
    }
    _stack.add(_name(newRoute));
  }

  /// Remove the TOPMOST entry with this name.
  ///
  /// By name rather than by position: `pushNamedAndRemoveUntil` pushes first
  /// and then removes the routes below, so the removals do not arrive
  /// top-down and blindly dropping `_stack.last` would discard the route that
  /// is still on screen.
  void _removeLast(String? name) {
    final i = _stack.lastIndexOf(name);
    if (i >= 0) {
      _stack.removeAt(i);
      return;
    }
    if (_stack.isNotEmpty) _stack.removeLast();
  }
}
