import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/widgets/app_bottom_sheet.dart';
import 'package:lazervault/src/features/crowdfund/presentation/widgets/crowdfund_sort_sheet.dart';

/// ONE control for how the campaign list is narrowed AND ordered.
///
/// ## What this replaces
///
/// The list carried two filter controls side by side in one row: a
/// horizontally-scrolling strip of status chips inside an `Expanded`, and a
/// fixed sort pill after it. On a normal phone the pill covered the end of the
/// strip, so "Cancelled" rendered as "Canc…" permanently clipped behind
/// "Newest" — two competing controls fighting for one row, and the last status
/// unreachable without discovering that the strip scrolls under the thing
/// overlapping it.
///
/// Status and order are the same question — "which campaigns, in what order" —
/// so they are now one button and one sheet.
///
/// ## Why the statuses WRAP instead of scrolling
///
/// A wrap cannot clip. The whole defect above came from a scrolling row whose
/// end was hidden; four short labels fit two lines at any width, and nothing
/// is ever out of sight.
class CrowdfundFilterResult {
  const CrowdfundFilterResult({required this.status, required this.sort});

  /// One of the status labels, matching the list's `_filters`.
  final String status;
  final CrowdfundSort sort;
}

const List<String> kCrowdfundStatusFilters = [
  'All',
  'Active',
  'Completed',
  'Cancelled',
];

/// Opens the combined sheet. Returns null when dismissed without applying, so
/// the caller can tell "changed their mind" from "re-picked the same thing" —
/// the second should still refresh, the first should not.
Future<CrowdfundFilterResult?> showCrowdfundFilterSheet(
  BuildContext context, {
  required String status,
  required CrowdfundSort sort,
}) {
  return showAppBottomSheet<CrowdfundFilterResult>(
    context: context,
    // Seven sort options plus the status row overflow a small phone.
    isScrollControlled: true,
    builder: (_) => _FilterSheet(status: status, sort: sort),
  );
}

class _FilterSheet extends StatefulWidget {
  const _FilterSheet({required this.status, required this.sort});

  final String status;
  final CrowdfundSort sort;

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late String _status = widget.status;
  late CrowdfundSort _sort = widget.sort;

  // The list screen's own palette, so the sheet reads as part of the same
  // surface rather than a system dialog dropped on top of it.
  static const _surface = Color(0xFF151515);
  static const _card = Color(0xFF1F1F1F);
  static const _accent = Color(0xFF4E03D0);
  static const _muted = Color(0xFF9CA3AF);

  bool get _isDefault =>
      _status == 'All' && _sort == CrowdfundSort.fundedFirst;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: _surface),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 36.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Filter & sort',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Only offered when there is something to undo — a Reset
                    // that is always lit invites a tap that does nothing.
                    if (!_isDefault)
                      TextButton(
                        onPressed: () => setState(() {
                          _status = 'All';
                          _sort = CrowdfundSort.fundedFirst;
                        }),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          minimumSize: Size(0, 32.h),
                        ),
                        child: Text(
                          'Reset',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: _muted,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 14.h),
                _sectionLabel('Status'),
                SizedBox(height: 8.h),
                // WRAP, NOT A SCROLLING ROW — see the class comment.
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: kCrowdfundStatusFilters.map((f) {
                    final selected = f == _status;
                    return GestureDetector(
                      onTap: () => setState(() => _status = f),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: selected
                              ? _accent.withValues(alpha: 0.22)
                              : _card,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: selected ? _accent : Colors.transparent,
                          ),
                        ),
                        child: Text(
                          f,
                          style: GoogleFonts.inter(
                            color: selected ? Colors.white : _muted,
                            fontSize: 13.sp,
                            fontWeight:
                                selected ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 18.h),
                _sectionLabel('Sort by'),
                SizedBox(height: 8.h),
                ...CrowdfundSort.values.map(_sortRow),
                SizedBox(height: 8.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(
                      CrowdfundFilterResult(status: _status, sort: _sort),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accent,
                      foregroundColor: Colors.white,
                      minimumSize: Size(0, 48.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    child: Text(
                      'Show campaigns',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) => Text(
        text.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color: _muted,
        ),
      );

  Widget _sortRow(CrowdfundSort s) {
    final selected = s == _sort;
    return InkWell(
      onTap: () => setState(() => _sort = s),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: selected ? _accent.withValues(alpha: 0.12) : _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected ? _accent : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(s.icon,
                size: 18.sp, color: selected ? Colors.white : _muted),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.label,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  // The blurb stays: a sort list of two-word options makes
                  // people pick by guess and then wonder whether it worked.
                  Text(
                    s.blurb,
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      height: 1.35,
                      color: _muted,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              Icon(Icons.check_circle_rounded, size: 18.sp, color: _accent),
          ],
        ),
      ),
    );
  }
}
