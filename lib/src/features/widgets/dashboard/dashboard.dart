import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/widgets/app_services_builder.dart';
import 'package:lazervault/src/features/account_cards_summary/presentation/view/dashboard_card_summary.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
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
import 'package:lazervault/core/types/app_routes.dart';
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

  // Track error snackbar to avoid repeated display
  bool _hasShownErrorSnackbar = false;

  @override
  void initState() {
    super.initState();
    _familyInviteCubit = serviceLocator<FamilyAccountCubit>();
    _familyInviteCubit.loadPendingInvitations();
  }

  Future<void> _onRefresh() async {
    // Allow error snackbar to show again on explicit refresh
    _hasShownErrorSnackbar = false;

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
                        _buildFamilyFriendsCTA(),
                        InviteFriends(),
                        SizedBox(height: 8.0.h),
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
          // Show error snackbar only once to avoid repeated popups on network failure
          if (!_hasShownErrorSnackbar) {
            _hasShownErrorSnackbar = true;
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
          // Do NOT retry here — user can pull-to-refresh to retry
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
            children: [
              ...invitations
                  .map((invite) => _buildInviteCard(invite, isProcessing: isProcessing)),
              if (invitations.length > 1)
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.familyInvitations),
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'View All Invitations',
                          style: TextStyle(
                            color: const Color(0xFF3B82F6),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: const Color(0xFF3B82F6),
                          size: 16.sp,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  /// CTA card for creating Family & Friends accounts (max 3).
  /// Only visible when the user has fewer than 3 family accounts.
  Widget _buildFamilyFriendsCTA() {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        if (state is! AccountCardsSummaryLoaded) return const SizedBox.shrink();

        final familyCount = state.accountSummaries
            .where((a) => a.accountTypeEnum == VirtualAccountType.family)
            .length;

        if (familyCount >= 3) return const SizedBox.shrink();

        final slotsRemaining = 3 - familyCount;

        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1A1A3E), Color(0xFF2D2B6B)],
              ),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1A1A3E).withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 52.w,
                  height: 52.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.family_restroom,
                    color: Colors.white.withValues(alpha: 0.9),
                    size: 28.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Family & Friends',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Share & manage money together. $slotsRemaining ${slotsRemaining == 1 ? 'slot' : 'slots'} available.',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 12.sp,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                GestureDetector(
                  onTap: () {
                    if (Get.isBottomSheetOpen == true) return;
                    _showCreateFamilyAccountSheet(context);
                  },
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.add_rounded,
                      color: const Color(0xFF1A1A3E),
                      size: 24.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCreateFamilyAccountSheet(BuildContext ctx) {
    final nameController = TextEditingController();
    bool isCreating = false;

    // Determine currency from user profile
    String currentCurrency = 'NGN';
    final profileState = ctx.read<ProfileCubit>().state;
    if (profileState is ProfileLoaded) {
      final currency = profileState.preferences.currency;
      if (currency.isNotEmpty) currentCurrency = currency;
    }

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setSheetState) {
          return Container(
            padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Create Family & Friends Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 20.h),
                TextField(
                  controller: nameController,
                  maxLength: 50,
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  decoration: InputDecoration(
                    labelText: 'Account Name',
                    labelStyle: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                    hintText: 'e.g., Kids Allowance, Friend Group, Family Pool',
                    hintStyle: TextStyle(
                      color: const Color(0xFF9CA3AF).withValues(alpha: 0.6),
                      fontSize: 13.sp,
                    ),
                    counterStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Color(0xFF3B82F6)),
                    ),
                    filled: true,
                    fillColor: const Color(0xFF0A0A0A),
                  ),
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: isCreating
                        ? null
                        : () async {
                            final name = nameController.text.trim();
                            if (name.isEmpty) {
                              Get.snackbar(
                                'Required',
                                'Please enter a name for the account',
                                backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP,
                              );
                              return;
                            }

                            setSheetState(() => isCreating = true);

                            try {
                              final familyCubit = serviceLocator<FamilyAccountCubit>();
                              await familyCubit.createAccount(
                                name: name,
                                initialCurrency: currentCurrency,
                                initialFunding: 0.0,
                                allowMemberContributions: true,
                              );

                              if (Get.isBottomSheetOpen != true) return;

                              final state = familyCubit.state;
                              if (state is FamilyAccountCreated) {
                                Get.back(); // Close bottom sheet
                                Get.snackbar(
                                  'Success',
                                  '"$name" account created!',
                                  backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.TOP,
                                );
                                // Refresh dashboard accounts so new family card appears in carousel
                                final accountsCubit = ctx.read<AccountCardsSummaryCubit>();
                                if (accountsCubit.currentUserId != null) {
                                  accountsCubit.fetchAccountSummaries(
                                      userId: accountsCubit.currentUserId!);
                                }
                                // Navigate to family setup
                                Get.toNamed(
                                  AppRoutes.familyActivationSetup,
                                  arguments: {'familyId': state.familyAccount.id},
                                );
                              } else if (state is FamilyAccountError) {
                                setSheetState(() => isCreating = false);
                                Get.snackbar(
                                  'Error',
                                  state.message,
                                  backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.TOP,
                                );
                              } else {
                                setSheetState(() => isCreating = false);
                              }
                            } catch (e) {
                              if (Get.isBottomSheetOpen == true) {
                                setSheetState(() => isCreating = false);
                              }
                              Get.snackbar(
                                'Error',
                                'Failed to create account. Please try again.',
                                backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP,
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      disabledBackgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: isCreating
                        ? SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Create Account',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          );
        },
      ),
      isScrollControlled: true,
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
              : const Color(0xFF2D2B6B).withValues(alpha: 0.4),
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
                      : const Color(0xFF2D2B6B).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isExpired ? Icons.timer_off : Icons.family_restroom,
                  color: isExpired
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF2D2B6B),
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
                        backgroundColor: const Color(0xFF2D2B6B),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: const Color(0xFF2D2B6B).withValues(alpha: 0.4),
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
