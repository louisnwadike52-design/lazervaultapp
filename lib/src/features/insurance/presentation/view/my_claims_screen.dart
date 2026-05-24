// User-facing "My Claims" list.
//
// Mirrors the group_account / insurance_all_policies_screen pattern:
//   - dark palette scaffold
//   - status filter tabs (All / Submitted / Approved / Settled / Rejected)
//   - pull-to-refresh
//   - tap row → InsuranceClaimTrackingScreen (existing detail view)
//   - empty state CTA → browse insurance products
//
// Pagination is stubbed for now (getUserClaims returns a single list);
// when the RPC gains page/limit, swap the loadMore() in the cubit.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import '../../domain/entities/insurance_claim_entity.dart';
import '../cubit/my_claims_cubit.dart';
import 'insurance_claim_tracking_screen.dart';

class MyClaimsScreen extends StatefulWidget {
  const MyClaimsScreen({super.key});
  @override
  State<MyClaimsScreen> createState() => _MyClaimsScreenState();
}

class _MyClaimsScreenState extends State<MyClaimsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _tabs = const ['All', 'Submitted', 'Approved', 'Settled', 'Rejected'];

  // One ScrollController per tab so each tab independently triggers
  // loadMore() when the user scrolls to the bottom of its own filtered
  // list. Mirrors the pattern in insurance_all_policies_screen.dart so
  // the infinite-scroll behaviour feels consistent across the app.
  late final List<ScrollController> _scrollControllers;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_onTabChanged);
    _scrollControllers = List.generate(_tabs.length, (_) {
      final ctrl = ScrollController();
      ctrl.addListener(() => _onScroll(ctrl));
      return ctrl;
    });
    // Resolve user id from AuthenticationCubit and fire initial fetch.
    // The build() also wraps the body in a BlocListener<AuthenticationCubit>
    // so a logout/re-login mid-screen pushes the new user id into the
    // cubit and re-fetches.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = context.read<AuthenticationCubit>().state;
      if (auth is AuthenticationSuccess) {
        context.read<MyClaimsCubit>().setUserId(auth.profile.user.id);
        context.read<MyClaimsCubit>().load();
      }
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    for (final c in _scrollControllers) {
      c.dispose();
    }
    super.dispose();
  }

  /// Fired by every ScrollController on every scroll frame. Triggers
  /// the next page when the user is within 240px of the bottom — the
  /// same threshold the All Policies screen uses, so infinite-scroll
  /// feels uniform. The cubit's own guards prevent re-fires while a
  /// page is already in flight, so this can be noisy without harm.
  void _onScroll(ScrollController ctrl) {
    if (!ctrl.hasClients) return;
    if (ctrl.position.pixels < ctrl.position.maxScrollExtent - 240) return;
    final cubit = context.read<MyClaimsCubit>();
    final s = cubit.state;
    if (s is MyClaimsLoaded && s.hasMore && !s.isLoadingMore) {
      cubit.loadMore();
    }
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    final filters = [null, 'submitted', 'approved', 'settled', 'rejected'];
    context.read<MyClaimsCubit>().load(status: filters[_tabController.index]);
  }

  // Tab filter. Tabs: All / Submitted / Approved / Settled / Rejected.
  // The mid-flight MyCover stages (documented, inspection submitted,
  // repair estimate *, offer sent / accepted) are rolled into the
  // Submitted tab via `isUnderReviewFamily` so the user sees them as
  // "in progress" rather than dropping off the list entirely.
  List<InsuranceClaim> _filterByTab(List<InsuranceClaim> all, int tabIndex) {
    if (tabIndex == 0) return all;
    switch (tabIndex) {
      case 1: // Submitted (+ all mid-flight under-review states)
        return all
            .where((c) =>
                c.status == ClaimStatus.submitted ||
                c.status.isUnderReviewFamily)
            .toList();
      case 2: // Approved
        return all.where((c) => c.status == ClaimStatus.approved).toList();
      case 3: // Settled (or paid — providers use both terms)
        return all
            .where((c) =>
                c.status == ClaimStatus.settled ||
                c.status == ClaimStatus.paid)
            .toList();
      case 4: // Rejected (or offer rejected)
        return all
            .where((c) =>
                c.status == ClaimStatus.rejected ||
                c.status == ClaimStatus.offerRejected)
            .toList();
      default:
        return all;
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
          'My Claims',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: const Color(0xFF6366F1),
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xFF9CA3AF),
          labelStyle: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600),
          unselectedLabelStyle:
              GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w500),
          tabAlignment: TabAlignment.start,
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listenWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
        listener: (context, auth) {
          final cubit = context.read<MyClaimsCubit>();
          if (auth is AuthenticationSuccess) {
            cubit.setUserId(auth.profile.user.id);
            cubit.load();
          } else {
            // Logged out — clear any leaked user id.
            cubit.setUserId('');
          }
        },
        child: BlocBuilder<MyClaimsCubit, MyClaimsState>(
        builder: (context, state) {
          if (state is MyClaimsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF6366F1)),
            );
          }
          if (state is MyClaimsError) {
            return _buildErrorState(state.message);
          }
          if (state is MyClaimsLoaded) {
            return TabBarView(
              controller: _tabController,
              children: List.generate(_tabs.length, (idx) {
                final filtered = _filterByTab(state.claims, idx);
                if (filtered.isEmpty) return _buildEmptyTab(_tabs[idx]);
                // Show a footer spinner row when another page is in
                // flight or when there's more to fetch. The cubit
                // emits isLoadingMore=true synchronously inside
                // loadMore(), so the spinner appears the moment the
                // scroll handler fires.
                final showFooter = state.hasMore || state.isLoadingMore;
                final itemCount = filtered.length + (showFooter ? 1 : 0);
                return RefreshIndicator(
                  onRefresh: () async => context.read<MyClaimsCubit>().load(
                        status: state.statusFilter,
                      ),
                  color: const Color(0xFF6366F1),
                  backgroundColor: const Color(0xFF1F1F1F),
                  child: ListView.separated(
                    controller: _scrollControllers[idx],
                    padding: EdgeInsets.all(16.w),
                    itemCount: itemCount,
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder: (_, i) {
                      if (i >= filtered.length) {
                        return _buildLoadMoreFooter(state.isLoadingMore);
                      }
                      return _buildClaimTile(filtered[i]);
                    },
                  ),
                );
              }),
            );
          }
          return _buildEmptyTab('All');
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
              onTap: () => context.read<MyClaimsCubit>().load(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text('Try Again',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
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

  /// Footer row at the bottom of the claims ListView. Shows a small
  /// spinner while a follow-on page is in flight, or stays invisible
  /// when we're caught up. Keeps the user oriented during long
  /// infinite-scroll sessions.
  Widget _buildLoadMoreFooter(bool isLoadingMore) {
    if (!isLoadingMore) return SizedBox(height: 12.h);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Center(
        child: SizedBox(
          width: 22.sp,
          height: 22.sp,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            color: Color(0xFF6366F1),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyTab(String tabName) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.assignment_outlined,
                size: 48.sp, color: const Color(0xFF9CA3AF)),
            SizedBox(height: 12.h),
            Text(
              tabName == 'All' ? "You haven't filed any claims yet" : 'No ${tabName.toLowerCase()} claims',
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF9CA3AF),
              ),
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.insuranceAllPolicies),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFF2D2D2D)),
                ),
                child: Text(
                  'View my policies',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClaimTile(InsuranceClaim claim) {
    final color = _statusColor(claim.status);
    return GestureDetector(
      onTap: () => Get.to(() => InsuranceClaimTrackingScreen(claim: claim)),
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
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.assignment_outlined, color: color, size: 22.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(claim.title.isNotEmpty ? claim.title : 'Claim #${claim.claimNumber}',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  SizedBox(height: 4.h),
                  Text(
                    'Policy ${claim.policyNumber} • ${DateFormat('dd MMM yyyy').format(claim.incidentDate)}',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    NumberFormat.currency(locale: 'en_NG', symbol: '₦', decimalDigits: 2).format(claim.claimAmount),
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                _statusLabel(claim.status),
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Mirror the per-stage colors used on InsuranceClaimTrackingScreen so a
  // claim's badge reads the same on the list and the detail screen. Every
  // MyCover status is mapped explicitly — the old `default` greyed out the
  // mid-flight stages (documented / inspection / repair-estimate / offer_*)
  // and even terminal `paid` / `offerRejected`, which washed out real
  // progress the reconciler had already fetched.
  Color _statusColor(ClaimStatus s) {
    switch (s) {
      case ClaimStatus.approved:
      case ClaimStatus.offerAccepted:
        return const Color(0xFF10B981); // green — positive decision
      case ClaimStatus.settled:
      case ClaimStatus.paid:
        return const Color(0xFF4E03D0); // purple — money paid out
      case ClaimStatus.rejected:
      case ClaimStatus.offerRejected:
        return const Color(0xFFEF4444); // red — declined
      case ClaimStatus.submitted:
        return const Color(0xFF6366F1); // indigo — just filed
      case ClaimStatus.underReview:
      case ClaimStatus.documented:
      case ClaimStatus.inspectionSubmitted:
      case ClaimStatus.repairEstimateRequested:
      case ClaimStatus.repairEstimateProvided:
      case ClaimStatus.offerSent:
        return const Color(0xFFFB923C); // orange — in progress
      case ClaimStatus.cancelled:
        return const Color(0xFF6B7280); // grey — withdrawn
    }
  }

  // Use the human-readable label ("Under Review", "Offer Sent", "Paid")
  // rather than the raw enum name ("UNDERREVIEW", "OFFERSENT").
  String _statusLabel(ClaimStatus s) => s.displayName.toUpperCase();
}
