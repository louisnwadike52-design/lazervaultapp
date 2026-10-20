import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/group_entities.dart';

/// Every member's auto-debit state for one cycle.
///
/// WHY THIS EXISTS
///
/// The auto-debit dialog answers "what happened to ME". When a pot is short
/// that is the wrong question: an admin needs to know which members the
/// collection failed for and why, and a member asking "is it just me?" wants
/// the same list. Until now that state lived only in the service's own table
/// and in a one-line summary on each roster row.
///
/// Reads the roster the screen already has — each ContributionMember carries
/// its own auto-charge status, attempt count, last attempt and last error — so
/// this costs no round-trip and cannot disagree with the Members tab.
class AutoDebitAttemptsSheet extends StatelessWidget {
  final Contribution contribution;
  final List<ContributionMember> members;
  final int cycle;

  const AutoDebitAttemptsSheet({
    super.key,
    required this.contribution,
    required this.members,
    required this.cycle,
  });

  @override
  Widget build(BuildContext context) {
    final tried = members.where((m) => m.autoChargeAttempts > 0).length;
    final settled = members.where((m) => m.hasPaidCurrentCycle).length;
    final stuck = members.where((m) => m.autoChargeExhausted).length;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
          child: Padding(
            padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 14.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 38.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 14.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4B5563),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                Text(
                  'Auto-debit · cycle $cycle',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  // Counts first, because the first question is "how bad is
                  // it" and scanning a roster to work that out is the thing
                  // this sheet is meant to replace.
                  '$settled of ${members.length} covered · $tried attempted'
                  '${stuck > 0 ? ' · $stuck need manual payment' : ''}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 14.h),
                if (members.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.h),
                    child: Center(
                      child: Text(
                        'No members to collect from yet',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6B7280),
                          fontSize: 12.5.sp,
                        ),
                      ),
                    ),
                  )
                else
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: members.length,
                      separatorBuilder: (_, __) => SizedBox(height: 8.h),
                      itemBuilder: (_, i) => _row(members[i]),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(ContributionMember m) {
    final state = _state(m);
    final name =
        m.userName.trim().isNotEmpty ? m.userName.trim() : (m.email.trim());

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name.isEmpty ? 'Member' : name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: state.colour.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  state.label,
                  style: GoogleFonts.inter(
                    color: state.colour,
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          if (m.missedCycles > 0) ...[
            SizedBox(height: 4.h),
            Text(
              // The standing arrears, beside this cycle's attempt. A member can
              // be "covered" this cycle and still owe three earlier ones, and
              // those are what decide whether they may collect the pot.
              m.missedCycles == 1
                  ? '1 earlier cycle unpaid'
                  : '${m.missedCycles} earlier cycles unpaid',
              style: GoogleFonts.inter(
                color: const Color(0xFFEF4444),
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          SizedBox(height: 6.h),
          Text(
            state.detail,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 11.5.sp,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  /// One member's state, as a label, a colour and a sentence.
  ///
  /// The sentence says what we DID and what happens next, never a raw status
  /// token — "failed" on its own tells somebody nothing about whether to go and
  /// pay manually.
  _AttemptState _state(ContributionMember m) {
    final when = m.autoChargeLastAttemptAt;
    final whenLabel =
        when != null ? DateFormat('MMM d, h:mm a').format(when.toLocal()) : null;
    final tries = m.autoChargeAttempts;
    final triesLabel = tries == 1 ? '1 attempt' : '$tries attempts';
    final reason = m.autoChargeLastError.trim();

    if (m.hasPaidCurrentCycle) {
      return _AttemptState(
        'Covered',
        const Color(0xFF10B981),
        tries > 0
            ? 'Collected after $triesLabel${whenLabel != null ? ', $whenLabel' : ''}.'
            : 'Paid for this cycle, nothing to collect.',
      );
    }
    if (m.autoChargeExhausted) {
      return _AttemptState(
        'Stopped',
        const Color(0xFFEF4444),
        'We stopped after $triesLabel${whenLabel != null ? ', last $whenLabel' : ''}. '
        'This member needs to pay manually.'
        '${reason.isNotEmpty ? '\nLast reason: $reason' : ''}',
      );
    }
    if (m.autoChargeTriedAndFailed) {
      return _AttemptState(
        'Retrying',
        const Color(0xFFFB923C),
        '$triesLabel so far${whenLabel != null ? ', last $whenLabel' : ''}. '
        'We try again once a day.'
        '${reason.isNotEmpty ? '\nLast reason: $reason' : ''}',
      );
    }
    if (tries > 0) {
      return _AttemptState(
        'In progress',
        const Color(0xFF3B82F6),
        '$triesLabel${whenLabel != null ? ', last $whenLabel' : ''}.',
      );
    }
    return _AttemptState(
      'Not tried',
      const Color(0xFF6B7280),
      'No attempt yet for this cycle.',
    );
  }
}

class _AttemptState {
  final String label;
  final Color colour;
  final String detail;
  const _AttemptState(this.label, this.colour, this.detail);
}
