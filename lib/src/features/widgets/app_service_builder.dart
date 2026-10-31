import 'package:flutter/material.dart';
import 'package:lazervault/src/features/channel_management/presentation/screens/phone_banking_channel_screen.dart';
import 'package:lazervault/src/features/channel_management/presentation/screens/whatsapp_banking_channel_screen.dart';
import 'package:lazervault/src/features/channel_management/cubit/channel_management_cubit.dart';
import 'package:lazervault/src/features/channel_management/presentation/screens/channel_management_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/src/features/pending_actions/domain/pending_action.dart';
import 'package:lazervault/src/features/pending_actions/presentation/cubit/pending_actions_cubit.dart';
import 'package:lazervault/src/features/pending_actions/presentation/widgets/service_pending_badge.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/service_usage_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/shared_widgets/service_unavailable_modal.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/src/features/uplift/presentation/views/uplift_home_screen.dart';

// The service-entry dispatcher (guards + routes) lives here, kept in this
// library so it can still see `_frozenBlockedServices`.
part 'app_service_navigation.dart';

/// Services that MOVE MONEY OUT of the active account (a debit/hold). These are
/// pre-empted when the active account is frozen — the backend already blocks
/// every debit on a frozen account, so this is the matching UX guard (point the
/// user at Details to unfreeze rather than walk them into a doomed flow).
/// Deliberately EXCLUDES view / business-admin / receive / setup services
/// (invoice-create, business dashboards, statements, channel setup, groups)
/// which stay usable while frozen. Incoming money is never blocked.
const Set<AppServiceName> _frozenBlockedServices = {
  AppServiceName.sendFunds,
  AppServiceName.batchTransfer,
  AppServiceName.tagPay,
  AppServiceName.payBills,
  AppServiceName.crypto,
  AppServiceName.rmb,
  AppServiceName.invest,
  AppServiceName.stocks,
  AppServiceName.exchange,
  AppServiceName.giftCards,
  AppServiceName.airtime,
  AppServiceName.data,
  AppServiceName.autoSave,
  AppServiceName.lockFunds,
  AppServiceName.escrow,
  AppServiceName.crowdfund,
  AppServiceName.uplift,
  AppServiceName.payInvoice,
  AppServiceName.rechargeCard,
  AppServiceName.betting,
  AppServiceName.bulkSms,
  AppServiceName.payroll,
  AppServiceName.qrPay,
  AppServiceName.aiScanToPay,
  AppServiceName.contactlessPay,
  AppServiceName.insurance,
};

class AppServiceBuilder extends StatefulWidget {
  const AppServiceBuilder({required this.appService, super.key});
  final AppService appService;

  @override
  State<AppServiceBuilder> createState() => _AppServiceBuilderState();
}

class _AppServiceBuilderState extends State<AppServiceBuilder> {
  bool isHovered = false;

  void _handleGotoService() =>
      openAppService(context, widget.appService.serviceName);

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

  /// The 32×32 soft-purple disc holding the themed material icon, with the
  /// pending-payment count badged on it when this service is owed money.
  ///
  /// The badge is what makes an unpaid tag or invoice findable. Routing every
  /// reminder through the home notification feed means it competes with
  /// marketing and transaction noise, and the ones that actually cost the user
  /// something get lost in it.
  /// Resolved once rather than per build. Null when the locator has no
  /// registration yet — the badge is decorative, and a missing cubit must show
  /// a plain tile, never throw inside build() and blank the whole grid.
  PendingActionsCubit? get _pendingCubit {
    try {
      return serviceLocator<PendingActionsCubit>();
    } catch (_) {
      return null;
    }
  }

  Widget _iconDisc() {
    final cubit = _pendingCubit;
    if (cubit == null) return _plainDisc();
    return BlocBuilder<PendingActionsCubit, PendingActionsSnapshot>(
      bloc: cubit,
      buildWhen: (a, b) =>
          a.countForTile(widget.appService.serviceName) !=
          b.countForTile(widget.appService.serviceName),
      builder: (context, snapshot) {
        final count = snapshot.countForTile(widget.appService.serviceName);
        final disc = _plainDisc();
        if (count <= 0) return disc;
        // Unclipped so the badge can sit proud of the disc without the tile
        // having to reserve space for it (which would shift every other icon).
        return Stack(
          clipBehavior: Clip.none,
          children: [
            disc,
            Positioned(
              top: -4.h,
              right: -4.w,
              child: ServicePendingBadge(count: count),
            ),
          ],
        );
      },
    );
  }

  /// The 32×32 soft-purple disc holding the themed material icon, with no
  /// badge. Rendered on its own when nothing is pending (the common case) and
  /// as the Stack's base when something is.
  Widget _plainDisc() {
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
      case AppServiceName.splitBills:
        iconData = Icons.call_split_rounded;
        break;
      case AppServiceName.escrow:
        iconData = Icons.verified_user;
        break;
      case AppServiceName.invoice:
        iconData = Icons.receipt_long;
        break;
      case AppServiceName.payInvoice:
        iconData = Icons
            .receipt_long; // Same icon as invoice since they're consolidated
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
      case AppServiceName.cardAcceptance:
        iconData = Icons.credit_card;
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
      case AppServiceName.data:
        iconData = Icons.wifi_rounded;
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
      case AppServiceName.bulkSms:
        iconData = Icons.sms_rounded;
        break;
    }

    return Icon(
      iconData,
      size: 16.sp,
      color: Color.fromARGB(255, 78, 3, 208),
    );
  }
}
