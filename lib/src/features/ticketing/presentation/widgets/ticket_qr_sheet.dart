import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/generated/ticketing.pb.dart' as tk;

import '../cubit/ticketing_cubit.dart';

import 'ticket_actions.dart';
import 'ticketing_theme.dart';

/// THE CODE, AS BIG AND AS BRIGHT AS THE SCREEN ALLOWS.
///
/// The card in the list shows a 148px code on a dark surface, which is fine
/// for recognising which ticket is which and useless at a door: a cheap
/// scanner in a dim venue needs size and contrast, and the holder has one
/// hand free. So the card is the index and this is the thing you actually
/// present.
///
/// A WHITE FULL-BLEED GROUND, not the app's dark theme. Every other surface in
/// this feature is dark on purpose; this one is inverted because a QR on a
/// dark card is the single most common reason a scan fails, and a screen at
/// full brightness against white is what a turnstile expects. The system bars
/// are flipped to match so the page does not read as a rendering fault.
Future<void> showTicketQrSheet(
  BuildContext context,
  tk.MyTicket ticket, {
  bool refundsEnabled = false,
  bool transfersEnabled = false,
  int refundCutoffHours = 0,
  int sameOrderCount = 1,
  TicketingCubit? cubit,
}) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      // THE CALLER'S CUBIT IS CARRIED ONTO THE PUSHED ROUTE.
      //
      // This is a full page, not a sheet, so it gets its own BuildContext with
      // no ancestor provider — the actions on it would otherwise throw looking
      // for one. `.value`, never `create`: the list screen owns this cubit and
      // closes it on pop, and a second owner would close it out from under the
      // screen behind.
      builder: (_) => cubit == null
          ? _TicketQrPage(
              ticket: ticket,
              refundsEnabled: false,
              transfersEnabled: false,
              refundCutoffHours: refundCutoffHours,
              sameOrderCount: sameOrderCount,
            )
          : BlocProvider<TicketingCubit>.value(
              value: cubit,
              child: _TicketQrPage(
                ticket: ticket,
                refundsEnabled: refundsEnabled,
                transfersEnabled: transfersEnabled,
                refundCutoffHours: refundCutoffHours,
                sameOrderCount: sameOrderCount,
              ),
            ),
    ),
  );
}

class _TicketQrPage extends StatelessWidget {
  const _TicketQrPage({
    required this.ticket,
    required this.refundsEnabled,
    required this.transfersEnabled,
    required this.refundCutoffHours,
    required this.sameOrderCount,
  });
  final tk.MyTicket ticket;
  final bool refundsEnabled;
  final bool transfersEnabled;
  final int refundCutoffHours;
  final int sameOrderCount;

  @override
  Widget build(BuildContext context) {
    final used =
        ticket.status == tk.TicketAdmissionStatus.TICKET_ADMISSION_STATUS_USED;
    final cancelled = ticket.eventStatus ==
        tk.TicketEventStatus.TICKET_EVENT_STATUS_CANCELLED;
    final dead = used || cancelled;

    // The side of the screen is the scan target, so the code takes the width
    // it can get rather than a fixed size — a 10" tablet and a small phone
    // both end up with the largest square that fits.
    final side = MediaQuery.of(context).size.width - 80.w;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Dark icons, because this page is white. Without this the status bar
      // keeps the app's light-on-dark icons and disappears.
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          title: Text('Your ticket',
              style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 32.h),
            child: Column(
              children: [
                Text(ticket.eventTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                if (ticket.hasEventAt()) ...[
                  SizedBox(height: 4.h),
                  Text(
                      DateFormat('EEE d MMM y, h:mm a')
                          .format(ticket.eventAt.toDateTime()),
                      style: GoogleFonts.inter(
                          fontSize: 12.5.sp, color: Colors.black54)),
                ],
                if (ticket.venue.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(ticket.venue,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          fontSize: 12.5.sp, color: Colors.black54)),
                ],
                SizedBox(height: 20.h),
                // A DEAD TICKET IS STAMPED, NOT HIDDEN. The holder still has
                // to be able to show a steward what they hold; what must not
                // happen is them presenting it believing it will work.
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: dead ? 0.15 : 1,
                      child: QrImageView(
                        data: ticket.code,
                        version: QrVersions.auto,
                        size: side,
                        gapless: true,
                        // Explicit, not inherited: this page is white and the
                        // widget's defaults follow the theme.
                        backgroundColor: Colors.white,
                        eyeStyle: const QrEyeStyle(
                          eyeShape: QrEyeShape.square,
                          color: Colors.black,
                        ),
                        dataModuleStyle: const QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.square,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    if (dead)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: TicketingTheme.warning,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          cancelled ? 'EVENT CANCELLED' : 'ALREADY USED',
                          style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                              color: Colors.white),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 18.h),
                // THE CODE IN TEXT, TAPPABLE TO COPY. A scanner that will not
                // read the screen — a cracked display, a scratched lens, harsh
                // sunlight — leaves the steward typing it, and the door's own
                // check-in screen accepts a typed code for exactly that reason.
                InkWell(
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: ticket.code));
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Code copied',
                          style: GoogleFonts.inter(fontSize: 13.sp)),
                    ));
                  },
                  borderRadius: BorderRadius.circular(10.r),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(ticket.code,
                            style: GoogleFonts.robotoMono(
                                fontSize: 20.sp,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w700,
                                color: Colors.black)),
                        SizedBox(width: 8.w),
                        Icon(Icons.copy_rounded,
                            size: 16.w, color: Colors.black45),
                      ],
                    ),
                  ),
                ),
                if (used && ticket.hasCheckedInAt()) ...[
                  SizedBox(height: 6.h),
                  Text(
                      'Admitted '
                      '${DateFormat('d MMM, h:mm a').format(ticket.checkedInAt.toDateTime())}',
                      style: GoogleFonts.inter(
                          fontSize: 12.sp, color: Colors.black54)),
                ],
                if (cancelled) ...[
                  SizedBox(height: 10.h),
                  Text(
                      'This event was cancelled. Your money is being refunded '
                      'automatically — you do not need to do anything.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          fontSize: 12.5.sp, color: Colors.black54)),
                ],
                TicketActions(
                  ticket: ticket,
                  refundsEnabled: refundsEnabled,
                  transfersEnabled: transfersEnabled,
                  refundCutoffHours: refundCutoffHours,
                  sameOrderCount: sameOrderCount,
                ),
                SizedBox(height: 16.h),
                Text('Turn your brightness up before you reach the door.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 11.5.sp, color: Colors.black38)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
