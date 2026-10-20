import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Terms for joint funds.
///
/// Six clauses, each one sentence of what happens and one of what it means
/// for the member. The point of the list is the fourth and fifth: we are a
/// payment channel, and a member who stops paying is not something we can
/// fix. That has to be said plainly BEFORE someone puts money into a pot
/// with eleven other people.
class GroupFundsTerms {
  const GroupFundsTerms._();

  static const List<({String title, String body})> clauses = [
    (
      title: 'We hold the pot, we do not vouch for anyone',
      body: 'Lazervault is the payment channel for your group. We move the '
          'money on the triggers you set. We do not vet, guarantee or '
          'underwrite the people you save with.',
    ),
    (
      title: 'Money moves only on the agreed trigger',
      body: 'A one-time goal pays out on its date to the receiver chosen '
          'when it was created. An Esusu pays the member whose turn it is, '
          'at the end of the cycle.',
    ),
    (
      title: 'The amount is fixed in an Esusu',
      body: 'Every member pays the same share each cycle. A one-time goal '
          'is open, pay what you want, or a percentage of the target.',
    ),
    (
      title: 'We cannot make a member pay',
      body: 'If someone stops contributing, we have no way to recover it '
          'for you and we do not cover the shortfall. Save with people you '
          'trust, the way you would in person.',
    ),
    (
      title: 'A member behind on payments does not collect',
      body: 'In an Esusu, a member in arrears has their turn held back '
          'until they are up to date. The pot goes to the next member who '
          'is current, so the people who paid are not funding someone who '
          'stopped.',
    ),
    (
      title: 'Leaving, and what comes back',
      body: 'You can leave a contribution. What you get back depends on '
          'where the money already is, the app shows you the exact refund '
          'and forfeit before you confirm, and nothing moves until you do.',
    ),
  ];
}

/// Shows the terms. Read-only; there is nothing to accept here, because the
/// acceptance that matters happens at the point of paying.
/// Shows the terms, optionally with a "Don't show this again" action.
///
/// [offerDismiss] is true only for the automatic first-visit opening on the
/// landing page. Opened deliberately from the menu there is nothing to
/// suppress — you asked for it.
Future<void> showGroupFundsTermsSheet(
  BuildContext context, {
  bool offerDismiss = false,
  VoidCallback? onDismissForever,
}) async {
  // Held outside the builder so a rebuild of the sheet (keyboard, rotation)
  // does not silently untick it.
  bool dontShowAgain = false;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setSheetState) => Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * 0.86),
        margin: EdgeInsets.fromLTRB(
            14.w, MediaQuery.of(ctx).padding.top + 14.h, 14.w, 14.h),
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.gavel_rounded,
                    color: const Color(0xFF8B5CF6), size: 18.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Terms and conditions',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  icon: Icon(Icons.close,
                      color: const Color(0xFF9CA3AF), size: 20.sp),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0;
                        i < GroupFundsTerms.clauses.length;
                        i++) ...[
                      Padding(
                        padding: EdgeInsets.only(bottom: 14.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${i + 1}. ${GroupFundsTerms.clauses[i].title}',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              GroupFundsTerms.clauses[i].body,
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 12.5.sp,
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            // Only on the automatic first opening. A CHECKBOX, above the
            // button, not a second button below it: as a bare TextButton it sat
            // under the primary CTA looking like a link, gave no feedback when
            // pressed, and — because it also closed the sheet — was impossible
            // to tell apart from Close. Ticking a box and then pressing Close
            // is the pattern people already know, and it shows its own state.
            //
            // Phrased as what it does rather than "OK": the terms are not being
            // accepted here, they are being stopped from opening themselves,
            // and Settings says where to find them again.
            if (offerDismiss) ...[
              SizedBox(height: 10.h),
              InkWell(
                onTap: () =>
                    setSheetState(() => dontShowAgain = !dontShowAgain),
                borderRadius: BorderRadius.circular(8.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.w),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 22.w,
                        height: 22.w,
                        child: Checkbox(
                          value: dontShowAgain,
                          onChanged: (v) =>
                              setSheetState(() => dontShowAgain = v ?? false),
                          activeColor: const Color(0xFF8B5CF6),
                          checkColor: Colors.white,
                          side: const BorderSide(
                              color: Color(0xFF6B7280), width: 1.5),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          "Don't show this again",
                          style: GoogleFonts.inter(
                              color: Colors.white, fontSize: 12.5.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.only(left: 32.w),
                child: Text(
                  'You can reopen it any time from Settings.',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF6B7280), fontSize: 10.5.sp),
                ),
              ),
            ],
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // The tick is honoured HERE, on the way out, so the box can
                  // be ticked and unticked freely while reading.
                  if (offerDismiss && dontShowAgain) onDismissForever?.call();
                  Navigator.of(ctx).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5CF6),
                  padding: EdgeInsets.symmetric(vertical: 13.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text('Close',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
