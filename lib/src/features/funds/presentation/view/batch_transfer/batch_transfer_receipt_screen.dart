import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/funds/services/batch_transfer_pdf_service.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_theme.dart';

class BatchTransferReceiptScreen extends StatefulWidget {
  const BatchTransferReceiptScreen({super.key});

  @override
  State<BatchTransferReceiptScreen> createState() =>
      _BatchTransferReceiptScreenState();
}

class _BatchTransferReceiptScreenState extends State<BatchTransferReceiptScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _checkAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _checkAnimation;

  Map<String, dynamic> receiptData = {};
  bool _isDownloading = false;
  bool _isSharing = false;
  // Track loading state per individual recipient (by index)
  final Map<int, bool> _individualDownloading = {};
  final Map<int, bool> _individualSharing = {};

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupAnimations();
  }

  void _initializeData() {
    receiptData = Get.arguments as Map<String, dynamic>? ?? {};
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _checkAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _checkAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _checkAnimationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _checkAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _checkAnimationController.dispose();
    super.dispose();
  }

  void _navigateToDashboard() {
    Get.offAllNamed(AppRoutes.home);
  }

  // --- Status helpers ---

  bool get _isScheduled => receiptData['isScheduled'] as bool? ?? false;

  String get _status =>
      receiptData['status'] as String? ?? 'completed';

  IconData _statusIcon(String status) {
    if (_isScheduled) return Icons.schedule_rounded;
    switch (status.toLowerCase()) {
      case 'completed':
      case 'success':
        return Icons.check_rounded;
      case 'partial':
      case 'partially_failed':
        return Icons.warning_rounded;
      case 'failed':
        return Icons.close_rounded;
      default:
        return Icons.access_time_rounded;
    }
  }

  String _statusTitle(String status) {
    if (_isScheduled) return 'Transfer Scheduled';
    final successfulTransfers =
        receiptData['successfulTransfers'] as int? ?? 0;
    final recipientCount = receiptData['recipientCount'] as int? ?? 0;

    switch (status.toLowerCase()) {
      case 'completed':
      case 'success':
        return 'All Transfers Complete';
      case 'partial':
      case 'partially_failed':
        return '$successfulTransfers of $recipientCount Complete';
      case 'failed':
        return 'Transfers Failed';
      default:
        return 'Processing Transfers';
    }
  }

  String _statusSubtitle(String status) {
    if (_isScheduled) {
      final scheduledAt = receiptData['scheduledAt'] as String?;
      if (scheduledAt != null) {
        try {
          final dt = DateTime.parse(scheduledAt).toLocal();
          return 'Scheduled for ${DateFormat('MMM dd, yyyy').format(dt)} at ${DateFormat('HH:mm').format(dt)}';
        } catch (_) {}
      }
      return 'Your batch transfer has been scheduled';
    }

    final failedTransfers = receiptData['failedTransfers'] as int? ?? 0;

    switch (status.toLowerCase()) {
      case 'completed':
      case 'success':
        return 'All transfers have been processed successfully';
      case 'partial':
      case 'partially_failed':
        return '$failedTransfers transfer${failedTransfers == 1 ? '' : 's'} could not be completed';
      case 'failed':
        return 'None of the transfers could be completed';
      default:
        return 'Your batch transfer is being processed';
    }
  }

  // --- Actions ---

  Future<void> _downloadReceipt() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);

    try {
      await BatchTransferPdfService.downloadReceipt(
        receiptData: receiptData,
      );

      if (mounted) {
        Get.snackbar(
          'Download Complete',
          'Receipt saved to Downloads',
          backgroundColor: btGreen,
          colorText: btTextPrimary,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      if (mounted) {
        Get.snackbar(
          'Download Failed',
          'Unable to download receipt. Please try again.',
          backgroundColor: btRed,
          colorText: btTextPrimary,
          snackPosition: SnackPosition.TOP,
        );
      }
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  Future<void> _shareReceipt() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);

    try {
      await BatchTransferPdfService.shareReceipt(
        receiptData: receiptData,
      );
    } catch (e) {
      if (mounted) {
        Get.snackbar(
          'Share Failed',
          'Unable to share receipt. Please try again.',
          backgroundColor: btRed,
          colorText: btTextPrimary,
          snackPosition: SnackPosition.TOP,
        );
      }
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }


  void _startAnotherTransfer() {
    Get.offAllNamed(AppRoutes.batchTransfer);
  }

  Future<void> _downloadIndividualReceipt(int index, Map<String, dynamic> transfer) async {
    if (_individualDownloading[index] == true) return;
    setState(() => _individualDownloading[index] = true);

    try {
      await BatchTransferPdfService.downloadIndividualReceipt(
        receiptData: receiptData,
        transfer: transfer,
      );

      if (mounted) {
        final name = transfer['recipientName'] as String? ?? 'Recipient';
        Get.snackbar(
          'Download Complete',
          'Receipt for $name saved to Downloads',
          backgroundColor: btGreen,
          colorText: btTextPrimary,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      if (mounted) {
        Get.snackbar(
          'Download Failed',
          'Unable to download receipt. Please try again.',
          backgroundColor: btRed,
          colorText: btTextPrimary,
          snackPosition: SnackPosition.TOP,
        );
      }
    } finally {
      if (mounted) setState(() => _individualDownloading[index] = false);
    }
  }

  Future<void> _shareIndividualReceipt(int index, Map<String, dynamic> transfer) async {
    if (_individualSharing[index] == true) return;
    setState(() => _individualSharing[index] = true);

    try {
      await BatchTransferPdfService.shareIndividualReceipt(
        receiptData: receiptData,
        transfer: transfer,
      );
    } catch (e) {
      if (mounted) {
        Get.snackbar(
          'Share Failed',
          'Unable to share receipt. Please try again.',
          backgroundColor: btRed,
          colorText: btTextPrimary,
          snackPosition: SnackPosition.TOP,
        );
      }
    } finally {
      if (mounted) setState(() => _individualSharing[index] = false);
    }
  }

  void _showIndividualReceiptsSheet() {
    final transfers = receiptData['transfers'] as List<dynamic>? ?? [];
    final currency = receiptData['currency'] as String? ?? 'NGN';
    final currencySymbol =
        receiptData['currencySymbol'] as String? ?? batchCurrencySymbol(currency);

    if (transfers.isEmpty) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              decoration: BoxDecoration(
                color: btCard,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  Container(
                    margin: EdgeInsets.only(top: 12.h),
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: btBorder,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  // Title
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 4.h),
                    child: Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: btBlue.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(Icons.receipt_long_rounded,
                              color: btBlue, size: 20.sp),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Individual Receipts',
                                style: GoogleFonts.inter(
                                  color: btTextPrimary,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Download or share receipt for each recipient',
                                style: GoogleFonts.inter(
                                  color: btTextSecondary,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(sheetContext).pop(),
                          child: Container(
                            width: 36.w,
                            height: 36.w,
                            decoration: BoxDecoration(
                              color: btCardElevated,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.close, color: btTextSecondary, size: 18.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Divider(color: btBorder, height: 1),
                  // Recipient list
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      itemCount: transfers.length,
                      separatorBuilder: (_, __) => SizedBox(height: 8.h),
                      itemBuilder: (context, index) {
                        final transfer = transfers[index] as Map<String, dynamic>;
                        final name = _resolveTransferName(transfer);
                        final account = transfer['recipientAccount'] as String? ??
                            transfer['account'] as String? ??
                            '\u2022\u2022\u2022\u2022';
                        final amount =
                            (transfer['amount'] as num?)?.toDouble() ?? 0.0;
                        final status = transfer['status'] as String? ?? 'Pending';
                        final isFailed = status.toLowerCase() == 'failed';
                        final statusColor = batchStatusColor(status);
                        final isDownloading =
                            _individualDownloading[index] == true;
                        final isShareing =
                            _individualSharing[index] == true;

                        return Container(
                          padding: EdgeInsets.all(14.w),
                          decoration: BoxDecoration(
                            color: btBackground,
                            borderRadius: BorderRadius.circular(14.r),
                            border: isFailed
                                ? Border.all(color: btRed.withValues(alpha: 0.2))
                                : null,
                          ),
                          child: Row(
                            children: [
                              // Avatar
                              Container(
                                width: 42.w,
                                height: 42.w,
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: isFailed
                                      ? Icon(Icons.close_rounded,
                                          color: btRed, size: 18.sp)
                                      : Text(
                                          name.isNotEmpty
                                              ? name[0].toUpperCase()
                                              : '?',
                                          style: GoogleFonts.inter(
                                            color: statusColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              // Name, account, amount
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: GoogleFonts.inter(
                                        color: btTextPrimary,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 2.h),
                                    Row(
                                      children: [
                                        Text(
                                          account,
                                          style: GoogleFonts.inter(
                                            color: btTextTertiary,
                                            fontSize: 11.sp,
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          '$currencySymbol${amount.toStringAsFixed(2)}',
                                          style: GoogleFonts.inter(
                                            color: btTextSecondary,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Download button
                              _buildSheetIconButton(
                                icon: Icons.download_rounded,
                                color: btGreen,
                                isLoading: isDownloading,
                                onTap: () async {
                                  await _downloadIndividualReceipt(index, transfer);
                                  setSheetState(() {});
                                },
                              ),
                              SizedBox(width: 8.w),
                              // Share button
                              _buildSheetIconButton(
                                icon: Icons.share_rounded,
                                color: btBlue,
                                isLoading: isShareing,
                                onTap: () async {
                                  await _shareIndividualReceipt(index, transfer);
                                  setSheetState(() {});
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // Bottom safe area padding
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 8.h),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSheetIconButton({
    required IconData icon,
    required Color color,
    required bool isLoading,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: 38.w,
        height: 38.w,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  width: 16.w,
                  height: 16.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              )
            : Icon(icon, color: color, size: 18.sp),
      ),
    );
  }

  /// Resolve the best name from a transfer map, avoiding generic names like "business"
  String _resolveTransferName(Map<String, dynamic> transfer) {
    final recipientName = transfer['recipientName'] as String?;
    final beneficiaryName = transfer['beneficiaryName'] as String?;
    final name = transfer['name'] as String?;

    // Check beneficiaryName first (actual person name from request)
    if (beneficiaryName != null && beneficiaryName.isNotEmpty &&
        beneficiaryName.toLowerCase() != 'unknown' &&
        beneficiaryName.toLowerCase() != 'external account') {
      return beneficiaryName;
    }
    // Then recipientName, but skip generic account type names
    if (recipientName != null && recipientName.isNotEmpty &&
        recipientName.toLowerCase() != 'unknown' &&
        recipientName.toLowerCase() != 'business') {
      return recipientName;
    }
    return name ?? recipientName ?? beneficiaryName ?? 'Unknown';
  }

  // --- Build ---

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _navigateToDashboard();
      },
      child: Scaffold(
        backgroundColor: btBackground,
        body: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        SizedBox(height: 8.h),
                        _buildStatusCard(),
                        SizedBox(height: 20.h),
                        _buildAmountCard(),
                        SizedBox(height: 20.h),
                        if (_isScheduled) ...[
                          _buildScheduleInfoCard(),
                          SizedBox(height: 20.h),
                        ],
                        _buildBatchSummary(),
                        SizedBox(height: 20.h),
                        _buildTransferResults(),
                        SizedBox(height: 12.h),
                        _buildViewAllRecipientsCTA(),
                        SizedBox(height: 20.h),
                        if (_hasNewBalance) ...[
                          _buildNewBalanceCard(),
                          SizedBox(height: 20.h),
                        ],
                        SizedBox(height: 80.h), // Space for bottom actions
                      ],
                    ),
                  ),
                ),
                _buildBottomActions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool get _hasNewBalance =>
      receiptData['newBalance'] != null && !_isScheduled;

  Widget _buildHeader() {
    String headerTitle;
    if (_isScheduled) {
      headerTitle = 'Transfer Scheduled';
    } else {
      switch (_status.toLowerCase()) {
        case 'completed':
        case 'success':
          headerTitle = 'Transfer Complete';
          break;
        case 'partial':
        case 'partially_failed':
          headerTitle = 'Partial Transfer';
          break;
        case 'failed':
          headerTitle = 'Transfer Failed';
          break;
        default:
          headerTitle = 'Transfer Receipt';
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: _navigateToDashboard,
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: btCardElevated,
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(Icons.arrow_back_ios_new, color: btTextPrimary, size: 18.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headerTitle,
                  style: GoogleFonts.inter(
                    color: btTextPrimary,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Batch Transfer Receipt',
                  style: GoogleFonts.inter(
                    color: btTextSecondary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    final status = _status;
    final color = _isScheduled ? btOrange : batchStatusColor(status);
    final icon = _statusIcon(status);
    final title = _statusTitle(status);
    final subtitle = _statusSubtitle(status);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _checkAnimation,
              builder: (context, child) {
                return Container(
                  width: 72.w,
                  height: 72.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [color, color.withValues(alpha: 0.8)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.35),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Transform.scale(
                    scale: _checkAnimation.value,
                    child: Icon(icon, color: Colors.white, size: 36.sp),
                  ),
                );
              },
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: GoogleFonts.inter(
                color: btTextPrimary,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: btTextSecondary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountCard() {
    final totalAmount =
        (receiptData['totalAmount'] as num?)?.toDouble() ?? 0.0;
    final totalFee = (receiptData['totalFee'] as num?)?.toDouble() ?? 0.0;
    final currency = receiptData['currency'] as String? ?? 'NGN';
    final currencySymbol = receiptData['currencySymbol'] as String? ??
        batchCurrencySymbol(currency);
    final recipientCount = receiptData['recipientCount'] as int? ?? 0;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: btCard,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Text(
            'Total Amount',
            style: GoogleFonts.inter(
              color: btTextSecondary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '$currencySymbol${totalAmount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: btTextPrimary,
              fontSize: 36.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAmountChip(
                Icons.people_outline,
                '$recipientCount ${recipientCount == 1 ? 'recipient' : 'recipients'}',
                btBlue,
              ),
              SizedBox(width: 12.w),
              _buildAmountChip(
                Icons.bolt_outlined,
                totalFee == 0 ? 'No fees' : '$currencySymbol${totalFee.toStringAsFixed(2)} fee',
                btGreen,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountChip(IconData icon, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14.sp),
          SizedBox(width: 4.w),
          Text(
            label,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleInfoCard() {
    final scheduledAt = receiptData['scheduledAt'] as String?;
    DateTime? scheduledDateTime;
    if (scheduledAt != null) {
      try {
        scheduledDateTime = DateTime.parse(scheduledAt).toLocal();
      } catch (_) {}
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: btOrange.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: btOrange.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: btOrange.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(Icons.schedule_rounded, color: btOrange, size: 24.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scheduled Execution',
                  style: GoogleFonts.inter(
                    color: btOrange,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                if (scheduledDateTime != null)
                  Text(
                    '${DateFormat('EEEE, MMMM dd, yyyy').format(scheduledDateTime)} at ${DateFormat('HH:mm').format(scheduledDateTime)}',
                    style: GoogleFonts.inter(
                      color: btTextSecondary,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                else
                  Text(
                    'Transfer will execute at the scheduled time',
                    style: GoogleFonts.inter(
                      color: btTextSecondary,
                      fontSize: 13.sp,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBatchSummary() {
    final batchId = receiptData['batchId']?.toString() ??
        'BTX${DateTime.now().millisecondsSinceEpoch}';
    final totalAmount =
        (receiptData['totalAmount'] as num?)?.toDouble() ?? 0.0;
    final totalFee = (receiptData['totalFee'] as num?)?.toDouble() ?? 0.0;
    final currency = receiptData['currency'] as String? ?? 'NGN';
    final recipientCount = receiptData['recipientCount'] as int? ?? 0;
    final timestamp =
        receiptData['timestamp'] as DateTime? ?? DateTime.now();
    final status = _status;
    final successfulTransfers =
        receiptData['successfulTransfers'] as int? ?? recipientCount;
    final failedTransfers = receiptData['failedTransfers'] as int? ?? 0;
    final currencySymbol = receiptData['currencySymbol'] as String? ??
        batchCurrencySymbol(currency);

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: btCard,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.receipt_long_rounded,
                  color: btTextSecondary, size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                'Transaction Details',
                style: GoogleFonts.inter(
                  color: btTextPrimary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          _buildSummaryRow('Batch ID', batchId),
          _buildSummaryRow('Date & Time',
              DateFormat('MMM dd, yyyy \u2022 HH:mm').format(timestamp)),
          _buildSummaryRow('Status',
              _isScheduled ? 'Scheduled' : formatBatchStatus(status),
              valueColor: _isScheduled ? btOrange : batchStatusColor(status)),
          _buildSummaryRow('Recipients',
              '$recipientCount transfer${recipientCount == 1 ? '' : 's'}'),

          if (!_isScheduled &&
              (status.toLowerCase() == 'partial' ||
                  status.toLowerCase() == 'partially_failed' ||
                  failedTransfers > 0)) ...[
            _buildSummaryRow('Successful', '$successfulTransfers',
                valueColor: btGreen),
            _buildSummaryRow('Failed', '$failedTransfers',
                valueColor: btRed),
          ],

          _buildSummaryRow('Currency', currency),
          _buildSummaryRow('Transfer Amount',
              '$currencySymbol${totalAmount.toStringAsFixed(2)}'),
          _buildSummaryRow(
              'Service Fee',
              totalFee == 0
                  ? 'Free'
                  : '$currencySymbol${totalFee.toStringAsFixed(2)}',
              valueColor: totalFee == 0 ? btGreen : null),

          SizedBox(height: 4.h),
          Divider(color: btBorder, height: 20.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Grand Total',
                style: GoogleFonts.inter(
                  color: btTextPrimary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '$currencySymbol${(totalAmount + totalFee).toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: btGreen,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: btTextSecondary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: valueColor ?? btTextPrimary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferResults() {
    final transfers =
        receiptData['transfers'] as List<dynamic>? ?? [];
    final currency = receiptData['currency'] as String? ?? 'NGN';
    final currencySymbol = receiptData['currencySymbol'] as String? ??
        batchCurrencySymbol(currency);

    if (transfers.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: btCard,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.people_outline, color: btTextSecondary, size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                'Transfer Results',
                style: GoogleFonts.inter(
                  color: btTextPrimary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: btBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '${transfers.length}',
                  style: GoogleFonts.inter(
                    color: btBlue,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...transfers.asMap().entries.map((entry) {
            final index = entry.key;
            final transfer = entry.value as Map<String, dynamic>;

            final name = _resolveTransferName(transfer);
            final account = transfer['recipientAccount'] as String? ??
                transfer['account'] as String? ??
                '\u2022\u2022\u2022\u2022';
            final amount =
                (transfer['amount'] as num?)?.toDouble() ?? 0.0;
            final status = transfer['status'] as String? ?? 'Pending';
            final failureReason = transfer['failureReason'] as String?;
            final isFailed = status.toLowerCase() == 'failed';
            final statusColor = batchStatusColor(status);

            return Container(
              margin: EdgeInsets.only(
                bottom: index < transfers.length - 1 ? 10.h : 0,
              ),
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: btBackground,
                borderRadius: BorderRadius.circular(14.r),
                border: isFailed
                    ? Border.all(color: btRed.withValues(alpha: 0.2))
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Recipient avatar
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: isFailed
                              ? Icon(Icons.close_rounded,
                                  color: btRed, size: 18.sp)
                              : Text(
                                  name.isNotEmpty
                                      ? name[0].toUpperCase()
                                      : '?',
                                  style: GoogleFonts.inter(
                                    color: statusColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: GoogleFonts.inter(
                                color: btTextPrimary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              account,
                              style: GoogleFonts.inter(
                                color: btTextTertiary,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '$currencySymbol${amount.toStringAsFixed(2)}',
                            style: GoogleFonts.inter(
                              color: btTextPrimary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 3.h),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              formatBatchStatus(status),
                              style: GoogleFonts.inter(
                                color: statusColor,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Failure reason
                  if (isFailed &&
                      failureReason != null &&
                      failureReason.isNotEmpty) ...[
                    SizedBox(height: 10.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: btRed.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8.r),
                        border:
                            Border.all(color: btRed.withValues(alpha: 0.15)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline_rounded,
                              color: btRed, size: 14.sp),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              failureReason,
                              style: GoogleFonts.inter(
                                color: btRed,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildNewBalanceCard() {
    final newBalance = receiptData['newBalance'];
    if (newBalance == null) return const SizedBox.shrink();

    final currency = receiptData['currency'] as String? ?? 'NGN';
    final currencySymbol = receiptData['currencySymbol'] as String? ??
        batchCurrencySymbol(currency);
    // newBalance from BatchTransferEntity is already in major units (double from proto)
    final balanceValue = newBalance is num
        ? newBalance.toDouble()
        : 0.0;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: btBlue.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: btBlue.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: btBlue.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.account_balance_wallet_outlined,
                color: btBlue, size: 22.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Updated Balance',
                  style: GoogleFonts.inter(
                    color: btTextSecondary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '$currencySymbol${balanceValue.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: btTextPrimary,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewAllRecipientsCTA() {
    final transfers = receiptData['transfers'] as List<dynamic>? ?? [];
    if (transfers.isEmpty) return const SizedBox.shrink();

    return GestureDetector(
      onTap: _showIndividualReceiptsSheet,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: btBlue.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: btBlue.withValues(alpha: 0.25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long_rounded, color: btBlue, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              'View All Recipients',
              style: GoogleFonts.inter(
                color: btBlue,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              '(${transfers.length})',
              style: GoogleFonts.inter(
                color: btBlue.withValues(alpha: 0.7),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(Icons.chevron_right, color: btBlue, size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: btCard,
        border: Border(top: BorderSide(color: btBorder)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Primary actions - Download and Share
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.download_rounded,
                    label: 'Download',
                    color: btGreen,
                    isLoading: _isDownloading,
                    onTap: _downloadReceipt,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.share_rounded,
                    label: 'Share',
                    color: btBlue,
                    isLoading: _isSharing,
                    onTap: _shareReceipt,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            // Secondary actions - New Transfer and View All Recipients
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.send_rounded,
                    label: 'New Transfer',
                    color: btOrange,
                    onTap: _startAnotherTransfer,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.receipt_long_rounded,
                    label: 'All Recipients',
                    color: btPurple,
                    onTap: _showIndividualReceiptsSheet,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isLoading = false,
  }) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: 14.w,
                height: 14.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              )
            else
              Icon(icon, color: color, size: 16.sp),
            SizedBox(width: 6.w),
            Text(
              label,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
