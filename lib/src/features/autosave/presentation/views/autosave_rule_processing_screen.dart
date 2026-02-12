import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_cubit.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_state.dart';

class AutoSaveRuleProcessingScreen extends StatefulWidget {
  const AutoSaveRuleProcessingScreen({super.key});

  @override
  State<AutoSaveRuleProcessingScreen> createState() =>
      _AutoSaveRuleProcessingScreenState();
}

class _AutoSaveRuleProcessingScreenState
    extends State<AutoSaveRuleProcessingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  Map<String, dynamic> ruleData = {};
  bool _hasStartedProcessing = false;

  @override
  void initState() {
    super.initState();
    ruleData = Get.arguments as Map<String, dynamic>? ?? {};

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startProcessing();
    });
  }

  void _startProcessing() {
    if (_hasStartedProcessing) return;
    _hasStartedProcessing = true;

    context.read<AutoSaveCubit>().createRule(
          name: ruleData['name'] as String,
          description: ruleData['description'] as String,
          triggerType: ruleData['triggerType'],
          amountType: ruleData['amountType'],
          amountValue: ruleData['amountValue'] as double,
          sourceAccountId: ruleData['sourceAccountId'] as String,
          destinationAccountId: ruleData['destinationAccountId'] as String,
          frequency: ruleData['frequency'],
          scheduleTime: ruleData['scheduleTime'] as String?,
          scheduleDay: ruleData['scheduleDay'] as int?,
          roundUpTo: ruleData['roundUpTo'] as int?,
          targetAmount: ruleData['targetAmount'] as double?,
          minimumBalance: ruleData['minimumBalance'] as double?,
          maximumPerSave: ruleData['maximumPerSave'] as double?,
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
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: BlocConsumer<AutoSaveCubit, AutoSaveState>(
          listener: (context, state) {
            if (state is AutoSaveRuleCreated) {
              _animationController.stop();
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted) {
                  Get.offNamed(
                    AppRoutes.autoSaveRuleReceipt,
                    arguments: {
                      ...ruleData,
                      'ruleId': state.rule.id,
                      'createdAt': state.rule.createdAt.toIso8601String(),
                    },
                  );
                }
              });
            } else if (state is AutoSaveError) {
              _animationController.stop();
              Get.snackbar(
                'Error',
                state.message,
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                duration: const Duration(seconds: 4),
              );
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted) {
                  Get.back();
                }
              });
            }
          },
          builder: (context, state) {
            String currentStep = 'Processing...';
            int currentStepIndex = 0;
            int totalSteps = 4;

            if (state is AutoSaveRuleCreating) {
              currentStep = state.step;
              currentStepIndex = state.currentStepIndex;
              totalSteps = state.totalSteps;
            } else if (state is AutoSaveRuleCreated) {
              currentStep = 'Rule created!';
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
                              color: const Color(0xFF4E03D0)
                                  .withValues(alpha: 0.3),
                              blurRadius: 30,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: Icon(
                          state is AutoSaveRuleCreated
                              ? Icons.check_circle
                              : Icons.savings_outlined,
                          color: Colors.white,
                          size: 60.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    // Current step text
                    Text(
                      currentStep,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Please wait while we set up your rule',
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40.h),
                    // Progress steps
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
                      style: GoogleFonts.inter(
                        color: Colors.grey[600],
                        fontSize: 12.sp,
                      ),
                    ),
                    const Spacer(),
                    // Rule info card
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
                              'Creating: ${ruleData['name'] ?? 'Auto-Save Rule'}',
                              style: GoogleFonts.inter(
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
      'Configure',
      'Validate',
      'Create',
      'Confirm',
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
                            style: GoogleFonts.inter(
                              color: isCurrent
                                  ? Colors.white
                                  : Colors.grey[600],
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  steps[index],
                  style: GoogleFonts.inter(
                    color: isCompleted || isCurrent
                        ? Colors.white
                        : Colors.grey[600],
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
