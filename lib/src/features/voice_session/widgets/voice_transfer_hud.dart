import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/voice_session/models/voice_transfer_context.dart';

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
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
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
              fontSize: 26.sp,
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
    if (c.totalNaira != null && c.totalNaira! > 0) {
      rows.add(_DataRow(
        label: 'TOTAL',
        value: _fmtNaira(c.totalNaira!, c.currency),
        emphasized: true,
      ));
    }
    // Interleave subtle dividers.
    final out = <Widget>[];
    for (var i = 0; i < rows.length; i++) {
      out.add(rows[i]);
      if (i != rows.length - 1) out.add(SizedBox(height: 8.h));
    }
    return out;
  }

  Widget _buildSuccessFooter(VoiceTransferContext c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if ((c.reference ?? '').isNotEmpty)
          _DataRow(label: 'REF', value: c.reference!, mono: true),
        if ((c.newBalance ?? '').isNotEmpty) ...[
          SizedBox(height: 8.h),
          _DataRow(label: 'BALANCE', value: c.newBalance!),
        ],
      ],
    );
  }

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

/// Dark glassy frame with thin neon borders + outer glow + a top scanline.
class _HudFrame extends StatelessWidget {
  final Color accent;
  final Widget child;
  const _HudFrame({required this.accent, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF14111F),
            Color(0xFF0C0B12),
          ],
        ),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: accent.withValues(alpha: 0.45), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.22),
            blurRadius: 24,
            spreadRadius: -4,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Scanline accent — a faint gradient line across the top edge.
          Positioned(
            top: 0,
            left: 8.w,
            right: 8.w,
            child: Container(
              height: 1.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    accent.withValues(alpha: 0.0),
                    accent.withValues(alpha: 0.7),
                    accent.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
          // Faint blue corner accent (second neon colour) bottom-right.
          if (accent != VoiceTransferHud._blue)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 40.w,
                height: 1.2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      VoiceTransferHud._blue.withValues(alpha: 0.0),
                      VoiceTransferHud._blue.withValues(alpha: 0.55),
                    ],
                  ),
                ),
              ),
            ),
          Padding(padding: EdgeInsets.only(top: 4.h), child: child),
        ],
      ),
    );
  }
}

/// Recipient panel — circular profile picture (or initials disc) + name/@user.
class _RecipientPanel extends StatelessWidget {
  final VoiceTransferContext context;
  final Color accent;
  const _RecipientPanel({required this.context, required this.accent});

  @override
  Widget build(BuildContext ctx) {
    final c = context;
    final avatarUrl = c.recipientAvatarUrl;
    return Row(
      children: [
        // Avatar — animate in with a scale/fade.
        TweenAnimationBuilder<double>(
          key: ValueKey('avatar_${c.recipientName}_${c.recipientUsername}'),
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutBack,
          builder: (context, t, child) => Transform.scale(
            scale: 0.6 + (t.clamp(0.0, 1.0) * 0.4),
            child: Opacity(opacity: t.clamp(0.0, 1.0), child: child),
          ),
          child: Container(
            width: 46.w,
            height: 46.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: VoiceTransferHud._purple.withValues(alpha: 0.18),
              border: Border.all(
                color: VoiceTransferHud._purple.withValues(alpha: 0.55),
                width: 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: VoiceTransferHud._purple.withValues(alpha: 0.30),
                  blurRadius: 12,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: ClipOval(
              child: (avatarUrl != null && avatarUrl.isNotEmpty)
                  ? Image.network(
                      avatarUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _initials(c),
                    )
                  : _initials(c),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                c.recipientName ?? c.recipientUsername ?? 'Recipient',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              if ((c.recipientUsername ?? '').isNotEmpty) ...[
                SizedBox(height: 2.h),
                Text(
                  '@${c.recipientUsername}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.robotoMono(
                    color: VoiceTransferHud._purple.withValues(alpha: 0.85),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _initials(VoiceTransferContext c) {
    return Container(
      alignment: Alignment.center,
      color: VoiceTransferHud._purple.withValues(alpha: 0.12),
      child: Text(
        c.recipientInitials,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// A single glowing "data row" inside the HUD box.
class _DataRow extends StatelessWidget {
  final String label;
  final String value;
  final bool emphasized;
  final bool mono;
  const _DataRow({
    required this.label,
    required this.value,
    this.emphasized = false,
    this.mono = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: emphasized
            ? Colors.white.withValues(alpha: 0.06)
            : Colors.white.withValues(alpha: 0.03),
        border: Border.all(
          color: emphasized
              ? VoiceTransferHud._blue.withValues(alpha: 0.28)
              : Colors.white.withValues(alpha: 0.07),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.robotoMono(
              color: Colors.white.withValues(alpha: 0.40),
              fontSize: 9.5.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.4,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: (mono ? GoogleFonts.robotoMono : GoogleFonts.inter)(
                color: emphasized
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.88),
                fontSize: emphasized ? 14.sp : 12.5.sp,
                fontWeight: emphasized ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated count-up Naira value. Animates from the previously-shown value to
/// the new one whenever [value] changes (e.g. amount appears / updates).
class _AnimatedNaira extends StatelessWidget {
  final double value;
  final String currency;
  final Color color;
  final double fontSize;
  const _AnimatedNaira({
    required this.value,
    required this.currency,
    required this.color,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final symbol = currency == 'NGN' ? '₦' : '$currency ';
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, v, _) {
        return FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerRight,
          child: Text(
            '$symbol${NumberFormat('#,##0.00').format(v)}',
            maxLines: 1,
            style: GoogleFonts.inter(
              color: color,
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
        );
      },
    );
  }
}
