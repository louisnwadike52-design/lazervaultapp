import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// One selectable thing in a scope filter: a linked bank, or a LazerVault
/// wallet. Both answer the same question ("which of my money is this about?"),
/// so both use one selector rather than two that drift apart.
class ScopeItem {
  final String id;
  final String label;

  /// Second line: an account number, a wallet type, a balance.
  final String? subtitle;

  const ScopeItem({required this.id, required this.label, this.subtitle});

  /// What actually gets PAINTED for [subtitle].
  ///
  /// Subtitles used to appear only inside the picker sheet; once they also
  /// render on the inline pills, a caller passing a raw account number (the
  /// bank selector passes `accountNumber` verbatim) would print it in full on
  /// the analytics page. Masking here — at the one place a subtitle is drawn —
  /// means no present or future caller can leak one by forgetting.
  ///
  /// Idempotent by construction: anything that is not a bare run of digits is
  /// returned untouched, so a server-supplied "••••8300" and a type label like
  /// "Personal" both survive unchanged.
  static String maskIdentifier(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return '';
    if (!RegExp(r'^\d+$').hasMatch(v)) return v;
    if (v.length <= 4) return v;
    return '••••${v.substring(v.length - 4)}';
  }
}

/// Horizontally-scrollable multi-select scope filter.
///
/// Renders an "All" pill plus one pill per item. Tapping toggles membership and
/// the caller re-scopes every number on the page to the union of the selection.
/// An empty selection means ALL, which is why the "All" pill is selected
/// exactly when nothing else is.
///
/// Only [inlineCount] pills render inline; the rest collapse into a labelled
/// "More (N)" chip opening a bottom-sheet checklist, so a user can always tell
/// there are further options. Anything already selected is pulled inline so the
/// active scope is never hidden behind "More".
///
/// This was extracted from the bank-only version so the wallet selector could
/// reuse it instead of becoming a second copy. Bank and wallet pills are now
/// the same widget with different content.
class ScopePills extends StatelessWidget {
  static const _accent = Color(0xFFFB923C);
  static const _chipBg = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);

  const ScopePills({
    super.key,
    required this.items,
    required this.selectedIds,
    required this.onChanged,
    required this.allLabel,
    required this.icon,
    required this.sheetTitle,
    required this.sheetAllHint,
    this.inlineCount = 2,
  });

  final List<ScopeItem> items;

  /// Empty = [allLabel].
  final Set<String> selectedIds;

  /// Fired with the full next selection whenever it changes.
  final ValueChanged<Set<String>> onChanged;

  final String allLabel;
  final IconData icon;
  final String sheetTitle;
  final String sheetAllHint;
  final int inlineCount;

  void _toggle(String id) {
    final next = Set<String>.from(selectedIds);
    if (!next.add(id)) next.remove(id); // add returns false when present
    onChanged(next);
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    // Keep selected items visible inline even if they would sit past
    // inlineCount, otherwise the active scope hides behind "More".
    final inline = <ScopeItem>[];
    final overflow = <ScopeItem>[];
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      if (i < inlineCount || selectedIds.contains(item.id)) {
        inline.add(item);
      } else {
        overflow.add(item);
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _pill(
            label: allLabel,
            icon: Icons.all_inclusive_rounded,
            selected: selectedIds.isEmpty,
            onTap: () => onChanged(const <String>{}),
          ),
          for (final item in inline) ...[
            SizedBox(width: 8.w),
            _pill(
              label: item.label,
              subtitle: item.subtitle,
              icon: icon,
              selected: selectedIds.contains(item.id),
              onTap: () => _toggle(item.id),
            ),
          ],
          if (overflow.isNotEmpty) ...[
            SizedBox(width: 8.w),
            _moreChip(context, overflow.length),
          ],
        ],
      ),
    );
  }

  Widget _pill({
    required String label,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
    String? subtitle,
  }) {
    // Two wallets can share a display name (same person, several wallets), so
    // the name ALONE cannot tell the user which one they are scoping to. The
    // masked account number underneath is what actually identifies it. The
    // sheet already showed it; the inline pill dropped it, which is why the
    // row read as several identical-looking chips.
    final shown = ScopeItem.maskIdentifier(subtitle);
    final hasSubtitle = shown.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: hasSubtitle ? 6.h : 8.h,
        ),
        decoration: BoxDecoration(
          color: selected ? _accent.withValues(alpha: 0.16) : _chipBg,
          borderRadius: BorderRadius.circular(hasSubtitle ? 14.r : 20.r),
          border: Border.all(
            color: selected ? _accent : _border,
            width: selected ? 1.2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13.sp, color: selected ? _accent : _muted),
            SizedBox(width: 6.w),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: selected ? _accent : Colors.white,
                    fontSize: 12.sp,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    height: 1.15,
                  ),
                ),
                if (hasSubtitle)
                  Text(
                    shown,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color:
                          selected ? _accent.withValues(alpha: 0.75) : _muted,
                      fontSize: 10.sp,
                      height: 1.2,
                      // Masked account numbers sit in a scrolling row, so fixed
                      // digit widths keep the pills from jittering in size.
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
              ],
            ),
            if (selected) ...[
              SizedBox(width: 5.w),
              Icon(Icons.check_rounded, size: 13.sp, color: _accent),
            ],
          ],
        ),
      ),
    );
  }

  Widget _moreChip(BuildContext context, int overflowCount) {
    return GestureDetector(
      onTap: () => _openMoreSheet(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: _chipBg,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: _border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'More ($overflowCount)',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 3.w),
            Icon(Icons.keyboard_arrow_down_rounded, size: 16.sp, color: _muted),
          ],
        ),
      ),
    );
  }

  Future<void> _openMoreSheet(BuildContext context) async {
    final result = await showScopeFilterSheet(
      context,
      items: items,
      selectedIds: selectedIds,
      title: sheetTitle,
      icon: icon,
      allHint: sheetAllHint,
    );
    if (result != null) onChanged(result);
  }
}

