import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/funds/cubit/batch_transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/batch_transfer_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_theme.dart';

enum BatchProcessingStatus {
  initiated,
  validating,
  reservingFunds,
  processing,
  completed,
}

class BatchTransferProcessingScreen extends StatefulWidget {
  const BatchTransferProcessingScreen({super.key});

  @override
  State<BatchTransferProcessingScreen> createState() =>
      _BatchTransferProcessingScreenState();
}

class _BatchTransferProcessingScreenState
    extends State<BatchTransferProcessingScreen> with TickerProviderStateMixin {
  late AnimationController _processingController;
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  Map<String, dynamic> batchTransferDetails = {};
  late BatchTransferCubit _batchTransferCubit;
  bool _transferInitiated = false;
  bool _isCompleted = false;
  bool _hasValidData = true;
  Timer? _timeoutTimer;
  bool _isScheduled = false;
  String? _scheduledAt;

  BatchProcessingStatus _currentStatus = BatchProcessingStatus.initiated;
  String _statusMessage = 'Initiating your batch transfer...';

  List<_ProcessingStep> get _steps => _isScheduled
      ? [
          const _ProcessingStep(
            status: BatchProcessingStatus.initiated,
            title: 'Request Initiated',
            description: 'Schedule request received',
            icon: Icons.receipt_outlined,
          ),
          const _ProcessingStep(
            status: BatchProcessingStatus.validating,
            title: 'Validating Recipients',
            description: 'Checking account details',
            icon: Icons.verified_user_outlined,
          ),
          const _ProcessingStep(
            status: BatchProcessingStatus.reservingFunds,
            title: 'Verifying Funds',
            description: 'Confirming balance availability',
            icon: Icons.account_balance_outlined,
          ),
          const _ProcessingStep(
            status: BatchProcessingStatus.processing,
            title: 'Scheduling Transfer',
            description: 'Setting up scheduled execution',
            icon: Icons.schedule_outlined,
          ),
          const _ProcessingStep(
            status: BatchProcessingStatus.completed,
            title: 'Scheduled',
            description: 'Transfer scheduled successfully',
            icon: Icons.check_circle_outline,
          ),
        ]
      : [
          const _ProcessingStep(
            status: BatchProcessingStatus.initiated,
            title: 'Transfer Initiated',
            description: 'Request received',
            icon: Icons.receipt_outlined,
          ),
          const _ProcessingStep(
            status: BatchProcessingStatus.validating,
            title: 'Validating Recipients',
            description: 'Checking account details',
            icon: Icons.verified_user_outlined,
          ),
          const _ProcessingStep(
            status: BatchProcessingStatus.reservingFunds,
            title: 'Reserving Funds',
            description: 'Securing your balance',
            icon: Icons.account_balance_outlined,
          ),
          const _ProcessingStep(
            status: BatchProcessingStatus.processing,
            title: 'Processing Transfers',
            description: 'Sending to recipients',
            icon: Icons.sync_outlined,
          ),
          const _ProcessingStep(
            status: BatchProcessingStatus.completed,
            title: 'Completed',
            description: 'Transfers complete',
            icon: Icons.check_circle_outline,
          ),
        ];

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupAnimations();
    _initiateBatchTransfer();
  }

  void _initializeData() {
    batchTransferDetails = Get.arguments as Map<String, dynamic>? ?? {};
    _batchTransferCubit = context.read<BatchTransferCubit>();
    _isScheduled = batchTransferDetails['isScheduled'] as bool? ?? false;
    _scheduledAt = batchTransferDetails['scheduledAt'] as String?;

    if (_isScheduled) {
      _statusMessage = 'Scheduling your batch transfer...';
    }

    // Validate required arguments
    if (batchTransferDetails['recipients'] == null ||
        batchTransferDetails['fromAccountId'] == null ||
        batchTransferDetails['transactionId'] == null ||
        batchTransferDetails['verificationToken'] == null) {
      _hasValidData = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar('Error', 'Missing transfer data. Please try again.',
            backgroundColor: btRed,
            colorText: Colors.white);
        Get.offAllNamed(AppRoutes.home);
      });
      return;
    }
  }

  void _setupAnimations() {
    _processingController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _processingController, curve: Curves.linear),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.elasticOut),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _processingController.repeat();
    _fadeController.forward();
    _pulseController.repeat(reverse: true);
  }

  void _startProcessingSimulation() {
    if (_isCompleted) return;

    // Progress through steps with timed delays
    _updateStatus(BatchProcessingStatus.initiated,
        _isScheduled ? 'Initiating schedule request...' : 'Initiating transfer...');

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted || _isCompleted) return;
      _updateStatus(BatchProcessingStatus.validating, 'Validating recipient details...');
    });

    Future.delayed(const Duration(milliseconds: 2800), () {
      if (!mounted || _isCompleted) return;
      _updateStatus(BatchProcessingStatus.reservingFunds,
          _isScheduled ? 'Verifying funds availability...' : 'Reserving funds...');
    });

    Future.delayed(const Duration(milliseconds: 4500), () {
      if (!mounted || _isCompleted) return;
      _updateStatus(BatchProcessingStatus.processing,
          _isScheduled ? 'Scheduling your batch transfer...' : 'Processing transfers...');
    });
  }

  void _updateStatus(BatchProcessingStatus status, String message) {
    if (!mounted) return;
    setState(() {
      _currentStatus = status;
      _statusMessage = message;
    });
  }

  void _initiateBatchTransfer() async {
    if (_transferInitiated || !_hasValidData) return;
    _transferInitiated = true;

    final recipients =
        batchTransferDetails['recipients'] as List<BatchTransferRecipient>? ??
            [];
    final fromAccountId =
        batchTransferDetails['fromAccountId'] as String? ?? '';
    final transactionId =
        batchTransferDetails['transactionId'] as String? ?? '';
    final verificationToken =
        batchTransferDetails['verificationToken'] as String? ?? '';

    // Start step progression animation
    _startProcessingSimulation();

    // Start timeout timer (90 seconds)
    _timeoutTimer = Timer(const Duration(seconds: 90), () {
      if (mounted && _transferInitiated && !_isCompleted) {
        _showErrorAndRetry(
            'Transfer timed out. Please check your connection and try again.');
      }
    });

    // Parse scheduledAt if present
    DateTime? scheduledDateTime;
    if (_scheduledAt != null) {
      try {
        scheduledDateTime = DateTime.parse(_scheduledAt!);
      } catch (_) {}
    }

    _batchTransferCubit.initiateBatchTransfer(
      fromAccountId: fromAccountId,
      recipients: recipients,
      transactionId: transactionId,
      verificationToken: verificationToken,
      scheduledAt: scheduledDateTime,
    );
  }

  void _completeProcessing() {
    if (_isCompleted) return;
    _isCompleted = true;
    _timeoutTimer?.cancel();
    _processingController.stop();
    _pulseController.stop();

    setState(() {
      _currentStatus = BatchProcessingStatus.completed;
      _statusMessage = _isScheduled
          ? 'Transfer scheduled successfully!'
          : 'Transfer complete!';
    });
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    _processingController.dispose();
    _fadeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _navigateToDashboard() {
    Get.offAllNamed(AppRoutes.home);
  }

  void _updateAccountBalance(BatchTransferEntity response) {
    // Update account balance in AccountCardsSummaryCubit if available
    try {
      final accountCubit = GetIt.I<AccountCardsSummaryCubit>();
      final userId = accountCubit.currentUserId;
      if (userId != null) {
        accountCubit.fetchAccountSummaries(userId: userId);
      }
    } catch (_) {
      // AccountCardsSummaryCubit may not be registered as singleton
    }
  }

  void _navigateToReceipt(BatchTransferEntity response) {
    _completeProcessing();

    // Update balance for instant transfers
    if (!_isScheduled) {
      _updateAccountBalance(response);
    }

    final currency = batchTransferDetails['currency'] as String? ?? 'NGN';
    final recipientNames =
        batchTransferDetails['recipientNames'] as Map<String, String>? ?? {};
    final currencySymbol =
        batchTransferDetails['currencySymbol'] as String? ?? '\u20a6';

    final receiptData = <String, dynamic>{
      'batchId': response.batchId,
      'totalAmount': response.totalAmount.toDouble() / 100,
      'totalFee': response.totalFee.toDouble() / 100,
      'currency': currency,
      'currencySymbol': currencySymbol,
      'timestamp': response.completedAt ?? response.createdAt,
      'status': response.status,
      'recipientCount': response.totalTransfers,
      'successfulTransfers': response.successfulTransfers,
      'failedTransfers': response.failedTransfers,
      'newBalance': response.newBalance,
      'message': response.message,
      'isScheduled': _isScheduled,
      'scheduledAt': _scheduledAt,
      'fromAccountId': batchTransferDetails['fromAccountId'],
      'senderAccountName': batchTransferDetails['senderAccountName'],
      'senderAccountInfo': batchTransferDetails['senderAccountInfo'],
      'transfers': response.results
          .map((r) => {
                'recipientName': r.recipientName ??
                    recipientNames[r.recipientAccount] ??
                    'Unknown',
                'recipientAccount': r.recipientAccount ?? '',
                'amount': r.amount.toDouble() / 100,
                'fee': r.fee.toDouble() / 100,
                'status': r.status,
                'failureReason': r.failureReason,
                'reference': r.reference,
              })
          .toList(),
    };

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        Get.offAllNamed(AppRoutes.batchTransferReceipt, arguments: receiptData);
      }
    });
  }

  void _showErrorAndRetry(String message) {
    if (!mounted) return;
    _processingController.stop();
    _pulseController.stop();

    final isNetworkError = message.toLowerCase().contains('unavailable') ||
        message.toLowerCase().contains('no internet') ||
        message.toLowerCase().contains('timeout');

    final displayMessage = isNetworkError
        ? 'No internet connection. Your transfer has not been processed. Please try again when online.'
        : message;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: btCardElevated,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          _isScheduled ? 'Scheduling Failed' : 'Transfer Failed',
          style: GoogleFonts.inter(
            color: btTextPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          displayMessage,
          style: GoogleFonts.inter(color: btTextSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _navigateToDashboard();
            },
            child: Text(
              'Go Home',
              style: GoogleFonts.inter(color: btTextSecondary),
            ),
          ),
          ElevatedButton(
            // Safe to retry: same transactionId ensures idempotent server-side handling
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _transferInitiated = false;
                _isCompleted = false;
                _currentStatus = BatchProcessingStatus.initiated;
                _statusMessage = _isScheduled
                    ? 'Scheduling your batch transfer...'
                    : 'Initiating your batch transfer...';
              });
              _processingController.repeat();
              _pulseController.repeat(reverse: true);
              _startProcessingSimulation();
              _initiateBatchTransfer();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: btBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
            ),
            child: Text(
              'Retry',
              style: GoogleFonts.inter(
                  color: btTextPrimary, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _navigateToDashboard();
        }
      },
      child: BlocListener<BatchTransferCubit, BatchTransferState>(
        listener: (context, state) {
          if (state is BatchTransferSuccess) {
            _navigateToReceipt(state.response);
          } else if (state is BatchTransferPartialSuccess) {
            _navigateToReceipt(state.response);
          } else if (state is BatchTransferNetworkError) {
            _showErrorAndRetry(state.message);
          } else if (state is BatchTransferFailure) {
            _showErrorAndRetry(state.message);
          }
        },
        child: Scaffold(
          backgroundColor: btBackground,
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildProcessingContent(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final splitType = batchTransferDetails['split_type'] as String?;

    String headerTitle;
    if (_isCompleted) {
      headerTitle =
          _isScheduled ? 'Transfer Scheduled!' : 'Transfer Complete!';
    } else if (_isScheduled) {
      headerTitle = splitType != null
          ? 'Scheduling Split Payment...'
          : 'Scheduling Batch Transfer...';
    } else {
      headerTitle = splitType != null
          ? 'Processing Split Payment...'
          : 'Processing Batch Transfer...';
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerTitle,
            style: GoogleFonts.inter(
              color: btTextPrimary,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            _statusMessage,
            style: GoogleFonts.inter(
              color: btTextSecondary,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            ScaleTransition(
              scale: _scaleAnimation,
              child: _buildProcessingIcon(),
            ),
            SizedBox(height: 32.h),
            _buildTransferDetailsCard(),
            SizedBox(height: 24.h),
            _buildProcessingSteps(),
            SizedBox(height: 24.h),
            _buildSecurityMessage(),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessingIcon() {
    final accentColor = _isScheduled ? btOrange : btBlue;
    final completedColor = btGreen;

    return AnimatedBuilder(
      animation: _isCompleted ? _fadeAnimation : _rotationAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _isCompleted ? 0 : _rotationAnimation.value * 2 * 3.14159,
          child: AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _isCompleted ? 1.0 : _pulseAnimation.value,
                child: Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _isCompleted
                          ? [
                              completedColor,
                              const Color(0xFF34D399),
                            ]
                          : [
                              accentColor,
                              accentColor.withValues(alpha: 0.7),
                            ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (_isCompleted ? completedColor : accentColor)
                            .withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    _isCompleted
                        ? Icons.check
                        : (_isScheduled ? Icons.schedule : Icons.sync),
                    color: Colors.white,
                    size: 50.sp,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTransferDetailsCard() {
    final recipients =
        batchTransferDetails['recipients'] as List<BatchTransferRecipient>? ??
            [];
    final totalRecipients = recipients.length;
    final totalAmount = batchTransferDetails['totalAmount'] ?? 0.0;
    final currencySymbol =
        batchTransferDetails['currencySymbol'] as String? ?? '\u20a6';

    DateTime? scheduledDateTime;
    if (_scheduledAt != null) {
      try {
        scheduledDateTime = DateTime.parse(_scheduledAt!).toLocal();
      } catch (_) {}
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: btCardElevated,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Text(
            _isScheduled ? 'Scheduled Batch Transfer' : 'Batch Transfer',
            style: GoogleFonts.inter(
              color: btTextSecondary,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '$currencySymbol${totalAmount is num ? totalAmount.toStringAsFixed(2) : totalAmount}',
            style: GoogleFonts.inter(
              color: btTextPrimary,
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '$totalRecipients ${totalRecipients == 1 ? 'recipient' : 'recipients'}',
            style: GoogleFonts.inter(
              color: btTextSecondary,
              fontSize: 16.sp,
            ),
          ),
          if (_isScheduled && scheduledDateTime != null) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: btOrange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: btOrange.withValues(alpha: 0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.schedule, color: btOrange, size: 14.sp),
                  SizedBox(width: 6.w),
                  Text(
                    DateFormat('MMM dd, yyyy \u2022 HH:mm')
                        .format(scheduledDateTime),
                    style: GoogleFonts.inter(
                      color: btOrange,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
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

  Widget _buildProcessingSteps() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: btCardElevated,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _isScheduled ? 'Scheduling Progress' : 'Transfer Progress',
            style: GoogleFonts.inter(
              color: btTextPrimary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          ..._steps.map((step) => _buildStepItem(step)),
        ],
      ),
    );
  }

  Widget _buildStepItem(_ProcessingStep step) {
    final isActive = _currentStatus.index >= step.status.index;
    final isCurrent = _currentStatus == step.status;
    final accentColor = _isScheduled ? btOrange : btBlue;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: isActive
                  ? (isCurrent ? accentColor : btGreen).withValues(alpha: 0.2)
                  : btTextTertiary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive
                    ? (isCurrent ? accentColor : btGreen)
                    : btTextTertiary.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Icon(
              isActive && !isCurrent ? Icons.check : step.icon,
              color: isActive
                  ? (isCurrent ? accentColor : btGreen)
                  : btTextTertiary,
              size: 16.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: GoogleFonts.inter(
                    color: isActive ? btTextPrimary : btTextTertiary,
                    fontSize: 14.sp,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                Text(
                  step.description,
                  style: GoogleFonts.inter(
                    color: isActive ? btTextSecondary : btTextTertiary,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          if (isCurrent && !_isCompleted)
            SizedBox(
              width: 16.w,
              height: 16.h,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor:
                    AlwaysStoppedAnimation<Color>(accentColor),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSecurityMessage() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: btCardElevated,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Icons.security, color: btGreen, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              _isScheduled
                  ? 'Scheduled transfers are secured with bank-level encryption and will execute at the specified time'
                  : 'All transfers are secured with bank-level encryption',
              style: GoogleFonts.inter(
                color: btTextSecondary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProcessingStep {
  final BatchProcessingStatus status;
  final String title;
  final String description;
  final IconData icon;

  const _ProcessingStep({
    required this.status,
    required this.title,
    required this.description,
    required this.icon,
  });
}
