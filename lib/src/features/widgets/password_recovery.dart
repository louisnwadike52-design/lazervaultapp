import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/domain/sms_policy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:lazervault/src/generated/auth.pbenum.dart' as auth_enum;
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({super.key});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _email = '';
  String _phone = '';

  // PREFILLED FROM THIS DEVICE'S REMEMBERED ACCOUNT, and locked while it is.
  //
  // This screen had NO prefill on either tab, so someone recovering a password
  // on the handset they use every day had to retype an address the app already
  // knew — and every retype is a chance to typo into somebody else's account
  // and send THEM a reset.
  //
  // Locked with a way out. The stored identity can belong to a different
  // person (a shared or second-hand phone) or to nobody at all, and recovery
  // is the last path a user has: a screen that will only ever address the
  // previous owner's account has nothing to offer them.
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _identityLocked = false;
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _errorMessage = null;
      });
    });
    _prefillFromDevice();
  }

  Future<void> _prefillFromDevice() async {
    try {
      final store = serviceLocator<FlutterSecureStorage>();
      final email = (await store.read(key: 'stored_email'))?.trim() ?? '';
      final phone = (await store.read(key: 'stored_phone'))?.trim() ?? '';
      if (!mounted || (email.isEmpty && phone.isEmpty)) return;
      setState(() {
        _email = email;
        _phone = phone;
        _emailController.text = email;
        _phoneController.text = phone;
        // Locked only when there is actually something to lock to.
        _identityLocked = true;
      });
    } catch (_) {
      // A storage read that fails costs the prefill, never the screen — the
      // user can still type their address, which is today's behaviour.
    }
  }

  /// Clears the remembered account so a different one can be recovered.
  void _useDifferentAccount() {
    setState(() {
      _identityLocked = false;
      _email = '';
      _phone = '';
      _emailController.clear();
      _phoneController.clear();
      _errorMessage = null;
    });
  }

  Widget _buildNotYouAction() {
    if (!_identityLocked) return const SizedBox.shrink();
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: _isLoading ? null : _useDifferentAccount,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text('Not you? Use a different account',
            style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w600)),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _tabController.dispose();
    super.dispose();
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

  void _showSuccessSnackbar(String title, String message) {
    if (mounted && Get.isSnackbarOpen == false) {
      Get.snackbar(
        title,
        message,
        backgroundColor: Colors.green.withValues(alpha: 0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(15.w),
        borderRadius: 10.r,
      );
    }
  }

  bool _validateEmail(String email) {
    if (email.isEmpty) return false;
    // Basic email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _validatePhone(String phone) {
    if (phone.isEmpty) return false;
    // Check if phone starts with + and has 8-15 digits
    final phoneRegex = RegExp(r'^\+[1-9]\d{7,14}$');
    return phoneRegex.hasMatch(phone);
  }

  Future<void> _submitPasswordReset() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    final tabIndex = _tabController.index;
    final cubit = context.read<AuthenticationCubit>();

    try {
      if (tabIndex == 0) {
        // Email flow
        if (!_validateEmail(_email)) {
          setState(() {
            _errorMessage = 'Please enter a valid email address';
            _isLoading = false;
          });
          return;
        }

        final result = await cubit.requestPasswordResetV2(
          email: _email,
          deliveryMethod:
              auth_enum.PasswordResetDeliveryMethod.DELIVERY_METHOD_EMAIL,
        );

        if (!mounted) return;

        result.fold(
          (failure) {
            setState(() {
              _errorMessage = failure.message;
              _isLoading = false;
            });
          },
          (data) {
            setState(() {
              _isLoading = false;
            });

            // Check if user was found - for better UX while maintaining security
            if (!data.userFound) {
              setState(() {
                _errorMessage =
                    'We couldn\'t find an account with that email address. Please check and try again.';
              });
              return;
            }

            setState(() {
              _successMessage = data.message;
            });
            _showSuccessSnackbar('Email Sent', data.message);

            // Navigate to new password screen after delay
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                Get.toNamed(
                  AppRoutes.createNewPassword,
                  arguments: {
                    'email': _email,
                    'resetToken': data.resetToken ?? '',
                    'requireToken':
                        data.resetToken == null || data.resetToken!.isEmpty,
                    'deliveryMethod': 'email',
                    'maskedContact': data.maskedContact,
                  },
                );
              }
            });
          },
        );
      } else {
        // SMS flow
        if (!_validatePhone(_phone)) {
          setState(() {
            _errorMessage =
                'Please enter a valid phone number (e.g., +234XXXXXXXXXX)';
            _isLoading = false;
          });
          return;
        }

        final result = await cubit.requestPasswordResetV2(
          phone: _phone,
          deliveryMethod:
              auth_enum.PasswordResetDeliveryMethod.DELIVERY_METHOD_SMS,
        );

        if (!mounted) return;

        result.fold(
          (failure) {
            setState(() {
              _errorMessage = failure.message;
              _isLoading = false;
            });
          },
          (data) {
            setState(() {
              _isLoading = false;
            });

            // Check if user was found - for better UX while maintaining security
            if (!data.userFound) {
              setState(() {
                _errorMessage =
                    'We couldn\'t find an account with that phone number. Please check and try again.';
              });
              return;
            }

            setState(() {
              _successMessage = data.message;
            });
            _showSuccessSnackbar('SMS Sent', data.message);

            // Navigate to OTP verification screen after delay
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                Get.toNamed(
                  AppRoutes.verifyPasswordResetOTP,
                  arguments: {
                    'phone': _phone,
                    'maskedContact': data.maskedContact,
                    'deliveryMethod': 'sms',
                    'expiresInSeconds': data.expiresInSeconds,
                  },
                );
              }
            });
          },
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'An error occurred. Please try again.';
          _isLoading = false;
        });
        _showErrorSnackbar('Error', _errorMessage!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        // Handle any authentication state changes
        if (state is AuthenticationError && !_isLoading) {
          // Only show errors from state, not from our submission
          // (those are handled in submit method)
        }
      },
      child: Column(
        children: [
          // Icon
          Center(
            child: UniversalImageLoader(
              imagePath: 'assets/images/profile/password-recovery.png',
              width: 60.w,
              height: 60.h,
            ),
          ),
          SizedBox(height: 24.h),

          // Title (not a duplicate of the AppBar's "Password Recovery")
          Text(
            'Forgot your password?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: AppColors.primaryFont,
            ),
          ),
          SizedBox(height: 12.h),

          // Subtitle
          Text(
            'Choose how you want to receive your password reset code',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.secondaryFont,
            ),
          ),
          SizedBox(height: 32.h),

          // Tabs — light track for the white theme.
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.r),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.secondaryFont,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(text: 'Email'),
                Tab(text: 'SMS'),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Tab Views
          SizedBox(
            height: 200.h,
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // Email Tab
                _buildEmailTab(),
                // SMS Tab
                _buildSMSTab(),
              ],
            ),
          ),

          // Error message
          if (_errorMessage != null) ...[
            SizedBox(height: 16.h),
            _buildMessageContainer(
              icon: Icons.error_outline,
              iconColor: Colors.red,
              message: _errorMessage!,
              bgColor: Colors.red.withValues(alpha: 0.1),
              borderColor: Colors.red.withValues(alpha: 0.3),
            ),
          ],

          // Success message
          if (_successMessage != null) ...[
            SizedBox(height: 16.h),
            _buildMessageContainer(
              icon: Icons.check_circle_outline,
              iconColor: Colors.green,
              message: _successMessage!,
              bgColor: Colors.green.withValues(alpha: 0.1),
              borderColor: Colors.green.withValues(alpha: 0.3),
            ),
          ],

          SizedBox(height: 32.h),

          // Submit Button
          _buildSubmitButton(),

          SizedBox(height: 16.h),

          // Back to Login link
          TextButton(
            onPressed: _isLoading
                ? null
                : () {
                    if (Navigator.canPop(context)) {
                      Get.back();
                    }
                  },
            child: Text(
              'Back to Login',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageContainer({
    required IconData icon,
    required Color iconColor,
    required String message,
    required Color bgColor,
    required Color borderColor,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20.w),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: iconColor,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter your registered email address',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.secondaryFont,
          ),
        ),
        SizedBox(height: 16.h),
        BuildFormField(
          leading:
              const Icon(Icons.email_outlined, color: AppColors.secondaryFont),
          name: 'email',
          placeholder: 'Enter your email',
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
          readOnly: _identityLocked,
          onChanged: (value) {
            setState(() {
              _email = value;
              _errorMessage = null;
            });
          },
          disabled: _isLoading,
        ),
        _buildNotYouAction(),
        SizedBox(height: 12.h),
        Text(
          'We\'ll send a password reset link to your email.',
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.secondaryFont.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildSMSTab() {
    // THE ONE RECOVERY FLOW THAT BYPASSED SmsPolicy.
    //
    // Every other SMS-dependent surface asks the policy before offering the
    // option — that module exists precisely so four screens in three features
    // cannot answer the same question differently. This tab did not, so with
    // no provider the user picked SMS, submitted a number, and waited for a
    // code nothing had attempted to send.
    //
    // SHOWN AND REFUSED, not hidden — the same choice canUseSmsTwoFactor
    // makes. A vanished SMS tab beside an Email one reads as the feature
    // being broken; a stated reason is a fact the user can act on by
    // switching tabs.
    if (!SmsPolicy.available) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline_rounded,
                    size: 18.sp, color: Colors.blue),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    SmsPolicy.unavailableReason,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      height: 1.4,
                      color: AppColors.secondaryFont,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Use the Email tab to receive your reset code.',
            style: TextStyle(fontSize: 13.sp, color: AppColors.secondaryFont),
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter your registered phone number',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.secondaryFont,
          ),
        ),
        SizedBox(height: 16.h),
        BuildFormField(
          leading:
              const Icon(Icons.phone_outlined, color: AppColors.secondaryFont),
          name: 'phone',
          placeholder: '+234XXXXXXXXXX',
          keyboardType: TextInputType.phone,
          controller: _phoneController,
          readOnly: _identityLocked,
          onChanged: (value) {
            setState(() {
              _phone = value;
              _errorMessage = null;
            });
          },
          disabled: _isLoading,
        ),
        SizedBox(height: 12.h),
        Text(
          'We\'ll send a 6-digit verification code to your phone.',
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.secondaryFont.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // Brand purple — consistent with the login + reset-password buttons.
        backgroundColor: const Color(0xFF4834D4),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: const StadiumBorder(),
        padding: EdgeInsets.symmetric(vertical: 14.h),
        minimumSize: Size(double.infinity, 48.h),
      ),
      onPressed: _isLoading ? null : _submitPasswordReset,
      child: _isLoading
          ? LazerVaultLoader.small()
          : Text(
              "Send Reset Code",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
    );
  }
}
