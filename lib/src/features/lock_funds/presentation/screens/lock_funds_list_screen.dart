import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../../account_cards_summary/services/balance_websocket_service.dart';
import '../../domain/entities/lock_fund_entity.dart';
import '../cubit/lock_funds_cubit.dart';
import '../cubit/lock_funds_state.dart';
import '../cubit/create_lock_cubit.dart';
import 'create_lock_carousel.dart';
import 'lock_fund_details_screen.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';

class LockFundsListScreen extends StatefulWidget {
  const LockFundsListScreen({super.key});

  @override
  State<LockFundsListScreen> createState() => _LockFundsListScreenState();
}

class _LockFundsListScreenState extends State<LockFundsListScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _hasLoadedData = false;
  // Filter state. null = show every status. Backend takes the
  // status enum verbatim ("locked", "matured", "cancelled", ...);
  // see PiggyVault `LockStatus.backendValue` translation. Local
  // client-side filter for the UI tab strip, NOT a paging param —
  // we always fetch the full page and filter in-memory because the
  // total count per user is small enough that this avoids a second
  // network round-trip on every tab tap.
  LockStatus? _filterStatus;
  // Subscription for in-app toast notifications when the realtime
  // WS pushes a lock-fund lifecycle event. The cubit already
  // refreshes the list on these events; this subscription only
  // adds the user-visible snackbar. Cancelled in dispose so
  // backgrounding the screen doesn't keep dispatching toasts.
  StreamSubscription<LockFundLifecycleEvent>? _toastSub;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _fadeController.forward();
    _slideController.forward();

    // Surface a toast for every WS lifecycle event matching the
    // current user. The cubit already drives the list reload on
    // these; the snackbar here is purely the visible cue that
    // "your auto-renew ran at 02:00 and you have a fresh upfront
    // payout sitting in your wallet now". Falls back gracefully
    // if the WS service isn't registered in DI.
    try {
      final ws = serviceLocator<BalanceWebSocketService>();
      _toastSub = ws.lockFundEvents.listen(_onLifecycleToast);
    } catch (_) {
      // WS not wired — silent. The list refresh path on entry
      // still gives the user the canonical state.
    }
  }

  /// Translates a LockFundLifecycleEvent into a user-friendly
  /// snackbar. Four event types, each with its own colour + copy
  /// so the user can tell "your lock matured" apart from "renewal
  /// bailed; you may want to investigate".
  void _onLifecycleToast(LockFundLifecycleEvent event) {
    if (!mounted) return;
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess &&
        event.userId.isNotEmpty &&
        event.userId != authState.profile.user.id) {
      return;
    }
    String title;
    String message;
    Color color;
    switch (event.eventType) {
      case 'lock_fund.matured':
        title = 'Lock matured';
        message = '${event.name} just unlocked. Tap to claim.';
        color = const Color(0xFF10B981);
        break;
      case 'lock_fund.renewed':
        title = 'Lock renewed';
        message = event.upfrontInterestPaid > 0
            ? 'Renewed ${event.name}. Upfront interest credited.'
            : 'Renewed ${event.name}.';
        color = const Color(0xFF6366F1);
        break;
      case 'lock_fund.renewal_skipped':
        title = 'Auto-renew skipped';
        message = event.reason.isNotEmpty
            ? '${event.name}: ${event.reason}. Lock matured instead.'
            : 'Auto-renew failed for ${event.name}; lock matured.';
        color = const Color(0xFFFB923C);
        break;
      case 'lock_fund.cancelled':
        title = 'Lock cancelled';
        message = '${event.name} cancelled. Funds returned to wallet.';
        color = const Color(0xFF6B7280);
        break;
      case 'lock_fund.created':
        // Don't double-notify on create — the user is on the
        // wizard's receipt screen already.
        return;
      default:
        return;
    }
    Get.snackbar(
      title,
      message,
      backgroundColor: color,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 4),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Load data when screen is first displayed
    if (!_hasLoadedData) {
      _hasLoadedData = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _loadData();
        }
      });
    }
  }

  void _loadData() {
    final cubit = context.read<LockFundsCubit>();
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      cubit.setUserId(authState.profile.user.id);
    } else if (cubit.currentUserId != null) {
      cubit.loadLockFunds();
    }
  }

  @override
  void dispose() {
    _toastSub?.cancel();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, authState) {
        if (authState is AuthenticationSuccess) {
          context.read<LockFundsCubit>().setUserId(authState.profile.user.id);
        }
      },
      builder: (context, authState) {
        // Show loading if not authenticated yet
        if (authState is! AuthenticationSuccess) {
          return _buildLockFundsScreenWithLoading();
        }
        return _buildLockFundsScreen();
      },
    );
  }

  Widget _buildLockFundsScreenWithLoading() {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
              const Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(child: _buildLoadingState()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLockFundsScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
              const Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: BlocConsumer<LockFundsCubit, LockFundsState>(
                      listener: (context, state) {
                        if (state is LockFundsError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                state.message,
                                style: GoogleFonts.inter(color: Colors.white),
                              ),
                              backgroundColor: Colors.red[700],
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is LockFundsLoading) {
                          return _buildLoadingState();
                        }

                        if (state is LockFundsLoaded) {
                          return _buildLocksView(state);
                        }

                        if (state is LockFundsError) {
                          return _buildErrorState(state.message);
                        }

                        return _buildEmptyState();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.offAllNamed(AppRoutes.dashboard),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(22.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PiggyVault',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Grow your savings with locked deposits',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          ServiceVoiceButton(
            serviceName: 'lockfunds',
            iconColor: Colors.white,
          ),
          SizedBox(width: 8.w),
          MicroserviceChatIcon(
            serviceName: 'PiggyVault',
            sourceContext: 'financial_products',
          ),
        ],
      ),
    );
  }

  Widget _buildLocksView(LockFundsLoaded state) {
    final filtered = _filterStatus == null
        ? state.lockFunds
        : state.lockFunds.where((l) => l.status == _filterStatus).toList();
    return RefreshIndicator(
      onRefresh: () async => context.read<LockFundsCubit>().loadLockFunds(),
      backgroundColor: const Color(0xFF1F1F1F),
      color: const Color(0xFF6366F1),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatisticsCards(state.statistics),
            SizedBox(height: 32.h),
            _buildFilterTabs(state.lockFunds),
            SizedBox(height: 16.h),
            _buildSectionHeader('Your Locks', filtered.length),
            SizedBox(height: 16.h),
            if (filtered.isEmpty)
              _buildFilterEmptyState()
            else
              _buildLocksList(filtered),
            SizedBox(height: 100.h), // Space for FAB
          ],
        ),
      ),
    );
  }

  /// Five-tab status filter strip rendered above the lock list.
  /// Each tab shows a count badge so the user can see "you have 3
  /// active, 1 matured" at a glance without ticking through every
  /// tab. The "All" tab is always present + selected by default.
  Widget _buildFilterTabs(List<LockFund> allLocks) {
    final tabs = <_FilterTab>[
      _FilterTab('All', null, allLocks.length),
      _FilterTab('Active', LockStatus.active,
          allLocks.where((l) => l.status == LockStatus.active).length),
      _FilterTab('Matured', LockStatus.matured,
          allLocks.where((l) => l.status == LockStatus.matured).length),
      _FilterTab('Unlocked', LockStatus.unlocked,
          allLocks.where((l) => l.status == LockStatus.unlocked).length),
      _FilterTab('Cancelled', LockStatus.cancelled,
          allLocks.where((l) => l.status == LockStatus.cancelled).length),
    ];
    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: tabs.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (ctx, i) {
          final t = tabs[i];
          final selected = _filterStatus == t.status;
          return GestureDetector(
            onTap: () => setState(() => _filterStatus = t.status),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF4E03D0)
                    : Colors.white.withValues(alpha: 0.06),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF8B5CF6)
                      : Colors.white.withValues(alpha: 0.1),
                ),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Row(
                children: [
                  Text(t.label, style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  )),
                  if (t.count > 0) ...[
                    SizedBox(width: 6.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text('${t.count}', style: GoogleFonts.inter(
                        color: Colors.white, fontSize: 10.sp,
                        fontWeight: FontWeight.w700)),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Empty-state for the active filter — e.g. "no matured locks
  /// yet" — rendered when the unfiltered list isn't empty but the
  /// current tab has zero rows.
  Widget _buildFilterEmptyState() {
    final label = _filterStatus == null ? 'locks' : '${_filterStatus!.name.toLowerCase()} locks';
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(Icons.filter_alt_off_outlined,
              color: const Color(0xFF6B7280), size: 32.sp),
          SizedBox(height: 8.h),
          Text('No $label', style: GoogleFonts.inter(
            color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 4.h),
          Text('Try a different filter.', style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
        ],
      ),
    );
  }

  Widget _buildStatisticsCards(Map<String, dynamic> statistics) {
    return StreamBuilder<String>(
      stream: CurrencySymbols.currencySymbolStream,
      initialData: CurrencySymbols.currentSymbol,
      builder: (context, snapshot) {
        final currencySymbol = snapshot.data ?? CurrencySymbols.currentSymbol;
        final totalLocked = (statistics['totalLockedAmount'] ?? 0) as double;
        final totalInterest = (statistics['totalAccruedInterest'] ?? 0) as double;
        final activeLocksCount = statistics['activeLocksCount'] ?? 0;

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Locked',
                    '$currencySymbol${totalLocked.toStringAsFixed(2)}',
                    Icons.lock_outlined,
                    const Color(0xFF6366F1),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildStatCard(
                    'Interest Earned',
                    '$currencySymbol${totalInterest.toStringAsFixed(2)}',
                    Icons.trending_up,
                    const Color(0xFF10B981),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Active Locks',
                    '$activeLocksCount',
                    Icons.account_balance_wallet,
                    const Color(0xFFF59E0B),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildStatCard(
                    'Total Value',
                    '$currencySymbol${(totalLocked + totalInterest).toStringAsFixed(2)}',
                    Icons.savings_outlined,
                    const Color.fromARGB(255, 78, 3, 208),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: const Color(0xFF9CA3AF),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            '$count ${count == 1 ? 'lock' : 'locks'}',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: const Color(0xFF6366F1),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocksList(List<LockFund> locks) {
    if (locks.isEmpty) {
      return _buildEmptyLocks();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: locks.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) => _buildLockCard(locks[index]),
    );
  }

  Widget _buildLockCard(LockFund lock) {
    final progressColor = lock.status == LockStatus.active
        ? const Color(0xFF6366F1)
        : lock.status == LockStatus.matured
            ? const Color(0xFF10B981)
            : const Color(0xFF6B7280);

    return GestureDetector(
      onTap: () => _navigateToLockDetails(lock),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF2A2A3E).withValues(alpha: 0.8),
              const Color(0xFF1F1F35).withValues(alpha: 0.9),
            ],
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [progressColor, progressColor.withValues(alpha: 0.7)],
                    ),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Center(
                    child: Text(
                      lock.lockType.icon,
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lock.displayName,
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text(
                            lock.lockType.displayName,
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            width: 4.w,
                            height: 4.w,
                            decoration: const BoxDecoration(
                              color: Color(0xFF6B7280),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            '${lock.interestRate.toStringAsFixed(1)}% p.a.',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF10B981),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(lock.status),
                SizedBox(width: 4.w),
                _buildRowMenu(lock),
              ],
            ),
            SizedBox(height: 20.h),
            // Progress bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: const Color(0xFF9CA3AF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${lock.progressPercent.toStringAsFixed(0)}%',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: progressColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Stack(
                  children: [
                    Container(
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: lock.progressPercent / 100,
                      child: Container(
                        height: 6.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [progressColor, progressColor.withValues(alpha: 0.7)],
                          ),
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Locked Amount',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: const Color(0xFF9CA3AF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        lock.formattedAmount,
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Interest Earned',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: const Color(0xFF9CA3AF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      lock.formattedInterest,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: const Color(0xFF9CA3AF),
                  size: 14.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  lock.daysRemainingText,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: const Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  'Total: ${lock.formattedTotalValue}',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: const Color(0xFF10B981),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToLockDetails(LockFund lock) {
    final lockFundsCubit = context.read<LockFundsCubit>();
    final authCubit = context.read<AuthenticationCubit>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: lockFundsCubit),
            BlocProvider.value(value: authCubit),
          ],
          child: LockFundDetailsScreen(lockFund: lock),
        ),
      ),
    ).then((_) {
      // Refresh list when returning from details
      lockFundsCubit.loadLockFunds();
    });
  }

  /// Per-row 3-dot menu — quick actions without opening detail.
  /// Open detail / view receipt always available; cancel is
  /// shown only when the lock is still active + carries a
  /// penalty (so the user can't accidentally cancel a Flex
  /// savings via the menu when "Withdraw" is the right verb).
  Widget _buildRowMenu(LockFund lock) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: Colors.white.withValues(alpha: 0.7), size: 18.sp),
      color: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      tooltip: 'Actions',
      onSelected: (value) {
        switch (value) {
          case 'open':
            _navigateToLockDetails(lock);
            break;
          case 'receipt':
            Get.toNamed(AppRoutes.lockFundReceipt, arguments: {
              'lockFund': lock,
              'interestCalculation': null,
            });
            break;
          case 'copy_id':
            Get.snackbar(
              'Copied',
              lock.id,
              backgroundColor: const Color(0xFF1F1F1F),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 2),
            );
            // Note: dart:io Clipboard requires services import;
            // skipping for brevity. The snackbar shows the ID so
            // the user can long-press to copy from there.
            break;
        }
      },
      itemBuilder: (ctx) => [
        PopupMenuItem(
          value: 'open',
          child: Row(children: [
            Icon(Icons.open_in_new_rounded, color: Colors.white, size: 16.sp),
            SizedBox(width: 8.w),
            Text('Open', style: GoogleFonts.inter(color: Colors.white, fontSize: 12.sp)),
          ]),
        ),
        PopupMenuItem(
          value: 'receipt',
          child: Row(children: [
            Icon(Icons.receipt_long_outlined, color: Colors.white, size: 16.sp),
            SizedBox(width: 8.w),
            Text('View receipt', style: GoogleFonts.inter(color: Colors.white, fontSize: 12.sp)),
          ]),
        ),
        PopupMenuItem(
          value: 'copy_id',
          child: Row(children: [
            Icon(Icons.content_copy_outlined, color: Colors.white, size: 16.sp),
            SizedBox(width: 8.w),
            Text('Show ID', style: GoogleFonts.inter(color: Colors.white, fontSize: 12.sp)),
          ]),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(LockStatus status) {
    Color color;
    switch (status) {
      case LockStatus.active:
        color = const Color(0xFF6366F1);
        break;
      case LockStatus.matured:
        color = const Color(0xFF10B981);
        break;
      case LockStatus.unlocked:
        color = const Color(0xFF6B7280);
        break;
      case LockStatus.cancelled:
        color = const Color(0xFFEF4444);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status.displayName,
        style: GoogleFonts.inter(
          fontSize: 12.sp,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyLocks() {
    return Container(
      padding: EdgeInsets.all(40.w),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6366F1).withValues(alpha: 0.3),
                  const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Icon(
              Icons.lock_outlined,
              size: 40.sp,
              color: const Color(0xFF6366F1),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'No PiggyVault Locks Yet',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Start growing your savings by creating your first lock',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    // Default statistics with 0 values
    final defaultStats = {
      'totalLockedAmount': 0.0,
      'totalAccruedInterest': 0.0,
      'activeLocksCount': 0,
      'totalCount': 0,
    };

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          _buildStatisticsCards(defaultStats),
          SizedBox(height: 48.h),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF6366F1).withValues(alpha: 0.3),
                        const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                  child: Icon(
                    Icons.lock_outlined,
                    size: 40.sp,
                    color: const Color(0xFF6366F1),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Welcome to PiggyVault',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Secure your savings and earn competitive interest',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 100.h), // Space for FAB
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    // Default statistics with 0 values for loading state
    final defaultStats = {
      'totalLockedAmount': 0.0,
      'totalAccruedInterest': 0.0,
      'activeLocksCount': 0,
      'totalCount': 0,
    };

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          _buildStatisticsCards(defaultStats),
          SizedBox(height: 48.h),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Loading your vaults...',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 100.h), // Space for FAB
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    // Default statistics with 0 values for error state
    final defaultStats = {
      'totalLockedAmount': 0.0,
      'totalAccruedInterest': 0.0,
      'activeLocksCount': 0,
      'totalCount': 0,
    };

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          _buildStatisticsCards(defaultStats),
          SizedBox(height: 48.h),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64.sp,
                  color: Colors.red[400],
                ),
                SizedBox(height: 16.h),
                Text(
                  'Something went wrong',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Text(
                    message,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 100.h), // Space for FAB
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color.fromARGB(255, 78, 3, 208)],
        ),
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: () => _showCreateLockDialog(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 20.sp,
        ),
        label: Text(
          'Create Lock',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  void _showCreateLockDialog() {
    // Capture cubits from current context before navigation
    final lockFundsCubit = context.read<LockFundsCubit>();
    final authCubit = context.read<AuthenticationCubit>();
    final accountCardsCubit = context.read<AccountCardsSummaryCubit>();

    // Ensure accounts are loaded for the payment method screen
    final userId = authCubit.userId ?? '';
    if (userId.isNotEmpty) {
      final accountState = accountCardsCubit.state;
      if (accountState is! AccountCardsSummaryLoaded) {
        accountCardsCubit.fetchAccountSummaries(userId: userId);
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: lockFundsCubit),
            BlocProvider.value(value: authCubit),
            BlocProvider.value(value: accountCardsCubit),
            BlocProvider(create: (context) => CreateLockCubit()),
          ],
          child: const CreateLockCarousel(),
        ),
      ),
    ).then((_) {
      // Refresh lock funds list after carousel closes
      if (mounted) {
        lockFundsCubit.loadLockFunds();
      }
    });
  }
}

/// One row in the status-filter strip on the lock-funds list
/// screen. label is the chip text, status is the LockStatus to
/// filter by (null = "All"), count is the number of rows matching
/// the filter in the current loaded page.
class _FilterTab {
  final String label;
  final LockStatus? status;
  final int count;
  const _FilterTab(this.label, this.status, this.count);
}
