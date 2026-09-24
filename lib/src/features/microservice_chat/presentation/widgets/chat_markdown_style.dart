import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The markdown style for an assistant bubble on a DARK background.
///
/// The bubbles were built with `MarkdownStyleSheet.fromTheme(...)` overriding only
/// `p`, which left every other element on the theme's defaults. Those defaults are
/// computed for the app's surface colours, not for a dark bubble, so anything the
/// agents actually emit came out wrong:
///
///   * `code` kept a light grey background with near-black text, so an inline
///     reference like `C2C-a1b2c3` rendered as a pale block on a dark bubble.
///   * `strong` inherited the default weight rather than the bubble's text colour,
///     so a bolded headline could come through dimmer than the body around it.
///   * `blockquote` and `horizontalRuleDecoration` used theme dividers that are
///     invisible at this contrast.
///   * list bullets took the body style but not the bubble colour.
///
/// The agents write markdown — headlines, emphasis, inline references, occasional
/// lists — so this is not cosmetic: it is the difference between a formatted reply
/// and one with grey boxes and missing separators in it.
MarkdownStyleSheet chatAssistantMarkdownStyle(BuildContext context) {
  final base = Theme.of(context).textTheme.bodyMedium;
  final body = base?.copyWith(
    color: Colors.white,
    fontSize: 14.sp,
    height: 1.45,
  );

  return MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
    p: body,
    a: body?.copyWith(
      color: const Color(0xFFA78BFA),
      decoration: TextDecoration.underline,
      decorationColor: const Color(0xFFA78BFA),
    ),
    // Brighter than the body, not just heavier: at 14sp on a dark bubble weight
    // alone barely reads as emphasis.
    strong: body?.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
    em: body?.copyWith(fontStyle: FontStyle.italic),
    h1: body?.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700),
    h2: body?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
    h3: body?.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w600),
    listBullet: body,
    // A reference or an amount, readable on the bubble rather than on a pale
    // block borrowed from the light theme.
    code: body?.copyWith(
      fontFamily: 'monospace',
      fontSize: 12.5.sp,
      color: const Color(0xFFE9D5FF),
      backgroundColor: Colors.transparent,
    ),
    codeblockDecoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8.r),
    ),
    codeblockPadding: EdgeInsets.all(10.w),
    blockquoteDecoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8.r),
      border: Border(
        left: BorderSide(color: const Color(0xFF7C5CFF), width: 3.w),
      ),
    ),
    blockquotePadding: EdgeInsets.all(10.w),
    horizontalRuleDecoration: BoxDecoration(
      border: Border(
        top: BorderSide(color: Colors.white.withValues(alpha: 0.14)),
      ),
    ),
    // Tables show up in analytics-style answers; the theme's borders vanish here.
    tableBorder: TableBorder.all(
      color: Colors.white.withValues(alpha: 0.14),
      width: 1,
    ),
    tableHead: body?.copyWith(fontWeight: FontWeight.w600),
    tableBody: body,
    // Tightened so a two-line reply does not sit in a block of dead space inside
    // an already-padded bubble.
    blockSpacing: 8.h,
    listIndent: 18.w,
  );
}
