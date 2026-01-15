import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/services/voice_biometrics_service.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/voice/managers/voice_activation_manager.dart';
import 'package:lazervault/src/features/voice_enrollment/presentation/voice_enrollment_screen.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:get/get.dart';

/// Voice Activation Prompt Screen
/// Shows friendly onboarding for voice enrollment with skip option
class VoiceActivationPromptScreen extends StatefulWidget {
  final String userId;
  final bool isMandatory;

  const VoiceActivationPromptScreen({
    Key? key,
    required this.userId,
    this.isMandatory = false,
  }) : super(key: key);

  @override
  State<VoiceActivationPromptScreen> createState() =>
      _VoiceActivationPromptScreenState();
}

class _VoiceActivationPromptScreenState
    extends State<VoiceActivationPromptScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Track skip count (max 3 skips before mandatory)
  Future<int> get _skipCount async {
    final storage = GetIt.I<FlutterSecureStorage>();
    final skips = await storage.read(key: 'voice_activation_skips');
    return int.tryParse(skips ?? '0') ?? 0;
  }

  Future<void> _incrementSkipCount() async {
    final storage = GetIt.I<FlutterSecureStorage>();
    final currentSkips = await _skipCount;
    await storage.write(key: 'voice_activation_skips', value: '${currentSkips + 1}');
  }

  Future<void> _resetSkipCount() async {
    final storage = GetIt.I<FlutterSecureStorage>();
    await storage.delete(key: 'voice_activation_skips');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with skip button
            _buildHeader(context),

            // Page view for onboarding
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildWelcomePage(),
                  _buildCapabilitiesPage(),
                  _buildHowItWorksPage(),
                  _buildEnrollPage(),
                ],
              ),
            ),

            // Page indicators and action buttons
            _buildBottomNavigation(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Close button
          IconButton(
            onPressed: () => _handleSkip(context),
            icon: const Icon(Icons.close),
            iconSize: 28,
          ),

          // Progress indicator
          Text(
            '${_currentPage + 1} of 4',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomePage() {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated microphone icon
          Container(
            width: 150.w,
            height: 150.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue[400]!,
                  Colors.blue[600]!,
                  Colors.purple[600]!,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Icon(
              Icons.mic_rounded,
              size: 80.sp,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 48.h),

          Text(
            'Welcome to Voice Banking',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 16.h),

          Text(
            'Bank securely with just your voice',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 32.h),

          _buildFeatureCard(
            Icons.security_rounded,
            'Secure',
            'Your voice is your password',
          ),

          SizedBox(height: 16.h),

          _buildFeatureCard(
            Icons.flash_on_rounded,
            'Fast',
            'Complete tasks in seconds',
          ),

          SizedBox(height: 16.h),

          _buildFeatureCard(
    Icons.touch_app_rounded,
            'Hands-free',
            'Bank while on the go',
          ),
        ],
      ),
    );
  }

  Widget _buildCapabilitiesPage() {
    final capabilities = [
      {
        'icon': Icons.send_rounded,
        'title': 'Send Money',
        'description': 'Send money to friends and family',
        'command': '"Send \$50 to John"',
      },
      {
        'icon': Icons.account_balance_rounded,
        'title': 'Check Balance',
        'description': 'Get account balances instantly',
        'command': '"What\'s my balance?"',
      },
      {
        'icon': Icons.show_chart_rounded,
        'title': 'Trade Stocks',
        'description': 'Buy and sell stocks by voice',
        'command': '"Buy 10 shares of Apple"',
      },
      {
        'icon': Icons.receipt_long_rounded,
        'title': 'Pay Bills',
        'description': 'Pay utility bills easily',
        'command': '"Pay my electricity bill"',
      },
      {
        'icon': Icons.credit_card_rounded,
        'title': 'Manage Cards',
        'description': 'Control your cards with voice',
        'command': '"Freeze my card"',
      },
      {
        'icon': Icons.phone_rounded,
        'title': 'Buy Airtime',
        'description': 'Top up your phone instantly',
        'command': '"Recharge \$20 of airtime"',
      },
    ];

    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32.h),

          Text(
            'What You Can Do',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: 16.h),

          Text(
            'Control your entire banking experience with voice commands',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
            ),
          ),

          SizedBox(height: 24.h),

          Expanded(
            child: ListView.builder(
              itemCount: capabilities.length,
              itemBuilder: (context, index) {
                final capability = capabilities[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 12.h),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        Container(
                          width: 56.w,
                          height: 56.w,
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            capability['icon'] as IconData,
                            color: Colors.blue[700],
                            size: 28,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                capability['title'] as String,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                capability['description'] as String,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[600],
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
        ],
      ),
    );
  }

  Widget _buildHowItWorksPage() {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        children: [
          SizedBox(height: 32.h),

          Text(
            'How It Works',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 48.h),

          _buildStep(
            step: 1,
            title: 'Record Your Voice',
            description: 'We\'ll record 5 voice samples to create your unique voice profile',
            icon: Icons.mic_rounded,
          ),

          SizedBox(height: 32.h),

          _buildStep(
            step: 2,
            title: 'Voice is Your Password',
            description: 'Your voice profile is used to verify your identity securely',
            icon: Icons.lock_rounded,
          ),

          SizedBox(height: 32.h),

          _buildStep(
            step: 3,
            title: 'Bank with Voice',
            description: 'Use voice commands for secure, hands-free banking',
            icon: Icons.check_circle_rounded,
          ),

          SizedBox(height: 48.h),

          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.green[700]),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Setup only takes 2 minutes. You can do it anytime, anywhere!',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.green[900],
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

  Widget _buildStep({
    required int step,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue[700],
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 20, color: Colors.blue[700]),
                  SizedBox(width: 8.w),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEnrollPage() {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Success animation
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green[400]!,
                  Colors.green[600]!,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Icon(
              Icons.mic_rounded,
              size: 64.sp,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 48.h),

          Text(
            'Ready to Activate Voice?',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 16.h),

          Text(
            'You\'re one step away from secure, hands-free banking',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 48.h),

          _buildRequirementItem(
            Icons.check_circle_rounded,
            'Takes only 2 minutes',
            Colors.green,
          ),

          SizedBox(height: 16.h),

          _buildRequirementItem(
            Icons.check_circle_rounded,
            'Record 5 voice samples',
            Colors.green,
          ),

          SizedBox(height: 16.h),

          _buildRequirementItem(
            Icons.check_circle_rounded,
            'Works anywhere, anytime',
            Colors.green,
          ),

          SizedBox(height: 16.h),

          _buildRequirementItem(
            Icons.security_rounded,
            'Bank-grade security',
            Colors.blue,
          ),

          SizedBox(height: 48.h),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(width: 12.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String description) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[700], size: 24),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: _currentPage == index ? 24.w : 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.blue[700]
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Action buttons
            Row(
              children: [
                // Back button (except on first page)
                if (_currentPage > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        if (_currentPage > 0) {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),

                if (_currentPage > 0) SizedBox(width: 16.w),

                // Next/Activate button
                Expanded(
                  flex: _currentPage > 0 ? 1 : 2,
                  child: ElevatedButton(
                    onPressed: () => _handleNext(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      _currentPage == 3 ? 'Activate Now' : 'Next',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Skip button (only on first 3 pages)
            if (_currentPage < 3 && !widget.isMandatory)
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: TextButton(
                  onPressed: () => _handleSkip(context),
                  child: Text(
                    'Skip for now',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _handleNext(BuildContext context) {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Last page - navigate to enrollment
      _resetSkipCount();
      Get.toNamed(
        AppRoutes.voiceEnrollment,
        arguments: {'userId': widget.userId},
      );
    }
  }

  Future<void> _handleSkip(BuildContext context) async {
    if (widget.isMandatory) {
      // Can't skip if mandatory
      return;
    }

    final skips = await _skipCount;
    final maxSkips = 3;

    if (skips >= maxSkips) {
      // Show mandatory dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Row(
            children: [
              Icon(Icons.warning_rounded, color: Colors.orange[700]),
              SizedBox(width: 12.w),
              const Expanded(child: Text('Voice Activation Required')),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You\'ve skipped voice activation $maxSkips times. For your security, voice activation is now required.',
              ),
              SizedBox(height: 16.h),
              const Text(
                'Voice banking adds an extra layer of security to protect your account from unauthorized access.',
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                // Go to first page
                _pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(
                'Activate Now',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ),
          ],
        ),
      );
      return;
    }

    // Show skip confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: const Text('Skip Voice Activation?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You have ${maxSkips - skips} skip${maxSkips - skips == 1 ? '' : 's'} remaining before voice activation becomes mandatory.',
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange[700], size: 20),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Some features require voice activation for security',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.orange[900],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[600],
            ),
            child: const Text('Skip Anyway'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _incrementSkipCount();
      if (mounted) {
        Get.back(); // Go to dashboard
      }
    }
  }
}
