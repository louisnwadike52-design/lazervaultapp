import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// A MODAL overlay (dimmed scrim + centered card) shown ON TOP of whatever
/// screen is loaded when the backend health probe fails. It does NOT replace
/// the app — the current screen stays rendered behind it (non-blocking flow) —
/// and it auto-dismisses the moment health recovers (the gate stops rendering
/// it). A non-dismissible barrier: interacting with the app would fail while
/// the backend is down, so we hold this until [onRetry] succeeds.
class MaintenanceModal extends StatefulWidget {
  final Future<void> Function() onRetry;

  /// Optional overrides so the SAME styled modal can be reused for other
  /// "temporarily unavailable" surfaces (e.g. the voice assistant) without
  /// forking the component. All default to the backend-maintenance copy.
  final IconData icon;
  final String title;
  final String message;
  final String retryLabel;

  /// When provided, a secondary dismiss ("Later") button is shown and this is
  /// invoked on tap. The gate's full-app barrier leaves this null (you cannot
  /// dismiss a real backend outage); optional/non-blocking surfaces pass it so
  /// the user can close and carry on.
  final VoidCallback? onClose;

  const MaintenanceModal({
    super.key,
    required this.onRetry,
    this.icon = Icons.construction_rounded,
    this.title = 'Under maintenance',
    this.message =
        'Our servers are being worked on right now. Your money and '
        'data are safe. Please hold on a moment while we get things '
        'back up.',
    this.retryLabel = 'Try again',
    this.onClose,
  });

  @override
  State<MaintenanceModal> createState() => _MaintenanceModalState();
}

class _MaintenanceModalState extends State<MaintenanceModal> {
  bool _retrying = false;

  Future<void> _retry() async {
    if (_retrying) return;
    setState(() => _retrying = true);
    try {
      await widget.onRetry();
    } finally {
      if (mounted) setState(() => _retrying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Absorb all input (barrier) + dim the app behind, so the maintenance card
    // reads as a true modal over the current screen.
    return Material(
      color: Colors.black.withValues(alpha: 0.72),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Container(
              constraints: BoxConstraints(maxWidth: 380.w),
              padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 24.h),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1C),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: const Color(0xFF262629)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 84.w,
                    height: 84.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.12),
                      border: Border.all(
                        color: const Color(0xFF4E03D0).withValues(alpha: 0.35),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      widget.icon,
                      color: const Color(0xFF4E03D0),
                      size: 38.sp,
                    ),
                  ),
                  SizedBox(height: 22.h),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    widget.message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 13.5.sp,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _retrying ? null : _retry,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4E03D0),
                        disabledBackgroundColor:
                            const Color(0xFF4E03D0).withValues(alpha: 0.5),
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      child: _retrying
                          ? SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              widget.retryLabel,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                  if (widget.onClose != null) ...[
                    SizedBox(height: 8.h),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: _retrying ? null : widget.onClose,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        child: Text(
                          'Later',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
