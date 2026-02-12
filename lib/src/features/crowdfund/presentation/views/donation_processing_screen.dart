import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';
import 'donation_receipt_screen.dart';

class DonationProcessingScreen extends StatefulWidget {
  final Crowdfund crowdfund;

  const DonationProcessingScreen({
    super.key,
    required this.crowdfund,
  });

  @override
  State<DonationProcessingScreen> createState() =>
      _DonationProcessingScreenState();
}

class _DonationProcessingScreenState extends State<DonationProcessingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent back navigation during processing
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: BlocConsumer<CrowdfundCubit, CrowdfundState>(
          listener: (context, state) {
            if (state is DonationCompleted) {
              // Wait a moment before navigating
              Future.delayed(const Duration(seconds: 2), () {
                if (!context.mounted) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DonationReceiptScreen(
                      donation: state.donation,
                      receipt: state.receipt,
                      crowdfund: widget.crowdfund,
                    ),
                  ),
                );
              });
            } else if (state is CrowdfundError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: const Color(0xFFEF4444),
                ),
              );
              // Navigate back after error
              Future.delayed(const Duration(seconds: 2), () {
                if (!context.mounted) return;
                Navigator.pop(context);
              });
            }
          },
          builder: (context, state) {
            String currentStep = 'Processing donation...';
            int currentStepIndex = 0;
            int totalSteps = 4;

            if (state is DonationProcessing) {
              currentStep = state.step;
              currentStepIndex = state.currentStepIndex;
              totalSteps = state.totalSteps;
            } else if (state is DonationCompleted) {
              currentStep = 'Donation completed!';
              currentStepIndex = totalSteps;
            }

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    // Animated icon
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: 120.w,
                        height: 120.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF4E03D0),
                              const Color(0xFF6B21E0).withValues(alpha: 0.7),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4E03D0).withValues(alpha: 0.3),
                              blurRadius: 30,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: Icon(
                          state is DonationCompleted
                              ? Icons.check_circle
                              : Icons.volunteer_activism,
                          color: Colors.white,
                          size: 60.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    // Current step text
                    Text(
                      currentStep,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Please wait while we process your donation',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40.h),
                    // Progress indicator
                    _buildProgressSteps(currentStepIndex, totalSteps),
                    SizedBox(height: 40.h),
                    // Linear progress
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: LinearProgressIndicator(
                        value: currentStepIndex / totalSteps,
                        backgroundColor: const Color(0xFF2D2D2D),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF4E03D0),
                        ),
                        minHeight: 8.h,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Step $currentStepIndex of $totalSteps',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.sp,
                      ),
                    ),
                    const Spacer(),
                    // Crowdfund info
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xFF2D2D2D),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: const Color(0xFF4E03D0),
                            size: 20.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'Supporting: ${widget.crowdfund.title}',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 13.sp,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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
    );
  }

  Widget _buildProgressSteps(int currentStep, int totalSteps) {
    final steps = [
      'Verify',
      'Process',
      'Update',
      'Receipt',
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps.length, (index) {
        final isCompleted = index < currentStep;
        final isCurrent = index == currentStep - 1;

        return Row(
          children: [
            Column(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted || isCurrent
                        ? const Color(0xFF4E03D0)
                        : const Color(0xFF2D2D2D),
                    border: Border.all(
                      color: isCompleted || isCurrent
                          ? const Color(0xFF4E03D0)
                          : const Color(0xFF2D2D2D),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: isCompleted
                        ? Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20.sp,
                          )
                        : Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: isCurrent ? Colors.white : Colors.grey[600],
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  steps[index],
                  style: TextStyle(
                    color:
                        isCompleted || isCurrent ? Colors.white : Colors.grey[600],
                    fontSize: 11.sp,
                    fontWeight:
                        isCurrent ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
            if (index < steps.length - 1)
              Container(
                width: 40.w,
                height: 2.h,
                margin: EdgeInsets.only(bottom: 24.h),
                color: isCompleted
                    ? const Color(0xFF4E03D0)
                    : const Color(0xFF2D2D2D),
              ),
          ],
        );
      }),
    );
  }
}
