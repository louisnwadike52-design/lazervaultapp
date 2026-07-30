import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/core/config/mono_config.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/linked_banks_empty_state.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/widgets/mono_connect_widget.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_state.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';
import 'package:lazervault/src/features/open_banking/presentation/helpers/account_reauth_helper.dart';
import 'package:lazervault/src/features/open_banking/presentation/helpers/bank_link_fee_mixin.dart';
import 'package:lazervault/src/features/move_money/presentation/widgets/linked_account_state_chip.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Compact Linked Banks Widget for Statistics Page
/// Shows first 2 linked banks with "View All" option
/// Displays empty state with link prompt when no banks connected
/// Uses Mono Connect bottom sheet for bank linking (same as move money flow)
class LinkedBanksWidget extends StatelessWidget {
  final List<LinkedBankAccount> linkedAccounts;
  final VoidCallback? onRefresh;
  final String userId;
  final String accessToken;
  /// Parent has narrowed the budgeting scope to this bank. Highlights
  /// the matching card so users know which bank the stats above reflect.
  final String? selectedAccountId;
  /// Tap on a bank card. Used by the budgeting screen to pivot the
  /// statistics filter to a single bank (or back to all). When null the
  /// card falls through to its default account-detail navigation.
  final void Function(LinkedBankAccount account)? onBankTap;

  const LinkedBanksWidget({
    super.key,
    required this.linkedAccounts,
    this.onRefresh,
    this.userId = '',
    this.accessToken = '',
    this.selectedAccountId,
    this.onBankTap,
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

        // BalanceRefreshed used to surface a "Balance updated" snackbar,
        // but the cubit emits it once per refreshed account, so users on
        // multi-bank accounts saw the toast fire repeatedly. The per-card
        // "X minutes ago" timestamp already conveys the same signal
        // ambiently — the toast was just noise.
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
                        LazerVaultLoader.tiny(),
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

              // Honesty signal: bank analytics come from the last synced pull,
              // not a live read, so the figures below may be out of date. Tell
              // the user plainly and give a one-tap refresh (same explicit sync
              // as the header icon) instead of silently re-pulling on load.
              if (hasAccounts) ...[
                _buildStaleDataAdvisory(context, isSyncing),
                SizedBox(height: 12.h),
              ],

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
    return LinkedBanksEmptyState(onLink: () => _linkNewBank(context));
  }

  /// Non-blocking advisory that the bank analytics may be stale, with a one-tap
  /// explicit refresh. Shown whenever banks are linked — bank data is never
  /// live-read on load, so "may be out of date" is always the honest framing.
  Widget _buildStaleDataAdvisory(BuildContext context, bool isSyncing) {
    return GestureDetector(
      onTap: isSyncing ? null : () => _syncAllAccounts(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFB923C).withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
              color: const Color(0xFFFB923C).withValues(alpha: 0.25)),
        ),
        child: Row(
          children: [
            Icon(
              isSyncing
                  ? Icons.sync_rounded
                  : Icons.info_outline_rounded,
              color: const Color(0xFFFB923C),
              size: 14.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                isSyncing
                    ? 'Refreshing your latest bank data…'
                    : 'Bank data may be out of date. Tap to pull your latest transactions.',
                style: GoogleFonts.inter(
                  color: const Color(0xFFD1D5DB),
                  fontSize: 11.sp,
                ),
              ),
            ),
            if (!isSyncing) ...[
              SizedBox(width: 8.w),
              Text(
                'Refresh',
                style: GoogleFonts.inter(
                  color: const Color(0xFFFB923C),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
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
            isSelected: selectedAccountId == account.id,
            // When the parent supplied a tap handler (budgeting filter
            // pivot) we route the tap through it; otherwise fall back to
            // the legacy "open linked banks screen" navigation.
            onTap: onBankTap != null
                ? () => onBankTap!(account)
                : () => Get.toNamed(
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
      final obc = context.read<OpenBankingCubit>();
      // Shared connection-fee notice (generic — no exact amount), then link.
      await linkBankWithConnectionNotice(
        context: context,
        doLink: (token, txnId) async => obc.linkAccount(
          userId: user.id,
          code: result.code,
          accessToken: authState.profile.session.accessToken,
          setAsDefault: linkedAccounts.isEmpty,
          verificationToken: token,
          transactionId: txnId,
        ),
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
  /// Parent has narrowed the budgeting filter to this account — paints a
  /// purple ring around the card so the user can see at a glance which
  /// bank the statistics scope is pinned to.
  final bool isSelected;

  const _BankAccountItem({
    required this.account,
    this.onTap,
    this.onSync,
    this.isSyncing = false,
    this.isSelected = false,
  });

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
    final needsReauth = account.needsReauthorization;
    const amber = Color(0xFFFB923C);

    return GestureDetector(
      // When the data session expired, tapping anywhere runs the reconnect flow
      // so budgeting insights refresh; otherwise the normal tap action.
      onTap: needsReauth ? () => startAccountReauthorization(context, account) : onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: needsReauth
              ? amber.withValues(alpha: 0.07)
              : isSelected
                  ? const Color(0xFF6F42C1).withValues(alpha: 0.12)
                  : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: needsReauth
              ? Border.all(color: amber.withValues(alpha: 0.35))
              : isSelected
                  ? Border.all(
                      color: const Color(0xFF6F42C1).withValues(alpha: 0.6),
                      width: 1.5,
                    )
                  : null,
        ),
        child: Row(
          children: [
            // Bank logo (bundled asset, gradient-initials fallback)
            BankLogo(
              bankName: account.bankName,
              bankCode: account.bankCode,
              size: 36,
              borderRadius: 8,
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
                            color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Default',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF4E03D0),
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 2.h),
                  needsReauth
                      ? Text(
                          'Session expired · Reconnect to refresh insights',
                          style: GoogleFonts.inter(
                            color: amber,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : Text(
                          '${account.displayAccountNumber}  ·  ${_formatSyncTime(account.balanceUpdatedAt)}',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF6B7280),
                            fontSize: 11.sp,
                          ),
                        ),
                ],
              ),
            ),

            // Trailing: the shared Reconnect chip when the Mono data session
            // expired (insights would otherwise silently exclude this bank).
            if (needsReauth)
              LinkedAccountStateChip(
                state: LinkedAccountState.reconnect,
                onTap: () => startAccountReauthorization(context, account),
              )
            else if (isSyncing)
              LazerVaultLoader.tiny()
            else
              Builder(builder: (_) {
                // COST-AWARE: no auto Mono read on load — show the last-known
                // (cached) balance, labelled "not live" when stale. A live figure
                // comes only from an explicit, cost-confirmed refresh.
                final hasBalance = account.balanceUpdatedAt != null;
                final fresh = hasBalance &&
                    DateTime.now()
                            .difference(account.balanceUpdatedAt!)
                            .inMinutes <
                        3;
                if (!hasBalance) {
                  return Text(
                    'Tap refresh to load balance',
                    style: GoogleFonts.inter(
                        color: const Color(0xFF6B7280), fontSize: 11.sp),
                  );
                }
                return Text(
                  '${CurrencySymbols.formatAmount(account.lastKnownBalance)}${fresh ? '' : ' · not live'}',
                  style: GoogleFonts.inter(
                    color: fresh ? Colors.white : Colors.white.withValues(alpha: 0.6),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
