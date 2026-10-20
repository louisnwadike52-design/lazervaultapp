part of 'lock_fund_details_screen.dart';

/// "When this plan ends" — the maturity choice, rendered three different ways
/// depending on where the plan is in its life.
///
/// The three states are genuinely different facts and must not be collapsed:
///
/// * **Changeable** (`locked` / `pending_approval`) — a tappable control. These
///   are the only two statuses accounts-service will accept a change for, so
///   offering the tap anywhere else would produce a refusal the user cannot
///   act on.
/// * **Decided but no longer changeable** — read-only. The term has ended or
///   the plan was closed; the choice is history.
/// * **Settled** — what actually happened, plus [LockFund.maturityNote] when
///   the server could not do what was asked. That note is the whole reason the
///   field exists: reinvesting returns alone routinely lands under a plan's
///   minimum and the money is paid out instead, which is safe but is NOT what
///   the user chose, so the screen has to say so.
class _MaturitySection extends StatelessWidget {
  final LockFund lock;

  /// Null when the plan's ending can no longer be changed.
  final VoidCallback? onTap;

  const _MaturitySection({required this.lock, this.onTap});

  /// Empty is "not decided", never "payout" — see [MaturityAction].
  bool get _settled => lock.maturitySettledAt != null;

  String get _valueText {
    if (_settled) return lock.maturityAction.displayName;
    if (lock.maturityAction == MaturityAction.undecided) {
      // Name the outcome auto-renew would produce rather than leaving the
      // user to work out what "not decided" means for their money.
      return lock.autoRenew ? 'Not set, will renew' : 'Not set, will pay out';
    }
    return lock.maturityAction.displayName;
  }

  @override
  Widget build(BuildContext context) {
    final interactive = onTap != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _settled ? 'At maturity' : 'When this plan ends',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: const Color(0xFFB7ABDA),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            _valueText,
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        if (interactive) ...[
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.chevron_right,
                            size: 18.sp,
                            color: const Color(0xFF8B5CF6),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (lock.maturityNote.trim().isNotEmpty) ...[
          SizedBox(height: 8.h),
          _MaturityNote(note: lock.maturityNote.trim()),
        ],
        if (_settled && lock.reinvestedIntoId.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Text(
            'This plan rolled into a new one. You will find it in My Locks.',
            style: GoogleFonts.inter(
              fontSize: 11.5.sp,
              color: const Color(0xFF10B981),
              height: 1.35,
            ),
          ),
        ],
        SizedBox(height: 12.h),
      ],
    );
  }
}

/// Amber, not red: the money reached the user safely, it just did not do the
/// thing they picked. Red would read as a failed payout.
class _MaturityNote extends StatelessWidget {
  final String note;

  const _MaturityNote({required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF59E0B).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 15.sp, color: const Color(0xFFF59E0B)),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              note,
              style: GoogleFonts.inter(
                fontSize: 11.5.sp,
                color: const Color(0xFFFCD34D),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
