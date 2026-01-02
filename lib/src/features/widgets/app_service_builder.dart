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
      case AppServiceName.payInvoice:
        // Both invoice services now go to the consolidated screen
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
      case AppServiceName.stocks:
        Get.toNamed(AppRoutes.stocks);
        break;
      case AppServiceName.exchange:
        Get.toNamed(AppRoutes.currencyExchange);
        break;
      case AppServiceName.giftCards:
        Get.toNamed(AppRoutes.giftCards);
        break;
      case AppServiceName.aiScanToPay:
        Get.toNamed(AppRoutes.aiScanToPay);
        break;
      case AppServiceName.barcodeQuickPay:
        Get.toNamed(AppRoutes.barcodeQuickPayHome);
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
      case AppServiceName.autoSave:
        Get.toNamed(AppRoutes.autoSave);
        break;
      case AppServiceName.batchTransfer:
        Get.toNamed(AppRoutes.batchTransfer);
        break;
      case AppServiceName.tagPay:
        Get.toNamed(AppRoutes.tagPay);
        break;
      case AppServiceName.crowdfund:
        Get.toNamed(AppRoutes.crowdfund);
        break;
      case AppServiceName.lockFunds:
        Get.toNamed(AppRoutes.lockFunds);
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
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
        decoration: BoxDecoration(
          color: isHovered
              ? Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: isHovered ? 12 : 6,
              offset: Offset(0, isHovered ? 6 : 2),
              spreadRadius: 0,
            ),
          ],
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
                    Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                    Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.05),
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
      case AppServiceName.tagPay:
        iconData = Icons.tag;
        break;
      case AppServiceName.invoice:
        iconData = Icons.receipt_long;
        break;
      case AppServiceName.payInvoice:
        iconData = Icons.receipt_long; // Same icon as invoice since they're consolidated
        break;
      case AppServiceName.payElectricityBill:
        iconData = Icons.receipt;
        break;
      case AppServiceName.invest:
        iconData = Icons.trending_up;
        break;
      case AppServiceName.stocks:
        iconData = Icons.show_chart;
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
      case AppServiceName.barcodeQuickPay:
        iconData = Icons.qr_code_2;
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
      case AppServiceName.autoSave:
        iconData = Icons.auto_awesome;
        break;
      case AppServiceName.crowdfund:
        iconData = Icons.volunteer_activism;
        break;
      case AppServiceName.lockFunds:
        iconData = Icons.lock_clock;
        break;
    }

    return Icon(
      iconData,
      size: 16.sp,
      color: Color.fromARGB(255, 78, 3, 208),
    );
  }
}

