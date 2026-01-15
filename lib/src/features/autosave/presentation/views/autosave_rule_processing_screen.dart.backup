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
  State<AutoSaveRuleProcessingScreen> createState() => _AutoSaveRuleProcessingScreenState();
}

class _AutoSaveRuleProcessingScreenState extends State<AutoSaveRuleProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _processingController;
  late AnimationController _fadeController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  Map<String, dynamic> ruleData = {};
  bool _hasStartedProcessing = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupAnimations();
  }

  void _initializeData() {
    ruleData = Get.arguments as Map<String, dynamic>? ?? {};
  }

  void _setupAnimations() {
    _processingController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _processingController, curve: Curves.linear),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.elasticOut),
    );

    _processingController.repeat();
    _fadeController.forward();

    // Start processing after animations
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startProcessing();
    });
  }

  void _startProcessing() async {
    if (_hasStartedProcessing) return;
    _hasStartedProcessing = true;

    // Call the backend to create the rule
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
    _processingController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _navigateToDashboard() {
    Get.offAllNamed(AppRoutes.autoSaveDashboard);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AutoSaveCubit, AutoSaveState>(
      listener: (context, state) {
        if (state is AutoSaveRuleCreated) {
          _processingController.stop();

          // Navigate to receipt screen with the created rule
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              Get.offNamed(
                AppRoutes.autoSaveRuleReceipt,
                arguments: {
                  ...ruleData,
                  'ruleId': 'AR${DateTime.now().millisecondsSinceEpoch}',
                  'createdAt': DateTime.now().toIso8601String(),
                },
              );
            }
          });
        } else if (state is AutoSaveError) {
          _processingController.stop();

          // Show error and navigate back
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
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (!didPop) {
            _navigateToDashboard();
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF1A1A2E),
                  const Color(0xFF0A0A0A),
                  const Color(0xFF000000),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: _buildProcessingContent(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Creating Auto-Save Rule...',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Please wait while we set up your rule',
                  style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 13.sp,
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

  Widget _buildProcessingContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color.fromARGB(255, 78, 3, 208).withOpacity(0.3),
                    const Color.fromARGB(255, 98, 33, 224).withOpacity(0.3),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 78, 3, 208).withOpacity(0.3),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  RotationTransition(
                    turns: _rotationAnimation,
                    child: Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color.fromARGB(255, 78, 3, 208),
                          width: 3,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color.fromARGB(255, 78, 3, 208),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.savings_outlined,
                    color: Colors.white,
                    size: 48.sp,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40.h),
          Text(
            'Processing your request',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: 200.w,
            child: Text(
              'We\'re setting up your auto-save rule. This will only take a moment.',
              style: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 40.h),
          _buildLoadingDots(),
        ],
      ),
    );
  }

  Widget _buildLoadingDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 600),
          builder: (context, value, child) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 78, 3, 208).withOpacity(
                  0.3 + (0.7 * ((value + index * 0.3) % 1)),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
