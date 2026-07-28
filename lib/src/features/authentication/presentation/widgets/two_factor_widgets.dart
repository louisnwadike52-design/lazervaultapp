import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/authentication/domain/entities/two_factor_entity.dart';

/// Shared 2FA method picker (Authenticator / SMS / Email), reused by the setup
/// screen and the settings screen. Extracted from the setup screen so the
/// settings screen can show the options + status in one place.
class TwoFactorMethodPicker extends StatelessWidget {
  final TwoFactorMethod selected;
  final ValueChanged<TwoFactorMethod> onSelect;
  final bool enabled; // disable taps once setup/enable has started

  const TwoFactorMethodPicker({
    super.key,
    required this.selected,
    required this.onSelect,
    this.enabled = true,
  });

  IconData _iconFor(String iconName) {
    switch (iconName) {
      case 'shield':
        return Icons.shield_rounded;
      case 'message':
        return Icons.sms_rounded;
      case 'mail':
        return Icons.mail_rounded;
      default:
        return Icons.security_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Choose Authentication Method',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: TwoFactorMethodInfo.availableMethods.map((method) {
              final isSelected = selected == method.method;
              return InkWell(
                onTap: enabled ? () => onSelect(method.method) : null,
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  margin: EdgeInsets.only(bottom: 1.h),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue.shade50 : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? Colors.blue.shade700 : Colors.transparent,
                      width: isSelected ? 2 : 0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue.shade700 : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(_iconFor(method.icon),
                            color: isSelected ? Colors.white : Colors.grey.shade600, size: 20.sp),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(method.name,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? Colors.blue.shade900 : Colors.grey.shade800)),
                            SizedBox(height: 4.h),
                            Text(method.description,
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: isSelected ? Colors.blue.shade700 : Colors.grey.shade600)),
                          ],
                        ),
                      ),
                      if (isSelected) Icon(Icons.check_circle, color: Colors.green, size: 24.sp),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

/// Self-contained 6-digit verification bottom sheet for 2FA setup. Owns its
/// controllers, auto-submits on the 6th digit, manages its own loading, and pops
/// `true` on success. Shared by the setup + settings screens.
class TwoFactorVerifySheet extends StatefulWidget {
  final String subtitle;
  final Future<bool> Function(String code) onVerify;

  /// Header title — defaults to the setup wording. Disable/confirm flows pass
  /// their own (e.g. "Confirm disable").
  final String title;

  /// Primary button label — defaults to the setup wording.
  final String actionLabel;

  /// Header icon + its tint. Defaults to the green "verified" setup look.
  final IconData icon;
  final Color? iconColor;

  /// When true the primary button uses the danger (red) styling — used by the
  /// disable-2FA confirmation so the destructive action reads as destructive.
  final bool destructive;

  const TwoFactorVerifySheet({
    super.key,
    required this.subtitle,
    required this.onVerify,
    this.title = 'Verify Setup',
    this.actionLabel = 'Verify and Enable',
    this.icon = Icons.verified_user_rounded,
    this.iconColor,
    this.destructive = false,
  });

  /// Shows the sheet and returns true when verification succeeded.
  static Future<bool?> show(
    BuildContext context, {
    required String subtitle,
    required Future<bool> Function(String code) onVerify,
    String title = 'Verify Setup',
    String actionLabel = 'Verify and Enable',
    IconData icon = Icons.verified_user_rounded,
    Color? iconColor,
    bool destructive = false,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => TwoFactorVerifySheet(
        subtitle: subtitle,
        onVerify: onVerify,
        title: title,
        actionLabel: actionLabel,
        icon: icon,
        iconColor: iconColor,
        destructive: destructive,
      ),
    );
  }

  @override
  State<TwoFactorVerifySheet> createState() => _TwoFactorVerifySheetState();
}

class _TwoFactorVerifySheetState extends State<TwoFactorVerifySheet> {
  final List<TextEditingController> _c = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _f = List.generate(6, (_) => FocusNode());
  bool _verifying = false;

  String get _code => _c.map((e) => e.text).join();

  @override
  void dispose() {
    for (final c in _c) {
      c.dispose();
    }
    for (final n in _f) {
      n.dispose();
    }
    super.dispose();
  }

