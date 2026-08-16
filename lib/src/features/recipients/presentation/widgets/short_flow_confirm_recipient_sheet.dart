import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';

/// Result of the short-flow confirm sheet.
class ShortFlowConfirmResult {
  /// Save the recipient to the address book + mark favorite. The short flow
  /// only exposes a single "Save to favorites" switch (ON by default), so save
  /// and favorite move together — turning it off makes this a one-time send.
  final bool saveAsFavorite;

  const ShortFlowConfirmResult({required this.saveAsFavorite});
}

/// Lean recipient confirmation used by the short send-funds flow. Unlike the
/// long-flow [AccountConfirmationBottomSheet]/[UsernameRecipientConfirmationSheet]
/// (save + favorite + alias), this shows ONLY a "Save to favorites" switch
/// (default ON) per the streamlined spec. Returns a [ShortFlowConfirmResult] via
/// `Navigator.pop`, or `null` if cancelled.
class ShortFlowConfirmRecipientSheet extends StatefulWidget {
  final RecipientModel recipient;

  const ShortFlowConfirmRecipientSheet({super.key, required this.recipient});

  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _card = Color(0xFF1F1F1F);
  static const Color _purple = Color(0xFF4E03D0);
  static const Color _amber = Color(0xFFF59E0B);
  static const Color _textSecondary = Color(0xFF9CA3AF);

  /// Shows the sheet and resolves to the confirmation result (or null).
  static Future<ShortFlowConfirmResult?> show(
    BuildContext context,
    RecipientModel recipient,
  ) {
    return showModalBottomSheet<ShortFlowConfirmResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ShortFlowConfirmRecipientSheet(recipient: recipient),
    );
  }

  @override
  State<ShortFlowConfirmRecipientSheet> createState() =>
      _ShortFlowConfirmRecipientSheetState();
}

class _ShortFlowConfirmRecipientSheetState
    extends State<ShortFlowConfirmRecipientSheet> {
  bool _saveAsFavorite = true; // ON by default, per spec.

  @override
  Widget build(BuildContext context) {
    final r = widget.recipient;
    final isInternal =
        r.type == 'internal' || r.bankName.toLowerCase() == 'lazervault';
    return Container(
      decoration: const BoxDecoration(
        color: ShortFlowConfirmRecipientSheet._bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Confirm recipient',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: ShortFlowConfirmRecipientSheet._card,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                if (isInternal)
                  CircleAvatar(
                    radius: 22.r,
                    backgroundColor:
                        ShortFlowConfirmRecipientSheet._purple.withValues(alpha: 0.2),
                    child: Text(
                      r.name.isNotEmpty ? r.name[0].toUpperCase() : '?',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ),
                  )
                else
                  BankLogo(
                    bankName: r.bankName,
                    bankCode: r.sortCode,
                    size: 44.r,
                  ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        r.name,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '${r.accountNumber} • ${r.bankName}',
                        style: GoogleFonts.inter(
                          color: ShortFlowConfirmRecipientSheet._textSecondary,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () => setState(() => _saveAsFavorite = !_saveAsFavorite),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: ShortFlowConfirmRecipientSheet._card,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Icon(
                    _saveAsFavorite ? Icons.star : Icons.star_outline,
                    color: _saveAsFavorite
                        ? ShortFlowConfirmRecipientSheet._amber
                        : ShortFlowConfirmRecipientSheet._textSecondary,
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Save to favorites',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Switch(
                    value: _saveAsFavorite,
                    onChanged: (v) => setState(() => _saveAsFavorite = v),
                    activeColor: ShortFlowConfirmRecipientSheet._purple,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 18.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(
                ShortFlowConfirmResult(saveAsFavorite: _saveAsFavorite),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ShortFlowConfirmRecipientSheet._purple,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(
                'Continue',
                style: GoogleFonts.inter(
                  color: Colors.white,
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
