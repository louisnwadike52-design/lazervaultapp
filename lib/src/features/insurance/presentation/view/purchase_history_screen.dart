// User-facing "Purchase History" list.
//
// Paginated via PurchaseHistoryCubit using the existing
// repository.getUserInsurancesPage method (Slice-4 pattern with
// generation token + scroll-to-bottom load-more). Each row taps into
// the existing policy detail screen which already supports certificate
// viewing post-Slice-1.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import '../../domain/entities/insurance_entity.dart';
import '../cubit/purchase_history_cubit.dart';

class PurchaseHistoryScreen extends StatefulWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  State<PurchaseHistoryScreen> createState() => _PurchaseHistoryScreenState();
}

class _PurchaseHistoryScreenState extends State<PurchaseHistoryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Initial wire-up of the user id. The build() also wraps in a
    // BlocListener<AuthenticationCubit> so a logout / re-login mid-screen
    // re-seeds the cubit and re-fetches.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = context.read<AuthenticationCubit>().state;
      if (auth is AuthenticationSuccess) {
        context.read<PurchaseHistoryCubit>().setUserId(auth.profile.user.id);
        context.read<PurchaseHistoryCubit>().load();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    // Threshold proportional to viewport height so the prefetch
    // distance scales with the device. The previous absolute 240px
    // misfired on small (< 360w) screens — either prefetching too
    // early (more pages than needed) or never triggering on tall
    // tablet layouts. ~30% of the viewport hits the sweet spot.
    final threshold = pos.viewportDimension * 0.3;
    if (pos.pixels < pos.maxScrollExtent - threshold) return;
    final cubit = context.read<PurchaseHistoryCubit>();
    final s = cubit.state;
    if (s is PurchaseHistoryLoaded && s.hasMore && !s.isLoadingMore) {
      cubit.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Purchase History',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listenWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
        listener: (context, auth) {
          final cubit = context.read<PurchaseHistoryCubit>();
          if (auth is AuthenticationSuccess) {
            cubit.setUserId(auth.profile.user.id);
            cubit.load();
          } else {
            cubit.setUserId('');
          }
        },
        child: BlocBuilder<PurchaseHistoryCubit, PurchaseHistoryState>(
        builder: (context, state) {
          if (state is PurchaseHistoryLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF6366F1)),
            );
          }
          if (state is PurchaseHistoryError) {
            return _buildErrorState(state.message);
          }
          if (state is PurchaseHistoryEmpty) {
            return _buildEmpty();
          }
          if (state is PurchaseHistoryLoaded) {
            return RefreshIndicator(
              onRefresh: () async => context.read<PurchaseHistoryCubit>().load(),
              color: const Color(0xFF6366F1),
              backgroundColor: const Color(0xFF1F1F1F),
              child: ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.all(16.w),
                itemCount: state.purchases.length +
                    (state.isLoadingMore || !state.hasMore ? 1 : 0),
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (_, i) {
                  if (i >= state.purchases.length) {
                    return _buildFooter(state);
                  }
                  return _buildPurchaseTile(state.purchases[i]);
                },
              ),
            );
          }
          return _buildEmpty();
        },
      ),
      ),
    );
  }

  Widget _buildErrorState(String msg) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_outlined, size: 48.sp, color: const Color(0xFFEF4444)),
            SizedBox(height: 12.h),
            Text(msg, textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF))),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () => context.read<PurchaseHistoryCubit>().load(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text('Try Again',
                    style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.receipt_long_outlined, size: 48.sp, color: const Color(0xFF9CA3AF)),
            SizedBox(height: 12.h),
            Text("You haven't purchased any insurance yet",
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF9CA3AF),
                )),
            SizedBox(height: 16.h),
            GestureDetector(
              // Route back to the insurance home (which surfaces the
              // "create new policy" FAB + category browser). Falls back
              // to Get.back() if the navigator can't push the named
              // route for some reason.
              onTap: () {
                final pushed = Get.offNamed(AppRoutes.insurance);
                if (pushed == null) Get.back();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text('Browse insurance products',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(PurchaseHistoryLoaded state) {
    if (state.isLoadingMore) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: const Center(
          child: SizedBox(
            width: 20, height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(Color(0xFF6366F1)),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Center(
        child: Text("You've reached the end",
            style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF6B7280))),
      ),
    );
  }

  Widget _buildPurchaseTile(Insurance insurance) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.insuranceDetails, arguments: insurance),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Container(
              width: 42.w, height: 42.w,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.receipt_long_outlined,
                  color: const Color(0xFF10B981), size: 22.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    insurance.policyHolderName.isNotEmpty
                        ? insurance.policyHolderName
                        : 'Insurance purchase',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${insurance.provider} • Policy ${insurance.policyNumber}',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    NumberFormat.currency(
                      locale: 'en_NG',
                      symbol: '₦',
                      decimalDigits: 2,
                    ).format(insurance.premiumAmount),
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right,
                color: const Color(0xFF6366F1), size: 22.sp),
          ],
        ),
      ),
    );
  }
}
