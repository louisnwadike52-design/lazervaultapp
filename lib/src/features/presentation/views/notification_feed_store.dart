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

  /// Pull page one off disk into memory, in the background, at launch.
  ///
  /// The feed hydrates itself on open, but that hydrate is ASYNC: on the
  /// first open of a session the sheet animates in, paints a loader, waits
  /// on SharedPreferences and only then shows rows. Doing it at startup
  /// makes peek() hit immediately, so the first open paints in the same
  /// frame as every subsequent one.
  ///
  /// Entirely best-effort. No user signed in yet, nothing stored, a decode
  /// failure — all end the same way: the feed hydrates on open exactly as it
  /// does today. This can make the first open faster and can never make it
  /// slower, which is why the caller does not await it.
  static Future<void> warm() async {
    try {
      final uid = currentUserId();
      if (uid.isEmpty) return;
      await page1.hydrate(userId: uid);
    } catch (_) {/* best-effort: the screen hydrates itself on open */}
  }

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
