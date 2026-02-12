import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_theme.dart';
import 'package:uuid/uuid.dart';

class BatchTransferReviewScreen extends StatefulWidget {
  const BatchTransferReviewScreen({super.key});

  @override
  State<BatchTransferReviewScreen> createState() => _BatchTransferReviewScreenState();
}

class _BatchTransferReviewScreenState extends State<BatchTransferReviewScreen>
    with SingleTickerProviderStateMixin, TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  Map<String, dynamic> transferData = {};
  Map<String, String> recipientNames = {};
  bool _isProcessing = false;
  late String _currency;
  late String _currencySymbol;

  // Scheduling state
  bool _isScheduled = false;
  DateTime? _scheduledDate;
  TimeOfDay? _scheduledTime;

  @override
  void initState() {
    super.initState();
    transferData = Get.arguments as Map<String, dynamic>? ?? {};
    recipientNames = (transferData['recipientNames'] as Map<dynamic, dynamic>?)?.cast<String, String>() ?? {};

    // Get currency from arguments, fallback to account manager
    final accountManager = GetIt.I<AccountManager>();
    _currency = transferData['currency'] as String? ??
        accountManager.activeAccountDetails?.currency ?? 'NGN';
    _currencySymbol = transferData['currencySymbol'] as String? ??
        batchCurrencySymbol(_currency);

    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  DateTime? get _scheduledDateTime {
    if (!_isScheduled || _scheduledDate == null) return null;
    final time = _scheduledTime ?? const TimeOfDay(hour: 9, minute: 0);
    return DateTime(
      _scheduledDate!.year,
      _scheduledDate!.month,
      _scheduledDate!.day,
      time.hour,
      time.minute,
    );
  }

  Future<void> _selectScheduleDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _scheduledDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(hours: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: btBlue,
              onPrimary: btTextPrimary,
              surface: btCardElevated,
              onSurface: btTextPrimary,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: btCard,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null && mounted) {
      setState(() {
        _scheduledDate = date;
      });
      _selectScheduleTime();
    }
  }

  Future<void> _selectScheduleTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _scheduledTime ?? const TimeOfDay(hour: 9, minute: 0),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: btBlue,
              onPrimary: btTextPrimary,
              surface: btCardElevated,
              onSurface: btTextPrimary,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: btCard,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
          child: child!,
        );
      },
    );

    if (time != null && mounted) {
      setState(() {
        _scheduledTime = time;
      });
    }
  }

  void _confirmTransfer() async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    // Calculate total amount for PIN validation
    final recipients = transferData['recipients'] as List<BatchTransferRecipient>? ?? [];

    if (recipients.isEmpty) {
      setState(() => _isProcessing = false);
      _showError('No recipients found. Please go back and add recipients.');
      return;
    }

    final totalAmount = recipients.fold<double>(
      0.0,
      (sum, recipient) => sum + (recipient.amount.toDouble() / 100),
    );

    if (totalAmount <= 0) {
      setState(() => _isProcessing = false);
      _showError('Total amount must be greater than zero.');
      return;
    }

    // Client-side balance check
    final accountManager = GetIt.I<AccountManager>();
    final selectedAccount = transferData['selectedAccount'] as AccountSummaryEntity?;
    final availableBalance = selectedAccount?.balance ?? accountManager.activeAccountDetails?.balance ?? 0.0;

    if (totalAmount > availableBalance) {
      setState(() => _isProcessing = false);
      _showError('Insufficient balance. Available: $_currencySymbol${availableBalance.toStringAsFixed(2)}');
      return;
    }

    // Validate schedule if set
    if (_isScheduled) {
      final scheduledDt = _scheduledDateTime;
      if (scheduledDt == null) {
        setState(() => _isProcessing = false);
        _showError('Please select a date and time for the scheduled transfer.');
        return;
      }
      if (scheduledDt.isBefore(DateTime.now().add(const Duration(minutes: 5)))) {
        setState(() => _isProcessing = false);
        _showError('Scheduled time must be at least 5 minutes in the future.');
        return;
      }
    }

    // Generate unique transaction ID
    final transactionId = 'batch_transfer_${const Uuid().v4()}';

    final pinMessage = _isScheduled
        ? 'Schedule batch transfer of $_currencySymbol${totalAmount.toStringAsFixed(2)} to ${recipients.length} ${recipients.length == 1 ? 'recipient' : 'recipients'}?'
        : 'Confirm batch transfer of $_currencySymbol${totalAmount.toStringAsFixed(2)} to ${recipients.length} ${recipients.length == 1 ? 'recipient' : 'recipients'}?';

    // Validate PIN before processing batch transfer
    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'batch_transfer',
      amount: totalAmount,
      currency: _currency,
      title: _isScheduled ? 'Schedule Batch Transfer' : 'Confirm Batch Transfer',
      message: pinMessage,
      onPinValidated: (verificationToken) async {
        _executeBatchTransferWithToken(transactionId, verificationToken);
      },
    );

    if (!success) {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        backgroundColor: btRed,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _executeBatchTransferWithToken(String transactionId, String verificationToken) {
    transferData['transactionId'] = transactionId;
    transferData['verificationToken'] = verificationToken;
    transferData['currency'] = _currency;
    transferData['currencySymbol'] = _currencySymbol;

    // Extract sender info from selected account for receipt/PDF
    final selectedAccount = transferData['selectedAccount'] as AccountSummaryEntity?;
    if (selectedAccount != null) {
      transferData['senderAccountName'] = selectedAccount.displayName;
      transferData['senderAccountInfo'] = '\u2022\u2022\u2022\u2022 ${selectedAccount.accountNumberLast4}';
    }

    if (_isScheduled && _scheduledDateTime != null) {
      transferData['scheduledAt'] = _scheduledDateTime!.toUtc().toIso8601String();
      transferData['isScheduled'] = true;
    }

    Get.offNamed(
      AppRoutes.batchTransferProcessing,
      arguments: transferData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: btBackground,
      body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _buildReviewContent(),
                  ),
                ),
              ),
              _buildConfirmButton(),
            ],
          ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
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
                  'Review Transfer',
                  style: GoogleFonts.inter(
                    color: btTextPrimary,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Confirm your batch transfer details',
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

  Widget _buildReviewContent() {
    final recipients = transferData['recipients'] as List<BatchTransferRecipient>? ?? [];
    final totalAmount = recipients.fold<double>(
      0.0,
      (sum, recipient) => sum + (recipient.amount.toDouble() / 100),
    );
    final category = transferData['category'] as String?;
    final reference = transferData['batchReference'] as String?;
    final selectedAccount = transferData['selectedAccount'] as AccountSummaryEntity?;

    const fee = 0.0;
    final grandTotal = totalAmount + fee;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),

          // Source account card
          if (selectedAccount != null)
            _buildSourceAccountCard(selectedAccount, grandTotal),

          if (selectedAccount != null)
            SizedBox(height: 20.h),

          // Transaction summary card
          _buildTransactionSummaryCard(totalAmount, recipients.length),

          SizedBox(height: 20.h),

          // Schedule toggle
          _buildScheduleSection(),

          SizedBox(height: 20.h),

          // Batch details card
          if (reference != null && reference.isNotEmpty || category != null && category.isNotEmpty)
            _buildBatchDetailsCard(reference, category),

          if (reference != null && reference.isNotEmpty || category != null && category.isNotEmpty)
            SizedBox(height: 20.h),

          // Recipients list card
          _buildRecipientsCard(recipients),

          SizedBox(height: 20.h),

          // Payment breakdown card
          _buildPaymentBreakdownCard(totalAmount, fee, grandTotal),

          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildSourceAccountCard(AccountSummaryEntity account, double total) {
    final hasInsufficientBalance = total > account.balance;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: btCard,
        borderRadius: BorderRadius.circular(16.r),
        border: hasInsufficientBalance
            ? Border.all(color: btRed.withValues(alpha: 0.5))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_balance_wallet_outlined, color: btTextSecondary, size: 16.sp),
              SizedBox(width: 8.w),
              Text(
                'Sending From',
                style: GoogleFonts.inter(
                  color: btTextSecondary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: btBlue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.account_balance_wallet, color: btBlue, size: 22.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.displayName,
                      style: GoogleFonts.inter(
                        color: btTextPrimary,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '\u2022\u2022\u2022\u2022 ${account.accountNumberLast4} \u2022 ${account.currency}',
                      style: GoogleFonts.inter(
                        color: btTextSecondary,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Balance',
                    style: GoogleFonts.inter(color: btTextTertiary, fontSize: 11.sp),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '$_currencySymbol${account.balance.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      color: hasInsufficientBalance ? btRed : btGreen,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (hasInsufficientBalance) ...[
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: btRed.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: btRed.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: btRed, size: 16.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Insufficient balance for this transfer',
                      style: GoogleFonts.inter(color: btRed, fontSize: 12.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScheduleSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: btCard,
        borderRadius: BorderRadius.circular(16.r),
        border: _isScheduled ? Border.all(color: btOrange.withValues(alpha: 0.3)) : null,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: btOrange.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.schedule_outlined, color: btOrange, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Schedule Transfer',
                      style: GoogleFonts.inter(
                        color: btTextPrimary,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _isScheduled ? 'Transfer will be executed at scheduled time' : 'Send immediately or schedule for later',
                      style: GoogleFonts.inter(
                        color: btTextSecondary,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _isScheduled,
                onChanged: (value) {
                  setState(() {
                    _isScheduled = value;
                    if (value && _scheduledDate == null) {
                      _selectScheduleDate();
                    }
                  });
                },
                activeThumbColor: btOrange,
                activeTrackColor: btOrange.withValues(alpha: 0.3),
                inactiveThumbColor: btTextTertiary,
                inactiveTrackColor: btBorder,
              ),
            ],
          ),
          if (_isScheduled) ...[
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: _selectScheduleDate,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: btBackground,
                  borderRadius: BorderRadius.circular(12.r),
                          ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, color: btOrange, size: 18.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_scheduledDate != null) ...[
                            Text(
                              DateFormat('EEEE, MMMM dd, yyyy').format(_scheduledDate!),
                              style: GoogleFonts.inter(
                                color: btTextPrimary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (_scheduledTime != null)
                              Text(
                                'at ${_scheduledTime!.format(context)}',
                                style: GoogleFonts.inter(
                                  color: btOrange,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                          ] else
                            Text(
                              'Tap to select date & time',
                              style: GoogleFonts.inter(
                                color: btTextTertiary,
                                fontSize: 14.sp,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: btTextTertiary, size: 20.sp),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTransactionSummaryCard(double totalAmount, int recipientCount) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: btCard,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: btBlue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(26.r),
                ),
                child: Icon(Icons.send_rounded, color: btBlue, size: 24.sp),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isScheduled ? 'Scheduled Batch Transfer' : 'Batch Transfer',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: btTextPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '$recipientCount ${recipientCount == 1 ? 'recipient' : 'recipients'}',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: btTextSecondary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: btBackground,
              borderRadius: BorderRadius.circular(12.r),
                  ),
            child: Column(
              children: [
                Text(
                  'Total Amount',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: btTextSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '$_currencySymbol${totalAmount.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                    color: btTextPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBatchDetailsCard(String? reference, String? category) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: btCard,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Batch Details',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: btTextPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          if (reference != null && reference.isNotEmpty)
            _buildDetailRow('Reference', reference),
          if (reference != null && reference.isNotEmpty && category != null && category.isNotEmpty)
            SizedBox(height: 12.h),
          if (category != null && category.isNotEmpty)
            _buildDetailRow('Category', category),
        ],
      ),
    );
  }

  Widget _buildRecipientsCard(List<BatchTransferRecipient> recipients) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: btCard,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recipients',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: btTextPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          ...recipients.asMap().entries.map((entry) {
            final index = entry.key;
            final recipient = entry.value;
            return Column(
              children: [
                _buildRecipientRow(recipient, index),
                if (index < recipients.length - 1) SizedBox(height: 12.h),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRecipientRow(BatchTransferRecipient recipient, int index) {
    final amount = recipient.amount.toDouble() / 100;
    final recipientId = recipient.toAccountNumber;
    final recipientName = recipientNames[recipientId] ?? 'Recipient ${index + 1}';

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: btBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: btBlue.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                recipientName[0].toUpperCase(),
                style: GoogleFonts.inter(
                  color: btBlue,
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
                  recipientName,
                  style: GoogleFonts.inter(
                    color: btTextPrimary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (recipient.reference != null && recipient.reference!.isNotEmpty)
                  Text(
                    recipient.reference!,
                    style: GoogleFonts.inter(
                      color: btTextSecondary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            '$_currencySymbol${amount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: btTextPrimary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentBreakdownCard(double totalAmount, double fee, double grandTotal) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: btCard,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Breakdown',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: btTextPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          _buildBreakdownRow('Transfer Amount', totalAmount),
          SizedBox(height: 8.h),
          _buildBreakdownRow('Service Fee', fee),
          if (_isScheduled && _scheduledDateTime != null) ...[
            SizedBox(height: 8.h),
            _buildBreakdownRowText(
              'Scheduled For',
              DateFormat('MMM dd, yyyy \u2022 HH:mm').format(_scheduledDateTime!),
              valueColor: btOrange,
            ),
          ],
          SizedBox(height: 12.h),
          Divider(color: btBorder),
          SizedBox(height: 12.h),
          _buildBreakdownRow('Total Amount', grandTotal, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: btTextSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: btTextPrimary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildBreakdownRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 16.sp : 14.sp,
            color: isTotal ? btTextPrimary : btTextSecondary,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          amount == 0 && !isTotal ? 'Free' : '$_currencySymbol${amount.toStringAsFixed(2)}',
          style: GoogleFonts.inter(
            fontSize: isTotal ? 16.sp : 14.sp,
            color: amount == 0 && !isTotal ? btGreen : (isTotal ? btGreen : btTextPrimary),
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBreakdownRowText(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: btTextSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: valueColor ?? btTextPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: btCard,
        border: Border(top: BorderSide(color: btBorder)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 52.h,
          child: ElevatedButton(
            onPressed: _isProcessing ? null : _confirmTransfer,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isScheduled ? btOrange : btBlue,
              foregroundColor: btTextPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            ),
            child: _isProcessing
                ? SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(btTextPrimary),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isScheduled ? Icons.schedule : Icons.lock_outlined,
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        _isScheduled ? 'Schedule Transfer' : 'Confirm Transfer',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
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
