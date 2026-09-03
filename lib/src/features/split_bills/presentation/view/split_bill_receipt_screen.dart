import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/pending_actions/presentation/cubit/pending_actions_cubit.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/services/injection_container.dart';
import '../../domain/entities/split_bill_entity.dart';
import '../../domain/repositories/split_bill_repository.dart';
import '../../services/split_bill_pdf_service.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class SplitBillReceiptScreen extends StatefulWidget {
  const SplitBillReceiptScreen({super.key});

  @override
  State<SplitBillReceiptScreen> createState() => _SplitBillReceiptScreenState();
}

class _SplitBillReceiptScreenState extends State<SplitBillReceiptScreen> {
  late final String transactionReference;
  late final double amount;
  late final String currency;
  late final String creatorName;
  late final String receiverName;

  /// Masked destination account for an external-bank receiver ("•••• 1234").
  /// Empty for internal/legacy bills, where there is no bank account to name.
  late final String receiverAccountMasked;

  /// Destination bank for an external receiver. Empty for internal receivers
  /// and for bills created before it was captured.
  late final String receiverBankName;
  late final String description;
  int paidCount = 0;
  int totalParticipants = 0;
  // Authoritative (bill-derived) fields — null/'Paid' when built from legacy args.
  DateTime? _paidAt;
  String _statusLabel = 'Paid';
  bool _authoritative = false;
  // For pull-to-refresh: re-fetch the bill and update the payer's live status
  // (in_progress → paid once the external payout confirms).
  String? _billId;
  String? _payerUserId;
  bool _refreshing = false;
  // When opened to VIEW an existing payer's receipt (from the detail sheet),
  // Done/back returns to the previous screen instead of resetting to the bills
  // list (which is the correct behavior only after just paying).
  bool _viewOnly = false;
  bool _isDownloading = false;
  bool _isSharing = false;

  /// Who the payment went to. Prefer an explicit receiver name passed from the
  /// pay screen; fall back to the creator for legacy bills where the creator
  /// collects.
  String get _paidToName =>
      receiverName.isNotEmpty ? receiverName : creatorName;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final bill = args['bill'];
    final payerUserId = args['payerUserId'] as String?;
    _viewOnly = args['viewOnly'] == true;
    // A freshly-paid share is no longer outstanding. Guarded on _viewOnly:
    // this same screen doubles as a read-only receipt viewer, where nothing
    // changed and a refetch would be pure noise.
    if (!_viewOnly) refreshPendingActions();

