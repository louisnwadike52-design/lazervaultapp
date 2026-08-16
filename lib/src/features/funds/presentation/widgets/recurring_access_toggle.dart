import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Auto-mandate Toggle - lets the user opt into an auto-mandate when linking a bank.
/// Off (one-time): Uses Mono DirectPay (user authorises each deposit at their bank).
/// On (auto-mandate): Creates a Mono mandate so future deposits are seamless (DebitMandate,
/// no per-deposit approval). The account is still linked either way; the mandate is what
/// makes it "Persistent" for instant future deposits.
class RecurringAccessToggle extends StatelessWidget {
  final bool isRecurringEnabled;
  final ValueChanged<bool> onToggle;

  const RecurringAccessToggle({
    super.key,
    required this.isRecurringEnabled,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isRecurringEnabled
              ? const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        isRecurringEnabled ? Icons.link : Icons.looks_one,
                        color: const Color.fromARGB(255, 78, 3, 208),
                        size: 18.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  'Set up Direct Debit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: 6.w),
                              // Info (i): explains Direct Debit vs Direct Pay
                              // so the user knows exactly what the switch does.
                              GestureDetector(
                                onTap: () => _showDirectDebitInfo(context),
                                behavior: HitTestBehavior.opaque,
                                child: Icon(
                                  Icons.info_outline,
                                  color: Colors.white.withValues(alpha: 0.6),
                                  size: 16.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            isRecurringEnabled
                                ? 'Direct Debit: future deposits are instant. No bank approval each time'
                                : 'You will approve each deposit at your bank (one-time)',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Switch(
                value: isRecurringEnabled,
                onChanged: onToggle,
                // On: bright white thumb on a SOLID lighter-violet track — the
                // old deep purple (#4E03D0) blended into the dark sheet and read
                // as "off". White-on-violet gives a clearly-visible enabled state.
                activeThumbColor: Colors.white,
                activeTrackColor: const Color(0xFF8B5CF6),
                inactiveThumbColor: Colors.white.withValues(alpha: 0.7),
                inactiveTrackColor: Colors.white.withValues(alpha: 0.22),
              ),
            ],
          ),
          if (isRecurringEnabled) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFA502).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: const Color(0xFFFFA502).withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: const Color(0xFFFFA502),
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'You can revoke access anytime in Settings',
                      style: TextStyle(
                        color: const Color(0xFFFFA502),
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Explains the two deposit modes the switch toggles between, in plain
  /// user language. Styled to the app's dark theme + brand purple.
  void _showDirectDebitInfo(BuildContext context) {
    const purple = Color.fromARGB(255, 78, 3, 208);
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (ctx) => Dialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.account_balance_outlined, color: purple, size: 22.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      'Direct Debit vs Direct Pay',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              _infoRow(
                icon: Icons.link,
                title: 'Direct Debit (switch ON)',
                body: 'You approve a recurring mandate with your bank just '
                    'once. After that, future deposits happen automatically — '
                    'no bank approval each time. You can revoke it anytime in '
                    'Settings.',
                accent: purple,
              ),
              SizedBox(height: 14.h),
              _infoRow(
                icon: Icons.looks_one,
                title: 'Direct Pay (switch OFF)',
                body: 'A one-time bank payment with no saved mandate. You '
                    'authorise each deposit at your bank, every time. Nothing '
                    'is stored for future use.',
                accent: Colors.white.withValues(alpha: 0.7),
              ),
              SizedBox(height: 22.h),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  style: TextButton.styleFrom(
                    backgroundColor: purple,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'Got it',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String title,
    required String body,
    required Color accent,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: accent, size: 16.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                body,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 12.sp,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
