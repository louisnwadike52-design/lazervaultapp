import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:lazervault/core/shared_widgets/server_refusal_sheet.dart';
import 'package:lazervault/src/generated/ticketing.pb.dart' as tk;

import '../cubit/ticketing_cubit.dart';
import '../cubit/ticketing_state.dart';
import 'package:lazervault/core/shared_widgets/load_more_footer.dart'
    show ScrollEndLoader;
import '../widgets/load_more_footer.dart';
import '../widgets/ticket_money.dart';
import '../widgets/ticket_qr_sheet.dart';
import '../widgets/ticketing_theme.dart';

/// MY TICKETS — what the holder shows at a door.
///
/// The QR encodes the CODE ALONE, not a URL and not a signed blob. The code is
/// already unique and single-use, and the check-in call is authenticated as the
/// ORGANISER — so the thing being scanned does not need to carry authority, and
/// a code that cannot be replayed is better than a token that can.
class MyTicketsScreen extends StatefulWidget {
  const MyTicketsScreen({super.key});

  @override
  State<MyTicketsScreen> createState() => _MyTicketsScreenState();
}

class _MyTicketsScreenState extends State<MyTicketsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TicketingCubit>().loadMyTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TicketingTheme.bg,
      appBar: AppBar(
        backgroundColor: TicketingTheme.bg,
        foregroundColor: TicketingTheme.onBar,
        elevation: 0,
        title: Text('My tickets',
            style: GoogleFonts.inter(
                fontSize: 18.sp, fontWeight: FontWeight.w700)),
      ),
      body: BlocConsumer<TicketingCubit, TicketingState>(
        // A REFUND OR A TRANSFER CHANGES THIS LIST, so the result is reported
        // and the list reloaded — otherwise the ticket just given away sits
        // there until the user pulls to refresh, and tapping it opens a QR for
        // a code somebody else now holds.
        listener: (context, state) async {
          final cubit = context.read<TicketingCubit>();
          if (state is TicketOrderRefunded) {
            final r = state.refund;
            await showServerRefusal(
              context,
              title: r.alreadyRefunded ? 'Already refunded' : 'Refunded',
              message: r.alreadyRefunded
                  // SAYS SO rather than showing a second success for money
                  // that did not move again.
                  ? 'This order was already refunded. Reference '
                      '${r.reference}.'
                  : state.isPartial
                      // The kept fee is NAMED. A buyer who paid ₦5,200 and
                      // got ₦5,000 back needs to be told why here, not left
                      // to find it on a statement.
                      ? '${ticketMoney(r.amountMinor.toInt(), r.currency)} is on '
                          'its way back to your wallet. The booking fee of '
                          '${ticketMoney(r.feeKeptMinor.toInt(), r.currency)} '
                          'was kept. Reference ${r.reference}.'
                      : '${ticketMoney(r.amountMinor.toInt(), r.currency)} is on '
                          'its way back to your wallet. Reference '
                          '${r.reference}.',
              tone: ServerRefusalTone.refusal,
            );
            if (!context.mounted) return;
            // Close the QR page the action was taken from, if it is still up.
            Navigator.of(context).popUntil((r) => r.isFirst || !r.isCurrent);
            cubit.loadMyTickets();
          }
          if (state is TicketTransferred) {
            await showServerRefusal(
              context,
              title: 'Ticket sent',
              message:
                  '${state.transfer.eventTitle} is now theirs. It has left '
                  'your tickets and only they can give it back.',
              tone: ServerRefusalTone.refusal,
            );
            if (!context.mounted) return;
            Navigator.of(context).popUntil((r) => r.isFirst || !r.isCurrent);
            cubit.loadMyTickets();
          }
        },
        builder: (context, state) {
          if (state is TicketingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TicketingFailure) {
            return _Centered(text: state.message);
          }
          if (state is! MyTicketsLoaded) return const SizedBox.shrink();
          if (state.tickets.isEmpty) {
            return const _Centered(
                text: 'You have no tickets yet.\nBuy one from Events.');
          }
          return // SCROLL TO THE BOTTOM AND THE NEXT PAGE ARRIVES.
// The footer below is still pressable and still says how many rows
// remain — it is what makes a FAILED page recoverable, since a list
// already at its end generates no further scroll notification.
              ScrollEndLoader(
            hasMore: state.tickets.length < state.total,
            loading: context.read<TicketingCubit>().isPaging('mytickets'),
            onReachEnd: () => context
                .read<TicketingCubit>()
                .loadMyTickets(page: state.page + 1),
            child: RefreshIndicator(
              onRefresh: () => context.read<TicketingCubit>().loadMyTickets(),
              child: ListView.separated(
                padding: EdgeInsets.all(16.w),
                itemCount: state.tickets.length + 1,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (_, i) {
                  if (i == state.tickets.length) {
                    return LoadMoreFooter(
                      loaded: state.tickets.length,
                      total: state.total,
                      onLoadMore: () => context
                          .read<TicketingCubit>()
                          .loadMyTickets(page: state.page + 1),
                    );
                  }
                  final t = state.tickets[i];
                  return _TicketCard(
                    ticket: t,
                    refundsEnabled: state.refundsEnabled,
                    transfersEnabled: state.transfersEnabled,
                    refundCutoffHours: state.refundCutoffHours,
                    // Counted from the rows already on screen. The ORDER is what
                    // a refund acts on, and a buyer needs to be told it voids
                    // all of them — the server refunds the whole order whatever
                    // this says, so a short count only ever understates.
                    sameOrderCount: state.tickets
                        .where((o) => o.purchaseId == t.purchaseId)
                        .length,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  const _TicketCard({
    required this.ticket,
    this.refundsEnabled = false,
    this.transfersEnabled = false,
    this.refundCutoffHours = 0,
    this.sameOrderCount = 1,
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
    final when = ticket.hasEventAt()
        ? DateFormat('EEE d MMM, h:mm a').format(ticket.eventAt.toDateTime())
        : '';

    return InkWell(
      // THE CARD WAS INERT. Tapping a ticket is the obvious gesture and it did
      // nothing — while the code on it is 148px on a dark surface, which is
      // the commonest reason a door scan fails.
      onTap: () => showTicketQrSheet(
        context,
        ticket,
        refundsEnabled: refundsEnabled,
        transfersEnabled: transfersEnabled,
        refundCutoffHours: refundCutoffHours,
        sameOrderCount: sameOrderCount,
        // The pushed page needs the SAME cubit; it has no ancestor provider
        // of its own.
        cubit: context.read<TicketingCubit>(),
      ),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: TicketingTheme.card,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: TicketingTheme.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(ticket.eventTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                ),
                if (used || cancelled) ...[
                  SizedBox(width: 8.w),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: TicketingTheme.warning.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(cancelled ? 'Event cancelled' : 'Used',
                        style: GoogleFonts.inter(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: TicketingTheme.warning)),
                  ),
                ],
              ],
            ),
            if (when.isNotEmpty || ticket.venue.isNotEmpty) ...[
              SizedBox(height: 6.h),
              Text(
                  [when, ticket.venue].where((s) => s.isNotEmpty).join('  •  '),
                  style: GoogleFonts.inter(
                      fontSize: 12.sp, color: TicketingTheme.textSecondary)),
            ],
            SizedBox(height: 16.h),
            Center(
              child: Column(
                children: [
                  // THE QR IS DIMMED, NOT HIDDEN, once the ticket is used or the
                  // event is cancelled. Hiding it would leave the holder unable
                  // to show a steward what they hold; dimming says plainly that
                  // it will not admit them again.
                  Opacity(
                    opacity: (used || cancelled) ? 0.25 : 1,
                    child: Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: QrImageView(
                        data: ticket.code,
                        version: QrVersions.auto,
                        size: 148.w,
                        gapless: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(ticket.code,
                      style: GoogleFonts.robotoMono(
                          fontSize: 15.sp,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  if (used && ticket.hasCheckedInAt()) ...[
                    SizedBox(height: 4.h),
                    Text(
                        'Admitted '
                        '${DateFormat('d MMM, h:mm a').format(ticket.checkedInAt.toDateTime())}',
                        style: GoogleFonts.inter(
                            fontSize: 11.sp, color: TicketingTheme.textMuted)),
                  ],
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Text('Paid',
                    style: GoogleFonts.inter(
                        fontSize: 12.sp, color: TicketingTheme.textMuted)),
                const Spacer(),
                Text(
                    ticketMoney(ticket.unitPriceMinor.toInt(), ticket.currency),
                    style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: TicketingTheme.textSecondary)),
              ],
            ),
            if (cancelled) ...[
              SizedBox(height: 8.h),
              Text(
                  'This event was cancelled. Your money is being refunded '
                  'automatically.',
                  style: GoogleFonts.inter(
                      fontSize: 11.sp, color: TicketingTheme.warning)),
            ],
          ],
        ),
      ),
    );
  }
}

class _Centered extends StatelessWidget {
  const _Centered({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Text(text,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 14.sp, color: TicketingTheme.textSecondary)),
        ),
      );
}
