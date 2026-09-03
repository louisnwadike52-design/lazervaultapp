import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/notifications/notification_navigator.dart';
import 'package:lazervault/core/notifications/notification_service_icon.dart';
import 'package:lazervault/core/notifications/notification_route_resolver.dart';
import 'package:lazervault/core/notifications/notification_target.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/notifications/data/notifications_remote_datasource.dart';
import 'package:lazervault/src/features/notifications/presentation/cubit/notification_badge_cubit.dart';
import 'package:lazervault/src/features/widgets/notifications_builder.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Maps a backend notification `type` to the AppService whose icon the
/// NotificationsBuilder renders. Defaults to a transfer icon for unknown types.

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

/// Notification types that must never surface in this feed even if the backend
/// still persists them (e.g. a not-yet-deployed notifications-service). P2P chat
/// messages belong to the chat inbox — they are push-only here. The server now
/// also excludes these, so this is a client-side safety net for historical rows.
bool _isFeedHidden(String type) {
  final t = type.toLowerCase();
  return t == 'p2p.message' || t == 'p2p_message';
}

class _NotificationScreenState extends State<NotificationScreen> {
  static const int _pageSize = 20;

  late final NotificationsRemoteDataSource _ds;
  final ScrollController _scrollController = ScrollController();

  bool _loading = true; // first-page / full-screen load
  bool _loadingMore = false; // appending a subsequent page
  bool _hasMore = true; // server has more pages to fetch
  String? _error;

  // Accumulated, feed-visible notifications (newest first, deduped by id).
  final List<AppNotification> _all = [];
  final Set<String> _seenIds = <String>{};

  // The RAW server offset — advances by every row the server returns (INCLUDING
  // any hidden rows we filter out client-side) so the next page continues from
  // the correct place regardless of client-side filtering.
  int _rawOffset = 0;

  // Bumped on every full (re)load. An in-flight load-more captures the value at
  // start and discards its result if a refresh happened meanwhile — otherwise a
  // stale page would append onto the freshly-reset list with a wrong offset.
  int _loadGeneration = 0;

  // Opening the feed counts as "viewing" — mark everything read on the server
  // (once) so the bell badge clears and stays cleared across later refreshes.
  bool _viewedMarked = false;

  @override
  void initState() {
    super.initState();
    _ds = NotificationsRemoteDataSource(
      secureStorage: serviceLocator<SecureStorageService>(),
      accountManager: serviceLocator<AccountManager>(),
      localeManager: serviceLocator<LocaleManager>(),
    );
    _scrollController.addListener(_onScroll);
    _load();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    // Trigger a little before the very bottom for a seamless feel.
    if (pos.pixels >= pos.maxScrollExtent - 240) {
      _loadMore();
    }
  }

  /// Full (re)load from the top — used by initState, pull-to-refresh, and after
  /// "mark all as read". Resets pagination state.
  Future<void> _load() async {
    // Invalidate any in-flight load-more so its page can't land on the reset list.
    final gen = ++_loadGeneration;
    setState(() {
      _loading = true;
      _loadingMore = false;
      _error = null;
    });
    _rawOffset = 0;
    _hasMore = true;
    _seenIds.clear();
    _all.clear();
    try {
      final res = await _ds.getNotifications(limit: _pageSize, offset: 0);
      if (!mounted || gen != _loadGeneration) return;
      _rawOffset = res.notifications.length;
      _appendPage(res.notifications);
      _hasMore = _rawOffset < res.total && res.notifications.isNotEmpty;
      setState(() => _loading = false);
      _maybeAutoFill();
      // First successful view → persist read-state + clear the bell badge. Done
      // once (not on every pull-to-refresh) to avoid redundant server writes.
      if (!_viewedMarked) {
        _viewedMarked = true;
        serviceLocator<NotificationBadgeCubit>().markAllViewed();
      }
    } catch (e) {
      if (!mounted || gen != _loadGeneration) return;
      setState(() {
        _error = 'Could not load notifications. Pull to retry.';
        _loading = false;
      });
    }
  }

