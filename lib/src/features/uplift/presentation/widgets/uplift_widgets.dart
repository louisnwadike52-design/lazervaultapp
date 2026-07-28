import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grpc/grpc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazervault/src/features/uplift/data/uplift_media_upload_service.dart';
import 'package:lazervault/src/generated/uplift.pbgrpc.dart' as up;

/// Fund-level equity terms live in the fund's opaque `metadata` JSON so no
/// proto change was needed on the fund. Shape:
/// {"equity_enabled":true,"investment_type":"equity","equity_offered_pct":1500,
///  "valuation":<kobo>,"equity_terms":"..."}
class UpEquityTerms {
  const UpEquityTerms({this.enabled = false, this.investmentType = '', this.offeredPct = 0, this.valuation = 0, this.terms = ''});
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
  const UpEquityChip({required this.label, this.icon = Icons.pie_chart, super.key});
  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: kUpPrimary.withOpacity(0.16),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: kUpPrimarySoft.withOpacity(0.4)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 12, color: kUpPrimarySoft),
          const SizedBox(width: 4),
          Text(label, style: GoogleFonts.inter(color: kUpPrimarySoft, fontSize: 11, fontWeight: FontWeight.w600)),
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
const Color kUpPrimary = Color.fromARGB(255, 78, 3, 208); // #4E03D0 — crypto/joint-funds accent
const Color kUpPrimarySoft = Color(0xFF7C3AED);
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

Color upStatusColor(String label) {
  final l = label.toLowerCase();
  if (l.contains('complete') || l.contains('funding') || l.contains('accepted') || l.contains('open')) return kUpSuccess;
  if (l.contains('cancel') || l.contains('reject') || l.contains('expired') || l.contains('declined')) return kUpError;
  if (l.contains('review') || l.contains('submitted') || l.contains('selected') || l.contains('shortlist')) return kUpWarning;
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
        border: Border.all(color: c.withOpacity(0.4)),
      ),
      child: Text(label,
          style: GoogleFonts.inter(color: c, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}

class UpliftFundCard extends StatelessWidget {
  const UpliftFundCard({required this.fund, this.onTap, this.trailing, super.key});
  final up.UpliftFundMessage fund;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final committed = fund.committedPool.toInt();
    final released = fund.releasedTotal.toInt();
    final progress = committed > 0 ? (released / committed).clamp(0.0, 1.0) : 0.0;
    final equity = UpEquityTerms.fromMetadata(fund.metadata);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: kUpCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kUpPrimary.withOpacity(0.18)),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (fund.coverImageUrl.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(fund.coverImageUrl, height: 108, width: double.infinity, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const SizedBox.shrink()),
                  ),
                if (fund.coverImageUrl.isNotEmpty) const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (fund.coverImageUrl.isEmpty) ...[
                      UpGradientAvatar(text: fund.title, size: 40),
                      const SizedBox(width: 10),
                    ],
                    Expanded(
                      child: Text(fund.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 8),
                    Padding(padding: const EdgeInsets.only(top: 1), child: UpStatusChip(label: upFundStatusLabel(fund.status))),
                  ],
                ),
                const SizedBox(height: 6),
                Text('${fund.category} · up to ${upNaira(fund.perBusinessCap.toInt(), fund.currency)} each · ${fund.targetCount} businesses',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: kUpTextSecondary, fontSize: 12)),
                if (equity.enabled && (equity.offeredPct > 0 || equity.investmentType.isNotEmpty)) ...[
                  const SizedBox(height: 8),
                  Row(children: [
                    UpEquityChip(
                      label: equity.offeredPct > 0
                          ? '${upInvestmentTypeLabel(equity.investmentType).isEmpty ? 'Equity' : upInvestmentTypeLabel(equity.investmentType)} · ${upPct(equity.offeredPct)}'
                          : upInvestmentTypeLabel(equity.investmentType),
                    ),
                  ]),
                ],
                const SizedBox(height: 10),
              UpProgressBar(value: progress),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${upNaira(released, fund.currency)} released of ${upNaira(committed, fund.currency)}',
                      style: const TextStyle(color: kUpTextSecondary, fontSize: 11)),
                  Text('${fund.applicationCount} applied', style: const TextStyle(color: kUpTextSecondary, fontSize: 11)),
                ],
              ),
                if (trailing != null) Align(alignment: Alignment.centerRight, child: trailing!),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
    super.key,
  });
  final List<String> urls;
  final ValueChanged<String> onAdd;
  final ValueChanged<String> onRemove;
  final String label;

  @override
  State<UpliftImagePickerRow> createState() => _UpliftImagePickerRowState();
}

