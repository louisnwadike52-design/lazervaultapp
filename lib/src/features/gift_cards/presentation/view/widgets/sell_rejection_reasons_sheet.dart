import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// One canonical reason a gift-card sell can be rejected by the processor,
/// with the sample reviewer comment and a plain-language explanation/fix.
class GiftCardRejectionReason {
  final String title;
  final String sampleComment;
  final String explanation;
  const GiftCardRejectionReason(this.title, this.sampleComment, this.explanation);
}

/// The 21 standard reasons a gift-card sell can be rejected (per Prestmit's
/// published list). Static educational/help content shown to users so they can
/// understand a rejection and fix + resubmit. Source of truth for the
/// "Why was this rejected?" modal.
const List<GiftCardRejectionReason> giftCardRejectionReasons = [
  GiftCardRejectionReason(
    'Vague gift card',
    'Kindly send a clear gift card with visible codes.',
    'The image was unclear and the code could not be read. Send a clear photo with the code fully visible. If you can read the code yourself, you can also type it into the comments when submitting.',
  ),
  GiftCardRejectionReason(
    'Unactivated gift card',
    'We are unable to load this gift card. It may not have been properly activated.',
    'The card was not activated. Cards must be activated right after purchase. Ask your source or return it to the store of purchase, then resubmit once activated.',
  ),
  GiftCardRejectionReason(
    'Invalid code',
    'The code you sent is not valid for this transaction. Kindly check the code.',
    'The claim code is invalid — likely a missing character or a wrong code. Double-check it with your source and resubmit the correct one.',
  ),
  GiftCardRejectionReason(
    'No offer for this card',
    'Sorry, we do not have an offer for this card at the moment.',
    'There is currently no rate/offer for this card — demand may have dropped or the brand is under maintenance. Try again later or pick another card.',
  ),
  GiftCardRejectionReason(
    'Steam error',
    'The gift card showed an error. It may not be properly activated, invalid, or incorrect. Please return the card to the store of purchase.',
    'The Steam card is not activated. Steam cards cannot be redeemed until activated — return it to the store of purchase and resubmit once confirmed.',
  ),
  GiftCardRejectionReason(
    'Google error',
    'The gift card showed an error; we need more info to redeem it. Please return the card to the store of purchase.',
    'Google Play cards sometimes show "We need more info to redeem this card", which cannot be fixed on our side. This does NOT mean it was redeemed. Lodge a complaint at the store where you bought it.',
  ),
  GiftCardRejectionReason(
    'Already used or no balance',
    'There is no balance left on this gift card. It is either used or has an issue.',
    'The card has already been used and has no balance. If you suspect unauthorized use, report it to the gift-card brand support team.',
  ),
  GiftCardRejectionReason(
    'Submitted by another user first',
    'Your transaction has been declined as this card has been submitted by another user.',
    'This exact card was already submitted by someone else. Trades are processed first-come, first-served. If you are the rightful owner, contact the card brand support.',
  ),
  GiftCardRejectionReason(
    'Xbox membership card',
    'The Xbox gift card cannot be processed. It is already linked to a different Microsoft account.',
    'Membership cards (issued to members) are different from prepaid gift cards and cannot be redeemed. We do not buy membership cards.',
  ),
  GiftCardRejectionReason(
    'Debit / cash receipt required',
    'Kindly send a debit receipt that matches this asset. Otherwise, submit it in the no-receipt category.',
    'Some cards (e.g. Amazon bought with cash/debit) need a receipt for the higher "receipt" rate. Without a valid receipt the card is processed under "no receipt". Attach the receipt and resubmit if you forgot it.',
  ),
  GiftCardRejectionReason(
    'Card not scratched',
    'Gently peel off the silver panel on this card to reveal the card code or PIN.',
    'The silver panel on a physical card was not scratched, so the code was not visible. Gently scratch it to reveal the code and resubmit.',
  ),
  GiftCardRejectionReason(
    'Locked gift card',
    'We could not process your asset because it is locked. Contact your card support team.',
    'The card is locked — possibly reported lost or flagged invalid. Contact the gift-card brand support team to resolve it.',
  ),
  GiftCardRejectionReason(
    'Balance disparity',
    'The current balance does not match the original value. This asset cannot be processed.',
    'The card has been partially used. Cards with a balance discrepancy are considered exposed and are not accepted.',
  ),
  GiftCardRejectionReason(
    'Unable to check balance',
    'We are unable to check the balance of this asset. Kindly return it to the store of purchase.',
    'The balance could not be verified, possibly due to a brand-side error. Contact the store or the gift-card support team.',
  ),
  GiftCardRejectionReason(
    'Balance on hold',
    'This asset is currently on hold, and the balance cannot be deducted.',
    'The card balance is on hold. Contact the gift-card support team — only cards with active balances can be processed.',
  ),
  GiftCardRejectionReason(
    'Repeated / previously sent card',
    'Repeated: You have already submitted this card previously.',
    'You have submitted this same card before. Check your transaction history to confirm.',
  ),
  GiftCardRejectionReason(
    'Receipt required',
    'Receipt is required for this trade. Kindly upload it and resubmit.',
    'This card requires a receipt to process. Attach the receipt and resubmit.',
  ),
  GiftCardRejectionReason(
    'Store card — both sides required',
    'Please send clear images of both the front and back of the gift card.',
    'Store cards need clear images of BOTH the front and back. Submissions with only one side are rejected. Make sure the images are clear.',
  ),
  GiftCardRejectionReason(
    'Empty trade / no card attached',
    'There is no gift card attached to this trade.',
    'Every trade needs an image of the card or a redeemable code. Trades with no valid card/code are rejected.',
  ),
  GiftCardRejectionReason(
    'Card unscratched',
    'Please scratch the silver panel to reveal the card code or PIN.',
    'All cards need a visible code. Make sure the silver panel is properly scratched before submitting.',
  ),
  GiftCardRejectionReason(
    'Live chat / video cards',
    'We do not accept gift cards sent via live videos or chats.',
    'Cards obtained from live videos or social media are often exposed (already redeemed or unactivated) and cannot be processed.',
  ),
];

