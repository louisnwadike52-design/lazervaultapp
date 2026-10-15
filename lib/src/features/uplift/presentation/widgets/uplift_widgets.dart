import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grpc/grpc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazervault/src/features/uplift/data/uplift_media_upload_service.dart';
import 'package:lazervault/src/generated/uplift.pbgrpc.dart' as up;

/// Fund-level equity terms live in the fund's opaque `metadata` JSON so no
/// proto change was needed on the fund. Shape:
/// {"equity_enabled":true,"investment_type":"equity","equity_offered_pct":1500,
///  "valuation":<kobo>,"equity_terms":"..."}
class UpEquityTerms {
  const UpEquityTerms(
      {this.enabled = false,
      this.investmentType = '',
      this.offeredPct = 0,
      this.valuation = 0,
      this.terms = ''});
  final bool enabled;
  final String investmentType;
  final int offeredPct; // pct×100
  final int valuation; // kobo
  final String terms;

  static UpEquityTerms fromMetadata(String metadata) {
    if (metadata.trim().isEmpty) return const UpEquityTerms();
    try {
      final m = jsonDecode(metadata) as Map<String, dynamic>;
      return UpEquityTerms(
        enabled: m['equity_enabled'] == true,
        investmentType: (m['investment_type'] ?? '').toString(),
        offeredPct: (m['equity_offered_pct'] as num?)?.toInt() ?? 0,
        valuation: (m['valuation'] as num?)?.toInt() ?? 0,
        terms: (m['equity_terms'] ?? '').toString(),
      );
    } catch (_) {
      return const UpEquityTerms();
    }
  }

  String toMetadata() => jsonEncode({
        'equity_enabled': enabled,
        if (investmentType.isNotEmpty) 'investment_type': investmentType,
        if (offeredPct > 0) 'equity_offered_pct': offeredPct,
        if (valuation > 0) 'valuation': valuation,
        if (terms.isNotEmpty) 'equity_terms': terms,
      });
}

/// A small purple pill used for equity / deal badges.
class UpEquityChip extends StatelessWidget {
  const UpEquityChip(
      {required this.label, this.icon = Icons.pie_chart, super.key});
  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: kUpPrimary.withOpacity(0.16),
          borderRadius: BorderRadius.circular(6),
          // No outline: the tinted fill is what makes this read as a pill.
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 12, color: kUpPrimarySoft),
          const SizedBox(width: 4),
          Text(label,
              style: GoogleFonts.inter(
                  color: kUpPrimarySoft,
                  fontSize: 11,
                  fontWeight: FontWeight.w600)),
        ]),
      );
}

/// Maps backend/transport failures to a short, user-friendly message. The Go
/// handlers already return human-readable gRPC status messages, so we surface
/// those verbatim; only bare/transport errors fall back to canned copy.
/// True when a raw error string is low-level transport/plumbing noise (HTTP
/// status leakage, gateway/proxy errors, socket/handshake failures) that must
/// never be shown to a user. e.g. the grpc-dart transport surfaces a down
/// gateway as "connection completed with 502 instead of 200".
bool _isTransportNoise(String raw) {
  final s = raw.toLowerCase();
  const needles = [
    'instead of 200',
    'connection completed',
    'bad gateway',
    'gateway time',
    'gateway timeout',
    'service unavailable',
    'internal server error',
    'http/2',
    'http status',
    'status code',
    'statuscode',
    '<html',
    'nginx',
    'cloudflare',
    'trailers',
    'connection refused',
    'connection reset',
    'connection closed',
    'connection terminated',
    'connection error',
    'handshake',
    'socketexception',
    'failed host lookup',
    'broken pipe',
    'eof',
    'transport',
  ];
  return needles.any(s.contains);
}

String upFriendlyError(Object e) {
  if (e is GrpcError) {
    // Map by code first — a stable, user-safe default per failure class.
    String byCode() {
      switch (e.code) {
        case StatusCode.unauthenticated:
          return 'Your session expired. Please log in again.';
        case StatusCode.permissionDenied:
          return 'You don\'t have permission to do that.';
        case StatusCode.unavailable:
          return 'Lazerfunds is temporarily unreachable. Please try again in a moment.';
        case StatusCode.deadlineExceeded:
          return 'The request timed out. Please try again.';
        case StatusCode.notFound:
          return 'We couldn\'t find that item.';
        case StatusCode.internal:
        case StatusCode.unknown:
          return 'Something went wrong on our end. Please try again shortly.';
        default:
          return 'Something went wrong. Please try again.';
      }
    }

    final m = (e.message ?? '').trim();
    // Only surface the server's own message when it's a clean, user-facing
    // sentence — never a leaked HTTP/transport string.
    if (m.isNotEmpty && !_isTransportNoise(m)) return m;
    return byCode();
  }
  if (e is UpliftUploadException) return e.message;
  // Non-gRPC failures (SocketException, plain Exception with a transport string)
  // must not leak either.
  final raw = e.toString();
  if (_isTransportNoise(raw)) {
    return 'Lazerfunds is temporarily unreachable. Please check your connection and try again.';
  }
  return 'Something went wrong. Please try again.';
}

// Dark palette — matched to the crypto + joint-funds (group accounts) services.
const Color kUpBg = Color(0xFF0A0A0A);
const Color kUpCard = Color(0xFF1F1F1F);
const Color kUpDivider = Color(0xFF2D2D2D);
// The accent is drawn on a near-black ground (#0A0A0A), and the app-bar buttons
// render it twice over: the glyph at full strength on a circle of the SAME
// colour at 10% alpha. The old #4E03D0 is far too dark for that — the icons,
// borders and link text all sank into the background. These are lifted into the
// violet-400/500 range so every purple element reads against black while a
// filled button still carries white label text.
const Color kUpPrimary = Color(0xFF8B5CF6);
const Color kUpPrimarySoft = Color(0xFFA78BFA);
const Color kUpSuccess = Color(0xFF10B981);
const Color kUpWarning = Color(0xFFFB923C);
const Color kUpError = Color(0xFFEF4444);
const Color kUpTextSecondary = Color(0xFF9CA3AF);

/// The subtle top-down page gradient used by the crypto surfaces (card→bg→bg).
const LinearGradient kUpPageGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFF1F1F1F), kUpBg, kUpBg],
  stops: [0.0, 0.35, 1.0],
);

