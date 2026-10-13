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
  return showDialog<void>(
    context: context,
    builder: (ctx) => Dialog(
      backgroundColor: const Color(0xFF1F1F1F),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: ConstrainedBox(
        // Long descriptions scroll rather than growing a dialog taller than
        // the screen, which clips its own close button.
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(ctx).size.height * 0.7,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
  );
}
