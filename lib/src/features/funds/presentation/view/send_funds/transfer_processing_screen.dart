import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/account_cards_summary/services/balance_websocket_service.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/balance_websocket_cubit.dart';

/// Transfer processing states from backend
enum TransferProcessingStatus {
  initiated,
  validating,
  processing,
  completed,
  failed,
}

class TransferProcessingScreen extends StatefulWidget {
  const TransferProcessingScreen({super.key});

  @override
  State<TransferProcessingScreen> createState() => _TransferProcessingScreenState();
}

class _TransferProcessingScreenState extends State<TransferProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _processingController;
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  Map<String, dynamic> transferDetails = {};
  TransferProcessingStatus _currentStatus = TransferProcessingStatus.initiated;
  String _statusMessage = 'Initiating transfer...';
  bool _isCompleted = false;
  StreamSubscription<BalanceWebSocketState>? _stateSubscription;
  BalanceUpdateEvent? _lastProcessedEvent;
  Timer? _timeoutTimer;

  // Status steps for progress display
  final List<_ProcessingStep> _steps = [
    _ProcessingStep(
      status: TransferProcessingStatus.initiated,
      title: 'Transfer Initiated',
      description: 'Request received',
      icon: Icons.receipt_outlined,
    ),
    _ProcessingStep(
      status: TransferProcessingStatus.validating,
      title: 'Validating',
      description: 'Checking account details',
      icon: Icons.verified_user_outlined,
    ),
    _ProcessingStep(
      status: TransferProcessingStatus.processing,
      title: 'Processing',
      description: 'Sending to recipient bank',
      icon: Icons.sync_outlined,
    ),
    _ProcessingStep(
      status: TransferProcessingStatus.completed,
      title: 'Completed',
      description: 'Transfer successful',
      icon: Icons.check_circle_outline,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupAnimations();
    _connectToRealTimeUpdates();
    _startProcessingSimulation();
  }

  void _initializeData() {
    transferDetails = Get.arguments as Map<String, dynamic>? ?? {};
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

  /// Connect to WebSocket for real-time balance updates
  void _connectToRealTimeUpdates() {
    try {
      final balanceWebSocketCubit = context.read<BalanceWebSocketCubit>();

      // Listen to cubit state changes for balance updates
      _stateSubscription = balanceWebSocketCubit.stream.listen((state) {
        final event = state.lastUpdate;
        if (event != null && event != _lastProcessedEvent) {
          _lastProcessedEvent = event;
          _handleBalanceUpdate(event);
        }
      });

      // Log current state
      debugPrint('TransferProcessingScreen: Listening for WebSocket updates');
      debugPrint('TransferProcessingScreen: Expected reference: ${transferDetails['reference']}');
    } catch (e) {
      debugPrint('TransferProcessingScreen: Error connecting to WebSocket: $e');
      // Continue with simulation if WebSocket not available
    }
  }

  /// Handle balance update events from WebSocket
  void _handleBalanceUpdate(BalanceUpdateEvent event) {
    debugPrint('TransferProcessingScreen: Received balance update: ${event.eventType}, status: ${event.status}');

    // Check if this event is for our transfer
    final expectedTransactionId = transferDetails['transactionId'] as String?;
    final expectedReference = transferDetails['reference'] as String?;

    // Match by transaction ID, reference, or if it's a transfer_out event
    final isMatch = (expectedTransactionId != null && event.transactionId == expectedTransactionId) ||
        (expectedReference != null && event.reference == expectedReference) ||
        (event.eventType == 'transfer_out' && !_isCompleted);

    if (isMatch) {
      // Update status based on event
      switch (event.status.toLowerCase()) {
        case 'pending':
          _updateStatus(TransferProcessingStatus.validating, 'Validating transfer...');
          break;
        case 'processing':
          _updateStatus(TransferProcessingStatus.processing, 'Processing with bank...');
          break;
        case 'completed':
          _updateStatus(TransferProcessingStatus.completed, 'Transfer successful!');
          _completeTransfer();
          break;
        case 'failed':
          _handleTransferFailure(event.narration ?? 'Transfer failed');
          break;
      }
    }
  }

  /// Simulate processing steps (fallback when WebSocket doesn't send updates)
  void _startProcessingSimulation() {
    // Set a timeout - if no real update received, simulate progress
    _timeoutTimer = Timer(const Duration(seconds: 1), () {
      if (_currentStatus == TransferProcessingStatus.initiated && mounted) {
        _updateStatus(TransferProcessingStatus.validating, 'Validating account details...');
      }
    });

    // Continue simulation
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (_currentStatus == TransferProcessingStatus.validating && mounted && !_isCompleted) {
        _updateStatus(TransferProcessingStatus.processing, 'Sending to recipient...');
      }
    });

    // If no real completion received, complete after delay
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (!_isCompleted && mounted) {
        // Check if transfer was already successful from the API response
        final status = transferDetails['status'] as String?;
        if (status?.toLowerCase() == 'completed' ||
            status?.toLowerCase() == 'success' ||
            transferDetails['transferId'] != null) {
          _updateStatus(TransferProcessingStatus.completed, 'Transfer successful!');
          _completeTransfer();
        }
      }
    });
  }

  void _updateStatus(TransferProcessingStatus status, String message) {
    if (!mounted) return;

    setState(() {
      _currentStatus = status;
      _statusMessage = message;
    });
  }

  void _completeTransfer() {
    if (_isCompleted) return;

    _isCompleted = true;
    _processingController.stop();
    _pulseController.stop();

    // Short delay to show completion state
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        Get.offAllNamed(AppRoutes.transferProof, arguments: transferDetails);
      }
    });
  }

  void _handleTransferFailure(String reason) {
    if (!mounted) return;

    _processingController.stop();
    _pulseController.stop();

    // Show error and go back
    Get.snackbar(
      'Transfer Failed',
      reason,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withValues(alpha: 0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Get.back();
      }
    });
  }

  @override
  void dispose() {
    _processingController.dispose();
    _fadeController.dispose();
    _pulseController.dispose();
    _stateSubscription?.cancel();
    _timeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isCompleted ? 'Transfer Complete!' : 'Processing Transfer...',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  _statusMessage,
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
    final recipientName = transferDetails['recipientName'] ?? 'Recipient';
    final amount = transferDetails['amount'] ?? 0.0;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),

            // Processing Animation
            ScaleTransition(
              scale: _scaleAnimation,
              child: _buildProcessingIcon(),
            ),

            SizedBox(height: 32.h),

            // Transfer Details Card
            _buildTransferDetailsCard(recipientName, amount),

            SizedBox(height: 24.h),

            // Processing Steps
            _buildProcessingSteps(),

            SizedBox(height: 24.h),

            // Security Message
            _buildSecurityMessage(),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessingIcon() {
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
                          ? [Colors.green[600]!, Colors.green[400]!]
                          : [Colors.blue[700]!, Colors.blue[500]!],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (_isCompleted ? Colors.green : Colors.blue)
                            .withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Icon(
                    _isCompleted ? Icons.check : Icons.sync,
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

  Widget _buildTransferDetailsCard(String recipientName, dynamic amount) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Text(
            'Sending',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '\$${amount is double ? amount.toStringAsFixed(2) : amount}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'to $recipientName',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingSteps() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transfer Progress',
            style: GoogleFonts.inter(
              color: Colors.white,
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

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: isActive
                  ? (isCurrent ? Colors.blue : Colors.green).withValues(alpha: 0.2)
                  : Colors.grey.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive
                    ? (isCurrent ? Colors.blue : Colors.green)
                    : Colors.grey.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Icon(
              isActive && !isCurrent ? Icons.check : step.icon,
              color: isActive
                  ? (isCurrent ? Colors.blue : Colors.green)
                  : Colors.grey[600],
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
                    color: isActive ? Colors.white : Colors.grey[600],
                    fontSize: 14.sp,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                Text(
                  step.description,
                  style: GoogleFonts.inter(
                    color: isActive ? Colors.grey[400] : Colors.grey[700],
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
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[400]!),
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
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
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
              'Your transfer is secured with bank-level encryption',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
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
  final TransferProcessingStatus status;
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
