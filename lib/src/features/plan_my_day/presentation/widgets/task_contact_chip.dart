import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/plan_my_day/contacts/domain/entities/contact.dart';

/// Small "linked person" chip shown on a task card (Day / Board / Kanban / task
/// detail). Renders the contact's initials avatar + first name; tapping it jumps
/// to that person's CRM profile. The three lenses (Day/Board/People) stay
/// cross-navigable through this chip.
class TaskContactChip extends StatelessWidget {
  final Contact contact;
  final VoidCallback? onTap;
  final bool compact;

  const TaskContactChip({
    super.key,
    required this.contact,
    this.onTap,
    this.compact = true,
  });

  Color get _avatarColor {
    final hex = contact.avatarColor;
    if (hex != null && hex.isNotEmpty) {
      try {
        return Color(int.parse(hex.replaceAll('#', '0xFF')));
      } catch (_) {}
    }
    return const Color(0xFF8B5CF6);
  }

  String get _firstName {
    final parts = contact.name.trim().split(RegExp(r'\s+'));
    return parts.isEmpty ? contact.name : parts.first;
  }

  @override
  Widget build(BuildContext context) {
    final c = _avatarColor;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(
            left: 2.w, right: compact ? 8.w : 10.w, top: 2.w, bottom: 2.w),
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: c.withValues(alpha: 0.35)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 18.w,
              height: 18.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: c, shape: BoxShape.circle),
              child: Text(
                contact.initials,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(width: 5.w),
            Text(
              _firstName,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
