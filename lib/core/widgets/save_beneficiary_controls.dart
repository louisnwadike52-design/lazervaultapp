import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// Shared "save this beneficiary" controls used by every QuickBuy surface
// (airtime + electricity / cable / water / internet / education / data).
//
// Historically each QuickBuy rolled its own save affordance — airtime used a
// bare checkbox with no name, electricity a switch that silently auto-named and
// best-effort saved. This module unifies them on the same pattern the review /
// confirmation screens already use:
//
//   * a [SaveBeneficiaryToggleRow] switch (like the auto-recharge toggle) that
//     opens [promptBeneficiaryNickname] when turned ON, so the user names the
//     beneficiary before it is saved (post-purchase, by the caller);
//   * a [SavedBeneficiaryInfoRow] passive tile shown INSTEAD of the switch when
//     the identifier (phone / meter / smart-card / account) is already saved, so
//     the same number can never be saved as a beneficiary twice.
//
// The nickname dialog returns `null` on cancel / empty so the caller snaps its
// switch back off — a blank-nicknamed beneficiary is never created.

const _card = Color(0xFF1F1F1F);
const _border = Color(0xFF2D2D2D);
const _muted = Color(0xFF9CA3AF);
const _green = Color(0xFF10B981);
// Lighter purple for small accents (switch thumb, dialog Save action) —
// the brand purple 0xFF4E03D0 is illegible on the near-black card.
const _accentLight = Color(0xFFA78BFA);

/// Prompt for a beneficiary nickname. Returns the trimmed nickname, or `null`
/// if the user cancels or submits an empty value.
Future<String?> promptBeneficiaryNickname(
  BuildContext context, {
  required Color accent,
  String title = 'Save beneficiary',
  String prompt = 'Give this a nickname so you can find it fast next time.',
  String hint = 'e.g. Home, Mum, Office',
  String initial = '',
}) {
  return showDialog<String>(
    context: context,
    builder: (_) => _BeneficiaryNicknameDialog(
      accent: accent,
      title: title,
      prompt: prompt,
      hint: hint,
      initial: initial,
    ),
  );
}

/// Switch tile ("Save as beneficiary"). Mirror of the auto-recharge toggle.
class SaveBeneficiaryToggleRow extends StatelessWidget {
  const SaveBeneficiaryToggleRow({
    super.key,
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.icon = Icons.bookmark_outline,
  });

  final Color accent;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _border, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: accent, size: 18.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 2.h),
                Text(subtitle,
                    style: GoogleFonts.inter(color: _muted, fontSize: 11.sp)),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeThumbColor: _accentLight,
          ),
        ],
      ),
    );
  }
}

/// Passive "already saved" tile shown in place of the toggle when the
/// identifier is already a saved beneficiary (prevents a duplicate save).
class SavedBeneficiaryInfoRow extends StatelessWidget {
  const SavedBeneficiaryInfoRow({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.bookmark,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: _green.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _green.withValues(alpha: 0.25), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: _green.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: _green, size: 18.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 2.h),
                Text(subtitle,
                    style: GoogleFonts.inter(color: _muted, fontSize: 11.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BeneficiaryNicknameDialog extends StatefulWidget {
  final Color accent;
  final String title;
  final String prompt;
  final String hint;
  final String initial;
  const _BeneficiaryNicknameDialog({
    required this.accent,
    required this.title,
    required this.prompt,
    required this.hint,
    required this.initial,
  });

  @override
  State<_BeneficiaryNicknameDialog> createState() =>
      _BeneficiaryNicknameDialogState();
}

class _BeneficiaryNicknameDialogState
    extends State<_BeneficiaryNicknameDialog> {
  late final TextEditingController _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initial);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final v = _controller.text.trim();
    if (v.isEmpty) {
      setState(() => _error = 'Nickname is required');
      return;
    }
    Navigator.of(context).pop(v);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: _card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Text(widget.title,
          style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.prompt,
              style: GoogleFonts.inter(color: _muted, fontSize: 13.sp)),
          SizedBox(height: 14.h),
          TextField(
            controller: _controller,
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF4B5563), fontSize: 14.sp),
              errorText: _error,
              filled: true,
              fillColor: const Color(0xFF0A0A0A),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: _border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: _border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: widget.accent),
              ),
            ),
            onChanged: (_) {
              if (_error != null) setState(() => _error = null);
            },
          ),
        ],
      ),
      actionsPadding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 8.h),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text('Cancel',
              style: GoogleFonts.inter(color: _muted, fontSize: 14.sp)),
        ),
        TextButton(
          onPressed: _submit,
          child: Text('Save',
              style: GoogleFonts.inter(
                  color: _accentLight,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}
