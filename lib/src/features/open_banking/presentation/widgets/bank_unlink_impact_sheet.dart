import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/open_banking/presentation/helpers/bank_unlink_impact.dart';
import 'package:lazervault/core/widgets/app_bottom_sheet.dart';

const _brand = Color(0xFF4E03D0);
const _surface = Color(0xFF1A1A1A);
const _raised = Color(0xFF1F1F1F);
const _border = Color(0xFF2A2A2D);
const _muted = Color(0xFF9CA3AF);
const _danger = Color(0xFFEF4444);
const _warn = Color(0xFFF59E0B);

/// Confirms a bank unlink by first SHOWING WHAT IS ATTACHED TO IT.
///
/// Returns true to proceed with the unlink, false/null to keep the bank.
///
/// "Keep this bank" is the primary, visually dominant action and "Unlink
/// anyway" is the quiet destructive one — the opposite of a normal confirm
/// dialog, and deliberate: the customer arrived here intending to unlink, so
/// the new information is the reason to stop, not the reason to continue.
Future<bool> showBankUnlinkImpactSheet({
  required BuildContext context,
  required String bankName,
  required String maskedAccountNumber,
  required BankUnlinkImpact impact,
}) async {
  final proceed = await showAppBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheetCtx) => _BankUnlinkImpactSheet(
      bankName: bankName,
      maskedAccountNumber: maskedAccountNumber,
      impact: impact,
    ),
  );
  return proceed ?? false;
}

class _BankUnlinkImpactSheet extends StatelessWidget {
  final String bankName;
  final String maskedAccountNumber;
  final BankUnlinkImpact impact;

  const _BankUnlinkImpactSheet({
    required this.bankName,
    required this.maskedAccountNumber,
    required this.impact,
  });

  @override
  Widget build(BuildContext context) {
    final rules = impact.liveAutoSaveRules;

    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        border: Border.all(color: _border),
      ),
      // The list can be long (a customer may have several rules on one bank),
      // so it scrolls and is capped rather than pushing the actions off screen.
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: _border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    SizedBox(height: 20.h),
                    if (rules.isNotEmpty) ...[
                      _sectionLabel(
                          rules.length == 1
                              ? '1 autosave rule is funded by this bank'
                              : '${rules.length} autosave rules are funded by this bank'),
                      SizedBox(height: 10.h),
                      for (final rule in rules) _ruleRow(rule),
                      SizedBox(height: 16.h),
                    ],
                    if (impact.revokesDebitAuthority) ...[
                      _sectionLabel('Direct debit'),
                      SizedBox(height: 10.h),
                      _mandateRow(),
                      SizedBox(height: 16.h),
                    ],
                    if (impact.isDefault) ...[
                      _infoRow(
                        icon: Icons.star_outline,
                        color: _warn,
                        title: 'This is your default funding bank',
                        detail:
                            'Another linked bank becomes the default. If this '
                            'is your only one, deposits and transfers that pull '
                            'from a bank will ask you to link one again.',
                      ),
                      SizedBox(height: 16.h),
                    ],
                    if (impact.attachmentsUnavailable)
                      _infoRow(
                        icon: Icons.cloud_off_outlined,
                        color: _warn,
                        title: "We couldn't check what's attached",
                        detail:
                            'Your autosave rules could not be loaded just now, '
                            'so this list may be incomplete. You can still '
                            'unlink, or try again when you are back online.',
                      ),
                    if (!impact.hasConsequences)
                      _infoRow(
                        icon: Icons.check_circle_outline,
                        color: const Color(0xFF10B981),
                        title: 'Nothing else is attached to this bank',
                        detail:
                            'No autosave rule is funded by it and there is no '
                            'direct debit to revoke.',
                      ),
                  ],
                ),
              ),
            ),
            _actions(context),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Unlink $bankName?',
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          maskedAccountNumber.isEmpty
              ? 'Here is what is attached to it.'
              : '$maskedAccountNumber · here is what is attached to it.',
          style: GoogleFonts.inter(fontSize: 13.sp, color: _muted),
        ),
      ],
    );
  }

  Widget _sectionLabel(String text) => Text(
        text.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.6,
          color: _muted,
        ),
      );

  Widget _ruleRow(AutoSaveRuleEntity rule) {
    // Named for what the customer will experience, not for the row's status
    // field: a paused rule they intend to resume is just as broken by this as
    // an active one, and saying "paused" here would imply it is fine.
    final consequence = rule.status == AutoSaveStatus.active
        ? 'Will stop saving'
        : 'Could not be resumed';
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: _raised,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Icon(Icons.savings_outlined, color: _brand, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rule.name.trim().isEmpty ? 'Autosave rule' : rule.name.trim(),
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  consequence,
                  style: GoogleFonts.inter(fontSize: 12.sp, color: _danger),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mandateRow() {
    final onDirectPay = impact.mandateIsOnDirectPay;
    return _infoRow(
      icon: Icons.account_balance_outlined,
      color: _warn,
      title: onDirectPay
          // The customer switched this to DirectPay themselves and reasonably
          // believes the direct debit is already finished with. It is not: a
          // paused mandate is still a standing authority at the bank, which is
          // why unlinking revokes it rather than leaving it behind.
          ? 'Your paused direct debit will be cancelled for good'
          : 'Your direct debit will be cancelled',
      detail: onDirectPay
          ? 'You switched this bank to one-time payments, which paused the '
              'direct debit rather than ending it. Unlinking cancels it at the '
              'bank. Setting one up again later means authorising it again.'
          : "$bankName will no longer be able to debit this account. Setting "
              'one up again later means authorising it again.',
    );
  }

  Widget _infoRow({
    required IconData icon,
    required Color color,
    required String title,
    required String detail,
  }) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: _raised,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  detail,
                  style: GoogleFonts.inter(
                      fontSize: 12.sp, color: _muted, height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              style: ElevatedButton.styleFrom(
                backgroundColor: _brand,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: Text(
                'Keep this bank',
                style: GoogleFonts.inter(
                    fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(
                foregroundColor: _danger,
                padding: EdgeInsets.symmetric(vertical: 13.h),
              ),
              child: Text(
                impact.liveAutoSaveRules.isEmpty
                    ? 'Unlink anyway'
                    : 'Unlink and stop these rules',
                style: GoogleFonts.inter(
                    fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
