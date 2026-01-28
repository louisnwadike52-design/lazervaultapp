import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
  bool _isProcessing = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupAnimations();
    _startProcessing();
  }

  void _initializeData() {
    batchTransferDetails = Get.arguments as Map<String, dynamic>? ?? {};
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

  void _startProcessing() async {
    // Simulate processing time for batch transfer
    await Future.delayed(const Duration(seconds: 5));
    
    if (mounted) {
      _processingController.stop();
      setState(() {
        _isProcessing = false;
      });
      
      // Navigate to batch transfer receipt screen
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          Get.offAllNamed('/batch-transfer-receipt', arguments: batchTransferDetails);
        }
      });
    }
  }

  @override
  void dispose() {
    _processingController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  // Navigate to dashboard - used for all back navigation
  void _navigateToDashboard() {
    Get.offAllNamed('/home');
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
                  'Processing Batch Transfer...',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Please wait while we process your batch transfer',
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
    
    return Center(
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Processing Animation
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
            
            // Processing Text
            Text(
              'Processing your batch transfer...',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 16.h),
            
            // Batch Transfer Details
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  Text(
                    'Sending \$${totalAmount.toStringAsFixed(2)} to',
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
            
            // Progress Steps
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
            
            // Progress Indicator
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
            
            // Security Message
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