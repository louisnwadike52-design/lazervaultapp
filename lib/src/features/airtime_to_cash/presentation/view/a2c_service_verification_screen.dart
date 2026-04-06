import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/network_rate.dart';
import '../cubit/airtime_to_cash_cubit.dart';
import '../cubit/airtime_to_cash_state.dart';
import '../widgets/a2c_step_indicator.dart';

/// Screen 2: Verify VTU Africa service availability and get destination phone number
/// This follows VTU Africa's requirement to verify service BEFORE proceeding
class A2CServiceVerificationScreen extends StatefulWidget {
  const A2CServiceVerificationScreen({super.key});

  @override
  State<A2CServiceVerificationScreen> createState() =>
      _A2CServiceVerificationScreenState();
}

class _A2CServiceVerificationScreenState
    extends State<A2CServiceVerificationScreen> {
  String? network;
  NetworkRate? rate;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _loadArguments();
    _verifyService();
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      network = args['network'] as String?;
      rate = args['rate'] as NetworkRate?;
    }
  }

  Future<void> _verifyService() async {
    if (network == null) {
      _showError('Network information missing. Please go back and try again.');
      return;
    }

    setState(() => _isVerifying = true);

    // Call the backend to verify service availability
    if (!mounted) return;
    context.read<AirtimeToCashCubit>().verifyService(network!);
  }

  void _navigateToTransferInstructions(
    String providerName,
    String destinationPhone,
    bool requiresTransfer,
  ) {
    if (!mounted) return;
    setState(() => _isVerifying = false);

    Get.toNamed(AppRoutes.airtimeToCashTransferInstructions, arguments: {
      'network': network,
      'rate': rate,
      'providerName': providerName,
      'destinationPhone': destinationPhone,
      'requiresTransfer': requiresTransfer,
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const A2CStepIndicator(currentStep: 1),
            Expanded(
              child: BlocConsumer<AirtimeToCashCubit, AirtimeToCashState>(
                listener: (context, state) {
                  if (state is AirtimeToCashServiceVerified) {
                    // Service verified successfully - navigate to transfer instructions
                    _navigateToTransferInstructions(
                      state.providerName,
                      state.destinationPhone,
                      state.requiresTransfer,
                    );
                  } else if (state is AirtimeToCashError) {
                    setState(() => _isVerifying = false);
                    _showError(state.message);
                  }
                },
                builder: (context, state) {
                  if (state is AirtimeToCashVerifying || _isVerifying) {
                    return _buildLoadingState();
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
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
                  'Verifying Service',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Checking ${network?.toUpperCase() ?? ''} service availability',
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

  Widget _buildLoadingState() {
    final networkColor = _getNetworkColor(network ?? '');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildVerificationAnimation(networkColor),
          SizedBox(height: 32.h),
          _buildVerifyingText(),
        ],
      ),
    );
  }

  Widget _buildVerificationAnimation(Color networkColor) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer pulsing circle
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.8, end: 1.2),
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: 150.w,
                  height: 150.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: networkColor.withValues(alpha: 0.1),
                  ),
                ),
              );
            },
          ),
          // Middle circle
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: networkColor.withValues(alpha: 0.2),
            ),
          ),
          // Inner loading indicator
          SizedBox(
            width: 60.w,
            height: 60.w,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(networkColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifyingText() {
    return Column(
      children: [
        Text(
          'Verifying Service',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'Checking if ${network?.toUpperCase() ?? ''} Airtime2Cash service is available...',
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFF9CA3AF),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          'This ensures we can process your conversion',
          style: TextStyle(
            fontSize: 12.sp,
            color: const Color(0xFF9CA3AF).withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: const Color(0xFF3B82F6),
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'You will now see the phone number to transfer your airtime to',
              style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xFF9CA3AF),
                height: 1.4,
              ),
            ),
          ),
        ],
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
