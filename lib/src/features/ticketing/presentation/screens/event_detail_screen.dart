import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/generated/ticketing.pb.dart' as tk;

import '../../data/event_share_service.dart';
import '../cubit/ticketing_cubit.dart';
import '../cubit/ticketing_state.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/buy_tickets_sheet.dart';
import '../widgets/event_flyer_viewer.dart';
import '../widgets/ticket_money.dart';
import '../widgets/ticketing_theme.dart';

/// One event, and the way in to buying.
///
/// The price shown on the Buy button is the SERVER'S QUOTE for one ticket
/// ([TicketEventDetail.buyerTotalPerTicketMinor]), not the ticket price: when
/// the buyer bears the commission the two differ, and showing the bare price
/// here and a larger total at the PIN is how a purchase starts to feel like a
/// bait. The quote comes from the same engine that charges.
class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key, required this.eventId});
  final String eventId;

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TicketingCubit>().loadEvent(widget.eventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TicketingTheme.bg,
      appBar: AppBar(
        backgroundColor: TicketingTheme.bg,
        foregroundColor: TicketingTheme.onBar,
        elevation: 0,
        title: Text('Event',
            style: GoogleFonts.inter(
                fontSize: 18.sp, fontWeight: FontWeight.w700)),
        actions: [
          // SHARE IS ON THE EVENT, not just the organiser page: a buyer
          // sending an event to a friend is how most tickets get sold, and an
          // event nobody can link to is a list nobody finds.
          BlocBuilder<TicketingCubit, TicketingState>(
            builder: (context, state) {
              if (state is! TicketEventDetail) return const SizedBox.shrink();
              return IconButton(
                tooltip: 'Share this event',
                icon: const Icon(Icons.ios_share),
                onPressed: () => _shareEvent(context, state),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<TicketingCubit, TicketingState>(
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
          if (state is TicketPurchased) {
            return _PurchaseDone(purchase: state.purchase);
          }
          if (state is! TicketEventDetail) return const SizedBox.shrink();
          return _Body(detail: state);
        },
      ),
    );
  }
}

/// Shares the event with its price and date attached.
///
/// A bare URL in a group chat gets ignored, so the message carries what the
/// recipient needs to decide whether to tap. FALLS BACK TO THE CLIPBOARD: on
/// a device with no share target, or when the sheet throws, leaving the user
/// looking at a button that did nothing is the one outcome to avoid.
Future<void> _shareEvent(BuildContext context, TicketEventDetail detail) async {
  final e = detail.event;
  final svc = EventShareService();
  final message = svc.messageFor(
    eventId: e.id,
    title: e.title,
    whenLabel: e.hasEventAt()
        ? DateFormat('EEE d MMM y, h:mm a').format(e.eventAt.toDateTime())
        : null,
    venue: e.venue,
    priceLabel: ticketMoney(detail.buyerTotalPerTicketMinor, e.currency),
  );
  final box = context.findRenderObject() as RenderBox?;
  try {
    await SharePlus.instance.share(ShareParams(
      text: message,
      subject: e.title,
      // Anchors the iPad popover; without it the sheet anchors top-left.
      sharePositionOrigin: (box != null && box.hasSize)
          ? box.localToGlobal(Offset.zero) & box.size
          : null,
    ));
  } catch (_) {
    await Clipboard.setData(ClipboardData(text: message));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Event link copied',
            style: GoogleFonts.inter(fontSize: 13.sp)),
        backgroundColor: TicketingTheme.card,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.detail});
  final TicketEventDetail detail;

  @override
  Widget build(BuildContext context) {
    final tk.TicketEvent e = detail.event;
    final onSale =
        e.status == tk.TicketEventStatus.TICKET_EVENT_STATUS_PUBLISHED;
    final soldOut = e.hasCapacity() && e.remaining <= 0;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (e.flyerUrl.isNotEmpty)
            GestureDetector(
              // TAPS INTO THE FULL FLYER, with the same Hero tag the list card
              // uses. A flyer at 16:9 inside a scroll view still crops the
              // small type organisers put at the bottom — the line-up, the
              // dress code, the door time.
              onTap: () => EventFlyerViewer.open(context, e.flyerUrl,
                  heroTag: 'event-flyer-${e.id}'),
              child: Hero(
                tag: 'event-flyer-${e.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(e.flyerUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                            color: TicketingTheme.border,
                            child: const Icon(
                                Icons.image_not_supported_outlined,
                                color: TicketingTheme.textMuted))),
                  ),
                ),
              ),
            ),
          SizedBox(height: 16.h),
          Text(e.title,
              style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
          SizedBox(height: 8.h),
          if (e.hasEventAt())
            _Row(
              icon: Icons.event_outlined,
              text: DateFormat('EEEE d MMMM y, h:mm a')
                  .format(e.eventAt.toDateTime()),
            ),
          if (e.venue.isNotEmpty)
            _Row(icon: Icons.place_outlined, text: e.venue),
          if (e.organiserName.trim().isNotEmpty)
            _Row(
              icon: Icons.person_outline,
              text: 'Hosted by ${e.organiserName.trim()}',
              // Opens that host's whole programme. The single most common
              // next question after "what is this" is "what else are they
              // doing", and the answer was previously unreachable.
              onTap: () =>
                  Get.toNamed(AppRoutes.ticketingHostFor(e.organiserName)),
            ),
          if (e.hasSalesCloseAt())
            _Row(
              icon: Icons.timer_outlined,
              text: 'Sales close '
                  '${DateFormat('d MMM, h:mm a').format(e.salesCloseAt.toDateTime())}',
            ),
          _Row(
            icon: Icons.people_outline,
            // See the card: "∞" rather than "/0", because an absent capacity
            // is unlimited and a zero would read as sold out.
            text: e.hasCapacity()
                ? '${e.remaining} of ${e.capacity} tickets left'
                : '${e.ticketsSold} sold · unlimited capacity',
          ),
          if (e.description.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Text(e.description,
                style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    height: 1.5,
                    color: TicketingTheme.textBody)),
          ],
          if (e.organiserSocials.isNotEmpty) ...[
            SizedBox(height: 16.h),
            _OrganiserSocials(socials: e.organiserSocials),
          ],
          SizedBox(height: 24.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: TicketingTheme.card,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: TicketingTheme.border),
            ),
            child: Column(
              children: [
                _PriceLine(
                    label: 'Ticket',
                    value: ticketMoney(e.unitPriceMinor.toInt(), e.currency)),
                // THE COMMISSION IS NAMED when the buyer bears it. Rolling it
                // silently into one figure is what makes a customer think they
                // were overcharged when the receipt itemises it later.
                if (detail.feePerTicketMinor > 0 &&
                    detail.buyerTotalPerTicketMinor >
                        e.unitPriceMinor.toInt()) ...[
                  SizedBox(height: 6.h),
                  _PriceLine(
                    label: 'Service fee',
                    value: ticketMoney(detail.feePerTicketMinor, e.currency),
                    muted: true,
                  ),
                ],
                SizedBox(height: 10.h),
                Divider(height: 1, color: TicketingTheme.border),
                SizedBox(height: 10.h),
                _PriceLine(
                  label: 'You pay, per ticket',
                  value:
                      ticketMoney(detail.buyerTotalPerTicketMinor, e.currency),
                  bold: true,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: TicketingTheme.cta,
                disabledBackgroundColor: TicketingTheme.border,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              // DISABLED WITH A REASON ON IT, never a dead button: the label
              // says why rather than leaving the buyer tapping.
              onPressed: (!onSale || soldOut)
                  ? null
                  : () => showBuyTicketsSheet(context, detail),
              child: Text(
                soldOut
                    ? 'Sold out'
                    : !onSale
                        ? 'Not on sale'
                        : 'Buy tickets',
                style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.icon, required this.text, this.onTap});
  final IconData icon;
  final String text;

  /// Tappable rows are tinted with the ticket accent, so a row that does
  /// something is distinguishable from a row that only says something. Without
  /// that, the host row looks identical to the venue row and nobody tries it.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colour =
        onTap == null ? TicketingTheme.textSecondary : TicketingTheme.ticket;
    final row = Padding(
      padding: EdgeInsets.only(top: 6.h),
      child: Row(
        children: [
          Icon(icon, size: 16.w, color: colour),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(text,
                style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight:
                        onTap == null ? FontWeight.w400 : FontWeight.w600,
                    color: colour)),
          ),
          if (onTap != null)
            Icon(Icons.chevron_right, size: 16.w, color: colour),
        ],
      ),
    );
    if (onTap == null) return row;
    return InkWell(
        onTap: onTap, borderRadius: BorderRadius.circular(8.r), child: row);
  }
}