/// The purple hero gradient used on primary cards + avatars.
const LinearGradient kUpAccentGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [kUpPrimary, kUpPrimarySoft],
);

/// An app-bar action styled to match [ServiceVoiceButton] and
/// [MicroserviceChatIcon], which both draw a 34pt circle filled with their icon
/// colour at 10% alpha.
///
/// A bare `IconButton` sits in a 48pt box with no circle, so the help action
/// read as a different kind of control and lined up badly beside the other two.
class UpAppBarIconButton extends StatelessWidget {
  const UpAppBarIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.tooltip,
    this.color = kUpPrimary,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final button = InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 34.w,
        height: 34.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.1),
          // A 10%-white outline on a filled circle is invisible at this
          // size on anything but a perfectly dim screen.
        ),
        child: Icon(icon, color: color, size: 17.sp),
      ),
    );
    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}

/// Wraps a page body in the crypto-style vertical gradient background AND sets
/// the Inter default text style so every descendant `Text` (whose own style
/// leaves fontFamily null) renders in Inter — matching the crypto/joint-funds
/// surfaces without having to touch every TextStyle in the feature.
class UpGradientScaffoldBody extends StatelessWidget {
  const UpGradientScaffoldBody({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(gradient: kUpPageGradient),
        child: DefaultTextStyle.merge(
          style: GoogleFonts.inter(color: Colors.white),
          child: child,
        ),
      );
}

/// A transparent, Inter-titled app bar with a rounded-square back button —
/// the crypto/joint-funds chrome. Use as `appBar: upAppBar('Title')`.
PreferredSizeWidget upAppBar(String title,
    {List<Widget>? actions, bool showBack = true, VoidCallback? onBack}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    foregroundColor: Colors.white,
    centerTitle: false,
    titleSpacing: showBack ? 0 : 16,
    leading: showBack ? UpBackButton(onTap: onBack) : null,
    leadingWidth: showBack ? 60 : null,
    title: Text(
      title,
      style: GoogleFonts.inter(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
    ),
    actions: actions,
  );
}

/// Rounded-square back button (crypto/joint-funds chrome).
class UpBackButton extends StatelessWidget {
  const UpBackButton({this.onTap, this.icon = Icons.arrow_back, super.key});
  final VoidCallback? onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 12),
        child: GestureDetector(
          onTap: onTap ?? () => Navigator.of(context).maybePop(),
          child: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: kUpCard, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
        ),
      );
}

String upNaira(int kobo, [String currency = 'NGN']) {
  final major = kobo / 100.0;
  final sym = currency == 'NGN' || currency.isEmpty ? '₦' : '$currency ';
  return '$sym${major.toStringAsFixed(2)}';
}

/// Formats a pct×100 equity value (1500 → "15%").
String upPct(int pctTimes100) {
  if (pctTimes100 <= 0) return '';
  final v = pctTimes100 / 100.0;
  return v == v.roundToDouble() ? '${v.toInt()}%' : '${v.toStringAsFixed(2)}%';
}

String upInvestmentTypeLabel(String t) {
  switch (t) {
    case 'equity':
      return 'Equity';
    case 'convertible_note':
      return 'Convertible note';
    case 'revenue_share':
      return 'Revenue share';
    case 'loan':
      return 'Loan';
    case 'grant':
      return 'Grant';
    default:
      return t.isEmpty ? '' : t;
  }
}

String upFundStatusLabel(up.UpliftFundStatus s) {
  switch (s) {
    case up.UpliftFundStatus.UPLIFT_FUND_STATUS_DRAFT:
      return 'Draft';
    case up.UpliftFundStatus.UPLIFT_FUND_STATUS_OPEN:
      return 'Open';
    case up.UpliftFundStatus.UPLIFT_FUND_STATUS_REVIEWING:
      return 'Reviewing';
    case up.UpliftFundStatus.UPLIFT_FUND_STATUS_FUNDING:
      return 'Funding';
    case up.UpliftFundStatus.UPLIFT_FUND_STATUS_COMPLETED:
      return 'Completed';
    case up.UpliftFundStatus.UPLIFT_FUND_STATUS_PAUSED:
      return 'Paused';
    case up.UpliftFundStatus.UPLIFT_FUND_STATUS_CANCELLED:
      return 'Cancelled';
    case up.UpliftFundStatus.UPLIFT_FUND_STATUS_EXPIRED:
      return 'Expired';
    default:
      return 'Unknown';
  }
}

String upAppStatusLabel(up.UpliftApplicationStatus s) {
  return s.name
      .replaceFirst('UPLIFT_APPLICATION_STATUS_', '')
      .toLowerCase()
      .replaceAll('_', ' ');
}


/// True when the fund carries an application deadline that has already passed.
///
/// The server refuses a late application outright, so every surface that
/// offers "Apply" has to withdraw the offer rather than let somebody write a
/// whole pitch and be refused on submit. It lived in uplift_detail_screen.dart
/// and only the detail screen consulted it — the Discover card went on
/// offering Apply on a fund whose window had shut, which is the exact walk
/// into a server-side refusal that the card's own "Your fund" branch exists to
/// prevent.
///
/// Compared in LOCAL time: the deadline arrives as a UTC timestamp, and
/// "has today passed" is a question about the user's clock.
bool upApplicationsClosed(up.UpliftFundMessage f) {
  if (!f.hasApplicationDeadline()) return false;
  return DateTime.now().isAfter(f.applicationDeadline.toDateTime().toLocal());
}

/// True when the fund can still take an application from this user right now.
///
/// NOT the control flow of the Apply surfaces, and the comment here used to
/// claim it was — it had ZERO call sites while saying it was "the single
/// predicate behind every Apply control". Both surfaces branch on the three
/// conditions SEPARATELY, on purpose: each refusal needs its own words ("Your
/// fund", the application's status, "Applications closed"), and collapsing
/// them to one boolean would replace three accurate labels with a missing
/// button and no explanation.
///
/// It survives as the single place the RULE is written down, used by the
/// guard test that pins every Apply surface against it
/// (test/features/uplift_apply_is_gated_test.dart). Keep the two in step: a
/// new condition here is a condition every surface must grow.
bool upCanApply(up.UpliftFundMessage f) =>
    !f.isFunder &&
    f.status == up.UpliftFundStatus.UPLIFT_FUND_STATUS_OPEN &&
    !upApplicationsClosed(f) &&
    !upHasLiveApplication(f);

