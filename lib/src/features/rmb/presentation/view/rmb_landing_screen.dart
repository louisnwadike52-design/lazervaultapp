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
import 'package:lazervault/core/shared_widgets/app_snackbar.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';

/// Whether an RMB transfer can be priced — and therefore started — right now.
///
/// Two different causes, one meaning to the user: nothing can be sent. They
/// share a single predicate so the hero copy and the rail CTAs cannot drift
/// apart and show "Temporarily unavailable" above four tappable rails.
///
///  - `maintenance` is the admin switch.
///  - a non-positive `indicativeFxRate` means the live quote FAILED. The
///    backend returns 0 on any provider error (indicativeNgnPerCny), and the
///    send flow needs that same quote to price a transfer, so there is nothing
///    to let the user through to.
bool rmbTransfersPaused(ProviderConfigResponse config) =>
    config.maintenance || config.indicativeFxRate <= 0;

/// RMB service landing — hero (indicative rate + provider), quick actions,
/// and recent payouts. All rails/provider shown here are what the pinned
/// provider supports; the send flow reuses the same config.
class RmbLandingScreen extends StatefulWidget {
  const RmbLandingScreen({super.key});

  @override
  State<RmbLandingScreen> createState() => _RmbLandingScreenState();
}

class _RmbLandingScreenState extends State<RmbLandingScreen> {
  /// Whether a manual rate retry is in flight, so the button can show it.
  bool _retryingRates = false;

  /// Retry the rate fetch and SAY what happened.
  ///
  /// The rate provider being down is an upstream condition we cannot fix from
  /// here (Klasha's sandbox quotation currently answers "This service is
  /// currently unavailable"), so the one thing this button owes the user is an
  /// honest answer about whether anything changed.
  Future<void> _retryRates() async {
    setState(() => _retryingRates = true);
    try {
      await context.read<RmbCubit>().refresh();
    } catch (_) {
      // The cubit surfaces its own error state; this guard only stops an
      // exception leaving the button stuck on "Checking…".
    }
    if (!mounted) return;
    setState(() => _retryingRates = false);

    // If rates are STILL unavailable, say so. Silence after a tap is what made
    // the button look broken — the card is pixel-identical before and after a
    // failed retry.
    final st = context.read<RmbCubit>().state;
    final stillPaused = st is! RmbLoaded || rmbTransfersPaused(st.config);
    if (stillPaused) {
      showAppSnackbar(
        'Rates still unavailable',
        'Our rate provider is not responding yet, so transfers stay paused. '
            'Nothing is wrong with your account.',
        type: AppSnackbarType.info,
      );
    }
  }

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
                    SliverToBoxAdapter(child: _recentHeader(state)),
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
          // No rate means the service cannot quote, NOT "the rate comes later".
          //
          // The hero used to say "Locked in at checkout" whenever the rate was
          // 0, which reads as a deliberate pricing choice and left every rail
          // tappable. But 0 is what the backend returns when the live quote
          // FAILS (see indicativeNgnPerCny — it returns 0 on any error), and
          // the send flow needs that exact same provider quote to price a
          // transfer. So the cheerful copy invited the user into a flow that
          // could not succeed, and they only found out after choosing a rail,
          // entering an amount and a recipient.
          //
          // Say it plainly instead, and disable the rails to match.
          Text(rmbTransfersPaused(config) ? 'Rates' : 'Rates from',
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7), fontSize: 11.sp)),
          SizedBox(height: 4.h),
          Text(
              rmbTransfersPaused(config)
                  ? 'Temporarily unavailable'
                  : '₦${rate.toStringAsFixed(2)} / ¥1',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: rmbTransfersPaused(config) ? 19.sp : 22.sp,
                  fontWeight: FontWeight.w700)),
          if (rmbTransfersPaused(config)) ...[
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(Icons.info_outline,
                    color: Colors.white.withValues(alpha: 0.75), size: 14.sp),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    config.maintenance && config.maintenanceMessage.isNotEmpty
                        ? config.maintenanceMessage
                        : 'We can\'t reach our rate provider right now, so '
                            'transfers are paused. Pull down to retry.',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 11.5.sp,
                        height: 1.35),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            // A REAL BUTTON, not a bare GestureDetector.
            //
            // Reported as "doesn't press": it did call refresh, but there was
            // no ripple, no spinner, and when the retry failed the same way
            // the card did not change by a single pixel — so every tap looked
            // like nothing had happened. The tap target was also only 8dp of
            // vertical padding.
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _retryingRates ? null : _retryRates,
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  constraints: BoxConstraints(minHeight: 40.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10.r),
                    border:
                        Border.all(color: Colors.white.withValues(alpha: 0.28)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_retryingRates)
                        SizedBox(
                          width: 14.sp,
                          height: 14.sp,
                          child: const CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      else
                        Icon(Icons.refresh, color: Colors.white, size: 14.sp),
                      SizedBox(width: 6.w),
                      Text(_retryingRates ? 'Checking…' : 'Try again',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Payment rails directly on the landing — tapping one opens the two-step
  /// send sheet. Alipay and WeChat lead; UnionPay + bank sit on a compact row.
  Widget _railsSection(ProviderConfigResponse config) {
    // Disabled whenever nothing can be priced — maintenance OR no live rate.
    // Previously only maintenance disabled these, so a quote outage left four
    // fully tappable rails leading to a dead end.
    final disabled = rmbTransfersPaused(config);
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
              // The call to action has to STOP being a call to action when the
              // card cannot be tapped. Dimming alone still reads as "Send now",
              // and a user who taps an unresponsive card concludes the app is
              // broken rather than that the service is paused.
              Row(
                children: [
                  Text(onTap == null ? 'Unavailable' : 'Send now',
                      style: TextStyle(
                          color: onTap == null ? RmbUi.textSecondary : color,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600)),
                  if (onTap != null) ...[
                    SizedBox(width: 4.w),
                    Icon(Icons.arrow_forward_rounded,
                        color: color, size: 14.sp),
                  ],
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
                    Icon(Icons.chevron_right, color: RmbUi.accent, size: 16.sp),
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
