import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_session.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_wallet.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_stats.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/spray_room_cubit.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/sprayme_cubit.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/sprayme_state.dart';
import 'package:lazervault/src/features/sprayme/presentation/screens/create_session_screen.dart';
import 'package:lazervault/src/features/sprayme/presentation/screens/join_session_screen.dart';
import 'package:lazervault/src/features/sprayme/presentation/screens/spray_room_screen.dart';
import 'package:lazervault/src/features/sprayme/presentation/screens/sprayme_wallet_screen.dart';
import 'package:lazervault/src/features/sprayme/presentation/screens/session_detail_screen.dart';
import 'package:lazervault/src/features/sprayme/presentation/screens/my_sessions_screen.dart';

class SprayMeHomeScreen extends StatefulWidget {
  const SprayMeHomeScreen({super.key});

  @override
  State<SprayMeHomeScreen> createState() => _SprayMeHomeScreenState();
}

class _SprayMeHomeScreenState extends State<SprayMeHomeScreen> {
  SprayWallet? _wallet;
  List<SpraySession> _sessions = [];
  MySprayStats? _stats;
  bool _isLoadingWallet = true;
  bool _isLoadingSessions = true;
  bool _isLoadingStats = true;

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  void _loadAll() {
    context.read<SprayMeCubit>().loadWallet();
  }

