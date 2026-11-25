import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/config/dashboard_widgets.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/widgets/app_bottom_sheet.dart';

/// ADD OR REMOVE WHAT IS ON THE DASHBOARD.
///
/// The Revolut shape the operator asked for: a section is never simply
/// missing — it is not yet added, and the place to add one is on the page
/// that would show it.
///
/// Two controls, in order of how large a decision they are:
///
///   * the MODE, which moves every section the user has not personally
///     decided about. "Upgrade the UI" in the operator's words.
///   * each SECTION, which overrides the mode for that one row.
///
/// Sections the operator has withdrawn are absent from this list entirely.
/// Offering a switch for something nobody can have is worse than not
/// offering it: the user flips it, nothing appears, and the app looks broken.
Future<void> showCustomiseDashboardSheet(BuildContext context) =>
    showAppBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const _CustomiseDashboardSheet(),
    );

class _CustomiseDashboardSheet extends StatefulWidget {
  const _CustomiseDashboardSheet();

  @override
  State<_CustomiseDashboardSheet> createState() =>
      _CustomiseDashboardSheetState();
}

class _CustomiseDashboardSheetState extends State<_CustomiseDashboardSheet> {
  static const _bg = Color(0xFF1F1F1F);
  static const _card = Color(0xFF151515);
  static const _border = Color(0xFF2D2D2D);
  static const _accent = Color(0xFF4E03D0);

  /// Only the sections an operator is actually offering.
  List<DashboardWidgetSpec> get _offered => kDashboardWidgets
      .where((w) => FeatureFlags.gateAvailable(w.adminPrefix))
      .toList(growable: false);

