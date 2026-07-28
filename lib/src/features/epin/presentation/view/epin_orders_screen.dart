import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/epin_cubit.dart';
import '../cubit/epin_state.dart';
import 'epin_theme.dart';

/// Recharge-card order history. Each row re-opens its order (via getEPinOrder)
/// so the user can view / copy the generated PINs on the receipt screen.
class EPinOrdersScreen extends StatefulWidget {
  const EPinOrdersScreen({super.key});

  @override
  State<EPinOrdersScreen> createState() => _EPinOrdersScreenState();
}

class _EPinOrdersScreenState extends State<EPinOrdersScreen> {
  static const _bg = EpinTheme.bg;
  static const _card = EpinTheme.card;
  static const _divider = EpinTheme.divider;
  static const _primary = EpinTheme.primary;
  static const _success = EpinTheme.success;
  static const _warning = EpinTheme.warning;
  static const _error = EpinTheme.error;
  static const _textSecondary = EpinTheme.textSecondary;

  // When true the next EPinOrderLoaded should route to the receipt.
  bool _openingOrder = false;

  @override
  void initState() {
    super.initState();
    context.read<EPinCubit>().loadOrders();
  }

  void _openOrder(String orderId) {
    _openingOrder = true;
    context.read<EPinCubit>().loadOrder(orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: BlocListener<EPinCubit, EPinState>(
          listenWhen: (_, s) => s is EPinOrderLoaded || s is EPinOrderError,
          listener: (context, state) {
            if (state is EPinOrderLoaded && _openingOrder) {
              _openingOrder = false;
              Get.toNamed(AppRoutes.epinReceipt, arguments: {
                'order': state.order,
                'message': '',
              });
            } else if (state is EPinOrderError) {
              _openingOrder = false;
              Get.snackbar('Error', state.message,
                  backgroundColor: _error, colorText: Colors.white);
            }
          },
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: BlocBuilder<EPinCubit, EPinState>(
                  buildWhen: (_, s) =>
                      s is EPinOrdersLoading ||
                      s is EPinOrdersLoaded ||
                      s is EPinOrdersError,
                  builder: (context, state) {
                    if (state is EPinOrdersLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: _primary),
                      );
                    }
                    if (state is EPinOrdersError) {
                      return _buildError(state.message);
                    }
                    if (state is EPinOrdersLoaded) {
                      if (state.orders.isEmpty) return _buildEmpty();
                      return RefreshIndicator(
                        color: _primary,
                        onRefresh: () =>
                            context.read<EPinCubit>().loadOrders(),
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          itemCount: state.orders.length,
                          itemBuilder: (context, i) =>
                              _buildOrderTile(state.orders[i]),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: _card,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            'My recharge cards',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTile(EPinOrder order) {
    final color = order.isFailed
        ? _error
        : (order.isPending ? _warning : _success);
    String created = order.createdAt;
    final parsed = DateTime.tryParse(order.createdAt);
    if (parsed != null) {
      created = DateFormat('MMM dd, yyyy HH:mm').format(parsed.toLocal());
    }
    return GestureDetector(
      onTap: () => _openOrder(order.id),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: _divider),
        ),
        child: Row(
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: _primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(11.r),
              ),
              child: Icon(Icons.sim_card, color: _primary, size: 20.sp),
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
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    created,
                    style: TextStyle(color: _textSecondary, fontSize: 11.sp),
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
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    order.status,
                    style: TextStyle(
                      color: color,
                      fontSize: 10.sp,
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
            Icon(Icons.error_outline, color: _error, size: 40.sp),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: _textSecondary, fontSize: 14.sp),
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: () => context.read<EPinCubit>().loadOrders(),
              child: const Text('Retry', style: TextStyle(color: _primary)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.receipt_long, color: _textSecondary, size: 44.sp),
          SizedBox(height: 12.h),
          Text(
            'No recharge card orders yet',
            style: TextStyle(color: _textSecondary, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
