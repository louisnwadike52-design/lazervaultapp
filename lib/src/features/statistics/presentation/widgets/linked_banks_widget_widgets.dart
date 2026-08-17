part of 'linked_banks_widget.dart';

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
