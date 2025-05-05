import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:lazervault/core/types/app_routes.dart';
// import 'package:lazervault/src/features/authentication/domain/entities/user.dart'; // No longer needed directly
import 'package:lazervault/src/features/widgets/common/back_navigator.dart';
import 'dart:math';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';

class TransferProof extends StatefulWidget {
  // final User recipient; // Replaced by details map
  final Map<String, dynamic> transferDetails;
  const TransferProof({super.key, required this.transferDetails});

  @override
  State<TransferProof> createState() => _TransferProofState();
}

class _TransferProofState extends State<TransferProof>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _starRotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 0.8, curve: Curves.easeIn),
      ),
    );

    _starRotationAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 1.0, curve: Curves.easeInOutBack),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Extract data from the map with default values
    final double amount = widget.transferDetails['amount'] as double? ?? 0.0;
    final String recipientName =
        widget.transferDetails['recipientName'] as String? ?? 'Recipient';
    // final double totalAmount = widget.transferDetails['totalAmount'] as double? ?? amount;
    // Extract timestamp and format it
    final DateTime timestamp =
        widget.transferDetails['timestamp'] as DateTime? ?? DateTime.now();
    final String formattedTimestamp =
        DateFormat('d MMM yyyy, HH:mm').format(timestamp);

    return Container(
      padding: EdgeInsets.only(left: 16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6C3CE9), // Consider using colors based on status or theme
            Color(0xFF6835E5),
          ],
        ),
      ),
      child: Scaffold(
        // Use Scaffold for better structure (AppBar, Body)
        backgroundColor:
            Colors.transparent, // Make Scaffold background transparent
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackNavigator(
              onPressed: () => Get.offAllNamed(AppRoutes.dashboard)),
          title: const Text('Transfer Receipt',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.h), // Space from AppBar
                // Animated Success Icon
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: UniversalImageLoader(
                    imagePath:
                        'assets/images/transfer-successful.png', // Keep using the success image
                    width: 180.w, // Adjusted size slightly
                    height: 180.h,
                  ),
                ),
                SizedBox(height: 30.h),

                // Success Text
                FadeTransition(
                  opacity: _opacityAnimation,
                  child: Column(
                    children: [
                      Text(
                        'Transfer Successful!', // More emphatic title
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.sp, // Slightly larger
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        // Use dynamic recipient name
                        'Your transfer to $recipientName has been initiated.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 15.sp, // Slightly larger
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Time: $formattedTimestamp', // Display formatted timestamp
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),

                // Amount Container - Now shows dynamic amount
                FadeTransition(
                  opacity: _opacityAnimation,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical: 16.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.25), // Slightly darker
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      // Format the dynamic amount
                      NumberFormat.currency(symbol: '£', decimalDigits: 2)
                          .format(amount),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.sp, // Slightly larger
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

                const Spacer(), // Pushes the button to the bottom

                // Button Container
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 24.h), // Padding at the bottom
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        // TODO: Implement actual receipt download logic
                        onPressed: () {
                          Get.snackbar(
                              'Info', 'Receipt download not implemented yet.',
                              snackPosition: SnackPosition.BOTTOM);
                          // Example: Get.find<ReceiptService>().downloadReceipt(widget.transferDetails);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1ED69E), // Existing color
                          foregroundColor:
                              Color(0xFF0A3D2E), // Darker text for contrast
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 5,
                          shadowColor: Colors.black.withOpacity(0.3),
                        ),
                        child: Text(
                          'Download Receipt',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ], // children of Column
            ),
          ),
        ),
      ),
    );
  }
}
