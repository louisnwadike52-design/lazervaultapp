part of 'payment_method_selector.dart';

// Pay-from picker was removed. The slide now renders the
// dashboard's resolved primary same-currency account as a static
// row — no bottom sheet, no Change CTA. _SheetAccountTile below is
// still used by _InterestDestinationPickerSheet for the upfront-
// interest picker.

class _SheetAccountTile extends StatelessWidget {
  final AccountSummaryEntity account;
  final bool isSelected;
  final bool hasBalance;
  final String? disabledReason;
  final VoidCallback? onTap;

  const _SheetAccountTile({
    required this.account,
    required this.isSelected,
    required this.hasBalance,
    required this.onTap,
    this.disabledReason,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = onTap == null;
    final tag = disabledReason ??
        (isSelected ? 'Active' : (hasBalance ? null : 'Insufficient'));
    final tagColor = disabled
        ? const Color(0xFF9CA3AF)
        : isSelected
            ? const Color(0xFF10B981)
            : const Color(0xFFEF4444);
    return Opacity(
      opacity: disabled ? 0.55 : 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF4E03D0).withValues(alpha: 0.12)
                : const Color(0xFF0A0A0A),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF8B5CF6)
                  : Colors.transparent,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: const Color(0xFF8B5CF6),
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.accountType,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      CurrencySymbols.formatAmountWithCurrency(
                          account.availableBalance, account.currency),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              if (tag != null) ...[
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: tagColor.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    tag,
                    style: GoogleFonts.inter(
                      color: tagColor,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
              if (isSelected) ...[
                SizedBox(width: 6.w),
                Icon(Icons.check_circle,
                    color: const Color(0xFF8B5CF6), size: 16.sp),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Bottom-sheet picker for the upfront-interest destination.
/// Mirrors [_AccountPickerSheet] except: no balance gate (the
/// platform deposits INTO this account, so balance is irrelevant),
/// foreign-currency wallets render but are tap-disabled.
class _InterestDestinationPickerSheet extends StatelessWidget {
  final List<AccountSummaryEntity> accounts;
  final String currency;
  final String? selectedAccountId;

  const _InterestDestinationPickerSheet({
    required this.accounts,
    required this.currency,
    required this.selectedAccountId,
  });

  bool _matches(AccountSummaryEntity a) =>
      a.currency.toUpperCase() == currency.toUpperCase();

  @override
  Widget build(BuildContext context) {
    final matching = accounts.where(_matches).toList();
    final others = accounts.where((a) => !_matches(a)).toList();
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF3D3D3D),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              'Receive upfront interest in',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Only $currency wallets can receive this interest payout',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 16.h),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.55,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (matching.isEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: Center(
                          child: Text(
                            'No $currency wallets available',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      )
                    else
                      ...matching.map((a) {
                        final isSelected = a.id == selectedAccountId;
                        return _SheetAccountTile(
                          account: a,
                          isSelected: isSelected,
                          hasBalance: true,
                          onTap: () => Navigator.of(context).pop(a),
                        );
                      }),
                    if (others.isNotEmpty) ...[
                      SizedBox(height: 14.h),
                      Text(
                        'Other wallets (not eligible)',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6B7280),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      ...others.map((a) => _SheetAccountTile(
                            account: a,
                            isSelected: false,
                            hasBalance: false,
                            disabledReason: 'Wrong currency',
                            onTap: null,
                          )),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
