import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/widgets/avatar_with_details.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';

class PasscodeSignIn extends StatefulWidget {
  const PasscodeSignIn({super.key});

  @override
  State<PasscodeSignIn> createState() => _PasscodeSignInState();
}

class _PasscodeSignInState extends State<PasscodeSignIn> {
  final int _passcodeLength = 6;

  final _secureStorage = const FlutterSecureStorage();
  final LocalAuthentication _localAuth = LocalAuthentication();

  bool _canCheckBiometrics = false;
  IconData _biometricIcon = Icons.fingerprint;
  String _biometricTooltip = 'Use Biometrics';
  BiometricType? _availableBiometricType;

  // Stored user data
  String? _storedFirstName;
  String? _storedAvatarUrl;

  @override
  void initState() {
    super.initState();
    _checkBiometricCapabilities();
    _loadStoredUserData();

    // Initialize passcode login state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthenticationCubit>().startPasscodeLogin();
    });
  }

  Future<void> _checkBiometricCapabilities() async {
    bool canCheck = false;
    List<BiometricType> availableBiometrics = [];
    try {
      canCheck = await _localAuth.canCheckBiometrics;
      if (canCheck) {
        availableBiometrics = await _localAuth.getAvailableBiometrics();
      }
    } on PlatformException catch (e) {
      print("Error checking biometrics: $e");
      canCheck = false;
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheck;
      if (_canCheckBiometrics && availableBiometrics.isNotEmpty) {
        if (availableBiometrics.contains(BiometricType.face)) {
          _availableBiometricType = BiometricType.face;
          _biometricIcon = Icons.face;
          _biometricTooltip = 'Use Face ID';
        } else if (availableBiometrics.contains(BiometricType.fingerprint) ||
            availableBiometrics.contains(BiometricType.strong) ||
            availableBiometrics.contains(BiometricType.weak)) {
          _availableBiometricType = BiometricType.fingerprint;
          _biometricIcon = Icons.fingerprint;
          _biometricTooltip = 'Use Fingerprint';
        } else {
          _availableBiometricType = availableBiometrics.first;
          _biometricIcon = Icons.fingerprint;
          _biometricTooltip = 'Use Biometrics';
        }
      } else {
        _availableBiometricType = null;
      }
    });
  }

  Future<void> _loadStoredUserData() async {
    try {
      final firstName = await _secureStorage.read(key: 'user_first_name');
      final avatarUrl = await _secureStorage.read(key: 'user_avatar_url');

      if (mounted) {
        setState(() {
          _storedFirstName = firstName;
          _storedAvatarUrl = avatarUrl;
        });
      }
    } catch (e) {
      print('Error loading stored user data: $e');
    }
  }

  void _onNumberPressed(String number) {
    context.read<AuthenticationCubit>().passcodeLoginDigitEntered(number);
  }

  void _onBackspacePressed() {
    context.read<AuthenticationCubit>().passcodeLoginBackspace();
  }

  void _onBiometricPressed() async {
    final currentState = context.read<AuthenticationCubit>().state;
    final isAuthenticating = currentState is PasscodeLoginInProgress && currentState.isAuthenticating;

    if (!_canCheckBiometrics || _availableBiometricType == null || isAuthenticating) {
      if (!_canCheckBiometrics) {
        _showErrorSnackbar('Biometric Error', 'Biometrics not available or supported.');
      } else if (_availableBiometricType == null) {
        _showErrorSnackbar('Biometric Error', 'No supported biometric type found.');
      }
      return;
    }

    try {
      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Authenticate using ${_biometricTooltip.split(' ').last}',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (didAuthenticate) {
        print('Biometric authentication successful using ${_availableBiometricType?.toString()}.');
        final storedRefreshToken = await _secureStorage.read(key: 'refresh_token');

        if (storedRefreshToken != null && storedRefreshToken.isNotEmpty) {
          print('Navigating to dashboard after biometric auth...');
          Get.offAllNamed(AppRoutes.dashboard);
        } else {
          print('No refresh token found for biometric login.');
          _showErrorSnackbar('Biometric Login', 'Please log in with your passcode first to enable biometric login.');
        }
      } else {
        print('Biometric authentication failed.');
      }
    } on PlatformException catch (e) {
      print('Biometric PlatformException: ${e.code} - ${e.message}');
      _showErrorSnackbar('Biometric Error', 'An error occurred: ${e.message ?? 'Platform error'}');
    } catch (e) {
      print('Biometric general error: $e');
      _showErrorSnackbar('Biometric Error', 'An unexpected error occurred.');
    }
  }

  void _onVoicePressed() {
    final currentState = context.read<AuthenticationCubit>().state;
    final isAuthenticating = currentState is PasscodeLoginInProgress && currentState.isAuthenticating;

    if (isAuthenticating) return;
    print('Voice login tapped - Placeholder');
    _showErrorSnackbar('Voice Login', 'Voice login is not yet implemented.');
  }

  void _switchToEmailPasswordLogin() {
    Get.offAllNamed(AppRoutes.emailSignIn);
  }

  void _showErrorSnackbar(String title, String message) {
    if (mounted && Get.isSnackbarOpen == false) {
      Get.snackbar(
        title,
        message,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(15.w),
        borderRadius: 10.r,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final availableHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    // Determine display name
    String displayName = 'Welcome Back 👋';
    if (_storedFirstName != null && _storedFirstName!.isNotEmpty) {
      displayName = 'Hey ${_storedFirstName!} 👋';
    }

    // Determine avatar to use
    String avatarPath = _storedAvatarUrl ?? AppData.dp;

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          // Load user profile after successful authentication
          context.read<ProfileCubit>().getUserProfile();
          Get.offAllNamed(AppRoutes.dashboard);
        }
      },
      builder: (context, state) {
        // Handle non-passcode login states
        if (state is! PasscodeLoginInProgress) {
          return Stack(
            children: [
              Container(
                color: Colors.black.withValues(alpha: 0.6),
              ),
              const Center(child: CircularProgressIndicator(color: Colors.white)),
            ],
          );
        }

        final passcodeState = state;
        final enteredPasscode = passcodeState.enteredPasscode;
        final isAuthenticating = passcodeState.isAuthenticating;

        return Stack(
          children: [
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
                      Padding(
                        padding: EdgeInsets.only(top: 45.h),
                        child: AvatarWithDetails(
                          title: displayName,
                          avatar: avatarPath,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        'Enter your Passcode',
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_passcodeLength, (index) {
                          bool isActive = index < enteredPasscode.length;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            width: 18.w,
                            height: 18.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isActive
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.3),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 35.h),
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
                            return _buildNumberButton(number, colorScheme, textTheme.titleLarge, Colors.white, isAuthenticating);
                          }),
                          Container(),
                          _buildNumberButton('0', colorScheme, textTheme.titleLarge, Colors.white, isAuthenticating),
                          _buildIconButton(
                            icon: Icons.backspace_outlined,
                            onPressed: isAuthenticating ? null : _onBackspacePressed,
                            iconColor: isAuthenticating ? Colors.grey : Colors.white,
                            colorScheme: colorScheme,
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      TextButton(
                        onPressed: isAuthenticating ? null : () => Get.toNamed(AppRoutes.emailSignIn, arguments: {'fromForgotPasscode': true}),
                        child: Text(
                          'Forgot your passcode?',
                          style: textTheme.bodyMedium?.copyWith(
                            color: isAuthenticating ? Colors.grey.withValues(alpha: 0.8) : Colors.white.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      isAuthenticating
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_canCheckBiometrics && _availableBiometricType != null)
                                  _buildIconButton(
                                    icon: _biometricIcon,
                                    onPressed: _onBiometricPressed,
                                    iconColor: Colors.white,
                                    colorScheme: colorScheme,
                                    tooltip: _biometricTooltip,
                                  ),
                                if (_canCheckBiometrics && _availableBiometricType != null)
                                  SizedBox(width: 20.w),
                                FutureBuilder<bool>(
                                  future: context.read<AuthenticationCubit>().checkFaceRegistration(),
                                  builder: (context, snapshot) {
                                    // Only show facial recognition icon if face is registered
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const SizedBox.shrink();
                                    }
                                    if (snapshot.data == true) {
                                      return Row(
                                        children: [
                                          _buildIconButton(
                                            icon: Icons.face_retouching_natural,
                                            onPressed: () => Get.toNamed(AppRoutes.facialLogin),
                                            iconColor: Colors.white,
                                            colorScheme: colorScheme,
                                            tooltip: 'Use Facial Recognition',
                                          ),
                                          SizedBox(width: 20.w),
                                        ],
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                                _buildIconButton(
                                  icon: Icons.mic_none_outlined,
                                  onPressed: _onVoicePressed,
                                  iconColor: Colors.white,
                                  colorScheme: colorScheme,
                                  tooltip: 'Use Voice Login (Placeholder)',
                                ),
                              ],
                            ),
                      SizedBox(height: 15.h),
                      TextButton(
                        onPressed: isAuthenticating ? null : _switchToEmailPasswordLogin,
                        child: Text(
                          "Use Email/Password Instead",
                          style: textTheme.bodyMedium?.copyWith(
                            color: isAuthenticating ? Colors.grey : Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                          TextButton(
                            onPressed: isAuthenticating ? null : () => Get.offAllNamed(AppRoutes.signUp),
                            child: Text(
                              "Sign Up",
                              style: textTheme.bodyMedium?.copyWith(
                                color: isAuthenticating ? Colors.grey : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ],
        );
      },
    );
  }

  Widget _buildNumberButton(
      String number, ColorScheme colorScheme, TextStyle? textStyle, Color textColor, bool isAuthenticating) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: isAuthenticating ? null : () => _onNumberPressed(number),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.15),
          ),
          child: Text(
            number,
            style: (textStyle ?? Theme.of(context).textTheme.titleLarge)?.copyWith(
              fontWeight: FontWeight.w500,
              color: isAuthenticating ? Colors.grey : textColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required ColorScheme colorScheme,
    required Color iconColor,
    String? tooltip,
  }) {
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      iconSize: 30.sp,
      color: onPressed == null ? Colors.grey : iconColor,
      onPressed: onPressed,
      splashRadius: 28.r,
    );
  }
}
