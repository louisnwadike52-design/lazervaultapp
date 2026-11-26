import 'package:lazervault/core/config/feature_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../cubit/referral_cubit.dart';
import '../cubit/referral_state.dart';
import '../widgets/referral_code_card.dart';
import '../widgets/how_it_works_card.dart';
import '../widgets/referral_stats_card.dart';
import '../widgets/leaderboard_list.dart';
import '../widgets/recent_referrals_list.dart';
import '../widgets/referral_bonus_card.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/referral/domain/referral_programme_copy.dart';

class ReferralDashboardScreen extends StatefulWidget {
  const ReferralDashboardScreen({super.key});

  @override
  State<ReferralDashboardScreen> createState() =>
      _ReferralDashboardScreenState();
}

class _ReferralDashboardScreenState extends State<ReferralDashboardScreen> {
  // Used only to mark the viewer's own row on the leaderboard. It is NOT an
  // identity check: referral-service cannot send a usable user id (the proto
  // field is a uint64 and real ids are UUIDs), and the old comparison matched
  // 0 == 0 and badged every row as "You". LeaderboardList badges a name only
  // when exactly one entry matches it.
  String? _myDisplayName;

  /// Whether the leaderboard was enabled the last time we looked.
  ///
  /// Seeded in [initState] so the first revision bump after launch — which is
  /// the ordinary one, when the startup snapshot lands — is not mistaken for
  /// an operator flipping the switch.
  bool _leaderboardWasEnabled = false;

  @override
  void initState() {
    super.initState();
    _leaderboardWasEnabled = FeatureFlags.referralLeaderboardEnabled;
    // TURNING THE FLAG ON MID-SESSION MUST ALSO FETCH THE DATA.
    //
    // The gated section repaints on a revision bump, but while the flag was
    // off the cubit never requested the leaderboard — deliberately, so a
    // hidden surface costs no round trip. Repainting alone would therefore
    // reveal an empty section and leave it empty until the user navigated
    // away and back, which reads as a broken feature rather than a flag that
    // has just been switched on.
    //
    // Only an OFF→ON transition reloads. A bump that leaves the flag
    // unchanged, or turns it off, triggers nothing: off needs no data, and
    // reloading on every snapshot would put this screen in a refresh loop
    // driven by an unrelated poll.
    FeatureFlags.revision.addListener(_onFlagsChanged);
    context.read<ReferralCubit>().loadDashboard();
    _loadMyDisplayName();
  }

  void _onFlagsChanged() {
    final nowEnabled = FeatureFlags.referralLeaderboardEnabled;
    final justTurnedOn = nowEnabled && !_leaderboardWasEnabled;
    _leaderboardWasEnabled = nowEnabled;
    if (!justTurnedOn || !mounted) return;
    context.read<ReferralCubit>().loadDashboard();
  }

  @override
  void dispose() {
    FeatureFlags.revision.removeListener(_onFlagsChanged);
    super.dispose();
  }

  Future<void> _loadMyDisplayName() async {
    try {
      final name =
          await serviceLocator<SecureStorageService>().getUserFullName();
      if (!mounted) return;
      final trimmed = name?.trim();
      if (trimmed == null || trimmed.isEmpty) return;
      setState(() => _myDisplayName = trimmed);
    } catch (_) {
      // No name cached (fresh install, cleared storage): the leaderboard simply
      // renders without a "You" badge, which is the correct degradation.
    }
  }

