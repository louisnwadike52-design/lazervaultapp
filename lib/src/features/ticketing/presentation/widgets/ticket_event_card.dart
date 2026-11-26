import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/generated/ticketing.pb.dart' as tk;

import 'event_flyer_viewer.dart';
import 'ticket_money.dart';
import 'ticketing_theme.dart';

/// One event in a list.
///
/// LAID OUT LIKE AN INVOICE ROW, NOT LIKE A POSTER.
///
/// The first version put the flyer across the top at 16:9, which made one card
/// roughly the height of three invoice rows: two events filled a phone screen,
/// so "what's on" meant scrolling rather than scanning. Every other list in the
/// product — invoices, tag-pay, transactions — is a Row with the words on the
/// left and one small square at the edge, and a list of events is the same kind
/// of thing: a set of rows you compare, not images you browse.
///
/// The flyer is not thrown away by shrinking it. Tapping the thumbnail opens it
/// full screen (see [EventFlyerViewer]) rather than opening the event, so the
/// artwork is one tap from the list and the row still costs 88dp.
class TicketEventCard extends StatelessWidget {
  const TicketEventCard({
    super.key,
    required this.event,
    this.onTap,
    this.onLongPress,
    this.showStatus = false,
    this.onOrganiserTap,
  });

  final tk.TicketEvent event;
  final VoidCallback? onTap;

  /// Secondary action. Used by the organiser's list for Edit, so a tap can
  /// stay on the money — the thing the list is opened for.
  final VoidCallback? onLongPress;

  /// Organiser lists show the status pill; the buyer's discover list does not,
  /// because everything on it is on sale by construction.
  final bool showStatus;

  /// Tapping the host name lists everything that host is running.
  ///
  /// Null on the organiser's own list, where every row has the same host and
  /// the navigation would be a loop.
  final ValueChanged<String>? onOrganiserTap;

  /// Hero tag for this card's flyer. Keyed on the EVENT id, not the URL: two
  /// events can legitimately share a flyer, and two Heroes with one tag in the
  /// same tree throws on flight.
  String get _heroTag => 'event-flyer-${event.id}';

  @override
  Widget build(BuildContext context) {
    final when = event.hasEventAt()
        ? DateFormat('EEE d MMM, h:mm a').format(event.eventAt.toDateTime())
        : '';
    final where = event.venue.trim();
    final host = event.organiserName.trim();

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: TicketingTheme.card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: TicketingTheme.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          event.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.25,
                          ),
                        ),
                      ),
                      if (showStatus) ...[
                        SizedBox(width: 8.w),
                        _StatusPill(status: event.status),
                      ],
                    ],
                  ),
                  if (when.isNotEmpty || where.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text(
                      [when, where].where((s) => s.isNotEmpty).join('  •  '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          fontSize: 11.sp, color: TicketingTheme.textSecondary),
                    ),
                  ],
                  if (host.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    _HostLine(
                      host: host,
                      onTap: onOrganiserTap == null
                          ? null
                          : () => onOrganiserTap!(host),
                    ),
                  ],
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      // FREE IS A WORD, NOT "₦0.00". A zero price rendered as
                      // money reads as a loading state or a bug; the whole
                      // point of a free listing is that it says free.
                      Flexible(
                        child: Text(
                          event.unitPriceMinor.toInt() <= 0
                              ? 'Free'
                              : ticketMoney(
                                  event.unitPriceMinor.toInt(), event.currency),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: event.unitPriceMinor.toInt() <= 0
                                ? TicketingTheme.success
                                : TicketingTheme.ticket,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // CAPACITY: a count of what is left only when there is a
                      // capacity. An absent capacity means unlimited, and
                      // rendering it as a zero would read as sold out — the
                      // opposite.
                      Text(
                        event.hasCapacity()
                            ? '${event.remaining} left'
                            : '${event.ticketsSold} sold',
                        style: GoogleFonts.inter(
                            fontSize: 11.sp, color: TicketingTheme.textMuted),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            _Flyer(url: event.flyerUrl, heroTag: _heroTag),
          ],
        ),
      ),
    );
  }
}

