import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../widgets/bill_receipt_qr_block.dart';
import '../../domain/entities/data_plan_entity.dart';
import '../../domain/entities/data_purchase_entity.dart';
import '../cubit/auto_renew_cubit.dart';
import '../cubit/data_bundles_cubit.dart';
import '../../data/datasources/data_beneficiary_remote_datasource.dart';
import '../widgets/rollover_preference_sheet.dart';
import '../widgets/save_data_beneficiary_sheet.dart';
import '../../services/data_bundles_pdf_service.dart';

/// Data bundle purchase receipt. Mirrors the transfer send-funds receipt
/// layout: compact success icon, amount headline, status + timestamp row,
/// a single details card with the full breakdown plus a QR of the
/// transaction reference pinned to the bottom of the card.
///
/// Post-purchase hooks (save beneficiary, rollover/auto-renew) run once
/// on first frame — identical behaviour to the prior version, just in a
/// cleaner visual shell.
class DataPaymentReceiptScreen extends StatefulWidget {
  const DataPaymentReceiptScreen({super.key});

  @override
  State<DataPaymentReceiptScreen> createState() =>
      _DataPaymentReceiptScreenState();
}

class _DataPaymentReceiptScreenState extends State<DataPaymentReceiptScreen> {
  bool _isDownloading = false;
  bool _isSharing = false;
  late final AutoRenewCubit _autoRenewCubit;
  bool _autoRenewTriggered = false;

  /// Mutable copy of the purchase shown in the receipt. Seeded from
  /// `Get.arguments` on first build; pull-to-refresh replaces it with
  /// the latest version from the history cubit when the same reference
  /// lands with a different status (processing → completed, etc.) so
  /// the user sees the in-flight row settle without leaving the screen.
  DataPurchaseEntity? _purchase;
  bool _beneficiarySaved = false;

