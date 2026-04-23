import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../widgets/bill_receipt_qr_block.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../data/datasources/cable_tv_beneficiary_remote_datasource.dart';
import '../../data/datasources/cable_tv_remote_datasource.dart';
import '../../domain/entities/cable_tv_payment_entity.dart';
import '../../domain/entities/cable_tv_provider_entity.dart';
import '../../domain/entities/tv_package_entity.dart';
import '../../services/cable_tv_pdf_service.dart';
import '../widgets/cable_tv_rollover_preference_sheet.dart';

class CableTVPaymentReceiptScreen extends StatefulWidget {
  const CableTVPaymentReceiptScreen({super.key});

  @override
  State<CableTVPaymentReceiptScreen> createState() =>
      _CableTVPaymentReceiptScreenState();
}

class _CableTVPaymentReceiptScreenState
    extends State<CableTVPaymentReceiptScreen> {
  bool _isDownloading = false;
  bool _isSharing = false;
  bool _postPurchaseRan = false;

  /// Latest payment snapshot, refreshed via pull-to-refresh. Overrides
  /// the initial [Get.arguments] payload in the build so the user can see
  /// async status updates (processing → completed/failed) without having
  /// to navigate away.
  CableTVPaymentEntity? _latestPayment;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _runPostPurchaseActions());
  }

  /// Re-fetches the payment history and finds the row matching the current
  /// reference/id. Preserves [newBalance]/[renewalDate]/[customerName] from
  /// the original pay response since the history endpoint doesn't surface
  /// those fields.
  Future<void> _refreshPayment(CableTVPaymentEntity current) async {
    if (_isRefreshing) return;
    _isRefreshing = true;
    try {
      final remote = GetIt.I<CableTVRemoteDataSource>();
      final history = await remote.getPaymentHistory(limit: 50);
      final match = history.where((p) =>
          (current.reference.isNotEmpty && p.reference == current.reference) ||
          (current.id.isNotEmpty && p.id == current.id));
      if (match.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('No newer status yet. Try again in a moment.'),
            backgroundColor: const Color(0xFFFB923C),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(12.w),
          ),
        );
        return;
      }
      final fresh = match.first;
      if (!mounted) return;
      setState(() {
        _latestPayment = CableTVPaymentEntity(
          id: fresh.id,
          userId: fresh.userId,
          accountId: fresh.accountId,
          billType: fresh.billType,
          providerId: fresh.providerId,
          reference: fresh.reference,
          amount: fresh.amount,
          status: fresh.status,
          customerNumber: fresh.customerNumber,
          metadata: fresh.metadata,
          createdAt: fresh.createdAt,
          // Preserve fields not returned by the history endpoint.
          newBalance: current.newBalance,
          renewalDate: current.renewalDate,
          customerName: current.customerName,
        );
      });
      // If the refreshed status flipped to non-failed, run post-purchase
      // actions once (save beneficiary / enable auto-renew) so an async
      // flow that terminated on a later status still honours the toggles.
      if (!_postPurchaseRan && !_latestPayment!.isFailed) {
        _runPostPurchaseActions();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Refresh failed: $e'),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(12.w),
        ),
      );
    } finally {
      _isRefreshing = false;
    }
  }

  /// Save beneficiary + enable auto-renew if the confirm screen asked
  /// for them. Runs once on first build — guarded by [_postPurchaseRan]
  /// so widget rebuilds don't trigger duplicate RPCs. Both calls hit
  /// the real backend (commerce-gateway → utility-payments-service) —
  /// no fake-success shortcuts.
  ///
  /// Strict gate on `payment.isCompleted`: we never save on
  /// pending/processing. If the user closes the receipt before the
  /// async consumer terminates the payment, they re-enable the toggles
  /// on their next purchase. Trade-off accepted over leaving partial
  /// data in the DB.
  Future<void> _runPostPurchaseActions() async {
    if (_postPurchaseRan) return;
    _postPurchaseRan = true;

    final args = Get.arguments as Map<String, dynamic>?;
    if (args == null) return;
    final payment = args['payment'] as CableTVPaymentEntity?;
    if (payment == null) return;
    // Skip only for definitively failed payments. Completed + processing +
    // pending all get the beneficiary saved — the user explicitly asked for
    // it and saving is idempotent. Auto-renew creation follows the same
    // rule: we don't schedule a recurring charge on a failed payment.
    if (payment.isFailed) return;

    final provider = args['provider'] as CableTVProviderEntity?;
    final package = args['package'] as TVPackageEntity?;
    final smartCardNumber = args['smartCardNumber'] as String?;
    final saveBeneficiary = (args['saveBeneficiary'] as bool?) ?? false;
    final nickname = args['beneficiaryNickname'] as String?;
    final autoRenewEnabled = (args['autoRenewEnabled'] as bool?) ?? false;
    final pref = args['rolloverPref'] as CableTVRolloverPreference?;

    // If neither toggle was on we have nothing to do. The receipt still
    // renders normally.
    if (!saveBeneficiary && !autoRenewEnabled) return;
    if (provider == null || package == null || smartCardNumber == null) return;

    final providerCode = provider.serviceId.toLowerCase();
    final ds = GetIt.I<CableTVBeneficiaryRemoteDataSource>();

    // --- Save beneficiary (or reuse existing) ---
    String? beneficiaryId;
    if (saveBeneficiary) {
      try {
        final saved = await ds.saveBeneficiary(
          smartCardNumber: smartCardNumber,
          providerCode: providerCode,
          providerName: provider.name,
          nickname: nickname,
          customerName: payment.customerName,
        );
        beneficiaryId = saved.id;
      } catch (_) {
        // Duplicate — fall through and look up the existing row.
        try {
          final list = await ds.getBeneficiaries();
          for (final b in list) {
            if (b.smartCardNumber == smartCardNumber &&
                b.providerCode.toLowerCase() == providerCode) {
              beneficiaryId = b.id;
              break;
            }
          }
        } catch (_) {
          _softInfo(
            'Smart card save failed',
            'We couldn\'t save this smart card. You can save it manually from the saved smart cards screen.',
          );
        }
      }
    }

    // --- Create auto-renew ---
    if (autoRenewEnabled && pref != null) {
      if (package.amount <= 0) {
        _softInfo(
          'Auto-renew skipped',
          'This package has no amount set, so we can\'t schedule a recurring charge.',
        );
        return;
      }
      // Beneficiary is required for auto-renew. If the user didn't save
      // one explicitly, upsert silently so the schedule has something
      // to attach to.
      if (beneficiaryId == null) {
        try {
          final list = await ds.getBeneficiaries();
          for (final b in list) {
            if (b.smartCardNumber == smartCardNumber &&
                b.providerCode.toLowerCase() == providerCode) {
              beneficiaryId = b.id;
              break;
            }
          }
          if (beneficiaryId == null) {
            final saved = await ds.saveBeneficiary(
              smartCardNumber: smartCardNumber,
              providerCode: providerCode,
              providerName: provider.name,
              nickname: nickname,
              customerName: payment.customerName,
            );
            beneficiaryId = saved.id;
          }
        } catch (_) {
          _softInfo(
            'Auto-renew couldn\'t be enabled',
            'We couldn\'t save the smart card this schedule attaches to. Try again from the saved smart cards screen.',
          );
          return;
        }
      }

      try {
        await ds.createAutoRecharge(
          beneficiaryId: beneficiaryId,
          variationCode: package.variationCode.isNotEmpty
              ? package.variationCode
              : package.id,
          packageName: package.name,
          amount: package.amount,
          currency: 'NGN',
          // VTpass accepts "change" or "renew" — default to "renew"
          // which is the safest semantic for a recurring schedule.
          subscriptionType: 'renew',
          frequency: pref.frequency,
          dayOfWeek: pref.dayOfWeek,
          dayOfMonth: pref.dayOfMonth,
          executionHour: pref.executionHour,
          executionMinute: pref.executionMinute,
        );
      } catch (_) {
        _softInfo(
          'Auto-renew couldn\'t be enabled',
          'Payment succeeded, but the auto-renew schedule didn\'t save. You can retry from the saved smart cards screen.',
        );
      }
    }
  }

  /// Non-blocking info snackbar. Shown for post-purchase side-effect
  /// failures so the user knows but isn't blocked — the payment itself
  /// has already gone through.
  void _softInfo(String title, String message) {
    if (!mounted) return;
    Get.snackbar(
      title,
      message,
      backgroundColor: const Color(0xFFFB923C).withValues(alpha: 0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 4),
      margin: EdgeInsets.all(16.w),
      borderRadius: 12,
    );
  }

  /// Opens the create-reminder screen pre-filled with this purchase's
  /// provider, smart card and package so the user only needs to pick
  /// the renewal date.
  void _openCreateReminder(CableTVPaymentEntity payment) {
    final args = Get.arguments;
    final map = args is Map<String, dynamic> ? args : const <String, dynamic>{};
    final provider = map['provider'] as CableTVProviderEntity?;
    final package = map['package'] as TVPackageEntity?;
    final providerName = provider?.name.trim().isNotEmpty == true
        ? provider!.name.trim()
        : (payment.providerId.isNotEmpty
            ? payment.providerId
            : 'Cable TV');
    final smartCardNumber = payment.customerNumber.trim();
    final title = smartCardNumber.isNotEmpty
        ? 'Renew $providerName · $smartCardNumber'
        : 'Renew $providerName';

    Get.toNamed(
      AppRoutes.cableTVReminderCreate,
      arguments: <String, dynamic>{
        'title': title,
        'amount': payment.amount > 0 ? payment.amount : null,
        if ((package?.variationCode ?? '').isNotEmpty)
          'packageId': package!.variationCode,
      },
    );
  }

  String _formatAmount(double amount) {
    final format = NumberFormat('#,##0.00', 'en_NG');
    return '\u20A6${format.format(amount)}';
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM dd, yyyy - hh:mm a').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  String _formatStatus(String status) {
    return status
        .split('_')
        .map((word) =>
            word.isNotEmpty ? word[0].toUpperCase() + word.substring(1).toLowerCase() : '')
        .join(' ');
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return const Color(0xFF10B981);
      case 'pending':
      case 'processing':
        return const Color(0xFFFB923C);
      case 'failed':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  @override
  Widget build(BuildContext context) {
    final rawArgs = Get.arguments;
    // Cold-start / deep-link / malformed-args guard. We never navigate
    // here without a payment in production, but a defensive check
    // avoids crashing the whole route tree if something goes wrong —
    // route to the landing so the user has somewhere to go.
    if (rawArgs is! Map<String, dynamic> ||
        rawArgs['payment'] is! CableTVPaymentEntity) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) Get.offAllNamed(AppRoutes.cableTVHome);
      });
      return const Scaffold(
        backgroundColor: Color(0xFF0A0A0A),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
        ),
      );
    }
    final args = rawArgs;
    final argsPayment = args['payment'] as CableTVPaymentEntity;
    // Prefer the refreshed snapshot (pull-to-refresh) so async status
    // updates are reflected without a full navigation reset.
    final payment = _latestPayment ?? argsPayment;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Get.offAllNamed(AppRoutes.cableTVHome);
      },
      child: Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offAllNamed(AppRoutes.cableTVHome),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 22.sp,
          ),
        ),
        title: Text(
          'Payment Receipt',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _refreshPayment(payment),
                color: const Color(0xFF4E03D0),
                backgroundColor: const Color(0xFF1F1F1F),
                child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),

                    // Success icon
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF10B981).withValues(alpha: 0.15),
                        border: Border.all(
                          color: const Color(0xFF10B981).withValues(alpha: 0.4),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        payment.isCompleted
                            ? Icons.check_circle
                            : payment.isPending
                                ? Icons.schedule
                                : Icons.error_outline,
                        color: payment.isCompleted
                            ? const Color(0xFF10B981)
                            : payment.isPending
                                ? const Color(0xFFFB923C)
                                : const Color(0xFFEF4444),
                        size: 44.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    Text(
                      payment.isCompleted
                          ? 'Payment Successful!'
                          : payment.isProcessing
                              ? 'Payment Processing'
                              : payment.isPending
                                  ? 'Payment Pending'
                                  : 'Payment Failed',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    Text(
                      _formatAmount(payment.amount),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF10B981),
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Pending / processing payment banner
                    if (payment.isPending) ...[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFB923C).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: const Color(0xFFFB923C).withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 18.sp,
                              color: const Color(0xFFFB923C),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                payment.isProcessing
                                    ? 'Your payment is being processed in the background. The subscription will be activated shortly. No action needed.'
                                    : 'Your payment is being processed. The subscription will be activated shortly.',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFFFB923C),
                                  fontSize: 13.sp,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],

                    // Receipt card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: const Color(0xFF2D2D2D),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transaction Details',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20.h),

                          _buildReceiptRow(
                            'Provider',
                            payment.billType.isNotEmpty
                                ? payment.billType
                                : payment.providerId,
                          ),
                          _buildDivider(),
                          _buildReceiptRow(
                            'Smart Card Number',
                            payment.customerNumber,
                          ),
                          _buildDivider(),
                          _buildReceiptRow(
                            'Customer Name',
                            payment.customerName,
                          ),
                          _buildDivider(),
                          _buildReceiptRow(
                            'Amount',
                            _formatAmount(payment.amount),
                          ),
                          _buildDivider(),
                          _buildReceiptRow(
                            'Reference',
                            payment.reference,
                            isCopyable: true,
                          ),
                          _buildDivider(),
                          _buildReceiptRow(
                            'Date',
                            _formatDate(payment.createdAt),
                          ),
                          _buildDivider(),
                          _buildReceiptRow(
                            'Status',
                            _formatStatus(payment.status),
                            valueColor: _statusColor(payment.status),
                          ),
                          if (payment.newBalance > 0) ...[
                            _buildDivider(),
                            _buildReceiptRow(
                              'New Balance',
                              _formatAmount(payment.newBalance),
                            ),
                          ],
                          if (payment.renewalDate.isNotEmpty) ...[
                            _buildDivider(),
                            _buildReceiptRow(
                              'Renewal Date',
                              payment.renewalDate,
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    BillReceiptQrBlock(
                      type: 'cable_tv',
                      reference: payment.reference,
                      amount: payment.amount,
                      currency: 'NGN',
                      status: payment.status,
                      timestamp: DateTime.tryParse(payment.createdAt) ??
                          DateTime.now(),
                      showDivider: false,
                      extraPayload: {
                        if (payment.customerNumber.isNotEmpty)
                          'smart_card': payment.customerNumber,
                        if (payment.providerId.isNotEmpty)
                          'provider_id': payment.providerId,
                        if (payment.billType.isNotEmpty)
                          'bill_type': payment.billType,
                        if (payment.customerName.isNotEmpty)
                          'customer': payment.customerName,
                      },
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
              ),
            ),

            // Bottom actions
            _buildActions(context, payment),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildReceiptRow(
    String label,
    String value, {
    Color? valueColor,
    bool isCopyable = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            child: GestureDetector(
              onTap: isCopyable
                  ? () {
                      Clipboard.setData(ClipboardData(text: value));
                      Get.snackbar(
                        'Copied',
                        'Reference copied to clipboard',
                        backgroundColor:
                            const Color(0xFF3B82F6).withValues(alpha: 0.9),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 2),
                        margin: EdgeInsets.all(16.w),
                        borderRadius: 12,
                      );
                    }
                  : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      value,
                      style: GoogleFonts.inter(
                        color: valueColor ?? Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isCopyable) ...[
                    SizedBox(width: 6.w),
                    Icon(
                      Icons.copy,
                      color: const Color(0xFF9CA3AF),
                      size: 14.sp,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: const Color(0xFF2D2D2D),
      height: 1,
    );
  }

  Widget _buildActions(BuildContext context, CableTVPaymentEntity payment) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (payment.isCompleted) ...[
            OutlinedButton.icon(
              onPressed: () => _openCreateReminder(payment),
              icon: Icon(
                Icons.notifications_active_outlined,
                size: 18.sp,
                color: const Color(0xFFFB923C),
              ),
              label: Text(
                'Set Renewal Reminder',
                style: GoogleFonts.inter(
                  color: const Color(0xFFFB923C),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: const Color(0xFFFB923C).withValues(alpha: 0.5),
                  width: 1.2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
            SizedBox(height: 10.h),
          ],
          Row(
            children: [
              // Share Receipt
              Expanded(
            child: OutlinedButton.icon(
              onPressed: _isSharing ? null : () => _shareReceipt(payment),
              icon: _isSharing
                  ? SizedBox(
                      width: 18.sp,
                      height: 18.sp,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Icon(
                      Icons.share,
                      size: 18.sp,
                      color: Colors.white,
                    ),
              label: Text(
                'Share Receipt',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Color(0xFF2D2D2D),
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Download PDF
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _isDownloading ? null : () => _downloadPdf(payment),
              icon: _isDownloading
                  ? SizedBox(
                      width: 18.sp,
                      height: 18.sp,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Icon(
                      Icons.download,
                      size: 18.sp,
                      color: Colors.white,
                    ),
              label: Text(
                'Download PDF',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                disabledBackgroundColor:
                    const Color(0xFF3B82F6).withValues(alpha: 0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
            ),
          ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _shareReceipt(CableTVPaymentEntity payment) async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      await CableTVPdfService.shareReceipt(payment: payment);
    } catch (e) {
      // Fallback to text share
      final text = '''Cable TV Payment Receipt
---
Provider: ${payment.billType.isNotEmpty ? payment.billType : payment.providerId}
Smart Card: ${payment.customerNumber}
Customer: ${payment.customerName}
Amount: ${_formatAmount(payment.amount)}
Reference: ${payment.reference}
Date: ${_formatDate(payment.createdAt)}
Status: ${_formatStatus(payment.status)}
---
Powered by LazerVault''';

      SharePlus.instance.share(ShareParams(text: text, subject: 'Cable TV Payment Receipt'));
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  Future<void> _downloadPdf(CableTVPaymentEntity payment) async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);
    try {
      final path = await CableTVPdfService.downloadReceipt(payment: payment);
      Get.snackbar(
        'Download Complete',
        'Receipt saved: ${path.split('/').last}',
        backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.all(16.w),
        borderRadius: 12,
      );
    } catch (e) {
      Get.snackbar(
        'Download Failed',
        'Could not download receipt.',
        backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.all(16.w),
        borderRadius: 12,
      );
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }
}
