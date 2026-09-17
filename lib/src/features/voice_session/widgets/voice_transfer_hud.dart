import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/voice_session/models/voice_transfer_context.dart';
part 'voice_transfer_hud_widgets.dart';

/// Persistent, boxed "sci-fi" transfer HUD that renders the accumulated
/// [VoiceTransferContext] and updates progressively per state.
///
/// Visual language:
/// - dark glassy card, thin neon brand-purple (#5B45C9) + blue (#3B82F6) borders
/// - subtle outer glow + an inner scanline accent line
/// - monospace-ish uppercase labels (GoogleFonts.robotoMono) for the "HUD"
///   readouts, GoogleFonts.inter for names/values
/// - every transition animates (AnimatedSwitcher / AnimatedSize / count-up)
///
/// The widget is STATELESS w.r.t. money safety — it only reflects the context
/// the cubit accumulated. The PIN entry itself stays the existing bottom sheet;
/// this HUD only mirrors the awaitingPin status.
class VoiceTransferHud extends StatelessWidget {
  final VoiceTransferContext context;

  const VoiceTransferHud({super.key, required this.context});

  // ── Palette ──
  static const Color _purple = Color(0xFF5B45C9);
  static const Color _blue = Color(0xFF3B82F6);
  static const Color _green = Color(0xFF10B981);
  static const Color _red = Color(0xFFEF4444);
  static const Color _muted = Color(0xFF6B7280);

