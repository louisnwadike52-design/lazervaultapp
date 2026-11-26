import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/widgets/partner_disclosure_sheet.dart';

/// The route to the full PiggyVault disclosure, and an optional line naming
/// who provides it.
///
/// WHY THIS EXISTS. A customer committing money to a fixed term should be
/// able to read the terms without leaving the app.
///
/// TWO PARTS, WITH DIFFERENT RULES, AND THAT IS THE POINT:
///
///  * The **CTA always renders**. The URL comes from
///    `piggyvault_disclosure_url` and [FeatureFlags.piggyvaultDisclosureUrl]
///    falls back to the published page when the setting is blank, so there is
///    deliberately no "hide when unset" branch. A compliance surface that
///    disappears because nobody filled in a field is not a compliance
///    surface.
///  * The **attribution line is operator text and ships EMPTY**
///    (`piggyvault_provider_text`). It used to be the compiled sentence
///    "Piggyvault is powered by Swiftlynx." — a commercial fact that changes
///    without a release, which the app would go on asserting after it stopped
///    being true. Operator decision 2026-11-24: show nothing until somebody
///    writes something.
///
/// The CTA opens [showPartnerDisclosureSheet] at 80% rather than a full
/// screen: reading the terms is a glance taken while deciding, so the product
/// stays visible behind it.
///
/// Kept in its own file because the PiggyVault landing screen is already far
/// past the size guideline, and because the creation and review steps show the
/// same footer: one widget means the attribution cannot drift between the
/// screen that advertises the product and the screen that takes the money.
class PiggyVaultDisclosureFooter extends StatelessWidget {
  const PiggyVaultDisclosureFooter({
    super.key,
    this.onLight = false,
    this.padding,
    this.alignStart = false,
  });

  /// Left-align instead of centring, for the one place this footer shares a
  /// row with something else.
  ///
  /// On the PiggyVault landing page the footer is pinned at the bottom and the
  /// "Create Lock" button floats over the bottom-right corner, so the centred
  /// text ran straight under it: "Piggyvault is powered by S…" and "View
  /// Piggyvault disclo…" with the rest behind the button. A disclosure that
  /// cannot be read is not a disclosure, which is the one thing this widget
  /// exists to be.
  final bool alignStart;

  /// Set on light backgrounds (the create/review sheets). The landing page is
  /// a dark gradient; the same muted-grey would be unreadable on both.
  final bool onLight;

  final EdgeInsetsGeometry? padding;

  Color get _muted =>
      onLight ? const Color(0xFF6B7280) : Colors.white.withValues(alpha: 0.45);

  Color get _link =>
      onLight ? const Color(0xFF4E03D0) : Colors.white.withValues(alpha: 0.92);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            alignStart ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          // THE ATTRIBUTION IS OPERATOR TEXT, AND THERE IS NONE BY DEFAULT.
          //
          // "Piggyvault is powered by Swiftlynx." was compiled in. Who powers
          // the product is a commercial fact that changes without a release,
          // so it is now `piggyvault_provider_text` and ships EMPTY — the
          // line simply is not drawn, rather than drawn blank with its
          // spacing left behind.
          //
          // Read inside build, not captured: the settings poll can land after
          // the first paint.
          if (FeatureFlags.piggyvaultProviderText.isNotEmpty) ...[
            Text(
              FeatureFlags.piggyvaultProviderText,
              textAlign: alignStart ? TextAlign.start : TextAlign.center,
              style: GoogleFonts.inter(color: _muted, fontSize: 11.sp),
            ),
            SizedBox(height: 6.h),
          ],
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            // The URL is resolved INSIDE the callback, so it is read at tap
            // time rather than at build time: the settings poll can land
            // after this widget is first painted, and a value captured during
            // build would pin the compiled fallback for the whole session.
            //
            // A SHEET, NOT A SCREEN. Reading the terms is a glance taken
            // while deciding, so the product stays visible behind it at 80%
            // and one swipe puts it away — instead of a full-screen route
            // with an app bar, a share menu and an overflow, which is the
            // furniture of somewhere you have gone to.
            onTap: () => showPartnerDisclosureSheet(
              context,
              url: FeatureFlags.piggyvaultDisclosureUrl,
              title: 'Piggyvault Disclosure',
            ),
            child: Padding(
              // No left inset when start-aligned, or the link sits indented
              // from the line above it and reads as a different block.
              padding: EdgeInsets.fromLTRB(alignStart ? 0 : 8.w, 4.h, 8.w, 4.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.gavel_rounded, color: _link, size: 13.sp),
                  SizedBox(width: 7.w),
                  Text(
                    'View Piggyvault disclosure',
                    style: GoogleFonts.inter(
                      color: _link,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 7.w),
                  Icon(Icons.open_in_new_rounded,
                      color: _link.withValues(alpha: 0.7), size: 11.sp),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
