import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/auth_status_sheet.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final _tokenController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _requireToken = false;
  bool _isLoading = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _hasMinimumLength = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasDigit = false;
  bool _hasSpecialChar = false;
  String _resetToken = '';
  String _deliveryMethod = 'email';
  String? _errorMessage;
  // Where to land after a successful reset. Defaults to email sign-in; switched
  // to passcode login when the user's stored preference is phone+passcode.
  String _postResetRoute = AppRoutes.emailSignIn;

  @override
  void initState() {
    super.initState();
    // Get email, reset token and other parameters from route
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = Get.arguments as Map<String, dynamic>?;
      if (args != null) {
        setState(() {
          _resetToken = args['resetToken'] as String? ?? args['token'] as String? ?? '';
          _requireToken = args['requireToken'] as bool? ?? false;
          _deliveryMethod = args['deliveryMethod'] as String? ?? 'email';

          if (_resetToken.isNotEmpty) {
            _tokenController.text = _resetToken;
          }
        });
      }
    });
    // Resolve the post-reset destination from the stored login preference so a
    // phone+passcode user lands on the passcode screen, not email sign-in.
    _resolvePostResetRoute();
  }

  Future<void> _resolvePostResetRoute() async {
    try {
      final pref = await serviceLocator<FlutterSecureStorage>()
          .read(key: 'preferred_login_method');
      final phoneMode = pref == 'phone_passcode' ||
          (pref == null && FeatureFlags.isPhonePasscodeMode);
      if (mounted && phoneMode) {
        setState(() => _postResetRoute = AppRoutes.passcodeLogin);
      }
    } catch (_) {/* keep the email sign-in default */}
  }

  @override
  void dispose() {
    _tokenController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Password strength validation
  void _validatePassword(String password) {
    setState(() {
      _hasMinimumLength = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasLowercase = password.contains(RegExp(r'[a-z]'));
      _hasDigit = password.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  bool _isPasswordValid() {
    return _hasMinimumLength && _hasUppercase && _hasLowercase && _hasDigit && _hasSpecialChar;
  }

  String _getPasswordStrengthText() {
    final int score = [
      _hasMinimumLength,
      _hasUppercase,
      _hasLowercase,
      _hasDigit,
      _hasSpecialChar,
    ].where((e) => e).length;

    if (score <= 2) return 'Weak';
    if (score <= 3) return 'Fair';
    if (score == 4) return 'Good';
    return 'Strong';
  }

  Color _getPasswordStrengthColor() {
    final int score = [
      _hasMinimumLength,
      _hasUppercase,
      _hasLowercase,
      _hasDigit,
      _hasSpecialChar,
    ].where((e) => e).length;

    if (score <= 2) return Colors.red;
    if (score <= 3) return Colors.orange;
    if (score == 4) return Colors.lightGreen;
    return Colors.green;
  }

  Future<void> _submitResetPassword() async {
    // Clear previous error
    setState(() {
      _errorMessage = null;
    });

    // Validate passwords
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final tokenToUse = _requireToken ? _tokenController.text.trim() : _resetToken;

    // Validation
    if (newPassword.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a new password';
      });
      return;
    }

    if (!_isPasswordValid()) {
      setState(() {
        _errorMessage = 'Password does not meet the requirements';
      });
      return;
    }

    if (confirmPassword.isEmpty) {
      setState(() {
        _errorMessage = 'Please confirm your new password';
      });
      return;
    }

    if (newPassword != confirmPassword) {
      setState(() {
        _errorMessage = 'Passwords do not match';
      });
      return;
    }

    if (_requireToken && tokenToUse.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter the reset token from your ${_deliveryMethod == 'sms' ? 'SMS verification' : 'email'}';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // The effective reset token: for the SMS flow it arrives via route args
    // (`_resetToken`, returned by VerifyPasswordResetCode); for the email flow
    // the user pastes the emailed token (`_tokenController`, captured in
    // `tokenToUse`). Either way, a non-empty token goes straight to
    // ResetPassword — the emailed UUID token IS a valid reset token server-side.
    // Previously the email branch fell through to the legacy no-op
    // submitResetPassword(), silently ignoring the pasted token.
    final effectiveToken = tokenToUse.isNotEmpty ? tokenToUse : _resetToken;

    if (effectiveToken.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Reset token is missing. Please restart the reset flow.';
      });
      return;
    }

    try {
      await context.read<AuthenticationCubit>().resetPasswordWithToken(
        resetToken: effectiveToken,
        newPassword: newPassword,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is PasswordResetSuccess) {
          // Confirm success with an on-theme bottom sheet, then send the user
          // to sign in with their new password.
          showAuthStatusSheet(
            context,
            type: AuthStatusType.success,
            title: 'Password updated',
            message:
                'Your password has been reset. Please sign in with your new password.',
            primaryLabel: 'Sign in',
            onPrimary: () => Get.offAllNamed(_postResetRoute),
          );
        } else if (state is AuthenticationError) {
          setState(() {
            _errorMessage = state.message;
            _isLoading = false;
          });
          // Surface the real failure (invalid/expired token, weak password, …)
          // in a bottom sheet with a retry affordance.
          showAuthStatusSheet(
            context,
            type: AuthStatusType.error,
            title: 'Couldn\'t reset password',
            message: state.message,
            primaryLabel: 'Try again',
            secondaryLabel: 'Start over',
            onSecondary: () => Get.offAllNamed(AppRoutes.passwordRecovery),
          );
        }
      },
      child: Column(
        children: [
          // Subtitle — the page title is in the AppBar already; this line
          // gives the user context on what to enter.
          Text(
            _requireToken
                ? 'Enter the reset token from your ${_deliveryMethod == 'sms' ? 'SMS' : 'email'} below, then create your new password.'
                : 'Create a new password below, different from your previous one.',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
              color: AppColors.secondaryFont,
            ),
          ),
          SizedBox(height: 30.h),

          // Token input field (only shown if required)
          if (_requireToken) ...[
            BuildFormField(
              name: 'resetToken',
              placeholder: 'Reset Token from ${_deliveryMethod == 'sms' ? 'SMS Verification' : 'Email'}',
              textInputType: TextInputType.text,
              prefixIcon: const Icon(
                Icons.key,
                color: Colors.grey,
              ),
              controller: _tokenController,
              onChanged: (token) {
                setState(() {
                  _errorMessage = null;
                });
              },
              disabled: _isLoading,
            ),
            SizedBox(height: 16.h),
          ],

          // New Password Field
          BuildFormField(
            name: 'password',
            placeholder: 'New Password',
            obscureText: !_isNewPasswordVisible,
            textInputType: TextInputType.visiblePassword,
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.grey,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: _isLoading ? null : () {
                setState(() {
                  _isNewPasswordVisible = !_isNewPasswordVisible;
                });
              },
            ),
            controller: _newPasswordController,
            onChanged: (password) {
              _validatePassword(password);
              setState(() {
                _errorMessage = null;
              });
            },
            disabled: _isLoading,
          ),

          // Password Strength Indicator
          if (_newPasswordController.text.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Password Strength: ',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.secondaryFont,
                      ),
                    ),
                    Text(
                      _getPasswordStrengthText(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: _getPasswordStrengthColor(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                // Strength bar
                Container(
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: (_getPasswordStrengthText() == 'Weak'
                        ? 0.25
                        : _getPasswordStrengthText() == 'Fair'
                            ? 0.5
                            : _getPasswordStrengthText() == 'Good'
                                ? 0.75
                                : 1.0),
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _getPasswordStrengthColor(),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                // Password requirements
                Wrap(
                  spacing: 12.w,
                  runSpacing: 4.h,
                  children: [
                    _buildRequirementItem('At least 8 characters', _hasMinimumLength),
                    _buildRequirementItem('One uppercase letter', _hasUppercase),
                    _buildRequirementItem('One lowercase letter', _hasLowercase),
                    _buildRequirementItem('One number', _hasDigit),
                    _buildRequirementItem('One special character', _hasSpecialChar),
                  ],
                ),
              ],
            ),
          ],

          SizedBox(height: 8.h),
          BuildFormField(
            name: 'confirmPassword',
            placeholder: 'Confirm New Password',
            obscureText: !_isConfirmPasswordVisible,
            textInputType: TextInputType.visiblePassword,
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Colors.grey,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: _isLoading ? null : () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                });
              },
            ),
            controller: _confirmPasswordController,
            onChanged: (_) {
              setState(() {
                _errorMessage = null;
              });
            },
            disabled: _isLoading,
          ),

          // Error message
          if (_errorMessage != null) ...[
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 18.w),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          SizedBox(height: 32.h),

          // Submit Button — brand purple primary
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4834D4),
              foregroundColor: Colors.white,
              disabledBackgroundColor: const Color(0xFF4834D4).withValues(alpha: 0.4),
              disabledForegroundColor: Colors.white70,
              elevation: 0,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 32.0,
              ),
              minimumSize: Size(double.infinity, 36.h),
            ),
            onPressed: _isLoading ? null : _submitResetPassword,
            child: _isLoading
                ? LazerVaultLoader.small()
                : Text(
                    "Reset Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String text, bool satisfied) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          satisfied ? Icons.check_circle : Icons.circle_outlined,
          size: 14.w,
          color: satisfied ? Colors.green : Colors.grey.withValues(alpha: 0.5),
        ),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 11.sp,
            color: satisfied ? AppColors.primaryFont : AppColors.secondaryFont.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