/// Shared multi-select scope sheet, used by the inline "More" chip and by the
/// top filter bar so there is exactly ONE picker per scope kind.
///
/// Edits a local working copy, so toggling several items does not re-scope the
/// page on every tap, and returns the committed selection on Apply (null when
/// dismissed).
const _sheetAccent = Color(0xFFFB923C);
const _sheetBorder = Color(0xFF2D2D2D);
const _sheetMuted = Color(0xFF9CA3AF);

Future<Set<String>?> showScopeFilterSheet(
  BuildContext context, {
  required List<ScopeItem> items,
  required Set<String> selectedIds,
  required String title,
  required IconData icon,
  required String allHint,
}) {
  final working = Set<String>.from(selectedIds);
  return showModalBottomSheet<Set<String>>(
    context: context,
    backgroundColor: const Color(0xFF141414),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setSheetState) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 16.sp, color: _sheetAccent),
                      SizedBox(width: 8.w),
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      if (working.isNotEmpty)
                        GestureDetector(
                          onTap: () => setSheetState(working.clear),
                          child: Text(
                            'Clear',
                            style: GoogleFonts.inter(
                              color: _sheetMuted,
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    working.isEmpty ? allHint : '${working.length} selected',
                    style:
                        GoogleFonts.inter(color: _sheetMuted, fontSize: 12.sp),
                  ),
                  SizedBox(height: 12.h),
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: items.length,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        color: _sheetBorder.withValues(alpha: 0.6),
                      ),
                      itemBuilder: (_, i) {
                        final item = items[i];
                        final checked = working.contains(item.id);
                        return InkWell(
                          onTap: () => setSheetState(() {
                            if (!working.add(item.id)) working.remove(item.id);
                          }),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Row(
                              children: [
                                Icon(icon,
                                    size: 18.sp,
                                    color:
                                        checked ? _sheetAccent : _sheetMuted),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.label,
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 13.5.sp,
                                          fontWeight: checked
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                        ),
                                      ),
                                      if (ScopeItem.maskIdentifier(
                                              item.subtitle)
                                          .isNotEmpty)
                                        Text(
                                          ScopeItem.maskIdentifier(
                                              item.subtitle),
                                          style: GoogleFonts.inter(
                                              color: _sheetMuted,
                                              fontSize: 11.sp),
                                        ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  checked
                                      ? Icons.check_circle_rounded
                                      : Icons.circle_outlined,
                                  size: 20.sp,
                                  color: checked ? _sheetAccent : _sheetBorder,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 14.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _sheetAccent,
                        padding: EdgeInsets.symmetric(vertical: 13.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                      ),
                      onPressed: () => Navigator.of(ctx).pop(working),
                      child: Text(
                        working.isEmpty ? allHint : 'Apply',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
