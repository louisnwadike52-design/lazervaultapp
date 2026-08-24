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
import 'package:lazervault/src/features/open_banking/presentation/helpers/link_account_gate.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/linked_bank_statement_export_sheet.dart';
part 'linked_banks_widget_widgets.dart';


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

  /// Per-account live balance refresh. MONEY-SAFETY: this MUST be the parent's
  /// existing FEE-GATED path (quote fee → cost-confirm tx-PIN → refresh), never
  /// a free direct read. The per-card refresh icon calls this. When null the
  /// refresh icon is hidden.
  final void Function(LinkedBankAccount account)? onRefreshBalance;

  const LinkedBanksWidget({
    super.key,
    required this.linkedAccounts,
    this.onRefresh,
    this.userId = '',
    this.accessToken = '',
    this.selectedAccountId,
    this.onBankTap,
    this.onRefreshBalance,
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

        // Linked-bank cap (admin-tunable default 3) / provider capacity
        // exhausted on a link attempt from the statistics "linked banks" panel —
        // surface as a styled modal with a "Manage banks" CTA (delete-to-add),
        // never a toast. Nothing was charged (both checked before any fee).
        if (state is OpenBankingError && state.operation == 'linkAccount') {
          if (state.errorCode == kLinkLimitReachedCode) {
            showLinkLimitReachedDialog(context, state.message);
          } else if (state.errorCode == kLinkingCapacityCode) {
            showLinkingCapacityDialog(context);
          }
        }

        // BalanceRefreshed used to surface a "Balance updated" snackbar,
        // but the cubit emits it once per refreshed account, so users on
        // multi-bank accounts saw the toast fire repeatedly. The per-card
        // "X minutes ago" timestamp already conveys the same signal
        // ambiently — the toast was just noise.
      },
      builder: (context, state) {
        // Only PER-ACCOUNT transaction syncing now — the bulk "sync all banks"
        // path (a cost-incurring unattended Mono fan-out) was removed.
        final isSyncing = state is AccountTransactionsSyncing;
        final syncingAccountId =
            state is AccountTransactionsSyncing ? state.accountId : null;
        // Per-account live balance refresh in flight (fee-gated path already
        // charged) — the card shows a spinner for just that bank.
        final refreshingAccountId =
            state is BalanceRefreshing ? state.accountId : null;

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
                      // Bulk "sync all banks" icon removed — refreshing every
                      // linked bank at once fanned out cost-incurring Mono reads.
                      // Each bank card carries its own fee-gated refresh instead.
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

              // Honesty signal now lives per-card: each bank shows "Updated Xm
              // ago" + its own fee-gated refresh. The old bulk "tap to refresh
              // all" advisory was removed with the cost-incurring bulk sync.

              // Content
              if (!hasAccounts)
                _buildEmptyState(context)
              else
                _buildAccountsList(context, displayAccounts, hasMore, syncingAccountId, isSyncing, refreshingAccountId),
            ],
          );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return LinkedBanksEmptyState(onLink: () => _linkNewBank(context));
  }

  Widget _buildAccountsList(
    BuildContext context,
    List<LinkedBankAccount> accounts,
    bool hasMore,
    String? syncingAccountId,
    bool isSyncing,
    String? refreshingAccountId,
  ) {
    return Column(
      children: [
        ...accounts.map((account) => Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: _BankAccountItem(
            account: account,
            isSyncing: isSyncing && syncingAccountId == account.id,
            isRefreshingBalance: refreshingAccountId == account.id,
            onRefreshBalance: onRefreshBalance,
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

    // CONNECTION-FEE CONSENT FIRST — before the Mono Connect webview, not after
    // the user has already linked. On "Not now" we abort without opening it.
    final proceed = await showBankConnectionFeeNotice(context);
    if (!proceed || !context.mounted) return;
    // One idempotency id for this whole link attempt.
    final txnId = 'link-${DateTime.now().millisecondsSinceEpoch}';

    final result = await showMonoConnectBottomSheet(
      context: context,
      publicKey: MonoConfig.publicKey,
      customerName: customerName.isNotEmpty ? customerName : null,
      customerEmail: user.email.isNotEmpty ? user.email : null,
      reference: 'lzv_stats_${DateTime.now().millisecondsSinceEpoch}',
    );

    if (result != null && context.mounted) {
      final obc = context.read<OpenBankingCubit>();
      // Fee already consented above — link straight through (no second notice).
      await obc.linkAccount(
        userId: user.id,
        code: result.code,
        accessToken: authState.profile.session.accessToken,
        setAsDefault: linkedAccounts.isEmpty,
        transactionId: txnId,
        // This links a bank for READ-ONLY financial insights (spending
        // analytics / credit score). Never auto-create a Direct Debit mandate
        // here — the user linking to see their spending did NOT consent to us
        // being able to debit their account. Deposits set up their own mandate.
        autoCreateMandate: false,
      );
    }
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
