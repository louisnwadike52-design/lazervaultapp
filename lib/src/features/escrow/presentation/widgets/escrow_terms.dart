import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/escrow_theme.dart';

/// The rules of an escrow deal, in the words a user would use, stated once.
///
/// WHY ONE PLACE
/// -------------
/// The rules that decide who can do what with someone else's money were
/// scattered across button visibility, server errors and notification copy.
/// A user only learned "only the seller can cancel" by not finding a button,
/// and "a release is final" by looking for one that had gone. Rules nobody
/// states are rules nobody consented to — and that is also the half of this
/// that protects the platform.
///
/// The liability clauses are deliberately plain rather than legalistic: a
/// disclaimer that is understood is worth more than one that is merely
/// present, and a user who reads "we do not inspect the goods" before paying
/// does not raise it as a surprise afterwards.
class EscrowTerms {
  const EscrowTerms._();

  /// Heading → body. Ordered as the deal happens.
  static const List<({String title, String body})> clauses = [
    (
      title: 'We hold the money, not the goods',
      body: 'Lazervault is the payment channel for this deal. We hold the '
          'buyer\'s payment and release it on the agreed trigger. We are not '
          'the buyer or the seller, we take no part in the sale itself, and '
          'we do not inspect, test, store, ship or insure anything that is '
          'being traded.',
    ),
    (
      title: 'The money moves only on an agreed trigger',
      body: 'The buyer pays into escrow. Nothing reaches the seller until the '
          'buyer confirms delivery and releases, or until our team resolves a '
          'dispute. Neither party can move the money on their own.',
    ),
    (
      title: 'Only the seller can cancel and refund',
      body: 'The seller still holds the goods, so the seller is the one who '
          'can call the deal off — before delivery is marked, whoever created '
          'it. The buyer\'s route out is a dispute, not a cancellation, so a '
          'buyer cannot unwind a deal a seller has already worked on.',
    ),
    (
      title: 'Either party can open a dispute',
      body: 'While the deal is live, either side can raise a dispute. The '
          'money stays held and untouched while our team reviews what both '
          'sides submit, and we decide only where the held funds go — not who '
          'was right about the goods.',
    ),
    (
      title: 'Releasing is final',
      body: 'Once the buyer releases the funds, the deal is closed. It cannot '
          'then be cancelled, refunded or disputed through Lazervault, and '
          'anything further is between the buyer and the seller directly.',
    ),
    (
      title: 'The escrow fee pays for the custody, not the outcome',
      body: 'The fee covers holding the money and moving it safely, so it is '
          'earned whether the deal completes or is called off. On a '
          'cancellation the buyer is refunded in full and pays nothing; the '
          'fee is charged to the seller who cancelled.',
    ),
    (
      title: 'What we are not responsible for',
      body: 'We do not guarantee the quality, condition, authenticity, '
          'legality, fitness or delivery of anything traded, and we are not '
          'liable for loss, damage or delay arising from the trade itself. '
          'Our responsibility is limited to holding the funds and moving them '
          'as these rules describe. Choose who you deal with carefully.',
    ),
  ];

  /// Key for the landing-page notice's "don't show this again" preference.
  /// Readable from settings so a user can turn the notice back on.
  static const String introDismissedKey = 'escrow_intro_notice_dismissed';

  static Future<bool> introDismissed() async {
    try {
      return (await SharedPreferences.getInstance())
              .getBool(introDismissedKey) ??
          false;
    } catch (_) {
      // A preferences failure must never be the reason the notice is hidden:
      // showing it one extra time is the harmless direction to fail in.
      return false;
    }
  }

  static Future<void> setIntroDismissed(bool value) async {
    try {
      await (await SharedPreferences.getInstance())
          .setBool(introDismissedKey, value);
    } catch (_) {
      // Non-fatal: the notice simply shows again next time.
    }
  }
}

/// Renders [EscrowTerms.clauses] as a card. Collapsed by default on a deal
/// page (where the user came to do something, not to read), expanded where
/// the terms ARE the content.
class EscrowTermsCard extends StatefulWidget {
  final bool initiallyExpanded;
  final String title;

  const EscrowTermsCard({
    super.key,
    this.initiallyExpanded = false,
    this.title = 'How Escrow Pay works, and what we cover',
  });

  @override
  State<EscrowTermsCard> createState() => _EscrowTermsCardState();
}

class _EscrowTermsCardState extends State<EscrowTermsCard> {
  late bool _open = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: EscrowTheme.card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: EscrowTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _open = !_open),
            borderRadius: BorderRadius.circular(12.r),
            child: Padding(
              padding: EdgeInsets.all(14.w),
              child: Row(
                children: [
                  Icon(Icons.gavel_rounded,
                      color: EscrowTheme.primaryLight, size: 18.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(widget.title,
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600)),
                  ),
                  Icon(_open ? Icons.expand_less : Icons.expand_more,
                      color: EscrowTheme.textSecondary, size: 20.sp),
                ],
              ),
            ),
          ),
          if (_open)
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final c in EscrowTerms.clauses) ...[
                    Text(c.title,
                        style: GoogleFonts.inter(
                            color: EscrowTheme.primaryLight,
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 4.h),
                    Text(c.body,
                        style: GoogleFonts.inter(
                            color: EscrowTheme.textSecondary,
                            fontSize: 12.sp,
                            height: 1.45)),
                    SizedBox(height: 12.h),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// The one-time notice shown on the Escrow Pay landing page.
///
/// Users arrive here expecting a marketplace. They are not in one: we are the
/// payment channel, and the difference decides who they can blame when a
/// parcel does not turn up. Saying it once, before the first deal, is both
/// the honest thing and the thing that keeps the platform out of a dispute
/// it is not a party to.
///
/// Dismissible for good, and re-enableable from Settings (searchable as
/// "Escrow"), so it is a notice rather than an obstacle.
Future<void> showEscrowIntroNotice(BuildContext context) async {
  if (await EscrowTerms.introDismissed()) return;
  if (!context.mounted) return;
  var dontShowAgain = false;
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setSheetState) => Container(
        margin: EdgeInsets.all(14.w),
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: EscrowTheme.card,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: EscrowTheme.border),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.shield_outlined,
                      color: EscrowTheme.primaryLight, size: 22.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text('Before your first deal',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                'Escrow Pay is a payment channel, not a marketplace. We hold '
                'the buyer\'s money and release it on the agreed trigger — we '
                'do not list, inspect, verify, ship or insure anything being '
                'traded, and we are not liable for the goods or services '
                'themselves. Deal with people you have reason to trust.',
                style: GoogleFonts.inter(
                    color: EscrowTheme.textSecondary,
                    fontSize: 12.5.sp,
                    height: 1.5),
              ),
              SizedBox(height: 14.h),
              const EscrowTermsCard(
                initiallyExpanded: true,
                title: 'The rules that apply to every deal',
              ),
              SizedBox(height: 12.h),
              InkWell(
                onTap: () => setSheetState(() => dontShowAgain = !dontShowAgain),
                child: Row(
                  children: [
                    Icon(
                        dontShowAgain
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: dontShowAgain
                            ? EscrowTheme.primaryLight
                            : EscrowTheme.textSecondary,
                        size: 20.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                          'Don\'t show this again (you can turn it back on in '
                          'Settings)',
                          style: GoogleFonts.inter(
                              color: EscrowTheme.textSecondary,
                              fontSize: 12.sp)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (dontShowAgain) {
                      await EscrowTerms.setIntroDismissed(true);
                    }
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: EscrowTheme.primary,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text('I understand',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
