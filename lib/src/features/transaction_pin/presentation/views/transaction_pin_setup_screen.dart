import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:lazervault/src/features/transaction_pin/cubit/transaction_pin_cubit.dart';

/// Screen for setting up a transaction PIN during signup flow
/// This is a 4-digit PIN used for authorizing payments and transfers
class TransactionPinSetupScreen extends StatefulWidget {
  const TransactionPinSetupScreen({super.key});

  @override
  State<TransactionPinSetupScreen> createState() => _TransactionPinSetupScreenState();
}

class _TransactionPinSetupScreenState extends State<TransactionPinSetupScreen> {
  final int _pinLength = 4;
  String _enteredPin = '';
  String _confirmedPin = '';
  String _currentPin = ''; // For change PIN flow
  bool _isConfirmMode = false;
  bool _isCreating = false;
  bool _isLoading = true;
  bool _userHasPin = false;
  bool _isChangePinMode = false; // true when user already has PIN and wants to change
  bool _hasEnteredCurrentPin = false; // for change flow
  String? _errorMessage;

  late TransactionPinCubit _transactionPinCubit;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    // Get the cubit from the service locator
    _transactionPinCubit = serviceLocator<TransactionPinCubit>();

    // Check if user already has a PIN
    _checkUserHasPin();
  }

  Future<void> _checkUserHasPin() async {
    try {
      await _transactionPinCubit.checkUserHasPin();
      if (mounted) {
        setState(() {
          _userHasPin = _transactionPinCubit.state.hasPin;
          _isChangePinMode = _userHasPin;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to check PIN status';
        });
      }
    }
  }

  void _onNumberPressed(String number) {
    if (_isCreating) return;

    setState(() {
      _errorMessage = null;

      // For change PIN flow, first collect current PIN
      if (_isChangePinMode && !_hasEnteredCurrentPin) {
        if (_currentPin.length < _pinLength) {
          _currentPin += number;

          // Move to new PIN entry when current PIN is complete
          if (_currentPin.length == _pinLength) {
            Future.delayed(const Duration(milliseconds: 300), () {
              if (mounted) {
                setState(() {
                  _hasEnteredCurrentPin = true;
                });
              }
            });
          }
        }
        return;
      }

      if (!_isConfirmMode) {
        if (_enteredPin.length < _pinLength) {
          _enteredPin += number;

          // Auto-switch to confirm mode when PIN is complete
          if (_enteredPin.length == _pinLength) {
            Future.delayed(const Duration(milliseconds: 300), () {
              if (mounted) {
                setState(() {
                  _isConfirmMode = true;
                });
              }
            });
          }
        }
      } else {
        if (_confirmedPin.length < _pinLength) {
          _confirmedPin += number;

          // Auto-submit when confirmation is complete
          if (_confirmedPin.length == _pinLength) {
            Future.delayed(const Duration(milliseconds: 300), () {
              if (mounted) {
                _submitPin();
              }
            });
          }
        }
      }
    });
  }

  void _onBackspacePressed() {
    if (_isCreating) return;

    setState(() {
      _errorMessage = null;

      // For change PIN flow, handle current PIN backspace
      if (_isChangePinMode && !_hasEnteredCurrentPin) {
        if (_currentPin.isNotEmpty) {
          _currentPin = _currentPin.substring(0, _currentPin.length - 1);
        }
        return;
      }

      if (!_isConfirmMode) {
        if (_enteredPin.isNotEmpty) {
          _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
        } else if (_isChangePinMode && _hasEnteredCurrentPin) {
          // Go back to current PIN entry in change flow
          _hasEnteredCurrentPin = false;
        }
      } else {
        if (_confirmedPin.isNotEmpty) {
          _confirmedPin = _confirmedPin.substring(0, _confirmedPin.length - 1);
        } else {
          // Go back to entry mode if backspace on empty confirm
          _isConfirmMode = false;
        }
      }
    });
  }

  Future<void> _submitPin() async {
    if (_enteredPin != _confirmedPin) {
      setState(() {
        _errorMessage = 'PINs do not match. Please try again.';
        _confirmedPin = '';
        _isConfirmMode = false;
        _enteredPin = '';
      });
      return;
    }

    setState(() {
      _isCreating = true;
      _errorMessage = null;
    });

    try {
      bool success;

      if (_isChangePinMode) {
        // Change existing PIN
        success = await _transactionPinCubit.changePin(
          currentPin: _currentPin,
          newPin: _enteredPin,
          confirmNewPin: _confirmedPin,
        );
      } else {
        // Create new PIN
        success = await _transactionPinCubit.createPin(
          pin: _enteredPin,
          confirmPin: _confirmedPin,
        );
      }

      if (success) {
        _showSuccessDialog();
      } else {
        setState(() {
          _isCreating = false;
          _errorMessage = _isChangePinMode
              ? 'Failed to change PIN. Please check your current PIN.'
              : 'Failed to create PIN. Please try again.';
          _confirmedPin = '';
          _isConfirmMode = false;
          _enteredPin = '';
          if (_isChangePinMode) {
            _hasEnteredCurrentPin = false;
            _currentPin = '';
          }
        });
      }
    } catch (e) {
      setState(() {
        _isCreating = false;
        _errorMessage = _isChangePinMode
            ? 'Error changing PIN: ${e.toString()}'
            : 'Error creating PIN: ${e.toString()}';
        _confirmedPin = '';
        _isConfirmMode = false;
        _enteredPin = '';
        if (_isChangePinMode) {
          _hasEnteredCurrentPin = false;
          _currentPin = '';
        }
      });
    }
  }

  void _skipPinSetup() {
    _showSkipConfirmationDialog();
  }

  void _showSkipConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            'Skip Transaction PIN?',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'You can set up your Transaction PIN later from Settings. Without a PIN, you won\'t be able to make payments or transfers.',
            style: TextStyle(fontSize: 14.sp),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Set PIN Now',
                style: TextStyle(fontSize: 14.sp, color: Colors.blue),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _proceedToNextStep();
              },
              child: Text(
                'Skip for Now',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    final isChange = _isChangePinMode;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28.sp),
              SizedBox(width: 8.w),
              Text(
                isChange ? 'PIN Changed!' : 'PIN Created!',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(
            isChange
                ? 'Your Transaction PIN has been changed successfully.'
                : 'Your Transaction PIN has been set up successfully. You can now make secure payments and transfers.',
            style: TextStyle(fontSize: 14.sp),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _proceedToNextStep();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ],
        );
      },
    );
  }

  void _proceedToNextStep() {
    // If user already had a PIN (change flow from settings), just go back
    if (_userHasPin) {
      Get.back();
      return;
    }

    // Otherwise, this is signup flow - show face registration prompt or go to dashboard
    _showFaceRegistrationPrompt();
  }

  void _showFaceRegistrationPrompt() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            'Setup Face Recognition?',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Would you like to enable Face Recognition for faster login?',
            style: TextStyle(fontSize: 14.sp),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Get.offAllNamed(AppRoutes.dashboard);
              },
              child: Text(
                'Skip for now',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Get.offAllNamed(AppRoutes.faceScan);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Setup Face Recognition',
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ],
        );
      },
    );
  }

  String _getTitle() {
    if (_isChangePinMode && !_hasEnteredCurrentPin) {
      return 'Enter Current PIN';
    } else if (_isConfirmMode) {
      return 'Confirm New PIN';
    } else if (_isChangePinMode) {
      return 'Enter New PIN';
    } else {
      return 'Set Up Transaction PIN';
    }
  }

  String _getSubtitle() {
    if (_isChangePinMode && !_hasEnteredCurrentPin) {
      return 'Enter your current 4-digit PIN to continue';
    } else if (_isConfirmMode) {
      return 'Enter your new PIN again to confirm';
    } else if (_isChangePinMode) {
      return 'Enter a new 4-digit PIN';
    } else {
      return 'Create a 4-digit PIN for secure payments';
    }
  }

  String _getCurrentDisplayPin() {
    if (_isChangePinMode && !_hasEnteredCurrentPin) {
      return _currentPin;
    } else if (_isConfirmMode) {
      return _confirmedPin;
    } else {
      return _enteredPin;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final availableHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    // Show loading while checking PIN status
    if (_isLoading) {
      return Scaffold(
        body: Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      );
    }

    final currentPin = _getCurrentDisplayPin();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _isChangePinMode
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            )
          : null,
      body: Stack(
        children: [
          // Background image
          DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://picsum.photos/seed/lazervaultpin/1080/1920',
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
                      SizedBox(height: _isChangePinMode ? 20.h : 60.h),
                      Center(
                        child: UniversalImageLoader(
                          imagePath: AppData.appLogo,
                          height: 80.h,
                          width: 80.w,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      // Lock icon for transaction PIN
                      Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                        size: 48.sp,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        _getTitle(),
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        _getSubtitle(),
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      // Info text (only for new PIN setup, not change flow)
                      if (!_isConfirmMode && !_isChangePinMode)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            'This PIN will be required for all payments and transfers',
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.6),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      SizedBox(height: 40.h),
                      // Error message
                      if (_errorMessage != null)
                        Container(
                          margin: EdgeInsets.only(bottom: 20.h),
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.red.withValues(alpha: 0.5)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline, color: Colors.red, size: 20.sp),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  _errorMessage!,
                                  style: TextStyle(
                                    color: Colors.red.shade200,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      // PIN dots indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _pinLength,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: EdgeInsets.symmetric(horizontal: 12.w),
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index < currentPin.length
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
                            return _buildNumberButton(number, _isCreating);
                          }),
                          Container(), // Empty space
                          _buildNumberButton('0', _isCreating),
                          _buildIconButton(
                            icon: Icons.backspace_outlined,
                            onPressed: _isCreating ? null : _onBackspacePressed,
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      // Skip button (only on first entry during signup, not for change flow)
                      if (!_isConfirmMode && !_isCreating && !_isChangePinMode)
                        TextButton(
                          onPressed: _skipPinSetup,
                          child: Text(
                            'Skip for now',
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      if (_isCreating)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Column(
                            children: [
                              const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                _isChangePinMode ? 'Changing your PIN...' : 'Creating your PIN...',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
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
