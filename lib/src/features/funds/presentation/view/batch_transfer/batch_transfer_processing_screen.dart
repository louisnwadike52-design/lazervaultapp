import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fixnum/fixnum.dart';
import 'package:lazervault/src/features/funds/cubit/batch_transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/batch_transfer_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

class BatchTransferProcessingScreen extends StatefulWidget {
  const BatchTransferProcessingScreen({super.key});

  @override
  State<BatchTransferProcessingScreen> createState() => _BatchTransferProcessingScreenState();
}

class _BatchTransferProcessingScreenState extends State<BatchTransferProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _processingController;
  late AnimationController _fadeController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  Map<String, dynamic> batchTransferDetails = {};
  late BatchTransferCubit _batchTransferCubit;
  bool _transferInitiated = false;
  Timer? _timeoutTimer;

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

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _processingController, curve: Curves.linear),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.elasticOut),
    );

    _processingController.repeat();
    _fadeController.forward();
  }

  void _initiateBatchTransfer() async {
    if (_transferInitiated) return;
    _transferInitiated = true;

    final recipients = batchTransferDetails['recipients'] as List<BatchTransferRecipient>? ?? [];
    final fromAccountId = batchTransferDetails['fromAccountId'] as Int64? ?? Int64.ZERO;
    final category = batchTransferDetails['category'] as String?;
    final reference = batchTransferDetails['reference'] as String?;

    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    final accessToken = authState.profile.session.accessToken;

    // Start timeout timer (60 seconds)
    _timeoutTimer = Timer(const Duration(seconds: 60), () {
      if (mounted && _transferInitiated) {
        _showErrorAndRetry('Transfer timed out. Please check your connection and try again.');
      }
    });

    _batchTransferCubit.initiateBatchTransfer(
      fromAccountId: fromAccountId,
      recipients: recipients,
      accessToken: accessToken,
      category: category,
      reference: reference,
    );
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    _processingController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _navigateToDashboard() {
    Get.offAllNamed('/home');
  }

  void _navigateToReceipt(BatchTransferEntity response) {
    _timeoutTimer?.cancel();
    _processingController.stop();

    final currency = batchTransferDetails['currency'] as String? ?? 'NGN';
    final recipientNames = batchTransferDetails['recipientNames'] as Map<String, String>? ?? {};

    final receiptData = <String, dynamic>{
      'batchId': response.batchId.toString(),
      'totalAmount': response.totalAmount.toDouble() / 100,
      'totalFee': response.totalFee.toDouble() / 100,
      'currency': currency,
      'timestamp': response.completedAt ?? response.createdAt,
      'status': response.status,
      'recipientCount': response.totalTransfers,
      'successfulTransfers': response.successfulTransfers,
      'failedTransfers': response.failedTransfers,
      'transfers': response.results.map((r) => {
        'recipientName': r.recipientName ?? recipientNames[r.transferId.toString()] ?? 'Unknown',
        'recipientAccount': r.recipientAccount ?? '',
        'amount': r.amount.toDouble() / 100,
        'status': r.status,
        'failureReason': r.failureReason,
      }).toList(),
    };

    Get.offAllNamed('/batch-transfer-receipt', arguments: receiptData);
  }

  void _showErrorAndRetry(String message) {
    _processingController.stop();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text('Transfer Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _navigateToDashboard();
            },
            child: Text('Go Home'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _transferInitiated = false;
              });
              _processingController.repeat();
              _initiateBatchTransfer();
            },
            child: Text('Retry'),
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
          } else if (state is BatchTransferFailure) {
            _showErrorAndRetry(state.message);
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF0F0F23),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF1A1A3E),
                  const Color(0xFF0F0F23),
                  const Color(0xFF0A0A1A),
                ],
              ),
            ),
            child: SafeArea(
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
      ),
    );
  }

  Widget _buildHeader() {
    final splitType = batchTransferDetails['split_type'] as String?;
    final headerTitle = splitType != null ? 'Processing Split Payment...' : 'Processing Batch Transfer...';
    final headerSubtitle = splitType != null
        ? 'Please wait while we process your split payment'
        : 'Please wait while we process your batch transfer';

    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headerTitle,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  headerSubtitle,
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingContent() {
    final totalRecipients = batchTransferDetails['totalRecipients'] ?? 0;
    final totalAmount = batchTransferDetails['totalAmount'] ?? 0.0;
    final currencySymbol = batchTransferDetails['currencySymbol'] as String? ?? '\u20a6';

    return Center(
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 2 * 3.14159,
                  child: Container(
                    width: 120.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue[700]!, Colors.blue[500]!],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.batch_prediction,
                      color: Colors.white,
                      size: 60.sp,
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 40.h),

            Text(
              'Processing your transfers...',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 16.h),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  Text(
                    'Sending $currencySymbol${totalAmount is num ? totalAmount.toStringAsFixed(2) : totalAmount} to',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '$totalRecipients recipients',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  _buildProgressStep('Validating recipients', true, true),
                  _buildProgressStep('Processing transfers', true, false),
                  _buildProgressStep('Generating receipts', false, false),
                ],
              ),
            ),

            SizedBox(height: 40.h),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 48.w),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    backgroundColor: Colors.grey[800],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[500]!),
                    minHeight: 4.h,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'This may take a few moments for multiple transfers',
                    style: GoogleFonts.inter(
                      color: Colors.grey[500],
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: 60.h),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 32.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.security,
                    color: Colors.green[400],
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'All transfers are secured with bank-level encryption',
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStep(String title, bool isCompleted, bool isActive) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green[500]
                  : isActive
                      ? Colors.blue[500]
                      : Colors.grey[600],
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCompleted ? Icons.check : Icons.circle,
              color: Colors.white,
              size: 16.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                color: isCompleted || isActive ? Colors.white : Colors.grey[500],
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
