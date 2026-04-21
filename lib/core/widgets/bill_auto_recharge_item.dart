import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

/// Unified auto-recharge list item used across electricity, airtime, and data
/// bundle auto-recharge screens. Matches the dark-theme card style of
/// [BillHistoryItem].
class BillAutoRechargeItem extends StatelessWidget {
  const BillAutoRechargeItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.planName,
    required this.amount,
    required this.frequency,
    required this.status,
    this.nextRunDate,
    this.createdAt,
    this.executionHour,
    this.executionMinute,
    this.leadingIcon,
    this.onPause,
    this.onResume,
    this.onDelete,
    this.onEdit,
    this.onTap,
    this.failureCount = 0,
    this.infoRows = const [],
    this.currencySymbol = '\u20A6',
  });

  /// Primary line -- network name, provider name, etc.
  final String title;

  /// Secondary line -- phone number, meter number, etc.
  final String subtitle;

  /// Optional plan description (e.g. "1GB 30 Days", "Prepaid").
  final String? planName;

  /// Amount in display units (not minor).
  final double amount;

  /// Frequency string from the backend ("daily" / "weekly" / "monthly").
  final String frequency;

  /// Status string ("active" / "paused" / "cancelled" / "expired").
  final String status;

  /// ISO-8601 next-run date. Displayed as relative or absolute text.
  final DateTime? nextRunDate;

  /// Creation date of this rollover. Rendered as an absolute date under
  /// the schedule line so users can see when the rollover was set up.
  final DateTime? createdAt;

  /// Execution hour (0-23). Combined with [executionMinute] for the
  /// "Every {frequency} at {HH:MM}" line.
  final int? executionHour;

  /// Execution minute (0-59).
  final int? executionMinute;

  /// Icon widget rendered in the leading 42x42 container.
  final Widget? leadingIcon;

  /// Called when the user taps "Pause". Only shown when status is active.
  final VoidCallback? onPause;

  /// Called when the user taps "Resume". Only shown when status is not active.
  final VoidCallback? onResume;

  /// Called when the user taps delete.
  final VoidCallback? onDelete;

  /// Called when the user taps edit.
  final VoidCallback? onEdit;

  /// Called when the user taps the card body.
  final VoidCallback? onTap;

  /// Number of consecutive failures. Shown as a warning badge when > 0.
  final int failureCount;

  /// Additional key-value rows displayed between the header and frequency row.
  /// Each entry is rendered as a label-value pair.
  final List<MapEntry<String, String>> infoRows;

  /// Currency symbol prepended to the amount. Defaults to Naira sign.
  final String currencySymbol;

  // ---------------------------------------------------------------------------
  // Status helpers
  // ---------------------------------------------------------------------------

  bool get _isActive => status.toLowerCase() == 'active';
  bool get _isPaused => status.toLowerCase() == 'paused';
  bool get _isCancelled => status.toLowerCase() == 'cancelled';

  Color get _statusColor {
    if (_isActive) return const Color(0xFF10B981);
    if (_isPaused) return const Color(0xFFFB923C);
    return const Color(0xFF6B7280); // cancelled / expired
  }

  String get _statusLabel {
    final s = status.toLowerCase();
    return '${s[0].toUpperCase()}${s.substring(1)}';
  }

  // ---------------------------------------------------------------------------
  // Formatting
  // ---------------------------------------------------------------------------

  String get _frequencyText {
    switch (frequency.toLowerCase()) {
      case 'daily':
        return 'Daily';
      case 'weekly':
        return 'Weekly';
      case 'monthly':
        return 'Monthly';
      default:
        return frequency.isEmpty ? 'Recurring' : frequency;
    }
  }

  String get _scheduleText {
    final base = 'Every $_frequencyText';
    if (executionHour != null && executionMinute != null) {
      final h = executionHour! % 12 == 0 ? 12 : executionHour! % 12;
      final m = executionMinute!.toString().padLeft(2, '0');
      final p = executionHour! < 12 ? 'AM' : 'PM';
      return '$base at $h:$m $p';
    }
    return base;
  }

  String _formatNextRun(DateTime d) {
    final now = DateTime.now();
    final diff = d.difference(now);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Tomorrow';
    if (diff.inDays > 0 && diff.inDays < 7) return '${diff.inDays} days';
    return DateFormat('MMM dd, yyyy').format(d);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: _isActive
                ? const Color(0xFF10B981).withValues(alpha: 0.4)
                : const Color(0xFF2D2D2D),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -- Header row: icon | title+subtitle | status badge --
            Row(
              children: [
                if (leadingIcon != null) ...[
                  Container(
                    width: 42.w,
                    height: 42.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(child: leadingIcon),
                  ),
                  SizedBox(width: 12.w),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title.isNotEmpty ? title : 'Unknown',
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$currencySymbol${amount.toStringAsFixed(0)}',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: _statusColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        _statusLabel,
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: _statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // -- Plan name (optional) --
            if (planName != null && planName!.isNotEmpty) ...[
              SizedBox(height: 10.h),
              Row(
                children: [
                  Icon(Icons.data_usage,
                      size: 14.sp, color: const Color(0xFF6B7280)),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      planName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            // -- Extra info rows (provider, meter, etc.) --
            if (infoRows.isNotEmpty) ...[
              SizedBox(height: 8.h),
              ...infoRows.map((e) => Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.key,
                            style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 12.sp)),
                        Text(e.value,
                            style: GoogleFonts.inter(
                                color: Colors.white, fontSize: 12.sp)),
                      ],
                    ),
                  )),
            ],

            // -- Frequency + schedule row --
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(Icons.repeat,
                    size: 14.sp, color: const Color(0xFF6B7280)),
                SizedBox(width: 6.w),
                Text(
                  _scheduleText,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),

            // -- Next run date --
            if (nextRunDate != null) ...[
              SizedBox(height: 6.h),
              Row(
                children: [
                  Icon(Icons.access_time,
                      size: 12.sp, color: const Color(0xFF6B7280)),
                  SizedBox(width: 4.w),
                  Text(
                    'Next: ${_formatNextRun(nextRunDate!)}',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ],

            // -- Created date --
            if (createdAt != null) ...[
              SizedBox(height: 4.h),
              Row(
                children: [
                  Icon(Icons.event_available,
                      size: 12.sp, color: const Color(0xFF6B7280)),
                  SizedBox(width: 4.w),
                  Text(
                    'Created ${DateFormat('MMM dd, yyyy').format(createdAt!)}',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ],

            // -- Failure warning --
            if (failureCount > 0) ...[
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning_amber,
                        color: const Color(0xFFEF4444), size: 14.sp),
                    SizedBox(width: 6.w),
                    Text(
                      '$failureCount failed attempt${failureCount > 1 ? "s" : ""}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFEF4444),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // -- Action buttons --
            if (!_isCancelled &&
                (onPause != null ||
                    onResume != null ||
                    onEdit != null ||
                    onDelete != null)) ...[
              SizedBox(height: 12.h),
              Row(
                children: [
                  // Pause / Resume
                  if (_isActive && onPause != null)
                    Expanded(child: _actionBtn(Icons.pause, 'Pause',
                        const Color(0xFFFB923C), onPause!)),
                  if (_isPaused && onResume != null)
                    Expanded(child: _actionBtn(Icons.play_arrow, 'Resume',
                        const Color(0xFF10B981), onResume!)),
                  // Edit
                  if (onEdit != null) ...[
                    if (onPause != null || onResume != null)
                      SizedBox(width: 8.w),
                    Expanded(child: _actionBtn(Icons.edit_outlined, 'Edit',
                        const Color(0xFF4E03D0), onEdit!)),
                  ],
                  // Delete
                  if (onDelete != null) ...[
                    SizedBox(width: 8.w),
                    _iconBtn(Icons.delete_outline, const Color(0xFFEF4444),
                        onDelete!),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _actionBtn(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 16.sp),
            SizedBox(width: 6.w),
            Text(
              label,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconBtn(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Icon(icon, color: color, size: 18.sp),
      ),
    );
  }
}