  @override
  void initState() {
    super.initState();
    _autoRenewCubit = GetIt.I<AutoRenewCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _runPostPurchaseHooks();
    });
  }

  /// Pull-to-refresh: ask the cubit for the latest history, find the
  /// row with our reference, and swap the displayed purchase in place.
  /// No-op if the row is gone (shouldn't happen) or unchanged — the
  /// RefreshIndicator's spinner hides on the same frame so short-
  /// circuiting here is safe.
  Future<void> _refreshPurchase() async {
    if (!mounted) return;
    final current = _purchase ?? _argsPurchase();
    if (current == null) return;
    final cubit = context.read<DataBundlesCubit>();
    await cubit.loadDataPurchaseHistory(limit: 50);
    if (!mounted) return;
    final list = cubit.cachedPurchases;
    if (list == null) return;
    for (final p in list) {
      if (p.id == current.id ||
          (p.reference.isNotEmpty && p.reference == current.reference)) {
        if (p == current) return;
        setState(() => _purchase = p);
        return;
      }
    }
  }

  DataPurchaseEntity? _argsPurchase() {
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      final v = args['purchase'];
      if (v is DataPurchaseEntity) return v;
    }
    return null;
  }

  /// Resolve a carrier's display name from a network code, so we never
  /// persist a literal "Unknown" placeholder on a saved beneficiary.
  /// Returns empty when the code is unrecognised — caller refuses to
  /// save in that case.
  String _resolveNetworkName(String networkCode, String networkName) {
    if (networkName.isNotEmpty &&
        networkName.toLowerCase() != 'unknown') {
      return networkName;
    }
    final code = networkCode.toUpperCase().replaceAll('-DATA', '');
    switch (code) {
      case 'MTN':
        return 'MTN';
      case 'AIRTEL':
        return 'Airtel';
      case 'GLO':
        return 'Glo';
      case 'ETISALAT':
      case '9MOBILE':
        return '9mobile';
      default:
        return '';
    }
  }

  /// Save-as-beneficiary + rollover hand-offs that the confirmation
  /// screen deferred. Only runs on completed purchases so we don't
  /// schedule rollovers off a pending/failed row. Each side is
  /// independent — a failure in one must not block the other.
  Future<void> _runPostPurchaseHooks() async {
    if (_autoRenewTriggered) return;
    final args = Get.arguments as Map<String, dynamic>?;
    if (args == null) return;
    final purchase = args['purchase'] as DataPurchaseEntity?;
    if (purchase == null || !purchase.isCompleted) return;
    _autoRenewTriggered = true;

    final plan = args['plan'] as DataPlanEntity?;
    final network = args['network'] as String? ?? '';
    final phoneNumber = args['phoneNumber'] as String? ?? purchase.phoneNumber;
    final saveBeneficiary = args['saveBeneficiary'] as bool? ?? false;
    final autoRenewEnabled = args['autoRenewEnabled'] as bool? ?? false;
    final rolloverPref = args['rolloverPreference'] as RolloverPreference?;

    String? beneficiaryId;
    if (saveBeneficiary && phoneNumber.isNotEmpty) {
      try {
        final rawName = args['networkName'] as String? ?? '';
        final networkName = _resolveNetworkName(network, rawName);
        // Skip save rather than store a placeholder — the beneficiary
        // list treats a missing networkName as "Unknown" which is
        // confusing, and the Buy Data action downstream needs the code
        // to route anyway.
        if (network.isNotEmpty && networkName.isNotEmpty) {
          final ds = GetIt.I<DataBeneficiaryRemoteDataSource>();
          final saved = await ds.saveBeneficiary(
            phoneNumber: phoneNumber,
            networkCode: network,
            networkName: networkName,
          );
          beneficiaryId = saved.id;
        }
      } catch (_) {
        // Silent fail — user can save manually from the beneficiary list.
      }
    }

    if (rolloverPref != null && plan != null && purchase.id.isNotEmpty) {
      if (rolloverPref.mode == RolloverMode.renewOnExpiry) {
        _autoRenewCubit.enableAutoRenew(
          subscriptionId: purchase.id,
          variationId: plan.variationId,
          network: network,
          amount: plan.price,
        );
      } else if (rolloverPref.mode == RolloverMode.recurringSchedule &&
          beneficiaryId != null) {
        try {
          final ds = GetIt.I<DataBeneficiaryRemoteDataSource>();
          await ds.createAutoRecharge(
            beneficiaryId: beneficiaryId,
            variationId: plan.variationId,
            planName: plan.name,
            amount: plan.price,
            currency: 'NGN',
            frequency: rolloverPref.frequency,
            dayOfWeek: rolloverPref.dayOfWeek,
            dayOfMonth: rolloverPref.dayOfMonth,
            executionHour: rolloverPref.executionHour,
          );
        } catch (_) {
          // User can retry from the auto-recharge management screen.
        }
      }
    } else if (autoRenewEnabled && plan != null && purchase.id.isNotEmpty) {
      // Legacy callers that pass only a bool — keep them working.
      _autoRenewCubit.enableAutoRenew(
        subscriptionId: purchase.id,
        variationId: plan.variationId,
        network: network,
        amount: plan.price,
      );
    }
  }

  @override
  void dispose() {
    if (!_autoRenewCubit.isClosed) _autoRenewCubit.close();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Formatting
  // ---------------------------------------------------------------------------

  String _formatAmount(double amount) {
    final format = NumberFormat('#,##0.00', 'en_NG');
    return '\u20A6${format.format(amount)}';
  }

  DateTime _parsedTimestamp(DataPurchaseEntity p) {
    final parsed = DateTime.tryParse(p.createdAt);
    return parsed ?? DateTime.now();
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  String _formatTime(DateTime d) =>
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  /// Receipt renders one of five user-facing categories — [_statusColor]
  /// and [_statusIcon] key off the same bucket to stay in sync with the
  /// history list's chip. The raw backend status (e.g. `awaiting_webhook`)
  /// never reaches the UI; [DataPurchaseEntity.displayStatus] already
  /// collapses webhook/verification states to "Processing".
  Color _statusColor(DataPurchaseEntity p) {
    switch (p.statusCategory) {
      case DataPurchaseStatusCategory.completed:
        return const Color(0xFF10B981);
      case DataPurchaseStatusCategory.processing:
      case DataPurchaseStatusCategory.pending:
        return const Color(0xFFFB923C);
      case DataPurchaseStatusCategory.failed:
        return const Color(0xFFEF4444);
      case DataPurchaseStatusCategory.refunded:
        return const Color(0xFF6B7280);
    }
  }

  IconData _statusIcon(DataPurchaseEntity p) {
    switch (p.statusCategory) {
      case DataPurchaseStatusCategory.completed:
        return Icons.check;
      case DataPurchaseStatusCategory.processing:
      case DataPurchaseStatusCategory.pending:
        return Icons.schedule;
      case DataPurchaseStatusCategory.refunded:
        return Icons.undo;
      case DataPurchaseStatusCategory.failed:
        return Icons.error_outline;
    }
  }

  String _headline(DataPurchaseEntity p) {
    switch (p.statusCategory) {
      case DataPurchaseStatusCategory.completed:
        return 'Data Purchase Successful';
      case DataPurchaseStatusCategory.processing:
      case DataPurchaseStatusCategory.pending:
        return 'Data Purchase Pending';
      case DataPurchaseStatusCategory.refunded:
        return 'Data Purchase Refunded';
      case DataPurchaseStatusCategory.failed:
        return 'Data Purchase Failed';
    }
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final purchase = _purchase ?? args['purchase'] as DataPurchaseEntity;
    // Prefer the explicit arg (fresh purchase flow sends it), then the
    // metadata stored server-side at purchase time (migration 2026-04:
    // backend now writes metadata.plan_name), then the variation code
    // as a last-resort. This makes the receipt render the full plan
    // label "MTN 10MB - 1 Day N100" even when the history row re-opens
    // the receipt days later with just the purchase entity in hand.
    final meta = purchase.metadataMap;
    final networkName = (args['networkName'] as String?)?.trim().isNotEmpty == true
        ? args['networkName'] as String
        : (meta['network_name']?.toString() ?? '');
    final planName = (args['planName'] as String?)?.trim().isNotEmpty == true
        ? args['planName'] as String
        : (meta['plan_name']?.toString().trim().isNotEmpty == true
            ? meta['plan_name'].toString()
            : purchase.dataPlan);
    final autoRenewEnabled = args['autoRenewEnabled'] as bool? ?? false;
    final timestamp = _parsedTimestamp(purchase);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              // Pull-to-refresh picks up a status flip (processing →
              // completed/failed) without the user needing to bounce
              // back to history. Uses AlwaysScrollableScrollPhysics so
              // the swipe-down gesture still triggers on a short
              // receipt.
              child: RefreshIndicator(
                color: const Color(0xFF4E03D0),
                backgroundColor: const Color(0xFF1F1F1F),
                onRefresh: _refreshPurchase,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 8.h),
                      _buildHeader(purchase, timestamp),
                      if (autoRenewEnabled && purchase.isCompleted) ...[
                        SizedBox(height: 12.h),
                        _buildAutoRenewBadge(),
                      ],
                      if (purchase.isPending) ...[
                        SizedBox(height: 16.h),
                        _buildPendingBanner(),
                      ],
                      SizedBox(height: 16.h),
                      _buildTransactionDetails(
                        purchase: purchase,
                        networkName: networkName,
                        planName: planName,
                        timestamp: timestamp,
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
            _buildActions(purchase, networkName, planName),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 2.h, 12.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            // Back from the receipt lands on the data-bundles landing, not
            // the bills hub — users deep in the data flow expect to return
            // to the scope they started in, and the hub is one more tap
            // away from there anyway.
            onPressed: () => Get.offAllNamed(AppRoutes.dataBundlesHome),
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          Image.asset(
            'assets/images/logo.png',
            width: 28.w,
            height: 28.w,
            errorBuilder: (_, __, ___) => Icon(
              Icons.shield_outlined,
              color: const Color(0xFF3B82F6),
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(DataPurchaseEntity p, DateTime timestamp) {
    final color = _statusColor(p);
    return Column(
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(_statusIcon(p), color: Colors.white, size: 26.sp),
        ),
        SizedBox(height: 10.h),
        Text(
          _formatAmount(p.amount),
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          _headline(p),
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              p.displayStatus,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF8E8E93),
              ),
            ),
            SizedBox(width: 8.w),
            Text('\u00b7',
                style: GoogleFonts.inter(
                    fontSize: 14.sp, color: const Color(0xFF8E8E93))),
            SizedBox(width: 8.w),
            Text(
              '${_formatDate(timestamp)} ${_formatTime(timestamp)}',
              style: GoogleFonts.inter(
                  fontSize: 12.sp, color: const Color(0xFF8E8E93)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAutoRenewBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.autorenew,
              color: const Color(0xFF10B981), size: 18.sp),
          SizedBox(width: 8.w),
          Text(
            'Non-Expiring Data Enabled',
            style: GoogleFonts.inter(
              color: const Color(0xFF10B981),
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingBanner() {
    return Container(
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
          Icon(Icons.info_outline,
              size: 18.sp, color: const Color(0xFFFB923C)),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Your data purchase is being processed. The bundle will be activated shortly.',
              style: GoogleFonts.inter(
                color: const Color(0xFFFB923C),
                fontSize: 13.sp,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetails({
    required DataPurchaseEntity purchase,
    required String networkName,
    required String planName,
    required DateTime timestamp,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 0),
            child: Text(
              'Details',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 14.h),
          // `networkName` on intl rows is the country label resolved by
          // the history-actions sheet (country name → dest currency →
          // fallback). Using the same field keeps the layout identical
          // across local and intl rows — the variant-specific rows are
          // appended below.
          _buildDetailRow(
              purchase.isInternational ? 'Country' : 'Network', networkName),
          _buildDetailRow('Data Plan', planName),
          _buildDetailRow('Phone', purchase.phoneNumber),
          _buildDetailRow('Amount', _formatAmount(purchase.amount)),
          // Intl payload — destination amount, FX rate, operator come
          // from the backend `metadata` JSON on the bill row. Only
          // render rows with real values; the intl screen used to show
          // all of them as "—" when missing which read as broken data.
          ..._buildIntlRows(purchase),
          _buildDetailRow(
            'Status',
            purchase.displayStatus,
            valueColor: _statusColor(purchase),
          ),
          if (purchase.newBalance > 0)
            _buildDetailRow('New Balance', _formatAmount(purchase.newBalance)),
          if (purchase.providerReference.isNotEmpty)
            _buildDetailRow('Provider Ref', purchase.providerReference),
          _buildDetailRow('Reference', purchase.reference, copyable: true),
          _buildDetailRow(
            'Date',
            DateFormat('MMM dd, yyyy · hh:mm a').format(timestamp),
          ),
          SizedBox(height: 4.h),
          BillReceiptQrBlock(
            type: 'data',
            reference: purchase.reference,
            amount: purchase.amount,
            currency: 'NGN',
            status: purchase.status,
            timestamp: timestamp,
            extraPayload: {
              'phone': purchase.phoneNumber,
              if (networkName.isNotEmpty) 'network': networkName,
              if (planName.isNotEmpty) 'plan': planName,
            },
          ),
          SizedBox(height: 14.h),
        ],
      ),
    );
  }

  /// Intl-specific detail rows — destination amount, destination
  /// currency, FX rate, operator. Read from the entity's metadata map
  /// (populated by the backend for `intl_data` bill rows). Rows with
  /// missing values are skipped rather than rendered as dashes so the
  /// card doesn't telegraph missing data.
  List<Widget> _buildIntlRows(DataPurchaseEntity p) {
    if (!p.isInternational) return const [];
    final meta = p.metadataMap;
    final out = <Widget>[];
    final destAmt = p.destAmount;
    final destCur = p.destCurrency;
    if (destAmt != null && destAmt > 0 && destCur.isNotEmpty) {
      out.add(_buildDetailRow(
        'Recipient got',
        '$destCur ${destAmt.toStringAsFixed(2)}',
      ));
    }
    final fx = meta['fx_rate_used'] ?? meta['fx_rate'];
    if (fx is num && fx > 0 && destCur.isNotEmpty) {
      final sender =
          (meta['sender_currency'] ?? meta['senderCurrency'])?.toString() ??
              'NGN';
      out.add(_buildDetailRow(
        'FX rate',
        '1 $destCur = ${fx.toStringAsFixed(4)} $sender',
      ));
    }
    final op = meta['operator_name'] ?? meta['operatorName'];
    if (op is String && op.isNotEmpty) {
      out.add(_buildDetailRow('Operator', op));
    }
    return out;
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    Color? valueColor,
    bool copyable = false,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110.w,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFF8E8E93),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: copyable
                  ? () {
                      Clipboard.setData(ClipboardData(text: value));
                      Get.snackbar(
                        'Copied',
                        'Reference copied to clipboard',
                        backgroundColor: const Color(0xFF3B82F6)
                            .withValues(alpha: 0.9),
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      value,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: valueColor ?? Colors.white,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (copyable) ...[
                    SizedBox(width: 6.w),
                    Icon(Icons.copy,
                        color: const Color(0xFF9CA3AF), size: 14.sp),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  Widget _buildActions(
    DataPurchaseEntity purchase,
    String networkName,
    String planName,
  ) {
    // Save-as-beneficiary only makes sense once the purchase cleared —
    // a failed/refunded row means the number might not even be valid,
    // so saving it as a contact would just sow confusion. International
    // rows have their own saved-contact flow (not wired here), so the
    // button stays scoped to local NGN rows for now.
    final canSaveContact = purchase.isCompleted &&
        !purchase.isInternational &&
        purchase.phoneNumber.isNotEmpty &&
        !_beneficiarySaved;
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 12.h),
      child: Row(
        children: [
          Expanded(
            child: _actionButton(
              icon: _isDownloading ? null : Icons.download_outlined,
              label: 'Download',
              isLoading: _isDownloading,
              onTap: _isDownloading
                  ? () {}
                  : () => _downloadPdf(purchase, networkName, planName),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _actionButton(
              icon: _isSharing ? null : Icons.share_outlined,
              label: 'Share',
              isLoading: _isSharing,
              onTap: _isSharing
                  ? () {}
                  : () => _shareReceipt(purchase, networkName, planName),
            ),
          ),
          if (canSaveContact) ...[
            SizedBox(width: 12.w),
            Expanded(
              child: _actionButton(
                icon: Icons.person_add_alt_outlined,
                label: 'Save',
                onTap: () => _openSaveBeneficiarySheet(purchase, networkName),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Opens the save-data-beneficiary sheet with fields pre-populated
  /// from the receipt payload. Cancel pops the sheet with `false` and
  /// leaves local state untouched; a successful save flips
  /// `_beneficiarySaved` so the button disappears (no re-save button on
  /// the same receipt) and surfaces a confirmation snackbar.
  Future<void> _openSaveBeneficiarySheet(
    DataPurchaseEntity purchase,
    String networkName,
  ) async {
    final args = Get.arguments as Map<String, dynamic>? ?? const {};
    final network = args['network'] as String? ?? purchase.networkCode;
    final resolvedName = _resolveNetworkName(
      network,
      networkName.isNotEmpty ? networkName : purchase.networkName,
    );
    if (network.isEmpty && resolvedName.isEmpty) {
      Get.snackbar(
        'Cannot save',
        "We couldn't identify the network for this number.",
        backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      return;
    }
    final saved = await SaveDataBeneficiarySheet.show(
      context,
      phoneNumber: purchase.phoneNumber,
      networkCode: network,
      networkName: resolvedName,
    );
    if (!mounted) return;
    if (saved == true) {
      setState(() => _beneficiarySaved = true);
      Get.snackbar(
        'Saved',
        'Added to your data contacts',
        backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        margin: EdgeInsets.all(16.w),
        borderRadius: 12,
      );
    }
  }

  Widget _actionButton({
    IconData? icon,
    required String label,
    required VoidCallback onTap,
    bool isLoading = false,
  }) {
    return Material(
      color: const Color(0xFF1F1F1F),
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox(
                  width: 16.sp,
                  height: 16.sp,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              else if (icon != null)
                Icon(icon, color: Colors.white, size: 18.sp),
              if (!isLoading && icon != null) SizedBox(width: 8.w),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _shareReceipt(
    DataPurchaseEntity purchase,
    String networkName,
    String planName,
  ) async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      await DataBundlesPdfService.shareReceipt(
        purchase: purchase,
        network: networkName,
        planName: planName,
      );
    } catch (e) {
      final text = '''Data Bundle Purchase Receipt
---
Network: $networkName
Plan: $planName
Phone: ${purchase.phoneNumber}
Amount: ${_formatAmount(purchase.amount)}
Reference: ${purchase.reference}
Date: ${DateFormat('MMM dd, yyyy · hh:mm a').format(_parsedTimestamp(purchase))}
Status: ${purchase.displayStatus}
---
Powered by LazerVault''';
      SharePlus.instance.share(
        ShareParams(text: text, subject: 'Data Bundle Purchase Receipt'),
      );
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  Future<void> _downloadPdf(
    DataPurchaseEntity purchase,
    String networkName,
    String planName,
  ) async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);
    try {
      final path = await DataBundlesPdfService.downloadReceipt(
        purchase: purchase,
        network: networkName,
        planName: planName,
      );
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
