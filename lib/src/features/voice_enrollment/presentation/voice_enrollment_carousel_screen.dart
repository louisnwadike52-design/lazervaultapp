import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/voice_enrollment/cubit/voice_enrollment_cubit.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';

/// Voice Enrollment Carousel Screen
///
/// Single screen with PageView for 3 voice samples.
/// Replaces the multi-step enrollment flow with a streamlined carousel.
class VoiceEnrollmentCarouselScreen extends StatefulWidget {
  final String? userId;
  final VoidCallback? onEnrollmentComplete;

  const VoiceEnrollmentCarouselScreen({
    super.key,
    this.userId,
    this.onEnrollmentComplete,
  });

  @override
  State<VoiceEnrollmentCarouselScreen> createState() =>
      _VoiceEnrollmentCarouselScreenState();
}

class _VoiceEnrollmentCarouselScreenState
    extends State<VoiceEnrollmentCarouselScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _pulseController;
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    context.read<VoiceEnrollmentCubit>().startCarouselEnrollment();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pulseController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => _showCancelDialog(context),
        ),
        title: Text(
          'Voice Enrollment',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<VoiceEnrollmentCubit, VoiceEnrollmentState>(
          listener: (context, state) {
            if (state is VoiceEnrollmentSuccess) {
              _showSuccessSheet(context, state);
            } else if (state is VoiceEnrollmentError) {
              _showErrorSnackbar(context, state.message);
            } else if (state is VoiceEnrollmentPermissionDenied) {
              _showPermissionSnackbar(context);
            }
          },
          builder: (context, state) {
            if (state is VoiceEnrollmentCarouselState) {
              return _buildCarousel(context, state);
            }
            if (state is VoiceEnrollmentLoading) {
              return _buildFinalizing(context);
            }
            // Fallback for permission denied re-entry
            if (state is VoiceEnrollmentPermissionDenied) {
              return _buildPermissionDenied(context);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, VoiceEnrollmentCarouselState state) {
    return Column(
      children: [
        SizedBox(height: 16.h),

        // Progress bar
        _buildProgressBar(state),

        SizedBox(height: 8.h),

        // Completed count
        Text(
          '${state.completedCount} of 3 samples recorded',
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ),

        SizedBox(height: 24.h),

        // PageView with 3 sample pages
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            physics: state.isRecording
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            onPageChanged: (page) {
              context.read<VoiceEnrollmentCubit>().setActivePage(page);
            },
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildSamplePage(context, state, index);
            },
          ),
        ),

        // Page dots
        _buildPageDots(state),

        SizedBox(height: 16.h),

        // Bottom action button
        _buildBottomAction(context, state),

        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _buildProgressBar(VoiceEnrollmentCarouselState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.r),
        child: LinearProgressIndicator(
          value: state.completedCount / 3.0,
          backgroundColor: const Color(0xFF2D2D2D),
          valueColor: const AlwaysStoppedAnimation(Color(0xFF3B82F6)),
          minHeight: 6.h,
        ),
      ),
    );
  }

  Widget _buildSamplePage(
    BuildContext context,
    VoiceEnrollmentCarouselState state,
    int index,
  ) {
    final isActive = state.activePage == index;
    final isCompleted = state.sampleCompleted[index];
    final isRecording = state.isRecording && isActive;
    final isProcessing = state.isProcessing && isActive;
    final phrase = enrollmentPhrases[index];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Sample number
          Text(
            'Sample ${index + 1}',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF9CA3AF),
            ),
          ),

          SizedBox(height: 12.h),

          // Instruction
          Text(
            'Read this phrase aloud:',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 20.h),

          // Phrase card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isRecording
                    ? const Color(0xFFEF4444).withValues(alpha: 0.5)
                    : isCompleted
                        ? const Color(0xFF10B981).withValues(alpha: 0.5)
                        : const Color(0xFF2D2D2D),
                width: 1.5,
              ),
            ),
            child: Text(
              '"$phrase"',
              style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 40.h),

          // Mic button area
          if (isProcessing)
            _buildProcessingIndicator()
          else if (isCompleted && !isRecording)
            _buildCompletedCheck()
          else
            _buildMicButton(context, state, index, isRecording),

          SizedBox(height: 24.h),

          // Sound level bars (visible during recording)
          if (isRecording) _buildSoundLevelBars(state.soundLevel),

          if (isRecording)
            Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFEF4444),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Recording...',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFEF4444),
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMicButton(
    BuildContext context,
    VoiceEnrollmentCarouselState state,
    int index,
    bool isRecording,
  ) {
    return GestureDetector(
      onTap: () {
        if (isRecording) {
          context.read<VoiceEnrollmentCubit>().stopCarouselRecording(index);
        } else {
          context.read<VoiceEnrollmentCubit>().recordSample(index);
        }
      },
      child: AnimatedBuilder(
        animation: isRecording ? _waveController : _pulseController,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Wave rings during recording
              if (isRecording) ...[
                for (int i = 2; i >= 0; i--)
                  Container(
                    width: 100.w + (i * 30.w) + (state.soundLevel * 30),
                    height: 100.w + (i * 30.w) + (state.soundLevel * 30),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFEF4444)
                            .withValues(alpha: 0.3 - (i * 0.08)),
                        width: 2,
                      ),
                    ),
                  ),
              ],

              // Pulse ring when idle
              if (!isRecording)
                Transform.scale(
                  scale: _pulseController.value * 0.15 + 1.0,
                  child: Container(
                    width: 110.w,
                    height: 110.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                        width: 2,
                      ),
                    ),
                  ),
                ),

              // Main mic circle
              Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isRecording
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF3B82F6),
                  boxShadow: [
                    BoxShadow(
                      color: (isRecording
                              ? const Color(0xFFEF4444)
                              : const Color(0xFF3B82F6))
                          .withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Icon(
                  isRecording ? Icons.stop_rounded : Icons.mic_rounded,
                  size: 48.sp,
                  color: Colors.white,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCompletedCheck() {
    return Container(
      width: 100.w,
      height: 100.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF10B981).withValues(alpha: 0.15),
        border: Border.all(
          color: const Color(0xFF10B981),
          width: 2.5,
        ),
      ),
      child: Icon(
        Icons.check_rounded,
        size: 48.sp,
        color: const Color(0xFF10B981),
      ),
    );
  }

  Widget _buildProcessingIndicator() {
    return SizedBox(
      width: 100.w,
      height: 100.w,
      child: const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF3B82F6),
          strokeWidth: 3,
        ),
      ),
    );
  }

  Widget _buildSoundLevelBars(double level) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(12, (index) {
        final isActive = (index / 12) < level;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 80),
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          width: 6.w,
          height: isActive ? 28.h : 12.h,
          decoration: BoxDecoration(
            color: isActive
                ? const Color(0xFFEF4444)
                : const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(3.r),
          ),
        );
      }),
    );
  }

  Widget _buildPageDots(VoiceEnrollmentCarouselState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isActive = state.activePage == index;
        final isCompleted = state.sampleCompleted[index];
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: isActive ? 24.w : 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: isCompleted
                ? const Color(0xFF10B981)
                : isActive
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFF2D2D2D),
          ),
        );
      }),
    );
  }

  Widget _buildBottomAction(
    BuildContext context,
    VoiceEnrollmentCarouselState state,
  ) {
    // If current page is completed and not the last, show "Next"
    // If all completed, the cubit auto-enrolls so this won't show
    if (state.currentPageCompleted &&
        !state.allCompleted &&
        state.activePage < 2) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: SizedBox(
          width: double.infinity,
          height: 52.h,
          child: ElevatedButton(
            onPressed: () {
              final nextPage = state.activePage + 1;
              _pageController.animateToPage(
                nextPage,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: Text(
              'Next Sample',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }

    // Show re-record option for completed pages
    if (state.currentPageCompleted) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: SizedBox(
          width: double.infinity,
          height: 52.h,
          child: OutlinedButton.icon(
            onPressed: () {
              context
                  .read<VoiceEnrollmentCubit>()
                  .recordSample(state.activePage);
            },
            icon: Icon(Icons.refresh_rounded, size: 20.sp),
            label: Text(
              'Re-record Sample',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF9CA3AF),
              side: const BorderSide(color: Color(0xFF2D2D2D)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
          ),
        ),
      );
    }

    // Default: prompt to tap mic
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Text(
        'Tap the microphone to start recording',
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          color: const Color(0xFF9CA3AF),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildFinalizing(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF10B981).withValues(alpha: 0.15),
            ),
            child: Icon(
              Icons.check_rounded,
              size: 48.sp,
              color: const Color(0xFF10B981),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'All samples collected!',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Finalizing your enrollment...',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          SizedBox(height: 32.h),
          const CircularProgressIndicator(
            color: Color(0xFF3B82F6),
            strokeWidth: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionDenied(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mic_off_rounded, size: 64.sp, color: const Color(0xFFFB923C)),
            SizedBox(height: 24.h),
            Text(
              'Microphone Permission Required',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              'Voice enrollment requires microphone access. Please grant permission to continue.',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF9CA3AF),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () {
                  context.read<VoiceEnrollmentCubit>().requestPermission();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  'Grant Permission',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessSheet(BuildContext context, VoiceEnrollmentSuccess state) {
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
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A3E), Color(0xFF0A0E27)],
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
                    widget.onEnrollmentComplete?.call();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, color: Colors.white, size: 20.sp),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  // Success icon
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

                  Text(
                    'Your unique voice profile has been securely registered. You can now use voice commands for banking.',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: InvoiceThemeColors.textGray400,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 32.h),

                  // Quality score
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
                        _buildFeatureItem(Icons.send_rounded, 'Voice-activated transfers'),
                        SizedBox(height: 12.h),
                        _buildFeatureItem(Icons.lock_rounded, 'Secure voice authentication'),
                        SizedBox(height: 12.h),
                        _buildFeatureItem(Icons.mic_rounded, 'Hands-free banking commands'),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),

          // Get Started button
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
                      Navigator.of(context).pop();
                      widget.onEnrollmentComplete?.call();
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
          child: Icon(Icons.check, color: InvoiceThemeColors.primaryPurple, size: 16),
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

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showPermissionSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Microphone permission is required for voice enrollment'),
        backgroundColor: Color(0xFFFB923C),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: const Text('Cancel Enrollment?', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Your progress will be lost. Are you sure?',
          style: TextStyle(color: Color(0xFF9CA3AF)),
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
            child: const Text('Yes, Cancel', style: TextStyle(color: Color(0xFFEF4444))),
          ),
        ],
      ),
    );
  }
}
