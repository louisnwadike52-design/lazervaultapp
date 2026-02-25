import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/widgets/app_services_builder.dart';
import 'package:lazervault/src/features/account_cards_summary/presentation/view/dashboard_card_summary.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/profile/cubit/profile_state.dart';
import 'package:lazervault/src/features/currency_exchange/presentation/cubit/dashboard_rates_cubit.dart';
import 'package:lazervault/src/features/widgets/dashboard/exchange_rates.dart';
import 'package:lazervault/src/features/widgets/dashboard/generate_bank_card.dart';
import 'package:lazervault/src/features/widgets/dashboard/invite_friends.dart';
import 'package:lazervault/src/features/widgets/dashboard/monthly_summary.dart';
import 'package:lazervault/src/features/widgets/dashboard/portfolio.dart';
import 'package:lazervault/src/features/widgets/recent_history.dart';
import 'package:lazervault/src/features/widgets/dashboard/trending_crowdfunds.dart';
import 'package:lazervault/src/features/widgets/dashboard/public_groups.dart';
import 'package:lazervault/src/features/crowdfund/presentation/cubit/leaderboard_cubit.dart';
import 'package:lazervault/src/features/group_account/presentation/cubit/group_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final FamilyAccountCubit _familyInviteCubit;

  // Cache last known invitations so banner doesn't flash during loading
  List<PendingInvitation> _cachedInvitations = [];

  @override
  void initState() {
    super.initState();
    _familyInviteCubit = serviceLocator<FamilyAccountCubit>();
    _familyInviteCubit.loadPendingInvitations();
  }

  Future<void> _onRefresh() async {
    // Refresh dashboard data by fetching account summaries
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      final userId = authState.profile.user.id;
      final accessToken = authState.profile.session.accessToken;

      // Get active country from ProfileCubit
      final profileState = context.read<ProfileCubit>().state;
      String? activeCountry;
      if (profileState is ProfileLoaded) {
        activeCountry = profileState.preferences.activeCountry.isNotEmpty
            ? profileState.preferences.activeCountry
            : null;
      }

      // Refresh account summaries
      await context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
            userId: userId,
            accessToken: accessToken,
            country: activeCountry,
          );

      // Refresh family invitations
      _familyInviteCubit.loadPendingInvitations();
    }
  }

  String _getBaseCurrency() {
    final profileState = context.read<ProfileCubit>().state;
    if (profileState is ProfileLoaded) {
      final currency = profileState.preferences.currency;
      if (currency.isNotEmpty) return currency;
    }
    return 'NGN';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: ClampingScrollPhysics(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DashboardCardSummary(),
                  _buildPendingInvitationsBanner(),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        AppServicesBuilder(),
                        SizedBox(height: 16.0.h),
                        InviteFriends(),
                        SizedBox(height: 16.0.h),
                        RecentHistory(),
                        SizedBox(height: 16.0.h),
                        BlocProvider(
                          create: (_) => serviceLocator<LeaderboardCubit>(),
                          child: const TrendingCrowdfunds(),
                        ),
                        SizedBox(height: 16.0.h),
                        BlocProvider.value(
                          value: serviceLocator<GroupAccountCubit>(),
                          child: const PublicGroups(),
                        ),
                        SizedBox(height: 16.0.h),
                        GenerateBankCard(),
                        SizedBox(height: 16.0.h),
                        Portfolio(),
                        SizedBox(height: 16.0.h),
                        BlocProvider(
                          create: (_) => serviceLocator<DashboardRatesCubit>()
                            ..loadRates(_getBaseCurrency()),
                          child: const ExchangeRates(),
                        ),
                        SizedBox(height: 16.0.h),
                        MonthlySummary(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
    );
  }

  Widget _buildPendingInvitationsBanner() {
    return BlocConsumer<FamilyAccountCubit, FamilyAccountState>(
      bloc: _familyInviteCubit,
      listener: (context, state) {
        if (state is InvitationAccepted) {
          Get.snackbar(
            'Invitation Accepted',
            'You have joined the family account!',
            backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
          // Refresh dashboard to show the new family card
          _onRefresh();
        } else if (state is InvitationDeclined) {
          Get.snackbar(
            'Invitation Declined',
            'The invitation has been declined.',
            backgroundColor: const Color(0xFF9CA3AF).withValues(alpha: 0.9),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
          _familyInviteCubit.loadPendingInvitations();
        } else if (state is FamilyAccountError) {
          Get.snackbar(
            'Error',
            state.message,
            backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
          // Reload invitations so buttons re-enable
          _familyInviteCubit.loadPendingInvitations();
        }
      },
      builder: (context, state) {
        // Update cache when fresh data arrives
        if (state is PendingInvitationsLoaded) {
          _cachedInvitations = state.invitations
              .where((inv) => !inv.isExpired)
              .toList();
        } else if (state is InvitationAccepted || state is InvitationDeclined) {
          // Clear cache — will be repopulated when loadPendingInvitations completes
          _cachedInvitations = [];
        }

        // Show cached invitations during loading (prevents flash)
        final invitations = _cachedInvitations;
        if (invitations.isEmpty) return const SizedBox.shrink();

        final isProcessing = state is FamilyAccountLoading;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            children: invitations
                .map((invite) => _buildInviteCard(invite, isProcessing: isProcessing))
                .toList(),
          ),
        );
      },
    );
  }

  Widget _buildInviteCard(PendingInvitation invite, {bool isProcessing = false}) {
    final isExpired = invite.isExpired;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isExpired
              ? const Color(0xFFEF4444).withValues(alpha: 0.3)
              : const Color(0xFF2D6B6B).withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: isExpired
                      ? const Color(0xFFEF4444).withValues(alpha: 0.15)
                      : const Color(0xFF2D6B6B).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isExpired ? Icons.timer_off : Icons.family_restroom,
                  color: isExpired
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF2D6B6B),
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isExpired
                          ? 'Expired Invitation'
                          : 'Family Account Invitation',
                      style: TextStyle(
                        color: isExpired
                            ? const Color(0xFFEF4444)
                            : Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${invite.creatorName} invited you to "${invite.familyName}"',
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (!isExpired)
                Text(
                  invite.daysUntilExpiration <= 0
                      ? '<1d left'
                      : '${invite.daysUntilExpiration}d left',
                  style: TextStyle(
                    color: invite.daysUntilExpiration <= 1
                        ? const Color(0xFFEF4444)
                        : const Color(0xFFFB923C),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          if (isExpired)
            Center(
              child: TextButton(
                onPressed: () => _familyInviteCubit.declineInvitation(invite.invitationToken),
                child: Text(
                  'Dismiss',
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                  ),
                ),
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40.h,
                    child: OutlinedButton(
                      onPressed: isProcessing
                          ? null
                          : () => _familyInviteCubit.declineInvitation(invite.invitationToken),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF9CA3AF),
                        side: const BorderSide(color: Color(0xFF2D2D2D)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Decline',
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: SizedBox(
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: isProcessing
                          ? null
                          : () => _familyInviteCubit.acceptInvitation(invite.invitationToken),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2D6B6B),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: const Color(0xFF2D6B6B).withValues(alpha: 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: isProcessing
                          ? SizedBox(
                              width: 18.w,
                              height: 18.h,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Accept',
                              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                            ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
