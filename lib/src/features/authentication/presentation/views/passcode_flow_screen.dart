import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/haptics_service.dart';
import 'package:lazervault/core/utilities/passcode_policy.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/utilities/auth_background.dart';
import 'package:lazervault/core/widgets/passcode_dots.dart';
import 'package:lazervault/core/widgets/passcode_keypad.dart';
import 'package:lazervault/core/widgets/shake_widget.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/change_passcode_usecase.dart';
import 'package:lazervault/src/features/identity/cubit/identity_cubit.dart';
import 'package:lazervault/src/features/identity/cubit/identity_state.dart';
import 'package:lazervault/src/features/identity/domain/repositories/i_identity_repository.dart';

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

  /// Drives the Revolut-style "wrong passcode" shake on the dots row, matching
  /// the login screen (`passcode_sign_in.dart`).
  final GlobalKey<ShakeWidgetState> _shakeKey = GlobalKey<ShakeWidgetState>();

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

  /// Brute-force lockout countdown (seconds). > 0 disables the keypad and shows
  /// a "try again in mm:ss" message that ticks down via [_lockoutTimer].
  int _lockoutRemaining = 0;
  Timer? _lockoutTimer;

  bool get _locked => _lockoutRemaining > 0;

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
    _lockoutTimer?.cancel();
    _passwordController.dispose();
    super.dispose();
  }

  /// Begin a lockout countdown for [seconds]; disables the keypad and ticks the
  /// "try again" message down to zero, then re-enables entry.
  void _startLockout(int seconds) {
    _lockoutTimer?.cancel();
    if (seconds <= 0) return;
    setState(() {
      _lockoutRemaining = seconds;
      _current = '';
      _error = '';
    });
    _lockoutTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() {
        _lockoutRemaining -= 1;
        if (_lockoutRemaining <= 0) {
          _lockoutRemaining = 0;
          t.cancel();
        }
      });
    });
  }

  String _formatDuration(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    if (m > 0) return '${m}m ${s.toString().padLeft(2, '0')}s';
    return '${s}s';
  }

  /// Local new-passcode policy shared by every mode. Returns an error string to
  /// show (and reject on), or null when the passcode is acceptable.
  String? _newPasscodeError(String code) {
    if (widget.mode == PasscodeFlowMode.change && code == _current) {
      return 'New passcode must be different from your current one.';
    }
    if (isWeakNumericCode(code)) {
      return 'Choose a less predictable passcode (avoid 111111 or 123456).';
    }
    return null;
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
    if (_busy || _locked) return;
    setState(() {
      _error = '';
      if (_step == 0 && _current.length < _passcodeLength) {
        _current += d;
        if (_current.length == _passcodeLength) {
          // Verify the current passcode with the backend BEFORE letting the
          // user enter a new one — so a wrong current code fails fast instead
          // of after they've typed the new code twice.
          _verifyCurrent();
        }
      } else if (_step == 1 && _next.length < _passcodeLength) {
        _next += d;
        if (_next.length == _passcodeLength) {
          // Validate the new passcode AS SOON AS it's entered (not after the
          // confirm step) so the user isn't asked to confirm a code we'll
          // reject — more streamlined.
          final err = _newPasscodeError(_next);
          if (err != null) {
            _error = err;
            _next = '';
            _shakeError();
          } else {
            _step = 2;
          }
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
    if (_busy || _locked) return;
    setState(() {
      _error = '';
      if (_step == 0 && _current.isNotEmpty) {
        _current = _current.substring(0, _current.length - 1);
      } else if (_step == 1) {
        if (_next.isNotEmpty) {
          _next = _next.substring(0, _next.length - 1);
        } else if (widget.mode == PasscodeFlowMode.change) {
          // Going back to the current-passcode step: clear it so it is
          // re-entered and re-verified rather than left full and unverifiable.
          _step = 0;
          _current = '';
        }
      } else if (_step == 2) {
        if (_confirm.isNotEmpty) {
          _confirm = _confirm.substring(0, _confirm.length - 1);
        } else {
          // Step back to "enter new" and clear it so the user re-enters the
          // new passcode cleanly rather than seeing a full, uneditable row.
          _step = 1;
          _next = '';
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
      _shakeError();
      return;
    }
    if (_next.length < _passcodeLength) {
      setState(() => _error = 'Passcode must be 6 digits.');
      _shakeError();
      return;
    }
    // (new != current and weak-code checks already ran when the new passcode
    // was first entered — see _onDigit step 1.)

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

  /// Verify the current passcode server-side (read-only, no session change)
  /// before advancing to "enter new". Handles rate-limit lockout (countdown +
  /// disabled keypad) and network timeouts distinctly from a wrong passcode.
  Future<void> _verifyCurrent() async {
    setState(() {
      _busy = true;
      _error = '';
    });
    try {
      final result = await serviceLocator<IIdentityRepository>()
          .verifyPasscode(passcode: _current)
          .timeout(const Duration(seconds: 15));
      if (!mounted) return;
      result.fold(
        (failure) {
          // Timeouts / connectivity issues are NOT a wrong attempt — let the
          // user retry without penalty.
          setState(() {
            _busy = false;
            _current = '';
            _error = _isConnectivityFailure(failure)
                ? 'Connection timed out. Check your connection and try again.'
                : (failure.message.isNotEmpty
                    ? failure.message
                    : 'Could not verify your passcode. Please try again.');
          });
          _shakeError();
        },
        (res) {
          setState(() => _busy = false);
          if (res.isValid) {
            setState(() => _step = 1); // proceed to "enter new"
          } else if (res.isLockedOut) {
            // Rate-limited — start the countdown + disable the keypad.
            _startLockout(res.retryAfterSeconds);
            _shakeError();
          } else {
            setState(() {
              _current = '';
              _error = res.attemptsRemaining > 0
                  ? 'Incorrect passcode. ${res.attemptsRemaining} '
                      '${res.attemptsRemaining == 1 ? "attempt" : "attempts"} remaining.'
                  : 'Incorrect passcode. Please try again.';
            });
            _shakeError();
          }
        },
      );
    } on TimeoutException {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _current = '';
        _error = 'Connection timed out. Check your connection and try again.';
      });
      _shakeError();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _current = '';
        _error = 'Could not verify your passcode. Please try again.';
      });
      _shakeError();
    }
  }

  /// gRPC DEADLINE_EXCEEDED (4) / UNAVAILABLE (14) — i.e. timeout/connectivity,
  /// surfaced by the repository as a ServerFailure with that status code.
  bool _isConnectivityFailure(Failure failure) {
    final c = failure.statusCode;
    return c == 4 || c == 14;
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
      ).timeout(const Duration(seconds: 20));
      if (!mounted) return;
      result.fold(
        (failure) {
          if (_isConnectivityFailure(failure)) {
            // Timed out — keep the new passcode, just re-confirm to retry.
            _onSubmitTimeout();
          } else {
            setState(() {
              _busy = false;
              _error = failure.message;
              _current = '';
              _next = '';
              _confirm = '';
              _step = 0;
            });
            _shakeError();
          }
        },
        (_) async {
          // Refresh the cached passcode so passcode-login keeps working.
          await _storage.write(key: 'login_passcode', value: _next);
          if (!mounted) return;
          setState(() => _busy = false);
          _onSuccess('Passcode changed successfully');
        },
      );
    } on TimeoutException {
      if (!mounted) return;
      _onSubmitTimeout();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = 'Something went wrong. Please try again.';
        _step = widget.mode == PasscodeFlowMode.change ? 0 : 1;
        _current = '';
        _next = '';
        _confirm = '';
      });
      _shakeError();
    }
  }

  /// Submit timed out — don't discard the chosen new passcode; drop back to the
  /// confirm step so a single re-confirm retries the write.
  void _onSubmitTimeout() {
    setState(() {
      _busy = false;
      _error = 'Connection timed out. Please re-enter to try again.';
      _confirm = '';
      _step = 2;
    });
    _shakeError();
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
      ).timeout(const Duration(seconds: 20));
      if (!mounted) return;
      result.fold(
        (failure) {
          if (_isConnectivityFailure(failure)) {
            _onSubmitTimeout();
          } else {
            setState(() {
              _busy = false;
              _error = failure.message;
              _step = 1;
              _next = '';
              _confirm = '';
            });
            _shakeError();
          }
        },
        (_) async {
          await _storage.write(key: 'login_passcode', value: _next);
          if (!mounted) return;
          setState(() => _busy = false);
          _onSuccess('Passcode reset successfully');
        },
      );
    } on TimeoutException {
      if (!mounted) return;
      _onSubmitTimeout();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = 'Something went wrong. Please try again.';
        _step = 1;
        _next = '';
        _confirm = '';
      });
      _shakeError();
    }
  }

  /// Shake the dots + fire an error haptic, exactly like the login screen does
  /// on a wrong passcode. Call inside a `setState` that has already updated
  /// `_error` (and any step reset).
  void _shakeError() {
    _shakeKey.currentState?.shake();
    Haptics.error();
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
            _shakeError();
          }
        },
        builder: (context, _) => body,
      );
    }
    return body;
  }

  Widget _buildBody(BuildContext context) {
    // Auth background image + dark overlay, matching the passcode login/setup
    // screens (`passcode_setup_screen.dart` / `passcode_sign_in.dart`) so the
    // settings passcode flow looks consistent with the rest of the auth surface.
    // PopScope blocks back-navigation (gesture/button) while a verify/write is
    // in flight so we never pop mid-operation; otherwise back returns to Settings.
    return PopScope(
      canPop: !_busy,
      child: Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _busy ? null : () => Navigator.of(context).pop(),
        ),
        // No title — the step heading ("Enter Current Passcode" / "Create
        // Passcode" / "Confirm New Passcode") already names the action.
      ),
      body: Stack(
        children: [
          // Background image (matching passcode login/setup).
          DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AuthBackground.current),
                fit: BoxFit.cover,
              ),
            ),
            child: const SizedBox.expand(),
          ),
          // Dark overlay (0.6) so dots, prompts and keypad read clearly over
          // the bright auth background — kept in sync with the setup screens.
          Container(color: Colors.black.withValues(alpha: 0.6)),
          SafeArea(
            child: _busy
                ? const Center(child: LazerVaultLoader.small())
                : _step == 3
                    ? _buildPasswordGate()
                    : _buildKeypad(),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildKeypad() {
    // Center the whole cluster (heading → subtitle → dots → keypad) vertically
    // in the area below the transparent AppBar, mirroring the auth passcode
    // setup/login screens — no large gap between the dots and the keypad.
    final media = MediaQuery.of(context);
    final availableHeight =
        media.size.height - media.padding.top - kToolbarHeight;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: availableHeight),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            // Two zones split by a flexible gap (mirrors the passcode LOGIN
            // screen): heading + dots on top, keypad anchored LOW like a system
            // keyboard rather than floating in the middle.
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ===== TOP zone: heading + subtitle + dots =====
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
              SizedBox(height: 16.h),
              Text(
                _stepTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                _stepSubtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
              SizedBox(height: 36.h),
              ShakeWidget(
                key: _shakeKey,
                child: PasscodeDots(
                  length: _passcodeLength,
                  filled: _activePasscode.length,
                ),
              ),
              SizedBox(height: 12.h),
              if (_locked)
                Text(
                  'Too many attempts. Try again in '
                  '${_formatDuration(_lockoutRemaining)}.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: const Color(0xFFFB923C),
                    fontWeight: FontWeight.w600,
                  ),
                )
              else if (_error.isEmpty)
                SizedBox(height: 20.h)
              else
                Text(
                  _error,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: const Color(0xFFEF4444),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ],
              ),
              // ===== BOTTOM zone: keypad anchored low (system-keyboard feel) =====
              // Disable + dim the keypad during a rate-limit lockout.
              Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: IgnorePointer(
                  ignoring: _locked,
                  child: AnimatedOpacity(
                    opacity: _locked ? 0.4 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: PasscodeKeypad(
                      onDigit: _onDigit,
                      onBackspace: _onBackspace,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _stepSubtitle,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 20.h),
          TextField(
            controller: _passwordController,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Account password',
              labelStyle:
                  TextStyle(color: Colors.white.withValues(alpha: 0.7)),
              hintText: 'Your Lazervault password',
              hintStyle:
                  TextStyle(color: Colors.white.withValues(alpha: 0.4)),
              filled: true,
              fillColor: const Color(0xFF1F1F1F),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
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
