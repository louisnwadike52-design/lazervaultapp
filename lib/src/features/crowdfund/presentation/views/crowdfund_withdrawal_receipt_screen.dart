import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/navigation/back_or_home.dart';
import 'package:lazervault/src/features/crowdfund/presentation/utils/crowdfund_withdrawal_receipt.dart';
import 'package:lazervault/src/features/crowdfund/services/crowdfund_withdrawal_pdf_service.dart';

/// What a creator sees straight after taking money out of a campaign.
///
/// The withdrawal used to end at a SnackBar: the one moment real money leaves
/// a campaign left no record of what was taken, what the platform charged,
/// what landed, or where. This states all four and can be shared as a PDF.
///
/// Back goes BACK — via backOrHome — because this screen is pushed over the
/// campaign details the creator was already on. Resetting to the dashboard
/// here would throw away the screen they want to return to.
class CrowdfundWithdrawalReceiptScreen extends StatefulWidget {
  const CrowdfundWithdrawalReceiptScreen({super.key, required this.receipt});

  final CrowdfundWithdrawalReceipt receipt;

  @override
  State<CrowdfundWithdrawalReceiptScreen> createState() =>
      _CrowdfundWithdrawalReceiptScreenState();
}

class _CrowdfundWithdrawalReceiptScreenState
    extends State<CrowdfundWithdrawalReceiptScreen> {
  bool _sharing = false;

  Future<void> _share() async {
    if (_sharing) return;
    setState(() => _sharing = true);
    try {
      await CrowdfundWithdrawalPdfService.share(widget.receipt);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not share the receipt: $e',
                style: TextStyle(fontSize: 13.sp)),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.receipt;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) backOrHome();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          backgroundColor: const Color(0xFF121212),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: backOrHome,
          ),
          title: Text(
            'Withdrawal receipt',
            style: GoogleFonts.inter(
                fontSize: 17.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.check_circle_rounded,
                    color: const Color(0xFF10B981), size: 56.sp),
                SizedBox(height: 12.h),
                Text(
                  r.netAmount,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 30.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4.h),
                Text(
                  r.destinationNote,
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.inter(fontSize: 13.sp, color: Colors.white70),
                ),
                SizedBox(height: 6.h),
                Text(
                  DateFormat('d MMM yyyy, h:mm a').format(r.createdAt),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 11.5.sp, color: Colors.white38),
                ),
                SizedBox(height: 24.h),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        r.title,
                        style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 12.h),
                      ...r.lines.map(
                        (l) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  l.label,
                                  style: GoogleFonts.inter(
                                    fontSize: 12.5.sp,
                                    color: l.emphasise
                                        ? Colors.white
                                        : Colors.white60,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                l.value,
                                style: GoogleFonts.inter(
                                  fontSize: l.emphasise ? 14.sp : 12.5.sp,
                                  fontWeight: l.emphasise
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: l.emphasise
                                      ? const Color(0xFF10B981)
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  height: 50.h,
                  child: ElevatedButton.icon(
                    onPressed: _sharing ? null : _share,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E03D0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                    icon: _sharing
                        ? SizedBox(
                            width: 16.w,
                            height: 16.w,
                            child: const CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : Icon(Icons.ios_share, size: 18.sp),
                    label: Text(
                      _sharing ? 'Preparing…' : 'Share receipt',
                      style: GoogleFonts.inter(
                          fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                TextButton(
                  onPressed: backOrHome,
                  child: Text(
                    'Done',
                    style: GoogleFonts.inter(
                        fontSize: 14.sp, color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
