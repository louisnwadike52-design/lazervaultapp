import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Open-loop PREPAID cards (Visa / Mastercard / Amex prepaid) behave nothing
/// like a merchant gift card: the balance is spendable anywhere the network is
/// accepted, and the card has to be activated before first use. Buyers who
/// think they're getting a store voucher — or who never activate — end up with
/// a card that appears not to work, so these are flagged wherever the item
/// appears: brand list, amount selection, receipt and the receipt PDF.
///
/// There is no `is_prepaid` field from any provider, so detection is by brand
/// name/category. Kept deliberately narrow — matching the card NETWORKS only —
/// so a merchant brand that happens to contain the word "card" is never
/// mislabelled.
bool isPrepaidGiftCard(String brandName, {String category = ''}) {
  final haystack = '$brandName $category'.toLowerCase();
  if (!haystack.contains('prepaid')) return false;
  const networks = ['visa', 'mastercard', 'master card', 'amex',
      'american express', 'discover', 'maestro'];
  return networks.any(haystack.contains);
}

/// Short "PREPAID" pill. Sits beside a brand name or receipt title.
class PrepaidBadge extends StatelessWidget {
  final bool compact;

  const PrepaidBadge({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 6.w : 8.w,
        vertical: compact ? 2.h : 3.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0EA5E9).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: const Color(0xFF0EA5E9).withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.credit_card_rounded,
              size: (compact ? 10 : 12).sp, color: const Color(0xFF38BDF8)),
          SizedBox(width: 4.w),
          Text(
            'PREPAID',
            style: GoogleFonts.inter(
              color: const Color(0xFF38BDF8),
              fontSize: (compact ? 8.5 : 9.5).sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

/// One-paragraph explainer shown where the user is deciding or has just
/// bought — the two moments the distinction actually matters.
class PrepaidExplainer extends StatelessWidget {
  const PrepaidExplainer({super.key});

  static const String text =
      'Prepaid cards work like a debit card — spend the balance anywhere the '
      'network is accepted. Activate it before first use; the balance '
      "can't be topped up.";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0EA5E9).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF0EA5E9).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded,
              size: 16.sp, color: const Color(0xFF38BDF8)),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                color: const Color(0xFFBAE6FD),
                fontSize: 11.5.sp,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
