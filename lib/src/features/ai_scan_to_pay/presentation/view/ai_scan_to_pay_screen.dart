import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../domain/entities/scan_entities.dart';
import '../cubit/ai_scan_cubit.dart';
import '../cubit/ai_scan_state.dart';
import '../widgets/scan_type_card.dart';
import '../widgets/scan_history_card.dart';
import '../widgets/ai_chat_bottom_sheet.dart';
import 'ai_scan_camera_screen.dart';
import '../../../presentation/views/dashboard/dashboard_screen.dart';

class AiScanToPayScreen extends StatefulWidget {
  const AiScanToPayScreen({super.key});

  @override
  State<AiScanToPayScreen> createState() => _AiScanToPayScreenState();
}

class _AiScanToPayScreenState extends State<AiScanToPayScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AiScanCubit>().initializeScanTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offAll(() => const DashboardScreen()),
          icon: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black87,
              size: 20.sp,
            ),
          ),
        ),
        title: Text(
          'AI Scan to Pay',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.read<AiScanCubit>().loadScanHistory(),
            icon: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.history,
                color: const Color.fromARGB(255, 78, 3, 208),
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
        ],
      ),
      body: BlocConsumer<AiScanCubit, AiScanState>(
        listener: (context, state) {
          if (state is AiScanCamera) {
            Get.to(() => BlocProvider.value(
              value: context.read<AiScanCubit>(),
              child: const AiScanCameraScreen(),
            ));
          } else if (state is AiScanChatActive) {
            // Only show bottom sheet if it's not already showing
            if (Get.isBottomSheetOpen != true) {
              // Add small delay to ensure navigation from camera completes
              Future.delayed(const Duration(milliseconds: 300), () {
                if (mounted && Get.isBottomSheetOpen != true) {
                  _showAiChatBottomSheet(context, state);
                }
              });
            }
          } else if (state is AiScanPaymentProcessing) {
            // Show payment processing overlay
            _showPaymentProcessingOverlay(context, state);
          } else if (state is AiScanPaymentSuccess) {
            // Show payment success overlay
            _showPaymentSuccessOverlay(context, state);
          } else if (state is AiScanError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
        },
        builder: (context, state) {
          if (state is AiScanLoading) {
            return _buildLoadingState(state.message);
          } else if (state is AiScanTypeSelection) {
            return _buildScanTypeSelection(state.availableTypes);
          } else if (state is AiScanChatActive) {
            // Show scan type selection with bottom sheet
            return _buildScanTypeSelection(ScanType.values);
          } else if (state is AiScanHistoryLoaded) {
            return _buildScanHistory(state.sessions);
          } else if (state is AiScanError) {
            return _buildErrorState(state.message);
          }

          return _buildInitialState();
        },
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color.fromARGB(255, 78, 3, 208).withOpacity(0.1),
                  const Color.fromARGB(255, 78, 3, 208).withOpacity(0.05),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.qr_code_scanner,
              size: 60.sp,
              color: const Color.fromARGB(255, 78, 3, 208),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'AI-Powered Scan to Pay',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              'Scan any document, QR code, or image and let AI guide you through the payment process',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 40.h),
          ElevatedButton(
            onPressed: () => context.read<AiScanCubit>().initializeScanTypes(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 78, 3, 208),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 3,
            ),
            child: Text(
              'Get Started',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(String? message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              const Color.fromARGB(255, 78, 3, 208),
            ),
          ),
          if (message != null) ...[
            SizedBox(height: 16.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScanTypeSelection(List<ScanType> availableTypes) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color.fromARGB(255, 78, 3, 208),
                  const Color.fromARGB(255, 78, 3, 208).withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What would you like to scan?',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Choose the type of document or code you want to scan',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.85,
            ),
            itemCount: availableTypes.length,
            itemBuilder: (context, index) {
              final scanType = availableTypes[index];
              return ScanTypeCard(
                scanType: scanType,
                onTap: () => context.read<AiScanCubit>().startScanSession(scanType),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScanHistory(List<ScanSession> sessions) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Scan History',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () => context.read<AiScanCubit>().returnToScanTypeSelection(),
                child: Text(
                  'New Scan',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 78, 3, 208),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (sessions.isEmpty)
            Center(
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  Icon(
                    Icons.history,
                    size: 64.sp,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No scan history yet',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Start scanning to see your history here',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                return ScanHistoryCard(
                  session: session,
                  onTap: () {
                    // Handle history item tap
                  },
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.sp,
            color: Colors.red[400],
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => context.read<AiScanCubit>().reset(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 78, 3, 208),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Try Again',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentProcessingOverlay(BuildContext context, AiScanPaymentProcessing state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => BlocProvider.value(
        value: context.read<AiScanCubit>(),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(32.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    const Color.fromARGB(255, 78, 3, 208),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Processing Payment',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  state.status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPaymentSuccessOverlay(BuildContext context, AiScanPaymentSuccess state) {
    // Close any existing dialogs
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => BlocProvider.value(
        value: context.read<AiScanCubit>(),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(32.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40.sp,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Payment Successful!',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Transaction ID: ${state.transactionId}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Amount: \$${state.instruction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'To: ${state.instruction.recipient}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: () {
                    Get.back(); // Close dialog
                    context.read<AiScanCubit>().reset();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAiChatBottomSheet(BuildContext context, AiScanChatActive state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (modalContext) => BlocProvider.value(
        value: context.read<AiScanCubit>(),
        child: AiChatBottomSheet(
          session: state.session,
          messages: state.messages,
          extractedData: state.extractedData,
          isTyping: state.isTyping,
        ),
      ),
    ).then((_) {
      // Check if context is still mounted before using it
      if (mounted && context.mounted) {
        try {
          // Use a post frame callback to ensure proper state reset
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && context.mounted) {
              context.read<AiScanCubit>().returnToScanTypeSelection();
            }
          });
        } catch (e) {
          // Safely handle any context-related errors
          print('Error returning to scan type selection: $e');
        }
      }
    });
  }
} 