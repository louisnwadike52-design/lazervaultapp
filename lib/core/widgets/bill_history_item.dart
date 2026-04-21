import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Unified history item widget used across electricity, airtime, and data
/// bundle history screens. Supports both compact (home strip) and full
/// (history list) layouts, optional left stripe, and a trailing widget
/// slot for extras like electricity tokens.
class BillHistoryItem extends StatelessWidget {
  const BillHistoryItem({
    super.key,
    this.leadingIcon,
    this.leftStripeColor,
    required this.title,
    required this.subtitle,
    this.reference,
    this.date,
    required this.amount,
    this.currencySymbol = '\u20A6',
    required this.status,
    this.refundSource,
    this.onTap,
    this.compact = false,
    this.trailing,
  });

  /// Icon widget rendered in the leading rounded container (42x42 full, 36x36 compact).
  final Widget? leadingIcon;

  /// When non-null, a 4px vertical color bar is drawn on the left edge of the card.
  final Color? leftStripeColor;

  /// Primary line — provider name, network name, etc.
  final String title;

  /// Secondary line — meter number, phone number, etc.
  final String subtitle;

  /// Transaction reference (hidden in compact mode).
  final String? reference;

  /// Formatted date string (hidden in compact mode).
  final String? date;

  /// Amount in display units (not minor).
  final double amount;

  /// Currency symbol prepended to the amount. Defaults to Naira sign.
  final String currencySymbol;

  /// Raw status string from the backend (e.g. "completed", "failed").
  final String status;

  /// Optional backend `refund_source` column. When non-empty on a `failed`
  /// row it means the user was refunded (hold auto-released, upstream
  /// auto-refund, admin manual reversal, etc.), so the chip should read
  /// "Refunded" in neutral gray instead of a red "Failed".
  final String? refundSource;

  /// Tap callback — typically opens a bottom sheet or receipt.
  final VoidCallback? onTap;

  /// Compact mode uses smaller padding/icon for home-screen strips.
  final bool compact;

  /// Optional widget rendered below the main row (e.g. electricity token).
  final Widget? trailing;

  // ---------------------------------------------------------------------------
  // Status badge logic — single source of truth for all bill types.
  // ---------------------------------------------------------------------------

  /// Canonicalises status strings in any of the three shapes we receive:
  ///   - backend snake_case (`refund_pending`, `awaiting_webhook`)
  ///   - Dart enum `.name` (`refundPending`, `awaitingWebhook`)
  ///   - human display name (`Refund Pending`, `Awaiting Webhook`)
  ///
  /// The old implementation inserted an underscore before every uppercase
  /// letter without stripping the leading one, so display-name input like
  /// "Completed" became `_completed` and never matched any case — every
  /// row fell through to the default "Pending" badge.
  static String _canonical(String status) {
    var out = status.replaceAllMapped(
      RegExp(r'[A-Z]'),
      (m) => '_${m[0]!.toLowerCase()}',
    );
    out = out.replaceAll(RegExp(r'\s+'), '_');
    out = out.replaceAll(RegExp(r'_+'), '_');
    if (out.startsWith('_')) out = out.substring(1);
    if (out.endsWith('_')) out = out.substring(0, out.length - 1);
    return out;
  }

  /// Returns (color, label) for every known bill-payment status so the
  /// history rows render a truthful badge. Previously `failed`, `pending`,
  /// and `refund_failed` fell through to `null`, which made those rows
  /// look identical to completed ones on the landing's recent-payments
  /// strip and in the full history list.
  ///
  /// [refundSource] is the backend `bill_payments.refund_source` column:
  /// when non-empty on a `failed` row it indicates the money was returned
  /// (auto-released hold, upstream auto-refund, admin reversal, etc.), so
  /// the chip is promoted from red "Failed" to gray "Refunded".
  static (Color, String)? statusInfo(String status, {String? refundSource}) {
    final canonical = _canonical(status);
    if (canonical == 'failed' &&
        refundSource != null &&
        refundSource.isNotEmpty) {
      return (const Color(0xFF6B7280), 'Refunded');
    }
    switch (canonical) {
      case 'completed':
      case 'success':
      case 'successful':
        return (const Color(0xFF10B981), 'Completed');
      case 'refunded':
      case 'reversed':
        return (const Color(0xFF6B7280), 'Refunded');
      case 'processing':
      case 'awaiting_webhook':
      case 'awaiting_verification':
      case 'enrichment_needed':
      case 'failover_submitted':
        return (const Color(0xFFFB923C), 'Processing');
      case 'refund_pending':
        return (const Color(0xFFFB923C), 'Refund Pending');
      case 'pending':
        return (const Color(0xFFFB923C), 'Pending');
      case 'failed':
        return (const Color(0xFFEF4444), 'Failed');
      case 'refund_failed':
        return (const Color(0xFFEF4444), 'Refund Failed');
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final info = statusInfo(status, refundSource: refundSource);
    final double pad = compact ? 12.w : 14.w;
    final double iconSize = compact ? 36.w : 42.w;
    final double iconRadius = compact ? 10.r : 12.r;

    Widget card = Container(
      padding: leftStripeColor != null ? null : EdgeInsets.all(pad),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      clipBehavior: leftStripeColor != null ? Clip.antiAlias : Clip.none,
      child: leftStripeColor != null
          ? IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(width: 4.w, color: leftStripeColor),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(pad),
                      child: _buildContent(
                        statusColor: info?.$1,
                        statusLabel: info?.$2,
                        iconSize: iconSize,
                        iconRadius: iconRadius,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : _buildContent(
              statusColor: info?.$1,
              statusLabel: info?.$2,
              iconSize: iconSize,
              iconRadius: iconRadius,
            ),
    );

    if (onTap != null) {
      card = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: card,
      );
    }

    return card;
  }

  Widget _buildContent({
    required Color? statusColor,
    required String? statusLabel,
    required double iconSize,
    required double iconRadius,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (leadingIcon != null) ...[
              SizedBox(
                width: iconSize,
                height: iconSize,
                child: leadingIcon,
              ),
              SizedBox(width: 12.w),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: compact ? 11.sp : 12.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (!compact && reference != null && reference!.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(
                      reference!,
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (!compact && date != null && date!.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(
                      date!,
                      style: GoogleFonts.inter(
                        fontSize: 10.sp,
                        color: const Color(0xFF9CA3AF).withValues(alpha: 0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$currencySymbol${amount.toStringAsFixed(0)}',
                  style: GoogleFonts.inter(
                    fontSize: compact ? 14.sp : 15.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                if (statusColor != null && statusLabel != null) ...[
                  SizedBox(height: 4.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      statusLabel,
                      style: GoogleFonts.inter(
                        fontSize: 10.sp,
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        if (trailing != null) ...[
          SizedBox(height: 8.h),
          trailing!,
        ],
      ],
    );
  }
}
