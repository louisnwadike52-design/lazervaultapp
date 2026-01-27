import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../cubit/whatsapp_banking_cubit.dart';
import '../../cubit/whatsapp_banking_state.dart';

class WhatsAppLinkingScreen extends StatefulWidget {
  const WhatsAppLinkingScreen({super.key});

  @override
  State<WhatsAppLinkingScreen> createState() => _WhatsAppLinkingScreenState();
}

class _WhatsAppLinkingScreenState extends State<WhatsAppLinkingScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _otpSent = false;
  String _phoneNumber = '';
  int _remainingSeconds = 300;
  Timer? _timer;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _remainingSeconds = 300;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _sendOTP() {
    if (!_formKey.currentState!.validate()) return;
    _phoneNumber = _phoneController.text;
    context.read<WhatsAppBankingCubit>().initiateLinking(_phoneNumber);
  }

  void _verifyOTP() {
    if (_otpController.text.length != 6) return;
    context.read<WhatsAppBankingCubit>().verifyLinking(_phoneNumber, _otpController.text);
  }

  void _resendOTP() {
    if (_remainingSeconds > 240) {
      Get.snackbar(
        'Please Wait',
        'You can resend OTP after ${_formatTime(_remainingSeconds - 240)}',
        backgroundColor: Colors.orange.withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(16.w),
      );
      return;
    }
    _sendOTP();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        contentPadding: EdgeInsets.all(24.w),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 78, 3, 208),
                    Color.fromARGB(255, 120, 40, 230),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 48.sp,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Account Linked!',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'You can now access all LazerVault services via WhatsApp',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 78, 3, 208),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 32.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 78, 3, 208),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Link WhatsApp',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<WhatsAppBankingCubit, WhatsAppBankingState>(
        listener: (context, state) {
          if (state is WhatsAppBankingOtpSent) {
            setState(() => _otpSent = true);
            _startTimer();
            Get.snackbar(
              'OTP Sent',
              'Check your WhatsApp for the verification code',
              backgroundColor: Colors.green.withValues(alpha: 0.9),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              duration: Duration(seconds: 3),
              margin: EdgeInsets.all(16.w),
            );
          } else if (state is WhatsAppBankingLinkingSuccess) {
            _timer?.cancel();
            _showSuccessDialog();
          } else if (state is WhatsAppBankingError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: Colors.red.withValues(alpha: 0.9),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              duration: Duration(seconds: 3),
              margin: EdgeInsets.all(16.w),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is WhatsAppBankingLoading;
          return SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Icon
                  Container(
                    width: 80.w,
                    height: 80.w,
                    margin: EdgeInsets.only(bottom: 24.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                          Color.fromARGB(255, 120, 40, 230).withValues(alpha: 0.1),
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.chat_bubble_outline,
                      size: 40.sp,
                      color: Color.fromARGB(255, 78, 3, 208),
                    ),
                  ),

                  // Title
                  Text(
                    _otpSent ? 'Enter Verification Code' : 'Link Your WhatsApp',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),

                  // Subtitle
                  Text(
                    _otpSent
                        ? 'We sent a 6-digit code to your WhatsApp\n$_phoneNumber'
                        : 'Enter your phone number to receive a verification code via WhatsApp',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),

                  // Phone Number Input (only show if OTP not sent)
                  if (!_otpSent) ...[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 16.sp),
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Color.fromARGB(255, 78, 3, 208),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length < 10) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Info Card
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Color.fromARGB(255, 78, 3, 208),
                            size: 20.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'Make sure this number is linked to your WhatsApp account',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black87,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // OTP Input (only show if OTP sent)
                  if (_otpSent) ...[
                    // Timer
                    if (_remainingSeconds > 0)
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                        margin: EdgeInsets.only(bottom: 20.h),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: Color.fromARGB(255, 78, 3, 208),
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Code expires in ${_formatTime(_remainingSeconds)}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 78, 3, 208),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // OTP Input
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 8.w,
                        ),
                        maxLength: 6,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(
                          hintText: '000000',
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(vertical: 20.h),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Resend OTP
                    TextButton(
                      onPressed: isLoading ? null : _resendOTP,
                      child: Text(
                        'Didn\'t receive code? Resend',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 78, 3, 208),
                        ),
                      ),
                    ),
                  ],

                  SizedBox(height: 32.h),

                  // Action Button
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : (_otpSent ? _verifyOTP : _sendOTP),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 78, 3, 208),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 4,
                    ),
                    child: isLoading
                        ? SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            _otpSent ? 'Verify & Link Account' : 'Send Verification Code',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