  void _onChanged(String v, int i) {
    if (v.isNotEmpty && i < 5) {
      _f[i + 1].requestFocus();
    } else if (v.isEmpty && i > 0) {
      _f[i - 1].requestFocus();
    }
    if (_code.length == 6 && !_verifying) {
      _submit();
    }
    setState(() {});
  }

  Future<void> _submit() async {
    if (_code.length != 6 || _verifying) return;
    FocusScope.of(context).unfocus();
    setState(() => _verifying = true);
    bool ok = false;
    try {
      ok = await widget.onVerify(_code);
    } catch (_) {
      ok = false;
    }
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pop(true);
    } else {
      setState(() => _verifying = false);
      for (final c in _c) {
        c.clear();
      }
      _f.first.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 16.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 28.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Icon(widget.icon, color: widget.iconColor ?? Colors.green.shade700),
              SizedBox(width: 12.w),
              Text(widget.title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700)),
            ],
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.subtitle, style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700)),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              6,
              (i) => SizedBox(
                width: 45.w,
                height: 55.h,
                child: TextField(
                  controller: _c[i],
                  focusNode: _f[i],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  autofocus: i == 0,
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: EdgeInsets.zero,
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
                    ),
                  ),
                  onChanged: (v) => _onChanged(v, i),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: _verifying ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    widget.destructive ? Colors.red : const Color(0xFF4834D4),
                foregroundColor: Colors.white,
                disabledBackgroundColor: (widget.destructive
                        ? Colors.red
                        : Colors.blue.shade700)
                    .withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
              child: _verifying
                  ? LazerVaultLoader.small()
                  : Text(widget.actionLabel,
                      style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

/// Complete authenticator-app (TOTP) setup in ONE self-contained bottom sheet:
/// shows the QR code, the manual-entry secret, the backup codes, and a 6-digit
/// verification field — no separate screen. Pops `true` once the entered code
/// is verified (via [onVerify] → completeTwoFactorSetup). Scrollable so the QR +
/// codes + input all fit without a full page.
class TotpSetupSheet extends StatefulWidget {
  final TwoFactorSetup setup;
  final Future<bool> Function(String code) onVerify;
  const TotpSetupSheet({super.key, required this.setup, required this.onVerify});

  static Future<bool?> show(
    BuildContext context, {
    required TwoFactorSetup setup,
    required Future<bool> Function(String code) onVerify,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => TotpSetupSheet(setup: setup, onVerify: onVerify),
    );
  }

  @override
  State<TotpSetupSheet> createState() => _TotpSetupSheetState();
}

class _TotpSetupSheetState extends State<TotpSetupSheet> {
  final List<TextEditingController> _c = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _f = List.generate(6, (_) => FocusNode());
  bool _verifying = false;
  bool _showBackupCodes = false;

  String get _code => _c.map((e) => e.text).join();

  @override
  void dispose() {
    for (final c in _c) {
      c.dispose();
    }
    for (final n in _f) {
      n.dispose();
    }
    super.dispose();
  }

  void _copy(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar('Copied', '$label copied to clipboard',
        duration: const Duration(seconds: 2), snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(15.w), borderRadius: 10.r);
  }

  void _onChanged(String v, int i) {
    if (v.isNotEmpty && i < 5) {
      _f[i + 1].requestFocus();
    } else if (v.isEmpty && i > 0) {
      _f[i - 1].requestFocus();
    }
    if (_code.length == 6 && !_verifying) _submit();
    setState(() {});
  }

  Future<void> _submit() async {
    if (_code.length != 6 || _verifying) return;
    FocusScope.of(context).unfocus();
    setState(() => _verifying = true);
    bool ok = false;
    try {
      ok = await widget.onVerify(_code);
    } catch (_) {
      ok = false;
    }
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pop(true);
    } else {
      setState(() => _verifying = false);
      for (final c in _c) {
        c.clear();
      }
      _f.first.requestFocus();
    }
  }

  String _formatSecret(String s) {
    final b = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && i % 4 == 0) b.write(' ');
      b.write(s[i]);
    }
    return b.toString();
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? qrBytes;
    try {
      if (widget.setup.qrCode.isNotEmpty) qrBytes = base64Decode(widget.setup.qrCode);
    } catch (_) {
      qrBytes = null;
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 24.w, right: 24.w, top: 12.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.88),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
                ),
              ),
              SizedBox(height: 18.h),
              Row(children: [
                Icon(Icons.qr_code_2_rounded, color: Colors.blue.shade700),
                SizedBox(width: 12.w),
                Text('Set up Authenticator App',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700)),
              ]),
              SizedBox(height: 6.h),
              Text('Scan this with Google Authenticator, Microsoft Authenticator, or Authy, then enter the 6-digit code it shows.',
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600)),
              SizedBox(height: 18.h),
              // QR
              Center(
                child: Container(
                  width: 190.w, height: 190.w,
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: qrBytes != null
                      ? Image.memory(qrBytes, fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Center(
                              child: Text('QR failed to load', style: TextStyle(color: Colors.red, fontSize: 12.sp))))
                      : Center(child: Text('QR unavailable', style: TextStyle(color: Colors.grey, fontSize: 12.sp))),
                ),
              ),
              SizedBox(height: 16.h),
              // Manual secret
              if (widget.setup.secret.isNotEmpty) ...[
                Text('Or enter this key manually:',
                    style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w500, color: Colors.grey.shade700)),
                SizedBox(height: 8.h),
                Row(children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(_formatSecret(widget.setup.secret),
                          style: TextStyle(fontSize: 14.sp, fontFamily: 'monospace', fontWeight: FontWeight.w600, letterSpacing: 1.5)),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: () => _copy(widget.setup.secret, 'Key'),
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(color: Colors.blue.shade700, borderRadius: BorderRadius.circular(8.r)),
                      child: Icon(Icons.copy_rounded, color: Colors.white, size: 20.sp),
                    ),
                  ),
                ]),
                SizedBox(height: 16.h),
              ],
              // Backup codes (collapsible)
              if (widget.setup.backupCodes.isNotEmpty) ...[
                InkWell(
                  onTap: () => setState(() => _showBackupCodes = !_showBackupCodes),
                  child: Row(children: [
                    Icon(Icons.key_rounded, color: Colors.orange.shade700, size: 18.sp),
                    SizedBox(width: 8.w),
                    Text('Backup codes (${widget.setup.backupCodes.length})',
                        style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w600)),
                    const Spacer(),
                    Text(_showBackupCodes ? 'Hide' : 'Show',
                        style: TextStyle(fontSize: 13.sp, color: const Color(0xFF4834D4), fontWeight: FontWeight.w600)),
                  ]),
                ),
                if (_showBackupCodes) ...[
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.amber.shade200),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Save these now — each works once if you lose your authenticator. You won\'t see them again.',
                          style: TextStyle(fontSize: 11.5.sp, fontWeight: FontWeight.w600, color: Colors.amber.shade900)),
                      SizedBox(height: 10.h),
                      Wrap(spacing: 8.w, runSpacing: 8.h, children: widget.setup.backupCodes.map((code) {
                        final f = code.length >= 8 ? '${code.substring(0, 4)}-${code.substring(4)}' : code;
                        return InkWell(
                          onTap: () => _copy(code, 'Backup code'),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.r), border: Border.all(color: Colors.grey.shade300)),
                            child: Text(f, style: TextStyle(fontSize: 13.sp, fontFamily: 'monospace', fontWeight: FontWeight.w600)),
                          ),
                        );
                      }).toList()),
                    ]),
                  ),
                ],
                SizedBox(height: 18.h),
              ],
              // Verify
              Text('Enter the 6-digit code from your app',
                  style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade800)),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (i) => SizedBox(
                  width: 45.w, height: 55.h,
                  child: TextField(
                    controller: _c[i], focusNode: _f[i],
                    keyboardType: TextInputType.number, textAlign: TextAlign.center, maxLength: 1,
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      counterText: '', contentPadding: EdgeInsets.zero, filled: true, fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade400)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.blue.shade700, width: 2)),
                    ),
                    onChanged: (v) => _onChanged(v, i),
                  ),
                )),
              ),
              SizedBox(height: 22.h),
              SizedBox(
                width: double.infinity, height: 50.h,
                child: ElevatedButton(
                  onPressed: _verifying ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4834D4), foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFF4834D4).withValues(alpha: 0.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: _verifying
                      ? LazerVaultLoader.small()
                      : Text('Verify and Enable', style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
