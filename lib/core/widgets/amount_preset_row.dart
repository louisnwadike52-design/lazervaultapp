import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// The quick-amount presets shown above the amount field on every bill-payment
/// screen (electricity, airtime, data, cable, betting…).
///
/// WHY A SHARED WIDGET
///
/// Each screen had rolled its own Wrap of bordered chips, and they had drifted:
/// one abbreviated to "₦1k" while another printed "₦20000" in full, with
/// different padding and radii. The long form is what broke the layout — five
/// full-width amounts cannot fit a phone, so the row wrapped and the last chip
/// sat alone on a second line looking like a different control.
///
/// TWO DELIBERATE CHOICES
///
///  * ONE LINE, ALWAYS. A Row of Expanded cells divides the width evenly
///    instead of letting content decide, so the set reads as one segmented
///    control rather than a ragged pile. Labels are abbreviated (₦1k, ₦20k) to
///    make that fit without shrinking the text to something unreadable.
///  * ELEVATION, NOT HAIRLINES. A 1px border at this size reads as noise and
///    disappears on an OLED black background. A lifted surface plus a soft
///    shadow separates the chip from the page the way every other card on
///    these screens already does.
class AmountPresetRow extends StatelessWidget {
  const AmountPresetRow({
    super.key,
    required this.amounts,
    required this.onSelected,
    this.selected,
    this.isEnabled,
    this.accent = const Color(0xFF4E03D0),
    this.brightness,
  });

  final List<int> amounts;

  /// The chosen preset, or null when the user typed a custom amount.
  final num? selected;

  final ValueChanged<int> onSelected;

  /// Optional per-amount gate — used where a provider declares min/max limits.
  /// An out-of-range preset stays visible but reads as unavailable, which is
  /// more useful than silently dropping it and changing the row's shape.
  final bool Function(int amount)? isEnabled;

  final Color accent;

  /// The surface this row is drawn ON, when it differs from the app theme.
  ///
  /// Every bill screen that uses this row paints its own near-black
  /// background while the app theme is light, so reading the ambient
  /// `Theme.of(context).brightness` produced WHITE chips on a black screen.
  /// A widget cannot see what is painted behind it, so the caller says.
  final Brightness? brightness;

  /// 1000 -> "1k", 1500 -> "1.5k", 500 -> "500".
  ///
  /// Abbreviating is what makes five presets fit one line. Below 1000 there is
  /// nothing to abbreviate, so the exact figure is kept.
  static String formatAmount(int amount) {
    if (amount < 1000) return '$amount';
    final k = amount / 1000;
    return k == k.roundToDouble()
        ? '${k.toStringAsFixed(0)}k'
        : '${k.toStringAsFixed(1)}k';
  }

  @override
  Widget build(BuildContext context) {
    if (amounts.isEmpty) return const SizedBox.shrink();
    final isDark =
        (brightness ?? Theme.of(context).brightness) == Brightness.dark;
    // Unselected chips are now TINTED AND BORDERED rather than a flat slab:
    // a solid light surface read as a disabled button on the dark screens,
    // and gave the row no relationship to the accent the selected chip uses.
    final surface = isDark
        ? Color.alphaBlend(accent.withValues(alpha: 0.16), const Color(0xFF121212))
        : Color.alphaBlend(accent.withValues(alpha: 0.08), Colors.white);
    final labelColor = isDark ? Colors.white : const Color(0xFF111827);

    return Row(
      children: [
        for (var i = 0; i < amounts.length; i++) ...[
          if (i > 0) SizedBox(width: 8.w),
          Expanded(
            child: _Chip(
              label: '₦${formatAmount(amounts[i])}',
              selected: selected != null && selected == amounts[i],
              enabled: isEnabled?.call(amounts[i]) ?? true,
              surface: surface,
              labelColor: labelColor,
              accent: accent,
              isDark: isDark,
              onTap: () => onSelected(amounts[i]),
            ),
          ),
        ],
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.enabled,
    required this.surface,
    required this.labelColor,
    required this.accent,
    required this.isDark,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool enabled;
  final Color surface;
  final Color labelColor;
  final Color accent;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = !enabled
        ? surface.withValues(alpha: 0.4)
        : selected
            ? accent
            : surface;
    return GestureDetector(
      // opaque so the whole cell is the target, not just the glyph run.
      behavior: HitTestBehavior.opaque,
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        // Tall enough to tap, tight enough that five fit across a phone.
        height: 40.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10.r),
          // The border is what makes an unselected chip read as a control
          // rather than a filled label. The selected one keeps a brighter
          // edge so the choice is unmistakable at a glance.
          border: Border.all(
            color: !enabled
                ? accent.withValues(alpha: 0.18)
                : selected
                    ? accent.withValues(alpha: 0.95)
                    : accent.withValues(alpha: isDark ? 0.55 : 0.40),
            width: selected ? 1.4 : 1.1,
          ),
          boxShadow: !enabled
              ? null
              : [
                  BoxShadow(
                    color: selected
                        ? accent.withValues(alpha: 0.32)
                        : Colors.black.withValues(alpha: 0.28),
                    blurRadius: selected ? 10 : 6,
                    offset: Offset(0, selected ? 3 : 2),
                  ),
                ],
        ),
        child: FittedBox(
          // A long label (₦10k) must shrink rather than overflow the cell —
          // a RenderFlex overflow stripe on a payment screen is unacceptable.
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Text(
              label,
              maxLines: 1,
              style: GoogleFonts.inter(
                color: !enabled
                    ? labelColor.withValues(alpha: 0.35)
                    : selected
                        ? Colors.white
                        : labelColor,
                fontSize: 13.sp,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
