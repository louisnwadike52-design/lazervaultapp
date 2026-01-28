import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/voice_enrollment/cubit/voice_enrollment_cubit.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
// Note: voice_enrollment_state.dart is a part of voice_enrollment_cubit.dart, no need to import separately

/// Voice Enrollment Screen
///
/// Guides users through voice biometric enrollment with animated UI
class VoiceEnrollmentScreen extends StatefulWidget {
  final String? userId;
  final VoidCallback? onEnrollmentComplete;

  const VoiceEnrollmentScreen({
    super.key,
    this.userId,
    this.onEnrollmentComplete,
  });

  @override
  State<VoiceEnrollmentScreen> createState() => _VoiceEnrollmentScreenState();
}

class _VoiceEnrollmentScreenState extends State<VoiceEnrollmentScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();

    // Pulse animation for mic button
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Wave animation for sound visualization
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    _waveAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _waveController,
      curve: Curves.easeInOut,
    ));

    // Start enrollment process
    context.read<VoiceEnrollmentCubit>().startEnrollment();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: BlocConsumer<VoiceEnrollmentCubit, VoiceEnrollmentState>(
          listener: (context, state) {
            if (state is VoiceEnrollmentSuccess) {
              _showSuccessDialog(context, state);
            } else if (state is VoiceEnrollmentError) {
              _showErrorDialog(context, state.message);
            } else if (state is VoiceEnrollmentPermissionDenied) {
              _showPermissionDialog(context);
            }
          },
          builder: (context, state) {
            if (state is VoiceEnrollmentInitial) {
              return _buildInstructionStep(context, state);
            } else if (state is VoiceEnrollmentRecording) {
              return _buildRecordingStep(context, state);
            } else if (state is VoiceEnrollmentProcessing) {
              return _buildProcessingStep(context, state);
            } else if (state is VoiceEnrollmentLoading) {
              return _buildFinalizingStep(context);
            } else if (state is VoiceEnrollmentPermissionDenied) {
              return _buildPermissionDenied(context);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => _showCancelDialog(context),
      ),
      title: const Text('Voice Enrollment'),
      centerTitle: true,
    );
  }

  Widget _buildInstructionStep(
    BuildContext context,
    VoiceEnrollmentInitial state,
  ) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Progress indicator
          _buildProgressIndicator(state.currentStep, state.totalSteps),

          SizedBox(height: 48.h),

          // Mic icon with animation
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 3,
                    ),
                  ),
                  child: Icon(
                    Icons.mic_rounded,
                    size: 60.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 48.h),

          // Instruction text
          Text(
            'Sample ${state.currentStep + 1} of ${state.totalSteps}',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
            ),
          ),

          SizedBox(height: 16.h),

          Text(
            'Read this phrase aloud:',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 24.h),

          // Phrase to read
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Text(
              state.currentPhrase,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const Spacer(),

          // Record button
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton.icon(
              onPressed: () {
                context.read<VoiceEnrollmentCubit>().startRecording();
              },
              icon: const Icon(Icons.mic),
              label: Text(
                'Start Recording',
                style: TextStyle(fontSize: 18.sp),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingStep(
    BuildContext context,
    VoiceEnrollmentRecording state,
  ) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Progress indicator
          _buildProgressIndicator(state.currentStep, state.totalSteps),

          SizedBox(height: 48.h),

          // Animated mic with sound waves
          Stack(
            alignment: Alignment.center,
            children: [
              // Sound wave rings
              ...List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _waveAnimation,
                  builder: (context, child) {
                    return Container(
                      width: 120.w + (index * 40.w) + (state.soundLevel * 40),
                      height: 120.w + (index * 40.w) + (state.soundLevel * 40),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context)
                              .primaryColor
                              .withValues(alpha: 0.3 - (index * 0.1)),
                          width: 2,
                        ),
                      ),
                    );
                  },
                );
              }),

              // Mic icon
              Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.mic_rounded,
                  size: 60.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          SizedBox(height: 48.h),

          // Recording indicator
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.red[100],
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Recording...',
                  style: TextStyle(
                    color: Colors.red[900],
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // Phrase being recorded
          Text(
            state.currentPhrase,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 48.h),

          // Sound level indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(10, (index) {
              final isActive = (index / 10) < state.soundLevel;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                width: 8.w,
                height: isActive ? 32.h : 16.h,
                decoration: BoxDecoration(
                  color: isActive
                      ? Theme.of(context).primaryColor
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(4.r),
                ),
              );
            }),
          ),

          const Spacer(),

          // Stop recording button
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: () {
                context.read<VoiceEnrollmentCubit>().stopRecording();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.r),
                ),
              ),
              child: Text(
                'Stop Recording',
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingStep(
    BuildContext context,
    VoiceEnrollmentProcessing state,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildProgressIndicator(state.currentStep, state.totalSteps),

          SizedBox(height: 48.h),

          // Loading spinner
          SizedBox(
            width: 80.w,
            height: 80.w,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).primaryColor,
              ),
            ),
          ),

          SizedBox(height: 32.h),

          Text(
            state.message,
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinalizingStep(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Success icon
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green[100],
            ),
            child: Icon(
              Icons.check_rounded,
              size: 60.sp,
              color: Colors.green,
            ),
          ),

          SizedBox(height: 32.h),

          Text(
            'All samples collected!',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 16.h),

          Text(
            'Finalizing your enrollment...',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
            ),
          ),

          SizedBox(height: 48.h),

          SizedBox(
            width: 40.w,
            height: 40.w,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionDenied(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mic_off_rounded,
              size: 80.sp,
              color: Colors.orange,
            ),

            SizedBox(height: 32.h),

            Text(
              'Microphone Permission Required',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 16.h),

            Text(
              'Voice enrollment requires access to your microphone. Please grant permission to continue.',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () {
                  context.read<VoiceEnrollmentCubit>().requestPermission();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                ),
                child: Text(
                  'Grant Permission',
                  style: TextStyle(fontSize: 18.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(int current, int total) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(total, (index) {
            final isActive = index <= current;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: isActive
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            );
          }),
        ),
        SizedBox(height: 8.h),
        Text(
          '${current + 1} of $total',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  void _showSuccessDialog(
    BuildContext context,
    VoiceEnrollmentSuccess state,
  ) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _buildSuccessBottomSheet(context, sheetContext, state),
    );
  }

  Widget _buildSuccessBottomSheet(
    BuildContext context,
    BuildContext sheetContext,
    VoiceEnrollmentSuccess state,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1A3E),
            const Color(0xFF0A0E27),
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          SizedBox(height: 24.h),

          // Close button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Success content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  // Success icon with gradient
                  Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          InvoiceThemeColors.successGreen,
                          InvoiceThemeColors.successGreenDark,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: InvoiceThemeColors.successGreen.withValues(alpha: 0.4),
                          blurRadius: 24,
                          spreadRadius: 4,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      size: 56.sp,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Success title
                  Text(
                    'Voice Enrolled Successfully!',
                    style: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 12.h),

                  // Description
                  Text(
                    'Your unique voice profile has been securely registered. You can now use voice commands for banking transactions.',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: InvoiceThemeColors.textGray400,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 32.h),

                  // Quality score card
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: InvoiceThemeColors.secondaryBackground,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: InvoiceThemeColors.borderColor,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              (state.qualityScore * 100).toStringAsFixed(0),
                              style: GoogleFonts.inter(
                                fontSize: 48.sp,
                                fontWeight: FontWeight.bold,
                                color: InvoiceThemeColors.primaryPurple,
                                height: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.h, left: 4.w),
                              child: Text(
                                '%',
                                style: GoogleFonts.inter(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  color: InvoiceThemeColors.primaryPurple,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Voice Quality Score',
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: InvoiceThemeColors.textGray400,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: InvoiceThemeColors.successGreen.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.verified_rounded,
                                color: InvoiceThemeColors.successGreen,
                                size: 18,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'Excellent Match',
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: InvoiceThemeColors.successGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Features unlocked
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: InvoiceThemeColors.secondaryBackground,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: InvoiceThemeColors.borderColor,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: InvoiceThemeColors.warningOrange,
                              size: 20,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Features Unlocked',
                              style: GoogleFonts.inter(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        _buildFeatureItem(
                          Icons.send_rounded,
                          'Voice-activated transfers',
                        ),
                        SizedBox(height: 12.h),
                        _buildFeatureItem(
                          Icons.lock_rounded,
                          'Secure voice authentication',
                        ),
                        SizedBox(height: 12.h),
                        _buildFeatureItem(
                          Icons.mic_rounded,
                          'Hands-free banking commands',
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),

          // Action button
          Container(
            padding: EdgeInsets.fromLTRB(32.w, 16.h, 32.w, 32.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF0A0E27).withValues(alpha: 0),
                  const Color(0xFF0A0E27),
                ],
              ),
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 56.h,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        InvoiceThemeColors.primaryPurple,
                        InvoiceThemeColors.primaryPurple.withValues(alpha: 0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(sheetContext).pop();
                      Navigator.of(context).pop(); // Close enrollment screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Row(
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check,
            color: InvoiceThemeColors.primaryPurple,
            size: 16,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: InvoiceThemeColors.textGray400,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Enrollment Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<VoiceEnrollmentCubit>().retryStep();
            },
            child: const Text('Retry'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Permission Required'),
        content: const Text(
          'Microphone permission is required for voice enrollment. Please grant permission in your device settings.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<VoiceEnrollmentCubit>().requestPermission();
            },
            child: const Text('Settings'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cancel Enrollment?'),
        content: const Text(
          'Your progress will be lost. Are you sure you want to cancel?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('No, Continue'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }
}
