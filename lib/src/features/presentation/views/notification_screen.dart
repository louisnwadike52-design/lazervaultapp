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
        serviceName: AppServiceName.requestFunds,
        serviceImg: AppServiceImg.requestFunds),
    title: 'Sent money successfully',
    subTitle: "Money transfer successfully to Account No: 2003898497975797",
    date: DateTime.parse('2023-01-01'),
  ),
  NotificationService(
    appService: AppService(
        serviceName: AppServiceName.requestFunds,
        serviceImg: AppServiceImg.requestFunds),
    title: 'Received Money Successfully',
    subTitle: "Account No: 2003898497975797 has just received payment",
    date: DateTime.now(),
  ),
  NotificationService(
    appService: const AppService(
        serviceName: AppServiceName.crypto,
        serviceImg: AppServiceImg.crypto),
    title: 'Sent money successfully',
    subTitle: "Money transfer successfully to Account No: 2003898497975797",
    date: DateTime.parse('2023-01-01'),
  ),
  NotificationService(
    appService: const AppService(
        serviceName: AppServiceName.crypto,
        serviceImg: AppServiceImg.crypto),
    title: 'Sent money successfully',
    subTitle: "Money transfer successfully to Account No: 2003898497975797",
    date: DateTime.parse('2023-01-01'),
  ),
  NotificationService(
    appService: const AppService(
        serviceName: AppServiceName.crypto,
        serviceImg: AppServiceImg.crypto),
    title: 'Sent money successfully',
    subTitle: "Money transfer successfully to Account No: 2003898497975797",
    date: DateTime.parse('2023-01-01'),
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
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                  textStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onPressed: () {},
                child: const Text('Mark all as read'),
              ),
            ],
          ),
          NotificationsBuilder(notifications: notifications),
          SizedBox(height: 16.0.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Older",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          NotificationsBuilder(notifications: notifications)
        ],
      ),
    );
  }
}
