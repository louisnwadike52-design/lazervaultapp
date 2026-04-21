import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shared list-item widget for saved beneficiaries/contacts across bill
/// payment features (airtime, data bundles, electricity meters, etc.).
///
/// Follows the dark-theme card pattern used elsewhere:
///   - 0xFF1F1F1F card bg, 16r radius, 0xFF2D2D2D border
///   - Leading colour circle with provider initial
///   - Display name, identifier subtitle, provider badge
///   - Optional last-plan / usage-count subtitles
///   - Optional trailing widget (e.g. auto-recharge badge)
class BillBeneficiaryItem extends StatelessWidget {
  /// Primary display — nickname or phone/meter number.
  final String displayName;

  /// Secondary line — phone number, meter number, etc.
  final String identifier;

  /// Network / DISCO / provider name shown as a green badge.
  final String? providerName;

  /// Background colour for the leading circle.
  final Color? providerColor;

  /// Optional "Last: 1GB" / "Last: N5,000" subtitle.
  final String? lastPlanOrAmount;

  /// If > 0 a "Used N time(s)" line is shown.
  final int? usageCount;

  /// Optional "Saved {date}" footer line. Callers pass a pre-formatted
  /// string (e.g. `Saved Dec 12, 2026`) so each feature controls its
  /// own date format without this widget taking an `intl` dep.
  final String? savedOn;

  /// Completely overrides the leading circle content (e.g. an icon).
  final Widget? leadingIcon;

  /// Optional widget placed at the trailing end of the row
  /// (e.g. auto-recharge badge).
  final Widget? trailing;

  /// Primary tap — opens options sheet / initiates purchase.
  final VoidCallback? onTap;

  /// Edit nickname.
  final VoidCallback? onEdit;

  /// Delete beneficiary.
  final VoidCallback? onDelete;

  /// Long-press handler.
  final VoidCallback? onLongPress;

  /// When true, drops the card background so the row sits flat against
  /// the scaffold. Pair with [leftAccentColor] for a list-style look.
  final bool flat;

  /// Optional left-edge colour strip. Typically the provider colour.
  /// Renders independently of [flat], but most useful in combination.
  final Color? leftAccentColor;

  const BillBeneficiaryItem({
    super.key,
    required this.displayName,
    required this.identifier,
    this.providerName,
    this.providerColor,
    this.lastPlanOrAmount,
    this.usageCount,
    this.savedOn,
    this.leadingIcon,
    this.trailing,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onLongPress,
    this.flat = false,
    this.leftAccentColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = providerColor ?? const Color(0xFF4E03D0);
    final showProvider = providerName != null &&
        providerName!.isNotEmpty &&
        providerName!.toLowerCase() != 'unknown';
    final initial = showProvider ? providerName![0].toUpperCase() : '?';

    // `flat` drops the pronounced #1F1F1F card tint, but we still need
    // contrast against the #0A0A0A scaffold so rows read as discrete
    // items — use a subtle #141414 tint instead of transparent.
    return Container(
      decoration: BoxDecoration(
        color: flat ? const Color(0xFF141414) : const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: leftAccentColor != null
            ? Border(
                left: BorderSide(color: leftAccentColor!, width: 3),
              )
            : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              leftAccentColor != null ? 14.w : 16.w,
              14.h,
              16.w,
              14.h,
            ),
            child: Row(
              children: [
                // --- Leading circle ---
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: leadingIcon ??
                        Text(
                          initial,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                  ),
                ),
                SizedBox(width: 16.w),
                // --- Text column ---
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              identifier,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xFF9CA3AF),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (showProvider) ...[
                            SizedBox(width: 8.w),
                            // Flexible wrapper + single-line ellipsis on the
                            // badge text prevents long DisCo names
                            // (e.g. "Eko Electricity Distribution Company")
                            // from pushing the row past the card width.
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981)
                                      .withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  providerName!,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF10B981),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (lastPlanOrAmount != null) ...[
                        SizedBox(height: 6.h),
                        Text(
                          'Last: $lastPlanOrAmount',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                      if (usageCount != null && usageCount! > 0) ...[
                        SizedBox(height: 4.h),
                        Text(
                          'Used $usageCount time${usageCount! > 1 ? 's' : ''}',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                      if (savedOn != null && savedOn!.isNotEmpty) ...[
                        SizedBox(height: 4.h),
                        Text(
                          savedOn!,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                // --- Trailing widget ---
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
