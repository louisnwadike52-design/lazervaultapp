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

class _BankAccountItem extends StatelessWidget {
  final LinkedBankAccount account;
  final VoidCallback? onTap;
  final VoidCallback? onSync;
  final bool isSyncing;
  /// A fee-gated live balance refresh is in flight for THIS account — the
  /// trailing shows a spinner instead of the balance.
  final bool isRefreshingBalance;
  /// Parent's fee-gated per-account refresh. The refresh icon calls this;
  /// hidden when null or when the connection needs reauthorization.
  final void Function(LinkedBankAccount account)? onRefreshBalance;
  /// Parent has narrowed the budgeting filter to this account — paints a
  /// purple ring around the card so the user can see at a glance which
  /// bank the statistics scope is pinned to.
  final bool isSelected;

  const _BankAccountItem({
    required this.account,
    this.onTap,
    this.onSync,
    this.isSyncing = false,
    this.isRefreshingBalance = false,
    this.onRefreshBalance,
    this.isSelected = false,
  });

  /// "Updated Xm ago" style label (mirrors the deposit card) for the last
  /// balance read timestamp.
  String _lastUpdatedLabel(DateTime? updatedAt) {
    if (updatedAt == null) return 'Not refreshed yet';
    final d = DateTime.now().difference(updatedAt);
    if (d.inSeconds < 45) return 'Updated just now';
    if (d.inMinutes < 60) return 'Updated ${d.inMinutes}m ago';
    if (d.inHours < 24) return 'Updated ${d.inHours}h ago';
    return 'Updated ${d.inDays}d ago';
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
                          account.displayAccountNumber,
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
                // Live per-account refresh in flight (fee already confirmed).
                if (isRefreshingBalance) {
                  return Row(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(
                      width: 14.w,
                      height: 14.w,
                      child: const CircularProgressIndicator(
                          strokeWidth: 2, color: Color(0xFF10B981)),
                    ),
                    SizedBox(width: 8.w),
                    Text('Refreshing…',
                        style: GoogleFonts.inter(
                            color: const Color(0xFF10B981),
                            fontSize: 11.5.sp,
                            fontWeight: FontWeight.w600)),
                  ]);
                }
                // COST-AWARE: no auto Mono read on load — show the last-known
                // (cached) balance with a freshness dot + "Updated Xm ago". A
                // live figure comes only from an explicit, fee-gated refresh.
                final hasBalance = account.balanceUpdatedAt != null;
                final fresh = hasBalance &&
                    DateTime.now()
                            .difference(account.balanceUpdatedAt!)
                            .inMinutes <
                        3;
                // Grey = never fetched, green = fresh (<3min), amber = stale.
                final dot = !hasBalance
                    ? const Color(0xFF6B7280)
                    : (fresh ? const Color(0xFF10B981) : const Color(0xFFFB923C));
                return Row(mainAxisSize: MainAxisSize.min, children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        hasBalance
                            ? CurrencySymbols.formatAmount(account.lastKnownBalance)
                            : 'Balance hidden',
                        style: GoogleFonts.inter(
                          color: hasBalance
                              ? (fresh
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.75))
                              : const Color(0xFF6B7280),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        Container(
                          width: 6.w,
                          height: 6.w,
                          decoration:
                              BoxDecoration(color: dot, shape: BoxShape.circle),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          _lastUpdatedLabel(account.balanceUpdatedAt),
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.55),
                            fontSize: 9.5.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                    ],
                  ),
                  // Fee-gated per-account refresh (never a free direct read).
                  if (onRefreshBalance != null) ...[
                    SizedBox(width: 8.w),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onRefreshBalance!(account),
                      child: Tooltip(
                        message: 'Refresh balance',
                        child: Container(
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(9.r),
                          ),
                          child: Icon(Icons.refresh_rounded,
                              size: 16.sp, color: const Color(0xFF10B981)),
                        ),
                      ),
                    ),
                  ],
                ]);
              }),
          ],
        ),
      ),
    );
  }
}