  Future<void> _setMode(DashboardUiMode m) async {
    await DashboardWidgets.setMode(m);
    // Clear the per-section overrides with the mode change. Switching to
    // advanced while three sections are individually removed would otherwise
    // "upgrade" into a dashboard still missing them.
    await DashboardWidgets.followMode();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final basic = DashboardWidgets.isBasic;
    return Container(
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: _border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text('Customise your dashboard',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 4.h),
            Text(
              'Choose how much you want on the home page. '
              'Nothing here changes your money or your accounts.',
              style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  height: 1.35),
            ),
            SizedBox(height: 16.h),
            _modeCard(
              selected: basic,
              title: 'Basic',
              blurb: 'Your money services, and nothing else unless you add it.',
              onTap: () => _setMode(DashboardUiMode.basic),
            ),
            SizedBox(height: 10.h),
            _modeCard(
              selected: !basic,
              title: 'Advanced',
              blurb: 'Everything — crowdfunds, groups, portfolio, rates and '
                  'your monthly analysis.',
              onTap: () => _setMode(DashboardUiMode.advanced),
            ),
            SizedBox(height: 18.h),
            Text(basic ? 'Add a section' : 'Sections on your dashboard',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 8.h),
            for (final w in _offered) _sectionRow(w),
            if (_offered.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Text(
                  'There are no optional sections on this account.',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                ),
              ),
            SizedBox(height: 14.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).maybePop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accent,
                  padding: EdgeInsets.symmetric(vertical: 13.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text('Done',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _modeCard({
    required bool selected,
    required String title,
    required String blurb,
    required VoidCallback onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: selected ? _accent.withValues(alpha: 0.12) : _card,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: selected ? _accent : _border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: selected ? _accent : const Color(0xFF6B7280),
                size: 18.sp,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 2.h),
                    Text(blurb,
                        style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 11.5.sp,
                            height: 1.3)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _sectionRow(DashboardWidgetSpec w) {
    final on = DashboardWidgets.isVisible(w.id);
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _border),
        ),
        child: Row(
          children: [
            Icon(w.icon, color: const Color(0xFF9CA3AF), size: 18.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(w.label,
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 2.h),
                  Text(
                    // Say whether this row is a choice or an inheritance, so
                    // "following Basic" is not mistaken for a decision the
                    // user made and forgot.
                    DashboardWidgets.hasUserChoice(w.id)
                        ? w.description
                        : '${w.description}  ·  following '
                            '${DashboardWidgets.isBasic ? 'Basic' : 'Advanced'}',
                    style: GoogleFonts.inter(
                        color: const Color(0xFF6B7280),
                        fontSize: 11.sp,
                        height: 1.3),
                  ),
                ],
              ),
            ),
            Switch.adaptive(
              value: on,
              activeThumbColor: Colors.white,
              activeTrackColor: _accent,
              onChanged: (v) async {
                await DashboardWidgets.setVisible(w.id, v);
                if (mounted) setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// THE CARD THAT SAYS THIS PAGE IS YOURS TO SHAPE.
///
/// In BASIC it is an invitation — there are sections you have not added. In
/// ADVANCED it is a quiet "customise". Either way it is the only place a user
/// discovers the page can be changed, so it is always present unless the
/// operator has withdrawn the whole feature.
///
/// ## Why it looks like this
///
/// It was a thin dark strip — near-black fill, a 1px grey hairline — pinned
/// to the foot of the page. On a dashboard whose own surfaces are white cards
/// on a light ground, that read as a piece of a different app, and the
/// hairline read as a seam rather than a card. It is now a FILLED BOX in the
/// brand purple at low opacity: a surface of its own, full width, with no
/// border competing with its own edge, and tall enough to be a destination
/// without becoming a banner.
///
/// WHERE it sits is the operator's: see DashboardWidgets.customisePosition.
class CustomiseDashboardRow extends StatelessWidget {
  const CustomiseDashboardRow({super.key});

  /// The brand purple the dashboard already uses for its own accents.
  static const _purple = Color(0xFF4E03D0);

  @override
  Widget build(BuildContext context) {
    if (!DashboardWidgets.customisable) return const SizedBox.shrink();
    final basic = DashboardWidgets.isBasic;
    // How many sections the operator offers that are not currently on the
    // page. Saying "3 more" beats "customise" — it is the difference between
    // a settings link and an invitation.
    final hidden = kDashboardWidgets
        .where((w) => FeatureFlags.gateAvailable(w.adminPrefix))
        .where((w) => !DashboardWidgets.isVisible(w.id))
        .length;
    final inviting = basic && hidden > 0;

    return Padding(
      padding: EdgeInsets.only(top: 16.0.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => showCustomiseDashboardSheet(context),
          borderRadius: BorderRadius.circular(16.r),
          child: Ink(
            // FULL WIDTH by taking the parent's, not by a hardcoded size —
            // this sits inside the dashboard's own horizontal padding, so it
            // lines up with the cards above it rather than with the screen.
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
            decoration: BoxDecoration(
              // A WASH, NOT A SLAB. Solid purple at this size would outrank
              // the balance card; at 8% it reads as a surface that belongs to
              // the brand without competing for the eye.
              color: _purple.withValues(alpha: inviting ? 0.10 : 0.06),
              borderRadius: BorderRadius.circular(16.r),
              // NO HAIRLINE. The fill already separates it, and a 1px border
              // on a filled box is the "tiny border" that made this look like
              // a list row rather than a card.
            ),
            child: Row(
              children: [
                // The icon gets its own tile, the way the quick services do,
                // so the card reads as part of the same family rather than as
                // a stray glyph beside text.
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: _purple.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    basic
                        ? Icons.add_circle_outline_rounded
                        : Icons.tune_rounded,
                    color: _purple,
                    size: 19.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        hidden == 0
                            ? 'Customise your dashboard'
                            : basic
                                ? 'Add more to your dashboard'
                                : 'Customise your dashboard',
                        style: GoogleFonts.inter(
                          // INK, NOT WHITE. The card sits on the light
                          // dashboard; white text on a 6% purple wash is
                          // unreadable, which is what the old near-black fill
                          // was hiding.
                          color: const Color(0xFF1A1A1A),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        hidden == 0
                            ? 'Choose what shows on your home page'
                            : '$hidden section${hidden == 1 ? '' : 's'} '
                                '${basic ? 'you can add' : 'hidden'}',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6B7280),
                          fontSize: 12.sp,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded,
                    color: _purple.withValues(alpha: 0.7), size: 20.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
