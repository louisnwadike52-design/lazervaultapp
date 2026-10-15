import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/id_pay_entity.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';

/// The status of a PayID, said plainly.
///
/// It used to be a 15%-alpha pill with 11pt tinted text on a #1F1F1F card — a
/// 4-point luminance step, which is a tag, not a conclusion. On a looked-up
/// PayID the status is the single most important thing on the screen: "Paid"
/// means there is nothing here to pay, and somebody who skims past it types
/// an amount into a request that is already settled.
///
/// So a TERMINAL state (paid, cancelled, expired) is drawn solid, with an
/// icon. `active` keeps the quiet treatment deliberately — it is the
/// unremarkable default, and making every badge shout makes none of them
/// heard.
class IDPayStatusBadge extends StatelessWidget {
  final IDPayStatus status;

  const IDPayStatusBadge({super.key, required this.status});

  bool get _isTerminal => status != IDPayStatus.active;

  @override
  Widget build(BuildContext context) {
    final accent = _accent;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: _isTerminal ? 10.w : 8.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: _isTerminal ? accent : accent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(_isTerminal ? 8.r : 4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isTerminal) ...[
            Icon(_icon, size: 13.sp, color: Colors.white),
            SizedBox(width: 5.w),
          ],
          Text(
            status.displayName,
            style: TextStyle(
              color: _isTerminal ? Colors.white : accent,
              fontSize: _isTerminal ? 12.sp : 11.sp,
              fontWeight: _isTerminal ? FontWeight.w700 : FontWeight.w600,
              letterSpacing: _isTerminal ? 0.2 : 0,
            ),
          ),
        ],
      ),
    );
  }

  IconData get _icon {
    switch (status) {
      case IDPayStatus.paid:
        return Icons.check_circle;
      case IDPayStatus.expired:
        return Icons.schedule;
      case IDPayStatus.cancelled:
        return Icons.block;
      case IDPayStatus.active:
        return Icons.bolt;
    }
  }

  /// One colour per status, used as the fill when terminal and as the tint
  /// when not — so the two treatments cannot drift apart.
  Color get _accent {
    switch (status) {
      case IDPayStatus.active:
        return const Color(0xFF10B981);
      case IDPayStatus.paid:
        return InvoiceThemeColors.primaryPurple;
      case IDPayStatus.expired:
        return const Color(0xFF6B7280);
      case IDPayStatus.cancelled:
        return const Color(0xFFEF4444);
    }
  }
}