/// The square at the right edge.
///
/// Fixed 64dp so every row in the list is the same height whether or not the
/// organiser uploaded artwork — a list whose row height depends on the image
/// jitters as pages load in.
class _Flyer extends StatelessWidget {
  const _Flyer({required this.url, required this.heroTag});

  final String url;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    final side = 64.w;

    if (url.isEmpty) {
      return Container(
        width: side,
        height: side,
        decoration: BoxDecoration(
          color: TicketingTheme.border,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(Icons.local_activity_outlined,
            color: TicketingTheme.textMuted, size: 22.w),
      );
    }

    return GestureDetector(
      // The thumbnail does NOT open the event. It is the only way to see the
      // flyer properly from the list, and a tap target that sometimes opens an
      // image and sometimes opens a page is the kind of thing people stop
      // trusting. Opening the event is the rest of the row.
      onTap: () => EventFlyerViewer.open(context, url, heroTag: heroTag),
      child: Stack(
        children: [
          Hero(
            tag: heroTag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                url,
                width: side,
                height: side,
                fit: BoxFit.cover,
                // A FLYER THAT FAILS TO LOAD MUST NOT BREAK THE CARD.
                // These are user-uploaded URLs behind an edge cache, so a
                // miss is normal rather than exceptional.
                errorBuilder: (_, __, ___) => Container(
                  width: side,
                  height: side,
                  color: TicketingTheme.border,
                  child: Icon(Icons.image_not_supported_outlined,
                      color: TicketingTheme.textMuted, size: 20.w),
                ),
                loadingBuilder: (_, child, progress) => progress == null
                    ? child
                    : Container(
                        width: side,
                        height: side,
                        color: TicketingTheme.border,
                      ),
              ),
            ),
          ),
          // A small affordance so the thumbnail reads as openable rather than
          // as decoration — without it nobody discovers the full-screen view.
          Positioned(
            right: 4.w,
            bottom: 4.w,
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Icon(Icons.fullscreen,
                  size: 11.w, color: Colors.white.withValues(alpha: 0.9)),
            ),
          ),
        ],
      ),
    );
  }
}

/// "Hosted by X", tappable into that host's listing.
class _HostLine extends StatelessWidget {
  const _HostLine({required this.host, this.onTap});
  final String host;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final text = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.person_outline,
            size: 12.w,
            color: onTap == null
                ? TicketingTheme.textMuted
                : TicketingTheme.ticket),
        SizedBox(width: 4.w),
        Flexible(
          child: Text(
            host,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: onTap == null
                  ? TicketingTheme.textMuted
                  : TicketingTheme.ticket,
            ),
          ),
        ),
      ],
    );
    if (onTap == null) return text;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4.r),
      child: Padding(padding: EdgeInsets.symmetric(vertical: 1.h), child: text),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});
  final tk.TicketEventStatus status;

  @override
  Widget build(BuildContext context) {
    // CANCELLED IS AMBER, NOT GREY. Grey reads as "finished and settled", and a
    // cancelled event still owes refunds.
    final (String label, Color colour) = switch (status) {
      tk.TicketEventStatus.TICKET_EVENT_STATUS_DRAFT => (
          'Draft',
          TicketingTheme.textSecondary
        ),
      tk.TicketEventStatus.TICKET_EVENT_STATUS_PUBLISHED => (
          'On sale',
          TicketingTheme.success
        ),
      tk.TicketEventStatus.TICKET_EVENT_STATUS_SALES_CLOSED => (
          'Sales closed',
          TicketingTheme.warning
        ),
      tk.TicketEventStatus.TICKET_EVENT_STATUS_CANCELLED => (
          'Cancelled',
          TicketingTheme.warning
        ),
      tk.TicketEventStatus.TICKET_EVENT_STATUS_SETTLED => (
          'Settled',
          TicketingTheme.textMuted
        ),
      _ => ('', TicketingTheme.textMuted),
    };
    if (label.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: colour.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(label,
          style: GoogleFonts.inter(
              fontSize: 10.sp, fontWeight: FontWeight.w600, color: colour)),
    );
  }
}
