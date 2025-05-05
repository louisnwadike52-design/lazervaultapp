import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/widgets/avatar_with_details.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart'; // For PlatformException
// Assuming you have a gRPC client setup
// import 'package:lazervault/src/grpc_client.dart'; // Example import
// import 'package:lazervault/src/generated/auth.pbgrpc.dart'; // Example import

class PasscodeSignIn extends StatefulWidget {
  const PasscodeSignIn({super.key});

  @override
  State<PasscodeSignIn> createState() => _PasscodeSignInState();
}

class _PasscodeSignInState extends State<PasscodeSignIn> {
  // Removed GlobalKey for Scaffold

  // Keep passcode state
  String _enteredPasscode = '';
  final int _passcodeLength = 6; // Define passcode length
  bool _isAuthenticating = false; // Loading state for biometric/login

  // Secure storage instance
  final _secureStorage = const FlutterSecureStorage();
  final String _refreshTokenKey = 'refreshToken'; // Key for storing refresh token
  final String _userEmailKey = 'userEmail'; // Key for storing user email

  // Local auth instance
  final LocalAuthentication _localAuth = LocalAuthentication();

  // State for biometric icon and type
  bool _canCheckBiometrics = false;
  IconData _biometricIcon = Icons.fingerprint; // Default icon
  String _biometricTooltip = 'Use Biometrics';
  BiometricType? _availableBiometricType; // To store the preferred type

  @override
  void initState() {
    super.initState();
    _checkBiometricCapabilities();
  }

