import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/card_settings/cubit/card_settings_cubit.dart';
import 'package:lazervault/src/features/card_settings/cubit/card_settings_state.dart';
import 'package:lazervault/src/features/card_settings/domain/entities/account_details_entity.dart';

class CardSettingsScreen extends StatelessWidget {
  const CardSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<CardSettingsCubit>(),
        ),
      ],
      child: const _CardSettingsView(),
    );
  }
}

class _CardSettingsView extends StatefulWidget {
  const _CardSettingsView();

  @override
  State<_CardSettingsView> createState() => _CardSettingsViewState();
}

class _CardSettingsViewState extends State<_CardSettingsView> {
  @override
  void initState() {
    super.initState();
    _loadAccountData();
  }

  void _loadAccountData() {
    final authCubit = context.read<AuthenticationCubit>();
    final userId = authCubit.currentProfile?.user.id;

    if (userId != null) {
      context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
        userId: userId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Card Settings',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1F2937),
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<CardSettingsCubit, CardSettingsState>(
        listener: (context, state) {
          if (state is CardSettingsUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white, size: 20.sp),
                    SizedBox(width: 12.w),
                    Text(
                      state.message,
                      style: GoogleFonts.inter(fontSize: 14.sp),
                    ),
                  ],
                ),
                backgroundColor: const Color(0xFF10B981),
                duration: const Duration(seconds: 2),
              ),
            );
          } else if (state is CardSettingsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.error, color: Colors.white, size: 20.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        state.message,
                        style: GoogleFonts.inter(fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
                backgroundColor: const Color(0xFFEF4444),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        child: BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
          builder: (context, state) {
            if (state is AccountCardsSummaryLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: const Color(0xFF4E03D0),
                ),
              );
            } else if (state is AccountCardsSummaryError) {
              return _buildErrorView(state.message);
            } else if (state is AccountCardsSummaryLoaded) {
              final accounts = state.accountSummaries;

              if (accounts.isEmpty) {
                return _buildEmptyView();
              }

              return SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    SizedBox(height: 24.h),
                    ...accounts.map((account) => _buildCardItem(context, account)),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4E03D0),
            Color(0xFF7C3AED),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(
            Icons.credit_card,
            size: 48.sp,
            color: Colors.white,
          ),
          SizedBox(height: 12.h),
          Text(
            'Manage Your Cards',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Control security settings and limits for each card',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardItem(BuildContext context, AccountSummaryEntity account) {
    // Fetch detailed account info when card is rendered
    final cardSettingsCubit = context.read<CardSettingsCubit>();

    // Load account details if not already cached
    if (!cardSettingsCubit.hasCachedAccountDetails(account.id)) {
      cardSettingsCubit.getAccountDetails(accountId: account.id);
    }

    return BlocBuilder<CardSettingsCubit, CardSettingsState>(
      builder: (context, settingsState) {
        AccountDetailsEntity? accountDetails;

        if (settingsState is CardSettingsLoaded) {
          accountDetails = settingsState.getAccountDetails(account.id);
        }

        // Use cached details or fall back to summary data
        final isLoading = settingsState is CardSettingsLoading;
        final isUpdating = settingsState is CardSettingsUpdating &&
            (settingsState).accountId == account.id;

        return Container(
          margin: EdgeInsets.only(bottom: 20.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildCardHeader(account, accountDetails, isUpdating),
              if (accountDetails != null)
                _buildCardSettings(context, account.id, accountDetails, isUpdating)
              else if (isLoading)
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: const Color(0xFF4E03D0),
                    ),
                  ),
                )
              else
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Text(
                    'Loading card settings...',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCardHeader(
    AccountSummaryEntity account,
    AccountDetailsEntity? accountDetails,
    bool isUpdating,
  ) {
    final isFrozen = accountDetails?.isFrozen ?? false;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getCardColor(account.accountType).withValues(alpha: 0.8),
            _getCardColor(account.accountType),
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.accountType.toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.9),
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '•••• ${account.accountNumberLast4}',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: isFrozen
                      ? Colors.red.withValues(alpha: 0.2)
                      : Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: isFrozen
                        ? Colors.red.withValues(alpha: 0.5)
                        : Colors.green.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    if (isUpdating)
                      SizedBox(
                        width: 14.w,
                        height: 14.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    else
                      Icon(
                        isFrozen ? Icons.lock : Icons.check_circle,
                        size: 14.sp,
                        color: isFrozen
                            ? Colors.red.shade100
                            : Colors.green.shade100,
                      ),
                    SizedBox(width: 4.w),
                    Text(
                      isFrozen ? 'Frozen' : 'Active',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Balance',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
              Text(
                '${account.currency} ${account.balance.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardSettings(
    BuildContext context,
    String accountId,
    AccountDetailsEntity accountDetails,
    bool isUpdating,
  ) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Security Settings'),
          SizedBox(height: 12.h),

          _buildSettingToggle(
            context: context,
            accountId: accountId,
            icon: Icons.security,
            title: '3D Secure',
            subtitle: 'Extra layer of security for online payments',
            value: accountDetails.enable3dSecure,
            enabled: !isUpdating,
            onChanged: (value) => _updateSecuritySettings(
              context,
              accountId,
              enable3dSecure: value,
              enableContactless: accountDetails.enableContactless,
              enableOnlinePayments: accountDetails.enableOnlinePayments,
            ),
          ),

          _buildSettingToggle(
            context: context,
            accountId: accountId,
            icon: Icons.contactless,
            title: 'Contactless Payments',
            subtitle: 'Tap to pay at supported terminals',
            value: accountDetails.enableContactless,
            enabled: !isUpdating,
            onChanged: (value) => _updateSecuritySettings(
              context,
              accountId,
              enable3dSecure: accountDetails.enable3dSecure,
              enableContactless: value,
              enableOnlinePayments: accountDetails.enableOnlinePayments,
            ),
          ),

          _buildSettingToggle(
            context: context,
            accountId: accountId,
            icon: Icons.language,
            title: 'Online Payments',
            subtitle: 'Use card for online transactions',
            value: accountDetails.enableOnlinePayments,
            enabled: !isUpdating,
            onChanged: (value) => _updateSecuritySettings(
              context,
              accountId,
              enable3dSecure: accountDetails.enable3dSecure,
              enableContactless: accountDetails.enableContactless,
              enableOnlinePayments: value,
            ),
          ),

          SizedBox(height: 20.h),

          // Freeze/Unfreeze Card Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isUpdating
                  ? null
                  : () => _toggleCardFreeze(
                        context,
                        accountId,
                        accountDetails.isFrozen,
                      ),
              icon: Icon(
                accountDetails.isFrozen ? Icons.lock_open : Icons.lock,
                size: 20.sp,
              ),
              label: Text(
                accountDetails.isFrozen ? 'Unfreeze Card' : 'Freeze Card',
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: accountDetails.isFrozen
                    ? const Color(0xFF10B981)
                    : const Color(0xFFEF4444),
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(0xFF9CA3AF),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1F2937),
      ),
    );
  }

  Widget _buildSettingToggle({
    required BuildContext context,
    required String accountId,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required bool enabled,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              size: 20.sp,
              color: const Color(0xFF4E03D0),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeTrackColor: const Color(0xFF4E03D0),
            activeColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.sp,
            color: Colors.red,
          ),
          SizedBox(height: 16.h),
          Text(
            'Failed to load accounts',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1F2937),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF6B7280),
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: _loadAccountData,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4E03D0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Retry',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.credit_card_off,
            size: 64.sp,
            color: const Color(0xFF9CA3AF),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Cards Found',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1F2937),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'You don\'t have any cards to manage',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Color _getCardColor(String accountType) {
    switch (accountType.toLowerCase()) {
      case 'savings':
        return const Color(0xFF10B981);
      case 'credit':
        return const Color(0xFFEF4444);
      case 'checking':
        return const Color(0xFF3B82F6);
      case 'business':
        return const Color(0xFF8B5CF6);
      default:
        return const Color(0xFF4E03D0);
    }
  }

  void _updateSecuritySettings(
    BuildContext context,
    String accountId, {
    required bool enable3dSecure,
    required bool enableContactless,
    required bool enableOnlinePayments,
  }) {
    context.read<CardSettingsCubit>().updateSecuritySettings(
          accountId: accountId,
          enable3dSecure: enable3dSecure,
          enableContactless: enableContactless,
          enableOnlinePayments: enableOnlinePayments,
        );
  }

  void _toggleCardFreeze(
    BuildContext context,
    String accountId,
    bool isFrozen,
  ) {
    final newStatus = !isFrozen;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Row(
            children: [
              Icon(
                newStatus ? Icons.lock : Icons.lock_open,
                color: newStatus
                    ? const Color(0xFFEF4444)
                    : const Color(0xFF10B981),
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              Text(
                newStatus ? 'Freeze Card' : 'Unfreeze Card',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            newStatus
                ? 'This will temporarily block all transactions on this card. You can unfreeze it anytime.'
                : 'This will reactivate your card and allow transactions.',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.grey.shade700,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                context.read<CardSettingsCubit>().updateAccountStatus(
                      accountId: accountId,
                      status: newStatus ? 'frozen' : 'active',
                      reason: newStatus
                          ? 'User requested freeze'
                          : 'User requested unfreeze',
                    );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: newStatus
                    ? const Color(0xFFEF4444)
                    : const Color(0xFF10B981),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Confirm',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
