import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/services.dart';

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
      case AppServiceName.invoice:
        Get.toNamed(AppRoutes.invoice);
        break;
      case AppServiceName.payElectricityBill:
        Get.toNamed(AppRoutes.payElectricityBill);
        break;
      case AppServiceName.crypto:
        Get.toNamed(AppRoutes.crypto);
        break;
      case AppServiceName.invest:
        Get.toNamed(AppRoutes.investments);
        break;
      case AppServiceName.exchange:
        Get.toNamed(AppRoutes.cbCurrencyExchange);
        break;
      case AppServiceName.payInvoice:
        Get.toNamed(AppRoutes.payInvoice);
        break;
      case AppServiceName.giftCards:
        Get.toNamed(AppRoutes.giftCards);
        break;
      case AppServiceName.aiScanToPay:
        Get.toNamed(AppRoutes.aiScanToPay);
        break;
      case AppServiceName.groupAccount:
        Get.toNamed(AppRoutes.groupAccount);
        break;
      case AppServiceName.insurance:
        Get.toNamed(AppRoutes.insurance);
        break;
      case AppServiceName.airtime:
        Get.toNamed(AppRoutes.airtime);
        break;
      case AppServiceName.batchTransfer:
        Get.toNamed(AppRoutes.batchTransfer);
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
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: isHovered
              ? Color.fromARGB(255, 78, 3, 208).withOpacity(0.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
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
              width: 32.w,
              height: 32.w,
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
                child: _buildServiceIcon(),
              ),
            ),
            SizedBox(height: 8.h),

            // Service Name
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Text(
                  widget.appService.serviceName.displayName,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.sp,
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

  Widget _buildServiceIcon() {
    IconData iconData;
    switch (widget.appService.serviceName) {
      case AppServiceName.sendFunds:
        iconData = Icons.send;
        break;
      case AppServiceName.batchTransfer:
        iconData = Icons.batch_prediction;
        break;
      case AppServiceName.invoice:
        iconData = Icons.receipt_long;
        break;
      case AppServiceName.payInvoice:
        iconData = Icons.payment;
        break;
      case AppServiceName.payElectricityBill:
        iconData = Icons.receipt;
        break;
      case AppServiceName.invest:
        iconData = Icons.trending_up;
        break;
      case AppServiceName.exchange:
        iconData = Icons.currency_exchange;
        break;
      case AppServiceName.crypto:
        iconData = Icons.currency_bitcoin;
        break;
      case AppServiceName.giftCards:
        iconData = Icons.card_giftcard;
        break;
      case AppServiceName.aiScanToPay:
        iconData = Icons.qr_code_scanner;
        break;
      case AppServiceName.groupAccount:
        iconData = Icons.groups;
        break;
      case AppServiceName.insurance:
        iconData = Icons.shield_outlined;
        break;
      case AppServiceName.airtime:
        iconData = Icons.phone_android;
        break;
    }

    return Icon(
      iconData,
      size: 16.sp,
      color: Color.fromARGB(255, 78, 3, 208),
    );
  }
}
