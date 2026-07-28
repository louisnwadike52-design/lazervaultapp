import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lazervault/src/features/notifications/data/notifications_remote_datasource.dart';

/// App-wide unread-notifications counter that backs the dashboard bell badge.
///
/// State is a single [int] — the number of unread notifications. It is fed by
/// the SAME `GET /api/v1/notifications` surface the notifications feed uses: the
/// notifications-service already returns an authoritative `unread_count`
/// (computed server-side and excluding `p2p.message`), so the badge can never
/// diverge from the list. Registered as a lazySingleton so every surface shares
/// one instance and updates stay consistent.
class NotificationBadgeCubit extends Cubit<int> {
  NotificationBadgeCubit({required NotificationsRemoteDataSource dataSource})
      : _ds = dataSource,
        super(0);

  final NotificationsRemoteDataSource _ds;
  bool _inFlight = false;

  /// Re-read the authoritative unread count from the server. Cheap: it only
  /// needs the `unread_count` envelope field, so it asks for a single row.
  /// Silent on error — a transient network failure must never clobber a
  /// known-good count with a wrong one.
  Future<void> refresh() async {
    if (_inFlight || isClosed) return;
    _inFlight = true;
    try {
      final res = await _ds.getNotifications(limit: 1, offset: 0);
      if (isClosed) return;
      emit(res.unreadCount < 0 ? 0 : res.unreadCount);
    } catch (_) {
      // Keep the last known count.
    } finally {
      _inFlight = false;
    }
  }

  /// Optimistically clear the badge without a server write. Use for immediate
  /// UI feedback when a stronger, persisted clear ([markAllViewed]) is also
  /// running or has already run.
  void clear() {
    if (!isClosed && state != 0) emit(0);
  }

  /// Persist "all read" on the server AND clear the local badge. Called when the
  /// user opens (views) the notifications feed, so the count stays at zero
  /// across a later [refresh] (e.g. on app resume or an incoming push).
  Future<void> markAllViewed() async {
    clear();
    try {
      await _ds.markAllAsRead();
    } catch (_) {
      // If the server write fails, the next refresh() restores the true count.
    }
  }
}