/// Whether a past application leaves the business free to apply to this fund
/// again. Mirrors `models.UpliftAppReapplyAllowedFrom`, which is the list
/// `ApplyToUpliftFund`'s duplicate guard actually uses.
///
/// `hasApplied` was `myApplicationId.isNotEmpty`, so ANY past application —
/// including one the business withdrew by mistake a minute earlier — replaced
/// the Apply button with a read-only status row permanently, while the server
/// would have accepted a new one. `completed` is not here: a business the fund
/// has already paid does not get a second grant from the same pool.
bool upCanReapply(up.UpliftApplicationStatus s) =>
    s == up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_WITHDRAWN ||
    s == up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_REJECTED ||
    s == up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_DECLINED ||
    s == up.UpliftApplicationStatus.UPLIFT_APPLICATION_STATUS_OFFER_EXPIRED;

/// A live application is one still in play. This, not "a row exists", is what
/// makes the Apply button wrong.
bool upHasLiveApplication(up.UpliftFundMessage f) =>
    f.myApplicationId.isNotEmpty && !upCanReapply(f.myApplicationStatus);

Color upStatusColor(String label) {
  final l = label.toLowerCase();
  if (l.contains('complete') ||
      l.contains('funding') ||
      l.contains('accepted') ||
      l.contains('open')) return kUpSuccess;
  if (l.contains('cancel') ||
      l.contains('reject') ||
      l.contains('expired') ||
      l.contains('declined')) return kUpError;
  if (l.contains('review') ||
      l.contains('submitted') ||
      l.contains('selected') ||
      l.contains('shortlist')) return kUpWarning;
  return kUpTextSecondary;
}

