import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/display_success_dialog.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/types/countries.dart';

class SetFingerPrint extends StatefulWidget {
  const SetFingerPrint({super.key});

  @override
  State<SetFingerPrint> createState() => _SetFingerPrintState();
}

class _SetFingerPrintState extends State<SetFingerPrint>
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

  Future<void> _scanFingerprint() async {
    setState(() {
      isScanning = true;
      scanProgress = 0.0;
    });

    // Simulate scanning progress
    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      setState(() {
        scanProgress = i / 100.0;
      });
    }

    // Authenticate using local_auth
    final bool didAuthenticate = await auth.authenticate(
      localizedReason: 'Please authenticate to set your fingerprint',
    );

    setState(() {
      isScanning = false;
    });
    if (context.mounted) {
      if (didAuthenticate) {
        // Handle successful authentication
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fingerprint set successfully!')),
        );
      } else {
        // Handle authentication failure
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication failed.')),
        );
      }
    }
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
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Add your fingerprint',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                    ),
                    child: UniversalImageLoader(
                        imagePath:
                            'assets/images/gifs/animated-fingerprint-scanner.gif',
                        height: 100.0,
                        width: 100.0),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Scanning (${(scanProgress * 100).toStringAsFixed(0)}%)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0.sp,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Place your finger on the sensor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 32.0.h),
                Container(
                  padding: EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: HybridHexColor.fromHex("#EBF3FE"),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Text(
                    "By enabling fingerprint, login becomes easier and faster",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () => displaySuccessDialog(
                  context: context,
                  iconPath: "assets/images/fingerprint-success.png",
                  title: "Fingerprint Added",
                  subtitle: "Fingerprint successfully added",
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
                  "Continue",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
