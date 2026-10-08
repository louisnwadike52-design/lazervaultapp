import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/escrow_deal_entity.dart';
import '../view/escrow_theme.dart';

/// The escrow action a party is about to take.
enum EscrowAction { release, markDelivered, cancel, dispute }

/// What a party is told BEFORE an escrow action, and what it costs them.
///
/// WHY EVERY ACTION GOES THROUGH ONE SHEET
///
/// The deal screen shows up to four CTAs at once and each one moves, holds or
/// freezes real money. Before this they went straight to their effect — the
/// buyer's "Confirm delivery & release funds" opened the PIN sheet immediately,
/// with nothing in between to say that the seller had not actually marked the
/// item delivered yet. A buyer could pay out in full for something never sent,
/// on a screen that gave them no reason to pause.
///
/// The fix is not to BLOCK the early release. A buyer who took delivery in
/// person is right to release, and the server deliberately allows it (see
/// ValidateRelease, which accepts FUNDED, IN_PROGRESS and DELIVERED) — refusing
/// would deadlock every hand-to-hand deal behind a seller who never taps a
/// button. So the rule here is: tell them exactly where the deal is, what the
/// action does, and what they can do instead. Then let them decide.
class EscrowActionGuide {
  final String title;
  final String body;

  /// The irreversible-consequence line, shown in its own emphasised block.
  /// Null when the action is reversible or holds no money.
  final String? warning;

  /// Shown when the deal is NOT in the step this action normally follows —
  /// e.g. releasing while the seller has not marked delivery.
  final bool outOfSequence;

  final String confirmLabel;
  final Color confirmColor;

  const EscrowActionGuide({
    required this.title,
    required this.body,
    required this.confirmLabel,
    required this.confirmColor,
    this.warning,
    this.outOfSequence = false,
  });

  /// Build the guidance for [action] from the deal's ACTUAL state, so the copy
  /// always describes where this deal really is rather than a generic flow.
  factory EscrowActionGuide.of(EscrowAction action, EscrowDealEntity deal) {
    final seller =
        deal.sellerName.trim().isEmpty ? 'the seller' : deal.sellerName;
    final buyer = deal.buyerName.trim().isEmpty ? 'the buyer' : deal.buyerName;

    switch (action) {
      case EscrowAction.release:
        // The whole reason this sheet exists. DELIVERED is the expected path;
        // FUNDED means the buyer is paying out ahead of the seller's own
        // confirmation, which is allowed but must never be accidental.
        if (deal.isDelivered) {
          return EscrowActionGuide(
            title: 'Release the funds?',
            body: '$seller has marked this delivered. Releasing pays them now '
                'and closes the deal.',
            warning: 'This cannot be undone. Only release once you have the '
                'item and it is what you agreed.',
            confirmLabel: 'Confirm & release',
            confirmColor: EscrowTheme.primary,
          );
        }
        return EscrowActionGuide(
          title: '$seller has not marked this delivered',
          body: 'You can still release if you already have the item — some '
              'deals are handed over in person and never get marked. But if '
              'you have not received it yet, message $seller first, or open a '
              'dispute and our team will step in.',
          warning: 'Releasing pays $seller immediately and cannot be undone. '
              'Your escrow protection ends the moment you release.',
          outOfSequence: true,
          confirmLabel: 'I have it — release',
          confirmColor: EscrowTheme.warning,
        );

      case EscrowAction.markDelivered:
        return EscrowActionGuide(
          title: 'Mark as delivered?',
          body: 'This tells $buyer the item is with them and asks them to '
              'confirm and release your payment. Add photos or a short video '
              'as proof — it is the evidence a dispute would be decided on.',
          warning: 'Once marked delivered the deal can no longer be cancelled. '
              '$buyer must either release the funds or open a dispute.',
          confirmLabel: 'Mark delivered',
          confirmColor: EscrowTheme.primary,
        );

      case EscrowAction.cancel:
        return EscrowActionGuide(
          title: 'Cancel and refund?',
          body: 'The full held amount goes back to $buyer and the deal closes. '
              'Either side can do this, but only before delivery is marked.',
          warning: 'This cannot be undone. If the item has already been sent, '
              'open a dispute instead so our team can look at the evidence.',
          confirmLabel: 'Cancel & refund',
          confirmColor: EscrowTheme.error,
        );

      case EscrowAction.dispute:
        return EscrowActionGuide(
          title: 'Open a dispute?',
          body: 'Our team reviews both sides and decides. The money stays held '
              'in escrow the whole time — nobody is paid and nobody is '
              'refunded until it is settled.',
          warning: 'Try messaging the other party first. Most problems are a '
              'delay or a misunderstanding, and a dispute takes longer than a '
              'conversation.',
          confirmLabel: 'Open dispute',
          confirmColor: EscrowTheme.warning,
        );
    }
  }
}

/// Show the guide. Returns true only when the user explicitly confirms;
/// dismissing any other way returns false so the caller stops.
Future<bool> showEscrowActionGuide(
  BuildContext context,
  EscrowAction action,
  EscrowDealEntity deal,
) async {
  final g = EscrowActionGuide.of(action, deal);
  final ok = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _GuideSheet(guide: g),
  );
  return ok ?? false;
}

class _GuideSheet extends StatelessWidget {
  final EscrowActionGuide guide;
  const _GuideSheet({required this.guide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: MediaQuery.of(context).padding.bottom + 16.h,
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 18.h),
        decoration: BoxDecoration(
          color: EscrowTheme.card,
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    guide.outOfSequence
                        ? Icons.warning_amber_rounded
                        : Icons.info_outline_rounded,
                    color: guide.outOfSequence
                        ? EscrowTheme.warning
                        : EscrowTheme.primary,
                    size: 22.sp,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      guide.title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                guide.body,
                style: GoogleFonts.inter(
                  color: EscrowTheme.textSecondary,
                  fontSize: 13.5.sp,
                  height: 1.45,
                ),
              ),
              if (guide.warning != null) ...[
                SizedBox(height: 14.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: guide.confirmColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                        color: guide.confirmColor.withValues(alpha: 0.4)),
                  ),
                  child: Text(
                    guide.warning!,
                    style: GoogleFonts.inter(
                      color: guide.confirmColor,
                      fontSize: 12.5.sp,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
              SizedBox(height: 18.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: EscrowTheme.border),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: Text('Not now',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: guide.confirmColor,
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: Text(guide.confirmLabel,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