class UpStatusChip extends StatelessWidget {
  const UpStatusChip({required this.label, super.key});
  final String label;
  @override
  Widget build(BuildContext context) {
    final c = upStatusColor(label);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: c.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
        // No outline: the status colour fill carries the meaning on its own.
      ),
      child: Text(label,
          style: GoogleFonts.inter(
              color: c, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}

class UpliftFundCard extends StatelessWidget {
  const UpliftFundCard(
      {required this.fund, this.onTap, this.trailing, super.key});
  final up.UpliftFundMessage fund;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final committed = fund.committedPool.toInt();
    final released = fund.releasedTotal.toInt();
    final progress =
        committed > 0 ? (released / committed).clamp(0.0, 1.0) : 0.0;
    final equity = UpEquityTerms.fromMetadata(fund.metadata);

    // THE IMAGE SITS BESIDE THE FUND, NOT ABOVE IT.
    //
    // A 108px banner plus a stacked title, meta line, equity chip, progress
    // bar and footer made one card about 280px tall, so barely two fit on a
    // phone and browsing meant scrolling past funds rather than comparing
    // them. A 64px square on the left puts the same information in roughly
    // half the height, and the vertical rhythm matches the group-funds list.
    //
    // The banner is not lost — it is the first thing on the detail page, and
    // tapping the thumbnail opens it full screen.
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: kUpCard,
        borderRadius: BorderRadius.circular(14),
        // NO BORDER ON A LISTING ROW. The kUpCard fill against the kUpBg page
        // is a 21-point luminance step and already separates one row from the
        // next; a kUpDivider outline on top of it adds a 14-point box around
        // each one, and stacked down a list those boxes read as a ladder of
        // faint artefacts rather than as structure. The earlier note here
        // argued a flat border beat a translucent hairline — the answer was
        // neither.
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Thumb(fund: fund),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(fund.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700)),
                              ),
                              const SizedBox(width: 8),
                              UpStatusChip(
                                  label: upFundStatusLabel(fund.status)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${fund.category} · up to '
                            '${upNaira(fund.perBusinessCap.toInt(), fund.currency)}'
                            ' · ${fund.targetCount} businesses',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: kUpTextSecondary, fontSize: 12),
                          ),
                          const SizedBox(height: 6),
                          // Equity and the applied count share a line now.
                          // They were two stacked rows saying very little
                          // each, and side by side they read as one fact
                          // about the deal.
                          Row(
                            children: [
                              if (equity.enabled &&
                                  (equity.offeredPct > 0 ||
                                      equity.investmentType.isNotEmpty))
                                Flexible(
                                  child: UpEquityChip(
                                    label: equity.offeredPct > 0
                                        ? '${upInvestmentTypeLabel(equity.investmentType).isEmpty ? 'Equity' : upInvestmentTypeLabel(equity.investmentType)} · ${upPct(equity.offeredPct)}'
                                        : upInvestmentTypeLabel(
                                            equity.investmentType),
                                  ),
                                ),
                              const Spacer(),
                              Text('${fund.applicationCount} applied',
                                  style: const TextStyle(
                                      color: kUpTextSecondary, fontSize: 11)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // The progress bar only says something once money has been
                // committed. On a fresh fund it was a grey line under
                // "₦0.00 released of ₦0.00" — two rows of nothing on every
                // card in the list.
                if (committed > 0) ...[
                  const SizedBox(height: 10),
                  UpProgressBar(value: progress, height: 5),
                  const SizedBox(height: 5),
                  Text(
                    '${upNaira(released, fund.currency)} released of '
                    '${upNaira(committed, fund.currency)}',
                    style: const TextStyle(
                        color: kUpTextSecondary, fontSize: 11),
                  ),
                ],
                if (trailing != null)
                  Align(alignment: Alignment.centerRight, child: trailing!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A network image that survives the upload race.
///
/// THE UPLOAD IS ASYNCHRONOUS AND THE APP RENDERS THE URL IMMEDIATELY.
/// products-gateway answers an upload with **202 Accepted** — "the URL is
/// reserved and the write is in flight" — and hands back the final URL
/// straight away. The picker adds it to the list and the tile asks for it at
/// once, often before the object exists. The request 404s, and Flutter's
/// ImageCache CACHES THE FAILURE: it never asks again, so the tile stays a
/// grey box for the rest of the session even though the file landed a second
/// later.
///
/// That is the whole of the reported "uploading more than one photo fails".
/// Measured in the prod gateway log: every background upload in the session
/// completed on attempt 1. Nothing failed to upload — the app simply looked
/// too early, once, and then stopped looking.
///
/// So on error we EVICT the cache entry and ask again, a few times, with a
/// widening gap. The retries are deliberately short and few: this covers a
/// write that is seconds behind, not a genuinely missing file, which still
/// ends at the placeholder.
class UpRemoteImage extends StatefulWidget {
  const UpRemoteImage({
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.fallback,
    super.key,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  /// Shown once the retries are exhausted. A missing image should look
  /// deliberate, not broken.
  final Widget? fallback;

  @override
  State<UpRemoteImage> createState() => _UpRemoteImageState();
}

class _UpRemoteImageState extends State<UpRemoteImage> {
  static const _delays = [
    Duration(milliseconds: 700),
    Duration(seconds: 2),
    Duration(seconds: 4),
  ];

  int _attempt = 0;
  bool _givenUp = false;

  /// A retry is already waiting. WITHOUT THIS THE LIST FLICKERS.
  ///
  /// `errorBuilder` runs on EVERY build of a failing image, not once per
  /// failure. It called _retry() each time, and _retry() scheduled a timer
  /// each time — so one broken thumbnail in a list of funds queued a new
  /// timer on every rebuild, each of which evicted the cache and called
  /// setState, which caused the next rebuild. The list rebuilt continuously
  /// for as long as any cover failed to load.
  bool _retryPending = false;

  /// Cancellable, so a retry cannot fire into a disposed State after the user
  /// has scrolled the row away.
  Timer? _retryTimer;

  @override
  void didUpdateWidget(covariant UpRemoteImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // A different URL is a different question — start it fresh rather than
    // inheriting the previous one's exhausted attempts.
    if (oldWidget.url != widget.url) {
      _retryTimer?.cancel();
      _retryTimer = null;
      _retryPending = false;
      _attempt = 0;
      _givenUp = false;
    }
  }

  @override
  void dispose() {
    _retryTimer?.cancel();
    super.dispose();
  }

  /// Called FROM BUILD, so it must never call setState synchronously.
  ///
  /// The old version did exactly that on the give-up branch — setState during
  /// the build phase, which Flutter either asserts on or services by
  /// scheduling another build, and that build hit the same errorBuilder. The
  /// state change is deferred to after the frame instead.
  void _retry() {
    if (_givenUp || _retryPending) return;
    if (_attempt >= _delays.length) {
      _retryPending = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() {
          _givenUp = true;
          _retryPending = false;
        });
      });
      return;
    }
    _retryPending = true;
    _retryTimer = Timer(_delays[_attempt], () async {
      if (!mounted) return;
      // Evicting is the point: without it the cached failure answers every
      // subsequent request and the retry is a no-op.
      await NetworkImage(widget.url).evict();
      if (!mounted) return;
      setState(() {
        _attempt++;
        _retryPending = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final fallback = widget.fallback ??
        Container(
          width: widget.width,
          height: widget.height,
          color: kUpDivider,
          child: const Icon(Icons.image_not_supported_outlined,
              color: kUpTextSecondary, size: 18),
        );
    if (_givenUp) return fallback;
    return Image.network(
      widget.url,
      // The key forces a fresh ImageProvider each attempt; without it the
      // element is reused and the evicted entry is never re-requested.
      key: ValueKey('${widget.url}#$_attempt'),
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      errorBuilder: (_, __, ___) {
        _retry();
        return fallback;
      },
    );
  }
}

/// The fund's cover as a square thumbnail, or its initials when it has none.
///
/// Tapping opens the image full screen — the banner it replaced was the only
/// place a fund's cover could be seen at any size, and shrinking it without
/// giving it back would have lost something real.
class _Thumb extends StatelessWidget {
  const _Thumb({required this.fund});
  final up.UpliftFundMessage fund;

  @override
  Widget build(BuildContext context) {
    if (fund.coverImageUrl.isEmpty) {
      return UpGradientAvatar(text: fund.title, size: 64);
    }
    return GestureDetector(
      // Opaque so the tap lands here and not on the card's InkWell behind it:
      // tapping the picture should show the picture, not open the fund.
      behavior: HitTestBehavior.opaque,
      onTap: () => showUpliftImageViewer(
          context, fund.coverImageUrl, fund.title),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: UpRemoteImage(
          url: fund.coverImageUrl,
          width: 64,
          height: 64,
          fallback: UpGradientAvatar(text: fund.title, size: 64),
        ),
      ),
    );
  }
}

/// Full-screen image viewer: pinch to zoom, tap or swipe down to dismiss.
///
/// Used by the fund card thumbnail and the detail page's gallery, so an image
/// is never a decoration the user cannot actually look at.
Future<void> showUpliftImageViewer(
    BuildContext context, String url, String title) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.92),
    builder: (ctx) => Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: Text(title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(fontSize: 15)),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => Navigator.of(ctx).pop(),
        child: Center(
          child: InteractiveViewer(
            minScale: 1,
            maxScale: 4,
            child: UpRemoteImage(
              url: url,
              fit: BoxFit.contain,
              fallback: const Padding(
                padding: EdgeInsets.all(24),
                child: Text('This image could not be loaded.',
                    style: TextStyle(color: kUpTextSecondary)),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

/// A media row: shows thumbnails of attached image URLs plus a "pick & upload"
/// tile. Picked images are uploaded to storage-service via the products-gateway
/// (POST /api/v1/uplifts/upload-image) and the returned public URL is added to
/// the list — the same URL is persisted on the record and rendered on detail
/// pages. Upload is non-blocking to the parent form; failures surface a
/// friendly SnackBar and leave the form usable.
class UpliftImagePickerRow extends StatefulWidget {
  const UpliftImagePickerRow({
    required this.urls,
    required this.onAdd,
    required this.onRemove,
    this.label = 'Photos',
    this.maxItems = 3,
    this.allowDocuments = false,
    this.onUploadingChanged,
    super.key,
  });

  /// Fires while an upload is in flight.
  ///
  /// The parent needs this to disable its submit button. Without it a user
  /// could tap Submit mid-upload and the form would post with the URL missing —
  /// the attachment silently absent from an application that looked like it
  /// sent. Most visible with a 100MB video, which takes minutes.
  final ValueChanged<bool>? onUploadingChanged;
  final List<String> urls;
  final ValueChanged<String> onAdd;
  final ValueChanged<String> onRemove;
  final String label;

  /// How many attachments this row accepts. Admin-tunable — the call sites
  /// read it from FeatureFlags rather than hardcoding a number here.
  ///
  /// The row had NO limit: a fund gallery or an application could carry as
  /// many files as the user had patience for, each one a real object in
  /// storage, and the funder's detail page then tried to render all of them.
  final int maxItems;

  /// Offer PDFs alongside photos.
  ///
  /// The uploader has accepted documents all along — `uploadImage` takes an
  /// `allowDocuments` flag and has the error copy written for it — but every
  /// call site used ImagePicker, which can only return images. So a business
  /// could never attach the pitch deck the funder's screen already renders a
  /// section for, and milestone evidence could not be an invoice.
  final bool allowDocuments;

  @override
  State<UpliftImagePickerRow> createState() => _UpliftImagePickerRowState();
}

class _UpliftImagePickerRowState extends State<UpliftImagePickerRow> {
  final _picker = ImagePicker();
  final _uploader = UpliftMediaUploadService();
  bool _uploading = false;

  /// Pick a PDF and upload it.
  ///
  /// Separate from the image path because the two need different pickers and
  /// different upload flags — folding them together would mean guessing the
  /// kind from the extension after the fact.
  Future<void> _pickDocumentAndUpload() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['pdf'],
        withData: false,
      );
      final path = result?.files.single.path;
      if (path == null) return;
      setState(() => _uploading = true);
      widget.onUploadingChanged?.call(true);
      final url = await _uploader.uploadImage(File(path), allowDocuments: true);
      widget.onAdd(url);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(upFriendlyError(e)), backgroundColor: kUpError),
        );
      }
    } finally {
      if (mounted) setState(() => _uploading = false);
      widget.onUploadingChanged?.call(false);
    }
  }

  Future<void> _pickAndUpload(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(
          source: source, maxWidth: 1600, imageQuality: 82);
      if (picked == null) return;
      setState(() => _uploading = true);
      widget.onUploadingChanged?.call(true);
      final url = await _uploader.uploadImage(File(picked.path));
      widget.onAdd(url);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(upFriendlyError(e)), backgroundColor: kUpError),
        );
      }
    } finally {
      if (mounted) setState(() => _uploading = false);
      widget.onUploadingChanged?.call(false);
    }
  }

  bool get _atLimit => widget.urls.length >= widget.maxItems;

  void _chooseSource() {
    if (_atLimit) {
      // Reached only if the tile is tapped between a successful upload and
      // the parent's setState; the tile itself is hidden at the limit.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'You can attach up to ${widget.maxItems} ${widget.maxItems == 1 ? "file" : "files"} here. '
              'Remove one to add another.'),
          backgroundColor: kUpCard,
        ),
      );
      return;
    }
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: kUpCard,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.white),
              title: const Text('Choose from gallery',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(ctx);
                _pickAndUpload(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.white),
              title: const Text('Take a photo',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(ctx);
                _pickAndUpload(ImageSource.camera);
              },
            ),
            if (widget.allowDocuments)
              ListTile(
                leading: const Icon(Icons.picture_as_pdf, color: Colors.white),
                title: const Text('Attach a PDF',
                    style: TextStyle(color: Colors.white)),
                subtitle: const Text('Pitch deck, financials, CAC certificate',
                    style: TextStyle(color: kUpTextSecondary, fontSize: 12)),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickDocumentAndUpload();
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: const TextStyle(color: kUpTextSecondary, fontSize: 12)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final u in widget.urls)
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    // A PDF gets a document tile, not Image.network — which
                    // would fail to decode it and draw a broken-image glyph on
                    // an upload that succeeded.
                    child: _isPdfUrl(u)
                        ? Container(
                            width: 72,
                            height: 72,
                            color: kUpDivider,
                            child: const Icon(Icons.picture_as_pdf,
                                color: Colors.white70),
                          )
                        // UpRemoteImage, because this tile is rendered the
                        // instant the upload returns 202 and the object may
                        // be a second behind. A plain Image.network asks once,
                        // caches the 404 and leaves a grey square forever —
                        // which is what "uploading more than one photo fails"
                        // actually was.
                        : UpRemoteImage(
                            url: u,
                            width: 72,
                            height: 72,
                            fallback: Container(
                                width: 72,
                                height: 72,
                                color: kUpDivider,
                                child: const Icon(Icons.broken_image,
                                    color: kUpTextSecondary))),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: () => widget.onRemove(u),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.black54, shape: BoxShape.circle),
                        child: const Icon(Icons.close,
                            size: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            if (!_atLimit)
              GestureDetector(
                onTap: _uploading ? null : _chooseSource,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                      // The kUpCard fill is the target; an outline on top of
                      // it is the same faint box as on the listing rows.
                      color: kUpCard,
                      borderRadius: BorderRadius.circular(8)),
                  child: _uploading
                      ? const Center(
                          child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: kUpPrimary)))
                      : const Icon(Icons.add_a_photo, color: kUpTextSecondary),
                ),
              ),
          ],
        ),
        // The limit is stated before it is hit, not discovered by hitting it.
        const SizedBox(height: 6),
        Text(
          _atLimit
              ? 'Maximum of ${widget.maxItems} reached — remove one to add another.'
              // "0 of 3" reads like a checklist with three boxes to tick.
              // These attachments are OPTIONAL and the number is a ceiling,
              // so say so: nothing here is required to submit.
              : widget.urls.isEmpty
                  ? 'Optional · up to ${widget.maxItems}'
                  : '${widget.urls.length} added · up to ${widget.maxItems}',
          style: TextStyle(
            color: _atLimit ? kUpWarning : kUpTextSecondary,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class UpliftApplicationCard extends StatelessWidget {
  const UpliftApplicationCard(
      {required this.application, this.onTap, this.trailing, super.key});
  final up.UpliftApplicationMessage application;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final a = application;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: kUpCard,
        borderRadius: BorderRadius.circular(14),
        // No outline — same rule as the fund rows above.
        boxShadow: const [
          BoxShadow(
              color: Color(0x14000000), blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    UpGradientAvatar(text: a.businessName, size: 36, radius: 9),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(a.businessName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 8),
                    UpStatusChip(label: upAppStatusLabel(a.status)),
                  ],
                ),
                const SizedBox(height: 4),
                if (a.fundTitle.isNotEmpty)
                  Text(a.fundTitle,
                      style: GoogleFonts.inter(
                          color: kUpTextSecondary, fontSize: 12)),
                const SizedBox(height: 6),
                Text(
                  'Requested ${upNaira(a.requestedAmount.toInt(), a.currency)}'
                  '${a.approvedAmount.toInt() > 0 ? ' · Approved ${upNaira(a.approvedAmount.toInt(), a.currency)}' : ''}',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                // What the business actually attached.
                //
                // A funder scanning a list of applications had no way to see
                // which ones came with a pitch video or a deck — the richest
                // signals were invisible until the detail screen, so the
                // applications that made the most effort read the same as the
                // ones that made none.
                if (a.videoUrl.isNotEmpty || a.docUrls.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Wrap(spacing: 6, runSpacing: 6, children: [
                    if (a.videoUrl.isNotEmpty)
                      const UpAttachmentChip(
                          label: 'Pitch video',
                          icon: Icons.play_circle_outline),
                    if (a.docUrls.isNotEmpty)
                      UpAttachmentChip(
                          label: a.docUrls.length == 1
                              ? '1 document'
                              : '${a.docUrls.length} documents',
                          icon: Icons.description_outlined),
                  ]),
                ],
                if (a.agreedEquityPct > 0 || a.proposedEquityPct > 0) ...[
                  const SizedBox(height: 6),
                  Wrap(spacing: 6, runSpacing: 6, children: [
                    if (a.agreedEquityPct > 0)
                      UpEquityChip(
                          label:
                              '${upInvestmentTypeLabel(a.investmentType).isEmpty ? 'Equity' : upInvestmentTypeLabel(a.investmentType)} · ${upPct(a.agreedEquityPct)}'),
                    if (a.agreedEquityPct == 0 && a.proposedEquityPct > 0)
                      UpEquityChip(
                          label: 'Proposes ${upPct(a.proposedEquityPct)}',
                          icon: Icons.handshake),
                  ]),
                ],
                if (a.hasCounter)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: UpEquityChip(
                      icon: Icons.swap_horiz,
                      label:
                          'Counter: ${upNaira(a.counterAmount.toInt(), a.currency)}${a.counterEquityPct > 0 ? ' · ${upPct(a.counterEquityPct)}' : ''}',
                    ),
                  ),
                if (a.endorsementCount > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text('❤ ${a.endorsementCount} endorsements',
                        style: const TextStyle(
                            color: kUpTextSecondary, fontSize: 11)),
                  ),
                if (trailing != null)
                  Align(alignment: Alignment.centerRight, child: trailing!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Shared building blocks — the crypto / joint-funds visual language.
// ─────────────────────────────────────────────────────────────────────────

/// A gradient avatar (rounded square) with the first initial — mirrors the
/// group-funds group avatar and the crypto asset avatar.
class UpGradientAvatar extends StatelessWidget {
  const UpGradientAvatar(
      {required this.text, this.size = 40, this.radius = 10, super.key});
  final String text;
  final double size;
  final double radius;
  @override
  Widget build(BuildContext context) {
    final initial = text.trim().isNotEmpty ? text.trim()[0].toUpperCase() : 'L';
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: kUpAccentGradient,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Text(
        initial,
        style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: size * 0.45),
      ),
    );
  }
}

/// Rounded contribution/progress meter — grey track + purple (or status) fill.
class UpProgressBar extends StatelessWidget {
  const UpProgressBar(
      {required this.value,
      this.color = kUpPrimary,
      this.height = 8,
      super.key});
  final double value; // 0..1
  final Color color;
  final double height;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: LinearProgressIndicator(
        value: value.clamp(0.0, 1.0),
        backgroundColor: kUpDivider,
        color: color,
        minHeight: height,
      ),
    );
  }
}

