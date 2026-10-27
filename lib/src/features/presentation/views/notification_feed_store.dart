import 'package:lazervault/core/cache/session_page_store.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/notifications/data/notifications_remote_datasource.dart';

/// Page one of the notifications feed, remembered across opens.
///
/// WHY: the feed fetched `GET /api/v1/notifications` on EVERY open and sat on
/// a full-screen loader until it answered — over a list the user had looked at
/// moments ago. The first page is painted from here at once, page one is
/// refreshed behind it, and a row whose read state changed server-side is
/// replaced in place when the fresh page lands.
///
/// The RAW server page is stored (hidden types and all) so the pagination
/// offset derived from it stays correct; the screen filters on paint, as it
/// always has. Per user (stamped), mirrored to SharedPreferences for a cold
/// start, and cleared with every other SessionPageStore on a user switch.
class NotificationFeedStore {
  NotificationFeedStore._();

  static final SessionPageStore<AppNotification> page1 =
      SessionPageStore<AppNotification>(
    'notifications_page1',
    toJson: notificationToJson,
    fromJson: AppNotification.fromJson,
  );

  /// Whoever is signed in, or '' when nobody is — the store then refuses to
  /// remember and the feed behaves exactly as it did before.
  static String currentUserId() {
    try {
      if (serviceLocator.isRegistered<AuthenticationCubit>()) {
        return serviceLocator<AuthenticationCubit>().userId ?? '';
      }
    } catch (_) {/* best-effort */}
    return '';
  }
}

/// The inverse of [AppNotification.fromJson], in the wire's own field names so
/// the one parser serves both the API and the mirror. `created_at` goes out
/// as UTC ISO-8601 because fromJson calls `.toLocal()` on what it reads.
Map<String, dynamic> notificationToJson(AppNotification n) => {
      'id': n.id,
      'type': n.type,
      'title': n.title,
      'body': n.body,
      'read': n.read,
      'created_at': n.createdAt.toUtc().toIso8601String(),
      'data': n.data,
      'reference_id': n.referenceId,
    };
