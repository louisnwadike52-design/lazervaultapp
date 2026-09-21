import 'package:lazervault/src/features/sprayme/domain/repositories/i_sprayme_repository.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/session_invite.dart';
import 'package:lazervault/src/features/sprayme/presentation/widgets/invited_sessions_section.dart';
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
import 'package:lazervault/src/features/sprayme/presentation/widgets/spray_wallet_action_sheet.dart';
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

  /// Celebrations this user has been tagged into by someone else.
  ///
  /// Loaded independently of the cubit's session chain: a failure to read
  /// invitations must not stop the wallet, the user's own sessions or the stats
  /// from rendering — and an invite list is the least important of the four.
  List<InvitedSession> _invitedSessions = const [];

  /// The signed-in user's id, used only to word the resume banner correctly
  /// ("Re-enter your session" for the host vs "Rejoin session" for a guest).
  /// Null until resolved — the banner then falls back to the guest wording,
  /// which is the safe default: telling a guest it is "your session" is a
  /// worse error than being vague at a host.
  String? _currentUserId;
  MySprayStats? _stats;
  bool _isLoadingWallet = true;
  bool _isLoadingSessions = true;
  bool _isLoadingStats = true;
  // Per-section error state. Errors are rendered INLINE on each widget (never a
  // snackbar) and only retried on an explicit tap — there is NO auto-retry loop.
  bool _walletError = false;
  bool _sessionsError = false;
  bool _statsError = false;

  @override
  void initState() {
    super.initState();
    _resolveCurrentUser();
    _loadAll();
  }

  Future<void> _resolveCurrentUser() async {
    try {
      final id = await serviceLocator<SecureStorageService>().getUserId();
      if (mounted && id != null) setState(() => _currentUserId = id);
    } catch (_) {
      // Non-fatal: only affects the banner's wording.
    }
  }

  void _loadAll() {
    setState(() {
      _isLoadingWallet = true;
      _walletError = false;
    });
    context.read<SprayMeCubit>().loadWallet();
    _loadInvites();
  }

  /// Reads the sessions this user has been tagged into.
  ///
  /// Silent on failure: the section simply does not appear. An error banner
  /// about invitations, sitting above a wallet that loaded perfectly well,
  /// would suggest something is wrong with the page.
  Future<void> _loadInvites() async {
    try {
      final invites =
          await serviceLocator<ISprayMeRepository>().getInvitedSessions();
      if (!mounted) return;
      setState(() => _invitedSessions = invites);
    } catch (_) {
      // Keep whatever was already on screen.
    }
  }

  /// Joins a session the user was tagged into, then opens the room.
  ///
  /// An invitee is NOT yet a participant, so the join has to happen first —
  /// opening the room directly would put them in a broadcast they have no
  /// participant row for, and their sprays would have nowhere to attribute.
  /// Joining also marks the invite accepted server-side, which is what stops it
  /// showing as a pending invitation to a party they are standing in.
  Future<void> _joinInvitedSession(InvitedSession invite) async {
    final code = invite.session.sessionCode;
    if (code.isEmpty) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await serviceLocator<ISprayMeRepository>().joinSession(code);
      if (!mounted) return;
      await _openSession(invite.session);
      if (!mounted) return;
      _loadInvites();
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst('Exception: ', '').trim().isEmpty
                ? 'Could not join that celebration'
                : e.toString().replaceFirst('Exception: ', '').trim(),
          ),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  /// Dismisses an invitation so it leaves this page.
  Future<void> _dismissInvite(InvitedSession invite) async {
    // Removed locally first so the tap feels immediate; the server call is
    // idempotent, and a failure only means it reappears on the next refresh.
    setState(() => _invitedSessions = _invitedSessions
        .where((i) => i.session.id != invite.session.id)
        .toList());
    try {
      await serviceLocator<ISprayMeRepository>().declineInvite(invite.session.id);
    } catch (_) {
      // Left dismissed locally; the next load reconciles.
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _isLoadingWallet = true;
      _isLoadingSessions = true;
      _isLoadingStats = true;
      _walletError = false;
      _sessionsError = false;
      _statsError = false;
    });
    context.read<SprayMeCubit>().loadWallet();
  }

  // Single-shot retry helpers (used by the inline error CTAs). Each clears its
  // own error, shows the loading state, and kicks exactly one load — no loop.
  void _retryWallet() {
    setState(() {
      _isLoadingWallet = true;
      _walletError = false;
    });
    context.read<SprayMeCubit>().loadWallet();
  }

  void _retrySessions() {
    setState(() {
      _isLoadingSessions = true;
      _sessionsError = false;
    });
    context.read<SprayMeCubit>().loadMySessions();
  }

  void _retryStats() {
    setState(() {
      _isLoadingStats = true;
      _statsError = false;
    });
    context.read<SprayMeCubit>().loadMySprayStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: BlocConsumer<SprayMeCubit, SprayMeState>(
          listener: (context, state) {
            // Sections load sequentially (wallet → sessions → stats) so exactly
            // one stage is in-flight when a result or error arrives; we key off
            // the loading flags to attribute it. Errors are surfaced INLINE on the
            // failing section (no snackbar) and never auto-retried, so a persistent
            // server error can't spin a toast/bottomsheet loop.
            if (state is WalletLoaded) {
              setState(() {
                _wallet = state.wallet;
                _isLoadingWallet = false;
                _walletError = false;
              });
              // Chain: after wallet, load sessions
              context.read<SprayMeCubit>().loadMySessions();
            } else if (state is MySessionsLoaded) {
              setState(() {
                _sessions = state.sessions;
                _isLoadingSessions = false;
                _sessionsError = false;
              });
              // Chain: after sessions, load stats
              context.read<SprayMeCubit>().loadMySprayStats();
            } else if (state is MySprayStatsLoaded) {
              setState(() {
                _stats = state.stats;
                _isLoadingStats = false;
                _statsError = false;
              });
            } else if (state is SprayMeError) {
              // Attribute the error to the in-flight stage, mark it failed inline,
              // and CONTINUE the chain so the other independent sections still load.
              if (_isLoadingWallet) {
                setState(() {
                  _isLoadingWallet = false;
                  _walletError = true;
                });
                context.read<SprayMeCubit>().loadMySessions();
              } else if (_isLoadingSessions) {
                setState(() {
                  _isLoadingSessions = false;
                  _sessionsError = true;
                });
                context.read<SprayMeCubit>().loadMySprayStats();
              } else if (_isLoadingStats) {
                setState(() {
                  _isLoadingStats = false;
                  _statsError = true;
                });
              }
              // Errors from non-chain operations (e.g. a join attempt on another
              // screen sharing this cubit) are intentionally ignored here — the
              // originating screen renders its own error. No snackbar on landing.
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
                  // Sits ABOVE the wallet, because a session you are still
                  // live in outranks everything else on this page.
                  _buildResumeBanner(),
                  _buildWalletCard(),
                  SizedBox(height: 20.h),
                  _buildQuickActions(),
                  SizedBox(height: 24.h),
                  // Invitations, directly under the funds card and above your
                  // own sessions: an invitation stops being joinable when the
                  // host ends the party, so it is the more time-limited of the
                  // two. Hides itself when there are none.
                  if (_invitedSessions.isNotEmpty) ...[
                    InvitedSessionsSection(
                      invites: _invitedSessions,
                      onJoin: _joinInvitedSession,
                      onDismiss: _dismissInvite,
                    ),
                    SizedBox(height: 24.h),
                  ],
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
      // No bottom nav inside Lazerspray.
      //
      // This screen is a pushed route, so the bar it drew was a REPLICA of the
      // dashboard's — tapping it had to pop back out and switch tabs, which is
      // not what a nav bar promises. A full-screen feature should own its
      // chrome; Back is the way out.
      bottomNavigationBar: null,
    );
  }

// ── Header ───────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Row(
      children: [
        // Back button — restored so users can return to the previous
        // dashboard surface from this nested page.
        IconButton(
          onPressed: () {
            HapticFeedback.selectionClick();
            Navigator.of(context).maybePop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(
            minWidth: 36.w,
            minHeight: 36.w,
          ),
        ),
        SizedBox(width: 4.w),
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
                  'Lazerspray',
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
                builder: (_) => BlocProvider(
                  create: (_) => serviceLocator<SprayMeCubit>(),
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

    // Inline wallet-load failure (only when we have no cached wallet to show).
    // A tap retries exactly once — no snackbar, no auto-retry loop.
    if (_wallet == null && _walletError) {
      return Container(
        height: 120.h,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border:
              Border.all(color: const Color(0xFFFB923C).withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off_rounded,
                color: const Color(0xFFFB923C), size: 26.sp),
            SizedBox(height: 8.h),
            Text(
              "Couldn't load your wallet",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4.h),
            Text(
              'Check your connection and try again',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
            ),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: _retryWallet,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C3AED).withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                      color: const Color(0xFF7C3AED).withValues(alpha: 0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.refresh_rounded,
                        color: const Color(0xFFB794F6), size: 15.sp),
                    SizedBox(width: 6.w),
                    Text('Retry',
                        style: TextStyle(
                            color: const Color(0xFFB794F6),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Defensive: no data yet and not (loading|errored) — keep a shimmer rather
    // than blanking the card. (Should not normally happen.)
    if (_wallet == null) {
      return const SizedBox.shrink();
    }

    final spendable = (_wallet?.balance ?? 0) / 100;
    final earnings = (_wallet?.earningsBalance ?? 0) / 100;

    void openWallet() {
      HapticFeedback.lightImpact();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => serviceLocator<SprayMeCubit>(),
            child: const SprayMeWalletScreen(),
          ),
        ),
      );
    }

    // Fund = top up spendable spray balance from the main account (before
    // buying gifts). Withdraw = move earnings back to the main account. Both
    // gate on the canonical tx-PIN bottom sheet inside the action sheet.
    Future<void> openWalletAction(SprayWalletAction action) async {
      HapticFeedback.lightImpact();
      final w = _wallet;
      if (w == null) {
        openWallet(); // wallet not loaded yet — fall back to the detail screen
        return;
      }
      final updated =
          await showSprayWalletActionSheet(context, action: action, wallet: w);
      if (updated != null && mounted) {
        setState(() => _wallet = updated);
        context.read<SprayMeCubit>().loadWallet();
      }
    }

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
                'Gifts to spray',
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
          SizedBox(height: 10.h),
          // Spendable spray credit (bought from your personal account in a session).
          Text(
            'NGN ${_formatAmount(spendable)}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ),
          SizedBox(height: 10.h),
          // Earnings (received gifts) — withdrawable to personal.
          Row(
            children: [
              Icon(Icons.savings_outlined,
                  color: const Color(0xFF34D399), size: 15.sp),
              SizedBox(width: 6.w),
              Text(
                'Earnings  NGN ${_formatAmount(earnings)}',
                style: TextStyle(
                  color: const Color(0xFF34D399),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildWalletActionButton(
                  icon: Icons.add_card_rounded,
                  label: 'Fund Wallet',
                  onTap: () => openWalletAction(SprayWalletAction.fund),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildWalletActionButton(
                  icon: Icons.arrow_downward,
                  label: 'Withdraw',
                  onTap: () => openWalletAction(SprayWalletAction.withdraw),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // History link — the full wallet screen is now history/earnings only.
          GestureDetector(
            onTap: openWallet,
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.receipt_long_outlined,
                    color: Colors.white.withOpacity(0.85), size: 15.sp),
                SizedBox(width: 6.w),
                Text(
                  'View history',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 3.w),
                Icon(Icons.arrow_forward_ios,
                    color: Colors.white.withOpacity(0.7), size: 11.sp),
              ],
            ),
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
                  builder: (_) => BlocProvider(
                    create: (_) => serviceLocator<SprayMeCubit>(),
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
                  builder: (_) => BlocProvider(
                    create: (_) => serviceLocator<SprayMeCubit>(),
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
                builder: (_) => BlocProvider(
                  create: (_) => serviceLocator<SprayMeCubit>(),
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

    // Inline sessions-load failure (only when we have nothing cached to show).
    if (_sessions.isEmpty && _sessionsError) {
      return _buildInlineSectionError(
        message: "Couldn't load your sessions",
        onRetry: _retrySessions,
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

    // ACTIVE SESSIONS FIRST, and never truncated away.
    //
    // The server returns sessions ordered by created_at DESC with no notion of
    // which are live, and this list showed only the first five. So a host with
    // six or more sessions whose live one was not among the most recent had no
    // visible way back into it — the "Join" CTA on the row existed, but the row
    // itself never rendered. A session you are still live in is the single most
    // actionable thing on this screen; it cannot be paged off the bottom.
    final active = _sessions.where((s) => s.isActive).toList();
    final past = _sessions.where((s) => !s.isActive).toList();
    final shownPast = past.take(5 - active.length.clamp(0, 5)).toList();

    // LABELLED, not merely ordered. Live and finished sessions render as
    // identical rows, so a list that only sorted them left the user working out
    // which was which from the row's CTA — and the whole of "View all" exists
    // to hold the finished ones.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (active.isNotEmpty) ...[
          _buildSessionGroupLabel('Live now', const Color(0xFF10B981)),
          ...active.map(_buildSessionTile),
        ],
        if (shownPast.isNotEmpty) ...[
          if (active.isNotEmpty) SizedBox(height: 14.h),
          _buildSessionGroupLabel('Ended', const Color(0xFF6B7280)),
          ...shownPast.map(_buildSessionTile),
        ],
      ],
    );
  }

  /// A small heading separating live sessions from finished ones.
  Widget _buildSessionGroupLabel(String text, Color dot) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, left: 2.w),
      child: Row(
        children: [
          Container(
            width: 7.w,
            height: 7.w,
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
          SizedBox(width: 7.w),
          Text(
            text,
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  /// Sessions the user can walk straight back into — hosted or joined.
  List<SpraySession> get _resumableSessions =>
      _sessions.where((s) => s.isActive).toList();

  /// "You're still live" banner.
  ///
  /// The resume CTAs already existed on the session rows and in My Sessions,
  /// but both required the user to go looking — and the row could be pushed out
  /// of the five shown here entirely. Someone who backgrounded the app mid-
  /// stream should not have to hunt for the way back into their own broadcast,
  /// so the live session is surfaced at the top of the page, above the wallet.
  ///
  /// Hidden entirely when nothing is live: an empty banner reserving space is
  /// worse than no banner.
  Widget _buildResumeBanner() {
    final live = _resumableSessions;
    if (live.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        ...live.map(_buildResumeCard),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildResumeCard(SpraySession session) {
    // A host is re-entering their OWN broadcast; a guest is returning to
    // someone else's. Same destination, different promise — so the wording
    // differs rather than showing everyone a generic "Open".
    final isHost =
        _currentUserId != null && session.hostUserId == _currentUserId;
    final verb = isHost ? 'Re-enter your session' : 'Rejoin session';

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF059669)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () => _openSession(session),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.podcasts_rounded,
                      color: Colors.white, size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 7.w,
                            height: 7.w,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'LIVE NOW',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        session.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.5.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        verb,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_rounded,
                    color: Colors.white, size: 20.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSessionTile(SpraySession session) {
    final statusColor = _statusColor(session.status);
    final occasionIcon = _occasionIcon(session.occasionType);
    final occasionColors = OccasionTheme.getGradient(session.occasionType);

    return GestureDetector(
      onTap: () => _openSession(session),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          // No hairline border. A 1px #2D2D2D outline on a #1F1F1F fill reads as
          // a seam rather than an edge; separation comes from the surface being
          // lighter than the page, which is what the rest of the product does.
          color: const Color(0xFF181818),
          borderRadius: BorderRadius.circular(16.r),
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
            // Active sessions get a one-tap "Join" so the creator (or a joiner)
            // jumps straight back in — no copy-code + manual Join needed.
            if (session.isActive)
              GestureDetector(
                onTap: () => _openSession(session),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF10B981), Color(0xFF059669)],
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.play_arrow_rounded,
                          color: Colors.white, size: 15.sp),
                      SizedBox(width: 3.w),
                      Text('Join',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              )
            else
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  // statusLabel, never `status` — the raw value is the protobuf
                  // enum name and was rendering as "SESSION_STATUS_ENDED".
                  session.statusLabel,
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

  /// Open an active session straight into the live room (re-entry — host or
  /// joiner — with no code retype); ended sessions open their detail screen.
  Future<void> _openSession(SpraySession session) async {
    HapticFeedback.lightImpact();
    if (!session.isActive) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => serviceLocator<SprayMeCubit>(),
            child: SessionDetailScreen(sessionId: session.id, session: session),
          ),
        ),
      );
      return;
    }
    final storage = serviceLocator<SecureStorageService>();
    final token = await storage.getAccessToken();
    if (token == null || !mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => serviceLocator<SprayRoomCubit>(),
          child: SprayRoomScreen(sessionId: session.id, accessToken: token),
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

    if (_stats == null && _statsError) {
      return _buildInlineSectionError(
        message: "Couldn't load your stats",
        onRetry: _retryStats,
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
                  value:
                      'NGN ${_formatAmount((_stats?.totalSprayed ?? 0) / 100)}',
                  color: const Color(0xFFEF4444),
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.arrow_downward,
                  label: 'Received',
                  value:
                      'NGN ${_formatAmount((_stats?.totalReceived ?? 0) / 100)}',
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

  /// Inline, tappable error card used for the Sessions/Stats sections. Mirrors
  /// the wallet inline error — never a snackbar, retry only on explicit tap.
  Widget _buildInlineSectionError({
    required String message,
    required VoidCallback onRetry,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          Icon(Icons.wifi_off_rounded,
              size: 30.sp, color: const Color(0xFFFB923C)),
          SizedBox(height: 10.h),
          Text(
            message,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: onRetry,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: const Color(0xFF7C3AED).withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                    color: const Color(0xFF7C3AED).withValues(alpha: 0.4)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh_rounded,
                      color: const Color(0xFFB794F6), size: 15.sp),
                  SizedBox(width: 6.w),
                  Text('Retry',
                      style: TextStyle(
                          color: const Color(0xFFB794F6),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
