import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';

/// Settings → Account → Delete account. In-app self-service account deletion
/// (required by both app stores). Explains the 30-day cancellable grace period,
/// requires an explicit type-to-confirm, then calls the backend which revokes
/// sessions and schedules finalisation. If the account still holds funds, the
/// backend replies FUNDS_PRESENT and we guide the user to withdraw first.
class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _card = Color(0xFF1F1F1F);
  static const Color _divider = Color(0xFF2D2D2D);
  static const Color _textSecondary = Color(0xFF9CA3AF);
  static const Color _danger = Color(0xFFEF4444);

  final TextEditingController _confirm = TextEditingController();
  bool _canDelete = false;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _confirm.addListener(() {
      final ok = _confirm.text.trim().toUpperCase() == 'DELETE';
      if (ok != _canDelete) setState(() => _canDelete = ok);
    });
  }

  @override
  void dispose() {
    _confirm.dispose();
    super.dispose();
  }

  /// Final double-confirmation before the destructive request. The typed-DELETE
  /// gate is the first confirm; this modal is the explicit second confirm.
  Future<bool> _confirmDeleteDialog() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Delete your account?',
            style: GoogleFonts.inter(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16.sp)),
        content: Text(
          'This starts a 30-day cancellable grace period. Sign in any time before it ends to cancel. '
          'After that, your account is queued for permanent deletion and reviewed by our team — this cannot be undone.',
          style: GoogleFonts.inter(color: _textSecondary, fontSize: 13.sp, height: 1.45),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Keep my account',
                style: GoogleFonts.inter(
                    color: const Color(0xFF3B82F6), fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text('Delete account',
                style: GoogleFonts.inter(
                    color: const Color(0xFFEF4444), fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
    return ok == true;
  }

  Future<void> _delete() async {
    if (!_canDelete || _busy) return;
    final confirmed = await _confirmDeleteDialog();
    if (!confirmed || !mounted) return;
    setState(() => _busy = true);
    final result = await serviceLocator<IAuthRepository>().requestAccountDeletion();
    if (!mounted) return;
    setState(() => _busy = false);

    result.fold(
      (failure) => _snack(failure.message, error: true),
      (outcome) async {
        if (!outcome.success) {
          if (outcome.isFundsBlocked) {
            _showFundsBlocked();
          } else {
            _snack(
              outcome.message.isNotEmpty
                  ? outcome.message
                  : 'We couldn\'t delete your account. Please try again.',
              error: true,
            );
          }
          return;
        }
        // Success: sessions are already revoked server-side. Wipe the local
        // session and return to the auth entry.
        try {
          await serviceLocator<SecureStorageService>().clearAll();
        } catch (_) {/* best-effort */}
        Get.offAllNamed(
          FeatureFlags.isPhonePasscodeMode
              ? AppRoutes.phoneEntry
              : AppRoutes.emailSignIn,
        );
        Get.snackbar(
          'Account scheduled for deletion',
          outcome.message.isNotEmpty
              ? outcome.message
              : 'Your account enters a ${outcome.gracePeriodDays}-day grace period. Sign in before it ends to cancel.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: _card,
          colorText: Colors.white,
          margin: EdgeInsets.all(12.w),
          duration: const Duration(seconds: 6),
        );
      },
    );
  }

  void _showFundsBlocked() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Withdraw your funds first',
            style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16.sp)),
        content: Text(
          'Your account still holds a balance. Please withdraw or transfer all funds to zero before deleting your account, so none of your money is lost.',
          style: GoogleFonts.inter(color: _textSecondary, fontSize: 13.sp, height: 1.45),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Got it', style: GoogleFonts.inter(color: const Color(0xFF3B82F6), fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _snack(String msg, {bool error = false}) {
    Get.snackbar(
      'Delete account',
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: error ? _danger : _card,
      colorText: Colors.white,
      margin: EdgeInsets.all(12.w),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Delete account',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w600)),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 32.h),
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: _danger.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: _danger.withValues(alpha: 0.35)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning_amber_rounded, color: _danger, size: 22.sp),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    'This permanently deletes your Lazervault account and personal data.',
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp, height: 1.4, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 18.h),
          Text('What happens', style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w700)),
          SizedBox(height: 10.h),
          _bullet('You are signed out on all devices immediately.'),
          _bullet('Your account enters a 30-day grace period — sign back in any time before then to cancel and keep your account.'),
          _bullet('After 30 days your account is queued for permanent deletion (reviewed by our team). Once finalized, your data cannot be recovered.'),
          _bullet('Make sure your balance is zero — withdraw or transfer any funds first.'),
          SizedBox(height: 22.h),
          Text('Type DELETE to confirm',
              style: GoogleFonts.inter(color: _textSecondary, fontSize: 12.5.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 8.h),
          TextField(
            controller: _confirm,
            enabled: !_busy,
            textCapitalization: TextCapitalization.characters,
            style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp, letterSpacing: 1.5),
            decoration: InputDecoration(
              hintText: 'DELETE',
              hintStyle: GoogleFonts.inter(color: _textSecondary.withValues(alpha: 0.5)),
              filled: true,
              fillColor: _card,
              contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: _divider),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: _danger),
              ),
            ),
          ),
          SizedBox(height: 22.h),
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: (_canDelete && !_busy) ? _delete : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _danger,
                disabledBackgroundColor: _danger.withValues(alpha: 0.35),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
              ),
              child: _busy
                  ? SizedBox(
                      width: 22.w, height: 22.w,
                      child: const CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white))
                  : Text('Delete my account',
                      style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bullet(String text) => Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 6.h, right: 10.w),
              child: Container(width: 5.w, height: 5.w,
                  decoration: const BoxDecoration(color: _textSecondary, shape: BoxShape.circle)),
            ),
            Expanded(
              child: Text(text,
                  style: GoogleFonts.inter(color: _textSecondary, fontSize: 13.sp, height: 1.45)),
            ),
          ],
        ),
      );
}
