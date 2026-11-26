import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/generated/ticketing.pb.dart' as tk;

import '../cubit/ticketing_cubit.dart';
import '../cubit/ticketing_state.dart';
import 'package:lazervault/core/shared_widgets/load_more_footer.dart'
    show ScrollEndLoader;
import '../widgets/load_more_footer.dart';
import '../widgets/ticketing_theme.dart';

/// THE ORGANISER'S DOOR LIST — one row per admission, not per order.
///
/// A purchase of four is four people through a gate, so a list that showed one
/// row saying "4" could not be ticked off as they arrived. The admin console's
/// purchases tab is the MONEY view (orders, totals, refunds); this is the DOOR
/// view, and they are deliberately different shapes for different questions.
///
/// NO BUYER CONTACT DETAILS, AND NONE ARE FETCHED. The server sends a user id
/// and nothing else about the person — an organiser is a customer, not an
/// operator, and handing them other customers' names and numbers because they
/// sold them a ticket is not a trade any of those buyers agreed to. The id is
/// shown shortened, as a way to tell two rows apart and to quote to support,
/// never as an identity.
///
/// SEARCH IS LOCAL, over the loaded page only, and says so. A server-side
/// search would need a query parameter this RPC does not have, and a box that
/// silently searched a fraction of the list would be worse than none at a door
/// where the answer is "this person is not on it".
class EventAttendeesScreen extends StatefulWidget {
  const EventAttendeesScreen({super.key, required this.eventId});
  final String eventId;

  @override
  State<EventAttendeesScreen> createState() => _EventAttendeesScreenState();
}

class _EventAttendeesScreenState extends State<EventAttendeesScreen> {
  final _search = TextEditingController();
  String _query = '';
  _Filter _filter = _Filter.all;

