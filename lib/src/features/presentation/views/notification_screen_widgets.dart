part of 'notification_screen.dart';

// Moved verbatim out of _NotificationScreenState: neither builder reads any
// state, so a top-level function in a `part` (same private scope, same
// imports) is the identical program with a shorter screen file.

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

/// The feed's app bar. Moved verbatim out of build(): it reads no state,
/// only the context it navigates with.
PreferredSizeWidget _notificationsAppBar(BuildContext context) {
  return AppBar(
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
      // Chat only. The voice button was removed: a notifications list is a
      // reading surface, and three header controls on it crowded out the
      // one that matters.
      //
      // Service name is lowercase to match DIRECT_ROUTES['notifications']
      // and the per-service feature-flag slug, so the icon's visibility
      // flag and its routing key cannot disagree.
      MicroserviceChatIcon(
        serviceName: 'notifications',
        sourceContext: 'notifications',
        icon: Icons.chat_bubble_outline,
        iconColor: const Color.fromARGB(255, 78, 3, 208),
      ),
      SizedBox(width: 4.w),
      IconButton(
        tooltip: 'Notification settings',
        icon: Icon(
          Icons.settings_outlined,
          color: const Color.fromARGB(255, 78, 3, 208),
          size: 24.sp,
        ),
        // Was an empty callback with a `// Handle notification settings`
        // comment — a control that looked live and did nothing. The
        // preferences live in the settings screen's
        // "Notifications & Display" section.
        onPressed: () => Get.toNamed(AppRoutes.profileSettings),
      ),
      SizedBox(width: 8.w),
    ],
  );
}
