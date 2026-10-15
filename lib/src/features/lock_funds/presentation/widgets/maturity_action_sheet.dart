import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/lock_fund_entity.dart';

const _kSheetBg = Color(0xFF1B1B2B);
const _kCardBg = Color(0xFF26263A);
const _kMuted = Color(0xFFB7ABDA);
const _kAccent = Color(0xFF8B5CF6);

/// Lets the user say what their plan should do when its term ends.
///
/// Returns the chosen [MaturityAction], or null when the sheet was dismissed
/// without a decision. [MaturityAction.undecided] is a real return value — it
/// is how the user CLEARS a previous choice and hands the plan back to its
/// auto-renew setting — so callers must distinguish it from null rather than
/// treating both as "nothing happened".
Future<MaturityAction?> showMaturityActionSheet(
  BuildContext context, {
  required MaturityAction current,
  required bool autoRenew,
}) {
  return showModalBottomSheet<MaturityAction>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (ctx) => _MaturityActionSheet(
      current: current,
      autoRenew: autoRenew,
    ),
  );
}

class _MaturityActionSheet extends StatelessWidget {
  final MaturityAction current;
  final bool autoRenew;

  const _MaturityActionSheet({
    required this.current,
    required this.autoRenew,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kSheetBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: _kMuted.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              Text(
                'When this plan ends',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Pick what happens the moment the term is up. You can change '
                'this any time before then.',
                style: GoogleFonts.inter(fontSize: 13.sp, color: _kMuted),
              ),
              SizedBox(height: 18.h),
              ...MaturityAction.choices.map(
                (a) => _OptionTile(
                  action: a,
                  selected: a == current,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    Navigator.of(context).pop(a);
                  },
                ),
              ),
              // Clearing is only offered when there is something to clear.
              // Showing it on an undecided plan would read as a fifth choice.
              if (current != MaturityAction.undecided) ...[
                SizedBox(height: 4.h),
                _ClearTile(autoRenew: autoRenew),
              ],
              SizedBox(height: 14.h),
              _FootNote(),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final MaturityAction action;
  final bool selected;
  final VoidCallback onTap;

  const _OptionTile({
    required this.action,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Material(
        color: selected ? _kAccent.withValues(alpha: 0.16) : _kCardBg,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Row(
              children: [
                Icon(
                  selected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: selected ? _kAccent : _kMuted,
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        action.displayName,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        action.description,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: _kMuted,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Hands the plan back to its auto-renew setting.
///
/// The copy names what auto-renew will actually do, because "clear" on its own
/// does not tell anybody whether their money comes back or rolls over — and
/// those are opposite outcomes.
class _ClearTile extends StatelessWidget {
  final bool autoRenew;

  const _ClearTile({required this.autoRenew});

  @override
  Widget build(BuildContext context) {
    final outcome = autoRenew
        ? 'Auto-renew is on, so the plan would start another term.'
        : 'Auto-renew is off, so the plan would pay out.';
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: () {
          HapticFeedback.selectionClick();
          Navigator.of(context).pop(MaturityAction.undecided);
        },
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
              Icon(Icons.undo_rounded, color: _kMuted, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Clear my choice',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      outcome,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: _kMuted,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FootNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: _kMuted, size: 16.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'A new plan has to meet the plan limits. If the amount being '
              'reinvested falls outside them we pay it to your wallet instead '
              'and tell you why — your money is never left waiting.',
              style: GoogleFonts.inter(
                fontSize: 11.5.sp,
                color: _kMuted,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
