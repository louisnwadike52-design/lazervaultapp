import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// WHAT THE CUSTOMER SAYS WHEN A HELD NAME IS WRONG.
///
/// The platform does not let anyone edit their own name — it is whatever KYC
/// verified, and a change is "a support request with evidence attached"
/// (auth_profile.go:54). So this sheet IS that support request, raised against
/// the verification an operator is already reviewing rather than dropped into
/// a separate ticket queue.
///
/// TWO CLAIMS, NOT A FREE-TEXT BOX, because the operator needs to know which
/// of two records to distrust and that is a closed question. The free text is
/// there as well, for the half of cases where the reason matters (a marriage,
/// a legal change, a bank that reversed two names).
///
/// Returns null if dismissed. The caller treats that as no submission at all,
/// never as an empty one.
class KycNameCorrectionResult {
  const KycNameCorrectionResult({
    required this.claim,
    required this.correctName,
    required this.note,
  });

  /// 'profile_misspelled' | 'bvn_outdated' — the server's own tokens, so
  /// there is no mapping layer to drift.
  final String claim;
  final String correctName;
  final String note;
}

Future<KycNameCorrectionResult?> showKycNameCorrectionSheet(
  BuildContext context, {
  required String bvnName,
  required String profileName,
}) {
  return showModalBottomSheet<KycNameCorrectionResult>(
    context: context,
    isScrollControlled: true, // the keyboard must not cover the field
    // Dark, matching this screen's other sheet (0xFF1A1A1A) — a white sheet
    // over a near-black screen reads as a rendering fault, and the host's
    // text colours are light.
    backgroundColor: const Color(0xFF1A1A1A),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
    ),
    builder: (_) => _Sheet(bvnName: bvnName, profileName: profileName),
  );
}

class _Sheet extends StatefulWidget {
  const _Sheet({required this.bvnName, required this.profileName});
  final String bvnName;
  final String profileName;

  @override
  State<_Sheet> createState() => _SheetState();
}

class _SheetState extends State<_Sheet> {
  static const _profileMisspelled = 'profile_misspelled';
  static const _bvnOutdated = 'bvn_outdated';

  String? _claim;
  final _name = TextEditingController();
  final _note = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _note.dispose();
    super.dispose();
  }

  bool get _needsName => _claim == _profileMisspelled;

  void _submit() {
    if (_claim == null) {
      setState(() => _error = 'Tell us which name is wrong.');
      return;
    }
    final name = _name.text.trim();
    // Mirrors the server's own rule, so the common mistake is caught without
    // a round trip — but the server still enforces it, because this is the
    // only thing that makes the request actionable.
    if (_needsName && name.isEmpty) {
      setState(() => _error = 'Enter the correct spelling of your name.');
      return;
    }
    Navigator.of(context).pop(KycNameCorrectionResult(
      claim: _claim!,
      correctName: _needsName ? name : '',
      note: _note.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Lifts the sheet clear of the keyboard; without this the note field
      // sits under it on a short screen.
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Which name is wrong?',
                style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            SizedBox(height: 4.h),
            Text(
              'We can\'t change a name ourselves — it has to match the '
              'records your identity was verified against. Tell us which one '
              'is wrong and the team reviewing your account will sort it.',
              style: GoogleFonts.inter(
                  fontSize: 11.5.sp,
                  color: const Color(0xFF6B7280),
                  height: 1.45),
            ),
            SizedBox(height: 14.h),
            _choice(
              value: _profileMisspelled,
              title: 'My profile name is misspelled',
              subtitle: widget.profileName,
            ),
            _choice(
              value: _bvnOutdated,
              title: 'My BVN record is out of date',
              subtitle: widget.bvnName,
            ),
            if (_needsName) ...[
              SizedBox(height: 10.h),
              TextField(
                controller: _name,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: 'Correct spelling of your name',
                  hintText: widget.bvnName,
                  border: const OutlineInputBorder(),
                  isDense: true,
                ),
                style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.white),
              ),
            ],
            SizedBox(height: 10.h),
            TextField(
              controller: _note,
              maxLines: 3,
              maxLength: 500, // the server clamps to the same number
              decoration: const InputDecoration(
                labelText: 'Anything else we should know (optional)',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.white),
            ),
            if (_error != null) ...[
              SizedBox(height: 4.h),
              Text(_error!,
                  style: GoogleFonts.inter(
                      fontSize: 11.5.sp, color: const Color(0xFFDC2626))),
            ],
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              height: 46.h,
              child: ElevatedButton(
                onPressed: _submit,
                child: Text('Send to the review team',
                    style: GoogleFonts.inter(
                        fontSize: 13.sp, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _choice({
    required String value,
    required String title,
    required String subtitle,
  }) {
    final selected = _claim == value;
    return InkWell(
      onTap: () => setState(() {
        _claim = value;
        _error = null;
      }),
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(11.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: selected ? const Color(0xFF6366F1) : const Color(0xFF2D2D2D),
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 18.sp,
              color:
                  selected ? const Color(0xFF4E03D0) : const Color(0xFF9CA3AF),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.inter(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  if (subtitle.isNotEmpty)
                    Text(subtitle,
                        style: GoogleFonts.inter(
                            fontSize: 11.5.sp, color: const Color(0xFF6B7280))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