/// Standard dark surface card (kUpCard + divider border + subtle shadow).
class UpCard extends StatelessWidget {
  const UpCard(
      {required this.child,
      this.padding = const EdgeInsets.all(16),
      this.margin,
      this.radius = 14,
      this.borderColor,
      super.key});
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: kUpCard,
          borderRadius: BorderRadius.circular(radius),
          // Bordered only when a caller asks for one. Every card carried a
          // 1px kUpDivider rule by default, which on a dark surface against a
          // dark page reads as an artefact rather than an edge — and when
          // cards stack, as they do down this detail page, it draws a ladder
          // of faint lines. The fill plus the shadow already separate a card
          // from the page; an explicit borderColor is still honoured for the
          // few places where the outline MEANS something.
          border:
              borderColor == null ? null : Border.all(color: borderColor!),
          boxShadow: const [
            BoxShadow(
                color: Color(0x14000000), blurRadius: 6, offset: Offset(0, 2)),
          ],
        ),
        child: child,
      );
}

/// A compact stat tile (icon + value + label) tinted by [color] — the
/// crypto/group-funds stat-strip motif.
class UpStatChip extends StatelessWidget {
  const UpStatChip(
      {required this.icon,
      required this.value,
      required this.label,
      this.color = kUpPrimary,
      super.key});
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  // NO OUTLINE. A 1px rule at 25% opacity around an already-tinted fill is
  // the "tiny borders" in the report: at phone density it reads as a
  // rendering artefact rather than an edge, and the tint alone already
  // separates the chip from the page. Dropping it also stops four chips in a
  // row looking like a table.
  //
  // Laid out to survive being STRETCHED: these now sit in Expanded on a 2x2
  // grid rather than hugging their content, so the value and label must
  // ellipsise instead of overflowing when a number is long.
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                Text(label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        color: kUpTextSecondary, fontSize: 10)),
              ],
            ),
          ),
        ]),
      );
}

