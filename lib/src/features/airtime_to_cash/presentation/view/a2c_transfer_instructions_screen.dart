import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/network_rate.dart';
import '../widgets/a2c_step_indicator.dart';

/// Screen 3: Display VTU Africa phone number and transfer instructions
/// CRITICAL: This screen shows the phone number from merchant-verify API
/// User must transfer airtime to this number BEFORE proceeding
class A2CTransferInstructionsScreen extends StatefulWidget {
  const A2CTransferInstructionsScreen({super.key});

  @override
  State<A2CTransferInstructionsScreen> createState() =>
      _A2CTransferInstructionsScreenState();
}

class _A2CTransferInstructionsScreenState
    extends State<A2CTransferInstructionsScreen> {
  String? network;
  NetworkRate? rate;
  String? providerName;
  String? destinationPhone;
  bool? requiresTransfer;
  double? amount;

  @override
  void initState() {
    super.initState();
    _loadArguments();
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      network = args['network'] as String?;
      rate = args['rate'] as NetworkRate?;
      providerName = args['providerName'] as String?;
      destinationPhone = args['destinationPhone'] as String?;
      requiresTransfer = args['requiresTransfer'] as bool?;
    }
  }

  void _onConfirmTransfer() {
    // User confirms they've transferred the airtime
    // Now navigate to phone input to continue the flow
    Get.toNamed(AppRoutes.airtimeToCashPhoneInput, arguments: {
      'network': network,
      'rate': rate,
      'vtuAfricaPhone': destinationPhone,
      'providerName': providerName,
      'requiresTransfer': requiresTransfer,
    });
  }

  @override
  Widget build(BuildContext context) {
    final networkColor = _getNetworkColor(network ?? '');

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const A2CStepIndicator(currentStep: 2),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),

                    // Warning banner
                    _buildWarningBanner(),

                    SizedBox(height: 24.h),

                    // Phone number card
                    _buildPhoneNumberCard(networkColor),

                    SizedBox(height: 24.h),

                    // Instructions
                    _buildInstructions(),

                    SizedBox(height: 24.h),

                    // Important notice
                    _buildImportantNotice(),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
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
                  'Transfer Airtime',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Send airtime to VTU Africa number',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningBanner() {
    // Only show warning banner for VTU Africa (requires manual transfer)
    if (requiresTransfer != true) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFB923C).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFFB923C).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: const Color(0xFFFB923C),
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'IMPORTANT: Transfer First',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFB923C),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'You MUST transfer the airtime to the number below BEFORE clicking confirm. Your account may be blocked if you proceed without transferring.',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF9CA3AF),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneNumberCard(Color networkColor) {
    // For Automation provider, we show a different message
    final bool isVTUAfrica = providerName == 'vtuafrica';
    final displayPhone = isVTUAfrica ? (destinationPhone ?? '08124139638') : 'See next step';

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            networkColor.withValues(alpha: 0.15),
            networkColor.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: networkColor.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: networkColor.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Provider badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: networkColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              '${providerName?.toUpperCase() ?? ''} PROVIDER',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: networkColor,
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // Label
          Text(
            isVTUAfrica ? 'Transfer Your Airtime To' : 'Provider: Automation',
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),

          SizedBox(height: 12.h),

          // Phone number (large) - only for VTU Africa
          if (isVTUAfrica)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone,
                    color: networkColor,
                    size: 28.sp,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    displayPhone,
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),

          if (isVTUAfrica) SizedBox(height: 16.h),

          // Copy button (only for VTU Africa)
          if (isVTUAfrica)
            GestureDetector(
              onTap: () {
                // Copy to clipboard
                Get.snackbar(
                  'Copied!',
                  'Phone number copied to clipboard',
                  backgroundColor: const Color(0xFF10B981),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: networkColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.copy,
                      color: networkColor,
                      size: 16.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Copy Number',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: networkColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Automation provider message
          if (!isVTUAfrica)
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: const Color(0xFF10B981),
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Automation provider will handle the transfer automatically. Proceed to enter your phone number.',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color(0xFF9CA3AF),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How to Transfer',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildInstructionStep(
            1,
            'Open your phone\'s dialer or USSD menu',
          ),
          SizedBox(height: 12.h),
          _buildInstructionStep(
            2,
            'Select "Transfer" or "Share" airtime option',
          ),
          SizedBox(height: 12.h),
          _buildInstructionStep(
            3,
            'Enter the phone number shown above',
          ),
          SizedBox(height: 12.h),
          _buildInstructionStep(
            4,
            'Enter the EXACT amount you want to convert',
          ),
          SizedBox(height: 12.h),
          _buildInstructionStep(
            5,
            'Complete the transfer',
          ),
          SizedBox(height: 12.h),
          _buildInstructionStep(
            6,
            'Return here and click "I Have Transferred"',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionStep(int step, String text, {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28.w,
          height: 28.w,
          decoration: BoxDecoration(
            color: isLast
                ? const Color(0xFF10B981).withValues(alpha: 0.15)
                : const Color(0xFF3B82F6).withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: isLast ? const Color(0xFF10B981) : const Color(0xFF3B82F6),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.white.withValues(alpha: isLast ? 1.0 : 0.8),
              fontWeight: isLast ? FontWeight.w600 : FontWeight.normal,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImportantNotice() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFEF4444).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: const Color(0xFFEF4444),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Important Notice',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFEF4444),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            '• Transfer the EXACT amount you want to convert\n'
            '• Make sure you have sufficient airtime balance\n'
            '• The transfer must be from the same network you selected\n'
            '• Do NOT proceed until you have completed the transfer',
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF9CA3AF),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _onConfirmTransfer,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF10B981),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 18.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            elevation: 0,
          ),
          child: Column(
            children: [
              Text(
                'I Have Transferred the Airtime',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Click only after completing the transfer',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getNetworkColor(String network) {
    switch (network.toLowerCase()) {
      case 'mtn':
        return const Color(0xFFFFCC00);
      case 'airtel':
        return const Color(0xFFEF4444);
      case 'glo':
        return const Color(0xFF10B981);
      case '9mobile':
        return const Color(0xFF00A651);
      default:
        return const Color(0xFF3B82F6);
    }
  }
}
