import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/widgets/user_avatar.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/haptics_service.dart';
import 'package:lazervault/core/widgets/shake_widget.dart';
import 'package:lazervault/core/widgets/passcode_dots.dart';
import 'package:lazervault/core/widgets/passcode_keypad.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class PasscodeSignIn extends StatefulWidget {
  const PasscodeSignIn({super.key});

  @override
  State<PasscodeSignIn> createState() => _PasscodeSignInState();
}

class _PasscodeSignInState extends State<PasscodeSignIn> {
  final int _passcodeLength = 6;

  // Revolut-style "wrong passcode" shake: the dots row shakes + a heavy haptic
  // fires whenever a new passcode error arrives. _lastError de-dupes so we
  // shake once per distinct error, not on every rebuild.
  final GlobalKey<ShakeWidgetState> _passcodeShakeKey =
      GlobalKey<ShakeWidgetState>();
  String? _lastError;

  final _secureStorage = serviceLocator<FlutterSecureStorage>();
  final LocalAuthentication _localAuth = LocalAuthentication();

  bool _canCheckBiometrics = false;
  IconData _biometricIcon = Icons.fingerprint;
  String _biometricTooltip = 'Use Biometrics';
  BiometricType? _availableBiometricType;

  // Stored user data
  String? _storedFirstName;
  String? _storedLastName;
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
      final lastName = await _secureStorage.read(key: 'user_last_name');
      final avatarUrl = await _secureStorage.read(key: 'user_avatar_url');

      if (mounted) {
        setState(() {
          _storedFirstName = firstName;
          _storedLastName = lastName;
          _storedAvatarUrl = avatarUrl;
        });
      }
    } catch (e) {
      print('Error loading stored user data: $e');
    }
  }

  // Note: the key-tap haptic now fires inside the shared PasscodeKeypad, so
  // these callbacks must NOT also call Haptics.keyTap() (would double-buzz).
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

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          // Load user profile after successful authentication
          context.read<ProfileCubit>().getUserProfile();
          Get.offAllNamed(AppRoutes.dashboard);
        } else if (state is PasscodeLoginInProgress) {
          // Wrong passcode → shake the dots + a heavy haptic, once per error.
          if (state.errorMessage != null &&
              state.errorMessage != _lastError) {
            _lastError = state.errorMessage;
            _passcodeShakeKey.currentState?.shake();
            Haptics.error();
          } else if (state.errorMessage == null) {
            _lastError = null;
          }
        }
      },
      builder: (context, state) {
        // Handle non-passcode login states
        if (state is! PasscodeLoginInProgress) {
          return Stack(
            children: [
              Positioned.fill(
                child: Container(color: Colors.black.withValues(alpha: 0.5)),
              ),
              const Center(child: LazerVaultLoader.small()),
            ],
          );
        }

        final passcodeState = state;
        final enteredPasscode = passcodeState.enteredPasscode;
        final isAuthenticating = passcodeState.isAuthenticating;

        return Stack(
          children: [
            Positioned.fill(
              child: Container(color: Colors.black.withValues(alpha: 0.5)),
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
                        // Smaller top inset so the whole stack sits higher and
                        // the bottom "Sign Up" row is never clipped on shorter
                        // screens (was 45.h, which pushed the bottom off-screen).
                        padding: EdgeInsets.only(top: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Per spec: passcode screen shows the app
                            // logo on a brand-purple halo when no
                            // profile picture is set (NOT initials —
                            // we don't want to flash a stranger's
                            // initials before they've signed in).
                            UserAvatar(
                              // Industry-standard sign-in avatar size
                              // (~80px) — large enough to anchor the
                              // screen, small enough to leave the
                              // greeting + keypad room to breathe.
                              size: 80.r,
                              imageUrl: _storedAvatarUrl,
                              firstName: _storedFirstName,
                              lastName: _storedLastName,
                              fallbackMode: UserAvatarFallback.appLogo,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              displayName,
                              style: GoogleFonts.inter(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
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
                      ShakeWidget(
                        key: _passcodeShakeKey,
                        child: PasscodeDots(
                          length: _passcodeLength,
                          filled: enteredPasscode.length,
                        ),
                      ),
                      SizedBox(height: 35.h),
                      PasscodeKeypad(
                        onDigit: _onNumberPressed,
                        onBackspace: _onBackspacePressed,
                        disabled: isAuthenticating,
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
                              child: const LazerVaultLoader.small(),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          TextButton(
                            onPressed: isAuthenticating ? null : () => Get.offAllNamed(AppRoutes.signUp),
                            // Shrink the tap padding so "Sign Up" sits inline
                            // with the question text instead of floating high.
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              "Sign Up",
                              style: textTheme.bodyMedium?.copyWith(
                                color: isAuthenticating ? Colors.grey : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Bottom breathing room so the signup row clears the
                      // device gesture bar / screen edge (outer SafeArea
                      // already accounts for the system inset). Kept modest so
                      // it doesn't push the row off the bottom on small screens.
                      SizedBox(height: 16.h),
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
