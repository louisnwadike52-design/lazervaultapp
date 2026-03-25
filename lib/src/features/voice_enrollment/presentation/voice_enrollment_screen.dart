import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
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
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

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
    WidgetsBinding.instance.removeObserver(this);
    _pulseController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  /// Handle app lifecycle changes — stop recording if user backgrounds the app
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      final cubit = context.read<VoiceEnrollmentCubit>();
      final currentState = cubit.state;
      if (currentState is VoiceEnrollmentRecording) {
        cubit.stopRecording();
      }
    }
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
            } else if (state is VoiceEnrollmentPoorQuality) {
              _showPoorQualityDialog(context, state);
            } else if (state is VoiceEnrollmentSkipped) {
              widget.onEnrollmentComplete?.call();
              Navigator.of(context).pop();
            } else if (state is VoiceEnrollmentError) {
              _showErrorDialog(context, state);
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
            } else if (state is VoiceEnrollmentReplacing) {
              return _buildReplacingStep(context, state);
            } else if (state is VoiceEnrollmentPermissionDenied) {
              return _buildPermissionDenied(context);
            } else if (state is VoiceEnrollmentError) {
              // Show a fallback UI behind the error dialog
              return _buildFinalizingStep(context);
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

  Widget _buildReplacingStep(BuildContext context, VoiceEnrollmentReplacing state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
            ),
            child: Icon(
              Icons.swap_horiz_rounded,
              size: 60.sp,
              color: const Color(0xFF3B82F6),
            ),
          ),

          SizedBox(height: 32.h),

          Text(
            state.message,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 16.h),

          Text(
            'Removing old voice data and re-enrolling...',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),

          SizedBox(height: 48.h),

          SizedBox(
            width: 40.w,
            height: 40.w,
            child: const CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation(Color(0xFF3B82F6)),
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

  void _showPoorQualityDialog(
    BuildContext context,
    VoiceEnrollmentPoorQuality state,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Row(
          children: [
            const Icon(Icons.warning_rounded, color: Color(0xFFFB923C), size: 24),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Voice Quality Too Low',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                '${(state.qualityScore * 100).toStringAsFixed(0)}% quality',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFEF4444),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Your voice sample quality is too low for secure authentication. This usually happens on emulators or in noisy environments.\n\nYou can set up again or skip for now.',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: Colors.white70,
                height: 1.4,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Voice authentication will not be used to secure your transactions. You can set it up later in Settings.',
                    style: GoogleFonts.inter(fontSize: 13),
                  ),
                  backgroundColor: const Color(0xFF1F1F1F),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 5),
                ),
              );
              context.read<VoiceEnrollmentCubit>().skipEnrollment();
            },
            child: Text(
              'Skip',
              style: GoogleFonts.inter(color: Colors.white54),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<VoiceEnrollmentCubit>().reEnroll();
            },
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: Text(
              'Set Up Again',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: InvoiceThemeColors.primaryPurple,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
            ),
          ),
        ],
      ),
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
                        Builder(builder: (context) {
                          final score = state.qualityScore;
                          final String label;
                          final Color color;
                          final IconData icon;
                          if (score >= 0.7) {
                            label = 'Excellent Match';
                            color = InvoiceThemeColors.successGreen;
                            icon = Icons.verified_rounded;
                          } else if (score >= 0.4) {
                            label = 'Good Match';
                            color = InvoiceThemeColors.successGreen;
                            icon = Icons.check_circle_rounded;
                          } else if (score >= 0.15) {
                            label = 'Fair Match';
                            color = const Color(0xFFFB923C);
                            icon = Icons.info_rounded;
                          } else {
                            label = 'Poor Quality — Try on a real device';
                            color = const Color(0xFFEF4444);
                            icon = Icons.warning_rounded;
                          }
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(icon, color: color, size: 18),
                                SizedBox(width: 6.w),
                                Text(
                                  label,
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: color,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
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
                      widget.onEnrollmentComplete?.call();
                      // Navigate to dashboard and auto-open voice command sheet
                      Get.offAllNamed(
                        AppRoutes.dashboard,
                        arguments: {'openVoiceSheet': true},
                      );
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
                      'Start Conversation',
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

  void _showErrorDialog(BuildContext context, VoiceEnrollmentError errorState) {
    final IconData icon;
    final Color iconColor;
    final String title;
    final String? hint;
    final bool canRetry;

    switch (errorState.errorCode) {
      case 'SERVICE_UNAVAILABLE':
        icon = Icons.cloud_off_rounded;
        iconColor = const Color(0xFFFB923C);
        title = 'Service Unavailable';
        hint = 'The voice processing service is temporarily down. Your progress has been saved.';
        canRetry = true;
      case 'POOR_AUDIO':
        icon = Icons.graphic_eq_rounded;
        iconColor = const Color(0xFFEF4444);
        title = 'Audio Quality Issue';
        hint = 'Tips: move to a quiet room, hold the phone close, and speak at a normal volume.';
        canRetry = true;
      case 'ALREADY_ENROLLED':
        icon = Icons.person_rounded;
        iconColor = const Color(0xFF3B82F6);
        title = 'Could Not Replace Profile';
        hint = 'The existing voice profile could not be replaced automatically. Try again or contact support.';
        canRetry = true;
      case 'DELETE_FAILED':
        icon = Icons.warning_amber_rounded;
        iconColor = const Color(0xFFFB923C);
        title = 'Replacement Failed';
        hint = 'Could not remove the existing voice profile. Please try again.';
        canRetry = true;
      default:
        icon = Icons.error_outline_rounded;
        iconColor = const Color(0xFFEF4444);
        title = 'Enrollment Failed';
        hint = null;
        canRetry = true;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              errorState.message,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.white70,
                height: 1.4,
              ),
            ),
            if (hint != null) ...[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: iconColor.withValues(alpha: 0.2)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lightbulb_outline_rounded, color: iconColor, size: 18),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        hint,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.white60,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: Colors.white54),
            ),
          ),
          if (canRetry)
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (errorState.errorCode == 'POOR_AUDIO' ||
                    errorState.errorCode == 'ALREADY_ENROLLED' ||
                    errorState.errorCode == 'DELETE_FAILED') {
                  context.read<VoiceEnrollmentCubit>().reEnroll();
                } else {
                  context.read<VoiceEnrollmentCubit>().retryStep();
                }
              },
              icon: Icon(
                errorState.errorCode == 'POOR_AUDIO'
                    ? Icons.refresh_rounded
                    : Icons.replay_rounded,
                size: 18,
              ),
              label: Text(
                errorState.errorCode == 'POOR_AUDIO' ? 'Re-record' : 'Try Again',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: InvoiceThemeColors.primaryPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
              ),
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
