import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/shared_widgets/server_refusal_sheet.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/generated/ticketing.pb.dart' as tk;

import 'package:lazervault/core/services/injection_container.dart';

import '../../data/ticketing_errors.dart';
import '../../data/ticketing_repository.dart';
import '../cubit/ticketing_cubit.dart';
import '../cubit/ticketing_state.dart';
import '../widgets/ticket_money.dart';
import '../widgets/ticketing_theme.dart';

/// THE ORGANISER'S VIEW of one event: what it has earned, what is owed, and
/// the three things they can do about it.
///
/// WITHDRAW IS DISABLED WITH THE SERVER'S OWN REASON ON IT, never a dead
/// button. `withdrawable` and `withdrawableReason` come from the same rules
/// the withdrawal itself enforces, so the screen can explain instead of
/// offering an action that will be refused.
///
/// CLOSE SALES AND CANCEL ARE KEPT VISIBLY APART. Closing keeps every
/// purchase and lets the organiser be paid; cancelling refunds every buyer.
/// Conflating them is how a sold-out event gets refunded because its organiser
/// only wanted to stop selling — so cancel is destructive-styled and asks.
class OrganiserEventScreen extends StatefulWidget {
  const OrganiserEventScreen({super.key, required this.eventId});
  final String eventId;

  @override
  State<OrganiserEventScreen> createState() => _OrganiserEventScreenState();
}

