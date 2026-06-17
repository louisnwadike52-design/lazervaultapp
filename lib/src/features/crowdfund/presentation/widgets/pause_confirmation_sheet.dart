import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/crowdfund_entities.dart';
import '../cubit/crowdfund_cubit.dart';

/// Pause is reversible and doesn't move money, so this sheet skips
/// the PIN gate. Confirm fires the cubit; details screen listener
/// pops + refreshes.
class PauseConfirmationSheet extends StatelessWidget {
  final Crowdfund crowdfund;
  const PauseConfirmationSheet({super.key, required this.crowdfund});

  @override
  Widget build(BuildContext context) {
    return _LifecycleConfirmSheet(
      title: 'Pause campaign',
      body:
          'New donations will be blocked while paused. Donors who already contributed are not affected. You can resume the campaign any time.',
      cta: 'Pause',
      ctaColor: const Color(0xFFF59E0B),
      icon: Icons.pause_circle_outline,
      onConfirm: (ctx) {
        ctx.read<CrowdfundCubit>().pauseCrowdfund(crowdfund.id);
        Navigator.pop(ctx);
      },
    );
  }
}

/// Resume warns if the deadline has already passed (deadline worker
/// will flip the row back to expired within a minute).
class ResumeConfirmationSheet extends StatelessWidget {
  final Crowdfund crowdfund;
  const ResumeConfirmationSheet({super.key, required this.crowdfund});

  @override
  Widget build(BuildContext context) {
    final deadlinePassed = crowdfund.isPastDeadline;
    return _LifecycleConfirmSheet(
      title: 'Resume campaign',
      body: deadlinePassed
          ? 'Heads up: the deadline has already passed. The campaign will be marked Expired again within a minute. Extend the deadline first if you want to keep collecting.'
          : 'Donations will resume immediately. Contributors will be notified.',
      cta: 'Resume',
      ctaColor: const Color(0xFF10B981),
      icon: Icons.play_circle_outline,
      warn: deadlinePassed,
      onConfirm: (ctx) {
        ctx.read<CrowdfundCubit>().resumeCrowdfund(crowdfund.id);
        Navigator.pop(ctx);
      },
    );
  }
}

class _LifecycleConfirmSheet extends StatelessWidget {
  final String title;
  final String body;
  final String cta;
  final Color ctaColor;
  final IconData icon;
  final bool warn;
  final void Function(BuildContext ctx) onConfirm;

  const _LifecycleConfirmSheet({
    required this.title,
    required this.body,
    required this.cta,
    required this.ctaColor,
    required this.icon,
    required this.onConfirm,
    this.warn = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFF3D3D3D),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Icon(icon, color: ctaColor, size: 24.sp),
              SizedBox(width: 10.w),
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            body,
            style: GoogleFonts.inter(
              color: warn ? const Color(0xFFFB923C) : const Color(0xFF9CA3AF),
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    side: const BorderSide(color: Color(0xFF3D3D3D)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => onConfirm(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ctaColor,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    cta,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