  Future<void> _refresh() async {
    setState(() {
      _isLoadingWallet = true;
      _isLoadingSessions = true;
      _isLoadingStats = true;
    });
    context.read<SprayMeCubit>().loadWallet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: BlocConsumer<SprayMeCubit, SprayMeState>(
          listener: (context, state) {
            if (state is WalletLoaded) {
              setState(() {
                _wallet = state.wallet;
                _isLoadingWallet = false;
              });
              // Chain: after wallet, load sessions
              context.read<SprayMeCubit>().loadMySessions();
            } else if (state is MySessionsLoaded) {
              setState(() {
                _sessions = state.sessions;
                _isLoadingSessions = false;
              });
              // Chain: after sessions, load stats
              context.read<SprayMeCubit>().loadMySprayStats();
            } else if (state is MySprayStatsLoaded) {
              setState(() {
                _stats = state.stats;
                _isLoadingStats = false;
              });
            } else if (state is SprayMeError) {
              // Determine which stage failed and continue loading chain
              if (_isLoadingWallet) {
                setState(() {
                  _isLoadingWallet = false;
                  _wallet = null; // Triggers wallet error UI
                });
                // Continue loading sessions even if wallet failed
                context.read<SprayMeCubit>().loadMySessions();
              } else if (_isLoadingSessions) {
                setState(() => _isLoadingSessions = false);
                // Continue loading stats even if sessions failed
                context.read<SprayMeCubit>().loadMySprayStats();
              } else if (_isLoadingStats) {
                setState(() => _isLoadingStats = false);
              } else {
                // Error from non-chain operation (e.g. join session)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: const Color(0xFFEF4444),
                  ),
                );
              }
            }
          },
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: _refresh,
              color: const Color(0xFF3B82F6),
              backgroundColor: const Color(0xFF1F1F1F),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                children: [
                  _buildHeader(),
                  SizedBox(height: 20.h),
                  _buildWalletCard(),
                  SizedBox(height: 20.h),
                  _buildQuickActions(),
                  SizedBox(height: 24.h),
                  _buildSectionHeader('My Sessions', showViewAll: true),
                  SizedBox(height: 12.h),
                  _buildSessionsList(),
                  SizedBox(height: 24.h),
                  _buildStatsCard(),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        ),
      ),
      // Bottom navigation bar — matches the main dashboard nav for continuity.
      // "Lifestyle" tab (index 4) is highlighted since SprayMe is part of lifestyle.
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF111111),
        border: Border(top: BorderSide(color: Color(0xFF2D2D2D), width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.dashboard_outlined, 'Dashboard', 0),
              _buildNavItem(Icons.pie_chart_outline, 'Budget', 1),
              _buildNavItem(Icons.chat_bubble_outline, 'AI Chat', 2),
              _buildNavItem(Icons.contactless_outlined, 'Beam', 3),
              _buildNavItem(Icons.spa_outlined, 'Lifestyle', 4, isActive: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int tabIndex, {bool isActive = false}) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        if (isActive) return; // Already on lifestyle
        // Pop with tabIndex result — the caller handles switching
        Navigator.of(context).pop(tabIndex);
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? const Color(0xFF7C3AED) : const Color(0xFF6B7280),
              size: 22.sp,
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: TextStyle(
                color: isActive ? const Color(0xFF7C3AED) : const Color(0xFF6B7280),
                fontSize: 10.sp,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Header ───────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF9333EA), Color(0xFFD4A017)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Text(
                  'LazerSpray',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Celebrate moments, spray love',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<SprayMeCubit>(),
                  child: const SprayMeWalletScreen(),
                ),
              ),
            );
          },
          icon: Icon(
            Icons.account_balance_wallet_outlined,
            color: const Color(0xFF9CA3AF),
            size: 24.sp,
          ),
        ),
      ],
    );
  }

  // ── Wallet Balance Card ──────────────────────────────────────────────────────

  Widget _buildWalletCard() {
    if (_isLoadingWallet) {
      return Shimmer.fromColors(
        baseColor: const Color(0xFF1F1F1F),
        highlightColor: const Color(0xFF2D2D2D),
        child: Container(
          height: 160.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      );
    }

    // Show wallet load failure with retry
    if (_wallet == null) {
      return Container(
        height: 120.h,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFFB923C).withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wallet, color: const Color(0xFFFB923C), size: 28.sp),
            SizedBox(height: 8.h),
            Text(
              'Wallet failed to load',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () {
                setState(() => _isLoadingWallet = true);
                context.read<SprayMeCubit>().loadWallet();
              },
              child: Text(
                'Tap to retry',
                style: TextStyle(color: const Color(0xFF3B82F6), fontSize: 13.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      );
    }

    final balance = (_wallet?.balance ?? 0) / 100;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF581C87), Color(0xFF7C3AED), Color(0xFFD4A017)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C3AED).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LazerSpray Wallet',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.monetization_on,
                color: Colors.white.withOpacity(0.6),
                size: 20.sp,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'NGN ${_formatAmount(balance)}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildWalletActionButton(
                  icon: Icons.add,
                  label: 'Fund',
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<SprayMeCubit>(),
                          child: const SprayMeWalletScreen(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildWalletActionButton(
                  icon: Icons.arrow_downward,
                  label: 'Withdraw',
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<SprayMeCubit>(),
                          child: const SprayMeWalletScreen(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWalletActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 16.sp),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Quick Actions ────────────────────────────────────────────────────────────

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            icon: Icons.add_circle_outline,
            label: 'Create Session',
            gradient: [const Color(0xFF7C3AED), const Color(0xFF9333EA)],
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<SprayMeCubit>(),
                    child: const CreateSessionScreen(),
                  ),
                ),
              ).then((_) => _refresh());
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildActionCard(
            icon: Icons.login,
            label: 'Join Session',
            gradient: [const Color(0xFFD4A017), const Color(0xFFF59E0B)],
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<SprayMeCubit>(),
                    child: const JoinSessionScreen(),
                  ),
                ),
              ).then((_) => _refresh());
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 28.sp),
            SizedBox(height: 8.h),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Section Header ───────────────────────────────────────────────────────────

  Widget _buildSectionHeader(String title, {bool showViewAll = false}) {
    if (!showViewAll) {
      return Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<SprayMeCubit>(),
                  child: const MySessionsScreen(),
                ),
              ),
            );
          },
          child: Row(
            children: [
              Text(
                'View All',
                style: TextStyle(
                  color: const Color(0xFF3B82F6),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 4.w),
              Icon(
                Icons.arrow_forward_ios,
                color: const Color(0xFF3B82F6),
                size: 14.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Sessions List ────────────────────────────────────────────────────────────

  Widget _buildSessionsList() {
    if (_isLoadingSessions) {
      return Shimmer.fromColors(
        baseColor: const Color(0xFF1F1F1F),
        highlightColor: const Color(0xFF2D2D2D),
        child: Column(
          children: List.generate(
            3,
            (_) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Container(
                height: 80.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        ),
      );
    }

    if (_sessions.isEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          children: [
            Icon(
              Icons.celebration_outlined,
              size: 48.sp,
              color: const Color(0xFF9CA3AF),
            ),
            SizedBox(height: 12.h),
            Text(
              'No sessions yet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Create or join a session to get started',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: _sessions.take(5).map((session) {
        return _buildSessionTile(session);
      }).toList(),
    );
  }

  Widget _buildSessionTile(SpraySession session) {
    final statusColor = _statusColor(session.status);
    final occasionIcon = _occasionIcon(session.occasionType);
    final occasionColors = OccasionTheme.getGradient(session.occasionType);

    return GestureDetector(
      onTap: () async {
        HapticFeedback.lightImpact();
        if (!session.isActive) {
          // Navigate to session detail for ended sessions
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<SprayMeCubit>(),
                child: SessionDetailScreen(
                  sessionId: session.id,
                  session: session,
                ),
              ),
            ),
          );
          return;
        }
        // For active sessions, navigate to live spray room
        final storage = serviceLocator<SecureStorageService>();
        final token = await storage.getAccessToken();
        if (token == null || !mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => serviceLocator<SprayRoomCubit>(),
              child: SprayRoomScreen(
                sessionId: session.id,
                accessToken: token,
              ),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    occasionColors[0].withOpacity(0.25),
                    occasionColors.length > 1
                        ? occasionColors[1].withOpacity(0.15)
                        : occasionColors[0].withOpacity(0.15),
                  ],
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                occasionIcon,
                color: occasionColors[0],
                size: 22.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    session.occasionType,
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                  if (session.isEnded) ...[
                    SizedBox(height: 2.h),
                    Text(
                      'Total: ${session.currency} ${(session.totalSprayed / 100).toStringAsFixed(0)}',
                      style: TextStyle(
                        color: const Color(0xFFFFD700),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                session.status.toUpperCase(),
                style: TextStyle(
                  color: statusColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Stats Card ───────────────────────────────────────────────────────────────

  Widget _buildStatsCard() {
    if (_isLoadingStats) {
      return Shimmer.fromColors(
        baseColor: const Color(0xFF1F1F1F),
        highlightColor: const Color(0xFF2D2D2D),
        child: Container(
          height: 120.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Stats',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.arrow_upward,
                  label: 'Sprayed',
                  value: 'NGN ${_formatAmount((_stats?.totalSprayed ?? 0) / 100)}',
                  color: const Color(0xFFEF4444),
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.arrow_downward,
                  label: 'Received',
                  value: 'NGN ${_formatAmount((_stats?.totalReceived ?? 0) / 100)}',
                  color: const Color(0xFF10B981),
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.event,
                  label: 'Sessions',
                  value: '${_stats?.totalSessions ?? 0}',
                  color: const Color(0xFF3B82F6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: color, size: 18.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────

  String _formatAmount(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    }
    if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(amount % 1000 == 0 ? 0 : 1)}K';
    }
    return amount.toStringAsFixed(amount == amount.truncateToDouble() ? 0 : 2);
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'live':
        return const Color(0xFF10B981);
      case 'ended':
      case 'completed':
        return const Color(0xFF9CA3AF);
      case 'pending':
        return const Color(0xFFFB923C);
      default:
        return const Color(0xFF3B82F6);
    }
  }

  IconData _occasionIcon(String occasionType) {
    switch (occasionType.toLowerCase()) {
      case 'wedding':
        return Icons.favorite;
      case 'birthday':
        return Icons.cake;
      case 'graduation':
        return Icons.school;
      case 'naming ceremony':
      case 'baby shower':
        return Icons.child_care;
      case 'housewarming':
        return Icons.home;
      case 'funeral':
        return Icons.sentiment_satisfied_alt;
      case 'promotion':
        return Icons.trending_up;
      case 'engagement':
        return Icons.diamond;
      case 'anniversary':
        return Icons.calendar_today;
      case 'retirement':
        return Icons.beach_access;
      case 'send-off':
        return Icons.flight_takeoff;
      case 'house party':
        return Icons.music_note;
      default:
        return Icons.celebration;
    }
  }
}
