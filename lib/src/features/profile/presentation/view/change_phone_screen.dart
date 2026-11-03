import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';
import 'package:lazervault/src/features/authentication/domain/sms_policy.dart';

/// Change the signed-in user's phone number to a brand-new one.
///
/// Two steps: (1) enter the new number → an SMS OTP is sent to it; (2) enter the
/// OTP → the change is applied server-side (auth-service RequestPhoneChange /
/// VerifyPhoneChange). The number is only updated after verification, and the
/// backend rejects a number already in use by another account.
///
/// ENTIRELY SMS-DEPENDENT, so it is gated on [SmsPolicy.canChangePhoneNumber].
/// The gate is HERE rather than at the four call sites that open this screen
/// (kyc_profile_fix, edit_profile_dialog and my_account twice) — gating each of
/// those would leave the next one added unguarded, which is how a check comes
/// to cover eight of nine paths.
class ChangePhoneScreen extends StatefulWidget {
  const ChangePhoneScreen({super.key});

  @override
  State<ChangePhoneScreen> createState() => _ChangePhoneScreenState();
}

enum _Step { enterPhone, enterOtp }

class _ChangePhoneScreenState extends State<ChangePhoneScreen> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _primary = Color(0xFF3B82F6);

  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _auth = serviceLocator<IAuthRepository>();

  _Step _step = _Step.enterPhone;
  bool _busy = false;
  String _newPhone = '';

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _requestChange() async {
    // THE CHOKE POINT. Every entry point lands here, so one check covers them
    // all. Without it the request is made, the backend queues an OTP to a
    // provider that cannot send it, and the user sits on step 2 entering codes
    // that were never generated.
    if (!SmsPolicy.canChangePhoneNumber) {
      _snack(SmsPolicy.unavailableReason, error: true);
      return;
    }
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      _snack('Enter your new phone number', error: true);
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() => _busy = true);
    final res = await _auth.requestPhoneChange(newPhone: phone);
    if (!mounted) return;
    setState(() => _busy = false);
    res.fold(
      (f) => _snack(f.message, error: true),
      (msg) {
        setState(() {
          _newPhone = phone;
          _step = _Step.enterOtp;
        });
        _snack(msg);
      },
    );
  }

  Future<void> _verifyChange() async {
    final code = _otpController.text.trim();
    if (code.length != 6) {
      _snack('Enter the 6-digit code', error: true);
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() => _busy = true);
    final res = await _auth.verifyPhoneChange(newPhone: _newPhone, code: code);
    if (!mounted) return;
    setState(() => _busy = false);
    res.fold(
      (f) => _snack(f.message, error: true),
      (phone) {
        _snack('Phone number updated');
        Get.back(result: phone);
      },
    );
  }

  void _snack(String msg, {bool error = false}) {
    Get.snackbar(
      error ? 'Error' : 'Success',
      msg,
      backgroundColor:
          error ? const Color(0xFFEF4444) : const Color(0xFF10B981),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _card,
        elevation: 0,
        title: const Text('Change phone number',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
              _step == _Step.enterPhone ? _buildPhoneStep() : _buildOtpStep(),
        ),
      ),
    );
  }

  Widget _buildPhoneStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Enter your new phone number',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Text(
          SmsPolicy.canChangePhoneNumber
              ? 'We\'ll send a 6-digit code to the new number to confirm it\'s yours.'
              : SmsPolicy.unavailableReason,
          style: TextStyle(
            color: SmsPolicy.canChangePhoneNumber
                ? const Color(0xFF9CA3AF)
                : const Color(0xFFFB923C),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: _fieldDecoration('New phone', '+2348012345678'),
        ),
        const SizedBox(height: 24),
        // Disabled outright when SMS cannot be delivered. The guard in
        // _requestChange still stands — this only saves the user a tap on a
        // button that cannot work; it is not the enforcement.
        _primaryButton(
          _busy ? 'Sending…' : 'Send code',
          (_busy || !SmsPolicy.canChangePhoneNumber) ? null : _requestChange,
        ),
      ],
    );
  }

  Widget _buildOtpStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Enter the code sent to $_newPhone',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 20),
        TextField(
          controller: _otpController,
          keyboardType: TextInputType.number,
          maxLength: 6,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(
              color: Colors.white, fontSize: 20, letterSpacing: 8),
          decoration: _fieldDecoration('6-digit code', '••••••'),
        ),
        const SizedBox(height: 12),
        _primaryButton(_busy ? 'Verifying…' : 'Verify & update',
            _busy ? null : _verifyChange),
        const SizedBox(height: 8),
        TextButton(
          onPressed:
              _busy ? null : () => setState(() => _step = _Step.enterPhone),
          child: const Text('Use a different number',
              style: TextStyle(color: _primary)),
        ),
      ],
    );
  }

  InputDecoration _fieldDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF9CA3AF)),
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF6B7280)),
      counterText: '',
      filled: true,
      fillColor: _card,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: _primary),
      ),
    );
  }

  Widget _primaryButton(String label, VoidCallback? onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: _primary,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }
}