class _UpliftImagePickerRowState extends State<UpliftImagePickerRow> {
  final _picker = ImagePicker();
  final _uploader = UpliftMediaUploadService();
  bool _uploading = false;

  Future<void> _pickAndUpload(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(source: source, maxWidth: 1600, imageQuality: 82);
      if (picked == null) return;
      setState(() => _uploading = true);
      final url = await _uploader.uploadImage(File(picked.path));
      widget.onAdd(url);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(upFriendlyError(e)), backgroundColor: kUpError),
        );
      }
    } finally {
      if (mounted) setState(() => _uploading = false);
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
              leading: const Icon(Icons.photo_library, color: Colors.white),
              title: const Text('Choose from gallery', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(ctx);
                _pickAndUpload(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.white),
              title: const Text('Take a photo', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(ctx);
                _pickAndUpload(ImageSource.camera);
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
        Text(widget.label, style: const TextStyle(color: kUpTextSecondary, fontSize: 12)),
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
                    child: Image.network(u, width: 72, height: 72, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                            width: 72, height: 72, color: kUpDivider, child: const Icon(Icons.broken_image, color: kUpTextSecondary))),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: () => widget.onRemove(u),
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                        child: const Icon(Icons.close, size: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            GestureDetector(
              onTap: _uploading ? null : _chooseSource,
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(color: kUpCard, borderRadius: BorderRadius.circular(8), border: Border.all(color: kUpDivider)),
                child: _uploading
                    ? const Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: kUpPrimary)))
                    : const Icon(Icons.add_a_photo, color: kUpTextSecondary),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class UpliftApplicationCard extends StatelessWidget {
  const UpliftApplicationCard({required this.application, this.onTap, this.trailing, super.key});
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
        border: Border.all(color: kUpDivider),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 6, offset: Offset(0, 2)),
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
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(width: 8),
                  UpStatusChip(label: upAppStatusLabel(a.status)),
                ],
              ),
              const SizedBox(height: 4),
              if (a.fundTitle.isNotEmpty)
                Text(a.fundTitle, style: GoogleFonts.inter(color: kUpTextSecondary, fontSize: 12)),
              const SizedBox(height: 6),
              Text(
                'Requested ${upNaira(a.requestedAmount.toInt(), a.currency)}'
                '${a.approvedAmount.toInt() > 0 ? ' · Approved ${upNaira(a.approvedAmount.toInt(), a.currency)}' : ''}',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              if (a.agreedEquityPct > 0 || a.proposedEquityPct > 0) ...[
                const SizedBox(height: 6),
                Wrap(spacing: 6, runSpacing: 6, children: [
                  if (a.agreedEquityPct > 0)
                    UpEquityChip(label: '${upInvestmentTypeLabel(a.investmentType).isEmpty ? 'Equity' : upInvestmentTypeLabel(a.investmentType)} · ${upPct(a.agreedEquityPct)}'),
                  if (a.agreedEquityPct == 0 && a.proposedEquityPct > 0)
                    UpEquityChip(label: 'Proposes ${upPct(a.proposedEquityPct)}', icon: Icons.handshake),
                ]),
              ],
              if (a.hasCounter)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: UpEquityChip(
                    icon: Icons.swap_horiz,
                    label: 'Counter: ${upNaira(a.counterAmount.toInt(), a.currency)}${a.counterEquityPct > 0 ? ' · ${upPct(a.counterEquityPct)}' : ''}',
                  ),
                ),
              if (a.endorsementCount > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text('❤ ${a.endorsementCount} endorsements', style: const TextStyle(color: kUpTextSecondary, fontSize: 11)),
                ),
              if (trailing != null) Align(alignment: Alignment.centerRight, child: trailing!),
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
  const UpGradientAvatar({required this.text, this.size = 40, this.radius = 10, super.key});
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
            color: Colors.white, fontWeight: FontWeight.w800, fontSize: size * 0.45),
      ),
    );
  }
}

