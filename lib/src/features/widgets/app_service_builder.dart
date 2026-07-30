import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/src/features/uplift/presentation/views/uplift_home_screen.dart';

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
      case AppServiceName.payBills:
        Get.toNamed(AppRoutes.billsHub);
        break;
      case AppServiceName.crypto:
        Get.toNamed(AppRoutes.crypto);
        break;
      case AppServiceName.rmb:
        Get.toNamed(AppRoutes.rmb);
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
      case AppServiceName.qrPay:
        Get.toNamed(AppRoutes.qrPayHome);
        break;
      case AppServiceName.contactlessPay:
        Get.toNamed(AppRoutes.contactlessPay);
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
        // Same screen renders short vs long; admin-gated via cached FeatureFlags.
        Get.toNamed(
          AppRoutes.batchTransfer,
          arguments: {'shortFlow': FeatureFlags.batchTransferShortFlow},
        );
        break;
      case AppServiceName.tagPay:
        Get.toNamed(AppRoutes.tagPay);
        break;
      case AppServiceName.escrow:
        Get.toNamed(AppRoutes.escrow);
        break;
      case AppServiceName.crowdfund:
        Get.toNamed(AppRoutes.crowdfund);
        break;
      case AppServiceName.uplift:
        Get.to(() => const UpliftHomeScreen());
        break;
      case AppServiceName.lockFunds:
        Get.toNamed(AppRoutes.lockFunds);
        break;
      case AppServiceName.whatsappIntegration:
        Get.toNamed(AppRoutes.whatsappBanking);
        break;
      case AppServiceName.phoneBanking:
        Get.toNamed(AppRoutes.channelManagement);
        break;
      case AppServiceName.idPay:
        Get.toNamed(AppRoutes.idPayHome);
        break;
      case AppServiceName.sendFunds:
        // Both modes use the SAME select-recipients screen; short flow renders
        // the add-recipient inline + runs amount→PIN→receipt on that screen.
        // The user's transfer-style choice (classic/standard) wins over the
        // admin platform default — see FeatureFlags.useShortSendFlow.
        Get.toNamed(
          AppRoutes.selectRecipient,
          arguments: {'shortFlow': FeatureFlags.sendFlowShortForSession},
        );
        break;
      case AppServiceName.payroll:
        Get.toNamed(AppRoutes.payroll);
        break;
      case AppServiceName.businessDashboard:
        Get.toNamed(AppRoutes.businessDashboard);
        break;
      case AppServiceName.businessAnalytics:
        Get.toNamed(AppRoutes.businessAnalytics);
        break;
      case AppServiceName.customers:
        Get.toNamed(AppRoutes.customers);
        break;
      case AppServiceName.inventory:
        Get.toNamed(AppRoutes.inventory);
        break;
      case AppServiceName.tax:
        Get.toNamed(AppRoutes.taxDashboard);
        break;
      case AppServiceName.expenses:
        Get.toNamed(AppRoutes.expenses);
        break;
      case AppServiceName.sales:
        Get.toNamed(AppRoutes.sales);
        break;
      case AppServiceName.rechargeCard:
        Get.toNamed(AppRoutes.epinHome);
        break;
      case AppServiceName.betting:
        Get.toNamed(AppRoutes.bettingHome);
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
            // Themed service icon on a soft brand disc.
            _iconDisc(),
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

  /// The 32×32 soft-purple disc holding the themed material icon.
  Widget _iconDisc() {
    return Container(
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
      child: Center(child: _buildServiceIcon()),
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
      case AppServiceName.escrow:
        iconData = Icons.verified_user;
        break;
      case AppServiceName.invoice:
        iconData = Icons.receipt_long;
        break;
      case AppServiceName.payInvoice:
        iconData = Icons.receipt_long; // Same icon as invoice since they're consolidated
        break;
      case AppServiceName.payBills:
        iconData = Icons.receipt_long;
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
      case AppServiceName.rmb:
        iconData = Icons.currency_yuan;
        break;
      case AppServiceName.giftCards:
        iconData = Icons.card_giftcard;
        break;
      case AppServiceName.aiScanToPay:
        iconData = Icons.qr_code_scanner;
        break;
      case AppServiceName.qrPay:
        iconData = Icons.qr_code_2;
        break;
      case AppServiceName.contactlessPay:
        iconData = Icons.contactless;
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
      case AppServiceName.uplift:
        iconData = Icons.rocket_launch;
        break;
      case AppServiceName.lockFunds:
        iconData = Icons.lock_clock;
        break;
      case AppServiceName.whatsappIntegration:
        iconData = Icons.chat_bubble;
        break;
      case AppServiceName.phoneBanking:
        iconData = Icons.phone_in_talk;
        break;
      case AppServiceName.idPay:
        iconData = Icons.fingerprint;
        break;
      case AppServiceName.payroll:
        iconData = Icons.payments;
        break;
      case AppServiceName.businessDashboard:
        iconData = Icons.dashboard_rounded;
        break;
      case AppServiceName.businessAnalytics:
        iconData = Icons.analytics_rounded;
        break;
      case AppServiceName.customers:
        iconData = Icons.people_rounded;
        break;
      case AppServiceName.expenses:
        iconData = Icons.account_balance_wallet_rounded;
        break;
      case AppServiceName.inventory:
        iconData = Icons.inventory_2_rounded;
        break;
      case AppServiceName.tax:
        iconData = Icons.account_balance_rounded;
        break;
      case AppServiceName.sales:
        iconData = Icons.point_of_sale_rounded;
        break;
      case AppServiceName.rechargeCard:
        iconData = Icons.confirmation_number;
        break;
      case AppServiceName.betting:
        iconData = Icons.sports_soccer;
        break;
    }

    return Icon(
      iconData,
      size: 16.sp,
      color: Color.fromARGB(255, 78, 3, 208),
    );
  }
}

