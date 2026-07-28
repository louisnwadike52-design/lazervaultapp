
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../cubit/epin_cubit.dart';
import '../widgets/epin_quick_buy.dart';
import '../cubit/epin_state.dart';
import 'epin_theme.dart';

/// Recharge-card printing hub: pick a network, a denomination, then a quantity
/// and continue to review. Entry point is the Bills Hub grid.
class EPinHomeScreen extends StatefulWidget {
  const EPinHomeScreen({super.key});

  @override
  State<EPinHomeScreen> createState() => _EPinHomeScreenState();
}

class _EPinHomeScreenState extends State<EPinHomeScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  // Recent-orders strip state (the purchase itself lives in EPinQuickBuy).
  Future<List<EPinOrder>>? _recentFuture;
  String? _openingOrderId;

  @override
  void initState() {
    super.initState();
    // Load the networks (the BlocBuilder gates the body on EPinNetworksLoaded,
    // and EPinQuickBuy — which lives inside that body — also consumes them) and
    // the recent-orders strip.
    context.read<EPinCubit>().loadNetworks();
    _loadRecent();
  }

  void _loadRecent() {
    _recentFuture = context.read<EPinCubit>().repository.listOrders();
  }




  Future<void> _openOrder(EPinOrder order) async {
    if (_openingOrderId != null) return;
    setState(() => _openingOrderId = order.id);
    try {
      final full = await context.read<EPinCubit>().repository.getOrder(order.id);
      if (!mounted) return;
      setState(() => _openingOrderId = null);
      Get.toNamed(AppRoutes.epinReceipt, arguments: {
        'order': full,
        'message': '',
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _openingOrderId = null);
      Get.snackbar('Error', 'Could not open that order. Please try again.',
          backgroundColor: EpinTheme.error, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EpinTheme.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Chat + voice intentionally omitted here — the Utility Payments
            // per-service assistant and the general chat/voice agents already
            // cover recharge-card printing, so the header stays clean.
            const EpinHeader(
              title: 'Recharge card printing',
              subtitle: 'Generate airtime PINs to print or share',
            ),
            Expanded(
              child: BlocBuilder<EPinCubit, EPinState>(
                buildWhen: (_, s) =>
                    s is EPinNetworksLoading ||
                    s is EPinNetworksLoaded ||
                    s is EPinNetworksError,
                builder: (context, state) {
                  if (state is EPinNetworksLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: EpinTheme.primary),
                    );
                  }
                  if (state is EPinNetworksError) {
                    return _buildError(state.message);
                  }
                  if (state is EPinNetworksLoaded) {
                    if (state.networks.isEmpty) {
                      return _buildEmpty();
                    }
                    return _buildBody(state.networks);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(List<EPinNetwork> networks) {
    // Streamlined single-page purchase (see EPinQuickBuy).
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          const EPinQuickBuy(),
          SizedBox(height: 28.h),
          _buildRecentSection(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text, {Widget? trailing}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (trailing != null) trailing,
        ],
      );




  /// Quick-pick quantities — each fills whole printout rows so the sheet has no
  /// ragged last row. Tapping a pill sets the quantity.




  /// Recent recharge-card orders — first 3, with a "View all" into full history.
  Widget _buildRecentSection() {
    return FutureBuilder<List<EPinOrder>>(
      future: _recentFuture,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting ||
            !snap.hasData ||
            snap.data!.isEmpty) {
          return const SizedBox.shrink();
        }
        final recent = snap.data!.take(3).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(
              'Recent',
              trailing: GestureDetector(
                onTap: () async {
                  await Get.toNamed(AppRoutes.epinOrders);
                  if (mounted) setState(_loadRecent);
                },
                child: Text(
                  'View all',
                  style: TextStyle(
                    color: EpinTheme.primary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            ...recent.map(_buildRecentTile),
          ],
        );
      },
    );
  }

  Widget _buildRecentTile(EPinOrder order) {
    final color = order.isFailed
        ? EpinTheme.error
        : (order.isPending ? EpinTheme.warning : EpinTheme.success);
    String created = order.createdAt;
    final parsed = DateTime.tryParse(order.createdAt);
    if (parsed != null) {
      created = DateFormat('MMM dd, HH:mm').format(parsed.toLocal());
    }
    final opening = _openingOrderId == order.id;
    return GestureDetector(
      onTap: opening ? null : () => _openOrder(order),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: EpinTheme.card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: EpinTheme.divider),
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: EpinTheme.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: opening
                  ? Padding(
                      padding: EdgeInsets.all(10.w),
                      child: const CircularProgressIndicator(
                          color: EpinTheme.primary, strokeWidth: 2),
                    )
                  : Icon(Icons.sim_card, color: EpinTheme.primary, size: 18.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${order.quantity} x ₦${order.denomination.toStringAsFixed(0)} · ${order.network}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    created,
                    style: TextStyle(
                        color: EpinTheme.textSecondary, fontSize: 10.sp),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₦${order.totalAmount.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    order.status,
                    style: TextStyle(
                      color: color,
                      fontSize: 9.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: EpinTheme.error, size: 40.sp),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: EpinTheme.textSecondary, fontSize: 14.sp),
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: () => context.read<EPinCubit>().loadNetworks(),
              child: const Text('Retry',
                  style: TextStyle(color: EpinTheme.primary)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Text(
        'No networks available right now',
        style: TextStyle(color: EpinTheme.textSecondary, fontSize: 14.sp),
      ),
    );
  }
}
