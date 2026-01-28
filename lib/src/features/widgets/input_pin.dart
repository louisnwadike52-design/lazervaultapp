import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

class InputPin extends StatefulWidget {
  final User recipient;
  const InputPin({super.key, required this.recipient});

  @override
  State<InputPin> createState() => _InputPinState();
}

class _InputPinState extends State<InputPin> with CodeAutoFill {
  final TextEditingController _pinController = TextEditingController();
  String? appSignature;
  bool isLoading = false;

  @override
  void codeUpdated() {
    setState(() {
      _pinController.text = code ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    listenForCode();
    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          // Top Section with Icon
          Container(
            margin: EdgeInsets.only(top: 32.h, bottom: 24.h),
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.1),
            ),
            child: Icon(
              Icons.lock_outline_rounded,
              color: Colors.white,
              size: 32.w,
            ),
          ),

          // Title and Subtitle
          Text(
            "Enter PIN",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            "Please enter your 4-digit PIN to\nauthorize this transaction",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.7),
              height: 1.5,
            ),
          ),
          SizedBox(height: 40.h),

          // PIN Input Field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: PinCodeTextField(
              controller: _pinController,
              appContext: context,
              length: 4,
              obscureText: true,
              obscuringCharacter: '●',
              blinkWhenObscuring: true,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.circle,
                borderRadius: BorderRadius.circular(24.r),
                fieldHeight: 56.h,
                fieldWidth: 56.w,
                activeFillColor: Colors.white.withValues(alpha: 0.15),
                selectedFillColor: Colors.white.withValues(alpha: 0.2),
                inactiveFillColor: Colors.white.withValues(alpha: 0.1),
                activeColor: Colors.white.withValues(alpha: 0.3),
                selectedColor: Colors.white,
                inactiveColor: Colors.transparent,
              ),
              cursorColor: Colors.white,
              animationDuration: const Duration(milliseconds: 200),
              enableActiveFill: true,
              keyboardType: TextInputType.number,
              onChanged: (value) {},
              beforeTextPaste: (text) => true,
            ),
          ),
          SizedBox(height: 40.h),

          // Confirm Button
          Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.2),
                  Colors.white.withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(28.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(28.r),
                onTap: () async {
                  if (_pinController.text.length == 4) {
                    setState(() => isLoading = true);
                    try {
                      await Future.delayed(Duration(seconds: 1)); // Simulate API call
                      Get.toNamed(AppRoutes.transferProof, arguments: widget.recipient);
                    } finally {
                      setState(() => isLoading = false);
                    }
                  } else {
                    Get.snackbar(
                      'Invalid PIN',
                      'Please enter a valid 4-digit PIN',
                      backgroundColor: Colors.white.withValues(alpha: 0.1),
                      colorText: Colors.white,
                      snackPosition: SnackPosition.TOP,
                    );
                  }
                },
                child: Center(
                  child: isLoading
                      ? SizedBox(
                          width: 24.w,
                          height: 24.w,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          "Confirm",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                ),
              ),
            ),
          ),

          // Forgot PIN Link
          TextButton(
            onPressed: () {
              // Handle forgot PIN
            },
            child: Text(
              "Forgot PIN?",
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