    // Preferred path: derive every field from the authoritative bill + the
    // target payer's participant record (real paidAt / reference / status /
    // amount / payee). Falls back to the legacy scalar args for back-compat.
    if (bill is SplitBillEntity &&
        payerUserId != null &&
        payerUserId.isNotEmpty) {
      final p = bill.participantForUser(payerUserId);
      _authoritative = true;
      _billId = bill.id;
      _payerUserId = payerUserId;
      amount = p?.amount ?? 0.0;
      currency = bill.currency;
      creatorName = bill.creatorName;
      receiverName = bill.receiverDisplay; // bill-authoritative payee
      // Only external receivers have a bank account. maskReceiverAccount()
      // returns the DISPLAY NAME for internal ones, so using it unguarded
      // would print the payee's name twice, once labelled "Account".
      receiverAccountMasked =
          bill.hasExternalReceiver ? bill.receiverAccountMasked : '';
      receiverBankName = bill.hasExternalReceiver ? bill.receiverBankName : '';
      description = bill.description;
      transactionReference = (p?.transactionReference != null &&
              p!.transactionReference!.isNotEmpty)
          ? p.transactionReference!
          : bill.reference;
      paidCount = bill.paidCount;
      totalParticipants = bill.totalParticipants;
      _paidAt = p?.paidAt;
      _statusLabel = _statusText(p?.status);
    } else {
      transactionReference = args['transactionReference'] as String? ?? '';
      amount = (args['amount'] as num?)?.toDouble() ?? 0.0;
      currency = args['currency'] as String? ?? 'NGN';
      creatorName = args['creatorName'] as String? ?? 'Unknown';
      receiverName = args['receiverName'] as String? ?? '';
      receiverAccountMasked = args['receiverAccountMasked'] as String? ?? '';
      receiverBankName = args['receiverBankName'] as String? ?? '';
      description = args['description'] as String? ?? '';
      paidCount = args['paidCount'] as int? ?? 0;
      totalParticipants = args['totalParticipants'] as int? ?? 0;
    }
  }

  /// Leaves the receipt: pop back when just viewing an existing payer's receipt,
  /// otherwise (post-payment flow) reset to the split-bills list.
  void _closeReceipt() {
    if (_viewOnly) {
      Get.back();
    } else {
      Get.offAllNamed(AppRoutes.splitBills);
    }
  }

  /// Pull-to-refresh: re-fetch the bill and update this payer's live status
  /// (e.g. in_progress → paid once the external payout confirms). No-op for
  /// legacy receipts opened without a bill id.
  Future<void> _refresh() async {
    if (_billId == null || _payerUserId == null || _refreshing) return;
    setState(() => _refreshing = true);
    try {
      final repo = serviceLocator<SplitBillRepository>();
      final bill = await repo.getSplitBill(splitBillId: _billId!);
      final p = bill.participantForUser(_payerUserId!);
      if (!mounted) return;
      setState(() {
        paidCount = bill.paidCount;
        totalParticipants = bill.totalParticipants;
        _paidAt = p?.paidAt;
        _statusLabel = _statusText(p?.status);
      });
    } catch (_) {
      // Silent — leave the current state; the user can pull again.
    } finally {
      if (mounted) setState(() => _refreshing = false);
    }
  }

  String _statusText(SplitBillParticipantStatus? s) {
    switch (s) {
      case SplitBillParticipantStatus.paid:
        return 'Paid';
      case SplitBillParticipantStatus.inProgress:
        return 'In progress';
      case SplitBillParticipantStatus.declined:
        return 'Declined';
      case SplitBillParticipantStatus.pending:
        return 'Pending';
      default:
        return 'Paid';
    }
  }

  Future<void> _downloadReceipt() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);
    try {
      final path = await SplitBillPdfService.downloadReceipt(
        transactionReference: transactionReference,
        amount: amount,
        currency: currency,
        creatorName: creatorName,
        receiverName: receiverName,
        receiverAccountMasked: receiverAccountMasked,
        receiverBankName: receiverBankName,
        description: description,
        paidCount: paidCount,
        totalParticipants: totalParticipants,
        paidAt: _authoritative ? _paidAt : null,
        status: _statusLabel,
      );
      Get.snackbar(
        'Download Complete',
        'Receipt saved to: ${path.split('/').last}',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Download Failed',
        'Could not download receipt. Please try again.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      setState(() => _isDownloading = false);
    }
  }

  Future<void> _shareReceipt() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      // Anchor the iOS/iPad share sheet to this screen (harmless elsewhere; omitting
      // it makes share_plus throw on iPad, which reads as "share not working").
      final box = context.findRenderObject() as RenderBox?;
      final origin =
          box != null ? box.localToGlobal(Offset.zero) & box.size : null;
      await SplitBillPdfService.shareReceipt(
        transactionReference: transactionReference,
        amount: amount,
        currency: currency,
        creatorName: creatorName,
        receiverName: receiverName,
        receiverAccountMasked: receiverAccountMasked,
        receiverBankName: receiverBankName,
        description: description,
        paidCount: paidCount,
        totalParticipants: totalParticipants,
        paidAt: _authoritative ? _paidAt : null,
        status: _statusLabel,
        sharePositionOrigin: origin,
      );
    } catch (e) {
      Get.snackbar(
        'Share Failed',
        'Could not share receipt. Please try again.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      setState(() => _isSharing = false);
    }
  }

  String get _formattedAmount {
    return '${_currencySymbol(currency)}${amount.toStringAsFixed(2)}';
  }

  String _currencySymbol(String code) {
    switch (code) {
      case 'NGN':
        return '\u20A6';
      case 'USD':
        return '\$';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      case 'GHS':
        return 'GH\u20B5';
      case 'KES':
        return 'KSh';
      case 'ZAR':
        return 'R';
      default:
        return '$code ';
    }
  }

  String _formatDate(DateTime dt) {
    final day = dt.day.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final year = dt.year;
    return '$day/$month/$year';
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    // Use the participant's real paid time when available; otherwise "now".
    final now = _paidAt ?? DateTime.now();
    final isPaid = _statusLabel == 'Paid';
    final isInProgress = _statusLabel == 'In progress';
    final headerText = isPaid
        ? 'Payment Successful!'
        : (isInProgress ? 'Transfer initiated' : 'Payment $_statusLabel');

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: _closeReceipt,
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Payment Receipt',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                color: const Color(0xFF4834D4),
                backgroundColor: const Color(0xFF1F1F1F),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8),
                      _buildSuccessIcon(isPaid),
                      const SizedBox(height: 24),
                      if (isInProgress) ...[
                        const Text(
                          'Pull down to refresh the status',
                          style:
                              TextStyle(color: Color(0xFF6B7280), fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                      ],
                      Text(
                        headerText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isPaid
                            ? 'This share has been paid'
                            : 'Share status: $_statusLabel',
                        style: const TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 32),
                      _buildAmountCard(),
                      const SizedBox(height: 24),
                      _buildTransactionDetails(now),
                      if (description.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        _buildSplitBillInfo(),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessIcon(bool isPaid) {
    final color = isPaid
        ? const Color(0xFF10B981)
        : (_statusLabel == 'Declined'
            ? const Color(0xFFEF4444)
            : const Color(0xFFFB923C));
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isPaid ? Icons.check_circle : Icons.receipt_long,
        color: color,
        size: 60,
      ),
    );
  }

  Widget _buildAmountCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            'Amount Paid',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _formattedAmount,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetails(DateTime now) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transaction Details',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow('Paid to', _paidToName),
          // Parity with the PDF, which has always had an Account row. The
          // on-screen receipt omitting it meant the shared file and the screen
          // it was shared from disagreed about what the payment shows.
          if (receiverBankName.isNotEmpty)
            _buildDetailRow('Bank', receiverBankName),
          if (receiverAccountMasked.isNotEmpty)
            _buildDetailRow('Account', receiverAccountMasked),
          const SizedBox(height: 12),
          _buildDetailRow('Reference', transactionReference),
          const SizedBox(height: 12),
          _buildDetailRow('Status', _statusLabel),
          const SizedBox(height: 12),
          _buildDetailRow('Date', _formatDate(now)),
          const SizedBox(height: 12),
          _buildDetailRow('Time', _formatTime(now)),
        ],
      ),
    );
  }

  Widget _buildSplitBillInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF4834D4).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF4834D4).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.receipt_long,
              color: Color(0xFF4834D4),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Part of: $description',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '$paidCount/$totalParticipants paid',
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: GestureDetector(
            onLongPress: label == 'Reference'
                ? () {
                    Clipboard.setData(ClipboardData(text: value));
                    Get.snackbar(
                      'Copied',
                      'Reference copied to clipboard',
                      backgroundColor: const Color(0xFF10B981),
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 2),
                    );
                  }
                : null,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _isSharing ? null : _shareReceipt,
                    icon: _isSharing
                        ? LazerVaultLoader(size: 18)
                        : const Icon(Icons.share, size: 18),
                    label: Text(
                      _isSharing ? 'Sharing...' : 'Share',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFF4834D4)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _isDownloading ? null : _downloadReceipt,
                    icon: _isDownloading
                        ? LazerVaultLoader(size: 18)
                        : const Icon(Icons.download, size: 18),
                    label: Text(
                      _isDownloading ? 'Saving...' : 'Download',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFF4834D4)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _closeReceipt,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4834D4),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
