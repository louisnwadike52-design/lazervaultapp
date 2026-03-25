import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/airtime_to_cash_conversion.dart';

class A2CResultScreen extends StatefulWidget {
  const A2CResultScreen({super.key});

  @override
  State<A2CResultScreen> createState() => _A2CResultScreenState();
}

class _A2CResultScreenState extends State<A2CResultScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  bool isSuccess = false;
  String? errorMessage;
  AirtimeToCashConversion? conversion;
  double? newBalance;
  String? phoneNumber;
  String? network;
  double? amount;
  double? estimatedCash;

  @override
  void initState() {
    super.initState();
    _loadArguments();
    _setupAnimations();
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      isSuccess = args['isSuccess'] ?? false;
      errorMessage = args['errorMessage'];
      conversion = args['conversion'];
      newBalance = args['newBalance'];
      phoneNumber = args['phoneNumber'];
      network = args['network'];
      amount = args['amount'];
      estimatedCash = args['estimatedCash'];
    }
  }

  void _setupAnimations() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
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
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
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
                if (isSuccess && conversion != null)
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: _buildReceiptCard(),
                    ),
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
            color: isSuccess
                ? const Color(0xFF10B981)
                : const Color(0xFFEF4444),
            boxShadow: [
              BoxShadow(
                color: (isSuccess
                        ? const Color(0xFF10B981)
                        : const Color(0xFFEF4444))
                    .withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
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
          isSuccess ? 'Conversion Successful!' : 'Conversion Failed',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),

        SizedBox(height: 12.h),

        // Status message
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            isSuccess
                ? '\u20A6${conversion?.cashAmount.toStringAsFixed(2) ?? estimatedCash?.toStringAsFixed(2) ?? '0.00'} credited to your wallet'
                : errorMessage ?? 'Something went wrong with your conversion',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.6),
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildReceiptCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1F1F1F),
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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3B82F6), Color.fromARGB(255, 78, 3, 208)],
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
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.swap_horiz,
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
                      'Airtime to Cash',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      conversion?.network ?? network ?? '',
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
          // Cash amount
          Text(
            '\u20A6${conversion?.cashAmount.toStringAsFixed(2) ?? '0.00'}',
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Cash Received',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.7),
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
          if (conversion?.reference != null) ...[
            _buildReceiptRow('Reference', conversion!.reference),
            _buildDivider(),
          ],
          _buildReceiptRow(
              'Phone Number', conversion?.phoneNumber ?? phoneNumber ?? ''),
          _buildDivider(),
          _buildReceiptRow('Network', conversion?.network ?? network ?? ''),
          _buildDivider(),
          _buildReceiptRow(
            'Airtime Amount',
            '\u20A6${conversion?.airtimeAmount.toStringAsFixed(2) ?? amount?.toStringAsFixed(2) ?? '0.00'}',
          ),
          _buildDivider(),
          _buildReceiptRow(
            'Conversion Rate',
            conversion?.ratePercentage ?? '',
          ),
          _buildDivider(),
          _buildReceiptRow(
            'Fee',
            '\u20A6${conversion?.fee.toStringAsFixed(2) ?? '0.00'}',
          ),
          _buildDivider(),
          _buildReceiptRow(
            'Status',
            conversion?.status.displayName ?? 'Completed',
            valueColor: const Color(0xFF10B981),
          ),
          if (conversion?.createdAt != null) ...[
            _buildDivider(),
            _buildReceiptRow(
              'Date & Time',
              DateFormat('MMM dd, yyyy \u2022 hh:mm a')
                  .format(conversion!.createdAt),
            ),
          ],

          // New balance section
          if (newBalance != null) ...[
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Balance',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                  Text(
                    '\u20A6${newBalance!.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF10B981),
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

  Widget _buildReceiptRow(String label, String value,
      {Color? valueColor, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: Colors.white
                .withValues(alpha: isTotal ? 1.0 : 0.6),
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: valueColor ??
                  (isTotal
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.8)),
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
          // Primary: Done
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.offAllNamed(AppRoutes.billsHub),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Done',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Secondary actions
          Row(
            children: [
              if (!isSuccess)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        Get.offAllNamed(AppRoutes.airtimeToCash),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF1F1F1F)),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Try Again',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ),
              if (isSuccess)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        Get.offAllNamed(AppRoutes.airtimeToCash),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF1F1F1F)),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Convert More',
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
                  onPressed: () =>
                      Get.toNamed(AppRoutes.airtimeToCashHistory),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF1F1F1F)),
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
