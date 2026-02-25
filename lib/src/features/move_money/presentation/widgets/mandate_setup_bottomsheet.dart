import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../cubit/mandate_cubit.dart';
import '../../cubit/mandate_state.dart';

/// Bottom sheet shown after account linking to offer mandate setup.
///
/// If the user enables auto-debit and the mandate requires e-mandate
/// authorization, opens the authorization URL in the browser.
Future<bool> showMandateSetupBottomSheet({
  required BuildContext context,
  required String linkedAccountId,
  required String userId,
  required String bankName,
  required String accountName,
  String? userEmail,
  String? userName,
  String? userPhone,
}) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xFF1F1F1F),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => BlocProvider.value(
      value: context.read<MandateCubit>(),
      child: _MandateSetupSheet(
        linkedAccountId: linkedAccountId,
        userId: userId,
        bankName: bankName,
        accountName: accountName,
        userEmail: userEmail,
        userName: userName,
        userPhone: userPhone,
      ),
    ),
  );
  return result ?? false;
}

class _MandateSetupSheet extends StatefulWidget {
  final String linkedAccountId;
  final String userId;
  final String bankName;
  final String accountName;
  final String? userEmail;
  final String? userName;
  final String? userPhone;

  const _MandateSetupSheet({
    required this.linkedAccountId,
    required this.userId,
    required this.bankName,
    required this.accountName,
    this.userEmail,
    this.userName,
    this.userPhone,
  });

  @override
  State<_MandateSetupSheet> createState() => _MandateSetupSheetState();
}

class _MandateSetupSheetState extends State<_MandateSetupSheet> {
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MandateCubit, MandateState>(
      listener: (context, state) async {
        if (state is MandateCreated) {
          if (state.needsAuthorization && state.authorizationUrl != null) {
            final uri = Uri.parse(state.authorizationUrl!);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          }
          if (context.mounted) Navigator.of(context).pop(true);
        } else if (state is MandateError) {
          setState(() {
            _errorMessage = state.message;
          });
        }
      },
      builder: (context, state) {
        final isLoading = state is MandateLoading;

        return Padding(
          padding: EdgeInsets.fromLTRB(
            20.w,
            16.h,
            20.w,
            MediaQuery.of(context).viewInsets.bottom + 20.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF6B7280),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 24.h),

              // Shield icon
              Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.verified_user_rounded,
                  color: const Color(0xFF10B981),
                  size: 32.sp,
                ),
              ),
              SizedBox(height: 16.h),

              // Title
              Text(
                'Enable Auto-Debit',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),

              // Bank info
              Text(
                '${widget.bankName} - ${widget.accountName}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 12.h),

              // Explanation
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  'Authorize once to skip bank login for future transfers. '
                  'You set limits and can cancel anytime.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              // Benefits
              _buildBenefitRow(Icons.flash_on_rounded, 'Instant transfers without WebView'),
              _buildBenefitRow(Icons.lock_outline_rounded, 'You control limits & can cancel'),
              _buildBenefitRow(Icons.shield_outlined, 'Bank-level security & encryption'),
              SizedBox(height: 16.h),

              // Inline error message
              if (_errorMessage != null) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        color: const Color(0xFFEF4444),
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'Failed to enable auto-debit. Please try again.',
                          style: GoogleFonts.inter(
                            color: const Color(0xFFFCA5A5),
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
              ],

              // Enable button
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          setState(() => _errorMessage = null);
                          context.read<MandateCubit>().createMandate(
                                userId: widget.userId,
                                linkedAccountId: widget.linkedAccountId,
                                userEmail: widget.userEmail,
                                userName: widget.userName,
                                userPhone: widget.userPhone,
                              );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    disabledBackgroundColor:
                        const Color(0xFF10B981).withValues(alpha: 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Enable Auto-Debit',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 12.h),

              // Not now button
              TextButton(
                onPressed: isLoading ? null : () => Navigator.of(context).pop(false),
                child: Text(
                  'Not Now',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBenefitRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF10B981), size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                color: const Color(0xFFD1D5DB),
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
