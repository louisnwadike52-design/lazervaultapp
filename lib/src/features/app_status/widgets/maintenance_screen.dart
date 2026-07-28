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

  const MaintenanceModal({super.key, required this.onRetry});

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
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.12),
                      border: Border.all(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.35),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      Icons.construction_rounded,
                      color: const Color(0xFF3B82F6),
                      size: 38.sp,
                    ),
                  ),
                  SizedBox(height: 22.h),
                  Text(
                    'Under maintenance',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Our servers are being worked on right now. Your money and '
                    'data are safe. Please hold on a moment while we get things '
                    'back up.',
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
                        backgroundColor: const Color(0xFF3B82F6),
                        disabledBackgroundColor:
                            const Color(0xFF3B82F6).withValues(alpha: 0.5),
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
                              'Try again',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