/// The host's handles, as links.
///
/// EVERY HANDLE IS TURNED INTO A URL HERE, not stored as one. The server
/// stores what the organiser typed — "lagosjazz" — because that is what they
/// know; which site it belongs to is the map key. Building the URL at render
/// time means a stored handle can never be a link to somewhere else, which is
/// the thing that matters when the text came from a user.
class _OrganiserSocials extends StatelessWidget {
  const _OrganiserSocials({required this.socials});
  final Map<String, String> socials;

  static const _labels = <String, String>{
    'instagram': 'Instagram',
    'x': 'X',
    'tiktok': 'TikTok',
    'facebook': 'Facebook',
    'youtube': 'YouTube',
    'whatsapp': 'WhatsApp',
    'website': 'Website',
  };

  static const _icons = <String, IconData>{
    'instagram': Icons.camera_alt_outlined,
    'x': Icons.alternate_email,
    'tiktok': Icons.music_note_outlined,
    'facebook': Icons.facebook_outlined,
    'youtube': Icons.play_circle_outline,
    'whatsapp': Icons.chat_bubble_outline,
    'website': Icons.link,
  };

  /// null when the platform is not one we know how to build a link for — the
  /// chip then renders as plain text rather than as a link that goes nowhere.
  Uri? _uri(String platform, String handle) {
    final h = handle.trim().replaceFirst(RegExp(r'^@'), '');
    if (h.isEmpty) return null;
    switch (platform) {
      case 'instagram':
        return Uri.parse('https://instagram.com/$h');
      case 'x':
        return Uri.parse('https://x.com/$h');
      case 'tiktok':
        return Uri.parse('https://tiktok.com/@$h');
      case 'facebook':
        return Uri.parse('https://facebook.com/$h');
      case 'youtube':
        // A channel handle, not a user id: youtube.com/@handle is the form
        // that resolves for both.
        return Uri.parse('https://youtube.com/@$h');
      case 'whatsapp':
        // Digits only — wa.me refuses anything else, including the leading
        // plus people naturally type.
        final digits = h.replaceAll(RegExp(r'[^0-9]'), '');
        return digits.isEmpty ? null : Uri.parse('https://wa.me/$digits');
      case 'website':
        final withScheme = h.startsWith('http://') || h.startsWith('https://')
            ? h
            : 'https://$h';
        final parsed = Uri.tryParse(withScheme);
        // ONLY http(s). The server validates on the way in, but a stored row
        // predates that check and a `javascript:`/`file:` URL must never be
        // handed to the launcher.
        if (parsed == null ||
            (parsed.scheme != 'http' && parsed.scheme != 'https')) {
          return null;
        }
        return parsed;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final entries =
        socials.entries.where((e) => e.value.trim().isNotEmpty).toList()
          // Key order so the chips do not reshuffle between rebuilds — a map's
          // iteration order is not a promise to the reader.
          ..sort((a, b) => a.key.compareTo(b.key));
    if (entries.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Follow the host',
            style: GoogleFonts.inter(
                fontSize: 12.sp, color: TicketingTheme.textSecondary)),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            for (final entry in entries)
              _SocialChip(
                label: _labels[entry.key] ?? entry.key,
                icon: _icons[entry.key] ?? Icons.link,
                handle: entry.value.trim(),
                uri: _uri(entry.key, entry.value),
              ),
          ],
        ),
      ],
    );
  }
}

