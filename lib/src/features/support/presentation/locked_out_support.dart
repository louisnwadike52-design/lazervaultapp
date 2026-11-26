import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/support/data/support_api.dart';
import 'package:lazervault/core/widgets/app_bottom_sheet.dart';

/// "Need help?" for somebody who cannot get past the lock.
///
/// ## Why this is not the ordinary support surface
///
/// [SupportContact] resumes a customer's existing thread, which needs a
/// session — and the person this is for has none. Every authenticated support
/// route answers 401 to them, so the one affordance they could actually use
/// was to find an address themselves and hope.
///
/// ## What it sends
///
/// The address the device already cached, the screen they are stuck on, and
/// what they typed. The address is NOT verified by anything — support sees the
/// request on a separate, visibly unverified channel and still proves identity
/// before touching an account. It is a way to reach us, not a way in.
///
/// ## Where it belongs
///
/// Every screen a customer can be stranded on before a session exists: the
/// passcode lock, the full phone+passcode login, email sign-in, and the
/// resumption states (verify-email, verify-phone) that can refuse to move on.
class LockedOutSupport {
  const LockedOutSupport._();

  /// The icon to drop into an AppBar or a corner of a lock screen.
  ///
  /// Quiet on purpose: it must be findable when someone is stuck without
  /// competing with the thing they are supposed to be doing, which is typing
  /// their passcode.
  static Widget icon(BuildContext context, {
    required String stuckOn,
    Color? color,
  }) {
    return IconButton(
      tooltip: 'Need help signing in?',
      icon: Icon(Icons.support_agent_rounded,
          size: 22.sp, color: color ?? Colors.white70),
      onPressed: () => open(context, stuckOn: stuckOn),
    );
  }

  /// Opens the composer. [stuckOn] names the screen, and travels with the
  /// ticket so an agent does not have to ask someone who cannot reply.
  static Future<void> open(BuildContext context,
      {required String stuckOn}) async {
    final email = await _cachedEmail();
    if (!context.mounted) return;
    await showAppBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _LockedOutSupportSheet(
        initialEmail: email ?? '',
        stuckOn: stuckOn,
      ),
    );
  }

  /// The address from the last successful sign-in on this device.
  ///
  /// Best-effort: an empty field the customer fills in themselves is a working
  /// form, while a crash on a lock screen is a customer with no way out at
  /// all.
  static Future<String?> _cachedEmail() async {
    try {
      return await serviceLocator<SecureStorageService>().getUserEmail();
    } catch (_) {
      return null;
    }
  }
}

class _LockedOutSupportSheet extends StatefulWidget {
  const _LockedOutSupportSheet({
    required this.initialEmail,
    required this.stuckOn,
  });

  final String initialEmail;
  final String stuckOn;

  @override
  State<_LockedOutSupportSheet> createState() => _LockedOutSupportSheetState();
}

class _LockedOutSupportSheetState extends State<_LockedOutSupportSheet> {
  late final TextEditingController _email =
      TextEditingController(text: widget.initialEmail);
  final TextEditingController _message = TextEditingController();
  bool _sending = false;
  String? _error;
  String? _sentTicket;
  String? _alreadyOpen;

  @override
  void dispose() {
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final email = _email.text.trim();
    final message = _message.text.trim();
    if (!email.contains('@')) {
      setState(() => _error = 'Enter the email address on your account.');
      return;
    }
    if (message.isEmpty) {
      setState(() => _error = 'Tell us what is happening so we can help.');
      return;
    }
    setState(() {
      _sending = true;
      _error = null;
    });
    try {
      final ref = await SupportApi(serviceLocator<SecureStorageService>())
          .createPreAuthTicket(
        email: email,
        subject: 'Cannot sign in — ${widget.stuckOn}',
        message: message,
        context: 'Stuck on: ${widget.stuckOn}',
      );
      if (!mounted) return;
      setState(() => _sentTicket = ref);
    } on SupportPreAuthOpenException catch (e) {
      if (!mounted) return;
      setState(() => _alreadyOpen = e.message);
    } catch (_) {
      if (!mounted) return;
      // No reassurance we cannot stand behind: if the request never reached
      // us, saying "we'll be in touch" is the one thing that must not happen.
      setState(() => _error =
          'We could not send that just now. Check your connection and try again.');
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final done = _sentTicket != null || _alreadyOpen != null;
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Text(
              done ? 'We have your request' : 'Trouble signing in?',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.h),
            if (done) ...[
              Text(
                _alreadyOpen ??
                    'Reference ${_sentTicket!}. We will reply to '
                        '${_email.text.trim()}.',
                style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    height: 1.5),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 78, 3, 208),
                      padding: EdgeInsets.symmetric(vertical: 14.h)),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Done',
                      style: GoogleFonts.inter(
                          fontSize: 14.sp, fontWeight: FontWeight.w600)),
                ),
              ),
            ] else ...[
              Text(
                'Send us a message and we will reply by email. You do not '
                'need to be signed in.',
                style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    height: 1.45),
              ),
              SizedBox(height: 16.h),
              _field(_email, 'Your email', TextInputType.emailAddress),
              SizedBox(height: 12.h),
              _field(_message, 'What is happening?', TextInputType.multiline,
                  maxLines: 4),
              if (_error != null) ...[
                SizedBox(height: 10.h),
                Text(_error!,
                    style: GoogleFonts.inter(
                        color: const Color(0xFFEF4444), fontSize: 12.sp)),
              ],
              SizedBox(height: 18.h),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 78, 3, 208),
                      padding: EdgeInsets.symmetric(vertical: 14.h)),
                  onPressed: _sending ? null : _send,
                  child: _sending
                      ? SizedBox(
                          width: 18.w,
                          height: 18.w,
                          child: const CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : Text('Send to support',
                          style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String hint, TextInputType type,
      {int maxLines = 1}) {
    return TextField(
      controller: c,
      keyboardType: type,
      maxLines: maxLines,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
            color: const Color(0xFF6B7280), fontSize: 13.sp),
        filled: true,
        fillColor: const Color(0xFF2C2C2E),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
