import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/src/features/widgets/notifications_builder.dart';

final List<NotificationService> notifications = [
  NotificationService(
    appService: const AppService(
        serviceName: AppServiceName.sendFunds,
        serviceImg: AppServiceImg.sendFunds),
    title: 'Received Money Successfully',
    subTitle: "Account No: 2003898497975797 has just received payment",
    date: DateTime.now(),
  ),
  NotificationService(
    appService: const AppService(
        serviceName: AppServiceName.invoice,
        serviceImg: AppServiceImg.invoice),
    title: 'Invoice Payment Received',
    subTitle: "Invoice #INV-2024-001 has been paid successfully",
    date: DateTime.now().subtract(Duration(hours: 2)),
  ),
  NotificationService(
    appService: const AppService(
        serviceName: AppServiceName.invoice,
        serviceImg: AppServiceImg.invoice),
    title: 'New Invoice Created',
    subTitle: "Invoice #INV-2024-002 created for client John Doe",
    date: DateTime.now().subtract(Duration(hours: 5)),
  ),
  NotificationService(
    appService: const AppService(
        serviceName: AppServiceName.crypto,
        serviceImg: AppServiceImg.crypto),
    title: 'Crypto Transaction Complete',
    subTitle: "Bitcoin purchase of 0.001 BTC completed successfully",
    date: DateTime.now().subtract(Duration(days: 1)),
  ),
  NotificationService(
    appService: const AppService(
        serviceName: AppServiceName.payInvoice,
        serviceImg: AppServiceImg.payInvoice),
    title: 'Invoice Payment Completed',
    subTitle: "Invoice payment successfully processed for £2,500.00",
    date: DateTime.now().subtract(Duration(days: 1)),
  ),
  NotificationService(
    appService: const AppService(
        serviceName: AppServiceName.giftCards,
        serviceImg: AppServiceImg.giftCards),
    title: 'Gift Card Purchased',
    subTitle: "Amazon gift card purchased successfully - \$50",
    date: DateTime.now().subtract(Duration(days: 2)),
  ),
];

final List<NotificationService> olderNotifications = [
  NotificationService(
    appService: const AppService(
        serviceName: AppServiceName.payElectricityBill,
        serviceImg: AppServiceImg.payElectricityBill),
    title: 'Electricity Bill Paid',
    subTitle: "Monthly electricity bill payment completed",
    date: DateTime.now().subtract(Duration(days: 7)),
  ),
  NotificationService(
    appService: const AppService(
        serviceName: AppServiceName.invest,
        serviceImg: AppServiceImg.invest),
    title: 'Investment Portfolio Update',
    subTitle: "Your portfolio gained +2.5% this week",
    date: DateTime.now().subtract(Duration(days: 10)),
  ),
  NotificationService(
    appService: const AppService(
        serviceName: AppServiceName.exchange,
        serviceImg: AppServiceImg.exchange),
    title: 'Currency Exchange Complete',
    subTitle: "Exchanged USD to EUR successfully",
    date: DateTime.now().subtract(Duration(days: 14)),
  ),
];

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Recent Section
            _buildSectionHeader(
              title: "Recent",
              actionText: "Mark all as read",
              onActionTap: () {
                // Handle mark all as read
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('All notifications marked as read'),
                    backgroundColor: Color.fromARGB(255, 78, 3, 208),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            SizedBox(height: 16.h),
            _buildNotificationsList(notifications),
            
            SizedBox(height: 32.h),
            
            // Older Section
            _buildSectionHeader(
              title: "Older",
              actionText: "Clear all",
              onActionTap: () {
                _showClearDialog();
              },
            ),
            SizedBox(height: 16.h),
            _buildNotificationsList(olderNotifications),
            
            SizedBox(height: 32.h),
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
              backgroundColor: Color.fromARGB(255, 78, 3, 208).withOpacity(0.1),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: NotificationsBuilder(notifications: notificationsList),
    );
  }

  void _showClearDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Clear All Notifications',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          content: Text(
            'Are you sure you want to clear all older notifications? This action cannot be undone.',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  olderNotifications.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Older notifications cleared'),
                    backgroundColor: Color.fromARGB(255, 78, 3, 208),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 78, 3, 208),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              ),
              child: Text(
                'Clear All',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
