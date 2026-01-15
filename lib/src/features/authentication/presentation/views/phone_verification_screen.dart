import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_verification_state.dart';
import 'package:lazervault/src/features/widgets/verification_code_input.dart';

class PhoneVerificationScreen extends StatelessWidget {
  final String? phoneNumber;

  const PhoneVerificationScreen({super.key, this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<PhoneVerificationCubit>(),
      child: _PhoneVerificationView(phoneNumber: phoneNumber),
    );
  }
}

class _PhoneVerificationView extends StatefulWidget {
  final String? phoneNumber;

  const _PhoneVerificationView({this.phoneNumber});

  @override
  State<_PhoneVerificationView> createState() => _PhoneVerificationViewState();
}

class _PhoneVerificationViewState extends State<_PhoneVerificationView> {
  final TextEditingController _phoneController = TextEditingController();
  bool _codeSent = false;

  @override
  void initState() {
    super.initState();
    if (widget.phoneNumber != null) {
      _phoneController.text = widget.phoneNumber!;
      context.read<PhoneVerificationCubit>().updatePhoneNumber(widget.phoneNumber!);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PhoneVerificationCubit>().updateVerificationCode('');
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent back navigation - verification is mandatory
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<PhoneVerificationCubit, PhoneVerificationState>(
          listener: (context, state) {
            if (state is PhoneVerificationCodeSent) {
              setState(() => _codeSent = true);
              Get.snackbar(
                'Success',
                state.message,
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                margin: EdgeInsets.all(16.w),
                borderRadius: 12.r,
                duration: const Duration(seconds: 3),
              );
            } else if (state is PhoneVerificationSuccess) {
              Get.snackbar(
                'Success',
                state.message,
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                margin: EdgeInsets.all(16.w),
                borderRadius: 12.r,
                duration: const Duration(seconds: 2),
              );
              Future.delayed(const Duration(milliseconds: 500), () {
                Get.offAllNamed(AppRoutes.passcodeSetup);
              });
            // Skip case removed - verification is now mandatory
            // } else if (state is PhoneVerificationSkipped) {
            //   Get.offAllNamed(AppRoutes.dashboard);
            } else if (state is PhoneVerificationFailure) {
            Get.snackbar(
              'Error',
              state.message,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.redAccent,
              colorText: Colors.white,
              margin: EdgeInsets.all(16.w),
              borderRadius: 12.r,
              duration: const Duration(seconds: 3),
            );
          } else if (state is PhoneVerificationInProgress) {
            if (state.errorMessage.isNotEmpty) {
              Get.snackbar(
                'Error',
                state.errorMessage,
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.redAccent,
                colorText: Colors.white,
                margin: EdgeInsets.all(16.w),
                borderRadius: 12.r,
                duration: const Duration(seconds: 3),
              );
            }
            if (state.successMessage.isNotEmpty) {
              Get.snackbar(
                'Success',
                state.successMessage,
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                margin: EdgeInsets.all(16.w),
                borderRadius: 12.r,
                duration: const Duration(seconds: 2),
              );
            }
          }
        },
        child: BlocBuilder<PhoneVerificationCubit, PhoneVerificationState>(
          builder: (context, state) {
            final isSending = state is PhoneVerificationSending;
            final isVerifying = state is PhoneVerificationVerifying;

            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.h),

                    // Header
                    Center(
                      child: Container(
                        width: 80.w,
                        height: 80.h,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4E03D0), Color(0xFF7C3AED)],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.phone_android,
                          size: 40.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    Center(
                      child: Text(
                        'Phone Verification',
                        style: GoogleFonts.inter(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    Center(
                      child: Text(
                        _codeSent
                            ? 'Enter the verification code sent to your phone'
                            : 'Enter your phone number to receive a verification code',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),

                    if (!_codeSent) ...[
                      // Phone Number Input
                      Text(
                        'Phone Number',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF374151),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          context.read<PhoneVerificationCubit>().updatePhoneNumber(value);
                        },
                        decoration: InputDecoration(
                          hintText: '+1 (555) 000-0000',
                          hintStyle: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                          ),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: const Color(0xFF4E03D0),
                            size: 20.sp,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF9FAFB),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color(0xFFE5E7EB),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color(0xFFE5E7EB),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color(0xFF4E03D0),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Send Code Button
                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: isSending
                              ? null
                              : () {
                                  final phone = _phoneController.text.trim();
                                  if (phone.isEmpty) {
                                    Get.snackbar(
                                      'Error',
                                      'Please enter your phone number',
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: Colors.redAccent,
                                      colorText: Colors.white,
                                    );
                                    return;
                                  }
                                  context.read<PhoneVerificationCubit>()
                                      .requestPhoneVerification(phoneNumber: phone);
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4E03D0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: isSending
                              ? SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Send Verification Code',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ] else ...[
                      // Verification Code Input
                      Text(
                        'Verification Code',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF374151),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      VerificationCodeInput(
                        onCompleted: (code) {
                          context.read<PhoneVerificationCubit>()
                              .updateVerificationCode(code);
                        },
                        onChanged: (code) {
                          context.read<PhoneVerificationCubit>()
                              .updateVerificationCode(code);
                        },
                      ),
                      SizedBox(height: 24.h),

                      // Verify Button
                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: isVerifying
                              ? null
                              : () {
                                  if (state is PhoneVerificationInProgress) {
                                    if (state.verificationCode.length != 6) {
                                      Get.snackbar(
                                        'Error',
                                        'Please enter the complete 6-digit code',
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor: Colors.redAccent,
                                        colorText: Colors.white,
                                      );
                                      return;
                                    }
                                    context.read<PhoneVerificationCubit>().verifyPhoneNumber(
                                          phoneNumber: state.phoneNumber,
                                          verificationCode: state.verificationCode,
                                        );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4E03D0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: isVerifying
                              ? SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Verify Phone Number',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Resend Code
                      Center(
                        child: TextButton(
                          onPressed: isSending
                              ? null
                              : () {
                                  context.read<PhoneVerificationCubit>()
                                      .resendVerificationCode(phoneNumber: _phoneController.text);
                                },
                          child: Text(
                            'Resend Code',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF4E03D0),
                            ),
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 24.h),

                    // Note: Skip button removed - phone verification is now mandatory

                    SizedBox(height: 40.h),

                    // Info Card
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: const Color(0xFF4E03D0),
                            size: 24.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'We\'ll send you a 6-digit verification code via SMS. Standard message rates may apply.',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: const Color(0xFF374151),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ));
  }
}
