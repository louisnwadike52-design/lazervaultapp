import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

/// Unified reminder list item used across electricity, airtime, and data
/// bundle reminder screens. Matches the dark-theme card style of
/// [BillHistoryItem] and [BillAutoRechargeItem].
class BillReminderItem extends StatelessWidget {
  const BillReminderItem({
    super.key,
    required this.title,
    this.description,
    this.amount,
    required this.reminderDate,
    required this.status,
    this.isRecurring = false,
    this.recurrenceType,
    this.leadingIcon,
    this.onEdit,
    this.onDelete,
    this.onMarkComplete,
    this.onPayNow,
    this.onTap,
    this.isDue = false,
    this.linkedContactLabel,
    this.currencySymbol = '\u20A6',
    this.payNowLabel = 'Pay Now',
  });

  /// Primary line -- "IKEDC Prepaid", "MTN Airtime", etc.
  final String title;

  /// Optional description shown below the title.
  final String? description;

  /// Optional amount. When null or <= 0 the amount chip is hidden.
  final double? amount;

  /// The date+time at which the reminder fires.
  final DateTime reminderDate;

  /// Status string ("pending" / "notified" / "completed" / "cancelled").
  final String status;

  /// Whether this reminder repeats.
  final bool isRecurring;

  /// Recurrence type ("daily" / "weekly" / "monthly"). Ignored when
  /// [isRecurring] is false.
  final String? recurrenceType;

  /// Leading icon. Falls back to a bell icon coloured by status.
  final Widget? leadingIcon;

  /// Called when the user taps edit. Hidden for completed/cancelled.
  final VoidCallback? onEdit;

  /// Called when the user taps delete.
  final VoidCallback? onDelete;

  /// Called when the user taps "Mark Complete". Hidden for completed/cancelled.
  final VoidCallback? onMarkComplete;

  /// Called when the user taps "Pay Now" on a due reminder.
  final VoidCallback? onPayNow;

  /// Called when the user taps the card body.
  final VoidCallback? onTap;

  /// Whether this reminder is past-due. Highlights the card border.
  final bool isDue;

  /// Currency symbol prepended to the amount. Defaults to Naira sign.
  final String currencySymbol;

  /// Label for the pay-now button (e.g. "Top up now", "Buy Data Now").
  final String payNowLabel;

  /// When non-null, renders a small "Contact: ..." chip so the user
  /// sees which saved beneficiary this reminder is wired to. Empty
  /// string hides the chip — callers pass null (not '') when there's
  /// no link and the pre-formatted display string (nickname or phone)
  /// otherwise.
  final String? linkedContactLabel;

  // ---------------------------------------------------------------------------
  // Status helpers
  // ---------------------------------------------------------------------------

  bool get _isCompleted =>
      status.toLowerCase() == 'completed' ||
      status.toLowerCase() == 'cancelled';

  Color get _statusColor {
    switch (status.toLowerCase()) {
      case 'completed':
        return const Color(0xFF10B981);
      case 'notified':
        return const Color(0xFF4E03D0);
      case 'cancelled':
        return const Color(0xFF6B7280);
      case 'pending':
      default:
        return isDue ? const Color(0xFFF59E0B) : const Color(0xFF4E03D0);
    }
  }

  String get _statusLabel {
    final s = status.toLowerCase();
    return '${s[0].toUpperCase()}${s.substring(1)}';
  }

  String get _recurrenceLabel {
    if (!isRecurring) return 'One-time';
    switch (recurrenceType?.toLowerCase()) {
      case 'daily':
        return 'Daily';
      case 'weekly':
        return 'Weekly';
      case 'monthly':
        return 'Monthly';
      default:
        return 'Recurring';
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('MMM dd, yyyy');
    final timeFmt = DateFormat('hh:mm a');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isDue
                ? const Color(0xFFF59E0B)
                : _isCompleted
                    ? Colors.grey.withValues(alpha: 0.3)
                    : const Color(0xFF2D2D2D),
            width: isDue ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -- Header row: icon | title+description | status badge --
            Row(
              children: [
                Container(
                  width: 42.w,
                  height: 42.w,
                  decoration: BoxDecoration(
                    color: _statusColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: leadingIcon ??
                      Icon(
                        _isCompleted
                            ? Icons.check_circle
                            : isDue
                                ? Icons.notification_important
                                : Icons.notifications_active,
                        color: _statusColor,
                        size: 22.sp,
                      ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          decoration: _isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      if (description != null &&
                          description!.isNotEmpty) ...[
                        SizedBox(height: 2.h),
                        Text(
                          description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: _statusColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    _statusLabel,
                    style: GoogleFonts.inter(
                      color: _statusColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            // -- Info chips: date, time, recurrence, amount --
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                    child:
                        _infoChip(Icons.calendar_today, dateFmt.format(reminderDate))),
                SizedBox(width: 8.w),
                Expanded(
                    child:
                        _infoChip(Icons.access_time, timeFmt.format(reminderDate))),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(child: _infoChip(Icons.repeat, _recurrenceLabel)),
                if (amount != null && amount! > 0) ...[
                  SizedBox(width: 8.w),
                  Expanded(
                    child: _infoChip(Icons.attach_money,
                        '$currencySymbol ${amount!.toStringAsFixed(0)}'),
                  ),
                ],
              ],
            ),
            if (linkedContactLabel != null &&
                linkedContactLabel!.isNotEmpty) ...[
              SizedBox(height: 8.h),
              _infoChip(
                Icons.person_outline,
                'Contact: ${linkedContactLabel!}',
              ),
            ],

            // -- "Pay Now" button for due reminders --
            if (isDue && !_isCompleted && onPayNow != null) ...[
              SizedBox(height: 14.h),
              GestureDetector(
                onTap: onPayNow,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.payment, color: Colors.white, size: 18.sp),
                      SizedBox(width: 8.w),
                      Text(
                        payNowLabel,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // -- Action buttons --
            SizedBox(height: 12.h),
            Row(
              children: [
                if (!_isCompleted && onMarkComplete != null)
                  Expanded(
                    child: _actionBtn(
                      Icons.check,
                      'Mark Complete',
                      const Color(0xFF10B981),
                      onMarkComplete!,
                    ),
                  ),
                if (!_isCompleted && onMarkComplete != null && onEdit != null)
                  SizedBox(width: 8.w),
                if (!_isCompleted && onEdit != null)
                  _iconBtn(
                      Icons.edit, const Color(0xFF4E03D0), onEdit!),
                if (!_isCompleted && onEdit != null) SizedBox(width: 8.w),
                if (onDelete != null)
                  _iconBtn(
                      Icons.delete, const Color(0xFFEF4444), onDelete!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white.withValues(alpha: 0.6), size: 14.sp),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color),
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
                fontSize: 13.sp,
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
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color),
        ),
        child: Icon(icon, color: color, size: 20.sp),
      ),
    );
  }
}