  /// Append the next page when the user scrolls near the bottom.
  Future<void> _loadMore() async {
    if (_loadingMore || _loading || !_hasMore || _error != null) return;
    final gen = _loadGeneration;
    setState(() => _loadingMore = true);
    try {
      final res =
          await _ds.getNotifications(limit: _pageSize, offset: _rawOffset);
      // A refresh happened mid-flight → discard this stale page. `_load` already
      // reset `_loadingMore`, so don't touch state here.
      if (!mounted || gen != _loadGeneration) return;
      // Advance by the RAW count so the offset stays correct even when the
      // server returns rows we hide client-side. An empty page ends pagination.
      _rawOffset += res.notifications.length;
      final added = _appendPage(res.notifications);
      _hasMore = res.notifications.isNotEmpty && _rawOffset < res.total;
      // Guard: if a page yielded only hidden rows (added 0) but the server still
      // claims more, keep pulling so the user isn't stuck on a hidden-only page.
      final needsAnotherPass =
          added == 0 && res.notifications.isNotEmpty && _hasMore;
      setState(() => _loadingMore = false);
      if (needsAnotherPass) {
        _loadMore();
      } else {
        _maybeAutoFill();
      }
    } catch (_) {
      // A failed load-more shouldn't wipe the list — just stop and let the user
      // retry by scrolling again. Ignore if a refresh superseded this fetch.
      if (!mounted || gen != _loadGeneration) return;
      setState(() => _loadingMore = false);
    }
  }

