import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../widgets/bill_receipt_qr_block.dart';
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/network_provider.dart';
import '../../services/airtime_pdf_service.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import 'airtime_screen.dart';

/// Local airtime receipt. Mirrors the electricity bill receipt layout 1:1
/// (status hero → consolidated details card → BillReceiptQrBlock → action
/// buttons) so a user buying airtime sees the same visual structure they
/// see when paying an electricity bill or sending money. The previous
/// version used a tall multi-section card with a 100w status badge and a
/// raw QrImageView in its own footer; the rewrite consolidates everything
/// into a single dark card and switches to the shared QR widget so all
/// LazerVault receipts stay visually consistent.
class AirtimePaymentConfirmationScreen extends StatefulWidget {
  const AirtimePaymentConfirmationScreen({super.key});

  @override
  State<AirtimePaymentConfirmationScreen> createState() =>
      _AirtimePaymentConfirmationScreenState();
}

class _AirtimePaymentConfirmationScreenState
    extends State<AirtimePaymentConfirmationScreen>
    with SingleTickerProviderStateMixin {
  AirtimeTransaction? transaction;
  bool isSuccess = false;
  String? errorMessage;
  bool _isDownloading = false;
  bool _isSharing = false;
  // Keep-alive payload forwarded from the review screen via processing.
  bool _saveAsContact = false;
  String? _nickname;
  String? _existingBeneficiaryId;
  bool _enableAutoRecharge = false;
  Map<String, dynamic>? _autoRechargePref;
  String? _networkCode;
  String? _networkName;
  /// Guard so the post-purchase save+autoRecharge RPCs only fire once
  /// per screen mount even if the rebuild + listener combo would
  /// otherwise re-trigger them.
  bool _postPayRan = false;

  late AnimationController _checkController;
  late Animation<double> _checkScale;

  @override
  void initState() {
    super.initState();
    _loadArguments();
    _checkController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _checkScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _checkController, curve: Curves.elasticOut),
    );
    _checkController.forward();
    // Fire the keep-alive RPCs after the first frame so the screen is
    // already painted (so the success snackbars don't overlap the build).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _runPostPurchaseActions();
      // A successful purchase invalidates the airtime landing's recent
      // transactions list. Notify the landing — it listens for this
      // tick and re-fetches, so the user sees their new purchase the
      // moment they navigate back.
      if (isSuccess) AirtimeScreen.notifyDataChanged();
    });
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      transaction = args['transaction'] as AirtimeTransaction?;
      errorMessage = args['errorMessage'] as String?;
      _saveAsContact = (args['saveAsContact'] as bool?) ?? false;
      _nickname = args['nickname'] as String?;
      _existingBeneficiaryId = args['existingBeneficiaryId'] as String?;
      _enableAutoRecharge = (args['enableAutoRecharge'] as bool?) ?? false;
      _autoRechargePref =
          (args['autoRechargePref'] as Map?)?.cast<String, dynamic>();
      _networkCode = args['networkCode'] as String?;
      _networkName = args['networkName'] as String?;
      // Derive success from the transaction's terminal state — pending /
      // processing share the success layout but with status-aware copy.
      if (transaction != null) {
        isSuccess = !transaction!.isFailed;
      } else {
        isSuccess = false;
        errorMessage ??= 'Payment could not be completed';
      }
    }
  }

  // ===================================================================
  // Post-purchase actions — fires once per mount when the payment is
  // in a terminal completed state. Mirrors electricity's
  // _runPostPurchaseActions in payment_receipt_screen.dart.
  //
  //   1. Save the recipient as a saved contact (skip if already saved).
  //   2. With the resolved beneficiary id, create the auto-recharge.
  //
  // Both steps are independent and best-effort: a failure in one does
  // not block the other and never blocks the receipt UI.
  // ===================================================================
  Future<void> _runPostPurchaseActions() async {
    if (_postPayRan) return;
    _postPayRan = true;
    if (!isSuccess || transaction == null) return;
    if (!_saveAsContact && !_enableAutoRecharge) return;

    final cubit = context.read<AirtimeCubit>();
    final tx = transaction!;
    String? beneficiaryId = _existingBeneficiaryId;

    // Run the post-purchase actions silently — the receipt itself
    // already confirms the airtime sent successfully, and the user
    // can verify the saved contact / auto-recharge in the dedicated
    // Saved Contacts and Auto-Recharge screens. The previous snackbars
    // ("Quick top-up from Saved Contacts", "Save the contact first")
    // were too noisy on top of the receipt's hero copy. We only
    // surface a snackbar when something genuinely went wrong, since
    // that's the only case the user needs to act on.

    // 1. Save as contact ─────────────────────────────────────────────
    if (_saveAsContact && beneficiaryId == null) {
      try {
        await cubit.saveBeneficiary(
          phoneNumber: tx.recipientPhoneNumber,
          networkCode:
              _networkCode ?? tx.networkProvider.shortName.toUpperCase(),
          networkName: _networkName ?? tx.networkProvider.displayName,
          nickname: (_nickname?.isNotEmpty ?? false) ? _nickname : null,
        );
        // The cubit emits AirtimeBeneficiarySaved with the new entity.
        final state = cubit.state;
        if (state is AirtimeBeneficiarySaved) {
          beneficiaryId = state.beneficiary.id;
        }
      } catch (_) {
        if (mounted) {
          _softInfo('Save failed',
              'We couldn\'t save the contact. Try again from the recipient screen.');
        }
      }
    }

    // 2. Auto-recharge ───────────────────────────────────────────────
    // Skipped silently when no beneficiary id is available — the user
    // chose not to save, so badgering them with "Save the contact
    // first" would be patronising. They can still set up auto-recharge
    // from the saved-contact options sheet later.
    if (_enableAutoRecharge && _autoRechargePref != null) {
      if (beneficiaryId == null) return;
      try {
        final pref = _autoRechargePref!;
        await cubit.createAutoRecharge(
          beneficiaryId: beneficiaryId,
          amount: (pref['amount'] as num).toDouble(),
          currency: tx.currency,
          frequency: (pref['frequency'] as String?) ?? 'daily',
          dayOfWeek: (pref['dayOfWeek'] as int?) ?? 0,
          dayOfMonth: (pref['dayOfMonth'] as int?) ?? 1,
          executionHour: pref['executionHour'] as int?,
          executionMinute: pref['executionMinute'] as int?,
        );
      } catch (_) {
        if (mounted) {
          _softInfo('Auto-recharge couldn\'t be enabled',
              'Payment succeeded, but the schedule didn\'t save. Retry from the auto-recharge screen.');
        }
      }
    }
  }

  void _softInfo(String title, String message, {bool isSuccess = false}) {
    if (!mounted) return;
    Get.snackbar(
      title,
      message,
      backgroundColor: (isSuccess
              ? const Color(0xFF10B981)
              : const Color(0xFFFB923C))
          .withValues(alpha: 0.92),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 4),
    );
  }

  /// Pull-to-refresh handler — re-renders this receipt so live updates
  /// from a webhook (e.g. `pending` → `completed`) are picked up. The
  /// payment is identified solely via the transaction object passed in
  /// from processing; we don't have a `receipt-by-id` RPC for airtime
  /// today, so the refresh is best-effort: it triggers any pending
  /// state-changes from the cubit and rebuilds the screen.
  Future<void> _refreshReceipt() async {
    if (transaction == null) return;
    try {
      final userId = transaction!.userId;
      if (userId.isNotEmpty) {
        await context.read<AirtimeCubit>().loadTransactionHistory(userId);
        // Ignore — the AirtimeTransactionHistoryLoaded state carries the
        // updated row, but we don't currently swap the local
        // `transaction` field; future improvement would patch from
        // history. The pull is still useful: reconciler-side state will
        // be reflected in the history list opened from the actions row.
      }
    } catch (_) {
      // Silent — refresh is opportunistic.
    }
  }

  @override
  void dispose() {
    _checkController.dispose();
    super.dispose();
  }

  Future<void> _downloadReceipt() async {
    if (transaction == null || _isDownloading) return;
    setState(() => _isDownloading = true);
    try {
      final filePath = await AirtimePdfService.downloadReceipt(
        transaction: transaction!,
      );
      if (mounted) {
        Get.snackbar(
          'Receipt Downloaded',
          'Saved to: $filePath',
          backgroundColor: const Color(0xFF10B981),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (_) {
      if (mounted) {
        Get.snackbar(
          'Download Failed',
          'Could not download receipt. Please try again.',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  Future<void> _shareReceipt() async {
    if (transaction == null || _isSharing) return;
    setState(() => _isSharing = true);
    try {
      await AirtimePdfService.shareReceipt(transaction: transaction!);
    } catch (_) {
      if (mounted) {
        Get.snackbar(
          'Share Failed',
          'Could not share receipt. Please try again.',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  /// Back navigation — always lands on the airtime landing page (not
  /// the dashboard) so users can immediately start another top-up.
  /// Mirrors the recipient_input "close" gesture (`Get.until` until the
  /// airtime route is found).
  void _handleBack() {
    Get.until((route) =>
        route.settings.name == AppRoutes.airtime || route.isFirst);
  }

  String get _currencySymbol => transaction?.currencySymbol ?? '₦';

  // ---------------------------------------------------------------------------
  // Status copy / icon — status-aware so failed / pending receipts aren't
  // misrepresented. Same shape as electricity_bill/payment_receipt_screen.
  // ---------------------------------------------------------------------------

  String _resolveHeroTitle() {
    if (transaction == null) return 'Payment Failed';
    if (transaction!.isFailed) return 'Payment Failed';
    if (transaction!.isPending) return 'Payment Submitted';
    return 'Airtime Sent!';
  }

  String _getStatusMessage() {
    if (transaction == null) {
      return errorMessage ?? 'Payment could not be completed';
    }
    if (transaction!.isFailed) {
      return errorMessage ??
          transaction!.failureReason ??
          'Payment failed. Please try again.';
    }
    if (transaction!.isPending) {
      return 'Your top-up is being processed by the network. This usually completes within a few seconds.';
    }
    return 'Your airtime has been delivered successfully.';
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: _handleBack,
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
        ),
        title: Text(
          'Payment Receipt',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        // Pull-to-refresh reruns the history fetch so any reconciler
        // updates land on this view. The receipt is otherwise static.
        child: RefreshIndicator(
          onRefresh: _refreshReceipt,
          color: const Color(0xFF4E03D0),
          backgroundColor: const Color(0xFF1F1F1F),
          child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildStatusIcon(),
              SizedBox(height: 12.h),
              Text(
                _resolveHeroTitle(),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                _getStatusMessage(),
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16.h),
              if (transaction != null) _buildTransactionDetails(),
              if (transaction != null && isSuccess) ...[
                SizedBox(height: 20.h),
                BillReceiptQrBlock(
                  type: 'airtime',
                  reference: transaction!.transactionReference,
                  amount: transaction!.amount,
                  currency: transaction!.currency,
                  status: transaction!.status.name,
                  timestamp: transaction!.createdAt,
                  showDivider: false,
                  extraPayload: {
                    'phone': transaction!.recipientPhoneNumber,
                    'network': transaction!.networkProvider.displayName,
                    if (transaction!.recipientName != null &&
                        transaction!.recipientName!.isNotEmpty)
                      'recipient': transaction!.recipientName!,
                  },
                ),
              ],
              SizedBox(height: 24.h),
            ],
          ),
        ),
        ),
      ),
      // Pin the primary CTAs so they're always reachable without scrolling.
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 12.h),
          child: _buildBottomActions(),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Status hero — 64w status-coloured circle, animated scale-in
  // ---------------------------------------------------------------------------

  Widget _buildStatusIcon() {
    IconData icon;
    Color color;
    if (transaction == null || transaction!.isFailed) {
      icon = Icons.cancel;
      color = const Color(0xFFEF4444);
    } else if (transaction!.isPending) {
      icon = Icons.hourglass_top;
      color = const Color(0xFFFB923C);
    } else {
      icon = Icons.check_circle;
      color = const Color(0xFF10B981);
    }
    return AnimatedBuilder(
      animation: _checkScale,
      builder: (context, child) {
        return Transform.scale(
          scale: _checkScale.value,
          child: Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 40.sp),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Single consolidated details card — same shape as the electricity
  // receipt: amount group → recipient group → reference group, separated
  // by inline dividers. Fits on one screen for a typical top-up.
  // ---------------------------------------------------------------------------

  Widget _buildTransactionDetails() {
    final t = transaction!;
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');
    final displayDate = t.completedAt ?? t.createdAt;
    final hasFee = t.fee != null && t.fee! > 0;
    final hasDiscount = t.discount != null && t.discount! > 0;
    final statusColor = isSuccess
        ? const Color(0xFF10B981)
        : (t.isPending
            ? const Color(0xFFFB923C)
            : const Color(0xFFEF4444));

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14.h),
          _detailRow('Airtime Amount',
              '$_currencySymbol${t.amount.toStringAsFixed(2)}'),
          if (hasFee) ...[
            SizedBox(height: 10.h),
            _detailRow('Service Fee',
                '$_currencySymbol${t.fee!.toStringAsFixed(2)}'),
          ],
          if (hasDiscount) ...[
            SizedBox(height: 10.h),
            _detailRow('Discount',
                '-$_currencySymbol${t.discount!.toStringAsFixed(2)}',
                valueColor: const Color(0xFF10B981)),
          ],
          SizedBox(height: 10.h),
          _detailRow(
            'Total Paid',
            '$_currencySymbol${t.totalAmount.toStringAsFixed(2)}',
            valueColor: Colors.white,
            isBold: true,
          ),
          _sectionDivider(),
          _detailRow('Recipient', t.formattedRecipientNumber),
          if (t.recipientName != null && t.recipientName!.isNotEmpty) ...[
            SizedBox(height: 10.h),
            _detailRow('Name', t.recipientName!),
          ],
          SizedBox(height: 10.h),
          _detailRow('Network', t.networkProvider.displayName),
          _sectionDivider(),
          _detailRow('Reference', t.transactionReference),
          SizedBox(height: 10.h),
          _detailRow('Date', dateFormat.format(displayDate)),
          SizedBox(height: 10.h),
          _detailRow('Time', timeFormat.format(displayDate)),
          SizedBox(height: 10.h),
          _detailRow(
            'Status',
            t.status.displayName,
            valueColor: statusColor,
          ),
        ],
      ),
    );
  }

  Widget _sectionDivider() => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Divider(color: const Color(0xFF2D2D2D), height: 1),
      );

  Widget _detailRow(String label, String value,
      {Color? valueColor, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              color: valueColor ?? Colors.white,
              fontSize: 13.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom action row helpers
  // ---------------------------------------------------------------------------

  /// Single icon-only action button — small circle + icon + tiny label.
  /// Used by the consolidated bottom row so Share / Download / Buy More /
  /// View History fit on one line without horizontal scrolling. The
  /// row is shown via [_buildBottomActions].
  Widget _iconActionButton({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    bool busy = false,
    Color color = const Color(0xFF4E03D0),
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: busy ? null : onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color.withValues(alpha: 0.35),
                    width: 1,
                  ),
                ),
                child: busy
                    ? Padding(
                        padding: EdgeInsets.all(11.w),
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF4E03D0),
                        ),
                      )
                    : Icon(icon, color: color, size: 20.sp),
              ),
              SizedBox(height: 6.h),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // _buildShareDownload was removed — Share/Download tiles are now part
  // of the consolidated bottom action row in _buildBottomActions.

  // ---------------------------------------------------------------------------
  // Bottom-pinned action row — Share / Download / Buy More / History on
  // success; Try Again / Buy More / History on failure.
  // ---------------------------------------------------------------------------

  /// Consolidated bottom action row. Drops the previous "Back to
  /// Dashboard" primary button (back arrow already returns to airtime
  /// landing) and lays Share / Download / Buy More / View History side
  /// by side as icon-only tiles. On failure, replaces Share/Download
  /// with a "Try Again" tile that pops to the previous screen. Each
  /// action is a real handler — the receipt is tappable end-to-end.
  Widget _buildBottomActions() {
    if (!isSuccess) {
      // Failure: keep just Try Again + Buy More + History so the user
      // can quickly recover. No share/download because the receipt has
      // nothing useful to share.
      return Row(
        children: [
          _iconActionButton(
            icon: Icons.refresh,
            label: 'Try Again',
            color: const Color(0xFFEF4444),
            onTap: () => Get.back(),
          ),
          _iconActionButton(
            icon: Icons.phone_android,
            label: 'Buy More',
            onTap: () => Get.offAllNamed(AppRoutes.airtime),
          ),
          _iconActionButton(
            icon: Icons.history,
            label: 'History',
            onTap: () => Get.toNamed(AppRoutes.airtimeHistory),
          ),
        ],
      );
    }
    return Row(
      children: [
        _iconActionButton(
          icon: Icons.share,
          label: 'Share',
          busy: _isSharing,
          onTap: _shareReceipt,
        ),
        _iconActionButton(
          icon: Icons.download,
          label: 'Download',
          busy: _isDownloading,
          onTap: _downloadReceipt,
        ),
        _iconActionButton(
          icon: Icons.phone_android,
          label: 'Buy More',
          onTap: () => Get.offAllNamed(AppRoutes.airtime),
        ),
        _iconActionButton(
          icon: Icons.history,
          label: 'History',
          onTap: () => Get.toNamed(AppRoutes.airtimeHistory),
        ),
      ],
    );
  }
}
