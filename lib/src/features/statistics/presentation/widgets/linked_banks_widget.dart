import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/core/config/mono_config.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/widgets/mono_connect_widget.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_state.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Compact Linked Banks Widget for Statistics Page
/// Shows first 2 linked banks with "View All" option
/// Displays empty state with link prompt when no banks connected
/// Uses Mono Connect bottom sheet for bank linking (same as move money flow)
class LinkedBanksWidget extends StatelessWidget {
  final List<LinkedBankAccount> linkedAccounts;
  final VoidCallback? onRefresh;
  final String userId;
  final String accessToken;

  const LinkedBanksWidget({
    super.key,
    required this.linkedAccounts,
    this.onRefresh,
    this.userId = '',
    this.accessToken = '',
  });

  @override
  Widget build(BuildContext context) {
    final hasAccounts = linkedAccounts.isNotEmpty;
    final displayAccounts = hasAccounts
        ? linkedAccounts.take(2).toList()
        : <LinkedBankAccount>[];
    final hasMore = linkedAccounts.length > 2;

    return BlocConsumer<OpenBankingCubit, OpenBankingState>(
      listener: (context, state) {
        if (state is AccountLinked && state.isNewAccount) {
          if (userId.isNotEmpty) {
            Future.delayed(const Duration(seconds: 2), () {
              if (context.mounted) {
                context.read<OpenBankingCubit>().syncAccountTransactions(
                      accountId: state.account.id,
                      userId: userId,
                      syncType: 'full',
                    );
              }
            });
          }
        }

        if (state is AccountLinkedWithMandate) {
          if (userId.isNotEmpty) {
            Future.delayed(const Duration(seconds: 2), () {
              if (context.mounted) {
                context.read<OpenBankingCubit>().syncAccountTransactions(
                      accountId: state.account.id,
                      userId: userId,
                      syncType: 'full',
                    );
              }
            });
          }
        }

        if (state is AccountTransactionsSynced) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${state.transactionsSynced} transactions synced',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF10B981),
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }

        if (state is AllAccountsSynced) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Synced ${state.accountsSynced} banks, ${state.transactionsSynced} transactions',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF10B981),
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }

        if (state is BalanceRefreshed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Balance updated',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF10B981),
              duration: const Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        final isSyncing = state is AllAccountsSyncing ||
            state is AccountTransactionsSyncing;
        final syncingAccountId = state is AccountTransactionsSyncing
            ? (state as AccountTransactionsSyncing).accountId
            : null;

        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_balance_rounded,
                        color: const Color(0xFF9CA3AF),
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Linked Banks',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (hasAccounts) ...[
                        SizedBox(width: 6.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            '${linkedAccounts.length}',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF10B981),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Row(
                    children: [
                      if (hasAccounts && !isSyncing)
                        GestureDetector(
                          onTap: () => _syncAllAccounts(context),
                          child: Icon(
                            Icons.sync_rounded,
                            color: const Color(0xFF9CA3AF),
                            size: 18.sp,
                          ),
                        ),
                      if (hasAccounts && isSyncing)
                        SizedBox(
                          width: 16.sp,
                          height: 16.sp,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF10B981),
                            ),
                          ),
                        ),
                      SizedBox(width: 12.w),
                      GestureDetector(
                        onTap: hasAccounts
                            ? () => Get.toNamed(AppRoutes.linkedBanks)
                            : () => _linkNewBank(context),
                        child: Text(
                          hasAccounts ? 'Manage' : 'Link Bank',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF10B981),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Content
              if (!hasAccounts)
                _buildEmptyState(context)
              else
                _buildAccountsList(context, displayAccounts, hasMore, syncingAccountId, isSyncing),
            ],
          );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return GestureDetector(
      onTap: () => _linkNewBank(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(
              Icons.link_rounded,
              size: 32.sp,
              color: const Color(0xFF6B7280),
            ),
            SizedBox(height: 8.h),
            Text(
              'Link a bank to track all your finances',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'Link Bank Account',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountsList(
    BuildContext context,
    List<LinkedBankAccount> accounts,
    bool hasMore,
    String? syncingAccountId,
    bool isSyncing,
  ) {
    return Column(
      children: [
        ...accounts.map((account) => Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: _BankAccountItem(
            account: account,
            isSyncing: isSyncing && syncingAccountId == account.id,
            onTap: () => Get.toNamed(
              AppRoutes.linkedBanks,
              arguments: {
                'highlightAccountId': account.id,
                'fromStatistics': true,
              },
            ),
            onSync: () => _syncAccount(context, account.id),
          ),
        )),
        if (hasMore)
          GestureDetector(
            onTap: () => Get.toNamed(
              AppRoutes.linkedBanks,
              arguments: {'fromStatistics': true},
            ),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'View all ${linkedAccounts.length} banks',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: const Color(0xFF10B981),
                    size: 11.sp,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _linkNewBank(BuildContext context) async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;

    final user = authState.profile.user;
    final customerName = '${user.firstName} ${user.lastName}'.trim();

    final result = await showMonoConnectBottomSheet(
      context: context,
      publicKey: MonoConfig.publicKey,
      customerName: customerName.isNotEmpty ? customerName : null,
      customerEmail: user.email.isNotEmpty ? user.email : null,
      reference: 'lzv_stats_${DateTime.now().millisecondsSinceEpoch}',
    );

    if (result != null && context.mounted) {
      context.read<OpenBankingCubit>().linkAccount(
            userId: user.id,
            code: result.code,
            accessToken: authState.profile.session.accessToken,
            setAsDefault: linkedAccounts.isEmpty,
          );
    }
  }

  void _syncAllAccounts(BuildContext context) {
    if (userId.isEmpty) return;
    context.read<OpenBankingCubit>().syncAllAccountTransactions(
          userId: userId,
          syncType: 'incremental',
        );
  }

  void _syncAccount(BuildContext context, String accountId) {
    if (userId.isEmpty) return;
    context.read<OpenBankingCubit>().syncAccountTransactions(
          accountId: accountId,
          userId: userId,
          syncType: 'incremental',
        );
  }
}

class _BankAccountItem extends StatelessWidget {
  final LinkedBankAccount account;
  final VoidCallback? onTap;
  final VoidCallback? onSync;
  final bool isSyncing;

  const _BankAccountItem({
    required this.account,
    this.onTap,
    this.onSync,
    this.isSyncing = false,
  });

  Color _getBankColor(String bankName) {
    final name = bankName.toLowerCase();
    if (name.contains('access')) return const Color(0xFFED7D31);
    if (name.contains('gtb') || name.contains('guaranty')) return const Color(0xFFE94C16);
    if (name.contains('zenith')) return const Color(0xFFED1C24);
    if (name.contains('uba')) return const Color(0xFFE4002B);
    if (name.contains('first')) return const Color(0xFF003366);
    if (name.contains('sterling')) return const Color(0xFF003399);
    if (name.contains('fidelity')) return const Color(0xFF009933);
    if (name.contains('fcmb')) return const Color(0xFF800080);
    if (name.contains('ecobank')) return const Color(0xFF003366);
    if (name.contains('union')) return const Color(0xFF009DDC);
    if (name.contains('polaris')) return const Color(0xFF8B0000);
    if (name.contains('stanbic')) return const Color(0xFF0033A0);
    if (name.contains('wema')) return const Color(0xFF800080);
    if (name.contains('keystone')) return const Color(0xFF006400);
    if (name.contains('kuda')) return const Color(0xFF40196D);
    if (name.contains('opay')) return const Color(0xFF1BB066);
    if (name.contains('palmpay')) return const Color(0xFF6F42C1);
    if (name.contains('moniepoint')) return const Color(0xFF2F3292);
    return const Color(0xFF3B82F6);
  }

  String _formatSyncTime(DateTime? syncTime) {
    if (syncTime == null) return 'Never';
    final diff = DateTime.now().difference(syncTime);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    final bankColor = _getBankColor(account.bankName);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            // Bank icon
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: bankColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(
                  account.bankName.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    color: bankColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),

            // Bank details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          account.bankName,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (account.isDefault) ...[
                        SizedBox(width: 6.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Default',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF10B981),
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${account.displayAccountNumber}  ·  ${_formatSyncTime(account.balanceUpdatedAt)}',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF6B7280),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),

            // Balance
            if (isSyncing)
              SizedBox(
                width: 16.sp,
                height: 16.sp,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF10B981),
                  ),
                ),
              )
            else
              Text(
                CurrencySymbols.formatAmount(account.lastKnownBalance),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