/// Rounded contribution/progress meter — grey track + purple (or status) fill.
class UpProgressBar extends StatelessWidget {
  const UpProgressBar({required this.value, this.color = kUpPrimary, this.height = 8, super.key});
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
  const UpCard({required this.child, this.padding = const EdgeInsets.all(16), this.margin, this.radius = 14, this.borderColor, super.key});
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
          border: Border.all(color: borderColor ?? kUpDivider),
          boxShadow: const [
            BoxShadow(color: Color(0x14000000), blurRadius: 6, offset: Offset(0, 2)),
          ],
        ),
        child: child,
      );
}

/// A compact stat tile (icon + value + label) tinted by [color] — the
/// crypto/group-funds stat-strip motif.
class UpStatChip extends StatelessWidget {
  const UpStatChip({required this.icon, required this.value, required this.label, this.color = kUpPrimary, super.key});
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
              Text(label,
                  style: GoogleFonts.inter(color: kUpTextSecondary, fontSize: 10)),
            ],
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
                style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
            if (trailing != null) trailing!,
          ],
        ),
      );
}

/// Full-height empty state (muted icon + title + subtitle).
class UpEmptyState extends StatelessWidget {
  const UpEmptyState({required this.icon, required this.title, this.subtitle, this.action, super.key});
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
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
              if (subtitle != null) ...[
                const SizedBox(height: 8),
                Text(subtitle!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(color: kUpTextSecondary, fontSize: 14)),
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
                border: Border.all(color: kUpDivider),
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
                    child: const Icon(Icons.wifi_tethering_error_rounded, size: 30, color: kUpError),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(color: kUpTextSecondary, fontSize: 13.5, height: 1.4),
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
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        icon: const Icon(Icons.refresh_rounded, size: 18, color: Colors.white),
                        label: Text('Try again',
                            style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
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
  const UpSegmentedTabs({required this.tabs, this.margin = const EdgeInsets.fromLTRB(16, 8, 16, 4), super.key});
  final List<Widget> tabs;
  final EdgeInsetsGeometry margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(color: kUpCard, borderRadius: BorderRadius.circular(12)),
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(color: kUpPrimary, borderRadius: BorderRadius.circular(12)),
        labelColor: Colors.white,
        unselectedLabelColor: kUpTextSecondary,
        labelStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
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
  const UpStepIndicator({required this.current, required this.total, super.key});
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
                        colors: isLast ? const [kUpSuccess, Color(0xFF059669)] : const [kUpPrimarySoft, kUpPrimary],
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
                  color: active ? kUpPrimarySoft : Colors.white.withOpacity(0.25),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: loading ? null : onBack,
                  child: Text('Back', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
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
                        colors: isLast ? const [kUpSuccess, Color(0xFF059669)] : const [kUpPrimarySoft, kUpPrimary],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: loading
                        ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(nextLabel, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                              const SizedBox(width: 8),
                              Icon(isLast ? Icons.check_circle : Icons.arrow_forward, color: Colors.white, size: 18),
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
  const UpRecentActivitySection({required this.receipts, required this.onViewAll, this.onTap, super.key});
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
                      Text('View all', style: GoogleFonts.inter(color: kUpTextSecondary, fontSize: 13, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_ios, color: kUpTextSecondary, size: 12),
                    ]),
                  ),
          ),
          const SizedBox(height: 8),
          if (shown.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Column(children: [
                  Icon(Icons.receipt_long, size: 36, color: Colors.white.withOpacity(0.25)),
                  const SizedBox(height: 8),
                  Text('No activity yet', style: GoogleFonts.inter(color: kUpTextSecondary, fontSize: 13)),
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
    final title = isRelease ? 'Funding received' : 'Escrow refund';
    return GestureDetector(
      onTap: onTap == null ? null : () => onTap!(r),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withOpacity(0.18), borderRadius: BorderRadius.circular(9)),
              child: Icon(isRelease ? Icons.south_west : Icons.reply, color: color, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: GoogleFonts.inter(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(r.fundTitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(color: kUpTextSecondary, fontSize: 12)),
              ]),
            ),
            Text(upNaira(r.amount.toInt(), r.currency), style: GoogleFonts.inter(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
