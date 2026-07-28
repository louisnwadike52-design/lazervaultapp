import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Bottom sheet that collects and validates a NEW password (no current-password
/// field — this is for passwordless accounts setting a first password). Returns
/// the validated password on confirm, or null if dismissed. The caller persists
/// it via SetPassword.
Future<String?> showSetPasswordSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: const Color(0xFF1F1F1F),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    builder: (sheetCtx) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(sheetCtx).viewInsets.bottom,
      ),
      child: const _SetPasswordSheetBody(),
    ),
  );
}

class _SetPasswordSheetBody extends StatefulWidget {
  const _SetPasswordSheetBody();

  @override
  State<_SetPasswordSheetBody> createState() => _SetPasswordSheetBodyState();
}

class _SetPasswordSheetBodyState extends State<_SetPasswordSheetBody> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscure = true;
  bool _obscureConfirm = true;
  String? _error;

  bool _hasMinLength = false;
  bool _hasUpper = false;
  bool _hasLower = false;
  bool _hasDigit = false;
  bool _hasSpecial = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _validate(String p) {
    setState(() {
      _hasMinLength = p.length >= 8;
      _hasUpper = p.contains(RegExp(r'[A-Z]'));
      _hasLower = p.contains(RegExp(r'[a-z]'));
      _hasDigit = p.contains(RegExp(r'[0-9]'));
      _hasSpecial = p.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
      _error = null;
    });
  }

  bool get _isValid =>
      _hasMinLength && _hasUpper && _hasLower && _hasDigit && _hasSpecial;

  void _submit() {
    final p = _passwordController.text.trim();
    final c = _confirmController.text.trim();
    if (!_isValid) {
      setState(() => _error = 'Password does not meet the requirements');
      return;
    }
    if (p != c) {
      setState(() => _error = 'Passwords do not match');
      return;
    }
    Navigator.of(context).pop(p);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Set a password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Add a password so you can sign in with your email or phone and password.',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
            ),
            SizedBox(height: 20.h),
            _field(
              controller: _passwordController,
              hint: 'New password',
              obscure: _obscure,
              onToggle: () => setState(() => _obscure = !_obscure),
              onChanged: _validate,
            ),
            SizedBox(height: 12.h),
            _field(
              controller: _confirmController,
              hint: 'Confirm new password',
              obscure: _obscureConfirm,
              onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
              onChanged: (_) => setState(() => _error = null),
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 4.h,
              children: [
                _req('8+ characters', _hasMinLength),
                _req('Uppercase', _hasUpper),
                _req('Lowercase', _hasLower),
                _req('Number', _hasDigit),
                _req('Special character', _hasSpecial),
              ],
            ),
            if (_error != null) ...[
              SizedBox(height: 12.h),
              Text(
                _error!,
                style: TextStyle(color: const Color(0xFFEF4444), fontSize: 13.sp),
              ),
            ],
            SizedBox(height: 24.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4834D4),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: const StadiumBorder(),
                minimumSize: Size(double.infinity, 48.h),
              ),
              onPressed: _submit,
              child: Text(
                'Set password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required bool obscure,
    required VoidCallback onToggle,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      onChanged: onChanged,
      style: TextStyle(color: Colors.white, fontSize: 15.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: const Color(0xFF6B7280), fontSize: 14.sp),
        filled: true,
        fillColor: const Color(0xFF161616),
        prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF9CA3AF)),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility,
              color: const Color(0xFF9CA3AF)),
          onPressed: onToggle,
        ),
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
          borderSide: const BorderSide(color: Color(0xFF4834D4)),
        ),
      ),
    );
  }

  Widget _req(String label, bool ok) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(ok ? Icons.check_circle : Icons.circle_outlined,
            size: 14.w,
            color: ok ? const Color(0xFF10B981) : const Color(0xFF6B7280)),
        SizedBox(width: 4.w),
        Text(label,
            style: TextStyle(
                fontSize: 11.sp,
                color: ok ? Colors.white : const Color(0xFF9CA3AF))),
      ],
    );
  }
}
