import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/kyc/data/services/prove_kyc_http_service.dart';
import 'package:lazervault/core/utilities/auth_background.dart';
import 'package:lazervault/core/utilities/passcode_policy.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
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
  bool _isConfirmMode = false;
  bool _isCreating = false;
  bool _isLoading = true;
  String? _errorMessage;

  /// When true, this screen was PUSHED mid-flow (e.g. from a payment that
  /// needs a PIN — see TransactionPinMixin) and must POP back to the caller on
  /// completion/skip so that flow can resume. When false (signup/onboarding /
  /// login-resume, reached via offAllNamed), it routes FORWARD to KYC/dashboard.
  bool get _returnToCaller =>
      (Get.arguments as Map<String, dynamic>?)?['returnOnComplete'] == true;

  // KYC-onboarding flags. The signup cubit writes with the DEFAULT config while
  // main.dart reads with encryptedSharedPreferences:true — different Android
  // backends — so read from both (mirrors bvn_verification_screen).
  static const _flagsDefault = FlutterSecureStorage();
  static const _flagsEncrypted = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      resetOnError: true,
    ),
  );

  Future<String?> _readFlag(String key) async {
    try {
      final v = await _flagsDefault.read(key: key);
      if (v != null) return v;
    } catch (_) {/* fall through */}
    try {
      return await _flagsEncrypted.read(key: key);
    } catch (_) {
      return null;
    }
  }

  Future<void> _deleteFlag(String key) async {
    try {
      await _flagsDefault.delete(key: key);
    } catch (_) {/* best-effort */}
    try {
      await _flagsEncrypted.delete(key: key);
    } catch (_) {/* best-effort */}
  }

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
      // ALWAYS hit the server here (forceRefresh) — never trust the session
      // "has PIN" cache on the setup screen. Otherwise a stale cached `true`
      // (e.g. after a super-admin cleared the PIN and the user logged back in
      // on the same process) would make us skip setup and strand the user with
      // no PIN. The setup screen must be authoritative about whether a PIN
      // genuinely exists.
      await _transactionPinCubit.checkUserHasPin(forceRefresh: true);
      if (mounted) {
        final hasPin = _transactionPinCubit.state.hasPin;
        if (hasPin) {
          // A PIN already exists (returning user / resumed signup). This screen
          // only CREATES a PIN — changing one lives in Settings
          // (PinManagementScreen). Never re-prompt or turn into a change flow;
          // just move forward.
          _proceedToNextStep();
          return;
        }
        setState(() {
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

  /// New-PIN policy for setup: reject trivially guessable PINs. Returns an
  /// error to show, or null.
  String? _newPinSetupError(String pin) {
    if (isWeakNumericCode(pin)) {
      return 'Choose a less predictable PIN (avoid 1111 or 1234).';
    }
    return null;
  }

  void _onNumberPressed(String number) {
    if (_isCreating) return;

    setState(() {
      _errorMessage = null;

      if (!_isConfirmMode) {
        if (_enteredPin.length < _pinLength) {
          _enteredPin += number;

          // Validate the new PIN the moment it's complete (before confirm) so
          // the user isn't asked to confirm a PIN we'll reject — weak codes are
          // rejected up front.
          if (_enteredPin.length == _pinLength) {
            final pinErr = _newPinSetupError(_enteredPin);
            if (pinErr != null) {
              _errorMessage = pinErr;
              _enteredPin = '';
            } else {
              Future.delayed(const Duration(milliseconds: 300), () {
                if (mounted) {
                  setState(() {
                    _isConfirmMode = true;
                  });
                }
              });
            }
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

      if (!_isConfirmMode) {
        if (_enteredPin.isNotEmpty) {
          _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
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
      // Create new PIN. Bounded so a stalled CreateTransactionPin RPC (no gRPC
      // deadline on the write path) can't leave the confirm step spinning
      // forever — a timeout throws TimeoutException, caught below like any error.
      final success = await _transactionPinCubit
          .createPin(
            pin: _enteredPin,
            confirmPin: _confirmedPin,
          )
          .timeout(const Duration(seconds: 20));

      if (success) {
        _showSuccessDialog();
      } else {
        setState(() {
          _isCreating = false;
          _errorMessage = 'Failed to create PIN. Please try again.';
          _confirmedPin = '';
          _isConfirmMode = false;
          _enteredPin = '';
        });
      }
    } on GrpcError catch (e) {
      // Translate the auth-service status code (see classifyPinError in
      // transaction_pin_server.go) into a message that's actionable inline
      // rather than dumping a raw "Exception: rpc error …" at the user.
      String msg;
      switch (e.code) {
        case StatusCode.unauthenticated:
          msg = 'Current PIN is incorrect.';
          break;
        case StatusCode.permissionDenied:
          msg = 'PIN locked due to too many attempts. Try again later.';
          break;
        case StatusCode.alreadyExists:
          msg = 'You already have a PIN. Use Update instead.';
          break;
        case StatusCode.notFound:
          msg = 'You don\'t have a PIN yet. Create one first.';
          break;
        case StatusCode.invalidArgument:
          msg = e.message ?? 'Invalid PIN.';
          break;
        case StatusCode.unavailable:
        case StatusCode.deadlineExceeded:
          // Server unreachable / timed out — never surface the raw
          // "transport: Error while dialing …" string to the user.
          msg = 'Can\'t reach the server right now. Check your connection and try again.';
          break;
        default:
          // Don't leak raw gRPC transport text; keep it short + actionable.
          msg = 'Could not save your PIN. Please try again.';
      }
      setState(() {
        _isCreating = false;
        _errorMessage = msg;
        _confirmedPin = '';
        _isConfirmMode = false;
        _enteredPin = '';
      });
    } catch (e) {
      setState(() {
        _isCreating = false;
        // Keep it short + actionable — never dump the raw exception text, which
        // can be a long "transport: Error while dialing …" string that distorts
        // the layout.
        _errorMessage = 'Could not save your PIN. Please try again.';
        _confirmedPin = '';
        _isConfirmMode = false;
        _enteredPin = '';
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
                'PIN Created!',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(
            'Your Transaction PIN has been set up successfully. You can now make secure payments and transfers.',
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
    // Pushed mid-flow (e.g. from a payment via TransactionPinMixin) — pop back
    // so the caller can re-check the PIN and resume its transaction. Never
    // offAllNamed here, which would wipe the stack and strand the payment.
    if (_returnToCaller) {
      Get.back();
      return;
    }

    // First-time signup, login/resume, and "PIN already exists → skip" all
    // funnel here. Honor the ONE-TIME KYC onboarding gate before the dashboard
    // (same `kyc_onboarding_pending` signal the boot router uses).
    _routeAfterPin();
  }

  /// Route after PIN setup. The KYC (BVN) onboarding step is shown ONLY while
  /// the user is still completing onboarding for the first time — i.e. the
  /// per-signup `kyc_onboarding_pending` flag is still set. That flag is written
  /// at signup and CLEARED the moment KYC is finished OR skipped (see
  /// bvn_verification_screen), so once the user first reaches the dashboard,
  /// subsequent logins go straight there — KYC is then updated via Settings.
  ///
  /// We intentionally do NOT consult `has_skipped_kyc` here: it's a GLOBAL
  /// (not per-user) flag, so a prior user/session skipping KYC would otherwise
  /// suppress the first-time KYC step for a brand-new signup. `kyc_onboarding_pending`
  /// is the per-signup source of truth and is sufficient on its own.
  Future<void> _routeAfterPin() async {
    final kycPending = await _readFlag('kyc_onboarding_pending');
    if (!mounted) return;
    if (kycPending == 'true') {
      // Already Tier 2+? (BVN inserted via Mono Prove, the BVN-only data-match
      // path, or a server-side login catch-up that reconciled a dropped-before-
      // liveness Prove session.) Then DON'T force the KYC screen on login — the
      // user is past the compulsory BVN step. Clear the stale onboarding flag and
      // go straight to the dashboard; further verification (Tier 3 liveness) is
      // optional and done from Settings. Authoritative but bounded; on any error
      // we fall SAFE to showing the (compulsory-below-Tier-2) step.
      try {
        final st = await serviceLocator<ProveKycHttpService>()
            .status()
            .timeout(const Duration(seconds: 4));
        if (!mounted) return;
        if (st.tier >= 2 || st.verified) {
          await _deleteFlag('kyc_onboarding_pending');
          if (!mounted) return;
          Get.offAllNamed(AppRoutes.dashboard);
          return;
        }
      } catch (_) {
        // Status unavailable — fall through to the compulsory KYC step.
      }
      if (!mounted) return;
      // First-time onboarding KYC step. The DEFAULT flow is Mono Prove
      // (kycBVNVerification): its completion webhook already auto-creates the
      // Flutterwave virtual account server-side (Mono verify → kyc.tier.upgrade
      // → accounts provisioner), so no separate BVN entry is needed.
      //
      // When the admin enables the standalone BVN screen
      // (bvn_signup_screen_enabled), signup instead shows that screen — unless
      // this signup already captured a BVN, in which case skip straight ahead.
      if (FeatureFlags.isBvnSignupScreenEnabled()) {
        String? storedBvn;
        try {
          storedBvn = await serviceLocator<SecureStorageService>().getBvn();
        } catch (_) {/* storage unavailable — fall through to the BVN screen */}
        if (!mounted) return;
        Get.offAllNamed(storedBvn == null || storedBvn.trim().isEmpty
            ? AppRoutes.bvnSignup
            : AppRoutes.dashboard);
      } else {
        // Default: skippable Mono Prove onboarding step.
        Get.offAllNamed(AppRoutes.kycBVNVerification);
      }
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
    }
  }

  String _getTitle() {
    if (_isConfirmMode) {
      return 'Confirm New PIN';
    } else {
      return 'Set Up Transaction PIN';
    }
  }

  String _getSubtitle() {
    if (_isConfirmMode) {
      return 'Enter your new PIN again to confirm';
    } else {
      return 'Create a 4-digit PIN for secure payments';
    }
  }

  String _getCurrentDisplayPin() {
    if (_isConfirmMode) {
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
            child: LazerVaultLoader.medium(),
          ),
        ),
      );
    }

    final currentPin = _getCurrentDisplayPin();

    // Signup/onboarding is forward-only (nothing to pop to): block the hardware
    // back gesture — users advance via "Skip for now" or by completing the PIN.
    // When pushed mid-flow (returnToCaller), allow back so the caller resumes,
    // except while a create is in flight.
    return PopScope(
      canPop: _returnToCaller && !_isCreating,
      child: Scaffold(
      extendBodyBehindAppBar: true,
      // No AppBar/back button: this is a forward-only signup step. Users move on
      // via "Skip for now" or by completing the PIN.
      body: Stack(
        children: [
          // Background image
          DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AuthBackground.current),
                fit: BoxFit.cover,
              ),
            ),
            child: const SizedBox.expand(),
          ),
          // Dark overlay — darkened (0.6) so the PIN dots, prompts and keypad
          // read clearly over the bright auth background. Kept in sync with the
          // passcode setup screen.
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
                    // Two zones (like the passcode LOGIN screen): header + dots
                    // on top, number pad anchored LOW like a system keyboard.
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ===== TOP zone: logo + heading + dots =====
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                      SizedBox(height: 40.h),
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
                      // Info text (only on the initial PIN-entry step)
                      if (!_isConfirmMode)
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
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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
                        ],
                      ),
                      // ===== BOTTOM zone: number pad anchored low =====
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                      // Skip button (only on the initial PIN-entry step)
                      if (!_isConfirmMode && !_isCreating)
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
                              const LazerVaultLoader.small(),
                              SizedBox(height: 12.h),
                              Text(
                                'Creating your PIN...',
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