/// Section header (title + optional trailing action).
class UpSectionHeader extends StatelessWidget {
  const UpSectionHeader({required this.title, this.trailing, super.key});
  final String title;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
            if (trailing != null) trailing!,
          ],
        ),
      );
}

/// Full-height empty state (muted icon + title + subtitle).
class UpEmptyState extends StatelessWidget {
  const UpEmptyState(
      {required this.icon,
      required this.title,
      this.subtitle,
      this.action,
      super.key});
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? action;
  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: kUpTextSecondary),
              const SizedBox(height: 16),
              Text(title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
              if (subtitle != null) ...[
                const SizedBox(height: 8),
                Text(subtitle!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        color: kUpTextSecondary, fontSize: 14)),
              ],
              if (action != null) ...[const SizedBox(height: 16), action!],
            ],
          ),
        ),
      );
}

/// Full-height error state with a Retry action.
/// Polished error surface — a soft card with a tinted icon badge, a friendly
/// title, the (already-sanitised) message and a filled retry action. Used for
/// full-screen failures across the Lazerfunds tabs.
class UpErrorState extends StatelessWidget {
  const UpErrorState({
    required this.message,
    this.onRetry,
    this.title = 'Something went wrong',
    super.key,
  });
  final String message;
  final String title;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              decoration: BoxDecoration(
                color: kUpCard,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kUpError.withOpacity(0.12),
                    ),
                    child: const Icon(Icons.wifi_tethering_error_rounded,
                        size: 30, color: kUpError),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        color: kUpTextSecondary, fontSize: 13.5, height: 1.4),
                  ),
                  if (onRetry != null) ...[
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: onRetry,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kUpPrimary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        icon: const Icon(Icons.refresh_rounded,
                            size: 18, color: Colors.white),
                        label: Text('Try again',
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
}

/// Centered purple loader.
class UpLoading extends StatelessWidget {
  const UpLoading({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator(color: kUpPrimary));
}

/// Group-funds style pill/segmented tabs. Wraps the ambient [DefaultTabController]
/// so callers just pass the tab widgets. Accent pill indicator on a dark surface.
class UpSegmentedTabs extends StatelessWidget {
  const UpSegmentedTabs(
      {required this.tabs,
      this.margin = const EdgeInsets.fromLTRB(16, 8, 16, 4),
      super.key});
  final List<Widget> tabs;
  final EdgeInsetsGeometry margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: kUpCard, borderRadius: BorderRadius.circular(12)),
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
            color: kUpPrimary, borderRadius: BorderRadius.circular(12)),
        labelColor: Colors.white,
        unselectedLabelColor: kUpTextSecondary,
        labelStyle:
            GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
        unselectedLabelStyle:
            GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
        dividerColor: Colors.transparent,
        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
        splashBorderRadius: BorderRadius.circular(12),
        tabs: tabs,
      ),
    );
  }
}

