import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/core/types/transaction.dart'; // Import Transaction type
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';

class AppServiceBuilder extends StatefulWidget {
  const AppServiceBuilder({required this.appService, super.key});
  final AppService appService;

  @override
  State<AppServiceBuilder> createState() => _AppServiceBuilderState();
}

class _AppServiceBuilderState extends State<AppServiceBuilder> {
  bool isHovered = false;

  void _handleGotoService() {
    switch (widget.appService.serviceName) {
      case AppServiceName.requestFunds:
        Get.toNamed(AppRoutes.requestFunds);
        break;
      case AppServiceName.payElectricityBill:
        Get.toNamed(AppRoutes.payElectricityBill);
        break;
      case AppServiceName.crypto:
        Get.toNamed(AppRoutes.crypto);
        break;
      case AppServiceName.stocks:
        Get.toNamed(AppRoutes.stocks);
        break;
      case AppServiceName.exchange:
        Get.toNamed(AppRoutes.cbCurrencyExchange);
        break;
      case AppServiceName.transferFunds:
        final userArg = User(
          id: "4454",
          firstName: "John",
          lastName: "Doe",
          email: 'john.doe@example.com',
          verified: false,
          isEmailVerified: false,
          createdAt: DateTime.fromMillisecondsSinceEpoch(0),
          updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
        );
        final transaction = TransferTransaction(
          type: TransactionType.billPay,
          amount: 5000,
          accountNo: '1234567890',
          transactionId: 'txn12345',
          dateTime: DateTime.now(),
          notes: 'Sample transaction',
          status: TransactionStatus.pending,
          user: userArg,
        );

        Get.toNamed(
          AppRoutes.transferFunds,
          arguments: {
            'user': userArg,
            'transaction': transaction,
          },
        );
        break;
      case AppServiceName.giftCards:
        Get.toNamed(AppRoutes.giftCards);
        break;
      case AppServiceName.sendFunds:
      default:
        Get.toNamed(AppRoutes.selectRecipient);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleGotoService,
      onTapDown: (_) => setState(() => isHovered = true),
      onTapUp: (_) => setState(() => isHovered = false),
      onTapCancel: () => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: isHovered
              ? Color.fromARGB(255, 78, 3, 208).withOpacity(0.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isHovered
                ? Color.fromARGB(255, 78, 3, 208).withOpacity(0.2)
                : Colors.grey[100]!,
            width: 1.5,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: Color.fromARGB(255, 78, 3, 208).withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Service Icon
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 78, 3, 208).withOpacity(0.1),
                    Color.fromARGB(255, 78, 3, 208).withOpacity(0.05),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  widget.appService.serviceImg.uri,
                  height: 24.h,
                  width: 24.w,
                  color: Color.fromARGB(255, 78, 3, 208),
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Service Name
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  widget.appService.serviceName.displayName,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                    color: isHovered
                        ? Color.fromARGB(255, 78, 3, 208)
                        : Colors.black87,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
