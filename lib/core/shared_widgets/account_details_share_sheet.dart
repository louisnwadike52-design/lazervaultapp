import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

/// One "view / copy / share my account details" sheet, for every account type
/// that holds a NUBAN.
///
/// WHY THIS IS SHARED RATHER THAN PER-SCREEN
/// -----------------------------------------
/// Personal accounts have had a full details surface (number, bank, copy,
/// share) for a long time. Business rendered the same facts as a single line of
/// DEAD TEXT — `'$bankName · $accountNumber'` — with no way to copy it, and the
/// family pool had no details surface at all. Someone being paid into a
/// business or family account had to retype a ten-digit number read off a
/// screen, which is exactly how money reaches the wrong account.
///
/// The share MESSAGE and its failure handling are deliberately identical to the
/// personal card's: the same greeting, the same aligned labels, the same
/// iPad-anchored share, and the same "we copied it instead" fallback when the
/// platform sheet fails. A person who shares their business details and then
/// their personal ones should not get two different-looking messages.
///
/// PER-ITEM COPY. Each row copies just its own value. Copying the whole block
/// is right when you are pasting into a chat; it is wrong when a bank form
/// wants only the digits, and forcing the user to edit a pasted blob is how a
/// stray space ends up in an account number.
class AccountDetailsShareSheet extends StatelessWidget {
  /// Title of the sheet — "Business account details", "Pool account details".
  final String title;

  /// The name the receiving bank will show: the business name, the family
  /// name, or the account holder.
  final String accountName;

  /// Label for [accountName] — "Business name", "Pool name", "Account name".
  /// Named per type because "Account name" on a family pool reads like the
  /// creator's personal name.
  final String accountNameLabel;

  final String bankName;
  final String accountNumber;

  /// Shown under the title. Use it to say whose account this is.
  final String? subtitle;

  const AccountDetailsShareSheet({
    super.key,
    required this.title,
    required this.accountName,
    required this.bankName,
    required this.accountNumber,
    this.accountNameLabel = 'Account name',
    this.subtitle,
  });

  static const _surface = Color(0xFF1F1F1F);
  static const _row = Color(0xFF141414);
  static const _brand = Color(0xFF7C3AED);
  static const _ok = Color(0xFF10B981);
  static const _warn = Color(0xFFF59E0B);

  /// Digits only. A NUBAN copied with a stray space or dash is rejected by the
  /// receiving bank's form, and the user cannot see which character is wrong.
  String get _digits => accountNumber.replaceAll(RegExp(r'[^0-9]'), '');

  bool get _payable => _digits.isNotEmpty;

  /// Byte-for-byte the personal card's format, so the two are indistinguishable
  /// to whoever receives them.
  String get _shareMessage {
    final details = <String>[
      if (accountName.trim().isNotEmpty)
        'Account name:    ${accountName.trim()}',
      if (bankName.trim().isNotEmpty) 'Bank:            ${bankName.trim()}',
      'Account number:  $_digits',
    ];
    return [
      'Hello,',
      '',
      'Here are my Lazervault account details for your transfer.',
      '',
      ...details,
      '',
      'Thank you.',
    ].join('\n');
  }

