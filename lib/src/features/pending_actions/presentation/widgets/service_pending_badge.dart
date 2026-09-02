import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// The count bubble on a service tile: "you owe money in here".
///
/// Deliberately RED rather than the brand purple. Every other accent on the
/// grid is purple, so a purple badge reads as decoration; this one is a debt
/// the user is carrying and has to stand apart from the tile it sits on. The
/// white ring keeps it legible over both the tile's white background and the
/// purple icon disc it overlaps.
class ServicePendingBadge extends StatelessWidget {
  const ServicePendingBadge({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();
    final label = count > 9 ? '9+' : '$count';
    return Semantics(
      label: '$count pending payment${count == 1 ? '' : 's'}',
      child: Container(
        constraints: BoxConstraints(minWidth: 16.w, minHeight: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.white, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFEF4444).withValues(alpha: 0.35),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          widthFactor: 1,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 9.sp,
              height: 1.1,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
