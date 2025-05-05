import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/presentation/views/notification_screen.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class DashboardCardSummary extends StatefulWidget {
  const DashboardCardSummary({super.key});

  @override
  State<DashboardCardSummary> createState() => _DashboardCardSummaryState();
}

class _DashboardCardSummaryState extends State<DashboardCardSummary> {
  // Define a type-safe structure for account data
  final List<Map<String, dynamic>> accounts = [
    {
      "accountType": "Personal Account",
      "currency": "GBP",
      "balance": 12000.00,
      "accountNumber": "•••• 7890",
      "trend": "+2.4%",
      "isUp": true, // Ensure boolean value is provided
    },
    {
      "accountType": "Savings Account",
      "currency": "GBP",
      "balance": 5430.00,
      "accountNumber": "•••• 5678",
      "trend": "+1.2%",
      "isUp": true, // Ensure boolean value is provided
    },
    {
      "accountType": "Investment Account",
      "currency": "GBP",
      "balance": 8750.00,
      "accountNumber": "•••• 9012",
      "trend": "-0.8%",
      "isUp": false, // Ensure boolean value is provided
    },
  ];

  int _currentIndex = 0;
  bool _showLocalDetails = true;
  bool _isCardActive = true;
  String _cardStatus = 'Active';
  Color _statusColor = Colors.green;
  final Map<String, bool> _securitySettings = {
    '3D Secure': true,
    'Contactless': true,
    'Online Payments': true,
  };
  bool _isPinVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 78, 3, 208),
            Color.fromARGB(255, 95, 20, 225),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: UniversalImageLoader(
                      imagePath: AppData.dp,
                      height: 40.h,
                      width: 40.w,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search transactions',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 14.sp,
                        ),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Colors.white.withOpacity(0.5),
                          size: 20.sp,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                _buildIconButton(Icons.notifications_outlined),
                SizedBox(width: 12.w),
                _buildIconButton(Icons.mic_rounded),
              ],
            ),

            // Cards Carousel
            SizedBox(height: 24.h),
            CarouselSlider.builder(
              itemCount: accounts.length,
              options: CarouselOptions(
                height: 200.h,
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() => _currentIndex = index);
                },
              ),
              itemBuilder: (context, index, realIndex) {
                final account = accounts[index];
                final bool isUp = account["isUp"] as bool; // Explicit casting

                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.15),
                            Colors.white.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                account["accountType"] as String,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 6.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isUp
                                          ? Colors.green.withOpacity(0.2)
                                          : Colors.red.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Text(
                                      account["trend"] as String,
                                      style: TextStyle(
                                        color: isUp
                                            ? Colors.green[300]
                                            : Colors.red[300],
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  GestureDetector(
                                    onTap: () => _showCardDetails(account),
                                    child: Container(
                                      width: 32.w,
                                      height: 32.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.2),
                                          width: 1,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.account_balance_outlined,
                                        color: Colors.white,
                                        size: 18.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            "£${(account["balance"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                account["accountNumber"] as String,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 14.sp,
                                ),
                              ),
                              Row(
                                children: [
                                  _buildActionButton(
                                    "Deposit",
                                    Icons.add_rounded,
                                    onTap: () {
                                      Get.toNamed(AppRoutes.depositFunds,
                                          arguments: {
                                            'selectedCard':
                                                accounts[_currentIndex],
                                          });
                                    },
                                  ),
                                  SizedBox(width: 12.w),
                                  _buildActionButton(
                                    "Withdraw",
                                    Icons.remove_rounded,
                                    onTap: () => Get.toNamed(
                                        AppRoutes.withdrawFunds,
                                        arguments: {
                                          'selectedCard':
                                              accounts[_currentIndex],
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Info Button
                  ],
                );
              },
            ),

            // Carousel Indicators
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                accounts.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: _currentIndex == index ? 24.w : 8.w,
                  height: 8.h,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 20.sp),
        onPressed: () {
          if (icon == Icons.notifications_outlined) {
            _showNotifications();
          }
        },
      ),
    );
  }

  void _showNotifications() {
    Get.bottomSheet(
      FractionallySizedBox(
        heightFactor: 0.9,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24.r),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 12.h),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              // Notification Screen
              Expanded(
                child: NotificationScreen(),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      enterBottomSheetDuration: Duration(milliseconds: 300),
      exitBottomSheetDuration: Duration(milliseconds: 200),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildActionButton(String label, IconData icon,
      {required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 16.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCardDetails(Map<String, dynamic> account) {
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return FractionallySizedBox(
              heightFactor: 0.9,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.r),
                  ),
                ),
                child: Column(
                  children: [
                    // Handle bar
                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 12.h),
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),

                    // Content
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Icon(
                                      Icons.credit_card_rounded,
                                      color: Colors.white,
                                      size: 24.sp,
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Text(
                                    'Card Details',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 16.h),

                              // Enhanced Tabs
                              Container(
                                height: 56.h,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Stack(
                                  children: [
                                    // Animated Selection Indicator
                                    AnimatedPositioned(
                                      duration: Duration(milliseconds: 200),
                                      left: _showLocalDetails
                                          ? 0
                                          : Get.width * 0.5 - 40.w,
                                      child: Container(
                                        width: Get.width * 0.5 - 40.w,
                                        height: 56.h,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.blue.withOpacity(0.2),
                                              Colors.purple.withOpacity(0.2),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          border: Border.all(
                                            color:
                                                Colors.white.withOpacity(0.1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Tab Buttons
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () => setState(
                                                () => _showLocalDetails = true),
                                            child: Container(
                                              color: Colors.transparent,
                                              width: double.infinity,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.credit_card,
                                                    color: _showLocalDetails
                                                        ? Colors.white
                                                        : Colors.white
                                                            .withOpacity(0.5),
                                                    size: 20.sp,
                                                  ),
                                                  SizedBox(height: 4.h),
                                                  Text(
                                                    'Local Card',
                                                    style: TextStyle(
                                                      color: _showLocalDetails
                                                          ? Colors.white
                                                          : Colors.white
                                                              .withOpacity(0.5),
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () => setState(() =>
                                                _showLocalDetails = false),
                                            child: Container(
                                              color: Colors.transparent,
                                              width: double.infinity,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.language,
                                                    color: !_showLocalDetails
                                                        ? Colors.white
                                                        : Colors.white
                                                            .withOpacity(0.5),
                                                    size: 20.sp,
                                                  ),
                                                  SizedBox(height: 4.h),
                                                  Text(
                                                    'International',
                                                    style: TextStyle(
                                                      color: !_showLocalDetails
                                                          ? Colors.white
                                                          : Colors.white
                                                              .withOpacity(0.5),
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 16.h),

                              // Card Visual Preview
                              Container(
                                height: 200.h,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF1A237E),
                                      Color(0xFF0D47A1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                padding: EdgeInsets.all(20.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'LazerVault',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: _showPINWithAuthentication,
                                          icon: Icon(
                                            Icons.pin_drop_outlined,
                                            color: Colors.white,
                                            size: 24.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          account["accountNumber"] as String,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                        SizedBox(height: 16.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'CARD HOLDER',
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.7),
                                                fontSize: 10.sp,
                                              ),
                                            ),
                                            Text(
                                              'EXPIRES',
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.7),
                                                fontSize: 10.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'JOHN DOE',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              '12/25',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Card Details Sections
                              SizedBox(height: 20.h),
                              Text(
                                _showLocalDetails
                                    ? 'Local Card Details'
                                    : 'International Card Details',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              _buildDetailSection(
                                'Card Information',
                                [
                                  _buildDetailRow(
                                      'Card Type',
                                      _showLocalDetails
                                          ? 'Local Debit'
                                          : 'International Debit'),
                                  _buildDetailRow('Currency',
                                      account["currency"] as String),
                                  _buildDetailRow('Status', 'Active',
                                      isHighlighted: true, isPositive: true),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              _buildDetailSection(
                                'Account Details',
                                [
                                  _buildCopyableDetailRow(
                                    'Beneficiary',
                                    'Louis Nwadike',
                                    onCopy: () => _copyToClipboard(
                                        'Louis Nwadike', 'Beneficiary name'),
                                  ),
                                  _buildCopyableDetailRow(
                                    'IBAN',
                                    'GB44 REVO 0099 7019 8493 64',
                                    onCopy: () => _copyToClipboard(
                                        'GB44 REVO 0099 7019 8493 64', 'IBAN'),
                                  ),
                                  _buildCopyableDetailRow(
                                    'BIC/SWIFT code',
                                    'REVOGB21',
                                    onCopy: () => _copyToClipboard(
                                        'REVOGB21', 'BIC/SWIFT code'),
                                  ),
                                  _buildCopyableDetailRow(
                                    'Address',
                                    'Revolut Ltd\n7 Westferry Circus, E14 4HD, London, United Kingdom',
                                    onCopy: () => _copyToClipboard(
                                      'Revolut Ltd\n7 Westferry Circus, E14 4HD, London, United Kingdom',
                                      'Address',
                                    ),
                                  ),
                                  _buildCopyableDetailRow(
                                    'Correspondent bank BIC',
                                    'CHASGB2L',
                                    onCopy: () => _copyToClipboard(
                                        'CHASGB2L', 'Correspondent bank BIC'),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              _buildDetailSection(
                                'Spending Limits',
                                [
                                  _buildDetailRow('Daily Limit', '£5,000'),
                                  _buildDetailRow('Monthly Limit', '£50,000'),
                                  _buildDetailRow('Available Balance',
                                      "£${(account["balance"] as double).toStringAsFixed(2)}"),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              _buildDetailSection(
                                'Security',
                                [
                                  _buildSwitchDetailRow('3D Secure', true),
                                  _buildSwitchDetailRow('Contactless', true),
                                  _buildSwitchDetailRow(
                                      'Online Payments', true),
                                ],
                              ),

                              // Add after the Security section and before Action Buttons
                              SizedBox(height: 16.h),
                              _buildDetailSection(
                                'Card Controls',
                                [
                                  _buildCardBlockingRow(),
                                ],
                              ),

                              // Action Buttons
                              SizedBox(height: 20.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildCardActionButton(
                                      'Copy Details',
                                      Icons.copy_rounded,
                                      () {
                                        Clipboard.setData(ClipboardData(
                                          text:
                                              'Card Number: ${account["accountNumber"]}\n'
                                              'Expiry: 12/25\n'
                                              'Currency: ${account["currency"]}',
                                        ));
                                        Get.snackbar(
                                          'Success',
                                          'Card details copied to clipboard',
                                          backgroundColor: Colors.green,
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.BOTTOM,
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: _buildCardActionButton(
                                      'Share Details',
                                      Icons.share_rounded,
                                      () {
                                        // Implement share functionality
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              // Add after the Action Buttons section and before Security Notice
                              SizedBox(height: 24.h),
                              Text(
                                'Documents',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Column(
                                children: [
                                  _buildDocumentButton(
                                    'Account Statement',
                                    'View and download your monthly statements',
                                    Icons.description_outlined,
                                    onTap: () {
                                      // Implement statement download/view
                                      Get.snackbar(
                                        'Download Started',
                                        'Your statement is being prepared',
                                        backgroundColor:
                                            Colors.blue.withOpacity(0.1),
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: Duration(seconds: 2),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 12.h),
                                  _buildDocumentButton(
                                    'Account Confirmation',
                                    'Download your account confirmation letter',
                                    Icons.verified_outlined,
                                    onTap: () {
                                      // Implement confirmation letter download/view
                                      Get.snackbar(
                                        'Download Started',
                                        'Your confirmation letter is being prepared',
                                        backgroundColor:
                                            Colors.blue.withOpacity(0.1),
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: Duration(seconds: 2),
                                      );
                                    },
                                  ),
                                ],
                              ),

                              // Add after the Documents section and before Security Notice
                              SizedBox(height: 24.h),
                              _buildTransferInfoSection(),
                              SizedBox(height: 16.h),
                              _buildCurrencyTransferButton(),
                              SizedBox(height: 16.h),
                              _buildGetHelpButton(),

                              // Security Notice
                              SizedBox(height: 20.h),
                              Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.shield_rounded,
                                      color: Colors.blue[300],
                                      size: 16.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Text(
                                        'Your card details are protected with end-to-end encryption',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      enterBottomSheetDuration: Duration(milliseconds: 300),
      exitBottomSheetDuration: Duration(milliseconds: 200),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> details) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12.h),
          ...details,
        ],
      ),
    );
  }

  Widget _buildCardActionButton(
      String label, IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value,
      {bool isHighlighted = false, bool isPositive = true}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isHighlighted
                  ? (isPositive ? Colors.green[300] : Colors.red[300])
                  : Colors.white,
              fontSize: 14.sp,
              fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentButton(
    String title,
    String subtitle,
    IconData icon, {
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  icon,
                  color: Colors.blue[300],
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white.withOpacity(0.5),
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransferInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
          Icons.account_balance_outlined,
          'Your money is held in licensed banks.',
          'Learn more',
        ),
        SizedBox(height: 12.h),
        _buildInfoRow(
          Icons.schedule,
          'Transfers usually take 3 to 5 business days to appear in your Lazervault account',
        ),
        SizedBox(height: 12.h),
        _buildInfoRow(
          Icons.currency_exchange,
          'Intermediary or sender\'s bank may charge you for international payments',
        ),
        SizedBox(height: 12.h),
        _buildInfoRow(
          Icons.flag_outlined,
          'Only SWIFT transfers are accepted. For local transfers, please use the local details found above',
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text,
      [String? linkText, VoidCallback? onTap]) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 2.h),
            child: Icon(
              icon,
              color: Colors.white.withOpacity(0.7),
              size: 18.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                if (linkText != null)
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      linkText,
                      style: TextStyle(
                        color: Colors.green[400],
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyTransferButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Implement currency transfer action
        },
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.swap_horiz_rounded,
                  color: Colors.green[400],
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transfer in another currency?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Get account details for other currencies',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white.withOpacity(0.5),
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGetHelpButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Implement get help action
        },
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Row(
            children: [
              Text(
                'Get help',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white.withOpacity(0.5),
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCopyableDetailRow(
    String label,
    String value, {
    required VoidCallback onCopy,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.green[400],
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onCopy,
                    borderRadius: BorderRadius.circular(8.r),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.copy_rounded,
                        color: Colors.white.withOpacity(0.7),
                        size: 16.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Copied!',
      '$label copied to clipboard',
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(16),
      borderRadius: 8,
      icon: Icon(
        Icons.check_circle_outline_rounded,
        color: Colors.green[400],
      ),
    );
  }

  Widget _buildSwitchDetailRow(String label, bool isEnabled) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: _isCardActive
                  ? Colors.white.withOpacity(0.7)
                  : Colors.white.withOpacity(0.3),
              fontSize: 14.sp,
            ),
          ),
          GestureDetector(
            onTap: _isCardActive
                ? () {
                    setState(() {
                      _securitySettings[label] = !_securitySettings[label]!;
                    });
                  }
                : null,
            child: Container(
              width: 44.w,
              height: 24.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: (_isCardActive && _securitySettings[label]!)
                    ? Colors.green.withOpacity(0.2)
                    : Colors.white.withOpacity(0.1),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    left: (_isCardActive && _securitySettings[label]!)
                        ? 20.w
                        : 2.w,
                    top: 2.h,
                    child: Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (_isCardActive && _securitySettings[label]!)
                            ? Colors.green[400]
                            : Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBlockingRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Card Status',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14.sp,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 6.h,
              ),
              decoration: BoxDecoration(
                color: _statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                _cardStatus,
                style: TextStyle(
                  color: _statusColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        if (_isCardActive) ...[
          SizedBox(height: 16.h),
          _buildBlockButton(
            'Report Stolen Card',
            'Immediately block card and request replacement',
            Icons.gpp_bad_outlined,
            Colors.red,
            onTap: () => _showBlockCardDialog(
              isTemporary: false,
              isStolen: true,
            ),
          ),
          SizedBox(height: 12.h),
          _buildBlockButton(
            'Temporarily Block Card',
            'Block your card temporarily. You can unblock it anytime.',
            Icons.pause_circle_outline_rounded,
            Colors.orange,
            onTap: () => _showBlockCardDialog(
              isTemporary: true,
              isStolen: false,
            ),
          ),
          SizedBox(height: 12.h),
          _buildBlockButton(
            'Permanently Block Card',
            'Block your card permanently. This action cannot be undone.',
            Icons.block_rounded,
            Colors.red,
            onTap: () => _showBlockCardDialog(
              isTemporary: false,
              isStolen: false,
            ),
          ),
        ] else if (_cardStatus == 'Temporarily Blocked') ...[
          SizedBox(height: 16.h),
          _buildBlockButton(
            'Unblock Card',
            'Restore all card functionalities.',
            Icons.lock_open_rounded,
            Colors.green,
            onTap: _showUnblockCardDialog,
          ),
        ],
      ],
    );
  }

  Widget _buildBlockButton(
      String title, String subtitle, IconData icon, Color color,
      {required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: color.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24.sp,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white.withOpacity(0.5),
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBlockCardDialog(
      {required bool isTemporary, bool isStolen = false}) {
    final TextEditingController reasonController = TextEditingController();
    bool isManualReason = false;

    if (isStolen) {
      _processBlockCard(
        isTemporary: false,
        reason: 'Card reported stolen',
        isStolen: true,
      );
      _showStolenCardInstructions();
      return;
    }

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: (isTemporary ? Colors.orange : Colors.red)
                      .withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isTemporary
                      ? Icons.pause_circle_outline_rounded
                      : Icons.block_rounded,
                  color: isTemporary ? Colors.orange : Colors.red,
                  size: 32.sp,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                isTemporary
                    ? 'Temporarily Block Card?'
                    : 'Permanently Block Card?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                child: TextField(
                  controller: reasonController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter reason for blocking',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 14.sp,
                    ),
                    border: InputBorder.none,
                  ),
                  maxLines: 3,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Get.back(),
                        borderRadius: BorderRadius.circular(12.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          if (reasonController.text.trim().isEmpty) {
                            Get.snackbar(
                              'Error',
                              'Please provide a reason for blocking the card',
                              backgroundColor: Colors.red.withOpacity(0.1),
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            return;
                          }
                          _processBlockCard(
                            isTemporary: isTemporary,
                            reason: reasonController.text.trim(),
                            isStolen: false,
                          );
                        },
                        borderRadius: BorderRadius.circular(12.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          decoration: BoxDecoration(
                            color: (isTemporary ? Colors.orange : Colors.red)
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            'Block Card',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isTemporary ? Colors.orange : Colors.red,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  void _processBlockCard({
    required bool isTemporary,
    required String reason,
    bool isStolen = false,
  }) {
    setState(() {
      _isCardActive = false;
      _cardStatus = isStolen
          ? 'Stolen - Blocked'
          : isTemporary
              ? 'Temporarily Blocked'
              : 'Permanently Blocked';
      _statusColor = isStolen
          ? Colors.red
          : isTemporary
              ? Colors.orange
              : Colors.red;

      // Disable all security settings when card is stolen
      if (isStolen) {
        _securitySettings.updateAll((key, value) => false);
      }
    });

    Get.back();
    Get.snackbar(
      isStolen ? 'Card Reported Stolen' : 'Card Blocked',
      isStolen
          ? 'Your card has been blocked and a replacement will be issued'
          : 'Reason: $reason',
      backgroundColor: (isStolen || !isTemporary ? Colors.red : Colors.orange)
          .withOpacity(0.1),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(16),
      borderRadius: 8,
      icon: Icon(
        isStolen
            ? Icons.gpp_bad_outlined
            : isTemporary
                ? Icons.pause_circle_outline_rounded
                : Icons.block_rounded,
        color: isStolen
            ? Colors.red
            : isTemporary
                ? Colors.orange
                : Colors.red,
      ),
    );
  }

  void _showStolenCardInstructions() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.security_rounded,
                color: Colors.red,
                size: 48.sp,
              ),
              SizedBox(height: 16.h),
              Text(
                'Card Reported Stolen',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'We\'ve taken the following actions:',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 16.h),
              _buildSecurityStep(
                '1',
                'Your card has been permanently blocked',
                Icons.block_rounded,
              ),
              SizedBox(height: 12.h),
              _buildSecurityStep(
                '2',
                'All online payments have been disabled',
                Icons.payment_rounded,
              ),
              SizedBox(height: 12.h),
              _buildSecurityStep(
                '3',
                'A replacement card has been requested',
                Icons.credit_card_rounded,
              ),
              SizedBox(height: 24.h),
              Text(
                'Contact our support team if you notice any suspicious transactions',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 48.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'I Understand',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  Widget _buildSecurityStep(String number, String text, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
              ),
            ),
          ),
          Icon(
            icon,
            color: Colors.red.withOpacity(0.7),
            size: 20.sp,
          ),
        ],
      ),
    );
  }

  void _showUnblockCardDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_open_rounded,
                  color: Colors.green,
                  size: 32.sp,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Unblock Card?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Your card will be unblocked and all functionalities will be restored.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Get.back(),
                        borderRadius: BorderRadius.circular(12.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _isCardActive = true;
                            _cardStatus = 'Active';
                            _statusColor = Colors.green;
                          });
                          Get.back();
                          Get.snackbar(
                            'Card Unblocked',
                            'Your card has been successfully unblocked',
                            backgroundColor: Colors.green.withOpacity(0.1),
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                            duration: Duration(seconds: 3),
                            margin: EdgeInsets.all(16),
                            borderRadius: 8,
                            icon: Icon(
                              Icons.lock_open_rounded,
                              color: Colors.green,
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(12.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            'Unblock Card',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  void _showPINWithAuthentication() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.pin_drop_outlined,
                  color: Colors.blue,
                  size: 32.sp,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'View PIN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Authenticate to view your card PIN',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        _showPINRevealDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Authenticate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  void _showPINRevealDialog() {
    _isPinVisible = true;
    String pin = '1234'; // In production, fetch this securely

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your PIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isPinVisible = !_isPinVisible;
                          });
                        },
                        icon: Icon(
                          _isPinVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.blue,
                          size: 24.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        width: 48.w,
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: Colors.blue.withOpacity(0.3),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _isPinVisible ? pin[index] : '•',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.amber.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.amber,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'Never share your PIN with anyone',
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: pin));
                            Get.snackbar(
                              'PIN Copied',
                              'Your PIN has been copied to clipboard',
                              backgroundColor: Colors.blue.withOpacity(0.1),
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                              duration: Duration(seconds: 2),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.copy_rounded,
                                color: Colors.blue,
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Copy PIN',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Get.back(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Done',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
    );

    // Auto-hide PIN after 30 seconds
    Future.delayed(Duration(seconds: 30), () {
      if (Get.isDialogOpen!) {
        Get.back();
      }
      _isPinVisible = false;
    });
  }
}
