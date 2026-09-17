import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Someone who can be @-mentioned.
class MentionCandidate {
  final String userId;
  final String name;
  final String? username;

  const MentionCandidate({
    required this.userId,
    required this.name,
    this.username,
  });
}

/// The list that appears above the composer while an "@" is being typed.
///
/// Sits directly on top of the input rather than floating mid-screen: the
/// choice is about the word under the caret, so it belongs next to it, and a
/// centred overlay would cover the conversation being replied to.
class MentionPicker extends StatelessWidget {
  const MentionPicker({
    super.key,
    required this.candidates,
    required this.onSelected,
  });

  final List<MentionCandidate> candidates;
  final ValueChanged<MentionCandidate> onSelected;

  static const _card = Color(0xFF1E1E1E);
  static const _border = Color(0xFF2A2A2A);

  @override
  Widget build(BuildContext context) {
    // Nothing to offer means no picker — an empty panel hanging over the
    // keyboard reads as broken, and typing an "@" that matches nobody is
    // perfectly normal.
    if (candidates.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.fromLTRB(12.w, 0, 12.w, 6.h),
      // Caps at roughly four rows: tall enough to choose from, short enough to
      // leave the conversation visible above the keyboard.
      constraints: BoxConstraints(maxHeight: 208.h),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 6.h),
        // The keyboard is up and the list is short; dragging it should dismiss
        // neither the keyboard nor the picker.
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        itemCount: candidates.length,
        separatorBuilder: (_, __) => Divider(
          height: 1,
          thickness: 1,
          color: _border.withValues(alpha: 0.6),
          indent: 56.w,
        ),
        itemBuilder: (_, i) {
          final c = candidates[i];
          return InkWell(
            onTap: () => onSelected(c),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16.r,
                    backgroundColor: const Color(0xFF2D2D2D),
                    child: Text(
                      c.name.trim().isNotEmpty
                          ? c.name.trim()[0].toUpperCase()
                          : '?',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // The username disambiguates two members with the same
                        // display name — the exact case where picking the wrong
                        // row notifies the wrong person.
                        if ((c.username ?? '').trim().isNotEmpty)
                          Text(
                            '@${c.username!.trim()}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: Colors.grey[500],
                              fontSize: 11.5.sp,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
