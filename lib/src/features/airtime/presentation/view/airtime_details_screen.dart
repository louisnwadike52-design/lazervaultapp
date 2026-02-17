import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/network_provider.dart';
import '../../services/airtime_pdf_service.dart';
import '../utils/airtime_navigation_utils.dart';

class AirtimeDetailsScreen extends StatefulWidget {
  const AirtimeDetailsScreen({super.key});

  @override
  State<AirtimeDetailsScreen> createState() => _AirtimeDetailsScreenState();
}

class _AirtimeDetailsScreenState extends State<AirtimeDetailsScreen> {
  AirtimeTransaction? _transaction;
  bool _isDownloading = false;
  bool _isSharing = false;

  @override
  void initState() {
    super.initState();
    _loadArguments();
  }

  void _loadArguments() {
    final args = Get.arguments;
    if (args is Map<String, dynamic> && args.containsKey('transaction')) {
      _transaction = args['transaction'] as AirtimeTransaction;
    } else if (args is String) {
      // Deep-link fallback: fetch by ID
      context.read<AirtimeCubit>().loadTransactionDetails(args);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E27),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1F1F1F),
              Color(0xFF0A0E27),
              Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),

              // Content
              Expanded(
                child: _transaction != null
                    ? _buildTransactionDetails(_transaction!)
                    : BlocBuilder<AirtimeCubit, AirtimeState>(
                        builder: (context, state) {
                          if (state is AirtimeTransactionDetailsLoaded) {
                            return _buildTransactionDetails(state.transaction);
                          } else if (state is AirtimeError) {
                            return _buildErrorState(state.message);
                          }
                          return _buildLoadingState();
                        },
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
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],

              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),

          SizedBox(width: 16.w),

          // Title
          Expanded(
            child: Text(
              'Transaction Details',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),

          // Share button
          GestureDetector(
            onTap: () => _shareTransaction(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],

              ),
              child: _isSharing
                  ? Padding(
                      padding: EdgeInsets.all(10.w),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 20.sp,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetails(AirtimeTransaction transaction) {
    // Create a mock network provider from transaction data
    final networkProvider = NetworkProvider(
      id: transaction.networkProvider.name,
      type: transaction.networkProvider,
      name: transaction.networkProvider.displayName,
      shortName: transaction.networkProvider.shortName,
      logo: transaction.networkProvider.logo,
      primaryColor: transaction.networkProvider.primaryColor,
      prefixes: transaction.networkProvider.prefixes,
      countryCode: 'NG', // Default to Nigeria
    );

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),

          // Status card
          _buildStatusCard(transaction),

          SizedBox(height: 24.h),

          // Transaction summary
          _buildTransactionSummary(transaction, networkProvider),

          SizedBox(height: 24.h),

          // Transaction details
          _buildTransactionDetailsCard(transaction, networkProvider),

          SizedBox(height: 24.h),

          // Payment breakdown
          _buildPaymentBreakdown(transaction),

          SizedBox(height: 32.h),

          // Action buttons
          _buildActionButtons(transaction),

          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildStatusCard(AirtimeTransaction transaction) {
    final isSuccess = transaction.status == AirtimeTransactionStatus.completed;
    final isPending = transaction.status == AirtimeTransactionStatus.pending ||
                     transaction.status == AirtimeTransactionStatus.processing;
    final isFailed = transaction.status == AirtimeTransactionStatus.failed;

    Color statusColor;
    IconData statusIcon;
    String statusMessage;

    if (isSuccess) {
      statusColor = Color(0xFF10B981);
      statusIcon = Icons.check_circle;
      statusMessage = 'Transaction completed successfully';
    } else if (isPending) {
      statusColor = Color(0xFFFFA500);
      statusIcon = Icons.access_time;
      statusMessage = 'Transaction is being processed';
    } else if (isFailed) {
      statusColor = Color(0xFFEF4444);
      statusIcon = Icons.error;
      statusMessage = transaction.failureReason ?? 'Transaction failed';
    } else {
      statusColor = Color(0xFF6B46C1);
      statusIcon = Icons.refresh;
      statusMessage = 'Transaction was refunded';
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],

      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              statusIcon,
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
                  transaction.status.displayName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  statusMessage,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.6),
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

  Widget _buildTransactionSummary(AirtimeTransaction transaction, NetworkProvider networkProvider) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],

      ),
      child: Column(
        children: [
          // Network provider and amount
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: networkProvider.type.color,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: networkProvider.type.color.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    networkProvider.name.substring(0, 1),
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 16.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${networkProvider.name} Airtime',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      transaction.formattedRecipientNumber,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Amount display
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Text(
                  'Amount',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '${transaction.currencySymbol}${transaction.amount.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetailsCard(AirtimeTransaction transaction, NetworkProvider networkProvider) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Information',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 16.h),

          _buildDetailRow('Transaction ID', transaction.transactionReference),
          _buildDivider(),
          _buildDetailRow('Phone Number', transaction.formattedRecipientNumber),

          if (transaction.recipientName != null && transaction.recipientName!.isNotEmpty) ...[
            _buildDivider(),
            _buildDetailRow('Recipient Name', transaction.recipientName!),
          ],

          _buildDivider(),
          _buildDetailRow('Network Provider', networkProvider.name),
          _buildDivider(),
          _buildDetailRow('Date & Time', DateFormat('MMMM dd, yyyy \u2022 hh:mm a').format(transaction.createdAt)),

          if (transaction.completedAt != null) ...[
            _buildDivider(),
            _buildDetailRow('Completed At', DateFormat('MMMM dd, yyyy \u2022 hh:mm a').format(transaction.completedAt!)),
          ],

          _buildDivider(),
          _buildDetailRow('Status', transaction.status.displayName,
            valueColor: transaction.status.color),
        ],
      ),
    );
  }

  Widget _buildPaymentBreakdown(AirtimeTransaction transaction) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Breakdown',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 16.h),

          _buildBreakdownRow('Airtime Amount', '${transaction.currencySymbol}${transaction.amount.toStringAsFixed(0)}'),


          if (transaction.fee != null) ...[
            SizedBox(height: 8.h),
            _buildBreakdownRow('Service Fee', '${transaction.currencySymbol}${transaction.fee!.toStringAsFixed(0)}'),
          ],

          SizedBox(height: 12.h),
          Divider(color: Colors.white.withValues(alpha: 0.1)),
          SizedBox(height: 12.h),

          _buildBreakdownRow('Total Amount', '${transaction.currencySymbol}${transaction.totalAmount.toStringAsFixed(0)}', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.6),
              fontWeight: FontWeight.w400,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: valueColor ?? Colors.white,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: Colors.white.withValues(alpha: isTotal ? 1.0 : 0.6),
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isTotal
                ? Colors.white
                : Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(AirtimeTransaction transaction) {
    return Column(
      children: [
        // Repeat Transaction Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => repeatAirtimeTransaction(context, transaction),
            icon: Icon(
              Icons.repeat,
              color: Colors.white,
              size: 20.sp,
            ),
            label: Text(
              'Repeat Transaction',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF3B82F6),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 0,
            ),
          ),
        ),

        SizedBox(height: 12.h),

        // Download Receipt Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _isDownloading ? null : () => _downloadReceipt(transaction),
            icon: _isDownloading
                ? SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withValues(alpha: 0.8)),
                    ),
                  )
                : Icon(
                    Icons.download,
                    color: Colors.white.withValues(alpha: 0.8),
                    size: 20.sp,
                  ),
            label: Text(
              _isDownloading ? 'Downloading...' : 'Download Receipt',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1.5,
              ),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      height: 1,
      color: Colors.white.withValues(alpha: 0.1),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading transaction details...',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.6),
            ),
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
            color: Colors.red.withValues(alpha: 0.6),
          ),
          SizedBox(height: 16.h),
          Text(
            'Error',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF3B82F6),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Go Back',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _shareTransaction() async {
    final transaction = _transaction;
    if (transaction == null || _isSharing) return;

    setState(() => _isSharing = true);
    try {
      await AirtimePdfService.shareReceipt(transaction: transaction);
    } catch (e) {
      if (mounted) {
        Get.snackbar(
          'Share Failed',
          'Could not share receipt. Please try again.',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  Future<void> _downloadReceipt(AirtimeTransaction transaction) async {
    if (_isDownloading) return;

    setState(() => _isDownloading = true);
    try {
      final filePath = await AirtimePdfService.downloadReceipt(
        transaction: transaction,
      );
      if (mounted) {
        Get.snackbar(
          'Receipt Downloaded',
          'Saved to: $filePath',
          backgroundColor: const Color(0xFF10B981),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      if (mounted) {
        Get.snackbar(
          'Download Failed',
          'Could not download receipt. Please try again.',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }
}