  // Check device capabilities and set the appropriate icon/tooltip
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
      canCheck = false; // Assume false if error occurs
    }

    if (!mounted) return; // Check if widget is still in the tree

    setState(() {
        _canCheckBiometrics = canCheck;
        if (_canCheckBiometrics && availableBiometrics.isNotEmpty) {
            // Prioritize Face ID over Fingerprint
            if (availableBiometrics.contains(BiometricType.face)) {
                _availableBiometricType = BiometricType.face;
                _biometricIcon = Icons.face; // Or Icons.face_retouching_natural
                _biometricTooltip = 'Use Face ID';
            } else if (availableBiometrics.contains(BiometricType.fingerprint) ||
                       availableBiometrics.contains(BiometricType.strong) || // Android strong often includes fingerprint
                       availableBiometrics.contains(BiometricType.weak)) { // Android weak might include fingerprint
                _availableBiometricType = BiometricType.fingerprint;
                _biometricIcon = Icons.fingerprint;
                _biometricTooltip = 'Use Fingerprint';
            } else {
                 // Neither face nor fingerprint explicitly found, but biometrics are available
                 // Keep default fingerprint icon or hide button? Let's keep default for now.
                 _availableBiometricType = availableBiometrics.first; // Take the first available one
                 _biometricIcon = Icons.fingerprint; // Keep default
                 _biometricTooltip = 'Use Biometrics';
            }
        } else {
            _availableBiometricType = null; // No specific type usable
        }
    });
  }

  // Mock login function - replace with your actual auth logic
  void _attemptLogin() {
    if (_enteredPasscode.length == _passcodeLength) {
      // Simulate network call or validation
      print('Attempting login with passcode: $_enteredPasscode');
      // TODO: Replace with actual login verification logic
      // If successful:
      Get.offAllNamed(AppRoutes.dashboard);
      // If failed:
      // setState(() { _enteredPasscode = ''; }); // Clear passcode on failure
      // Show error message (e.g., using Get.snackbar or another method)
    }
  }

  // --- Passcode Login --- 
  void _attemptPasscodeLogin() async {
    if (_enteredPasscode.length != _passcodeLength || _isAuthenticating) return;

    setState(() => _isAuthenticating = true);
    print('Attempting login with passcode: $_enteredPasscode');

    try {
      // TODO: Implement actual passcode login verification
      // This should call your standard Login gRPC endpoint
      // Example placeholder:
      await Future.delayed(const Duration(seconds: 1)); 
      bool loginSuccess = true; // Replace with actual gRPC call result
      String? refreshToken = "DUMMY_REFRESH_TOKEN"; // Replace with actual token from LoginResponse
      String? userEmail = "dummy@example.com"; // Replace with actual email

      if (loginSuccess) {
        // Store refresh token and email securely
        await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
        await _secureStorage.write(key: _userEmailKey, value: userEmail);
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        // Handle login failure
        _showErrorSnackbar('Login Failed', 'Invalid passcode.');
        setState(() => _enteredPasscode = ''); // Clear passcode
      }
    } catch (e) {
      // Handle exceptions during login
      _showErrorSnackbar('Login Error', 'An error occurred during login.');
      print('Login error: $e');
      setState(() => _enteredPasscode = '');
    } finally {
      if(mounted) {
          setState(() => _isAuthenticating = false);
      }
    }
  }

  void _onNumberPressed(String number) {
    if (_enteredPasscode.length < _passcodeLength && !_isAuthenticating) {
      setState(() {
        _enteredPasscode += number;
      });
      if (_enteredPasscode.length == _passcodeLength) {
        _attemptPasscodeLogin();
      }
    }
  }

  void _onBackspacePressed() {
    if (_enteredPasscode.isNotEmpty && !_isAuthenticating) {
      setState(() {
        _enteredPasscode =
            _enteredPasscode.substring(0, _enteredPasscode.length - 1);
      });
    }
  }

  // --- Biometric Login --- 
  void _onBiometricPressed() async {
    // Re-check just in case, although initState should handle it
    if (!_canCheckBiometrics || _availableBiometricType == null || _isAuthenticating) {
        if (!_canCheckBiometrics) {
            _showErrorSnackbar('Biometric Error', 'Biometrics not available or supported.');
        } else if (_availableBiometricType == null) {
             _showErrorSnackbar('Biometric Error', 'No supported biometric type found.');
        }
        return;
    }

    setState(() => _isAuthenticating = true);

    try {
      // Use stickyAuth to keep prompt visible, biometricOnly to prevent device credential fallback
      final bool didAuthenticate = await _localAuth.authenticate(
          // Use dynamic reason based on type if desired, or keep generic
          localizedReason: 'Authenticate using ${_biometricTooltip.split(' ').last}', // e.g., "Authenticate using Face ID"
          options: const AuthenticationOptions(
              biometricOnly: true, // Don't allow device passcode fallback
              stickyAuth: true,
              // useErrorDialogs: true // Use system dialogs for errors
          ),
      );

      if (didAuthenticate) {
        print('Biometric authentication successful using ${_availableBiometricType?.toString()}.');
        final storedRefreshToken = await _secureStorage.read(key: _refreshTokenKey);

        if (storedRefreshToken != null && storedRefreshToken.isNotEmpty) {
          print('Calling RefreshToken with stored token...');
          // TODO: Replace with actual gRPC RefreshToken call
           Get.offAllNamed(AppRoutes.dashboard); // Placeholder navigation
        } else {
          print('No refresh token found for biometric login.');
          _showErrorSnackbar('Biometric Login', 'Please log in with your passcode first to enable biometric login.');
        }
      } else {
        print('Biometric authentication failed.');
        // Optional: show a message if auth failed, but often not needed
      }
    } on PlatformException catch (e) {
       print('Biometric PlatformException: ${e.code} - ${e.message}');
       // Handle specific codes if needed, e.g., e.code == 'LockedOut' or 'PermanentlyLockedOut'
       _showErrorSnackbar('Biometric Error', 'An error occurred: ${e.message ?? 'Platform error'}');
    } catch (e) {
       print('Biometric general error: $e');
       _showErrorSnackbar('Biometric Error', 'An unexpected error occurred.');
    } finally {
       if(mounted) {
          setState(() => _isAuthenticating = false);
       }
    }
  }

  // --- Voice Login (Placeholder) ---
  void _onVoicePressed() {
    if (_isAuthenticating) return;
    // TODO: Implement Voice authentication trigger (e.g., start listening)
    print('Voice login tapped - Placeholder');
    _showErrorSnackbar('Voice Login', 'Voice login is not yet implemented.');
    // Placeholder - would eventually call a backend endpoint after voice processing
    // String? userEmail = await _secureStorage.read(key: _userEmailKey);
    // if (userEmail != null) {
    //    callVoiceLoginEndpoint(userEmail);
    // } else { ... }
  }

  void _showErrorSnackbar(String title, String message) {
    if(mounted && Get.isSnackbarOpen == false) { // Prevent multiple snackbars
        Get.snackbar(
          title,
          message,
          backgroundColor: Colors.redAccent.withOpacity(0.8),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(15.w),
          borderRadius: 10.r,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use Theme colors for better consistency
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Calculate approximate available height excluding safe area padding
    final availableHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    // Return the Stack directly, without the Scaffold
    return Stack(
      children: [
        // Dark overlay Container
        Container(
          color: Colors.black.withOpacity(0.6), // 60% opacity black
        ),
        // Original content on top of the overlay
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  // Ensure Column tries to fill at least the viewport height
                  minHeight: availableHeight,
                ),
                child: Column(
                  // Use MainAxisAlignment.end to push flexible space to the top
                  // if content is shorter than the screen.
                  // Use MainAxisAlignment.start if you prefer content aligned top.
                  // Or use MainAxisAlignment.spaceBetween if you want space distributed.
                  mainAxisAlignment: MainAxisAlignment.start, // Adjust as needed
                  children: [
                    // --- Top Content ---
                    Padding(
                      padding: EdgeInsets.only(top: 45.h),
                      child: AvatarWithDetails(
                        title: "Hey Louis 👋",
                        avatar: AppData.dp,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      'Enter your Passcode',
                      style: textTheme.titleMedium?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_passcodeLength, (index) {
                        bool isActive = index < _enteredPasscode.length;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          width: 18.w,
                          height: 18.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isActive
                                ? Colors.white
                                : Colors.white.withOpacity(0.3),
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
                          return _buildNumberButton(number, colorScheme, textTheme.titleLarge, Colors.white);
                        }),
                        Container(),
                        _buildNumberButton('0', colorScheme, textTheme.titleLarge, Colors.white),
                        _buildIconButton(
                          icon: Icons.backspace_outlined,
                          onPressed: _isAuthenticating ? null : _onBackspacePressed, // Disable while authenticating
                          iconColor: _isAuthenticating ? Colors.grey : Colors.white,
                          colorScheme: colorScheme,
                        ),
                      ],
                    ),

                    // --- Flexible Space (Replaces Spacer) ---
                    // Add flexible space if content is shorter than screen
                    // Only works well if Column height is constrained or known.
                    // Given SingleChildScrollView, explicit SizedBox is safer.
                    SizedBox(height: 30.h), // Adjust this height as needed

                    // --- Bottom Content ---
                    TextButton(
                      onPressed: _isAuthenticating ? null : () => Get.toNamed(AppRoutes.passwordRecovery),
                      child: Text(
                        'Forgot your passcode?',
                        style: textTheme.bodyMedium?.copyWith(
                          color: _isAuthenticating ? Colors.grey.withOpacity(0.8) : Colors.white.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    // --- Biometric/Voice Buttons --- 
                    // Show loading indicator or buttons
                    _isAuthenticating 
                    ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Only show biometric button if it's supported
                        // if (_canCheckBiometrics && _availableBiometricType != null)
                           _buildIconButton(
                             icon: _biometricIcon, // Use the icon determined in initState
                             onPressed: _onBiometricPressed,
                             iconColor: Colors.white,
                             colorScheme: colorScheme,
                             tooltip: _biometricTooltip, // Use the tooltip determined in initState
                           ),
                        // Add spacing only if biometric button is shown
                        // if (_canCheckBiometrics && _availableBiometricType != null)
                        //     SizedBox(width: 30.w),

                            // faceId login option 
                            // if(_availableBiometricType == BiometricType.face)
                              _buildIconButton(
                                icon: Icons.face_outlined,
                                onPressed: _onBiometricPressed,
                                iconColor: Colors.white,
                                colorScheme: colorScheme,
                                tooltip: 'Use Face ID',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        TextButton(
                          // Disable during auth attempt
                          onPressed: _isAuthenticating ? null : () => Get.offAllNamed(AppRoutes.signUp),
                          child: Text(
                            "Sign Up",
                            style: textTheme.bodyMedium?.copyWith(
                              color: _isAuthenticating ? Colors.grey : Colors.white,
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
  }

  // Updated helper to accept text style
  Widget _buildNumberButton(
      String number, ColorScheme colorScheme, TextStyle? textStyle, Color textColor) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _isAuthenticating ? null : () => _onNumberPressed(number), // Disable while authenticating
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.15),
          ),
          child: Text(
            number,
            style: (textStyle ?? Theme.of(context).textTheme.titleLarge)?.copyWith(
              fontWeight: FontWeight.w500,
              color: _isAuthenticating ? Colors.grey : textColor,
            ),
          ),
        ),
      ),
    );
  }

  // Helper to build consistently styled icon buttons
  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback? onPressed, // Allow null for disabling
    required ColorScheme colorScheme,
    required Color iconColor,
    String? tooltip,
  }) {
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      iconSize: 30.sp,
      color: onPressed == null ? Colors.grey : iconColor, // Grey out if disabled
      onPressed: onPressed,
      splashRadius: 28.r,
    );
  }
}