class _SocialChip extends StatelessWidget {
  const _SocialChip({
    required this.label,
    required this.icon,
    required this.handle,
    required this.uri,
  });
  final String label;
  final IconData icon;
  final String handle;
  final Uri? uri;

  @override
  Widget build(BuildContext context) {
    final enabled = uri != null;
    return InkWell(
      onTap: enabled
          ? () async {
              // externalApplication so Instagram/X open in their own app when
              // installed. A failure is swallowed: there is nothing useful to
              // say to someone whose phone has no browser, and a red snackbar
              // over an event page reads as the event being broken.
              try {
                await launchUrl(uri!, mode: LaunchMode.externalApplication);
              } catch (_) {}
            }
          : null,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: TicketingTheme.card,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
              color: enabled
                  ? TicketingTheme.ticket.withValues(alpha: 0.4)
                  : TicketingTheme.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 13.w,
                color:
                    enabled ? TicketingTheme.ticket : TicketingTheme.textMuted),
            SizedBox(width: 6.w),
            Text(label == 'Website' ? label : '$label · $handle',
                style: GoogleFonts.inter(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w600,
                    color: enabled ? Colors.white : TicketingTheme.textMuted)),
          ],
        ),
      ),
    );
  }
}

class _PriceLine extends StatelessWidget {
  const _PriceLine({
    required this.label,
    required this.value,
    this.bold = false,
    this.muted = false,
  });
  final String label;
  final String value;
  final bool bold;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final colour = muted ? TicketingTheme.textSecondary : Colors.white;
    return Row(
      children: [
        Text(label,
            style: GoogleFonts.inter(
                fontSize: bold ? 14.sp : 13.sp, color: colour)),
        const Spacer(),
        Text(value,
            style: GoogleFonts.inter(
                fontSize: bold ? 16.sp : 13.sp,
                fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
                color: colour)),
      ],
    );
  }
}

