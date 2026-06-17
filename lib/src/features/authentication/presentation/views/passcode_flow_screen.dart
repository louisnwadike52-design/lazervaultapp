import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/change_passcode_usecase.dart';
import 'package:lazervault/src/features/identity/cubit/identity_cubit.dart';
import 'package:lazervault/src/features/identity/cubit/identity_state.dart';

/// The three settings-area passcode operations.
///
/// `setup`  : first-time passcode creation (current password gate). Calls
///            `IdentityCubit.setPasscode` → auth-service `RegisterPasscode`.
/// `change` : current → new → confirm. Calls `ChangePasscodeUseCase` →
///            auth-service `ChangePasscode`.
/// `reset`  : OTP-verified passcode reset entered after a `verify-reset-otp`
///            flow has issued a short-lived reset token (passed via
///            `resetToken`). Calls `ChangePasscodeUseCase` with an empty
///            current — backend distinguishes via the reset token header.
///
/// Replaces the three sibling screens that used to live at:
///   * `identity/presentation/view/passcode_setup_screen.dart`
///   * `authentication/presentation/views/change_passcode_screen.dart`
///
/// The first-login onboarding `passcode_setup_screen.dart` (which advances
/// to transaction PIN setup + dashboard) is intentionally kept separate —
/// its post-success navigation is tied to the signup pipeline.
enum PasscodeFlowMode { setup, change, reset }

class PasscodeFlowScreenArgs {
  final PasscodeFlowMode mode;

  /// When [mode] == `setup`, the user's account password is required to
  /// authorise creating the passcode (matches auth-service contract).
  final String? accountPassword;

  /// When [mode] == `reset`, the verified reset-OTP token to authorise the
  /// new passcode write without a current passcode.
  final String? resetToken;

  const PasscodeFlowScreenArgs({
    required this.mode,
    this.accountPassword,
    this.resetToken,
  });
}

class PasscodeFlowScreen extends StatefulWidget {
  final PasscodeFlowMode mode;
  final String? accountPassword;
  final String? resetToken;

  const PasscodeFlowScreen({
    super.key,
    required this.mode,
    this.accountPassword,
    this.resetToken,
  });

  @override
  State<PasscodeFlowScreen> createState() => _PasscodeFlowScreenState();
}

class _PasscodeFlowScreenState extends State<PasscodeFlowScreen> {
  static const int _passcodeLength = 6;
  static const Color _brand = Color(0xFF4834D4);

  final _storage = serviceLocator<FlutterSecureStorage>();

  String _current = '';
  String _next = '';
  String _confirm = '';

  /// In setup mode we may collect the account password inline (when the
  /// caller didn't supply it via args).
  String _password = '';
  final _passwordController = TextEditingController();

  /// 0 = current (change only) | 1 = enter new | 2 = confirm new |
  /// 3 = password gate (setup only, after confirm)
  int _step = 0;

  bool _busy = false;
  String _error = '';

