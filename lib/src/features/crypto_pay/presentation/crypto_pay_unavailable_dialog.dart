import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Why paying with crypto cannot be combined with a scheduled or recurring
/// transfer, said once, in one place.
///
/// THE CONVERSION RUNS THE MOMENT THE TRANSFER IS AUTHORISED. That is the
/// whole design: the coin is sold, the naira lands, and the transfer goes out
/// behind it. A schedule or a repeat asks for the opposite — pay LATER, and
/// possibly many times. Honouring both would mean selling someone's crypto
/// today to pay a bill next month, leaving the naira idle in between and the
/// customer exposed to a fall they never agreed to; or selling again on every
/// repeat, which nobody asked for and nobody would see coming.
///
/// auth-service refuses the combination too (`a payment cannot be both
/// scheduled and funded by crypto`), so this is the same rule said early and
/// in words, rather than as a server error after the PIN.
enum CryptoPayConflict { scheduled, recurring }

class CryptoPayUnavailableDialog {
  const CryptoPayUnavailableDialog._();

  /// Explains the clash and returns what the customer chose.
  ///
  /// Returns true when they want to go ahead with the SCHEDULE/REPEAT and pay
  /// from their wallet instead; false when they would rather keep paying with
  /// crypto and drop the schedule.
  ///
  /// THE DEFAULT IS THE THING THEY JUST TAPPED. Someone who has this moment
  /// turned on "Repeat" means it, so the primary action keeps the repeat and
  /// moves the funding back to the wallet. Silently reverting their newest
  /// choice is how an app feels broken.
  static Future<bool> show(
    BuildContext context, {
    required CryptoPayConflict conflict,
    required String assetLabel,
  }) async {
    final what = conflict == CryptoPayConflict.scheduled
        ? 'a scheduled transfer'
        : 'a repeating transfer';
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1E),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          'Pay with crypto is not available here',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Selling your $assetLabel happens as soon as a transfer is '
          'authorised, so it cannot be used for $what — that would convert '
          'your crypto now to pay later.\n\n'
          'Keep the $what and pay from your wallet instead?',
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              'Keep paying with $assetLabel',
              style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF), fontSize: 13.sp),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 78, 3, 208)),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              'Use my wallet',
              style: GoogleFonts.inter(
                  fontSize: 13.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
    // A dismissed dialog chose nothing; the safe reading is "leave it as the
    // customer just set it", which is the schedule/repeat they tapped.
    return ok ?? true;
  }
}