class _OrganiserEventScreenState extends State<OrganiserEventScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TicketingCubit>().loadEarnings(widget.eventId);
  }

  Future<void> _confirmCancel() async {
    final go = await showServerRefusal(
      context,
      title: 'Cancel this event?',
      message: 'Every buyer is refunded automatically from the ticket pool, '
          'and the event stops selling immediately. This cannot be undone.',
      actionLabel: 'Cancel the event',
      dismissLabel: 'Keep it',
      tone: ServerRefusalTone.refusal,
    );
    if (!go || !mounted) return;
    // No free-text reason collected: the buyers are refunded either way, and
    // an organiser typing an explanation into a field nobody reads is worse
    // than not asking. The admin console shows the cancellation itself.
    await context.read<TicketingCubit>().cancel(widget.eventId, '');
  }

  /// Closing sales is IRREVERSIBLE — there is no reopen path on the server —
  /// so it asks first, like cancelling does.
  ///
  /// It used to fire straight at the cubit with no confirmation and no
  /// feedback. Combined with the earnings response carrying no status, a
  /// successful close reloaded the page into an identical page, so the only
  /// reading available was that the button was dead and the organiser pressed
  /// it again. The status now hides the button; this supplies the two halves
  /// a money action owes the person taking it — a chance to stop, and word
  /// that it happened.
  Future<void> _confirmCloseSales() async {
    final go = await showServerRefusal(
      context,
      title: 'Stop selling now?',
      message: 'No one can buy a ticket after this, and sales cannot be '
          'reopened. Every ticket already sold is kept, and you can withdraw '
          'your earnings once sales are closed.',
      actionLabel: 'Stop selling',
      dismissLabel: 'Keep selling',
      tone: ServerRefusalTone.refusal,
    );
    if (!go || !mounted) return;
    await context.read<TicketingCubit>().closeSales(widget.eventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TicketingTheme.bg,
      appBar: AppBar(
        backgroundColor: TicketingTheme.bg,
        foregroundColor: TicketingTheme.onBar,
        elevation: 0,
        title: Text('Event earnings',
            style: GoogleFonts.inter(
                fontSize: 18.sp, fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            tooltip: 'Edit this event',
            icon: const Icon(Icons.edit_outlined),
            // This screen holds EARNINGS, not the event, so the event is
            // fetched before the form opens — the form needs it to know which
            // fields a sale has frozen. A failure here leaves the organiser
            // where they were with a reason, rather than on an empty form.
            onPressed: () async {
              final repo = serviceLocator<TicketingRepository>();
              // The cubit is captured BEFORE the awaits. Reading it from
              // `context` afterwards is a BuildContext crossing an async gap,
              // and the State's `mounted` does not vouch for this context.
              final cubit = context.read<TicketingCubit>();
              try {
                final resp = await repo.getEvent(widget.eventId);
                if (!context.mounted) return;
                final saved = await Get.toNamed(AppRoutes.ticketingEdit,
                    arguments: resp.event);
                if (saved != true || !mounted) return;
                cubit.loadEarnings(widget.eventId);
              } catch (e) {
                if (!context.mounted) return;
                await showServerRefusal(
                  context,
                  title: 'Could not open the event',
                  message: ticketError(e).message,
                  tone: ServerRefusalTone.failure,
                );
              }
            },
          ),
          IconButton(
            tooltip: 'Check in at the door',
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () => Get.toNamed(
              AppRoutes.ticketingCheckIn
                  .replaceFirst(':eventId', widget.eventId),
            ),
          ),
        ],
      ),
      body: BlocConsumer<TicketingCubit, TicketingState>(
        listener: (context, state) async {
          // THE CUBIT IS CAPTURED BEFORE ANY await. Reading it from `context`
          // afterwards is a BuildContext crossing an async gap, and the
          // State's `mounted` does not vouch for the listener's context.
          final cubit = context.read<TicketingCubit>();
          if (state is TicketPayoutMade) {
            await showServerRefusal(
              context,
              title: state.payout.alreadyPaid
                  // SAYS SO rather than showing a second success for money
                  // that did not move again.
                  ? 'Already withdrawn'
                  : 'Sent to your wallet',
              message: state.payout.alreadyPaid
                  ? 'These earnings were already withdrawn. Reference '
                      '${state.payout.reference}.'
                  : '${ticketMoney(state.payout.amountMinor.toInt(), state.payout.currency)} '
                      'is on its way to your wallet. Reference '
                      '${state.payout.reference}.',
              tone: ServerRefusalTone.refusal,
            );
            if (mounted) cubit.loadEarnings(widget.eventId);
          }
          if (state is TicketEventCancelled) {
            // `context.mounted`, not the State's: the first sheet above
            // awaited, so this context has to vouch for itself.
            if (!context.mounted) return;
            await showServerRefusal(
              context,
              title: 'Event cancelled',
              // The SERVER'S note, which says the refunds happen
              // automatically. An organiser who sees only "cancelled" assumes
              // they have already completed.
              message: state.note,
              tone: ServerRefusalTone.refusal,
            );
            if (mounted) Get.back();
          }
          if (state is TicketEventSaved && mounted) {
            // Say so when the state actually moved. The screen re-renders
            // from the reloaded earnings below, but a money screen that
            // changes silently reads as a screen that did nothing.
            if (state.event.status ==
                tk.TicketEventStatus.TICKET_EVENT_STATUS_SALES_CLOSED) {
              // `context.mounted`, not the State's: an earlier branch of this
              // listener awaits, so this context has to vouch for itself —
              // the same rule the cancelled branch above follows.
              if (!context.mounted) return;
              await showServerRefusal(
                context,
                title: 'Sales closed',
                message: 'No further tickets can be bought. Your earnings '
                    'become withdrawable from here.',
                tone: ServerRefusalTone.refusal,
              );
            }
            if (mounted) cubit.loadEarnings(widget.eventId);
          }
        },
        builder: (context, state) {
          if (state is TicketingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TicketingFailure) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: Text(state.message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 14.sp, color: TicketingTheme.textSecondary)),
              ),
            );
          }
          if (state is! TicketEarningsLoaded) return const SizedBox.shrink();
          return _Body(
            e: state.earnings,
            eventId: widget.eventId,
            onWithdraw: () =>
                context.read<TicketingCubit>().withdraw(widget.eventId),
            onCloseSales: _confirmCloseSales,
            onCancel: _confirmCancel,
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.e,
    required this.eventId,
    required this.onWithdraw,
    required this.onCloseSales,
    required this.onCancel,
  });

  final tk.GetEventEarningsResponse e;
  final String eventId;
  final VoidCallback onWithdraw;
  final VoidCallback onCloseSales;
  final VoidCallback onCancel;

  // WHAT THE EVENT'S STATE ALLOWS, read from the server's own status rather
  // than inferred from the money. Each mirrors a rule the service enforces,
  // so the screen offers an action only where it would actually be accepted.
  bool get _sellingNow =>
      e.status == tk.TicketEventStatus.TICKET_EVENT_STATUS_PUBLISHED;
  bool get _salesClosed =>
      e.status == tk.TicketEventStatus.TICKET_EVENT_STATUS_SALES_CLOSED ||
      e.status == tk.TicketEventStatus.TICKET_EVENT_STATUS_SETTLED;
  bool get _cancelled =>
      e.status == tk.TicketEventStatus.TICKET_EVENT_STATUS_CANCELLED;

  /// CancelEvent refuses once anything has been withdrawn — the money is in
  /// the organiser's wallet and the pool can no longer fund the refunds. Said
  /// here instead of offering the button and surfacing that refusal.
  bool get _withdrawnAlready => e.paidOutMinor > 0;

  @override
  Widget build(BuildContext context) {
    final cur = e.currency;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // OUTSTANDING LEADS. It is the figure the organiser came for — what
          // they are owed — and burying it among counts is how it stops being
          // the answer to the question they asked.
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: TicketingTheme.card,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: TicketingTheme.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Owed to you',
                    style: GoogleFonts.inter(
                        fontSize: 12.sp, color: TicketingTheme.textSecondary)),
                SizedBox(height: 6.h),
                Text(ticketMoney(e.outstandingMinor.toInt(), cur),
                    style: GoogleFonts.inter(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TicketingTheme.success,
                      disabledBackgroundColor: TicketingTheme.border,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                      elevation: 0,
                    ),
                    onPressed: e.withdrawable ? onWithdraw : null,
                    child: Text('Withdraw',
                        style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: e.withdrawable
                                ? Colors.white
                                : TicketingTheme.textSecondary)),
                  ),
                ),
                if (!e.withdrawable && e.withdrawableReason.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  Text(
                    e.hasWithdrawableAt()
                        ? '${e.withdrawableReason} '
                            '(${DateFormat('d MMM, h:mm a').format(e.withdrawableAt.toDateTime())})'
                        : e.withdrawableReason,
                    style: GoogleFonts.inter(
                        fontSize: 11.5.sp, color: TicketingTheme.textSecondary),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: TicketingTheme.card,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: TicketingTheme.border),
            ),
            child: Column(
              children: [
                _line('Tickets sold', '${e.ticketsSold}'),
                _line('Collected from buyers',
                    ticketMoney(e.grossCollectedMinor.toInt(), cur)),
                _line('Platform commission',
                    ticketMoney(e.feeCollectedMinor.toInt(), cur),
                    muted: true),
                _line('Your earnings',
                    ticketMoney(e.organiserNetMinor.toInt(), cur)),
                _line('Already withdrawn',
                    ticketMoney(e.paidOutMinor.toInt(), cur),
                    muted: true),
                if (e.refundedMinor > 0)
                  _line('Refunded to buyers',
                      ticketMoney(e.refundedMinor.toInt(), cur),
                      muted: true),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          _DoorCard(e: e, eventId: eventId),
          SizedBox(height: 20.h),
          // OFFERED ONLY WHILE THERE ARE SALES TO STOP.
          //
          // This used to render unconditionally, and the earnings response
          // carried no status for it to test — so after a successful close
          // the button came straight back and the organiser's only reading
          // was that it had not worked. Gating it on the event's own state is
          // what makes the action visibly take effect.
          if (_sellingNow) ...[
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: TicketingTheme.border),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
                onPressed: onCloseSales,
                icon: const Icon(Icons.lock_clock,
                    color: TicketingTheme.textSecondary),
                label: Text('Stop selling now',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: TicketingTheme.textSecondary)),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              // The distinction, stated where the two buttons are, because
              // this is the moment it matters.
              'Keeps every ticket sold. You can withdraw once sales are '
              'closed.',
              style: GoogleFonts.inter(
                  fontSize: 11.sp, color: TicketingTheme.textSecondary),
            ),
            SizedBox(height: 18.h),
          ] else if (_salesClosed) ...[
            // The state the button leaves behind, said plainly. An organiser
            // who has just closed sales should see the result, not an absence.
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: TicketingTheme.border.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(children: [
                const Icon(Icons.lock_outline,
                    size: 18, color: TicketingTheme.textSecondary),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    'Sales are closed. Every ticket sold is kept.',
                    style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: TicketingTheme.textSecondary),
                  ),
                ),
              ]),
            ),
            SizedBox(height: 18.h),
          ],
          // Cancelling is refused by the server once the event is already
          // cancelled, or once earnings have been withdrawn. Both are stated
          // rather than offered-and-refused.
          if (!_cancelled && !_withdrawnAlready) ...[
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side:
                      const BorderSide(color: TicketingTheme.destructiveBorder),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
                onPressed: onCancel,
                icon: const Icon(Icons.cancel_outlined,
                    color: TicketingTheme.error),
                label: Text('Cancel the event',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: TicketingTheme.error)),
              ),
            ),
            SizedBox(height: 6.h),
            Text('Refunds every buyer. This cannot be undone.',
                style: GoogleFonts.inter(
                    fontSize: 11.sp, color: TicketingTheme.error)),
          ] else if (_cancelled)
            Text(
                'This event is cancelled. Buyers are refunded automatically '
                'from the ticket pool.',
                style: GoogleFonts.inter(
                    fontSize: 11.sp, color: TicketingTheme.textSecondary))
          else
            Text(
                'Earnings have already been withdrawn, so this event can no '
                'longer be cancelled here. Raise a support case if you need '
                'to.',
                style: GoogleFonts.inter(
                    fontSize: 11.sp, color: TicketingTheme.textSecondary)),
        ],
      ),
    );
  }

  Widget _line(String label, String value, {bool muted = false}) {
    final colour = muted ? TicketingTheme.textSecondary : Colors.white;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        children: [
          Text(label, style: GoogleFonts.inter(fontSize: 13.sp, color: colour)),
          const Spacer(),
          Text(value,
              style: GoogleFonts.inter(
                  fontSize: 13.sp, fontWeight: FontWeight.w600, color: colour)),
        ],
      ),
    );
  }
}

