import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';

/// Compact bank-scope selector for the AI Budgeting filter bar.
///
/// Renders the scope as a horizontally-scrollable row of pills — "All banks"
/// plus one pill per linked bank. The filter is MULTI-SELECT: tapping a bank
/// toggles it in/out of scope, and every number on the page reflects the union
/// of the selected banks (via the parent's [onChanged] → StatisticsCubit
/// .changeBanks). An empty selection = all banks.
///
/// Only [inlineCount] banks (default 2) show inline; the rest collapse into a
/// clearly-labelled trailing "More (N)" chip that opens a bottom-sheet checklist
/// — so users always know there are more banks to choose from. Any bank that is
/// already selected is pulled inline so the active scope is never hidden behind
/// "More".
class BankScopePills extends StatelessWidget {
  const BankScopePills({
    super.key,
    required this.banks,
    required this.selectedIds,
    required this.onChanged,
    this.inlineCount = 2,
  });

  final List<LinkedBankAccount> banks;

  /// Empty = "All banks".
  final Set<String> selectedIds;

  /// Fired with the full next selection whenever it changes.
  final ValueChanged<Set<String>> onChanged;

  /// How many bank pills render inline before the rest collapse into "More".
  final int inlineCount;

  static const _accent = Color(0xFFFB923C);
  static const _chipBg = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);

  void _toggle(String id) {
    final next = Set<String>.from(selectedIds);
    if (!next.add(id)) next.remove(id); // add returns false if already present
    onChanged(next);
  }

  @override
  Widget build(BuildContext context) {
    // Keep selected banks visible inline even if they'd sit past inlineCount —
    // otherwise the active scope hides behind "More".
    final inline = <LinkedBankAccount>[];
    final overflow = <LinkedBankAccount>[];
    for (var i = 0; i < banks.length; i++) {
      final b = banks[i];
      if (i < inlineCount || selectedIds.contains(b.id)) {
        inline.add(b);
      } else {
        overflow.add(b);
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _pill(
            label: 'All banks',
            icon: Icons.all_inclusive_rounded,
            selected: selectedIds.isEmpty,
            onTap: () => onChanged(const <String>{}),
          ),
          for (final b in inline) ...[
            SizedBox(width: 8.w),
            _pill(
              label: b.bankName,
              icon: Icons.account_balance_rounded,
              selected: selectedIds.contains(b.id),
              onTap: () => _toggle(b.id),
            ),
          ],
          if (overflow.isNotEmpty) ...[
            SizedBox(width: 8.w),
            _moreChip(context, overflow.length),
          ],
        ],
      ),
    );
  }

  Widget _pill({
    required String label,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? _accent.withValues(alpha: 0.16) : _chipBg,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: selected ? _accent : _border,
            width: selected ? 1.2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13.sp, color: selected ? _accent : _muted),
            SizedBox(width: 6.w),
            Text(
              label,
              style: GoogleFonts.inter(
                color: selected ? _accent : Colors.white,
                fontSize: 12.sp,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            if (selected) ...[
              SizedBox(width: 5.w),
              Icon(Icons.check_rounded, size: 13.sp, color: _accent),
            ],
          ],
        ),
      ),
    );
  }

  /// Trailing "More (N)" chip. Clearly labelled with the overflow count so the
  /// user always knows there are more banks; opens a multi-select bottom sheet.
  Widget _moreChip(BuildContext context, int overflowCount) {
    return GestureDetector(
      onTap: () => _openMoreSheet(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: _chipBg,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: _border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'More ($overflowCount)',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 3.w),
            Icon(Icons.keyboard_arrow_down_rounded, size: 16.sp, color: _muted),
          ],
        ),
      ),
    );
  }

  /// Bottom-sheet checklist of EVERY linked bank. Edits a local working copy so
  /// toggling several banks doesn't re-scope the page on every tap; commits the
  /// whole selection on "Apply". Delegates to the shared [showBankFilterSheet]
  /// so the consolidated top filter bar opens the SAME multi-select sheet.
  Future<void> _openMoreSheet(BuildContext context) async {
    final result = await showBankFilterSheet(
      context,
      banks: banks,
      selectedIds: selectedIds,
    );
    if (result != null) onChanged(result);
  }
}

/// Shared multi-select bank-filter bottom sheet. Used by both the inline
/// [BankScopePills] "More" chip and the consolidated top filter bar's Banks
/// chip so there is exactly ONE bank-picker sheet. Edits a local working copy
/// (so toggling several banks doesn't re-scope on every tap) and returns the
/// committed selection on "Apply" (or null if dismissed).
Future<Set<String>?> showBankFilterSheet(
  BuildContext context, {
  required List<LinkedBankAccount> banks,
  required Set<String> selectedIds,
}) {
  const accent = Color(0xFFFB923C);
  const border = Color(0xFF2D2D2D);
  const muted = Color(0xFF9CA3AF);
  final working = Set<String>.from(selectedIds);
  return showModalBottomSheet<Set<String>>(
    context: context,
    backgroundColor: const Color(0xFF141414),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setSheetState) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_balance_rounded,
                          size: 16.sp, color: accent),
                      SizedBox(width: 8.w),
                      Text(
                        'Filter by bank',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      if (working.isNotEmpty)
                        GestureDetector(
                          onTap: () => setSheetState(working.clear),
                          child: Text(
                            'Clear',
                            style: GoogleFonts.inter(
                              color: muted,
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    working.isEmpty
                        ? 'Showing all linked banks'
                        : '${working.length} selected',
                    style: GoogleFonts.inter(color: muted, fontSize: 12.sp),
                  ),
                  SizedBox(height: 12.h),
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: banks.length,
                      separatorBuilder: (_, __) => Divider(
                          height: 1, color: border.withValues(alpha: 0.6)),
                      itemBuilder: (_, i) {
                        final b = banks[i];
                        final checked = working.contains(b.id);
                        return InkWell(
                          onTap: () => setSheetState(() {
                            if (!working.add(b.id)) working.remove(b.id);
                          }),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Row(
                              children: [
                                Icon(Icons.account_balance_rounded,
                                    size: 18.sp,
                                    color: checked ? accent : muted),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        b.bankName,
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 13.5.sp,
                                          fontWeight: checked
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                        ),
                                      ),
                                      if (b.accountNumber.isNotEmpty)
                                        Text(
                                          b.accountNumber,
                                          style: GoogleFonts.inter(
                                              color: muted, fontSize: 11.sp),
                                        ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  checked
                                      ? Icons.check_circle_rounded
                                      : Icons.circle_outlined,
                                  size: 20.sp,
                                  color: checked ? accent : border,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 14.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        padding: EdgeInsets.symmetric(vertical: 13.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                      ),
                      onPressed: () => Navigator.of(ctx).pop(working),
                      child: Text(
                        working.isEmpty ? 'Show all banks' : 'Apply',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