  Future<void> _onRefresh() async {
    await context.read<ReferralCubit>().refreshDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: Text(
          'Referral Program',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: BlocConsumer<ReferralCubit, ReferralState>(
        listener: (context, state) {
          if (state is ReferralCodeCopied) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Referral code copied to clipboard!'),
                backgroundColor: const Color(0xFF10B981),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          }

          if (state is ReferralError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ReferralLoading) {
            return _buildLoadingState();
          }

          if (state is ReferralError) {
            return _buildErrorState(state.message);
          }

          if (state is ReferralLoaded) {
            return _buildLoadedState(state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LazerVaultLoader.small(),
          SizedBox(height: 16.h),
          Text(
            'Loading referral data...',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64.sp,
              color: const Color(0xFFEF4444),
            ),
            SizedBox(height: 16.h),
            Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF9CA3AF),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () => context.read<ReferralCubit>().loadDashboard(),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedState(ReferralLoaded state) {
    final cubit = context.read<ReferralCubit>();

    // ONE RESOLUTION OF THE PROGRAMME'S STATE, FOR THE WHOLE PAGE.
    //
    // Four cards used to make the same promise independently, in compiled
    // text, and none of them consulted whether the reward was still being
    // paid. Resolving it once here means the banner, the stats footnote, the
    // empty prompt and the KYC summary cannot say different things.
    final copy = ReferralProgrammeCopy.resolve(
      programmeActive: state.bonusBalance.programmeActive,
      programmeNotice: state.bonusBalance.programmeNotice,
      referrerRewardMinor: state.rewardConfig?.referrerReward ?? 0,
      refereeRewardMinor: state.rewardConfig?.refereeReward ?? 0,
      rewardConfigLoaded: state.rewardConfig != null,
    );

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),

            // THE STATE OF THE PROGRAMME, BEFORE ANYTHING THAT INVITES
            // SHARING. A referrer who is about to send their code needs to
            // know the reward is paused BEFORE they send it, not in a
            // footnote below the stats.
            if (copy.paused) _buildProgrammeNotice(copy),

            // Referral Code Card
            ReferralCodeCard(
              code: state.myCode.code,
              onCopy: () => cubit.copyReferralCode(state.myCode.code),
              onShare: () => cubit.shareReferralCode(
                state.myCode.code,
                // From the COUNTRY CONFIG, not the stats block: stats carries
                // the currency of what has been earned, which is empty for a
                // user who has not referred anyone yet — the exact user who is
                // about to share.
                currency: state.rewardConfig?.currency ?? state.stats.currency,
                refereeRewardMinor: state.rewardConfig?.refereeReward,
              ),
            ),

            // LazerPoints quick access card
            _buildLazerPointsCard(),

            // How It Works
            // Only when the real reward is known. An unknown reward shows no
            // promise at all — advertising the wrong currency is worse than
            // advertising nothing, because the user acts on it.
            if (state.rewardConfig != null)
              HowItWorksCard(
                currency: state.rewardConfig!.currency,
                referrerReward: state.rewardConfig!.referrerReward,
                refereeReward: state.rewardConfig!.refereeReward,
              ),

            // Accrued bonus and the one action on it. Above the stats panel
            // deliberately: the claimable number is what the user came for,
            // and the stats explain it.
            ReferralBonusCard(balance: state.bonusBalance),

            // Stats
            ReferralStatsCard(
              totalReferrals: state.stats.totalReferrals,
              totalRewardsEarned: state.stats.totalRewardsEarned,
              pendingRewards: state.stats.pendingRewards,
              currency: state.stats.currency,
              copy: copy,
            ),

            // LEADERBOARD — ADMIN-GATED, HIDDEN BY DEFAULT.
            //
            // It publishes other customers' names and referral counts to
            // every user, so it stays off until an operator turns it on.
            //
            // Wrapped in a ValueListenableBuilder on FeatureFlags.revision so
            // a flip applied by the background snapshot poll repaints THIS
            // session. Reading the flag directly would leave the old value on
            // screen until some unrelated rebuild happened to occur, which
            // for a disclosure switch means "takes effect whenever the user
            // next restarts the app".
            //
            // The flag read itself is synchronous, so nothing here waits on
            // the network — and when it is off the cubit never fetched the
            // list at all, so there is no empty section and no wasted call.
            ValueListenableBuilder<int>(
              valueListenable: FeatureFlags.revision,
              builder: (context, _, __) {
                if (!FeatureFlags.referralLeaderboardEnabled) {
                  // Nothing, not a placeholder: a hidden surface should leave
                  // no gap in the column for the user to wonder about.
                  return const SizedBox.shrink();
                }
                if (state.leaderboard.isEmpty) {
                  // On but empty — nobody has referred anyone yet, or the
                  // fetch failed and was swallowed as non-fatal. Either way
                  // the rest of the dashboard is intact and an empty ranking
                  // is not worth a slot.
                  return const SizedBox.shrink();
                }
                return LeaderboardList(
                  entries: state.leaderboard,
                  currentUserName: _myDisplayName,
                );
              },
            ),

            // Recent Referrals with "View All" header
            _buildRecentReferralsSection(state, copy),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  /// THE PROGRAMME IS NOT PAYING — SAID PLAINLY, AT THE TOP.
  ///
  /// Amber rather than red: nothing has failed and nothing has been taken
  /// away. Referrals are still recorded in the paused state, and an accrued
  /// balance stays the user's in both — so this is a change of terms, not an
  /// error, and it must not read as one.
  ///
  /// Every word comes from [ReferralProgrammeCopy], which reads the operator's
  /// own notice before any compiled fallback.
  Widget _buildProgrammeNotice(ReferralProgrammeCopy copy) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF59E0B).withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14.r),
        border:
            Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded,
              size: 17.sp, color: const Color(0xFFF59E0B)),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              copy.notice,
              style: TextStyle(
                fontSize: 12.sp,
                height: 1.4,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFFCD34D),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLazerPointsCard() {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.lazerPoints),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromARGB(255, 78, 3, 208), Color(0xFF6D28D9)],
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child:
                  Icon(Icons.stars_rounded, color: Colors.white, size: 24.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lazerpoints',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Earn points for referrals, transactions & more',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                color: Colors.white.withValues(alpha: 0.7), size: 24.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentReferralsSection(
      ReferralLoaded state, ReferralProgrammeCopy copy) {
    return Column(
      children: [
        // Header with "View All" button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Referrals',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.allReferrals),
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
              ),
            ],
          ),
        ),
        RecentReferralsList(
          referrals: state.recentReferrals,
          currency: state.stats.currency,
          copy: copy,
        ),
      ],
    );
  }
}
