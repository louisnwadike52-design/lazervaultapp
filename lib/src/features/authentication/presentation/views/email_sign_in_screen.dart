import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/haptics_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class EmailSignInScreen extends StatefulWidget {
  const EmailSignInScreen({super.key});

  @override
  State<EmailSignInScreen> createState() => _EmailSignInScreenState();
}

class _EmailSignInScreenState extends State<EmailSignInScreen> {
  late ResponsiveController _responsiveController;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _storage = serviceLocator<FlutterSecureStorage>();
  bool _hasPasscodeSetup = false;
  // One-shot guard: the async AuthenticationSuccess listener can re-fire
  // (success snackbar + getUserProfile re-entrancy), which navigated to the
  // dashboard twice (the "double swipe"). Navigate exactly once.
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _responsiveController = ResponsiveController(context);
    // Set status bar icons to white
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    _checkPasscodeAvailability();
  }

  Future<void> _checkPasscodeAvailability() async {
    try {
      final loginMethod = await _storage.read(key: 'login_method');
      final storedEmail = await _storage.read(key: 'stored_email');
      final userEmail = await _storage.read(key: 'user_email');

      final hasEmail = (storedEmail != null && storedEmail.isNotEmpty) ||
                       (userEmail != null && userEmail.isNotEmpty);

      if (mounted) {
        setState(() {
          _hasPasscodeSetup = loginMethod == 'passcode' && hasEmail;
        });
      }
    } catch (e) {
      print('Error checking passcode availability: $e');
    }
  }

  void _switchToPasscodeLogin() {
    Get.offAllNamed(AppRoutes.passcodeLogin);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get arguments from navigation
    final arguments = Get.arguments as Map<String, dynamic>?;
    final fromForgotPasscode = arguments?['fromForgotPasscode'] == true;

    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg/up-down-curve-bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BlocListener<AuthenticationCubit, AuthenticationState>(
            listener: (context, state) async {
              switch (state) {
              case AuthenticationSuccess(profile: final profile):
                // Guard against a duplicate navigation if the listener re-fires.
                if (_navigated) break;
                _navigated = true;
                // Load user profile after successful authentication
                context.read<ProfileCubit>().getUserProfile();

                Get.snackbar(
                  'Success',
                  'Login Successful!',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(15.w),
                  borderRadius: 10.r,
                );

                if (fromForgotPasscode) {
                  // Go to passcode setup when resetting — pass hasTransactionPin
                  // so user isn't routed to TX PIN setup if they already have one
                  Get.offAllNamed(AppRoutes.passcodeSetup, arguments: {
                    'fromLoginFlow': true,
                    'hasTransactionPin': profile.user.hasTransactionPin,
                    'fromForgotPasscode': true,
                  });
                  break;
                }

                // Resume from any incomplete signup step — the backend
                // is source of truth (users.current_signup_step + users.
                // signup_status). If the user logged in mid-signup
                // (e.g. they signed up, didn't verify their phone, and
                // came back days later), drop them at the right resume
                // route instead of the dashboard. `null` / empty / the
                // "complete" status means signup is done → fall through
                // to the usual dashboard-or-passcode-setup branch.
                final resumeRoute = _signupResumeRoute(
                  profile.user.currentSignupStep,
                  profile.user.signupStatus,
                  email: profile.user.email,
                  phone: profile.user.phoneNumber,
                  hasTransactionPin: profile.user.hasTransactionPin,
                );
                if (resumeRoute != null) {
                  Get.offAllNamed(resumeRoute.name, arguments: resumeRoute.args);
                  break;
                }

                // Backend is source of truth — use login response data
                if (profile.user.hasPasscode) {
                  // Passcode already set — persist login method and go to dashboard
                  await _storage.write(key: 'login_method', value: 'passcode');
                  Get.offAllNamed(AppRoutes.dashboard);
                } else {
                  // No passcode — route to setup, pass hasTransactionPin for downstream
                  Get.offAllNamed(AppRoutes.passcodeSetup, arguments: {
                    'fromLoginFlow': true,
                    'hasTransactionPin': profile.user.hasTransactionPin,
                  });
                }
                break;
              case AuthenticationFailure(message: final msg):
                Get.snackbar(
                  'Login Error',
                  msg,
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(15.w),
                  borderRadius: 10.r,
                );
                break;
                default:
                  break;
              }
            },
            child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                final isLoading = state is AuthenticationLoading;

                return SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0.h,
                      horizontal: 16.0.w,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: _responsiveController.screenHeight * 0.1),
                          Center(
                        child: UniversalImageLoader(
                          imagePath: AppData.appLogo,
                          height: 70.0.h,
                          width: 70.0.w,
                        ),
                      ),
                       SizedBox(height: 16.0.h),
                      Text(
                        fromForgotPasscode ? "Reset Your Passcode" : "Welcome Back!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.0.h),
                      Text(
                        fromForgotPasscode
                            ? "Sign in with email/password to reset your passcode"
                            : "Sign in to continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 42.0.h),
                        _buildSignInForm(context),
                      SizedBox(height: 24.0.h),
                      isLoading
                          ? const Center(child: LazerVaultLoader.small())
                          : SizedBox(
                              width: double.infinity,
                              height: 54.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4834D4),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  // Pill-rounded edges — half-height radius
                                  // gives a true capsule shape regardless of
                                  // device scale.
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.r),
                                  ),
                                ),
                                onPressed: () {
                                    context.read<AuthenticationCubit>().loginUser(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    );
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                ),
                              ),
                            ),
                      SizedBox(height: 12.0.h),
                      if (_hasPasscodeSetup && !isLoading)
                        Center(
                          child: TextButton(
                            onPressed: _switchToPasscodeLogin,
                            child: Text(
                              'Use Passcode Instead',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 12.0.h),
                      UniversalImageLoader(imagePath: AppData.orDivider),
                      SizedBox(height: 24.0.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _socialLoginButton(context, AppData.googleLogo, () {
                              context.read<AuthenticationCubit>().signInWithGoogle();
                          }),
                          SizedBox(width: 10.w),
                          _socialLoginButton(context, AppData.appleLogo, () {
                              context.read<AuthenticationCubit>().signInWithApple();
                          }),
                        ],
                      ),
                      SizedBox(height: 120.h),
                      _buildSignUpLink(context),
                      SizedBox(height: 30.h),
                    ],
                    ),
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

  Widget _buildSignInForm(BuildContext context) {
      return Column(
        children: [
          BuildFormField(
            name: "email",
          placeholder: "Email",
            keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.email, color: Colors.black45),
          controller: _emailController,
          validator: (value) {
            if (value == null || value.isEmpty || !GetUtils.isEmail(value)) {
              Haptics.error();
              return 'Please enter a valid email';
            }
            return null;
          },
          ),
        SizedBox(height: 8.0.h),
          BuildFormField(
            name: "password",
          placeholder: "Password",
            obscureText: true,
          prefixIcon: const Icon(Icons.lock, color: Colors.black45),
          controller: _passwordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              Haptics.error();
              return 'Please enter your password';
            }
            return null;
          },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Get.toNamed(AppRoutes.passwordRecovery),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      );
    }

   Widget _socialLoginButton(BuildContext context, String imagePath, VoidCallback onPressed) {
      return InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 50.0.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0.r),
            border: Border.all(color: Colors.black, width: 1.2),
          ),
          child: UniversalImageLoader(
            imagePath: imagePath,
            height: 24.0.h,
            width: 24.0.w,
          ),
        ),
      );
    }

  Widget _buildSignUpLink(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
          ),
          SizedBox(width: 4.w),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => Get.toNamed(AppRoutes.signUp),
          )
        ],
    );
  }
}

