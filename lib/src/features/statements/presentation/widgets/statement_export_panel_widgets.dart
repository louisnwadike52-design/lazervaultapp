part of 'statement_export_panel.dart';

/// The pieces of [StatementExportPanel]. Kept in a part file so the panel
/// itself stays readable; both halves share the palette getters and state.
extension _StatementExportPanelWidgets on _StatementExportPanelState {
  Widget _sectionLabel(String text, {bool large = false}) => Text(
        text,
        style: GoogleFonts.inter(
          fontSize: large ? 16.sp : 14.sp,
          fontWeight: FontWeight.w600,
          color: large ? _primaryText : _labelText,
        ),
      );

  Widget _shell({required Widget child, double? height, VoidCallback? onTap}) {
    final box = Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _border),
      ),
      child: child,
    );
    if (onTap == null) return box;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: box,
      ),
    );
  }

  // ── Account ────────────────────────────────────────────────────────────
  String _accountLabel(AccountSummaryEntity a) {
    final type = a.accountType.isEmpty ? 'Account' : a.accountType;
    final last4 = a.accountNumberLast4;
    final suffix = last4.isEmpty ? '' : ' (*$last4)';
    final currency = a.currency.isEmpty ? '' : ' · ${a.currency.toUpperCase()}';
    return '$type$suffix$currency';
  }

  Widget _accountSelector() {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        if (state is AccountCardsSummaryLoading) {
          return _shell(
            height: 56.h,
            child: Center(child: LazerVaultLoader.small()),
          );
        }

        if (state is! AccountCardsSummaryLoaded) {
          // The account list failed. The user may still know which account
          // they came from, so a pinned selection stays usable rather than
          // blocking the export behind a list we could not load.
          if (widget.lockAccount && _selectedAccountId != null) {
            return _lockedAccountRow(null);
          }
          return _shell(
            height: 56.h,
            child: Row(
              children: [
                Icon(Icons.error_outline, size: 18.sp, color: Colors.redAccent),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    'Could not load your accounts. Pull down or try again.',
                    style: GoogleFonts.inter(
                        fontSize: 13.sp, color: Colors.redAccent),
                  ),
                ),
              ],
            ),
          );
        }

        final accounts = state.accountSummaries;
        if (accounts.isEmpty) {
          return _shell(
            height: 56.h,
            child: Center(
              child: Text('No accounts available',
                  style: GoogleFonts.inter(fontSize: 14.sp, color: _mutedText)),
            ),
          );
        }

        // A pinned account that is not in the list (a closed or filtered
        // account) must not silently fall back to another one — the statement
        // would be for the wrong account and look right.
        AccountSummaryEntity? pinned;
        for (final a in accounts) {
          if (a.id == _selectedAccountId) {
            pinned = a;
            break;
          }
        }
        if (widget.lockAccount && _selectedAccountId != null) {
          return _lockedAccountRow(pinned);
        }

        // Guard the dropdown's own invariant: `value` must be one of `items`
        // or DropdownButton asserts and the screen fails to build.
        final value = pinned?.id;

        return _shell(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: value,
              dropdownColor: _dark ? const Color(0xFF1F1F1F) : Colors.white,
              hint: Text('Choose an account',
                  style: GoogleFonts.inter(fontSize: 14.sp, color: _mutedText)),
              padding: EdgeInsets.symmetric(vertical: 4.h),
              icon: Icon(Icons.keyboard_arrow_down, color: _brand),
              items: [
                for (final a in accounts)
                  DropdownMenuItem<String>(
                    value: a.id,
                    child: Text(
                      _accountLabel(a),
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          fontSize: 14.sp, color: _primaryText),
                    ),
                  ),
              ],
              onChanged: (v) => update(() => _selectedAccountId = v),
            ),
          ),
        );
      },
    );
  }

  Widget _lockedAccountRow(AccountSummaryEntity? account) {
    return _shell(
      height: 56.h,
      child: Row(
        children: [
          Icon(Icons.account_balance_wallet_outlined,
              size: 18.sp, color: _brand),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              account != null ? _accountLabel(account) : 'This account',
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: _primaryText),
            ),
          ),
          Icon(Icons.lock_outline, size: 15.sp, color: _mutedText),
        ],
      ),
    );
  }

  // ── Date range ─────────────────────────────────────────────────────────
  Widget _rangeField() {
    final start = _startDate;
    final end = _endDate;
    final label = (start != null && end != null)
        ? '${DateFormat('MMM dd, yyyy').format(start)} - '
            '${DateFormat('MMM dd, yyyy').format(end)}'
        : 'Select date range';
    return _shell(
      height: 56.h,
      onTap: _pickRange,
      child: Row(
        children: [
          Icon(Icons.date_range, color: _brand, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: start != null ? _primaryText : _mutedText,
              ),
            ),
          ),
          Icon(Icons.chevron_right, color: _mutedText, size: 18.sp),
        ],
      ),
    );
  }

  Future<DateTime?> _pickDay(DateTime? initial, DateTime first, DateTime last) {
    // Clamp: showDatePicker asserts when initialDate falls outside the bounds,
    // which happens whenever the user narrows one end past the other.
    final seed = initial ?? last;
    final safe =
        seed.isBefore(first) ? first : (seed.isAfter(last) ? last : seed);
    return showDatePicker(
      context: context,
      initialDate: safe,
      firstDate: first,
      lastDate: last,
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: _dark
              ? ColorScheme.dark(
                  primary: _brand, surface: const Color(0xFF1F1F1F))
              : ColorScheme.light(primary: _brand),
        ),
        child: child!,
      ),
    );
  }

  // ── Format ─────────────────────────────────────────────────────────────
  Widget _formatRow() => Row(
        children: [
          Expanded(
            child: _formatButton(
              label: 'PDF',
              icon: Icons.picture_as_pdf,
              selected: _format == StatementFormat.pdf,
              onTap: () => update(() => _format = StatementFormat.pdf),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _formatButton(
              label: 'CSV',
              icon: Icons.table_chart,
              selected: _format == StatementFormat.csv,
              onTap: () => update(() => _format = StatementFormat.csv),
            ),
          ),
        ],
      );

  Widget _formatButton({
    required String label,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 56.h,
        decoration: BoxDecoration(
          color: selected ? _brand.withValues(alpha: 0.1) : _surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: selected ? _brand : _border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: selected ? _brand : _mutedText, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: selected ? _brand : _mutedText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Generate ───────────────────────────────────────────────────────────
  Widget _generateButton() {
    return BlocBuilder<StatementCubit, StatementState>(
      builder: (context, state) {
        final busy = state is StatementDownloading || _isPreparingFile;
        return SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: busy ? null : _generate,
            style: ElevatedButton.styleFrom(
              backgroundColor: _brand,
              disabledBackgroundColor: _brand.withValues(alpha: 0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
            ),
            child: busy
                ? LazerVaultLoader.small()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.download, color: Colors.white),
                      SizedBox(width: 8.w),
                      Text('Download statement',
                          style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ],
                  ),
          ),
        );
      },
    );
  }

  /// Says what the document actually contains. People export a statement to
  /// hand to someone else, and the two questions they ask before doing that
  /// are "does it show my address" and "does it show the running balance".
  Widget _whatIsIncludedNote() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 15.sp, color: _mutedText),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Includes your name and address, opening and closing balances, '
              'money in and out, and the balance before and after every entry. '
              'Add your address under Profile if it is missing.',
              style: GoogleFonts.inter(
                  fontSize: 11.5.sp, color: _mutedText, height: 1.45),
            ),
          ),
        ],
      );
}