  /// When a loaded page doesn't fill the viewport (e.g. many hidden rows on an
  /// un-updated backend, or a short first page), the scroll listener can never
  /// fire — so proactively pull the next page until the list is scrollable or
  /// exhausted. Runs after layout so `maxScrollExtent` is accurate.
  void _maybeAutoFill() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_hasMore || _loadingMore || _loading) return;
      if (!_scrollController.hasClients) return;
      if (_scrollController.position.maxScrollExtent <= 0) {
        _loadMore();
      }
    });
  }

  /// Append a fetched page into [_all], dropping feed-hidden types and any id
  /// already shown (new arrivals can shift server offsets and cause overlap).
  /// Returns how many rows were actually added.
  int _appendPage(List<AppNotification> page) {
    var added = 0;
    for (final n in page) {
      if (_isFeedHidden(n.type)) continue;
      if (n.id.isNotEmpty && !_seenIds.add(n.id)) continue;
      _all.add(n);
      added++;
    }
    return added;
  }

  Future<void> _markAllRead() async {
    try {
      await _ds.markAllAsRead();
    } catch (_) {}
    // Keep the dashboard bell badge in sync with the explicit action.
    serviceLocator<NotificationBadgeCubit>().clear();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
        backgroundColor: Color.fromARGB(255, 78, 3, 208),
        behavior: SnackBarBehavior.floating,
      ),
    );
    _load();
  }

  /// Marks a single notification read and refreshes the dashboard bell count.
  /// Best-effort — a failure here must never cost the user the navigation.
  Future<void> _markRead(String id) async {
    try {
      await _ds.markAsRead(id);
      if (serviceLocator.isRegistered<NotificationBadgeCubit>()) {
        serviceLocator<NotificationBadgeCubit>().refresh();
      }
    } catch (_) {}
  }

  NotificationService _toService(AppNotification n) {
    // Resolve the destination up front rather than at tap time: a row whose
    // type this build does not recognise must render as plain text, not as a
    // tappable target that leads nowhere.
    final target = NotificationRouteResolver.resolve(n.type, n.data);

    return NotificationService(
      appService: notificationServiceFor(n.type),
      title: n.title,
      subTitle: n.body,
      date: n.createdAt,
      onTap: target == null ? null : () => _openNotification(n, target),
    );
  }

  /// Opens what a feed row is about, through the same resolver and navigator a
  /// tapped push uses — so the two doors cannot drift apart.
  void _openNotification(AppNotification n, NotificationTarget target) {
    // Reading it in the feed is as much an acknowledgement as tapping the push,
    // so clear the unread state before leaving. Fire-and-forget: a failed
    // mark-read must not block the navigation the user actually asked for.
    if (!n.read && n.id.isNotEmpty) {
      unawaited(_markRead(n.id));
    }

    // This screen is usually presented inside a modal bottom sheet (the bell on
    // the dashboard header and on the card summary both do that), and is also
    // used as a full page and as a tab. Pushing the destination without closing
    // the sheet would leave it stacked underneath, so Back would return to a
    // half-height sheet over the new screen.
    //
    // `PopupRoute` is what distinguishes the sheet case: ModalBottomSheetRoute
    // extends it, while a page route and a tab do not — so this dismisses
    // exactly when there is a sheet to dismiss.
    final modal = ModalRoute.of(context);
    if (modal is PopupRoute && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    // PendingDeepLink navigates on the next frame via GetX's root navigator, so
    // it is unaffected by this screen's context going away with the sheet.
    PendingDeepLink.instance.push(target);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 78, 3, 208),
            size: 20.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Per-service voice + chat icons — pin every session to
          // chat-notifications-service via DIRECT_ROUTES['notifications'].
          // Lets users say "mark all read" / "show unread" / "update
          // notification preferences" via voice or chat.
          ServiceVoiceButton(
            serviceName: 'notifications',
            iconColor: const Color.fromARGB(255, 78, 3, 208),
            backgroundColor: const Color.fromARGB(255, 78, 3, 208),
          ),
          SizedBox(width: 8.w),
          MicroserviceChatIcon(
            serviceName: 'Notifications',
            sourceContext: 'notifications',
            icon: Icons.chat_bubble_outline,
            iconColor: const Color.fromARGB(255, 78, 3, 208),
          ),
          SizedBox(width: 4.w),
          IconButton(
            icon: Icon(
              Icons.settings_outlined,
              color: Color.fromARGB(255, 78, 3, 208),
              size: 24.sp,
            ),
            onPressed: () {
              // Handle notification settings
            },
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(
        child: LazerVaultLoader.small(),
      );
    }
    if (_error != null) {
      return RefreshIndicator(
        onRefresh: _load,
        color: const Color.fromARGB(255, 78, 3, 208),
        child: ListView(
          children: [
            SizedBox(height: 120.h),
            Icon(Icons.cloud_off_rounded, size: 48.sp, color: Colors.grey[400]),
            SizedBox(height: 16.h),
            Text(_error!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600])),
            SizedBox(height: 16.h),
            Center(
              child: TextButton(
                onPressed: _load,
                child: const Text('Retry'),
              ),
            ),
          ],
        ),
      );
    }
    // Derive the date-split sections from the accumulated, feed-visible list.
    final cutoff = DateTime.now().subtract(const Duration(days: 7));
    final recent = <NotificationService>[];
    final older = <NotificationService>[];
    for (final n in _all) {
      (n.createdAt.isAfter(cutoff) ? recent : older).add(_toService(n));
    }
    final isEmpty = recent.isEmpty && older.isEmpty;
    return RefreshIndicator(
      onRefresh: _load,
      color: const Color.fromARGB(255, 78, 3, 208),
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isEmpty)
              Padding(
                padding: EdgeInsets.only(top: 80.h),
                child: _buildNotificationsList(const []),
              )
            else ...[
              if (recent.isNotEmpty) ...[
                _buildSectionHeader(
                  title: "Recent",
                  actionText: "Mark all as read",
                  onActionTap: _markAllRead,
                ),
                SizedBox(height: 16.h),
                _buildNotificationsList(recent),
                SizedBox(height: 32.h),
              ],
              if (older.isNotEmpty) ...[
                _buildSectionHeader(
                  title: "Older",
                  actionText: "Mark all as read",
                  onActionTap: _markAllRead,
                ),
                SizedBox(height: 16.h),
                _buildNotificationsList(older),
                SizedBox(height: 32.h),
              ],
            ],
            _buildPagingFooter(),
          ],
        ),
      ),
    );
  }

  /// Bottom-of-list affordance: a spinner while a page is loading, otherwise
  /// nothing (an exhausted list simply ends). Ensures the user gets visible
  /// feedback that more is loading instead of the list appearing "stuck".
  Widget _buildPagingFooter() {
    if (_loadingMore) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: const Center(child: LazerVaultLoader.small()),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildSectionHeader({
    required String title,
    required String actionText,
    required VoidCallback onActionTap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              letterSpacing: 0.5,
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor:
                  Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
              foregroundColor: Color.fromARGB(255, 78, 3, 208),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              textStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: onActionTap,
            child: Text(actionText),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList(List<NotificationService> notificationsList) {
    if (notificationsList.isEmpty) {
      return Container(
        padding: EdgeInsets.all(32.w),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.notifications_none_outlined,
              size: 48.sp,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16.h),
            Text(
              'No notifications',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'All caught up! Check back later for updates.',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: NotificationsBuilder(notifications: notificationsList),
    );
  }
}
