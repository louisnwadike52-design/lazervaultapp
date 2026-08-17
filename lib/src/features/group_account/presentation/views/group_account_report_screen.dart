import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';
import '../../services/group_account_report_service.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'group_account_report_screen_widgets.dart';


class _ShareCard extends StatelessWidget {
  final GroupAccountReport report;
  final VoidCallback onShare;
  final VoidCallback onCopy;
  final VoidCallback onClose;

  const _ShareCard({
    required this.report,
    required this.onShare,
    required this.onCopy,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEC4899), Color(0xFFBE185D)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.share,
                color: Colors.white,
                size: 48,
              ),
              SizedBox(height: 24.h),
              Text(
                'Share Your Story',
                style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Spread the word and help your group grow!',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              // Hashtags
              if (report.hashtags.isNotEmpty)
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  alignment: WrapAlignment.center,
                  children: report.hashtags.map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Text(
                        '#$tag',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              SizedBox(height: 48.h),
              // Share button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onShare,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFEC4899),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  icon: const Icon(Icons.share),
                  label: Text(
                    'Share Report',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              // Copy button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onCopy,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  icon: const Icon(Icons.copy),
                  label: Text(
                    'Copy Text',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              TextButton(
                onPressed: onClose,
                child: Text(
                  'Done',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
