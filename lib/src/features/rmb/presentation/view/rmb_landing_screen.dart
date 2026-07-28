import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/generated/rmb.pb.dart';
import 'package:lazervault/src/features/rmb/cubit/rmb_cubit.dart';
import 'package:lazervault/src/features/rmb/presentation/rmb_ui.dart';
import 'package:lazervault/src/features/rmb/presentation/widgets/rmb_send_sheet.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';

/// RMB service landing — hero (indicative rate + provider), quick actions,
/// and recent payouts. All rails/provider shown here are what the pinned
/// provider supports; the send flow reuses the same config.
class RmbLandingScreen extends StatefulWidget {
  const RmbLandingScreen({super.key});

  @override
  State<RmbLandingScreen> createState() => _RmbLandingScreenState();
}

class _RmbLandingScreenState extends State<RmbLandingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RmbCubit>().load();
  }

  void _openSend(RmbRail rail) => showRmbSendSheet(
        context,
        rail: rail,
        cubit: context.read<RmbCubit>(),
      ).then((_) {
        // A completed payout changes the recent-transfers list.
        if (mounted) context.read<RmbCubit>().refresh();
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RmbUi.bg,
      body: SafeArea(
        child: RefreshIndicator(
          color: RmbUi.accent,
          onRefresh: () => context.read<RmbCubit>().refresh(),
          child: BlocBuilder<RmbCubit, RmbState>(
            builder: (context, state) {
              return CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: _header()),
                  if (state is RmbLoading || state is RmbInitial)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: CircularProgressIndicator(color: RmbUi.accent),
                      ),
                    ),
                  if (state is RmbError)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: _error(state.message),
                    ),
                  if (state is RmbLoaded) ...[
                    SliverToBoxAdapter(child: _hero(state.config)),
                    SliverToBoxAdapter(child: _sectionTitle('Send with')),
                    SliverToBoxAdapter(child: _railsSection(state.config)),
                    SliverToBoxAdapter(
                        child: _recentHeader(state)),
                    _transfers(state),
                    const SliverToBoxAdapter(child: SizedBox(height: 32)),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _header() => Padding(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 4.h),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                height: 34.h,
                width: 34.w,
                decoration: BoxDecoration(
                  color: RmbUi.card,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.arrow_back, color: Colors.white, size: 18.sp),
              ),
            ),
            SizedBox(width: 12.w),
            Text('RMB Transfer',
                style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            const Spacer(),
            ServiceVoiceButton(
              serviceName: 'rmb',
              iconColor: RmbUi.accent,
              backgroundColor: RmbUi.accent,
              buttonSize: 34.w,
              iconSize: 17.sp,
            ),
            SizedBox(width: 8.w),
            MicroserviceChatIcon(
              serviceName: 'RMB Transfer',
              sourceContext: 'rmb',
              iconColor: RmbUi.accent,
              size: 34,
              iconSize: 17,
            ),
          ],
        ),
      );

  Widget _hero(ProviderConfigResponse config) {
    final rate = config.indicativeFxRate;
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: RmbUi.heroGradient,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.currency_yuan, color: Colors.white, size: 22.sp),
              SizedBox(width: 8.w),
              Text('Pay China in Yuan',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700)),
              const Spacer(),
              if (config.maintenance)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Text('Maintenance',
                      style: TextStyle(color: Colors.orange, fontSize: 11.sp)),
                ),
            ],
          ),
          SizedBox(height: 18.h),
          Text('Rates from',
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7), fontSize: 11.sp)),
          SizedBox(height: 4.h),
          Text(
              rate > 0
                  ? '₦${rate.toStringAsFixed(2)} / ¥1'
                  : 'Locked in at checkout',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  /// Payment rails directly on the landing — tapping one opens the two-step
  /// send sheet. Alipay and WeChat lead; UnionPay + bank sit on a compact row.
  Widget _railsSection(ProviderConfigResponse config) {
    final disabled = config.maintenance;
    final enabled = config.rails
        .where((r) => r.enabled && r.rail != RmbRail.RAIL_UNSPECIFIED)
        .map((r) => r.rail)
        .toSet();
    final wallets =
        [RmbRail.ALIPAY, RmbRail.WECHAT].where(enabled.contains).toList();
    final others =
        [RmbRail.UNIONPAY, RmbRail.BANK].where(enabled.contains).toList();
    if (wallets.isEmpty && others.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Text('No payment methods are currently available.',
            style: TextStyle(color: RmbUi.textSecondary, fontSize: 13.sp)),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          if (wallets.isNotEmpty)
            Row(
              children: [
                for (var i = 0; i < wallets.length; i++) ...[
                  if (i > 0) SizedBox(width: 12.w),
                  Expanded(
                    child: _walletRailCard(wallets[i],
                        onTap: disabled ? null : () => _openSend(wallets[i])),
                  ),
                ],
              ],
            ),
          if (others.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                for (var i = 0; i < others.length; i++) ...[
                  if (i > 0) SizedBox(width: 12.w),
                  Expanded(
                    child: _compactRailCard(others[i],
                        onTap: disabled ? null : () => _openSend(others[i])),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _walletRailCard(RmbRail rail, {VoidCallback? onTap}) {
    final color = RmbUi.railColor(rail);
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: onTap == null ? 0.5 : 1,
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: RmbUi.card,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: RmbUi.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 46.w,
                width: 46.w,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                padding: EdgeInsets.all(10.w),
                child: RmbUi.railGlyph(rail, size: 24.sp),
              ),
              SizedBox(height: 12.h),
              Text(RmbUi.railLabel(rail),
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 3.h),
              Text('Instant wallet payout',
                  style:
                      TextStyle(color: RmbUi.textSecondary, fontSize: 11.sp)),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Text('Send now',
                      style: TextStyle(
                          color: color,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600)),
                  SizedBox(width: 4.w),
                  Icon(Icons.arrow_forward_rounded, color: color, size: 14.sp),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _compactRailCard(RmbRail rail, {VoidCallback? onTap}) {
    final color = RmbUi.railColor(rail);
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: onTap == null ? 0.5 : 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: RmbUi.card,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: RmbUi.border),
          ),
          child: Row(
            children: [
              Container(
                height: 34.w,
                width: 34.w,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.all(7.w),
                child: RmbUi.railGlyph(rail, size: 18.sp),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(RmbUi.railLabel(rail),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600)),
              ),
              Icon(Icons.chevron_right_rounded,
                  color: RmbUi.textSecondary, size: 18.sp),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String t) => Padding(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 8.h),
        child: Text(t,
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700)),
      );

  /// "Recent transfers" title with a "View all" action → full history. The
  /// action only shows once there are transfers to view.
  Widget _recentHeader(RmbLoaded state) => Padding(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Recent transfers',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700)),
            if (state.transfers.isNotEmpty)
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.rmbHistory),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Text('View all',
                        style: GoogleFonts.inter(
                            color: RmbUi.accent,
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w600)),
                    Icon(Icons.chevron_right,
                        color: RmbUi.accent, size: 16.sp),
                  ],
                ),
              ),
          ],
        ),
      );

  Widget _transfers(RmbLoaded state) {
    if (state.transfersLoading) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator(color: RmbUi.accent)),
        ),
      );
    }
    if (state.transfers.isEmpty) {
      // Distinguish a genuine empty history from a failed fetch (F19): the
      // latter offers a retry instead of implying the user has no transfers.
      final failed = state.transfersError;
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            children: [
              Icon(failed ? Icons.cloud_off_outlined : Icons.inbox_outlined,
                  color: RmbUi.textSecondary, size: 36.sp),
              SizedBox(height: 8.h),
              Text(failed ? 'Couldn’t load transfers' : 'No transfers yet',
                  style:
                      TextStyle(color: RmbUi.textSecondary, fontSize: 13.sp)),
              if (failed) ...[
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () => context.read<RmbCubit>().refresh(),
                  behavior: HitTestBehavior.opaque,
                  child: Text('Try again',
                      style: GoogleFonts.inter(
                          color: RmbUi.accent,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ],
          ),
        ),
      );
    }
    // Landing shows only the 3 most recent; the rest live behind "View all".
    final recent = state.transfers.take(3).toList();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) => _transferTile(recent[i]),
        childCount: recent.length,
      ),
    );
  }

  // Recipient name in the shared surname-first / CJK-aware format so tiles,
  // history and the receipt all read identically.
  String _displayName(Transfer t) => RmbUi.recipientName(
        surname: t.receiverLastName,
        given: t.receiverFirstName,
        fallback: t.beneficiaryName,
      );

  Widget _transferTile(Transfer t) {
    final rail = t.rail;
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.rmbReceipt, arguments: {
        'transferId': t.id,
        'fromHistory': true,
      }),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: RmbUi.card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: RmbUi.border),
        ),
        child: Row(
          children: [
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: RmbUi.railColor(rail).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: RmbUi.railGlyph(rail, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_displayName(t),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 3.h),
                  Text('${RmbUi.railLabel(rail)} · ${_date(t)}',
                      style: TextStyle(
                          color: RmbUi.textSecondary, fontSize: 11.sp)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(RmbUi.cny(t.destAmountMinor.toInt()),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 3.h),
                _statusChip(t.status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusChip(RmbStatus s) {
    late Color c;
    late String label;
    switch (s) {
      case RmbStatus.RMB_COMPLETED:
        c = RmbUi.success;
        label = 'Completed';
        break;
      case RmbStatus.RMB_FAILED:
        c = RmbUi.error;
        label = 'Failed';
        break;
      case RmbStatus.RMB_REFUNDED:
        c = RmbUi.accent;
        label = 'Refunded';
        break;
      case RmbStatus.RMB_PENDING_COMPLIANCE:
        c = const Color(0xFFF59E0B);
        label = 'In review';
        break;
      default:
        c = const Color(0xFF3B82F6);
        label = 'Processing';
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
          color: c.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20.r)),
      child: Text(label, style: TextStyle(color: c, fontSize: 10.sp)),
    );
  }

  Widget _error(String msg) {
    // The friendly message can itself be "Something went wrong…"; when it does,
    // fall back to a helpful subtitle so the title isn't duplicated.
    var subtitle = msg.trim();
    if (subtitle.toLowerCase().startsWith('something went wrong')) {
      final rest = subtitle.substring('something went wrong'.length).trim();
      subtitle = rest.replaceFirst(RegExp(r'^[.\s]+'), '').trim();
      if (subtitle.isEmpty) {
        subtitle = "We couldn't load RMB right now. Please try again.";
      } else {
        subtitle = subtitle[0].toUpperCase() + subtitle.substring(1);
      }
    }
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: RmbUi.error.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.cloud_off_rounded,
                  color: RmbUi.error, size: 34.sp),
            ),
            SizedBox(height: 20.h),
            Text('Something went wrong',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                )),
            SizedBox(height: 8.h),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: RmbUi.textSecondary,
                  fontSize: 13.sp,
                  height: 1.4,
                )),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: RmbUi.accent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r)),
                  elevation: 0,
                ),
                onPressed: () => context.read<RmbCubit>().load(),
                child: Text('Try again',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _date(Transfer t) {
    if (!t.hasCreatedAt()) return '';
    final dt = t.createdAt.toDateTime().toLocal();
    return DateFormat('MMM d, HH:mm').format(dt);
  }
}
