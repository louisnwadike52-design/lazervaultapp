import 'package:get/get.dart';

/// Last-known-good `Get.arguments` for one screen.
///
/// THE BUG THIS FIXES
/// ------------------
/// `Get.arguments` is not per-route state. It is a single global that GetX's
/// route observer overwrites on EVERY push and pop, and the guard that keeps
/// a non-page route from changing the current route name does not extend to
/// the arguments (get-4.7.3,
/// `get_navigation/src/routes/observers/route_observer.dart`):
///
/// ```dart
/// if (route is PageRoute) { value.current = newRoute.name ?? ''; }
/// value.args = route.settings.arguments;   // ← runs for ANY route
/// ```
///
/// A `showModalBottomSheet` / `showDialog` route carries no arguments, so for
/// as long as one is open `Get.arguments` is **null**, and it is restored only
/// when that route pops. Any screen underneath that reads the global during
/// that window gets null.
///
/// Eleven screens across internet, cable TV, water, data bundles and
/// airtime-to-cash read it inside `build()` as a NON-NULL cast:
///
/// ```dart
/// final args = Get.arguments as Map<String, dynamic>;   // throws on null
/// ```
///
/// They only have to rebuild once while a sheet is up — a `setState`, a bloc
/// emit, the keyboard changing the view insets — and the cast throws during
/// build. In release that paints the error widget, which is the blank screen
/// people report after closing a share or format-picker sheet.
///
/// HOW THIS FIXES IT
/// -----------------
/// Hold the cache on the `State`, so it lives exactly as long as the screen.
/// Every read takes the global when it is usable and otherwise returns the
/// last good value, so a sheet opening above can no longer blank the page
/// beneath it. Re-navigating to the same screen builds a new `State`, so a
/// genuinely new set of arguments is never masked by an old one.
class RouteArgsCache {
  Map<String, dynamic>? _last;

  /// The screen's arguments: the live ones when GetX still has them, else the
  /// last set seen. Empty only when the screen was opened without any.
  ///
  /// An empty map is deliberately NOT cached: a screen whose first build lands
  /// while a sheet is open would otherwise remember "no arguments" forever.
  Map<String, dynamic> get value {
    final live = Get.arguments;
    if (live is Map<String, dynamic>) {
      if (live.isNotEmpty) _last = live;
      return _last ?? const <String, dynamic>{};
    }
    if (live is Map) {
      final coerced = live.map((k, v) => MapEntry(k.toString(), v));
      if (coerced.isNotEmpty) _last = coerced;
      return _last ?? const <String, dynamic>{};
    }
    return _last ?? const <String, dynamic>{};
  }

  /// True when nothing usable has ever been seen, so a caller can show a
  /// recovery screen instead of rendering a half-empty one.
  bool get isEmpty => value.isEmpty;
}
