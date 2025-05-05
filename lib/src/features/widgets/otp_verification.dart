import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/avatar_with_details.dart';
import 'package:lazervault/src/features/widgets/themed_app_bar.dart';
import 'package:local_auth/local_auth.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification>
    with SingleTickerProviderStateMixin {
  final LocalAuthentication auth = LocalAuthentication();

  // Existing fields
  double scanProgress = 0.0;
  bool isScanning = false;
  late AnimationController _controller;
  bool isPasswordObscured = true;

  // New field to store entered passcode
  String _enteredPasscode = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsiveController = ResponsiveController(context);

    return Column(
      children: [
        ThemedAppBar(
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Get.back();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("No route to go back."),
                      ),
                    );
                  }
                })),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 4.0.h),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AvatarWithDetails(
                    avatar: AppData.dp,
                  ),
                  SizedBox(height: 24.0.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Verify it's you",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8.0.h),
                      SizedBox(
                        width: responsiveController.screenWidth * 0.7,
                        child: Text(
                          "We sent a code to ( *****@mail.com ). Enter it here to verify your identity",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 38.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      6,
                      (index) => Container(
                        width: 40.0.w,
                        height: 40.0.h,
                        margin: EdgeInsets.symmetric(horizontal: 4.0.w),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12.0.r),
                        ),
                        child: Center(
                          child: Text(
                            _enteredPasscode.length > index
                                ? _enteredPasscode[index]
                                : '',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      mainAxisSpacing: 16.h,
                      crossAxisSpacing: 16.w,
                      childAspectRatio: 2.5,
                      children: [
                        ...List.generate(9, (index) {
                          final number = (index + 1).toString();
                          return _buildNumberButton(number);
                        }),
                        const SizedBox.shrink(),
                        _buildNumberButton('0'),
                        IconButton(
                          icon: const Icon(Icons.backspace),
                          color: Colors.blue,
                          onPressed: () {
                            setState(() {
                              if (_enteredPasscode.isNotEmpty) {
                                _enteredPasscode = _enteredPasscode.substring(
                                  0,
                                  _enteredPasscode.length - 1,
                                );
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.all(8.0),
                        ),
                        onPressed: () {},
                        child: Text("Resend code",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black54,
                            )),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 32.0,
                      ),
                      minimumSize: Size(double.infinity, 36.h),
                    ),
                    onPressed: () {
                      if (_enteredPasscode.length == 6) {
                        Get.toNamed(AppRoutes.createNewPassword);
                      }
                    },
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberButton(String number) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        backgroundColor: Colors.blue,
        padding: EdgeInsets.all(8.r),
        elevation: 0,
      ),
      onPressed: () {
        if (_enteredPasscode.length < 6) {
          setState(() {
            _enteredPasscode += number;
          });
        }
      },
      child: Text(
        number,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}
