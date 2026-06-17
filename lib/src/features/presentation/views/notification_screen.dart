import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/notifications/data/notifications_remote_datasource.dart';
import 'package:lazervault/src/features/widgets/notifications_builder.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Maps a backend notification `type` to the AppService whose icon the
/// NotificationsBuilder renders. Defaults to a transfer icon for unknown types.
AppService _appServiceForType(String type) {
  switch (type.toLowerCase()) {
    case 'transfer':
    case 'payment':
    case 'deposit':
    case 'withdrawal':
      return const AppService(
          serviceName: AppServiceName.sendFunds,
          serviceImg: AppServiceImg.sendFunds);
    case 'investment':
      return const AppService(
          serviceName: AppServiceName.invest, serviceImg: AppServiceImg.invest);
    case 'giftcard':
      return const AppService(
          serviceName: AppServiceName.giftCards,
          serviceImg: AppServiceImg.giftCards);
    case 'bill':
      return const AppService(
          serviceName: AppServiceName.payBills,
          serviceImg: AppServiceImg.payBills);
    case 'invoice':
      return const AppService(
          serviceName: AppServiceName.invoice,
          serviceImg: AppServiceImg.invoice);
    case 'security':
    case 'account':
    default:
      return const AppService(
          serviceName: AppServiceName.phoneBanking,
          serviceImg: AppServiceImg.phoneBanking);
  }
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final NotificationsRemoteDataSource _ds;
  bool _loading = true;
  String? _error;
  List<NotificationService> _recent = [];
  List<NotificationService> _older = [];

  @override
  void initState() {
    super.initState();
    _ds = NotificationsRemoteDataSource(
      secureStorage: serviceLocator<SecureStorageService>(),
      accountManager: serviceLocator<AccountManager>(),
      localeManager: serviceLocator<LocaleManager>(),
    );
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final res = await _ds.getNotifications(limit: 50);
      if (!mounted) return;
      final cutoff = DateTime.now().subtract(const Duration(days: 7));
      final recent = <NotificationService>[];
      final older = <NotificationService>[];
      for (final n in res.notifications) {
        final item = NotificationService(
          appService: _appServiceForType(n.type),
          title: n.title,
          subTitle: n.body,
          date: n.createdAt,
        );
        (n.createdAt.isAfter(cutoff) ? recent : older).add(item);
      }
      setState(() {
        _recent = recent;
        _older = older;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Could not load notifications. Pull to retry.';
        _loading = false;
      });
    }
  }

  Future<void> _markAllRead() async {
    try {
      await _ds.markAllAsRead();
    } catch (_) {}
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
            Icon(Icons.cloud_off_rounded,
                size: 48.sp, color: Colors.grey[400]),
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
    final isEmpty = _recent.isEmpty && _older.isEmpty;
    return RefreshIndicator(
      onRefresh: _load,
      color: const Color.fromARGB(255, 78, 3, 208),
      child: SingleChildScrollView(
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
              if (_recent.isNotEmpty) ...[
                _buildSectionHeader(
                  title: "Recent",
                  actionText: "Mark all as read",
                  onActionTap: _markAllRead,
                ),
                SizedBox(height: 16.h),
                _buildNotificationsList(_recent),
                SizedBox(height: 32.h),
              ],
              if (_older.isNotEmpty) ...[
                _buildSectionHeader(
                  title: "Older",
                  actionText: "Mark all as read",
                  onActionTap: _markAllRead,
                ),
                SizedBox(height: 16.h),
                _buildNotificationsList(_older),
                SizedBox(height: 32.h),
              ],
            ],
          ],
        ),
      ),
    );
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
              backgroundColor: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
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