/// AT THE DOOR: how many of the admissions sold have actually come through.
///
/// NOT ticketsSold, which is an ORDER count and is what the money above is
/// derived from. A purchase of four is four people through a gate, so an
/// organiser standing at a door reading "60 sold" against 240 humans has been
/// told the wrong thing. ticketsIssued counts admission rows and
/// ticketsAdmitted counts the ones already scanned.
///
/// Hidden entirely for an event that has issued nothing: an empty progress bar
/// reading "0 of 0" is noise on a page whose headline is money.
class _DoorCard extends StatelessWidget {
  const _DoorCard({required this.e, required this.eventId});

  final tk.GetEventEarningsResponse e;
  final String eventId;

  @override
  Widget build(BuildContext context) {
    final issued = e.ticketsIssued;
    if (issued <= 0) return const SizedBox.shrink();
    final admitted = e.ticketsAdmitted;
    // Clamped: a server that ever reported more admitted than issued would
    // otherwise paint a bar past its own end, which at a door reads as a bug
    // in the scanner.
    final progress = (admitted / issued).clamp(0.0, 1.0);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: TicketingTheme.card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: TicketingTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('At the door',
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              const Spacer(),
              Text('$admitted of $issued in',
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: admitted > 0
                          ? TicketingTheme.success
                          : TicketingTheme.textSecondary)),
            ],
          ),
          SizedBox(height: 10.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6.h,
              backgroundColor: TicketingTheme.border,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(TicketingTheme.success),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            // Says WHY the two numbers differ, because "240 issued, 60 sold"
            // on one page otherwise looks like one of them is wrong.
            issued == e.ticketsSold
                ? 'One admission per order on this event.'
                : '$issued admissions across ${e.ticketsSold} '
                    '${e.ticketsSold == 1 ? 'order' : 'orders'}.',
            style: GoogleFonts.inter(
                fontSize: 11.sp, color: TicketingTheme.textMuted),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            height: 44.h,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: TicketingTheme.border),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              onPressed: () => Get.toNamed(
                AppRoutes.ticketingAttendees.replaceFirst(':eventId', eventId),
              ),
              icon: const Icon(Icons.people_outline,
                  size: 18, color: TicketingTheme.textSecondary),
              label: Text('Guest list',
                  style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: TicketingTheme.textSecondary)),
            ),
          ),
        ],
      ),
    );
  }
}