  /// Opens the sheet. Returns when it is dismissed.
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String accountName,
    required String bankName,
    required String accountNumber,
    String accountNameLabel = 'Account name',
    String? subtitle,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => AccountDetailsShareSheet(
        title: title,
        accountName: accountName,
        bankName: bankName,
        accountNumber: accountNumber,
        accountNameLabel: accountNameLabel,
        subtitle: subtitle,
      ),
    );
  }

  void _copy(String value, String what) {
    Clipboard.setData(ClipboardData(text: value));
    Get.snackbar('Copied', '$what copied to clipboard',
        backgroundColor: _ok,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2));
  }

  Future<void> _share(BuildContext iconContext) async {
    if (!_payable) {
      Get.snackbar('Not ready yet', 'This account has no number to share yet.',
          backgroundColor: _warn,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3));
      return;
    }
    // The popover rect must come from the tapped widget, or on iPad it points
    // somewhere else entirely — and SharePlus throws without one.
    Rect? origin;
    final box = iconContext.findRenderObject() as RenderBox?;
    if (box != null && box.hasSize) {
      origin = box.localToGlobal(Offset.zero) & box.size;
    }
    try {
      await SharePlus.instance.share(ShareParams(
        text: _shareMessage,
        subject: 'My Lazervault account details',
        sharePositionOrigin: origin,
      ));
    } catch (_) {
      // Never leave the user tapping a button that gives no sign either way.
      Get.snackbar('Could not share',
          'Your details are copied instead — paste them anywhere.',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3));
      await Clipboard.setData(ClipboardData(text: _shareMessage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ConstrainedBox(
        // Capped and SCROLLABLE. isScrollControlled lifts the default height
        // limit but does not make the content scroll — without this the column
        // overflowed on a short screen (caught at 390x844 in the widget test:
        // "RenderFlex overflowed by 17 pixels"), which on a real device clips
        // the Share button off the bottom of a sheet whose entire purpose is
        // that button. 0.85 keeps the page visible behind so it still reads as
        // a sheet rather than a route.
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: SingleChildScrollView(
            // Clears the home indicator so the final control is tappable
            // rather than sitting under the gesture bar.
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewPadding.bottom,
            ),
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
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 18.h),
                Text(title,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700)),
                if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(subtitle!,
                      style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 12.5.sp)),
                ],
                SizedBox(height: 16.h),
                if (!_payable)
                  // Say what is missing rather than showing an empty row. A blank
                  // number beside a real bank name invites someone to pay into
                  // nothing.
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: _warn.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: _warn.withValues(alpha: 0.4)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: _warn, size: 18.sp),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            'This account has no number yet, so there is nothing to '
                            'copy or share. It appears here as soon as it is issued.',
                            style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: Colors.white.withValues(alpha: 0.85)),
                          ),
                        ),
                      ],
                    ),
                  )
                else ...[
                  _DetailRow(
                    label: accountNameLabel,
                    value: accountName,
                    onCopy: accountName.trim().isEmpty
                        ? null
                        : () => _copy(accountName.trim(), accountNameLabel),
                  ),
                  _DetailRow(
                    label: 'Bank',
                    value: bankName,
                    onCopy: bankName.trim().isEmpty
                        ? null
                        : () => _copy(bankName.trim(), 'Bank name'),
                  ),
                  _DetailRow(
                    label: 'Account number',
                    value: _digits,
                    emphasise: true,
                    onCopy: () => _copy(_digits, 'Account number'),
                  ),
                ],
                SizedBox(height: 18.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _payable
                            ? () => _copy(_shareMessage, 'Account details')
                            : null,
                        icon: Icon(Icons.copy_all_rounded, size: 18.sp),
                        label: Text('Copy all',
                            style: GoogleFonts.inter(
                                fontSize: 14.sp, fontWeight: FontWeight.w600)),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(
                              color: Colors.white.withValues(alpha: 0.25)),
                          padding: EdgeInsets.symmetric(vertical: 13.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r)),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Builder(
                        // Builder so the share sheet anchors to THIS button.
                        builder: (iconContext) => ElevatedButton.icon(
                          onPressed:
                              _payable ? () => _share(iconContext) : null,
                          icon: Icon(Icons.ios_share, size: 18.sp),
                          label: Text('Share',
                              style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _brand,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor:
                                _brand.withValues(alpha: 0.35),
                            padding: EdgeInsets.symmetric(vertical: 13.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// One labelled fact with its own copy button.
class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool emphasise;
  final VoidCallback? onCopy;

  const _DetailRow({
    required this.label,
    required this.value,
    this.onCopy,
    this.emphasise = false,
  });

  @override
  Widget build(BuildContext context) {
    final shown = value.trim().isEmpty ? '—' : value.trim();
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AccountDetailsShareSheet._row,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: GoogleFonts.inter(
                        fontSize: 11.5.sp,
                        color: Colors.white.withValues(alpha: 0.55))),
                SizedBox(height: 3.h),
                Text(
                  shown,
                  style: GoogleFonts.inter(
                    fontSize: emphasise ? 17.sp : 14.sp,
                    color: Colors.white,
                    fontWeight: emphasise ? FontWeight.w800 : FontWeight.w600,
                    // Digits line up when the number is the thing being read
                    // aloud or checked character by character.
                    letterSpacing: emphasise ? 1.1 : 0,
                  ),
                ),
              ],
            ),
          ),
          if (onCopy != null)
            IconButton(
              onPressed: onCopy,
              visualDensity: VisualDensity.compact,
              tooltip: 'Copy $label',
              icon: Icon(Icons.copy_rounded,
                  size: 18.sp, color: Colors.white.withValues(alpha: 0.75)),
            ),
        ],
      ),
    );
  }
}