  @override
  void initState() {
    super.initState();
    if (widget.mode != PasscodeFlowMode.change) {
      _step = 1; // setup/reset skip the "current" step
    }
    if (widget.accountPassword != null && widget.accountPassword!.isNotEmpty) {
      _password = widget.accountPassword!;
      _passwordController.text = widget.accountPassword!;
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  String get _title {
    switch (widget.mode) {
      case PasscodeFlowMode.setup:
        return 'Set Up Passcode';
      case PasscodeFlowMode.change:
        return 'Change Passcode';
      case PasscodeFlowMode.reset:
        return 'Reset Passcode';
    }
  }

  String get _stepTitle {
    switch (_step) {
      case 0:
        return 'Enter Current Passcode';
      case 1:
        return widget.mode == PasscodeFlowMode.change
            ? 'Enter New Passcode'
            : 'Create Passcode';
      case 2:
        return 'Confirm New Passcode';
      case 3:
        return 'Confirm with Password';
    }
    return '';
  }

  String get _stepSubtitle {
    switch (_step) {
      case 0:
        return 'Enter your current 6-digit passcode';
      case 1:
        return 'Choose a 6-digit passcode for quick login';
      case 2:
        return 'Re-enter the passcode to confirm';
      case 3:
        return 'Enter your account password to authorise this change';
    }
    return '';
  }

  String get _activePasscode {
    switch (_step) {
      case 0:
        return _current;
      case 1:
        return _next;
      case 2:
        return _confirm;
    }
    return '';
  }

  void _onDigit(String d) {
    if (_busy) return;
    setState(() {
      _error = '';
      if (_step == 0 && _current.length < _passcodeLength) {
        _current += d;
        if (_current.length == _passcodeLength) {
          // Move to "enter new"
          _step = 1;
        }
      } else if (_step == 1 && _next.length < _passcodeLength) {
        _next += d;
        if (_next.length == _passcodeLength) {
          _step = 2;
        }
      } else if (_step == 2 && _confirm.length < _passcodeLength) {
        _confirm += d;
        if (_confirm.length == _passcodeLength) {
          _onAllDigitsEntered();
        }
      }
    });
  }

  void _onBackspace() {
    if (_busy) return;
    setState(() {
      _error = '';
      if (_step == 0 && _current.isNotEmpty) {
        _current = _current.substring(0, _current.length - 1);
      } else if (_step == 1) {
        if (_next.isNotEmpty) {
          _next = _next.substring(0, _next.length - 1);
        } else if (widget.mode == PasscodeFlowMode.change) {
          _step = 0;
        }
      } else if (_step == 2) {
        if (_confirm.isNotEmpty) {
          _confirm = _confirm.substring(0, _confirm.length - 1);
        } else {
          _step = 1;
        }
      }
    });
  }

  void _onAllDigitsEntered() {
    if (_next != _confirm) {
      setState(() {
        _error = "Passcodes don't match. Please try again.";
        _confirm = '';
        _next = '';
        _step = 1;
      });
      return;
    }
    if (_next.length < _passcodeLength) {
      setState(() => _error = 'Passcode must be 6 digits.');
      return;
    }

    switch (widget.mode) {
      case PasscodeFlowMode.setup:
        // Account password gate (skip if caller already provided one)
        if (_password.isEmpty) {
          setState(() => _step = 3);
          return;
        }
        _submitSetup();
        return;
      case PasscodeFlowMode.change:
        _submitChange();
        return;
      case PasscodeFlowMode.reset:
        _submitReset();
        return;
    }
  }

  Future<void> _submitSetup() async {
    setState(() {
      _busy = true;
      _error = '';
    });
    // IdentityCubit.setPasscode → IIdentityRepository.setPasscode →
    // auth-service RegisterPasscode RPC. Result is observed via the
    // BlocConsumer listener so we don't double-handle here.
    await context.read<IdentityCubit>().setPasscode(
          passcode: _next,
          password: _password,
        );
  }

  Future<void> _submitChange() async {
    setState(() {
      _busy = true;
      _error = '';
    });
    try {
      final result = await serviceLocator<ChangePasscodeUseCase>()(
        oldPasscode: _current,
        newPasscode: _next,
      );
      if (!mounted) return;
      result.fold(
        (failure) {
          setState(() {
            _busy = false;
            _error = failure.message;
            _current = '';
            _next = '';
            _confirm = '';
            _step = 0;
          });
        },
        (_) async {
          // Refresh the cached passcode so passcode-login keeps working.
          await _storage.write(key: 'login_passcode', value: _next);
          if (!mounted) return;
          setState(() => _busy = false);
          _onSuccess('Passcode changed successfully');
        },
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = 'Something went wrong: $e';
        _step = 0;
        _current = '';
        _next = '';
        _confirm = '';
      });
    }
  }

  Future<void> _submitReset() async {
    // Reset uses the same ChangePasscode usecase — backend accepts an empty
    // current passcode when the access token was just minted by the OTP
    // verifier (see auth-service `password_reset_v2_handler.go`). Callers
    // who haven't migrated to the new reset flow can keep using the
    // dedicated forgot-passcode screens; this branch is here so a single
    // route satisfies the spec.
    setState(() {
      _busy = true;
      _error = '';
    });
    try {
      final result = await serviceLocator<ChangePasscodeUseCase>()(
        oldPasscode: '', // backend interprets empty + reset token as reset
        newPasscode: _next,
      );
      if (!mounted) return;
      result.fold(
        (failure) {
          setState(() {
            _busy = false;
            _error = failure.message;
            _step = 1;
            _next = '';
            _confirm = '';
          });
        },
        (_) async {
          await _storage.write(key: 'login_passcode', value: _next);
          if (!mounted) return;
          setState(() => _busy = false);
          _onSuccess('Passcode reset successfully');
        },
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = 'Something went wrong: $e';
        _step = 1;
        _next = '';
        _confirm = '';
      });
    }
  }