/// Resolve where to send a user who logs in mid-signup, based on the
/// server-tracked `users.current_signup_step` and `users.signup_status`.
///
/// Step names mirror the backend `models.Step*` constants
/// (account_created / email_verify / phone_verify / passcode_setup /
/// identity_verify). Returns `null` for a fully-complete signup so
/// the caller's normal post-login routing runs.
///
/// **MUST stay in sync with `_getRouteForSignupStep` in main.dart** —
/// both files resolve the same set of step strings to GetX routes; one
/// for cold-start resume, the other for post-login resume.
({String name, Map<String, dynamic> args})? _signupResumeRoute(
  String? step,
  String? status, {
  required String email,
  String? phone,
  bool hasTransactionPin = false,
}) {
  // Backend treats "complete" as the terminal status; anything else is
  // either explicit-incomplete or null (legacy users predating the
  // tracking table — fall through to default routing).
  if (status == null || status.isEmpty) return null;
  if (status == 'complete') return null;
  if (step == null || step.isEmpty) return null;

  switch (step) {
    case 'email_verify':
      return (
        name: AppRoutes.emailVerification,
        args: <String, dynamic>{
          'email': email,
          'codeSent': false,
          'isRequired': true,
          'secondaryPhone': phone,
        },
      );
    case 'phone_verify':
      if (phone == null || phone.isEmpty) {
        // No phone on file but backend expects phone verify — defensive
        // fallback to passcode setup; user can add phone in Settings.
        return (
          name: AppRoutes.passcodeSetup,
          args: <String, dynamic>{
            'fromLoginFlow': true,
            'hasTransactionPin': hasTransactionPin,
          },
        );
      }
      return (
        name: AppRoutes.phoneVerification,
        args: <String, dynamic>{
          'phoneNumber': phone,
          'codeSent': false,
          'isRequired': false,
          'expiresIn': 600,
        },
      );
    case 'identity_verify':
      // BVN/NIN flow — KYC entry point.
      return (
        name: AppRoutes.kycBVNVerification,
        args: <String, dynamic>{'fromSignup': true},
      );
    case 'passcode_setup':
    case 'account_created': // user signed up but bailed before any verify
      return (
        name: AppRoutes.passcodeSetup,
        args: <String, dynamic>{
          'fromLoginFlow': true,
          'hasTransactionPin': hasTransactionPin,
        },
      );
  }
  return null;
}
