import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';

/// THE LEFT SLOT OF A TRANSACTION ROW — one implementation, every list.
///
/// ## Why this was extracted
///
/// The full history and the dashboard's first five rendered the same
/// transactions two different ways. History showed the recipient BANK'S LOGO
/// and a direction pip; the dashboard showed a generic service glyph in a
/// tinted circle and no direction at all. So the same payment looked like two
/// different things depending on which screen you were on, and the five rows a
/// customer actually sees first were the poorer pair — "which bank" and "which
/// way" both missing from the only list most people scroll.
///
/// ## The ring is a parameter, and that is the whole reason a copy existed
///
/// The pip sits ON the avatar, so it needs a ring in the PAGE'S OWN GROUND to
/// read as sitting on top rather than being part of it. History is on
/// 0xFF0A0A0A; the dashboard card is white. A hardcoded ring is what made this
/// un-shareable — not the logic — so [ringColor] is required rather than
/// defaulted: a caller that does not say gets a compile error instead of a
/// near-black ring on a white card.
class TransactionAvatar extends StatelessWidget {
  const TransactionAvatar({
    super.key,
    required this.transaction,
    required this.ringColor,
    this.size = 40,
  });

  final UnifiedTransaction transaction;

  /// The colour of the surface this row is drawn on.
  final Color ringColor;

  /// Diameter in logical pixels before .w scaling.
  final double size;

  @override
  Widget build(BuildContext context) {
    final avatar = _avatar();
    final badge = _directionBadge();
    if (badge == null) return avatar;

    // Sized to the avatar so the badge can hang off its corner without the
    // row's height changing — an unbounded Stack would let it clip.
    return SizedBox(
      width: size.w,
      height: size.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(right: -1.w, bottom: -1.w, child: badge),
        ],
      ),
    );
  }

  /// The bank's logo where we know it, the service's glyph otherwise.
  Widget _avatar() {
    // External bank transfers show the recipient bank's logo instead of a
    // generic transfer glyph, so history reads "which bank" at a glance.
    final md = transaction.metadata;
    final bankName = md?['bank_name'] as String?;
    final bankCode = (md?['bank_code'] as String?) ??
        (md?['destination_bank_code'] as String?);

    if (bankName != null && bankName.isNotEmpty) {
      return BankLogo(
        bankName: bankName,
        bankCode: bankCode,
        size: size,
        borderRadius: size / 2,
      );
    }
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        color: transaction.serviceColor.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(
        transaction.serviceIcon,
        color: transaction.serviceColor,
        size: (size / 2).sp,
      ),
    );
  }

  /// The in/out pip, or null for a transaction with no direction.
  ///
  /// NEUTRAL FLOWS GET NOTHING. A balance enquiry or a reversal pair has no
  /// direction, and an arrow pointing one way would assert something the row
  /// does not know.
  ///
  /// INCOMING IS THE ONLY ONE COLOURED, which matches the decision the amount
  /// already makes. Painting an ordinary payment red would read as a failure,
  /// and these lists show failures in red already; two reds meaning different
  /// things is worse than one.
  Widget? _directionBadge() {
    final incoming = transaction.flow == TransactionFlow.incoming;
    final outgoing = transaction.flow == TransactionFlow.outgoing;
    if (!incoming && !outgoing) return null;

    const inColour = Color(0xFF34C759);
    const outColour = Color(0xFFD1D1D6);

    return Container(
      width: 17.w,
      height: 17.w,
      decoration: BoxDecoration(
        // SOLID, NOT TRANSLUCENT. A wash takes its actual colour from the
        // avatar beneath it, and these avatars are bank logos and brand
        // tiles — over a dark logo a translucent outgoing pip turned into a
        // grey arrow on a near-identical grey.
        color: incoming ? const Color(0xFF123D23) : const Color(0xFF2C2C2E),
        shape: BoxShape.circle,
        border: Border.all(color: ringColor, width: 1.6),
      ),
      child: Icon(
        incoming ? Icons.south_west_rounded : Icons.north_east_rounded,
        // 9.5sp inside a 17px circle left the glyph too fine to read at a
        // glance, which is the only job it has.
        size: 11.sp,
        color: incoming ? inColour : outColour,
      ),
    );
  }
}
