import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/utilities/auth_background.dart';
import 'package:lazervault/core/utilities/passcode_policy.dart';
import 'package:lazervault/src/features/transaction_pin/cubit/transaction_pin_cubit.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/transaction_pin/widgets/pin_success_view.dart';

/// Settings → Security → Transaction PIN.
///
/// One screen that switches between SET and UPDATE flows based on whether
/// the user already has a PIN. No OTP step — this is a direct
/// authenticated keypad flow that talks to auth-service's
/// `CreateTransactionPin` / `ChangeTransactionPin` RPCs.
///
/// Flow states (driven by `_stage`):
///
///   SET (no PIN yet):
///     1. enterNew    — enter the new 4-digit PIN
///     2. confirmNew  — re-enter to confirm
///     3. success     — auto-dismisses back to caller
///
///   UPDATE (has PIN):
///     1. enterCurrent — enter the existing PIN
///     2. enterNew     — enter the new PIN
///     3. confirmNew   — re-enter to confirm
///     4. success      — auto-dismisses back to caller
///
/// All validation errors render inline under the keypad — never as a
/// snackbar — so the user keeps context without losing the PIN row.
class PinManagementScreen extends StatefulWidget {
  const PinManagementScreen({super.key});

  @override
  State<PinManagementScreen> createState() => _PinManagementScreenState();
}

enum _PinStage {
  loading,
  enterCurrent,
  enterNew,
  confirmNew,
  submitting,
  success,
}

class _PinManagementScreenState extends State<PinManagementScreen> {
  static const int _pinLength = 4;
  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _textPrimary = Colors.white;
  static const Color _errorRed = Color(0xFFEF4444);

  late final TransactionPinCubit _cubit;
  late final ITransactionPinService _pinService;

  _PinStage _stage = _PinStage.loading;
  bool _hasExistingPin = false;

  String _currentPin = '';
  String _newPin = '';
  String _confirmPin = '';

  String? _inlineError;

  /// True while the current PIN is being verified up front (before "enter new").
  bool _verifyingCurrent = false;

  /// Rate-limit lockout countdown (seconds). > 0 disables the keypad and shows
  /// a "try again in mm:ss" message that ticks down via [_lockoutTimer].
  int _lockoutRemaining = 0;
  Timer? _lockoutTimer;

  bool get _locked => _lockoutRemaining > 0;

  @override
  void initState() {
    super.initState();
    _cubit = serviceLocator<TransactionPinCubit>();
    _pinService = serviceLocator<ITransactionPinService>();
    _bootstrap();
  }

  @override
  void dispose() {
    _lockoutTimer?.cancel();
    super.dispose();
  }

