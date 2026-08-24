import 'dart:async';

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
import '../../data/datasources/internet_beneficiary_remote_datasource.dart';
import '../../data/datasources/internet_bill_remote_datasource.dart';
import '../../domain/entities/internet_package_entity.dart';
import '../../domain/entities/internet_payment_entity.dart';
import '../../domain/entities/internet_provider_entity.dart';
import '../../services/internet_bill_pdf_service.dart';
import '../widgets/internet_rollover_preference_sheet.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class InternetPaymentReceiptScreen extends StatefulWidget {
  const InternetPaymentReceiptScreen({super.key});

  @override
  State<InternetPaymentReceiptScreen> createState() =>
      _InternetPaymentReceiptScreenState();
}

class _InternetPaymentReceiptScreenState
    extends State<InternetPaymentReceiptScreen> {
  bool _isDownloading = false;
  bool _isSharing = false;
  bool _postPurchaseRan = false;

  /// Latest payment snapshot, refreshed via pull-to-refresh + bounded poll so
  /// a `processing` payment reconciles (processing → completed/failed) without
  /// the user having to navigate away. Overrides the initial [Get.arguments]
  /// payload in the build. Mirrors the cable receipt.
  InternetPaymentEntity? _latestPayment;
  bool _isRefreshing = false;

  // Bounded auto-poll while the payment is pending (webhook may land after the
  // pay response). Mirrors the epin receipt's poll.
  Timer? _pollTimer;
  int _pollCount = 0;
  static const _maxPolls = 15;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _runPostPurchaseActions();
      _maybeStartPolling();
    });
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  InternetPaymentEntity? _argsPayment() {
    final args = Get.arguments;
    if (args is! Map<String, dynamic>) return null;
    return args['payment'] as InternetPaymentEntity?;
  }

  void _maybeStartPolling() {
    if (_pollTimer != null) return;
    final payment = _latestPayment ?? _argsPayment();
    if (payment == null || !payment.isPending) return;
    _pollTimer = Timer.periodic(const Duration(seconds: 4), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      _pollCount++;
      final current = _latestPayment ?? _argsPayment();
      if (current == null || !current.isPending || _pollCount >= _maxPolls) {
        t.cancel();
        _pollTimer = null;
        return;
      }
      _refreshPayment(current);
    });
  }

  /// Re-fetches internet payment history and swaps in the row matching the
  /// current reference/id. Preserves newBalance/renewalDate from the original
  /// pay response (the history endpoint doesn't surface them). On a flip out
  /// of pending, stops the poll and re-runs post-purchase actions if completed.
  Future<void> _refreshPayment(InternetPaymentEntity current) async {
    if (_isRefreshing) return;
    _isRefreshing = true;
    try {
      final remote = GetIt.I<InternetBillRemoteDataSource>();
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
      final wasPending = current.isPending;
      final updated = InternetPaymentEntity(
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
      );
      setState(() => _latestPayment = updated);
      if (wasPending && !updated.isPending) {
        _pollTimer?.cancel();
        _pollTimer = null;
        // Honour save-beneficiary / rollover toggles skipped while pending.
        if (updated.isCompleted && !_postPurchaseRan) {
          _runPostPurchaseActions();
        }
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

  /// Save beneficiary + enable rollover if the confirm screen asked for
  /// them. Runs once on first build — guarded by [_postPurchaseRan] so
  /// widget rebuilds don't trigger duplicate RPCs. Both calls hit the
  /// real backend (commerce-gateway → utility-payments-service) — no
  /// fake-success shortcuts.
  ///
  /// Policy (2026-04-18): strict gate on `isCompleted`. We never save
  /// on pending/processing — that would leave stale beneficiaries /
  /// rollover schedules if the payment later fails. If the user closes
  /// the receipt before the async consumer terminates the payment, they
  /// re-enable the toggles on their next purchase. Trade-off accepted
  /// over leaving partial data in the DB.
  Future<void> _runPostPurchaseActions() async {
    if (_postPurchaseRan) return;

    final args = Get.arguments as Map<String, dynamic>?;
    if (args == null) return;
    // Prefer the reconciled snapshot so a payment that flipped
    // processing → completed via pull-to-refresh / poll still honours the
    // save-beneficiary / rollover toggles.
    final payment =
        _latestPayment ?? (args['payment'] as InternetPaymentEntity?);
    if (payment == null) return;
    // Don't consume the guard while pending — the poll re-invokes this once
    // the status flips to completed.
    if (!payment.isCompleted) return;
    _postPurchaseRan = true;

    final provider = args['provider'] as InternetProviderEntity?;
    final package = args['package'] as InternetPackageEntity?;
    final accountNumber = args['accountNumber'] as String?;
    final saveBeneficiary = (args['saveBeneficiary'] as bool?) ?? false;
    final nickname = args['beneficiaryNickname'] as String?;
    // Already-saved account: the QuickBuy resolved the existing beneficiary, so
    // reuse its id (skip the duplicate save) and still attach any auto-renew.
    final existingBeneficiaryId = args['existingBeneficiaryId'] as String?;
    final autoRenewEnabled = (args['autoRenewEnabled'] as bool?) ?? false;
    final pref = args['rolloverPref'] as InternetRolloverPreference?;

    if (provider == null || package == null || accountNumber == null) return;
    if (!saveBeneficiary && !autoRenewEnabled) return;

    final providerCode = _providerCodeFor(provider.serviceId);
    final ds = GetIt.I<InternetBeneficiaryRemoteDataSource>();

    // --- Save beneficiary (or reuse existing) ---
    String? beneficiaryId = existingBeneficiaryId;
    if (saveBeneficiary && beneficiaryId == null && accountNumber.isNotEmpty) {
      try {
        final saved = await ds.saveBeneficiary(
          accountNumber: accountNumber,
          providerCode: providerCode,
          providerName: provider.name,
          nickname: nickname,
        );
        beneficiaryId = saved.id;
      } catch (_) {
        // Duplicate — fall through and look up the existing row.
        try {
          final list = await ds.getBeneficiaries(providerCode: providerCode);
          for (final b in list) {
            if (b.accountNumber == accountNumber &&
                b.providerCode == providerCode) {
              beneficiaryId = b.id;
              break;
            }
          }
        } catch (_) {
          _softInfo(
            'Beneficiary save failed',
            'We couldn\'t save this contact. You can save it manually from the beneficiaries screen.',
          );
        }
      }
    }

    // --- Create rollover (auto-recharge) ---
    // Outer gate already ensures the payment is completed.
    if (autoRenewEnabled && pref != null) {
      // Refuse zero-amount rollover up-front; backend would reject it
      // anyway (`amount must be greater than 0`).
      if (package.amount <= 0) {
        _softInfo(
          'Rollover skipped',
          'This plan has no amount set, so we can\'t schedule a recurring charge.',
        );
        return;
      }
      // Beneficiary is required for rollover. If the user didn't save
      // one explicitly, upsert silently so the auto-recharge has
      // something to attach to.
      if (beneficiaryId == null) {
        try {
          final list = await ds.getBeneficiaries(providerCode: providerCode);
          for (final b in list) {
            if (b.accountNumber == accountNumber &&
                b.providerCode == providerCode) {
              beneficiaryId = b.id;
              break;
            }
          }
          if (beneficiaryId == null) {
            final saved = await ds.saveBeneficiary(
              accountNumber: accountNumber,
              providerCode: providerCode,
              providerName: provider.name,
              nickname: nickname,
            );
            beneficiaryId = saved.id;
          }
        } catch (_) {
          _softInfo(
            'Rollover couldn\'t be enabled',
            'We couldn\'t save the beneficiary this rollover attaches to. Try again from the beneficiaries screen.',
          );
          return;
        }
      }

      try {
        await ds.createAutoRecharge(
          beneficiaryId: beneficiaryId,
          packageId: package.id,
          planName: package.name,
          amount: package.amount,
          currency: 'NGN',
          frequency: pref.frequency,
          dayOfWeek: pref.dayOfWeek,
          dayOfMonth: pref.dayOfMonth,
          executionHour: pref.executionHour,
          executionMinute: pref.executionMinute,
        );
      } catch (_) {
        _softInfo(
          'Rollover couldn\'t be enabled',
          'Payment succeeded, but the rollover schedule didn\'t save. You can retry from the beneficiaries screen.',
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

  String _providerCodeFor(String serviceId) {
    switch (serviceId.toLowerCase()) {
      case 'smile-direct':
      case 'smile':
        return 'SMILE';
      case 'spectranet':
        return 'SPECTRANET';
      case 'ipnx':
      case 'ipnx1515':
        return 'IPNX';
      case 'swift4g':
      case 'swift':
        return 'SWIFT';
      default:
        return serviceId.toUpperCase();
    }
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
        return const Color(0xFFFB923C);
      case 'failed':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final argsPayment = args['payment'] as InternetPaymentEntity;
    // Prefer the refreshed snapshot (pull-to-refresh / poll) so async status
    // updates are reflected without a full navigation reset.
    final payment = _latestPayment ?? argsPayment;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Get.offAllNamed(AppRoutes.internetBillHome);
      },
      child: Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offAllNamed(AppRoutes.internetBillHome),
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

                    // Pending payment banner
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
                                'Your payment is being processed. The internet package will be activated shortly.',
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
                            'Account Number',
                            payment.customerNumber,
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
                      type: 'internet',
                      reference: payment.reference,
                      amount: payment.amount,
                      currency: 'NGN',
                      status: payment.status,
                      timestamp:
                          DateTime.tryParse(payment.createdAt) ??
                              DateTime.now(),
                      showDivider: false,
                      extraPayload: {
                        if (payment.customerNumber.isNotEmpty)
                          'account': payment.customerNumber,
                        if (payment.providerId.isNotEmpty)
                          'provider_id': payment.providerId,
                        if (payment.billType.isNotEmpty)
                          'bill_type': payment.billType,
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
                            const Color(0xFF4E03D0).withValues(alpha: 0.9),
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

  Widget _buildActions(BuildContext context, InternetPaymentEntity payment) {
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
                color: const Color(0xFF4E03D0),
              ),
              label: Text(
                'Set Renewal Reminder',
                style: GoogleFonts.inter(
                  color: const Color(0xFF4E03D0),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.5),
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
                  ? LazerVaultLoader(size: 18)
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
                  ? LazerVaultLoader(size: 18)
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
                backgroundColor: const Color(0xFF4E03D0),
                disabledBackgroundColor:
                    const Color(0xFF4E03D0).withValues(alpha: 0.4),
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

  /// Opens the create-reminder screen pre-filled with this purchase's
  /// provider, account and package so the user only needs to pick the
  /// renewal date. Null-safe — if Get.arguments is missing provider or
  /// package we still navigate with sensible fallbacks rather than
  /// crash on a cold-start receipt route.
  void _openCreateReminder(InternetPaymentEntity payment) {
    final args = Get.arguments;
    final map = args is Map<String, dynamic> ? args : const <String, dynamic>{};
    final provider = map['provider'] as InternetProviderEntity?;
    final package = map['package'] as InternetPackageEntity?;
    final providerName = provider?.name.trim().isNotEmpty == true
        ? provider!.name.trim()
        : (payment.providerId.isNotEmpty
            ? payment.providerId
            : 'Internet');
    final accountNumber = payment.customerNumber.trim();
    final title = accountNumber.isNotEmpty
        ? 'Renew $providerName \u00B7 $accountNumber'
        : 'Renew $providerName';

    Get.toNamed(
      AppRoutes.internetBillReminderCreate,
      arguments: <String, dynamic>{
        'title': title,
        'amount': payment.amount > 0 ? payment.amount : null,
        if ((package?.id ?? '').isNotEmpty) 'packageId': package!.id,
      },
    );
  }

  Future<void> _shareReceipt(InternetPaymentEntity payment) async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      await InternetBillPdfService.shareReceipt(payment: payment);
    } catch (e) {
      // Fallback to text share
      final text = '''Internet Bill Payment Receipt
---
Provider: ${payment.billType.isNotEmpty ? payment.billType : payment.providerId}
Account Number: ${payment.customerNumber}
Amount: ${_formatAmount(payment.amount)}
Reference: ${payment.reference}
Date: ${_formatDate(payment.createdAt)}
Status: ${_formatStatus(payment.status)}
---
Powered by Lazervault''';

      SharePlus.instance.share(ShareParams(
        // iOS: a non-zero popover anchor is required — CGRectZero throws
        // PlatformException and the share silently fails on iPhone/iPad.
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),text: text, subject: 'Internet Bill Payment Receipt'));
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  Future<void> _downloadPdf(InternetPaymentEntity payment) async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);
    try {
      final path = await InternetBillPdfService.downloadReceipt(payment: payment);
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
