import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/shared_widgets/app_snackbar.dart';
import 'package:lazervault/core/shared_widgets/service_entrance_animation.dart';
import '../cubit/escrow_cubit.dart';
import '../widgets/escrow_shimmer.dart';
import '../widgets/escrow_empty_state.dart';
import '../../domain/entities/escrow_deal_entity.dart';
import 'escrow_theme.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';

class EscrowHomeScreen extends StatefulWidget {
  const EscrowHomeScreen({super.key});

  @override
  State<EscrowHomeScreen> createState() => _EscrowHomeScreenState();
}

class _EscrowHomeScreenState extends State<EscrowHomeScreen> {
  String _role = ''; // "", "buyer", "seller"

  // Status-group filter key. The backend `status` filter matches a single exact
  // status, so the multi-status groups below are applied client-side over the
  // loaded list (the server call passes role only).
  String _status = '';

  static const List<(String key, String label)> _statusFilters = [
    ('', 'All'),
    ('in_escrow', 'In Escrow'),
    ('delivered', 'Delivered'),
    ('refund_requested', 'Refund requested'),
    ('disputed', 'Disputed'),
    ('completed', 'Completed'),
    ('refunded', 'Refunded'),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _reload());
  }

  void _reload() => context.read<EscrowCubit>().loadDeals(role: _role);

  void _setRole(String role) {
    setState(() => _role = role);
    _reload();
  }

  void _setStatus(String status) => setState(() => _status = status);

  /// Client-side status-group filter over the already-loaded list.
  List<EscrowDealEntity> _applyStatusFilter(List<EscrowDealEntity> deals) {
    switch (_status) {
      case 'in_escrow':
        return deals.where((d) => d.isFunded).toList();
      case 'delivered':
        return deals.where((d) => d.isDelivered).toList();
      case 'refund_requested':
        return deals.where((d) => d.isRefundRequested).toList();
      case 'disputed':
        return deals.where((d) => d.isDisputed).toList();
      case 'completed':
        return deals.where((d) => d.isReleased).toList();
      case 'refunded':
        return deals
            .where((d) => d.isRefunded || d.status == 'EXPIRED')
            .toList();
      default:
        return deals;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EscrowTheme.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
          icon: Container(
            padding: EdgeInsets.all(8.w),
            decoration: const BoxDecoration(color: EscrowTheme.card, shape: BoxShape.circle),
            child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
          ),
        ),
        title: Text('Escrow Pay',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700)),
        centerTitle: true,
        actions: [
          ServiceVoiceButton(
            serviceName: 'escrow',
            iconColor: EscrowTheme.primary,
            backgroundColor: EscrowTheme.primary,
            buttonSize: 34.w,
            iconSize: 17.sp,
          ),
          SizedBox(width: 8.w),
          // Offers inbox: listings I published + offers/requests sent to me.
          IconButton(
            onPressed: () async {
              await Get.toNamed(AppRoutes.escrowOffers);
              _reload();
            },
            icon: Icon(Icons.local_offer_outlined,
                color: EscrowTheme.primary, size: 20.sp),
            tooltip: 'Offers',
          ),
          MicroserviceChatIcon(
            serviceName: 'Escrow Pay',
            sourceContext: 'escrow',
            iconColor: EscrowTheme.primary,
            size: 34,
            iconSize: 17,
          ),
          SizedBox(width: 12.w),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: EscrowTheme.primary,
        onPressed: _newOfferChooser,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text('New',
            style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      body: ServiceEntranceAnimation(
        child: SafeArea(
        child: Column(
          children: [
            _header(),
            _roleTabs(),
            _statusFilterRow(),
            Expanded(
              child: BlocConsumer<EscrowCubit, EscrowState>(
                listener: (context, state) {
                  if (state is EscrowError) {
                    showAppSnackbar('Escrow Pay', state.message,
                        type: AppSnackbarType.error);
                  }
                },
                builder: (context, state) {
                  if (state is EscrowLoading || state is EscrowInitial) {
                    return const EscrowListShimmer();
                  }
                  if (state is EscrowError) {
                    return EscrowEmptyState.error(onRetry: _reload);
                  }
                  if (state is EscrowDealsLoaded) {
                    final deals = _applyStatusFilter(state.deals);
                    if (deals.isEmpty) return _empty();
                    return RefreshIndicator(
                      color: EscrowTheme.primary,
                      onRefresh: () async => _reload(),
                      child: ListView.separated(
                        padding: EdgeInsets.all(16.w),
                        itemCount: deals.length,
                        separatorBuilder: (_, __) => SizedBox(height: 12.h),
                        itemBuilder: (context, i) =>
                            _dealCard(deals[i], state.currentUserId),
                      ),
                    );
                  }
                  return const EscrowListShimmer();
                },
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  /// The two honest entry points of a standard two-sided escrow. The old FAB
  /// dropped BOTH sides into a buyer-pays create flow — a seller tapping
  /// "Create a Deal" on their own tab was asked to fund a purchase.
  Future<void> _newOfferChooser() async {
    final direction = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: EscrowTheme.card,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 14.h),
            Text('What would you like to do?',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 6.h),
            ListTile(
              leading: Icon(Icons.storefront_outlined,
                  color: EscrowTheme.primary, size: 24.sp),
              title: Text('Sell something',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600)),
              subtitle: Text(
                  'List the item with photos and price. Share it or offer it to a buyer.',
                  style: GoogleFonts.inter(
                      color: EscrowTheme.textSecondary, fontSize: 11.5.sp)),
              onTap: () => Navigator.pop(ctx, 'sell_offer'),
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag_outlined,
                  color: EscrowTheme.primary, size: 24.sp),
              title: Text('Request to buy',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600)),
              subtitle: Text(
                  'Ask a seller for something. You pay only after they accept.',
                  style: GoogleFonts.inter(
                      color: EscrowTheme.textSecondary, fontSize: 11.5.sp)),
              onTap: () => Navigator.pop(ctx, 'buy_request'),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
    if (direction == null) return;
    await Get.toNamed(AppRoutes.escrowOfferCreate,
        arguments: {'direction': direction});
    _reload();
  }

  Widget _header() {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 12.h),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [EscrowTheme.primary, EscrowTheme.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 46.w,
            height: 46.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.verified_user, color: Colors.white, size: 24.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Buy & sell safely with escrow',
                    style: GoogleFonts.inter(
                        color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                SizedBox(height: 4.h),
                Text(
                    'Agree first, pay into escrow, release after delivery is confirmed.',
                    style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.9), fontSize: 11.5.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _roleTabs() {
    Widget tab(String label, String role) {
      final active = _role == role;
      return Expanded(
        child: GestureDetector(
          onTap: () => _setRole(role),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: active ? EscrowTheme.primary : EscrowTheme.card,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(label,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: active ? Colors.white : EscrowTheme.textSecondary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600)),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(children: [tab('All', ''), tab('Buying', 'buyer'), tab('Selling', 'seller')]),
    );
  }

  Widget _statusFilterRow() {
    return SizedBox(
      height: 38.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 4.h),
        itemCount: _statusFilters.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, i) {
          final (key, label) = _statusFilters[i];
          final active = _status == key;
          return GestureDetector(
            onTap: () => _setStatus(key),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                color: active
                    ? EscrowTheme.primary.withValues(alpha: 0.16)
                    : EscrowTheme.card,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: active ? EscrowTheme.primary : EscrowTheme.border,
                ),
              ),
              child: Text(label,
                  style: GoogleFonts.inter(
                      color: active ? EscrowTheme.primary : EscrowTheme.textSecondary,
                      fontSize: 12.5.sp,
                      fontWeight: active ? FontWeight.w700 : FontWeight.w500)),
            ),
          );
        },
      ),
    );
  }

  // Empty-state CTAs open the direction chooser — a seller's CTA must never
  // drop them into a flow that asks THEM to pay.
  Future<void> _goCreate() => _newOfferChooser();

  Widget _empty() {
    // When a status filter narrows everything out, keep it honest rather than
    // implying the user has no deals at all.
    if (_status.isNotEmpty) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: 360.h,
          child: EscrowEmptyState(
            icon: Icons.filter_list_off,
            title: 'No deals in this filter',
            description: 'Nothing matches this status yet. Try another filter.',
            actionText: 'Show all',
            onAction: () => _setStatus(''),
          ),
        ),
      );
    }
    switch (_role) {
      case 'buyer':
        return EscrowEmptyState.noBuying(onAction: _goCreate);
      case 'seller':
        return EscrowEmptyState.noSelling(onAction: _goCreate);
      default:
        return EscrowEmptyState.noDeals(onAction: _goCreate);
    }
  }

  Widget _dealCard(EscrowDealEntity deal, String uid) {
    final isBuyer = deal.isBuyer(uid);
    final roleLabel = isBuyer ? 'Buying' : 'Selling';
    final counterparty = isBuyer ? deal.sellerName : deal.buyerName;
    return GestureDetector(
      onTap: () async {
        await Get.toNamed(AppRoutes.escrowDetail, arguments: deal.id);
        _reload();
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: EscrowTheme.card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: EscrowTheme.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(deal.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700)),
                ),
                EscrowTheme.statusChip(deal.status),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: (isBuyer ? EscrowTheme.primary : EscrowTheme.success).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(roleLabel,
                      style: GoogleFonts.inter(
                          color: isBuyer ? EscrowTheme.primary : EscrowTheme.success,
                          fontSize: 10.5.sp,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text('with $counterparty',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(color: EscrowTheme.textSecondary, fontSize: 12.sp)),
                ),
              ],
            ),
            ..._buildWaitingLine(deal, uid),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    isBuyer
                        ? 'You pay ${deal.currency} ${deal.buyerTotal.toStringAsFixed(2)}'
                        : 'You get ${deal.currency} ${deal.sellerNet.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                        color: Colors.white, fontSize: 13.5.sp, fontWeight: FontWeight.w600)),
                Icon(Icons.chevron_right, color: EscrowTheme.textSecondary, size: 20.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Compact one-line progress hint on the list card (e.g. "Waiting for Jane
  /// to deliver"), emphasised when it's the viewer's turn to act.
  List<Widget> _buildWaitingLine(EscrowDealEntity deal, String uid) {
    final s = deal.waitingSubtitle(uid);
    if (s.text.isEmpty) return const [];
    final color = s.yourTurn ? EscrowTheme.primary : EscrowTheme.textSecondary;
    final icon = s.yourTurn
        ? Icons.touch_app_outlined
        : (deal.isActive ? Icons.hourglass_bottom : Icons.check_circle_outline);
    return [
      SizedBox(height: 8.h),
      Row(
        children: [
          Icon(icon, color: color, size: 13.sp),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(s.text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                    color: color,
                    fontSize: 11.5.sp,
                    fontWeight: s.yourTurn ? FontWeight.w600 : FontWeight.w500)),
          ),
        ],
      ),
    ];
  }
}
