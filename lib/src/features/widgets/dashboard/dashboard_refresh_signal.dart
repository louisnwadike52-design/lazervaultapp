import 'package:flutter/foundation.dart';

/// App-wide broadcast for an EXPLICIT, user-initiated dashboard refresh
/// (swipe-down → "Refresh accounts").
///
/// Some dashboard sections own their own cubit instance rather than reading one
/// from the widget tree — e.g. [RecentHistory] builds a `serviceLocator`
/// `TransactionHistoryCubit`, which is registered as a **factory**, so a fresh
/// `serviceLocator` lookup from the dashboard would hand back a DIFFERENT
/// instance and refreshing it would never touch what's on screen. Those widgets
/// listen here instead and reload their OWN instance in place.
///
/// Silent/background refreshes (login, app-resume, scroll-into-view, WebSocket)
/// deliberately do NOT fire this — it is reserved for the manual action so those
/// sections only hard-reload (+ revalidate their cache) when the user asks.
class DashboardRefreshSignal {
  DashboardRefreshSignal._();
  static final DashboardRefreshSignal instance = DashboardRefreshSignal._();

  // Monotonic tick; listeners react to any change. A counter (not a bool) so two
  // refreshes in a row are still distinct events.
  final ValueNotifier<int> _tick = ValueNotifier<int>(0);

  /// Subscribe to manual-refresh events.
  ValueListenable<int> get listenable => _tick;

  /// Fire a manual-refresh event to every listener.
  void fire() => _tick.value++;
}
