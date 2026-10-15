import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/group_funds_palette.dart';

/// Shows a name and description in full.
///
/// Group and contribution cards clip both to one line, because a list of ten
/// of them has to stay scannable — but the names people actually give these
/// things ("another esussu manual trigger for the october cohort") are longer
/// than the row, so the one piece of text that identifies the group was the
/// piece you could not read. Opening the group to find out which one it is
/// defeats the purpose of the list.
///
/// Read-only on purpose: this answers "which one is this", not "let me change
/// it". Editing lives behind the card's own menu, where it is gated by role.
Future<void> showFullTextDetailsDialog(
  BuildContext context, {
  required String title,
  required String description,
  String? subtitle,
  IconData icon = Icons.info_outline,
}) {
  final body = description.trim();
  // A BOTTOM SHEET, not a centre dialog.
  //
  // This is reached by tapping a title or description that has been clipped,
  // so it is a "show me the rest of this" gesture rather than a decision to
  // confirm. A sheet rises from the thumb, can be dismissed by dragging in the
  // same direction the finger already moved, and gives long text the full
  // width of the screen instead of a dialog's inset box.
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    // Long descriptions need to grow past the default half-height, and the
    // drag-to-dismiss has to keep working while the body scrolls.
    isScrollControlled: true,
    builder: (ctx) => Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          // Long descriptions scroll rather than growing a sheet taller than
          // the screen, which would clip its own close button.
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(ctx).size.height * 0.75,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 12.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Grab handle — says "drag me down" before the user has to
                // hunt for a close control.
                Center(
                  child: Container(
                    width: 38.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 14.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4B5563),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon, size: 18.sp, color: GroupFundsPalette.onDark),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: SelectableText(
                        title,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                        ),
                      ),
                    ),
                    // Copy, because a name this long is usually being quoted to
                    // somebody — in a chat, a support message, a search box.
                    IconButton(
                      tooltip: 'Copy',
                      padding: EdgeInsets.all(4.w),
                      constraints: const BoxConstraints(),
                      visualDensity: VisualDensity.compact,
                      icon: Icon(Icons.copy_rounded,
                          size: 16.sp, color: const Color(0xFF9CA3AF)),
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(
                          text: body.isEmpty ? title : '$title\n\n$body',
                        ));
                        if (!ctx.mounted) return;
                        HapticFeedback.lightImpact();
                        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                          content: const Text('Copied'),
                          backgroundColor: const Color(0xFF10B981),
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 1),
                        ));
                      },
                    ),
                  ],
                ),
                if (subtitle != null && subtitle.trim().isNotEmpty) ...[
                  SizedBox(height: 6.h),
                  Text(
                    subtitle.trim(),
                    style: GoogleFonts.inter(
                      color: GroupFundsPalette.onDark,
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                SizedBox(height: 12.h),
                Flexible(
                  child: SingleChildScrollView(
                    child: SelectableText(
                      // An empty description is a normal state — say so rather
                      // than leaving a blank gap that reads as a loading bug.
                      body.isEmpty ? 'No description.' : body,
                      style: GoogleFonts.inter(
                        color: body.isEmpty
                            ? const Color(0xFF6B7280)
                            : const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                        height: 1.5,
                        fontStyle:
                            body.isEmpty ? FontStyle.italic : FontStyle.normal,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: Text(
                      'Close',
                      style: GoogleFonts.inter(
                        color: GroupFundsPalette.onDark,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
