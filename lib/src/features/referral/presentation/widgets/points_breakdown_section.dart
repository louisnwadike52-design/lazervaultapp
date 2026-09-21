import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/referral/domain/entities/points_breakdown_entity.dart';

/// Where a Lazerpoints balance came from, per product.
///
/// The screen showed a total and a flat list of history rows, so "most of this
/// came from bill payments" could not be answered without scrolling the whole
/// ledger. A rewards balance nobody can account for is a rewards balance nobody
/// trusts — and the first thing someone does with an unexpected number is try
/// to work out where it came from.
///
/// Its own file rather than another method on the screen, which is already past
/// 600 lines.
class PointsBreakdownSection extends StatelessWidget {
  const PointsBreakdownSection({super.key, required this.breakdown});

  final PointsBreakdownEntity breakdown;

  static const _card = Color(0xFF1C1C1E);
  static const _border = Color(0xFF2A2A2C);

  @override
  Widget build(BuildContext context) {
    // Nothing earned yet is the normal opening state of a new account. An
    // empty card headed "Where your points came from" answers a question
    // nobody asked and makes a new account look broken, so the section is
    // simply absent until there is something to account for.
    if (breakdown.isEmpty) return const SizedBox.shrink();

    final items = breakdown.items;
    final max = items.first.points; // Server orders by points DESC.

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Where your points came from',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: _border),
          ),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
          child: Column(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (i > 0) Divider(color: _border, height: 1.h),
                _row(items[i], max),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _row(ServicePointsBreakdownEntity item, int max) {
    // Proportion of the largest row, not of the total: with one dominant
    // product every other bar would be a sliver, and a chart where the
    // differences are invisible is decoration rather than information.
    final fraction = max <= 0 ? 0.0 : (item.points / max).clamp(0.0, 1.0);
    final colour = _colourFor(item.serviceKey);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 11.h),
      child: Row(
        children: [
          Container(
            width: 34.w,
            height: 34.w,
            decoration: BoxDecoration(
              color: colour.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(_iconFor(item.serviceKey), color: colour, size: 18.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3.r),
                  child: LinearProgressIndicator(
                    value: fraction,
                    minHeight: 4.h,
                    backgroundColor: _border,
                    valueColor: AlwaysStoppedAnimation(colour),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${_points(item.points)} LP',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  // Digits line up down the column rather than jittering.
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                // A big total from one large payment reads very differently
                // from the same total earned steadily, and the count is the
                // only thing that distinguishes them.
                item.transactions == 1 ? '1 transaction' : '${item.transactions} transactions',
                style: GoogleFonts.inter(
                  color: Colors.grey[500],
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _points(int v) => NumberFormat('#,###').format(v);

  /// Icons match the product's own identity elsewhere in the app, so a row is
  /// recognisable before its label is read.
  static IconData _iconFor(String key) => switch (key) {
        'transfer' => Icons.swap_horiz_rounded,
        'bank_transfer' => Icons.account_balance_rounded,
        'international' => Icons.public_rounded,
        'crypto' => Icons.currency_bitcoin_rounded,
        'giftcards' => Icons.card_giftcard_rounded,
        'bills' => Icons.receipt_long_rounded,
        'batch_transfer' => Icons.group_outlined,
        'lazerspray' => Icons.celebration_outlined,
        'escrow' => Icons.handshake_outlined,
        'invoice' => Icons.description_outlined,
        'payroll' => Icons.groups_outlined,
        'id_pay' => Icons.badge_outlined,
        'contactless' => Icons.contactless_outlined,
        'group' => Icons.groups_2_outlined,
        'family' => Icons.family_restroom_rounded,
        'savings' => Icons.savings_outlined,
        // Also where the one-off bonuses land — a welcome bonus belongs to no
        // product, and inventing one for it would misstate where points came
        // from on the very screen built to answer that.
        _ => Icons.stars_rounded,
      };

  static Color _colourFor(String key) => switch (key) {
        'transfer' => const Color(0xFF4E03D0),
        'bank_transfer' => const Color(0xFF3B82F6),
        'international' => const Color(0xFF0EA5E9),
        'crypto' => const Color(0xFFF59E0B),
        'giftcards' => const Color(0xFF6366F1),
        'bills' => const Color(0xFF00B04F),
        'batch_transfer' => const Color(0xFF8B5CF6),
        'lazerspray' => const Color(0xFFD946EF),
        'escrow' => const Color(0xFF7C3AED),
        'invoice' => const Color(0xFF6366F1),
        'payroll' => const Color(0xFF6366F1),
        'id_pay' => const Color(0xFF9B6DFF),
        'contactless' => const Color(0xFF6F42C1),
        'group' => const Color(0xFFA855F7),
        'family' => const Color(0xFFEC4899),
        'savings' => const Color(0xFF22C55E),
        _ => const Color(0xFFF59E0B),
      };
}
