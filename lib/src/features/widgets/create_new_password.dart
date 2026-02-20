import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';

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
  String _email = '';
  String _deliveryMethod = 'email';
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Get email, reset token and other parameters from route
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = Get.arguments as Map<String, dynamic>?;
      if (args != null) {
        setState(() {
          _email = args['email'] as String? ?? '';
          _resetToken = args['resetToken'] as String? ?? args['token'] as String? ?? '';
          _requireToken = args['requireToken'] as bool? ?? false;
          _deliveryMethod = args['deliveryMethod'] as String? ?? 'email';

          if (_resetToken.isNotEmpty) {
            _tokenController.text = _resetToken;
          }
        });
      }
    });
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

    try {
      if (_resetToken.isNotEmpty || (!_requireToken && tokenToUse.isNotEmpty)) {
        // Use new resetPasswordWithToken method
        await context.read<AuthenticationCubit>().resetPasswordWithToken(
          resetToken: _resetToken.isNotEmpty ? _resetToken : tokenToUse,
          newPassword: newPassword,
        );
      } else {
        // Legacy method for backward compatibility
        await context.read<AuthenticationCubit>().submitResetPassword();
      }
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
          // Show success and navigate will be handled by the listener
          Get.snackbar(
            'Password Reset',
            'Your password has been reset successfully',
            backgroundColor: Colors.green.withValues(alpha: 0.8),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(15.w),
            borderRadius: 10.r,
          );
          // Navigate to login after a delay
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              Get.offAllNamed(AppRoutes.emailSignIn);
            }
          });
        } else if (state is AuthenticationError && !_isLoading) {
          // Show error from state
          _showErrorSnackbar('Error', state.message);
        }
      },
      child: Column(
        children: [
          // Title
          Text(
            'Reset Password',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: AppColors.primaryFont,
            ),
          ),
          SizedBox(height: 8.h),
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
              placeholder: 'Reset Token from ${_deliveryMethod == 'sms' ? 'Email' : 'Email'}',
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
                    color: const Color(0xFF2D2D2D),
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

          // Submit Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
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
                ? SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
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