  @override
  void initState() {
    super.initState();
    context.read<TicketingCubit>().loadAttendees(widget.eventId);
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TicketingTheme.bg,
      appBar: AppBar(
        backgroundColor: TicketingTheme.bg,
        foregroundColor: TicketingTheme.onBar,
        elevation: 0,
        title: Text('Guest list',
            style: GoogleFonts.inter(
                fontSize: 18.sp, fontWeight: FontWeight.w700)),
      ),
      body: BlocBuilder<TicketingCubit, TicketingState>(
        builder: (context, state) {
          if (state is TicketingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TicketingFailure) {
            return _Message(state.message);
          }
          if (state is! TicketAttendeesLoaded) {
            return const SizedBox.shrink();
          }
          if (state.total == 0) {
            return _Message(
              'Nobody has bought a ticket yet. They will appear here as they '
              'do, one row per person.',
            );
          }

          final rows = _apply(state.attendees);
          return Column(
            children: [
              _header(state: state),
              Expanded(
                // SCROLL TO THE BOTTOM AND THE NEXT PAGE ARRIVES. The footer
                // stays pressable and keeps the remaining count, which is what
                // makes a failed page recoverable at an end-of-list that
                // generates no further notification.
                child: ScrollEndLoader(
                  hasMore: state.attendees.length < state.total,
                  loading: context.read<TicketingCubit>().isPaging('attendees'),
                  onReachEnd: () => context
                      .read<TicketingCubit>()
                      .loadAttendees(widget.eventId, page: state.page + 1),
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 32.h),
                    // +1 for the footer, which is a row so it scrolls with the
                    // list rather than floating over the last guest.
                    itemCount: rows.length + 1,
                    separatorBuilder: (_, __) => SizedBox(height: 8.h),
                    itemBuilder: (context, i) {
                      if (i == rows.length) {
                        return LoadMoreFooter(
                          loaded: state.attendees.length,
                          total: state.total,
                          onLoadMore: () => context
                              .read<TicketingCubit>()
                              .loadAttendees(widget.eventId,
                                  page: state.page + 1),
                        );
                      }
                      return _AttendeeRow(a: rows[i]);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<tk.EventAttendee> _apply(List<tk.EventAttendee> all) {
    return all.where((a) {
      switch (_filter) {
        case _Filter.all:
          break;
        case _Filter.arrived:
          if (a.status !=
              tk.TicketAdmissionStatus.TICKET_ADMISSION_STATUS_USED) {
            return false;
          }
        case _Filter.expected:
          // A refunded admission is not "expected" — nobody is coming on it.
          if (a.status ==
                  tk.TicketAdmissionStatus.TICKET_ADMISSION_STATUS_USED ||
              a.hasRefundedAt()) {
            return false;
          }
      }
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      return a.code.toLowerCase().contains(q) ||
          a.buyerUserId.toLowerCase().contains(q);
    }).toList();
  }

  Widget _header({required TicketAttendeesLoaded state}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _search,
            onChanged: (v) => setState(() => _query = v.trim()),
            style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
            decoration: InputDecoration(
              // Says what it searches. A box that quietly covered only the
              // loaded page would read as "not on the list".
              hintText: state.hasMore
                  ? 'Search the ${state.attendees.length} loaded'
                  : 'Search by code',
              hintStyle: GoogleFonts.inter(
                  fontSize: 14.sp, color: TicketingTheme.textMuted),
              prefixIcon:
                  const Icon(Icons.search, color: TicketingTheme.textSecondary),
              filled: true,
              fillColor: TicketingTheme.card,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 12.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              for (final f in _Filter.values) ...[
                _chip(f),
                SizedBox(width: 8.w),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(_Filter f) {
    final on = _filter == f;
    return GestureDetector(
      onTap: () => setState(() => _filter = f),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: on ? TicketingTheme.cta : TicketingTheme.card,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(f.label,
            style: GoogleFonts.inter(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
                color: on ? Colors.white : TicketingTheme.textSecondary)),
      ),
    );
  }
}

enum _Filter {
  all('Everyone'),
  expected('Expected'),
  arrived('Arrived');

  const _Filter(this.label);
  final String label;
}

class _AttendeeRow extends StatelessWidget {
  const _AttendeeRow({required this.a});
  final tk.EventAttendee a;

  @override
  Widget build(BuildContext context) {
    final used =
        a.status == tk.TicketAdmissionStatus.TICKET_ADMISSION_STATUS_USED;
    final refunded = a.hasRefundedAt();
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: TicketingTheme.card,
        borderRadius: BorderRadius.circular(12.r),
        // A refunded row is marked on its EDGE as well as in its text: at a
        // door it is read at a glance, and "refunded" buried in a subtitle is
        // how somebody gets let in on a ticket that was paid back.
        //
        // An ordinary row still gets the standard card edge — on this ground a
        // borderless card reads as a vague block — and the refunded one
        // REPLACES it rather than adding to it, so the red reads as a marker
        // instead of a thicker version of the same line.
        border: refunded
            ? const Border(
                left: BorderSide(color: TicketingTheme.error, width: 3))
            : Border.all(color: TicketingTheme.border),
      ),
      child: Row(
        children: [
          Container(
            width: 34.w,
            height: 34.w,
            decoration: BoxDecoration(
              color: used
                  ? TicketingTheme.success.withValues(alpha: 0.15)
                  : TicketingTheme.border,
              shape: BoxShape.circle,
            ),
            child: Icon(
              refunded
                  ? Icons.money_off
                  : used
                      ? Icons.check
                      : Icons.confirmation_number_outlined,
              size: 17.sp,
              color: refunded
                  ? TicketingTheme.error
                  : used
                      ? TicketingTheme.success
                      : TicketingTheme.textSecondary,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(a.code,
                    style: GoogleFonts.robotoMono(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                SizedBox(height: 2.h),
                Text(
                  _subtitle(),
                  style: GoogleFonts.inter(
                      fontSize: 11.5.sp,
                      color: refunded
                          ? TicketingTheme.error
                          : TicketingTheme.textMuted),
                ),
              ],
            ),
          ),
          Text(
            refunded
                ? 'Refunded'
                : used
                    ? 'In'
                    : 'Expected',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: refunded
                  ? TicketingTheme.error
                  : used
                      ? TicketingTheme.success
                      : TicketingTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  String _subtitle() {
    if (a.hasRefundedAt()) {
      return 'Refunded ${DateFormat('d MMM').format(a.refundedAt.toDateTime().toLocal())} '
          '— this ticket is not valid';
    }
    if (a.status == tk.TicketAdmissionStatus.TICKET_ADMISSION_STATUS_USED &&
        a.hasCheckedInAt()) {
      final at = DateFormat('d MMM, h:mm a')
          .format(a.checkedInAt.toDateTime().toLocal());
      // Which steward let them in, when a door has several. Blank is normal
      // (one person scanning) and reads as plain "Arrived".
      return a.checkedInBy.isEmpty
          ? 'Arrived $at'
          : 'Arrived $at · ${a.checkedInBy}';
    }
    if (a.hasPurchasedAt()) {
      return 'Bought ${DateFormat('d MMM').format(a.purchasedAt.toDateTime().toLocal())}';
    }
    return 'Not arrived yet';
  }
}

class _Message extends StatelessWidget {
  const _Message(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Text(text,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                fontSize: 14.sp, color: TicketingTheme.textSecondary)),
      ),
    );
  }
}
