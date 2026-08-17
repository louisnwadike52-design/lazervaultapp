part of 'autosave_transactions_screen.dart';

/// One row on the list. Elevated dark surface, no border — matches the
/// All Rules card visual treatment so the two screens feel like one
/// feature. Status pill on the right, trigger badge under the title.
/// Wrapper returned by `_pickFilter` so callers can disambiguate
/// "user dismissed the sheet" from "user picked an option whose value
/// happens to be null" (the All option). `cancelled = true` is the
/// dismiss case; `value` carries the chosen payload otherwise.
class _PickResult<T> {
  final bool cancelled;
  final T? value;
  const _PickResult.cancelled()
      : cancelled = true,
        value = null;
  const _PickResult.value(this.value) : cancelled = false;
}

class _FilterOption<T> {
  final String label;
  final T value;
  final IconData? icon;
  final Color? accent;
  const _FilterOption({
    required this.label,
    required this.value,
    this.icon,
    this.accent,
  });
}

/// Pill-shaped dropdown trigger used in the transactions filter row.
/// Displays the active selection's label inline with a chevron and a
/// purple dot when a non-default filter is active so the user sees
/// at a glance which controls are constraining the list.
class _DropdownButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String valueLabel;
  final Color? valueAccent;
  final bool isFiltered;
  final VoidCallback onTap;

  const _DropdownButton({
    required this.icon,
    required this.label,
    required this.valueLabel,
    required this.valueAccent,
    required this.isFiltered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      // Screen readers hear "Outcome filter, currently Successful,
      // double-tap to change" instead of just the label text.
      label: '$label filter, currently $valueLabel',
      button: true,
      child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: isFiltered
                    ? const Color.fromARGB(255, 78, 3, 208)
                        .withValues(alpha: 0.18)
                    : Colors.black.withValues(alpha: 0.25),
                blurRadius: isFiltered ? 12 : 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 16.sp,
                color: valueAccent ?? Colors.grey[400],
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontSize: 9.sp,
                        letterSpacing: 0.6,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      valueLabel,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.expand_more,
                size: 18.sp,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

/// Modal bottom sheet picker. Each row shows the option's icon (if
/// any) with its label; the currently-selected row gets a check-mark
/// and accent colour. Tapping a row pops with that value; the sheet's
/// dismiss returns null so the caller can preserve the existing
/// filter.
class _FilterPickerSheet<T> extends StatelessWidget {
  final String title;
  final List<_FilterOption<T>> options;
  final T current;

  const _FilterPickerSheet({
    required this.title,
    required this.options,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            for (final opt in options)
              _buildRow(context, opt, opt.value == current),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, _FilterOption<T> opt, bool selected) {
    final accent = opt.accent ?? const Color.fromARGB(255, 78, 3, 208);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        // Pop with a tagged wrapper instead of the raw value so the
        // caller can tell "user picked the All option (value=null)"
        // apart from "sheet dismissed (popped with null)". Without
        // this, picking "All triggers" / "All outcomes" looked like
        // a cancel and the filter never updated.
        onTap: () => Navigator.of(context).pop(_PickResult.value(opt.value)),
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: selected
                ? accent.withValues(alpha: 0.10)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  opt.icon ?? Icons.tune,
                  size: 16.sp,
                  color: accent,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  opt.label,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight:
                        selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                  // Future trigger types or longer outcome labels
                  // shouldn't overflow the row — clip with ellipsis
                  // and rely on the leading icon + accent for context.
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (selected)
                Icon(Icons.check_circle,
                    color: accent, size: 18.sp),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final AutoSaveTransactionEntity tx;
  final AutoSaveRuleEntity? rule;
  final VoidCallback onTap;

  const _TransactionTile({
    required this.tx,
    required this.rule,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final triggerColor = _triggerColor(tx.triggerType);
    final amountText =
        cur.CurrencySymbols.formatAmountWithCurrency(tx.amount, tx.currency);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: triggerColor.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _triggerIcon(tx.triggerType),
                    color: triggerColor,
                    size: 18.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rule?.name ??
                            'Rule ${tx.ruleId.substring(0, 6)}',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        DateFormat('MMM d, yyyy • HH:mm')
                            .format(tx.createdAt),
                        style: GoogleFonts.inter(
                          color: Colors.grey[500],
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      amountText,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: tx.success
                            ? const Color(0xFF10B981)
                                .withValues(alpha: 0.15)
                            : const Color(0xFFEF4444)
                                .withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        tx.success ? 'SUCCESS' : 'FAILED',
                        style: GoogleFonts.inter(
                          color: tx.success
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444),
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: triggerColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text(
                    _triggerLabel(tx.triggerType),
                    style: GoogleFonts.inter(
                      color: triggerColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                if (tx.triggerReason.isNotEmpty) ...[
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      tx.triggerReason,
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontSize: 11.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _triggerColor(TriggerType t) {
    switch (t) {
      case TriggerType.scheduled:
        return const Color(0xFF3B82F6);
      case TriggerType.onDeposit:
        return const Color(0xFF10B981);
      case TriggerType.roundUp:
        return const Color(0xFFFB923C);
      case TriggerType.externalInflow:
        return const Color(0xFFF97316);
      case TriggerType.scheduledExternal:
        return const Color(0xFF14B8A6);
      default:
        return const Color(0xFF6B7280);
    }
  }

  IconData _triggerIcon(TriggerType t) {
    switch (t) {
      case TriggerType.scheduled:
        return Icons.schedule;
      case TriggerType.onDeposit:
        return Icons.south_west;
      case TriggerType.roundUp:
        return Icons.unfold_more;
      case TriggerType.externalInflow:
        return Icons.account_balance;
      case TriggerType.scheduledExternal:
        return Icons.account_balance_wallet;
      default:
        return Icons.help_outline;
    }
  }

  String _triggerLabel(TriggerType t) {
    switch (t) {
      case TriggerType.scheduled:
        return 'SCHEDULED';
      case TriggerType.onDeposit:
        return 'ON DEPOSIT';
      case TriggerType.roundUp:
        return 'ROUND-UP';
      case TriggerType.externalInflow:
        return 'BANK INFLOW';
      case TriggerType.scheduledExternal:
        return 'STANDING ORDER';
      default:
        return 'OTHER';
    }
  }
}

/// Bottom sheet shown when a row is tapped. Same layout pattern as the
/// past-contribution / cycle-history sheets so the surfaces feel
/// consistent. Surfaces every captured field on the transaction +
/// links back to the parent rule so investigative drills are one tap
/// away.
class _TransactionDetailsSheet extends StatelessWidget {
  final AutoSaveTransactionEntity tx;
  final AutoSaveRuleEntity? rule;
  final VoidCallback? onOpenRule;

  const _TransactionDetailsSheet({
    required this.tx,
    required this.rule,
    required this.onOpenRule,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Transaction details',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            Flexible(
              child: ListView(
                padding: EdgeInsets.all(16.w),
                children: [
                  _amountBanner(),
                  SizedBox(height: 14.h),
                  _section(
                    title: 'Trigger',
                    rows: [
                      _row('Type', _triggerName(tx.triggerType)),
                      _row('Reason',
                          tx.triggerReason.isEmpty ? '—' : tx.triggerReason),
                      _row(
                        'Outcome',
                        tx.success ? 'Success' : 'Failed',
                        valueColor: tx.success
                            ? const Color(0xFF10B981)
                            : const Color(0xFFEF4444),
                      ),
                      if (tx.errorMessage != null &&
                          tx.errorMessage!.isNotEmpty)
                        _row('Error', tx.errorMessage!,
                            valueColor: const Color(0xFFFCA5A5)),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  _section(
                    title: 'Money movement',
                    rows: [
                      _row(
                          'Amount',
                          cur.CurrencySymbols.formatAmountWithCurrency(
                              tx.amount, tx.currency)),
                      _row('Source account', tx.sourceAccountId),
                      _row('Destination account', tx.destinationAccountId),
                      _row('Currency', tx.currency),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  _section(
                    title: 'Identifiers',
                    rows: [
                      _row('Transaction ID', tx.id),
                      _row('Rule ID', tx.ruleId),
                      _row(
                          'Captured at',
                          DateFormat('MMM d, yyyy • HH:mm:ss')
                              .format(tx.createdAt)),
                    ],
                  ),
                  if (rule != null) ...[
                    SizedBox(height: 14.h),
                    _ruleSummary(),
                  ],
                  SizedBox(height: 16.h),
                  if (onOpenRule != null)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: onOpenRule,
                        icon: Icon(Icons.open_in_new, size: 18.sp),
                        label: Text(
                          'Open rule',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 78, 3, 208),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _amountBanner() {
    final colour = tx.success
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444);
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colour.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: colour.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              tx.success ? Icons.check_circle : Icons.error_outline,
              color: colour,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cur.CurrencySymbols.formatAmountWithCurrency(
                      tx.amount, tx.currency),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  tx.success ? 'Saved successfully' : 'Did not save',
                  style: GoogleFonts.inter(
                    color: colour,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ruleSummary() {
    final r = rule!;
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Parent rule',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 10.sp,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            r.name,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (r.description.isNotEmpty) ...[
            SizedBox(height: 4.h),
            Text(
              r.description,
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 11.sp,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Widget _section({
    required String title,
    required List<Widget> rows,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: const Color.fromARGB(255, 178, 137, 255),
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 6.h),
          ...rows,
        ],
      ),
    );
  }

  Widget _row(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130.w,
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 11.sp,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: valueColor ?? Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _triggerName(TriggerType t) {
    switch (t) {
      case TriggerType.scheduled:
        return 'Scheduled';
      case TriggerType.onDeposit:
        return 'On deposit';
      case TriggerType.roundUp:
        return 'Round-up';
      case TriggerType.externalInflow:
        return 'Bank inflow';
      case TriggerType.scheduledExternal:
        return 'Standing order';
      default:
        return 'Other';
    }
  }
}