/// Opens the full-width "Why was this rejected?" modal listing the standard
/// rejection reasons. [highlightReason] (the actual reviewer comment for this
/// sale) is surfaced at the top so the user sees their specific reason first.
Future<void> showSellRejectionReasonsSheet(
  BuildContext context, {
  String? highlightReason,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => SellRejectionReasonsSheet(highlightReason: highlightReason),
  );
}

class SellRejectionReasonsSheet extends StatelessWidget {
  final String? highlightReason;
  const SellRejectionReasonsSheet({super.key, this.highlightReason});

  @override
  Widget build(BuildContext context) {
    final reason = (highlightReason ?? '').trim();
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF0A0A0A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Grab handle
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Why a sale can be rejected',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).maybePop(),
                      child: Icon(Icons.close, color: const Color(0xFF9CA3AF), size: 22.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'These are the standard reasons our gift-card processor rejects a sale, with how to fix and resubmit.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                    height: 1.4,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                  children: [
                    if (reason.isNotEmpty) _yourReasonCard(reason),
                    ...giftCardRejectionReasons.map(_reasonTile),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _yourReasonCard(String reason) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'YOUR REJECTION REASON',
            style: GoogleFonts.inter(
              color: const Color(0xFFEF4444),
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            reason,
            style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _reasonTile(GiftCardRejectionReason r) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            r.title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              '“${r.sampleComment}”',
              style: GoogleFonts.inter(
                color: const Color(0xFFFB923C),
                fontSize: 12.sp,
                fontStyle: FontStyle.italic,
                height: 1.35,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            r.explanation,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.5.sp,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
