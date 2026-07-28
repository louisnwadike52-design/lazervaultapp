import 'package:flutter/material.dart';

/// Process-global suppression for the inactivity auto-logout ([InactivityWatcher]).
///
/// Some surfaces are legitimately "engaged but idle" — the user may sit on the
/// chatbot reading a long reply, or on the financial-connections page, with no
/// pointer/scroll/keyboard interaction for a while. On those pages we must NOT
/// auto-logout; it re-enables the moment the user navigates away.
///
/// Voice sessions are already exempted separately (see `VoiceSessionActivity`),
/// so this guard covers the chatbot + financial-connection surfaces.
///
/// **Leak-safe by design.** A suppression that never clears would silently
/// disable auto-logout for the whole session — a security regression. So instead
/// of a plain counter we hold *predicates*: each is evaluated FRESH every time
/// the watcher checks (i.e. only at the moment the idle timer fires). A page that
/// is kept alive off-screen (a dashboard tab) therefore stops suppressing as soon
/// as its predicate reports it is no longer the active surface — even if the
/// registration was never removed. Push/pop routes and sheets additionally remove
/// their registration on dispose (via [AutoLogoutSuppressed]).
class AutoLogoutGuard {
  AutoLogoutGuard._();

  static final List<bool Function()> _predicates = <bool Function()>[];

  /// Register [active] as a suppression predicate. While ANY registered predicate
  /// returns true, auto-logout is deferred. Returns a disposer that removes it —
  /// call it from the page's `dispose`.
  static VoidCallback register(bool Function() active) {
    _predicates.add(active);
    return () => _predicates.remove(active);
  }

  /// True when at least one registered surface is currently active. Evaluated
  /// lazily/fresh; a throwing predicate is treated as "not suppressing" so a bad
  /// predicate can never wedge auto-logout OFF.
  static bool get isSuppressed {
    for (final p in _predicates) {
      try {
        if (p()) return true;
      } catch (_) {
        // A broken predicate must never keep the user logged in forever.
      }
    }
    return false;
  }
}

/// Wrap a route/sheet body in this to suppress auto-logout while it is on screen.
/// `dispose` (which always fires when the route is popped / the sheet is closed)
/// removes the suppression, so auto-logout re-enables on navigate-away. Use this
/// for pushed screens and bottom sheets; for a kept-alive dashboard tab register
/// a route/tab-aware predicate directly via [AutoLogoutGuard.register] instead.
class AutoLogoutSuppressed extends StatefulWidget {
  final Widget child;
  const AutoLogoutSuppressed({super.key, required this.child});

  @override
  State<AutoLogoutSuppressed> createState() => _AutoLogoutSuppressedState();
}

class _AutoLogoutSuppressedState extends State<AutoLogoutSuppressed> {
  VoidCallback? _release;

  @override
  void initState() {
    super.initState();
    _release = AutoLogoutGuard.register(() => true);
  }

  @override
  void dispose() {
    _release?.call();
    _release = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
