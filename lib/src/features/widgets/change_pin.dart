import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/display_success_dialog.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/types/countries.dart';

class ChangePin extends StatefulWidget {
  const ChangePin({super.key});

  @override
  State<ChangePin> createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin>
    with SingleTickerProviderStateMixin {
  Country selectedCountry = AppData.countries.first;
  final LocalAuthentication auth = LocalAuthentication();
  double scanProgress = 0.0;
  bool isScanning = false;
  late AnimationController _controller;

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
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 24.0.h,
              children: [
                BuildFormField(
                  name: "oldPin",
                  placeholder: "****",
                  labelText: "Old Pin",
                ),
                BuildFormField(
                  name: "newPin",
                  placeholder: "Enter new Pin",
                  labelText: "New Pin",
                ),
                BuildFormField(
                  name: "confirmPin",
                  placeholder: "Re-enter new Pin",
                  labelText: "Re-enter New Pin",
                ),
                Column(
                  spacing: 8.0.h,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Fingerprint Authentication",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0.sp),
                    ),
                    Text("Use your fingerprint to verify your identity",
                        style: TextStyle(
                          fontSize: 14.0.sp,
                          color: HybridHexColor.fromHex("#A3A3A3"),
                        )),
                    SizedBox(height: 16.0.h),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _controller.value * 2 * 3.14,
                          child: child,
                        );
                      },
                      child: Icon(
                        Icons.fingerprint,
                        size: 130.0.r,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => displaySuccessDialog(
              context: context,
              iconPath: "assets/images/pin-success.png",
              title: "Pin changed",
              subtitle: "Pin has been changed successfully",
              confirmationText: "Done",
              dismissText: "Back to home",
              onConfirm: () => Get.offAllNamed(AppRoutes.dashboard),
              onDismiss: () => Get.offAllNamed(AppRoutes.dashboard),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: HybridHexColor.fromHex("#3784F9"),
              foregroundColor: Colors.white,
            ),
            child: Text(
              "Done",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
