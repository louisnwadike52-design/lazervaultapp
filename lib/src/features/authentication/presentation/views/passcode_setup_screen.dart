import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

class PasscodeSetupScreen extends StatefulWidget {
  const PasscodeSetupScreen({super.key});

  @override
  State<PasscodeSetupScreen> createState() => _PasscodeSetupScreenState();
}

class _PasscodeSetupScreenState extends State<PasscodeSetupScreen> {
  final int _passcodeLength = 6;
  bool _skipped = false;
  bool get _fromLoginFlow => (Get.arguments as Map<String, dynamic>?)?['fromLoginFlow'] == true;
  bool get _hasTransactionPin => (Get.arguments as Map<String, dynamic>?)?['hasTransactionPin'] == true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    // Initialize passcode setup state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthenticationCubit>().startPasscodeSetup();
    });
  }

  void _onNumberPressed(String number) {
    context.read<AuthenticationCubit>().passcodeSetupDigitEntered(number);
  }

  void _onBackspacePressed() {
    context.read<AuthenticationCubit>().passcodeSetupBackspace();
  }

  void _skipPasscode() {
    _skipped = true;
    context.read<AuthenticationCubit>().skipPasscodeSetup();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final availableHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          if (_skipped) {
            // Skip was pressed, go directly to dashboard
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                Get.offAllNamed(AppRoutes.dashboard);
              }
            });
          } else if (_fromLoginFlow && _hasTransactionPin) {
            // Login flow and user already has PIN — go straight to dashboard
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                Get.offAllNamed(AppRoutes.dashboard);
              }
            });
          } else {
            // Navigate to Transaction PIN setup after successful passcode setup
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                Get.offNamed(
                  AppRoutes.transactionPinSetup,
                  arguments: _fromLoginFlow ? {'fromLoginFlow': true} : null,
                );
              }
            });
          }
        }
      },
      builder: (context, state) {
        // Handle non-passcode states
        if (state is! PasscodeSetupInProgress) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final passcodeState = state;
        final enteredPasscode = passcodeState.enteredPasscode;
        final isConfirmMode = passcodeState.isConfirmMode;
        final isRegistering = passcodeState.isRegistering;

        return Scaffold(
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              // Background image (matching passcode login)
              DecoratedBox(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://picsum.photos/seed/lazervaultsignin/1080/1920',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const SizedBox.expand(),
              ),
              // Dark overlay
              Container(
                color: Colors.black.withValues(alpha: 0.6),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: availableHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 60.h),
                          Center(
                            child: UniversalImageLoader(
                              imagePath: AppData.appLogo,
                              height: 80.h,
                              width: 80.w,
                            ),
                          ),
                          SizedBox(height: 40.h),
                          Text(
                            isConfirmMode ? 'Confirm Passcode' : 'Set Up Passcode',
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            isConfirmMode
                                ? 'Enter your passcode again to confirm'
                                : 'Create a 6-digit passcode for quick login',
                            style: textTheme.titleMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 40.h),
                          // Passcode dots indicator
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _passcodeLength,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: EdgeInsets.symmetric(horizontal: 8.w),
                                width: 18.w,
                                height: 18.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: index < enteredPasscode.length
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.3),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 35.h),
                          // Number pad
                          GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            mainAxisSpacing: 18.h,
                            crossAxisSpacing: 25.w,
                            childAspectRatio: 1.6,
                            children: [
                              ...List.generate(9, (index) {
                                final number = (index + 1).toString();
                                return _buildNumberButton(number, isRegistering);
                              }),
                              Container(), // Empty space
                              _buildNumberButton('0', isRegistering),
                              _buildIconButton(
                                icon: Icons.backspace_outlined,
                                onPressed: isRegistering ? null : _onBackspacePressed,
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h),
                          // Skip button (only on first entry)
                          if (!isConfirmMode && !isRegistering)
                            TextButton(
                              onPressed: _skipPasscode,
                              child: Text(
                                'Skip for now',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          if (isRegistering)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            ),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNumberButton(String number, bool isDisabled) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: isDisabled ? null : () => _onNumberPressed(number),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.15),
          ),
          child: Text(
            number,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: isDisabled ? Colors.grey : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.15),
          ),
          child: Icon(
            icon,
            color: onPressed == null ? Colors.grey : Colors.white,
            size: 28.sp,
          ),
        ),
      ),
    );
  }
}
