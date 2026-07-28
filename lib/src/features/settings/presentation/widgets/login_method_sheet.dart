import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Bottom sheet to choose the account's login method. Returns the chosen method
/// ("email_password" | "phone_passcode") or null if dismissed. Purely a picker
/// — the caller performs the switch (and any "set password first" gating).
Future<String?> showLoginMethodSheet(
  BuildContext context, {
  required String current,
}) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: const Color(0xFF1F1F1F),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    builder: (sheetCtx) => SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Login method',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Choose how you sign in to this account. You can switch back any time.',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
            ),
            SizedBox(height: 20.h),
            _MethodOption(
              icon: Icons.pin_rounded,
              title: 'Phone + passcode',
              subtitle: 'Sign in with your phone and 6-digit passcode',
              selected: current == 'phone_passcode',
              onTap: () => Navigator.of(sheetCtx).pop('phone_passcode'),
            ),
            SizedBox(height: 12.h),
            _MethodOption(
              icon: Icons.alternate_email_rounded,
              title: 'Email or phone + password',
              subtitle: 'Sign in with your email or phone and password',
              selected: current == 'email_password',
              onTap: () => Navigator.of(sheetCtx).pop('email_password'),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    ),
  );
}

class _MethodOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _MethodOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF4834D4);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: selected ? accent.withValues(alpha: 0.10) : const Color(0xFF161616),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: selected ? accent : const Color(0xFF2D2D2D),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: accent, size: 22.w),
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
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              Icon(Icons.check_circle_rounded, color: accent, size: 22.w),
          ],
        ),
      ),
    );
  }
}
