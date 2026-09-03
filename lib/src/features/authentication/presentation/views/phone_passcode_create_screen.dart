import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/haptics_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/passcode_policy.dart';
import 'package:lazervault/core/widgets/passcode_dots.dart';
import 'package:lazervault/core/widgets/passcode_keypad.dart';
import 'package:lazervault/core/widgets/shake_widget.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_passcode_cubit.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/phone_flow_scaffold.dart';

/// Step 3: create + confirm a 6-digit passcode (same length as the existing
/// [PasscodeSetupScreen]). The keypad drives the flow — no sticky CTA. On a
/// matching confirmation the passcode is held in the cubit and we advance to
/// personal details.
class PhonePasscodeCreateScreen extends StatefulWidget {
  const PhonePasscodeCreateScreen({super.key});

  @override
  State<PhonePasscodeCreateScreen> createState() =>
      _PhonePasscodeCreateScreenState();
}

class _PhonePasscodeCreateScreenState extends State<PhonePasscodeCreateScreen> {
  static const int _length = 6;

  final GlobalKey<ShakeWidgetState> _shakeKey = GlobalKey<ShakeWidgetState>();

  String _entered = '';
  String _initial = '';
  bool _confirmMode = false;
  String? _error;

  void _onDigit(String d) {
    if (_entered.length >= _length) return;
    setState(() {
      _entered += d;
      _error = null;
    });
    if (_entered.length == _length) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _onComplete());
    }
  }

  void _onBackspace() {
    if (_entered.isEmpty) return;
    setState(() {
      _entered = _entered.substring(0, _entered.length - 1);
      _error = null;
    });
  }

  Future<void> _onComplete() async {
    if (!_confirmMode) {
      // Reject trivially guessable passcodes (111111, 123456, …) on the FIRST
      // entry — before asking the user to confirm it. Same policy + wording as
      // the email passcode setup, transaction PIN, and Settings change flows.
      if (isWeakNumericCode(_entered)) {
        Haptics.error();
        _shakeKey.currentState?.shake();
        setState(() {
          _error =
              'Choose a less predictable passcode (avoid 111111 or 123456).';
          _entered = '';
        });
        return;
      }
      // First entry — switch to confirm mode.
      setState(() {
        _initial = _entered;
        _entered = '';
        _confirmMode = true;
      });
      return;
    }
    // Confirm mode — must match the first entry.
    if (_entered != _initial) {
      Haptics.error();
      _shakeKey.currentState?.shake();
      setState(() {
        _error = 'Passcodes do not match. Try again.';
        _entered = '';
        _initial = '';
        _confirmMode = false;
      });
      return;
    }
    final ok = await context
        .read<PhonePasscodeCubit>()
        .confirmPasscode(passcode: _initial, confirmation: _entered);
    if (ok && mounted) {
      Get.toNamed(AppRoutes.phonePersonalDetails);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PhoneFlowScaffold(
      // Passcode entry uses the dark login-passcode surface (distinct from the
      // light phone/details screens) with the default white keypad styling,
      // matching the canonical login passcode screen.
      darkBackground: true,
      title: _confirmMode ? 'Confirm passcode' : 'Create a passcode',
      subtitle: _confirmMode
          ? 'Enter your passcode again to confirm.'
          : 'Set a 6-digit passcode for quick, secure login.',
      step: 3,
      totalSteps: 5,
      children: [
        SizedBox(height: 20.h),
        ShakeWidget(
          key: _shakeKey,
          child: PasscodeDots(
            length: _length,
            filled: _entered.length,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.35),
          ),
        ),
        if (_error != null) ...[
          SizedBox(height: 14.h),
          Text(
            _error!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFFFCA5A5),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
        SizedBox(height: 40.h),
        // Default keypad colours = white digits on translucent buttons (the
        // login-passcode look).
        PasscodeKeypad(
          onDigit: _onDigit,
          onBackspace: _onBackspace,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
