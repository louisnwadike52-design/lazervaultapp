import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/src/features/widgets/app_service_builder.dart';

class AppServicesBuilder extends StatefulWidget {
  const AppServicesBuilder({super.key});

  @override
  State<AppServicesBuilder> createState() => _AppServicesBuilderState();
}

class _AppServicesBuilderState extends State<AppServicesBuilder> {
  final List<AppService> appServices = [
    const AppService(
        serviceName: AppServiceName.sendFunds,
        serviceImg: AppServiceImg.sendFunds),
    const AppService(
        serviceName: AppServiceName.invoice,
        serviceImg: AppServiceImg.invoice),
    const AppService(
        serviceName: AppServiceName.transferFunds,
        serviceImg: AppServiceImg.transferFunds),
    const AppService(
        serviceName: AppServiceName.payElectricityBill,
        serviceImg: AppServiceImg.payElectricityBill),
    const AppService(
        serviceName: AppServiceName.invest,
        serviceImg: AppServiceImg.invest),
    const AppService(
        serviceName: AppServiceName.exchange,
        serviceImg: AppServiceImg.exchange),
    const AppService(
        serviceName: AppServiceName.crypto,
        serviceImg: AppServiceImg.crypto),
    const AppService(
        serviceName: AppServiceName.giftCards,
        serviceImg: AppServiceImg.giftCards),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Quick Services",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 78, 3, 208),
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 78, 3, 208).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "View All",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 78, 3, 208),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 14.sp,
                      color: Color.fromARGB(255, 78, 3, 208),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Services Grid
          GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.65,
            ),
            itemCount: appServices.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return AppServiceBuilder(appService: appServices[index]);
            },
          ),
        ],
      ),
    );
  }
}