  void _startLockout(int seconds) {
    _lockoutTimer?.cancel();
    if (seconds <= 0) return;
    setState(() {
      _lockoutRemaining = seconds;
      _currentPin = '';
      _inlineError = null;
      _stage = _PinStage.enterCurrent;
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

  Future<void> _bootstrap() async {
    try {
      final hasPin = await _pinService.checkUserHasPin();
      if (!mounted) return;
      setState(() {
        _hasExistingPin = hasPin;
        _stage = hasPin ? _PinStage.enterCurrent : _PinStage.enterNew;
      });
    } catch (e) {
      if (!mounted) return;
      // Hard failure to even check status — surface inline and let user retry
      // via the back button. We default to the SET flow so the user isn't
      // blocked entirely; if they actually have a PIN, the backend will
      // reject CreateTransactionPin with AlreadyExists and we'll re-route.
      setState(() {
        _hasExistingPin = false;
        _stage = _PinStage.enterNew;
        _inlineError = 'Could not check PIN status. You can still set or change your PIN.';
      });
    }
  }

  // ── Keypad input ─────────────────────────────────────────────────────────

  String get _activeBuffer {
    switch (_stage) {
      case _PinStage.enterCurrent:
        return _currentPin;
      case _PinStage.enterNew:
        return _newPin;
      case _PinStage.confirmNew:
        return _confirmPin;
      default:
        return '';
    }
  }

  void _setActiveBuffer(String value) {
    switch (_stage) {
      case _PinStage.enterCurrent:
        _currentPin = value;
        break;
      case _PinStage.enterNew:
        _newPin = value;
        break;
      case _PinStage.confirmNew:
        _confirmPin = value;
        break;
      default:
        break;
    }
  }

  bool get _isInputStage =>
      _stage == _PinStage.enterCurrent ||
      _stage == _PinStage.enterNew ||
      _stage == _PinStage.confirmNew;

  void _onKey(String d) {
    if (!_isInputStage || _locked || _verifyingCurrent) return;
    if (_activeBuffer.length >= _pinLength) return;
    setState(() {
      _inlineError = null;
      _setActiveBuffer(_activeBuffer + d);
    });
    if (_activeBuffer.length == _pinLength) {
      // Slight beat so the user sees the final dot fill before we advance.
      Future.delayed(const Duration(milliseconds: 180), _advance);
    }
  }

  void _onBackspace() {
    if (!_isInputStage || _locked || _verifyingCurrent) return;
    final buf = _activeBuffer;
    if (buf.isEmpty) {
      // On empty buffer, allow stepping back through stages so the user can
      // correct an earlier step without exiting the screen.
      _stepBack();
      return;
    }
    setState(() {
      _inlineError = null;
      _setActiveBuffer(buf.substring(0, buf.length - 1));
    });
  }

  void _stepBack() {
    setState(() {
      _inlineError = null;
      switch (_stage) {
        case _PinStage.confirmNew:
          _confirmPin = '';
          _newPin = '';
          _stage = _PinStage.enterNew;
          break;
        case _PinStage.enterNew:
          if (_hasExistingPin) {
            _newPin = '';
            _currentPin = '';
            _stage = _PinStage.enterCurrent;
          }
          break;
        default:
          break;
      }
    });
  }

  // ── Stage progression ────────────────────────────────────────────────────

  void _advance() {
    if (!mounted) return;
    switch (_stage) {
      case _PinStage.enterCurrent:
        // Verify the current PIN with the backend BEFORE asking for the new
        // one — so a wrong current PIN fails fast (and counts toward lockout)
        // instead of after the user has typed the new PIN twice.
        _verifyCurrentPin();
        break;
      case _PinStage.enterNew:
        final err = _newPinError(_newPin);
        if (err != null) {
          setState(() {
            _inlineError = err;
            _newPin = '';
          });
          return;
        }
        setState(() => _stage = _PinStage.confirmNew);
        break;
      case _PinStage.confirmNew:
        if (_newPin != _confirmPin) {
          setState(() {
            _inlineError = 'PINs don\'t match. Try again.';
            _confirmPin = '';
            _newPin = '';
            _stage = _PinStage.enterNew;
          });
          return;
        }
        _submit();
        break;
      default:
        break;
    }
  }

  /// New-PIN policy: must be 4 digits, differ from the current PIN (change
  /// flow), and not be trivially guessable. Checked the moment the new PIN is
  /// entered (before confirm) so the user isn't asked to confirm a rejected PIN.
  String? _newPinError(String pin) {
    if (pin.length != _pinLength) return 'PIN must be $_pinLength digits.';
    if (_hasExistingPin && pin == _currentPin) {
      return 'New PIN must be different from your current one.';
    }
    if (isWeakNumericCode(pin)) {
      return 'Choose a less predictable PIN (avoid 1111 or 1234).';
    }
    return null;
  }

  /// Verify the current PIN up front (reuses the authenticated VerifyTransactionPin
  /// RPC with a non-transactional "pin_change" context — a real backend check
  /// that also applies the shared lockout). Handles lockout countdown + timeout.
  Future<void> _verifyCurrentPin() async {
    setState(() {
      _verifyingCurrent = true;
      _inlineError = null;
    });
    try {
      final res = await _pinService
          .verifyPin(
            pin: _currentPin,
            transactionId: 'pin-change',
            transactionType: 'pin_change',
            amount: 0,
            currency: 'NGN',
          )
          .timeout(const Duration(seconds: 15));
      if (!mounted) return;
      setState(() => _verifyingCurrent = false);
      if (res.success) {
        setState(() => _stage = _PinStage.enterNew);
      } else if (res.isLocked || res.isLockedUntil) {
        final secs = res.lockedUntil != null
            ? res.lockedUntil!.difference(DateTime.now()).inSeconds
            : 15 * 60;
        _startLockout(secs > 0 ? secs : 15 * 60);
      } else {
        setState(() {
          _currentPin = '';
          _inlineError = res.remainingAttempts > 0
              ? 'Incorrect PIN. ${res.remainingAttempts} '
                  '${res.remainingAttempts == 1 ? "attempt" : "attempts"} remaining.'
              : 'Incorrect PIN. Please try again.';
        });
      }
    } on TimeoutException {
      if (!mounted) return;
      setState(() {
        _verifyingCurrent = false;
        _currentPin = '';
        _inlineError =
            'Connection timed out. Check your connection and try again.';
      });
    } on GrpcError catch (e) {
      if (!mounted) return;
      setState(() {
        _verifyingCurrent = false;
        _currentPin = '';
        if (e.code == StatusCode.permissionDenied) {
          // Locked but no structured timestamp — fall back to the default window.
          _startLockout(15 * 60);
          return;
        }
        if (e.code == StatusCode.notFound) {
          _hasExistingPin = false;
          _stage = _PinStage.enterNew;
          _inlineError = 'You don\'t have a PIN yet. Set one now.';
          return;
        }
        _inlineError = e.code == StatusCode.deadlineExceeded ||
                e.code == StatusCode.unavailable
            ? 'Connection timed out. Check your connection and try again.'
            : 'Incorrect PIN. Please try again.';
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _verifyingCurrent = false;
        _currentPin = '';
        _inlineError = 'Could not verify your PIN. Please try again.';
      });
    }
  }

  Future<void> _submit() async {
    setState(() {
      _stage = _PinStage.submitting;
      _inlineError = null;
    });

    try {
      bool ok;
      if (_hasExistingPin) {
        ok = await _cubit
            .changePin(
              currentPin: _currentPin,
              newPin: _newPin,
              confirmNewPin: _confirmPin,
            )
            .timeout(const Duration(seconds: 20));
      } else {
        ok = await _cubit
            .createPin(
              pin: _newPin,
              confirmPin: _confirmPin,
            )
            .timeout(const Duration(seconds: 20));
      }

      if (!mounted) return;

      if (ok) {
        setState(() => _stage = _PinStage.success);
        // Brief celebration beat, then auto-return to the previous screen
        // (Settings) with `true` so callers can refresh state if needed.
        await Future.delayed(const Duration(milliseconds: 1200));
        if (!mounted) return;
        Get.back(result: true);
        return;
      }

      // Cubit returned false — pull the error message off its state if there
      // is one; otherwise fall back to a generic prompt.
      final cubitErr = _cubit.state.errorMessage;
      _handleFailure(cubitErr ?? 'Could not save your PIN. Try again.');
    } on TimeoutException {
      // Timed out — keep the new PIN, just re-confirm to retry.
      if (!mounted) return;
      setState(() {
        _confirmPin = '';
        _stage = _PinStage.confirmNew;
        _inlineError = 'Connection timed out. Please re-enter to try again.';
      });
    } on GrpcError catch (e) {
      _handleGrpcFailure(e);
    } catch (e) {
      _handleFailure(_friendlyErrorMessage(e.toString()));
    }
  }

  void _handleGrpcFailure(GrpcError e) {
    // Map gRPC status codes to inline UI behaviour. The backend status codes
    // here come from `classifyPinError` in transaction_pin_server.go.
    switch (e.code) {
      case StatusCode.unauthenticated:
        // Wrong current PIN — restart from the current-PIN stage.
        setState(() {
          _currentPin = '';
          _newPin = '';
          _confirmPin = '';
          _stage = _hasExistingPin ? _PinStage.enterCurrent : _PinStage.enterNew;
          _inlineError = 'Current PIN is incorrect.';
        });
        return;
      case StatusCode.permissionDenied:
        // Locked — start the countdown + disable the keypad (no structured
        // timestamp from this RPC, so use the default lockout window).
        _newPin = '';
        _confirmPin = '';
        _startLockout(15 * 60);
        return;
      case StatusCode.deadlineExceeded:
      case StatusCode.unavailable:
        setState(() {
          _confirmPin = '';
          _stage = _PinStage.confirmNew;
          _inlineError =
              'Connection timed out. Please re-enter to try again.';
        });
        return;
      case StatusCode.alreadyExists:
        // The user actually has a PIN — switch to the update flow.
        setState(() {
          _hasExistingPin = true;
          _currentPin = '';
          _newPin = '';
          _confirmPin = '';
          _stage = _PinStage.enterCurrent;
          _inlineError = 'You already have a PIN. Enter it to change it.';
        });
        return;
      case StatusCode.notFound:
        // No PIN to change — switch to the create flow.
        setState(() {
          _hasExistingPin = false;
          _currentPin = '';
          _newPin = '';
          _confirmPin = '';
          _stage = _PinStage.enterNew;
          _inlineError = 'You don\'t have a PIN yet. Set one now.';
        });
        return;
      case StatusCode.invalidArgument:
        _handleFailure(_friendlyErrorMessage(e.message ?? 'Invalid PIN.'));
        return;
      default:
        _handleFailure(_friendlyErrorMessage(e.message ?? 'Could not save your PIN. Try again.'));
        return;
    }
  }

  void _handleFailure(String message) {
    setState(() {
      _newPin = '';
      _confirmPin = '';
      _stage = _hasExistingPin ? _PinStage.enterCurrent : _PinStage.enterNew;
      // Don't keep an old current PIN in memory on failure restart.
      _currentPin = '';
      _inlineError = message;
    });
  }

  String _friendlyErrorMessage(String raw) {
    final cleaned = raw.replaceAll('Exception:', '').trim();
    if (cleaned.isEmpty) return 'Something went wrong. Try again.';
    return cleaned;
  }

  // ── Build ────────────────────────────────────────────────────────────────

  String get _title {
    switch (_stage) {
      case _PinStage.enterCurrent:
        return 'Enter Current PIN';
      case _PinStage.enterNew:
        return _hasExistingPin ? 'Enter New PIN' : 'Set Up Transaction PIN';
      case _PinStage.confirmNew:
        return 'Confirm New PIN';
      case _PinStage.success:
        return _hasExistingPin ? 'PIN Updated' : 'PIN Created';
      case _PinStage.submitting:
        return _hasExistingPin ? 'Updating PIN…' : 'Creating PIN…';
      case _PinStage.loading:
        return 'Transaction PIN';
    }
  }

  String get _subtitle {
    switch (_stage) {
      case _PinStage.enterCurrent:
        return 'Enter your current 4-digit PIN to continue.';
      case _PinStage.enterNew:
        return _hasExistingPin
            ? 'Pick a new 4-digit PIN for your transactions.'
            : 'Create a 4-digit PIN. You\'ll use it to approve payments and transfers.';
      case _PinStage.confirmNew:
        return 'Re-enter your new PIN to confirm.';
      case _PinStage.success:
        return _hasExistingPin
            ? 'Use your new PIN for your next transaction.'
            : 'You can now make secure payments and transfers.';
      case _PinStage.submitting:
        return 'Hang tight…';
      case _PinStage.loading:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final busy = _stage == _PinStage.submitting || _verifyingCurrent;
    return BlocProvider.value(
      value: _cubit,
      // Block back-nav while a verify/write is in flight; otherwise back to Settings.
      child: PopScope(
        canPop: !busy,
        child: Scaffold(
          backgroundColor: _bg,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: _textPrimary),
              onPressed: busy ? null : () => Get.back(),
            ),
            // No title — the step heading already names the action, matching the
            // passcode flow.
          ),
          body: Stack(
            children: [
              // Auth background image + dark overlay (parity with the passcode
              // and login/setup screens).
              DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AuthBackground.current),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const SizedBox.expand(),
              ),
              Container(color: Colors.black.withValues(alpha: 0.6)),
              SafeArea(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: _buildBody(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_stage) {
      case _PinStage.loading:
        return const Center(
          key: ValueKey('loading'),
          child: LazerVaultLoader.medium(),
        );
      case _PinStage.success:
        return _buildSuccess();
      default:
        return _buildEntry();
    }
  }

  Widget _buildEntry() {
    final submitting = _stage == _PinStage.submitting;
    final busy = submitting || _verifyingCurrent;
    final buffer = _activeBuffer;

    return Padding(
      key: const ValueKey('entry'),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 24.h),
          Text(
            _title,
            style: GoogleFonts.inter(
              color: _textPrimary,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            _subtitle,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          _StageBreadcrumb(
            stage: _stage,
            hasExistingPin: _hasExistingPin,
          ),
          SizedBox(height: 28.h),
          _PinDots(
            length: _pinLength,
            filled: buffer.length,
            isError: _inlineError != null,
          ),
          SizedBox(height: 14.h),
          // Status region — lockout countdown (orange) takes priority, else the
          // inline error (red). Fixed height so the keypad doesn't jump.
          SizedBox(
            height: 36.h,
            child: _locked
                ? Center(
                    child: Text(
                      'Too many attempts. Try again in '
                      '${_formatDuration(_lockoutRemaining)}.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: const Color(0xFFFB923C),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    child: _inlineError == null
                        ? const SizedBox.shrink()
                        : Row(
                            key: ValueKey(_inlineError),
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error_outline,
                                  color: _errorRed, size: 16),
                              SizedBox(width: 6.w),
                              Flexible(
                                child: Text(
                                  _inlineError!,
                                  style: GoogleFonts.inter(
                                    color: _errorRed,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                  ),
          ),
          SizedBox(height: 8.h),
          if (busy)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: LazerVaultLoader.small(),
            )
          else
            Expanded(
              child: Center(
                child: IgnorePointer(
                  ignoring: _locked,
                  child: AnimatedOpacity(
                    opacity: _locked ? 0.4 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: _Keypad(
                      onKey: _onKey,
                      onBackspace: _onBackspace,
                      disabled: _locked,
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _buildSuccess() {
    // Centralized PIN-success confirmation (shared across PIN flows).
    return PinSuccessView(title: _title, subtitle: _subtitle);
  }
}

class _StageBreadcrumb extends StatelessWidget {
  final _PinStage stage;
  final bool hasExistingPin;

  const _StageBreadcrumb({required this.stage, required this.hasExistingPin});

  @override
  Widget build(BuildContext context) {
    final steps = hasExistingPin
        ? const [_PinStage.enterCurrent, _PinStage.enterNew, _PinStage.confirmNew]
        : const [_PinStage.enterNew, _PinStage.confirmNew];

    int currentIdx = steps.indexOf(stage);
    if (currentIdx == -1) {
      // Submitting or success — peg to the last step.
      currentIdx = steps.length - 1;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps.length, (i) {
        final filled = i <= currentIdx;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: 28.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: filled
                ? const Color(0xFF3B82F6)
                : const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(2.r),
          ),
        );
      }),
    );
  }
}

class _PinDots extends StatelessWidget {
  final int length;
  final int filled;
  final bool isError;

  const _PinDots({
    required this.length,
    required this.filled,
    required this.isError,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (i) {
        final isOn = i < filled;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          width: 16.w,
          height: 16.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isError
                ? const Color(0xFFEF4444).withValues(alpha: 0.85)
                : isOn
                    ? const Color(0xFF3B82F6)
                    : Colors.white.withValues(alpha: 0.18),
            border: Border.all(
              color: isError
                  ? const Color(0xFFEF4444)
                  : Colors.white.withValues(alpha: 0.25),
              width: 1,
            ),
          ),
        );
      }),
    );
  }
}

class _Keypad extends StatelessWidget {
  final void Function(String) onKey;
  final VoidCallback onBackspace;
  final bool disabled;

  const _Keypad({
    required this.onKey,
    required this.onBackspace,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    final keys = const [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['', '0', '⌫'],
    ];

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 320.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: keys.map((row) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: row.map((k) {
                if (k.isEmpty) {
                  return SizedBox(width: 72.w, height: 56.h);
                }
                if (k == '⌫') {
                  return _KeypadKey(
                    onTap: disabled ? null : onBackspace,
                    child: const Icon(Icons.backspace_outlined,
                        color: Colors.white, size: 22),
                  );
                }
                return _KeypadKey(
                  onTap: disabled ? null : () => onKey(k),
                  child: Text(
                    k,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _KeypadKey extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  const _KeypadKey({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(40),
        child: Container(
          width: 72.w,
          height: 56.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: onTap == null ? 0.04 : 0.08),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.06),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
