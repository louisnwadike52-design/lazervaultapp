import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/mandate_entity.dart';

/// Small inline badge showing mandate/auto-debit status on account cards.
///
/// Renders as: [colored dot] [label text]
class MandateStatusBadge extends StatelessWidget {
  final MandateEntity? mandate;

  const MandateStatusBadge({super.key, this.mandate});

  @override
  Widget build(BuildContext context) {
    final (color, label) = _resolveDisplay();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: GoogleFonts.inter(
            color: color,
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  (Color, String) _resolveDisplay() {
    if (mandate == null) {
      return (const Color(0xFF6B7280), 'Manual auth');
    }

    switch (mandate!.status) {
      case MandateStatus.readyToDebit:
      case MandateStatus.active:
        return (const Color(0xFF10B981), 'Auto-debit');
      case MandateStatus.awaitingAuthorization:
      case MandateStatus.authorized:
        return (const Color(0xFFFB923C), 'Activating...');
      case MandateStatus.paused:
        return (const Color(0xFFFBBF24), 'Paused');
      case MandateStatus.expired:
        return (const Color(0xFFEF4444), 'Expired');
      case MandateStatus.rejected:
        return (const Color(0xFFEF4444), 'Rejected');
      case MandateStatus.cancelled:
        return (const Color(0xFF6B7280), 'Cancelled');
      case MandateStatus.pending:
        return (const Color(0xFFFB923C), 'Setting up...');
    }
  }
}
