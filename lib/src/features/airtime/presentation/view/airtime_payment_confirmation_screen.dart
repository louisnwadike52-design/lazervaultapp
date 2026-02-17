import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/network_provider.dart';
import '../../services/airtime_pdf_service.dart';

class AirtimePaymentConfirmationScreen extends StatefulWidget {
  const AirtimePaymentConfirmationScreen({super.key});

  @override
  State<AirtimePaymentConfirmationScreen> createState() => _AirtimePaymentConfirmationScreenState();
}

class _AirtimePaymentConfirmationScreenState extends State<AirtimePaymentConfirmationScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  AirtimeTransaction? transaction;
  bool isSuccess = false;
  String? errorMessage;
  bool _isDownloading = false;
  bool _isSharing = false;

  @override
  void initState() {
    super.initState();
    _loadArguments();
    _setupAnimations();
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      transaction = args['transaction'];
      isSuccess = args['isSuccess'] ?? false;
      errorMessage = args['errorMessage'];
    }
  }

  void _setupAnimations() {
    _slideController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    _slideController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _downloadReceipt() async {
    if (transaction == null || _isDownloading) return;

    setState(() => _isDownloading = true);
    try {
      final filePath = await AirtimePdfService.downloadReceipt(
        transaction: transaction!,
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

  Future<void> _shareReceipt() async {
    if (transaction == null || _isSharing) return;

    setState(() => _isSharing = true);
    try {
      await AirtimePdfService.shareReceipt(
        transaction: transaction!,
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
            ),
            child: Column(
              children: [
                SizedBox(height: 40.h),

                // Status icon and message
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildStatusSection(),
                ),

                SizedBox(height: 40.h),

                // Receipt card
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildReceiptCard(),
                  ),
                ),

                SizedBox(height: 24.h),

                // Download/Share buttons (only on success)
                if (isSuccess && transaction != null)
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildReceiptActions(),
                  ),

                SizedBox(height: 24.h),

                // Action buttons
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildActionButtons(),
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusSection() {
    return Column(
      children: [
        // Status icon
        Container(
          width: 100.w,
          height: 100.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSuccess ? Color(0xFF10B981) : Color(0xFFEF4444),
            boxShadow: [
              BoxShadow(
                color: (isSuccess ? Color(0xFF10B981) : Color(0xFFEF4444)).withValues(alpha: 0.3),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            isSuccess ? Icons.check : Icons.close,
            color: Colors.white,
            size: 48.sp,
          ),
        ),

        SizedBox(height: 24.h),

        // Status title
        Text(
          isSuccess ? 'Payment Successful!' : 'Payment Failed',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),

        SizedBox(height: 12.h),

        // Status message
        Text(
          isSuccess
            ? 'Your airtime purchase has been completed successfully'
            : errorMessage ?? 'Something went wrong with your payment',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white.withValues(alpha: 0.6),
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildReceiptCard() {
    if (transaction == null) return SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 30,
            offset: Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
          ),
          child: Column(
            children: [
              _buildReceiptHeader(),
              _buildReceiptBody(),
              _buildReceiptFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptHeader() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: transaction!.networkProvider.color,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    transaction!.networkProvider.displayName.substring(0, 1),
                    style: TextStyle(
                      fontSize: 20.sp,
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
                      'Airtime Purchase',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      transaction!.networkProvider.displayName,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Amount
          Text(
            '${transaction!.currencySymbol}${transaction!.amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptBody() {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          _buildReceiptRow('Transaction ID', transaction!.transactionReference),
          _buildDivider(),
          _buildReceiptRow('Phone Number', transaction!.formattedRecipientNumber),
          if (transaction!.recipientName != null && transaction!.recipientName!.isNotEmpty) ...[
            _buildDivider(),
            _buildReceiptRow('Recipient', transaction!.recipientName!),
          ],
          _buildDivider(),
          _buildReceiptRow('Network Provider', transaction!.networkProvider.displayName),
          _buildDivider(),
          _buildReceiptRow('Date & Time', DateFormat('MMM dd, yyyy • hh:mm a').format(transaction!.createdAt)),
          _buildDivider(),
          _buildReceiptRow('Status', transaction!.status.displayName,
            valueColor: isSuccess ? Color(0xFF10B981) : Color(0xFFEF4444)),

          if (transaction!.fee != null || transaction!.discount != null) ...[
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _buildReceiptRow('Airtime Amount', '${transaction!.currencySymbol}${transaction!.amount.toStringAsFixed(0)}'),
                  if (transaction!.fee != null) ...[
                    SizedBox(height: 8.h),
                    _buildReceiptRow('Service Fee', '${transaction!.currencySymbol}${transaction!.fee!.toStringAsFixed(0)}'),
                  ],
                  SizedBox(height: 12.h),
                  Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  SizedBox(height: 12.h),
                  _buildReceiptRow('Total Paid', '${transaction!.currencySymbol}${transaction!.totalAmount.toStringAsFixed(0)}',
                    isTotal: true),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReceiptFooter() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withValues(alpha: 0.5),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Thank you for using LazerVault',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Keep this receipt for your records',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white.withValues(alpha: 0.5),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptActions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _isDownloading ? null : _downloadReceipt,
              icon: _isDownloading
                  ? SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                      ),
                    )
                  : Icon(Icons.download, size: 18.sp),
              label: Text(
                _isDownloading ? 'Downloading...' : 'Download',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF3B82F6),
                side: const BorderSide(color: Color(0xFF3B82F6)),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _isSharing ? null : _shareReceipt,
              icon: _isSharing
                  ? SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                      ),
                    )
                  : Icon(Icons.share, size: 18.sp),
              label: Text(
                _isSharing ? 'Sharing...' : 'Share',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF3B82F6),
                side: const BorderSide(color: Color(0xFF3B82F6)),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value, {Color? valueColor, bool isTotal = false}) {
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
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: valueColor ?? (isTotal ? Colors.white : Colors.white.withValues(alpha: 0.8)),
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      height: 1,
      color: Colors.white.withValues(alpha: 0.1),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          // Primary action button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF3B82F6),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Back to Dashboard',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Secondary action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.offAllNamed(AppRoutes.airtime),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFF1F1F1F)),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Buy More Airtime',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.toNamed(AppRoutes.airtimeHistory),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFF1F1F1F)),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'View History',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
