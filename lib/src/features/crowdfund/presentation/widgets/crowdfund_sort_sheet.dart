import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/core/widgets/app_bottom_sheet.dart';

/// HOW A CAMPAIGN LIST IS ORDERED, as the operator specified it.
///
/// ## Why `fundedFirst` is the default
///
/// The brief: start with the campaigns that are already fulfilled or already
/// have money in them, group by how far along they are, and let a person
/// re-sort by newest or oldest.
///
/// The reasoning behind it is that money already in a campaign is EVIDENCE
/// other people believed it, which is the single most useful thing to put in
/// front of a donor who has just arrived and has no other way to judge.
///
/// ## Why these values are strings on the wire and not an enum
///
/// The backend resolves them in `applyCrowdfundOrder`, which is shared by the
/// browse list and the leaderboard. An unrecognised value there degrades to
/// newest-first rather than erroring, so a value this build sends and a newer
/// backend has renamed is a cosmetic regression rather than a broken list.
enum CrowdfundSort {
  fundedFirst,
  newest,
  oldest,
  mostFunded,
  mostDonors,
  endingSoon,
  nearlyComplete,
}

extension CrowdfundSortWire on CrowdfundSort {
  /// The value `GetCrowdfundsRequest.sort_by` carries. These strings are the
  /// contract with `applyCrowdfundOrder`; changing one silently reverts that
  /// option to newest-first.
  String get wire => switch (this) {
        CrowdfundSort.fundedFirst => 'funded_first',
        CrowdfundSort.newest => 'newest',
        CrowdfundSort.oldest => 'oldest',
        CrowdfundSort.mostFunded => 'most_funded',
        CrowdfundSort.mostDonors => 'most_donors',
        CrowdfundSort.endingSoon => 'ending_soon',
        CrowdfundSort.nearlyComplete => 'nearly_complete',
      };

  String get label => switch (this) {
        CrowdfundSort.fundedFirst => 'Funded first',
        CrowdfundSort.newest => 'Newest',
        CrowdfundSort.oldest => 'Oldest',
        CrowdfundSort.mostFunded => 'Most raised',
        CrowdfundSort.mostDonors => 'Most donors',
        CrowdfundSort.endingSoon => 'Ending soon',
        CrowdfundSort.nearlyComplete => 'Almost there',
      };

  /// What this ordering actually does, in the reader's terms. A sort list
  /// whose options are two words each makes people pick by guess and then
  /// wonder whether it worked.
  String get blurb => switch (this) {
        CrowdfundSort.fundedFirst =>
          'Completed campaigns first, then the ones closest to their goal',
        CrowdfundSort.newest => 'Most recently created',
        CrowdfundSort.oldest => 'The ones that have been waiting longest',
        CrowdfundSort.mostFunded => 'Largest amount raised',
        CrowdfundSort.mostDonors => 'Most people who have given',
        CrowdfundSort.endingSoon =>
          'Closest to their deadline. Campaigns with no deadline come last.',
        CrowdfundSort.nearlyComplete =>
          'Not yet at their goal, closest first',
      };

  IconData get icon => switch (this) {
        CrowdfundSort.fundedFirst => Icons.auto_awesome_rounded,
        CrowdfundSort.newest => Icons.fiber_new_rounded,
        CrowdfundSort.oldest => Icons.history_rounded,
        CrowdfundSort.mostFunded => Icons.trending_up_rounded,
        CrowdfundSort.mostDonors => Icons.groups_rounded,
        CrowdfundSort.endingSoon => Icons.timer_outlined,
        CrowdfundSort.nearlyComplete => Icons.flag_rounded,
      };
}

/// Opens the sort sheet and returns the chosen ordering, or null if the
/// person dismissed it without choosing.
///
/// Returning null rather than the current value is deliberate: the caller
/// must be able to tell "they changed their mind" from "they re-picked the
/// same one", because the second should still trigger a refresh and the first
/// should not.
Future<CrowdfundSort?> showCrowdfundSortSheet(
  BuildContext context, {
  required CrowdfundSort current,
}) {
  return showAppBottomSheet<CrowdfundSort>(
    context: context,
    // isScrollControlled so the sheet is not clipped on a small phone with
    // seven options, and so it scrolls rather than overflowing.
    isScrollControlled: true,
    builder: (sheetContext) => _SortSheet(current: current),
  );
}

class _SortSheet extends StatelessWidget {
  const _SortSheet({required this.current});

  final CrowdfundSort current;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
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
                  color: scheme.outlineVariant,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              'Sort campaigns',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
            SizedBox(height: 12.h),
            ...CrowdfundSort.values.map((s) {
              final selected = s == current;
              return InkWell(
                onTap: () => Navigator.of(context).pop(s),
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: selected
                        ? scheme.primary.withValues(alpha: 0.08)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: selected ? scheme.primary : scheme.outlineVariant,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        s.icon,
                        size: 18.sp,
                        color: selected ? scheme.primary : scheme.onSurfaceVariant,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              s.label,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: scheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              s.blurb,
                              style: TextStyle(
                                fontSize: 11.sp,
                                height: 1.35,
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (selected)
                        Icon(Icons.check_rounded,
                            size: 18.sp, color: scheme.primary),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
