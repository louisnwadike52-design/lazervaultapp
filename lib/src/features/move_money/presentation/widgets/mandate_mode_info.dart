import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The debit mode a linked bank account currently uses, for the info modal.
enum MandateModeView {
  /// Active Direct Debit — recurring, debits instantly with no per-transaction approval.
  directDebit,

  /// Mandate authorized but still activating with NIBSS — one-time approval is used meanwhile.
  settingUp,

  /// One-time DirectPay — the user approves each transaction at their bank.
  oneTime,
}

/// Shared info modal explaining DirectPay (one-time) vs Direct Debit (recurring)
/// for a linked bank account. Used by the Deposit cards and the Beam transfer
/// flow so the copy + styling never drift across the money-movement screens.
///
/// [actionNoun] is the per-transaction noun ("deposit" / "transfer").
/// [switchHint] is the screen-specific line telling the user how to switch
/// (e.g. "Tap the 3-dots on the card to switch between them.").
void showMandateModeInfoModal(
  BuildContext context, {
  required MandateModeView current,
  required String bankName,
  required String actionNoun,
  String? switchHint,
}) {
  const green = Color(0xFF10B981);
  const amber = Color(0xFFFB923C);
  const purple = Color(0xFF7C5CFF);
  final bank = bankName.isNotEmpty ? bankName : 'this bank';

  showDialog<void>(
    context: context,
    builder: (ctx) => Dialog(
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('How $bank ${actionNoun}s work',
                style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
            SizedBox(height: 16.h),
            _modeRow(
              icon: Icons.autorenew,
              color: green,
              title: 'Direct Debit (recurring)',
              body: 'Authorize once, then ${actionNoun}s debit automatically with no bank approval each time.',
              active: current == MandateModeView.directDebit,
            ),
            if (current == MandateModeView.settingUp) ...[
              SizedBox(height: 12.h),
              _modeRow(
                icon: Icons.hourglass_bottom,
                color: amber,
                title: 'Setting up Direct Debit',
                body: 'You authorized it. Your bank is activating it with NIBSS, which can take a little while. Until then ${actionNoun}s use one-time approval.',
                active: true,
              ),
            ],
            SizedBox(height: 12.h),
            _modeRow(
              icon: Icons.bolt,
              color: purple,
              title: 'One-time (DirectPay)',
              body: 'You approve each $actionNoun at your bank. No recurring authorization is stored.',
              active: current == MandateModeView.oneTime,
            ),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.swap_horiz, color: Colors.white.withValues(alpha: 0.55), size: 15.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(switchHint ?? 'Use the account options to switch between them.',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12.sp, height: 1.4)),
                ),
              ],
            ),
            SizedBox(height: 18.h),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                style: TextButton.styleFrom(foregroundColor: const Color(0xFF3B82F6)),
                child: Text('Got it', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _modeRow({
  required IconData icon,
  required Color color,
  required String title,
  required String body,
  required bool active,
}) {
  return Container(
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: active ? color.withValues(alpha: 0.10) : Colors.white.withValues(alpha: 0.03),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: active ? color.withValues(alpha: 0.45) : Colors.white.withValues(alpha: 0.08)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(title,
                        style: TextStyle(color: Colors.white, fontSize: 13.5.sp, fontWeight: FontWeight.w700)),
                  ),
                  if (active) ...[
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text('Current',
                          style: TextStyle(color: color, fontSize: 9.sp, fontWeight: FontWeight.w800)),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 4.h),
              Text(body,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12.sp, height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}