/// What the buyer sees the moment the purchase lands.
class _PurchaseDone extends StatelessWidget {
  const _PurchaseDone({required this.purchase});
  final tk.BuyTicketsResponse purchase;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(28.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 56.w, color: TicketingTheme.success),
            SizedBox(height: 16.h),
            Text(
              // A REPLAY SAYS SO. Without this the buyer sees a second
              // "purchased" screen for money that did not move again and
              // reasonably concludes they were charged twice.
              purchase.alreadyPurchased
                  ? 'You already have these tickets'
                  : 'Tickets bought',
              style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            SizedBox(height: 8.h),
            Text(
              '${purchase.quantity} × '
              '${ticketMoney(purchase.unitPriceMinor.toInt(), purchase.currency)}'
              '  ·  paid '
              '${ticketMoney(purchase.buyerTotalMinor.toInt(), purchase.currency)}',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 13.sp, color: TicketingTheme.textSecondary),
            ),
            if (purchase.ticketCodes.isNotEmpty) ...[
              SizedBox(height: 18.h),
              Text('Your codes',
                  style: GoogleFonts.inter(
                      fontSize: 12.sp, color: TicketingTheme.textMuted)),
              SizedBox(height: 6.h),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.w,
                runSpacing: 8.h,
                children: purchase.ticketCodes
                    .map((c) => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            color: TicketingTheme.card,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: TicketingTheme.border),
                          ),
                          child: Text(c,
                              style: GoogleFonts.robotoMono(
                                  fontSize: 12.sp, color: Colors.white)),
                        ))
                    .toList(),
              ),
            ],
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: TicketingTheme.cta,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  elevation: 0,
                ),
                onPressed: () => Get.back(),
                child: Text('Done',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
