import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/network_provider.dart';

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
              Color(0xFF1A1A3E),
              Color(0xFF0A0E27),
              Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
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
                  
                  SizedBox(height: 40.h),
                  
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
                color: (isSuccess ? Color(0xFF10B981) : Color(0xFFEF4444)).withOpacity(0.3),
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
            color: Colors.white.withOpacity(0.6),
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
            color: Colors.black.withOpacity(0.2),
            blurRadius: 30,
            offset: Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              // Receipt header
              _buildReceiptHeader(),
              
              // Receipt body
              _buildReceiptBody(),
              
              // Receipt footer
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
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
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
                  color: _getProviderColor(transaction!.networkProvider),
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
                        color: Colors.white.withOpacity(0.8),
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
            '₦${transaction!.amount.toStringAsFixed(0)}',
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
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _buildReceiptRow('Airtime Amount', '₦${transaction!.amount.toStringAsFixed(0)}'),
                  if (transaction!.discount != null && transaction!.discount! > 0) ...[
                    SizedBox(height: 8.h),
                    _buildReceiptRow('Discount', '-₦${transaction!.discount!.toStringAsFixed(0)}', 
                      valueColor: Color(0xFF10B981)),
                  ],
                  if (transaction!.fee != null) ...[
                    SizedBox(height: 8.h),
                    _buildReceiptRow('Service Fee', '₦${transaction!.fee!.toStringAsFixed(0)}'),
                  ],
                  SizedBox(height: 12.h),
                  Container(
                    height: 1,
                    color: Colors.white.withOpacity(0.1),
                  ),
                  SizedBox(height: 12.h),
                  _buildReceiptRow('Total Paid', '₦${transaction!.totalAmount.toStringAsFixed(0)}', 
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
        color: Colors.white.withOpacity(0.02),
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
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
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Keep this receipt for your records',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.w400,
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
            color: Colors.white.withOpacity(isTotal ? 1.0 : 0.6),
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: valueColor ?? (isTotal ? Colors.white : Colors.white.withOpacity(0.8)),
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
      color: Colors.white.withOpacity(0.1),
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
                backgroundColor: Color(0xFF6366F1),
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
                    side: BorderSide(color: Colors.white.withOpacity(0.2)),
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
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
              
              SizedBox(width: 12.w),
              
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.toNamed(AppRoutes.airtimeHistory),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white.withOpacity(0.2)),
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
                      color: Colors.white.withOpacity(0.8),
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

  Color _getProviderColor(NetworkProviderType type) {
    switch (type) {
      case NetworkProviderType.mtn:
        return Color(0xFFFFCC00);
      case NetworkProviderType.airtel:
        return Color(0xFFFF0000);
      case NetworkProviderType.glo:
        return Color(0xFF00B04F);
      case NetworkProviderType.etisalat:
      case NetworkProviderType.ninemobile:
        return Color(0xFF00AA4F);
      default:
        return Color(0xFF6366F1); // Default blue color
    }
  }
} 