  @override
  Widget build(BuildContext ctx) {
    final c = context;

    // idle → nothing (the caller decides whether to show a slim "Ready" strip).
    if (!c.isActive) return const SizedBox.shrink();

    final accent = _accentFor(c.status);

    // AnimatedSize smooths the box growing as data rows appear; AnimatedSwitcher
    // cross-fades the inner content per state. Keyed by status so rapid state
    // changes swap cleanly without tearing.
    return AnimatedSize(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      alignment: Alignment.topCenter,
      child: _HudFrame(
        accent: accent,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 260),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, anim) => FadeTransition(
            opacity: anim,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.06),
                end: Offset.zero,
              ).animate(anim),
              child: child,
            ),
          ),
          child: KeyedSubtree(
            key: ValueKey(c.status),
            child: _buildBody(c, accent),
          ),
        ),
      ),
    );
  }

  Color _accentFor(VoiceTransferStatus s) {
    switch (s) {
      case VoiceTransferStatus.success:
        return _green;
      case VoiceTransferStatus.failed:
        return _red;
      case VoiceTransferStatus.cancelled:
        return _muted;
      case VoiceTransferStatus.awaitingPin:
        return _blue;
      default:
        return _purple;
    }
  }

  Widget _buildBody(VoiceTransferContext c, Color accent) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildStatusBar(c, accent),
        SizedBox(height: 12.h),
        // Recipient panel — present from recipientSelected onward.
        if (c.recipientName != null || c.recipientUsername != null)
          _RecipientPanel(context: c, accent: accent),
        // Money + destination rows — present once an amount exists.
        if (c.hasAmount) ...[
          SizedBox(height: 12.h),
          _buildAmountReadout(c, accent),
          SizedBox(height: 10.h),
          ..._buildDataRows(c),
        ],
        // Terminal extras (reference / balance / reason).
        if (c.status == VoiceTransferStatus.success) ...[
          SizedBox(height: 10.h),
          _buildSuccessFooter(c),
        ],
        if (c.status == VoiceTransferStatus.failed &&
            (c.failureReason ?? '').isNotEmpty) ...[
          SizedBox(height: 10.h),
          _buildFailureFooter(c),
        ],
      ],
    );
  }

  // ── Status bar (top of the HUD) ──
  Widget _buildStatusBar(VoiceTransferContext c, Color accent) {
    final label = _statusLabel(c.status);
    final icon = _statusIcon(c.status);
    return Row(
      children: [
        Container(
          width: 22.w,
          height: 22.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: accent.withValues(alpha: 0.16),
            border: Border.all(color: accent.withValues(alpha: 0.5), width: 1),
          ),
          child: Icon(icon, color: accent, size: 12.sp),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.robotoMono(
              color: accent,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),
        // Tiny "TRANSFER" tag — reads as a HUD module label.
        Text(
          'TRANSFER',
          style: GoogleFonts.robotoMono(
            color: Colors.white.withValues(alpha: 0.28),
            fontSize: 9.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  String _statusLabel(VoiceTransferStatus s) {
    switch (s) {
      case VoiceTransferStatus.recipientSelected:
        return 'RECIPIENT LOCKED';
      case VoiceTransferStatus.amountSet:
        return 'AMOUNT SET';
      case VoiceTransferStatus.reviewing:
        return 'REVIEW • CONFIRM';
      case VoiceTransferStatus.awaitingPin:
        return 'AUTHORIZE • ENTER PIN';
      case VoiceTransferStatus.success:
        return 'TRANSFER CONFIRMED';
      case VoiceTransferStatus.failed:
        return 'TRANSFER FAILED';
      case VoiceTransferStatus.cancelled:
        return 'CANCELLED';
      case VoiceTransferStatus.idle:
        return 'READY';
    }
  }

  IconData _statusIcon(VoiceTransferStatus s) {
    switch (s) {
      case VoiceTransferStatus.recipientSelected:
        return Icons.person_rounded;
      case VoiceTransferStatus.amountSet:
      case VoiceTransferStatus.reviewing:
        return Icons.receipt_long_rounded;
      case VoiceTransferStatus.awaitingPin:
        return Icons.lock_rounded;
      case VoiceTransferStatus.success:
        return Icons.check_rounded;
      case VoiceTransferStatus.failed:
        return Icons.priority_high_rounded;
      case VoiceTransferStatus.cancelled:
        return Icons.close_rounded;
      case VoiceTransferStatus.idle:
        return Icons.bolt_rounded;
    }
  }

  // ── Amount readout (big, animated count-up) ──
  Widget _buildAmountReadout(VoiceTransferContext c, Color accent) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        gradient: LinearGradient(
          colors: [
            accent.withValues(alpha: 0.10),
            accent.withValues(alpha: 0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: accent.withValues(alpha: 0.22), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: Text(
              'AMOUNT',
              style: GoogleFonts.robotoMono(
                color: Colors.white.withValues(alpha: 0.35),
                fontSize: 9.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const Spacer(),
          Flexible(
            child: _AnimatedNaira(
              value: c.amountNaira ?? 0,
              currency: c.currency,
              color: Colors.white,
              fontSize: 22.sp,
            ),
          ),
        ],
      ),
    );
  }

  // ── Data rows (recipient destination, fee, total) ──
  List<Widget> _buildDataRows(VoiceTransferContext c) {
    final rows = <Widget>[];
    if ((c.transferTypeLabel ?? '').isNotEmpty) {
      rows.add(_DataRow(label: 'VIA', value: c.transferTypeLabel!));
    }
    if ((c.bankName ?? '').isNotEmpty) {
      rows.add(_DataRow(label: 'BANK', value: c.bankName!));
    }
    if ((c.accountDetail ?? '').isNotEmpty) {
      rows.add(_DataRow(label: 'ACCT', value: c.accountDetail!, mono: true));
    }
    if (c.feeNaira != null && c.feeNaira! > 0) {
      rows.add(_DataRow(
        label: 'FEE',
        value: _fmtNaira(c.feeNaira!, c.currency),
      ));
    }
    // TOTAL only when it DIFFERS from the amount. With no fee the two are
    // identical, and repeating the same figure on its own row was the single
    // biggest waste of height on a card the user reads at a glance.
    final total = c.totalNaira;
    final amount = c.amountNaira;
    final totalDiffers = total != null &&
        total > 0 &&
        (amount == null || (total - amount).abs() > 0.009);
    if (totalDiffers) {
      rows.add(_DataRow(
        label: 'TOTAL',
        value: _fmtNaira(total, c.currency),
        emphasized: true,
      ));
    }
    // Interleave subtle dividers.
    final out = <Widget>[];
    for (var i = 0; i < rows.length; i++) {
      out.add(rows[i]);
      if (i != rows.length - 1) out.add(SizedBox(height: 5.h));
    }
    return out;
  }

  Widget _buildSuccessFooter(VoiceTransferContext c) {
    final ref = c.reference ?? '';
    final bal = c.newBalance ?? '';
    if (ref.isEmpty && bal.isEmpty) return const SizedBox.shrink();

    // One compact line instead of two stacked rows. Both are reference data a
    // user checks rather than reads, so they earn a single line between them —
    // the reference truncates from the FRONT, because the distinguishing part
    // of these ids is the tail.
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (ref.isNotEmpty)
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _footerLabel('REF'),
                Text(
                  // Keep the TAIL: reference ids share a long common prefix
                  // (C2C-CHAT-transfer-…), so trimming the front is what keeps
                  // the part that identifies this transfer.
                  ref.length > 22 ? '…${ref.substring(ref.length - 22)}' : ref,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.robotoMono(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: 10.sp),
                ),
              ],
            ),
          ),
        if (ref.isNotEmpty && bal.isNotEmpty) SizedBox(width: 10.w),
        if (bal.isNotEmpty)
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _footerLabel('BALANCE'),
                Text(
                  bal,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.robotoMono(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: 10.sp),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _footerLabel(String text) => Text(
        text,
        style: GoogleFonts.robotoMono(
          color: Colors.white.withValues(alpha: 0.32),
          fontSize: 8.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      );

  Widget _buildFailureFooter(VoiceTransferContext c) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: _red.withValues(alpha: 0.08),
        border: Border.all(color: _red.withValues(alpha: 0.25), width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, color: _red, size: 14.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              c.failureReason!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                color: _red.withValues(alpha: 0.92),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _fmtNaira(double v, String currency) {
    final symbol = currency == 'NGN' ? '₦' : '$currency ';
    return '$symbol${NumberFormat('#,##0.00').format(v)}';
  }
}