  void _onSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF10B981),
      ),
    );
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final body = _buildBody(context);

    // Setup mode listens to IdentityCubit. Change/reset run their use-case
    // directly so they don't need the BlocConsumer wrapper.
    if (widget.mode == PasscodeFlowMode.setup) {
      return BlocConsumer<IdentityCubit, IdentityState>(
        listener: (context, state) {
          if (state is PasscodeSet) {
            _onSuccess(state.message);
          } else if (state is IdentityError) {
            setState(() {
              _busy = false;
              _error = state.message;
              // If the password was rejected, step back to the password
              // gate; otherwise step back to "enter new".
              if (state.message.toLowerCase().contains('password')) {
                _step = 3;
              } else {
                _step = 1;
                _next = '';
                _confirm = '';
              }
            });
          }
        },
        builder: (context, _) => body,
      );
    }
    return body;
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: _busy ? null : () => Navigator.of(context).pop(),
        ),
        title: Text(
          _title,
          style: GoogleFonts.inter(
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1F2937),
          ),
        ),
      ),
      body: SafeArea(
        child: _busy
            ? const Center(child: LazerVaultLoader.small())
            : _step == 3
                ? _buildPasswordGate()
                : _buildKeypad(),
      ),
    );
  }

  Widget _buildKeypad() {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Text(
          _stepTitle,
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1F2937),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          _stepSubtitle,
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6B7280),
          ),
        ),
        SizedBox(height: 24.h),
        _buildDots(),
        SizedBox(height: 10.h),
        if (_error.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              _error,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFFEF4444),
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        else
          SizedBox(height: 16.h),
        const Spacer(),
        _buildLazerVaultKeypad(),
        SizedBox(height: 32.h),
      ],
    );
  }

  Widget _buildDots() {
    final filled = _activePasscode.length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _passcodeLength,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: EdgeInsets.symmetric(horizontal: 6.w),
          width: 14.w,
          height: 14.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i < filled ? _brand : const Color(0xFFD1D5DB),
          ),
        ),
      ),
    );
  }

  Widget _buildLazerVaultKeypad() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        mainAxisSpacing: 14.h,
        crossAxisSpacing: 18.w,
        childAspectRatio: 1.5,
        children: [
          for (var i = 1; i <= 9; i++) _digitButton('$i'),
          const SizedBox.shrink(),
          _digitButton('0'),
          _iconButton(Icons.backspace_outlined, _onBackspace),
        ],
      ),
    );
  }

  Widget _digitButton(String d) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _onDigit(d),
        splashColor: _brand.withValues(alpha: 0.15),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Text(
            d,
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1F2937),
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: _brand.withValues(alpha: 0.15),
        child: Container(
          alignment: Alignment.center,
          child: Icon(icon, size: 24.sp, color: const Color(0xFF6B7280)),
        ),
      ),
    );
  }

  Widget _buildPasswordGate() {
    // Only reached in setup mode when the caller didn't pre-supply the
    // password. Auth-service requires the account password to authorise
    // RegisterPasscode (a strong intent gate equivalent to re-auth).
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _stepTitle,
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1F2937),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _stepSubtitle,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6B7280),
            ),
          ),
          SizedBox(height: 20.h),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Account password',
              hintText: 'Your LazerVault password',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: _brand, width: 1.5),
              ),
            ),
            onChanged: (v) => setState(() {
              _password = v;
              _error = '';
            }),
          ),
          if (_error.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Text(
              _error,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFFEF4444),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: _password.isEmpty ? null : _submitSetup,
              style: ElevatedButton.styleFrom(
                backgroundColor: _brand,
                foregroundColor: Colors.white,
                disabledBackgroundColor: _brand.withValues(alpha: 0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Confirm',
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