/// Insurance-style step indicator: an animated linear bar + expanding dots.
/// Bar turns green on the final step. [current] is 0-based.
class UpStepIndicator extends StatelessWidget {
  const UpStepIndicator(
      {required this.current, required this.total, super.key});
  final int current;
  final int total;
  @override
  Widget build(BuildContext context) {
    final isLast = current == total - 1;
    final progress = total <= 0 ? 0.0 : (current + 1) / total;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Stack(
              children: [
                Container(height: 4, color: Colors.white.withOpacity(0.1)),
                LayoutBuilder(
                  builder: (ctx, c) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 4,
                    width: c.maxWidth * progress,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isLast
                            ? const [kUpSuccess, Color(0xFF059669)]
                            : const [kUpPrimarySoft, kUpPrimary],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(total, (i) {
              final active = i == current;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: active ? 22 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color:
                      active ? kUpPrimarySoft : Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

/// Insurance-style bottom flow bar: optional outlined Back + a primary CTA with
/// WHITE text on the accent gradient (green on the last step). Fixed to the
/// bottom with a top divider + SafeArea.
class UpBottomNav extends StatelessWidget {
  const UpBottomNav({
    required this.onNext,
    required this.nextLabel,
    this.onBack,
    this.isLast = false,
    this.loading = false,
    super.key,
  });
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final String nextLabel;
  final bool isLast;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: kUpBg,
        border: Border(top: BorderSide(color: kUpDivider)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (onBack != null) ...[
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(52),
                    side: const BorderSide(color: kUpDivider),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: loading ? null : onBack,
                  child: Text('Back',
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              flex: onBack != null ? 1 : 1,
              child: Opacity(
                opacity: onNext == null ? 0.5 : 1,
                child: GestureDetector(
                  onTap: (loading || onNext == null) ? null : onNext,
                  child: Container(
                    height: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isLast
                            ? const [kUpSuccess, Color(0xFF059669)]
                            : const [kUpPrimarySoft, kUpPrimary],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: loading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(nextLabel,
                                  style: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white)),
                              const SizedBox(width: 8),
                              Icon(
                                  isLast
                                      ? Icons.check_circle
                                      : Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 18),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Crypto-style "Recent activity" card: header + View all, up to 3 receipt rows,
/// or an empty state. Rows show a tinted leading icon, title + date, amount + type.
class UpRecentActivitySection extends StatelessWidget {
  const UpRecentActivitySection(
      {required this.receipts, required this.onViewAll, this.onTap, super.key});
  final List<up.UpliftReceiptMessage> receipts;
  final VoidCallback onViewAll;
  final void Function(up.UpliftReceiptMessage)? onTap;

  @override
  Widget build(BuildContext context) {
    final shown = receipts.take(3).toList();
    return UpCard(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 20),
      radius: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UpSectionHeader(
            title: 'Recent activity',
            trailing: receipts.isEmpty
                ? null
                : GestureDetector(
                    onTap: onViewAll,
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Text('View all',
                          style: GoogleFonts.inter(
                              color: kUpTextSecondary,
                              fontSize: 13,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_ios,
                          color: kUpTextSecondary, size: 12),
                    ]),
                  ),
          ),
          const SizedBox(height: 8),
          if (shown.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Column(children: [
                  Icon(Icons.receipt_long,
                      size: 36, color: Colors.white.withOpacity(0.25)),
                  const SizedBox(height: 8),
                  Text('No activity yet',
                      style: GoogleFonts.inter(
                          color: kUpTextSecondary, fontSize: 13)),
                ]),
              ),
            )
          else
            for (int i = 0; i < shown.length; i++)
              Padding(
                padding: EdgeInsets.only(bottom: i < shown.length - 1 ? 10 : 0),
                child: _row(shown[i]),
              ),
        ],
      ),
    );
  }

  Widget _row(up.UpliftReceiptMessage r) {
    final isRelease = r.referenceType == 'milestone_release';
    final color = isRelease ? kUpSuccess : kUpPrimarySoft;
    final title = isRelease ? 'Funding received' : 'Pool refund';
    return GestureDetector(
      onTap: onTap == null ? null : () => onTap!(r),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: color.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(9)),
              child: Icon(isRelease ? Icons.south_west : Icons.reply,
                  color: color, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(r.fundTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                            color: kUpTextSecondary, fontSize: 12)),
                  ]),
            ),
            Text(upNaira(r.amount.toInt(), r.currency),
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

/// True when a stored media URL points at a PDF rather than an image.
///
/// Compared on the path only: a signed or query-stringed URL still ends in
/// `.pdf` before the `?`, and matching the whole string would miss it.
bool _isPdfUrl(String url) {
  final path = Uri.tryParse(url)?.path ?? url;
  return path.toLowerCase().endsWith('.pdf');
}

/// Public form of [_isPdfUrl] for screens that render stored media.
bool upIsPdfUrl(String url) => _isPdfUrl(url);

/// Founder pitch video picker — one video, replaceable.
///
/// Not a list. A funder deciding on an investment watches one pitch; offering a
/// gallery is a way to avoid making one. Picking again replaces rather than
/// appends, so the control always reflects what the funder will actually see.
/// A PITCH CAN BE A LINK, NOT ONLY AN UPLOAD.
///
/// `video_url` has always been a plain string, so a pasted link needs no
/// contract change — but everything that READ it assumed our storage and
/// handed it to a video player, which cannot play a YouTube, Loom or Drive
/// page. A founder who already has a pitch hosted somewhere had to re-upload
/// it as a file, and a 64MB ceiling means plenty of them could not.
///
/// So the question every reader asks first is which kind of thing this is.
/// Ours gets the inline player; anything else gets a link tile that opens in
/// the browser, which is honest about what it is rather than failing to play.
bool upIsHostedMedia(String url) {
  final u = url.trim().toLowerCase();
  if (u.isEmpty) return false;
  // Our storage service serves every uploaded object under this path. Matched
  // on the PATH rather than the host so it keeps working behind the tunnel,
  // in dev, and if the domain ever moves.
  return u.contains('/v1/storage/objects/');
}

/// Whether [url] is something we are willing to store in `video_url` at all.
///
/// http/https only: a `javascript:` or `data:` URL in a field that other
/// people's devices will open is not a pitch, and the funder is the one who
/// would tap it.
bool upIsAcceptablePitchLink(String url) {
  final u = url.trim();
  if (u.isEmpty) return false;
  final parsed = Uri.tryParse(u);
  if (parsed == null) return false;
  // host, not hasAuthority: Dart reports hasAuthority == true for a bare
  // "https://", which names nothing. The server checks u.Host for the same
  // reason, and the two must agree or the app accepts a link the RPC refuses.
  if (parsed.host.isEmpty) return false;
  return parsed.scheme == 'http' || parsed.scheme == 'https';
}

class UpliftVideoPickerRow extends StatefulWidget {
  const UpliftVideoPickerRow({
    required this.url,
    required this.onChanged,
    this.label = 'Pitch video (optional)',
    this.onUploadingChanged,
    super.key,
  });

  /// See UpliftImagePickerRow.onUploadingChanged — matters most here, because a
  /// pitch video upload runs for minutes.
  final ValueChanged<bool>? onUploadingChanged;

  final String url;
  final ValueChanged<String> onChanged;
  final String label;

  @override
  State<UpliftVideoPickerRow> createState() => _UpliftVideoPickerRowState();
}

class _UpliftVideoPickerRowState extends State<UpliftVideoPickerRow> {
  final _picker = ImagePicker();
  final _uploader = UpliftMediaUploadService();
  bool _uploading = false;

  Future<void> _pick(ImageSource source) async {
    try {
      final picked = await _picker.pickVideo(
        source: source,
        // Capped at the source rather than validated after upload: a merchant
        // on mobile data should not send 80MB before being told it is too long.
        maxDuration: const Duration(minutes: 3),
      );
      if (picked == null) return;
      setState(() => _uploading = true);
      widget.onUploadingChanged?.call(true);
      final url = await _uploader.uploadVideo(File(picked.path));
      widget.onChanged(url);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(upFriendlyError(e)), backgroundColor: kUpError),
        );
      }
    } finally {
      if (mounted) setState(() => _uploading = false);
      widget.onUploadingChanged?.call(false);
    }
  }

  void _chooseSource() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: kUpCard,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.video_library, color: Colors.white),
              title: const Text('Choose a video',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(ctx);
                _pick(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.videocam, color: Colors.white),
              title: const Text('Record a pitch',
                  style: TextStyle(color: Colors.white)),
              subtitle: const Text('Up to 3 minutes',
                  style: TextStyle(color: kUpTextSecondary, fontSize: 12)),
              onTap: () {
                Navigator.pop(ctx);
                _pick(ImageSource.camera);
              },
            ),
            if (widget.url.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.delete_outline, color: kUpError),
                title: const Text('Remove video',
                    style: TextStyle(color: kUpError)),
                onTap: () {
                  Navigator.pop(ctx);
                  widget.onChanged('');
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final has = widget.url.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: const TextStyle(color: kUpTextSecondary, fontSize: 12)),
        const SizedBox(height: 8),
        InkWell(
          onTap: _uploading ? null : _chooseSource,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: kUpCard,
              borderRadius: BorderRadius.circular(12),
              // The purple edge MEANS "a file is attached" — the only place
              // that fact is shown on this row. The empty state gets no
              // outline at all, rather than the kUpDivider hairline, which
              // was decoration pretending to be a state.
              border: has ? Border.all(color: kUpPrimary) : null,
            ),
            child: Row(
              children: [
                if (_uploading)
                  const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: kUpPrimary))
                else
                  Icon(has ? Icons.check_circle : Icons.videocam_outlined,
                      color: has ? kUpPrimary : kUpTextSecondary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _uploading
                        ? 'Uploading your pitch…'
                        : has
                            ? 'Pitch video attached — tap to change'
                            : 'Add a short pitch video',
                    style: TextStyle(
                        color: has ? Colors.white : kUpTextSecondary,
                        fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// A small "what's attached" marker on an application card.
///
/// Deliberately quieter than [UpEquityChip]: equity is a term of the deal, an
/// attachment is a hint to open the application. Same shape so the row reads as
/// one set of tags rather than two competing styles.
class UpAttachmentChip extends StatelessWidget {
  const UpAttachmentChip({required this.label, required this.icon, super.key});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: kUpDivider,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: kUpTextSecondary),
          const SizedBox(width: 4),
          Text(label,
              style: const TextStyle(color: kUpTextSecondary, fontSize: 11)),
        ],
      ),
    );
  }
}
