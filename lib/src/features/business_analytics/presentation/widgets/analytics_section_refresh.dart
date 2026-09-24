import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';

/// Shows a loader over the DATA of an analytics tab, not over the whole page.
///
/// Tapping a period chip used to emit a bare loading state, and the screen
/// swapped its entire body for a full-page spinner — so the header, the tab bar
/// and the chips all disappeared and reappeared. A filter tap read as the page
/// reloading, which is exactly what it should not read as.
///
/// The chrome now stays put and only this wrapper covers the figures that are
/// about to change. The old numbers are dimmed rather than removed: keeping them
/// crisp under a chip the user has already moved would present the previous
/// period's figures as the new period's, and blanking them makes the section jump
/// as it empties and refills.
class AnalyticsSectionRefresh extends StatelessWidget {
  const AnalyticsSectionRefresh({
    super.key,
    required this.isRefreshing,
    required this.child,
    this.pendingLabel,
    this.error,
    this.onRetry,
  });

  /// True while the newly-tapped period is being fetched.
  final bool isRefreshing;

  /// The section's normal content.
  final Widget child;

  /// Human label for the period being loaded, e.g. "Week". Shown beside the
  /// spinner so the user can see WHICH filter they are waiting on.
  final String? pendingLabel;

  /// Set when the last period change failed. Reported here rather than by
  /// replacing the page, because the figures on screen are still valid for the
  /// period the chip has snapped back to.
  final String? error;

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final message = error?.trim() ?? '';
    if (message.isNotEmpty && !isRefreshing) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFFEF4444).withValues(alpha: 0.30),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline_rounded,
                    size: 16.sp, color: const Color(0xFFEF4444)),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    // Names the period that failed, so it is clear the figures
                    // below are the previous one's and still correct.
                    pendingLabel == null
                        ? "Couldn't load that period. Showing the last one."
                        : "Couldn't load $pendingLabel. "
                            'Showing the last period.',
                    style: TextStyle(
                      color: const Color(0xFFEF4444),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                if (onRetry != null)
                  TextButton(
                    onPressed: onRetry,
                    child: Text('Retry', style: TextStyle(fontSize: 12.sp)),
                  ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          child,
        ],
      );
    }

    if (!isRefreshing) return child;

    return Stack(
      children: [
        // IgnorePointer, not a disabled tree: taps must not reach charts whose
        // numbers are about to be replaced, but the widgets stay mounted so the
        // section keeps its height and nothing below it jumps.
        IgnorePointer(
          child: Opacity(opacity: 0.35, child: child),
        ),
        Positioned.fill(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const LazerVaultLoader.small(),
                if (pendingLabel != null) ...[
                  SizedBox(height: 8.h),
                  Text(
                    'Loading $pendingLabel…',
                    style: TextStyle(
                      color: InvoiceThemeColors.primaryPurpleLight,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
