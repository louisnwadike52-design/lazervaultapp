import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// UI for cards the supplier does not fulfil instantly.
///
/// Most of the Prestmit catalogue is pre-order (6,815 of 7,515 live cards,
/// including every Amazon SKU), while Reloadly fulfils immediately. Buying a
/// gift card strongly implies a code on the very next screen, so when that is
/// not true the user has to be told BEFORE they pay, not after.
///
/// Two surfaces, deliberately different in weight:
///   [PreOrderBadge]  a glanceable pill on the catalogue tile, so the choice
///                    can be made before opening the card at all.
///   [PreOrderNotice] the full explanation on the purchase and confirmation
///                    screens, where the user is about to commit money.
///
/// Amber, not red: this is a normal supply characteristic, not an error or a
/// risk. Red here would read as "something is wrong" and suppress legitimate
/// purchases.
const Color _preOrderAmber = Color(0xFFF59E0B);
const Color _preOrderAmberSoft = Color(0x1AF59E0B);

/// Compact pill for a catalogue tile. Keep it small: it sits alongside the
/// price on a dense grid card.
class PreOrderBadge extends StatelessWidget {
  const PreOrderBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: _preOrderAmberSoft,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: _preOrderAmber.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule_rounded, size: 10.sp, color: _preOrderAmber),
          SizedBox(width: 3.w),
          Text(
            'Pre-order',
            style: GoogleFonts.inter(
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
              color: _preOrderAmber,
            ),
          ),
        ],
      ),
    );
  }
}

/// Full explanation shown before payment.
///
/// Set [compact] on the confirmation sheet, where space is tight and the user
/// has already read the long form on the purchase screen.
class PreOrderNotice extends StatelessWidget {
  const PreOrderNotice({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(compact ? 10.w : 12.w),
      decoration: BoxDecoration(
        color: _preOrderAmberSoft,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _preOrderAmber.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.schedule_rounded, size: 16.sp, color: _preOrderAmber),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery is not instant',
                  style: GoogleFonts.inter(
                    fontSize: compact ? 11.sp : 12.sp,
                    fontWeight: FontWeight.w600,
                    color: _preOrderAmber,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  compact
                      // On the confirm step the user is one tap from paying, so
                      // state only what changes their decision.
                      ? 'You pay now. The code is delivered once the supplier releases it.'
                      : 'This card is supplied as a pre-order. Your payment is taken '
                          'now and the code is delivered once the supplier releases '
                          'it, not immediately. We will notify you the moment it '
                          'lands, and it will appear under My Cards.',
                  style: GoogleFonts.inter(
                    fontSize: compact ? 10.sp : 11.sp,
                    height: 1.4,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
