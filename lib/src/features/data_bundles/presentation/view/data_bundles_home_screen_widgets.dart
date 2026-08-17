part of 'data_bundles_home_screen.dart';

/// Flat quick-action tile used above the tab toggle. Mirrors
/// [_QuickActionCard] on the internet bill landing so every utility's
/// "Saved / Rollover / Reminders" strip renders the same shell.
class _QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _accent = Color(0xFF4E03D0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _border, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: _accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: _accent, size: 18.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
