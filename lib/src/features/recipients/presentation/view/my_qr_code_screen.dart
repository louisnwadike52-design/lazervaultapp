import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../profile/cubit/profile_cubit.dart';
import '../../../profile/cubit/profile_state.dart';

/// My QR Code Screen - displays the user's QR code for others to scan
/// Contains user information that can be used for payments and transfers
class MyQRCodeScreen extends StatelessWidget {
  const MyQRCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1A3E),
              Color(0xFF0A0E27),
              Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoaded) {
                      return _buildQRCodeContent(context, state.user);
                    }

                    // Fallback to auth cubit if profile not loaded
                    final authCubit = context.read<AuthenticationCubit>();
                    final user = authCubit.currentProfile?.user;

                    if (user != null) {
                      return _buildQRCodeContent(context, user);
                    }

                    return _buildLoadingState();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My QR Code',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Share with others to receive payments',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRCodeContent(BuildContext context, dynamic user) {
    final fullName = '${user.firstName} ${user.lastName}';
    final username = user.username ?? user.email;

    // Create QR code data matching backend format
    final qrData = {
      'type': 'lazervault_recipient',
      'recipientId': user.id.toString(),
      'username': username,
      'name': fullName,
      'version': '1.0',
    };

    final qrString = jsonEncode(qrData);

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),

          // User Info Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF4E03D0),
                  Color(0xFF6B21E0),
                ],
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  child: Text(
                    fullName.isNotEmpty ? fullName[0].toUpperCase() : 'U',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  fullName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  '@$username',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          // QR Code Card
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Column(
              children: [
                QrImageView(
                  data: qrString,
                  version: QrVersions.auto,
                  size: 280.w,
                  backgroundColor: Colors.white,
                  errorCorrectionLevel: QrErrorCorrectLevel.M,
                  padding: EdgeInsets.all(16.w),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Scan to send me money',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF1F2937),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          // Instructions
          _buildInstructions(),

          SizedBox(height: 24.h),

          // Share Button
          _buildShareButton(),
        ],
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How it works',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          _buildInstructionItem(
            '1',
            'Share your QR code',
            'Show this QR code to someone who wants to send you money',
          ),
          SizedBox(height: 12.h),
          _buildInstructionItem(
            '2',
            'They scan it',
            'They open LazerVault and scan your QR code',
          ),
          SizedBox(height: 12.h),
          _buildInstructionItem(
            '3',
            'Receive payment',
            'Your details are auto-filled and they can send you money instantly',
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(String number, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Center(
            child: Text(
              number,
              style: GoogleFonts.inter(
                color: const Color(0xFF4E03D0),
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                description,
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShareButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          // TODO: Implement share functionality
          Get.snackbar(
            'Share',
            'Share functionality coming soon',
            backgroundColor: const Color(0xFF10B981),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        icon: Icon(Icons.share, size: 20.sp, color: Colors.white),
        label: Text(
          'Share QR Code',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: Color(0xFF4E03D0),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading your QR code...',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
