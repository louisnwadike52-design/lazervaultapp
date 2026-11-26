import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/crowdfund_entities.dart';
import '../utils/crowdfund_status_display.dart';

/// ONE BADGE, SO A CAMPAIGN LOOKS THE SAME WHEREVER IT IS LISTED.
///
/// The vocabulary in [crowdfundStatusVisual] was already shared; the DRAWING
/// of it was not. Five surfaces each built their own pill, and two of them
/// drew no label at all — the landing page's "My campaigns" strip and its
/// discover rows tinted an icon and a progress bar by status colour and
/// stopped there. Since `active` and `completed` were both the same green,
/// an open campaign was pixel-identical to a finished one, which is what
/// "campaigns which are not completed are showing completed" looks like from
/// the outside.
///
/// Now `active` wears the brand accent, `completed` keeps the green to
/// itself, and the ending that is worth noticing is drawn LOUDLY: a filled
/// badge with 🎉 rather than another tinted pill in a column of tinted pills.
class CrowdfundStatusBadge extends StatelessWidget {
  const CrowdfundStatusBadge({
    super.key,
    required this.visual,
    this.compact = false,
  });

  /// Build from a campaign.
  factory CrowdfundStatusBadge.of(Crowdfund c,
          {Color? activeColor, bool compact = false, Key? key}) =>
      CrowdfundStatusBadge(
        key: key,
        visual: crowdfundStatusVisual(c, activeColor: activeColor),
        compact: compact,
      );

  final CrowdfundStatusVisual visual;

  /// Tighter type and padding, for a dense list row.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final fontSize = (compact ? 9.5 : 11).sp;
    final emphatic = visual.emphatic;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: (compact ? 7 : 8).w,
        vertical: (compact ? 3 : 4).h,
      ),
      decoration: BoxDecoration(
        // Filled for the ending worth celebrating, tinted for every other
        // state. The difference has to be visible at a glance in a scrolling
        // list, which a 12sp icon swap is not.
        gradient: emphatic
            ? LinearGradient(
                colors: [
                  visual.color,
                  Color.lerp(visual.color, const Color(0xFF059669), 0.55)!,
                ],
              )
            : null,
        color: emphatic ? null : visual.color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999.r),
        border: emphatic
            ? null
            : Border.all(color: visual.color.withValues(alpha: 0.35)),
        boxShadow: emphatic
            ? [
                BoxShadow(
                  color: visual.color.withValues(alpha: 0.35),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (visual.emoji.isNotEmpty) ...[
            // The emoji carries the meaning on its own in a dense row, where
            // the label may be the first thing to be clipped.
            Text(visual.emoji, style: TextStyle(fontSize: fontSize)),
            SizedBox(width: 4.w),
          ] else ...[
            Icon(visual.icon,
                size: fontSize + 1,
                color: emphatic ? Colors.white : visual.color),
            SizedBox(width: 3.w),
          ],
          Text(
            visual.label,
            style: TextStyle(
              color: emphatic ? Colors.white : visual.color,
              fontSize: fontSize,
              fontWeight: emphatic ? FontWeight.w800 : FontWeight.w600,
              letterSpacing: emphatic ? 0.2 : 0,
            ),
          ),
        ],
      ),
    );
  }
}
