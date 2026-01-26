import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Import the new widgets
import './bottom_sheet_header.dart';
import './card_detail_tabs.dart';
import './card_visual_preview.dart';
import './detail_section.dart';
import './detail_row.dart';
import './copyable_detail_row.dart';
import './switch_detail_row.dart';
import './card_blocking_row.dart';

// Import deposit and withdrawal flows
import 'package:lazervault/src/features/funds/presentation/view/deposit/deposit_flow_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/withdrawal/withdrawal_flow_screen.dart';
// Keep imports for dialogs/logic methods if they need specific types

class CardDetailsBottomSheet extends StatefulWidget {
  final Map<String, dynamic> accountArgs;

  const CardDetailsBottomSheet({super.key, required this.accountArgs});

  @override
  State<CardDetailsBottomSheet> createState() => _CardDetailsBottomSheetState();
}

class _CardDetailsBottomSheetState extends State<CardDetailsBottomSheet> {
  // State variables moved here from _DashboardCardSummaryViewState
  bool _showLocalDetails = true;
  bool _isCardActive = true;
  String _cardStatus = 'Active';
  Color _statusColor = Colors.green;
  final Map<String, bool> _securitySettings = {
    '3D Secure': true,
    'Contactless': true,
    'ATM Withdrawals': true,
    'Online Payments': true,
    'International Payments': false,
  };
  bool _isPinVisible = false;
  // Timer? _pinVisibilityTimer;

  @override
  void dispose() {
    // _pinVisibilityTimer?.cancel(); // Cancel timer if using one for PIN auto-hide
    super.dispose();
  }

  String _getCurrencySymbol() {
    final currency = widget.accountArgs['currency'] as String? ?? 'NGN';
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'GBP':
        return '£';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      default:
        return '₦';
    }
  }

  @override
  Widget build(BuildContext context) {
    void setSheetState(VoidCallback fn) {
      setState(fn);
    }

    return FractionallySizedBox(
        heightFactor: 0.9,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
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
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Use new widgets
                        const BottomSheetHeader(),
                        SizedBox(height: 16.h),
                        CardDetailTabs(
                          showLocalDetails: _showLocalDetails,
                          onTabSelected: (isLocal) => setSheetState(() => _showLocalDetails = isLocal),
                        ),
                        SizedBox(height: 16.h),
                        CardVisualPreview(
                           accountArgs: widget.accountArgs, 
                           // Pass the method reference for showing PIN
                           onShowPin: () => _showPINWithAuthentication(setSheetState), 
                        ),
                        SizedBox(height: 20.h),
                         // Use new Text widget for title
                        Text(
                           _showLocalDetails ? 'Local Card Details' : 'International Card Details',
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 16.sp,
                             fontWeight: FontWeight.w600,
                           ),
                         ),
                        SizedBox(height: 12.h),
                        // Use DetailSection and DetailRow widgets
                        DetailSection(
                          title: 'Card Information',
                          details: [
                            DetailRow(
                                label: 'Card Type',
                                value: _showLocalDetails
                                    ? 'Local Debit'
                                    : 'International Debit'),
                            DetailRow(label: 'Currency',
                                value: widget.accountArgs["currency"] as String),
                            DetailRow(label: 'Status', value: _cardStatus, 
                                isHighlighted: true, isPositive: _isCardActive), 
                          ],
                        ),
                        SizedBox(height: 16.h),
                        DetailSection(
                          title: 'Account Details',
                          details: [
                            CopyableDetailRow(
                              label: 'Beneficiary',
                              value: 'Louis Nwadike',
                              onCopy: () => _copyToClipboard(
                                  'Louis Nwadike', 'Beneficiary name'),
                            ),
                            CopyableDetailRow(
                              label: 'IBAN',
                              value: 'GB44 REVO 0099 7019 8493 64',
                              onCopy: () => _copyToClipboard(
                                  'GB44 REVO 0099 7019 8493 64', 'IBAN'),
                            ),
                            CopyableDetailRow(
                              label: 'BIC/SWIFT code',
                              value: 'REVOGB21',
                              onCopy: () => _copyToClipboard(
                                  'REVOGB21', 'BIC/SWIFT code'),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        DetailSection(
                          title: 'Spending Limits',
                          details: [
                            DetailRow(label: 'Daily Limit', value: '${_getCurrencySymbol()}5,000'),
                            DetailRow(label: 'Monthly Limit', value: '${_getCurrencySymbol()}50,000'),
                            DetailRow(label: 'Available Balance',
                                value: "${_getCurrencySymbol()}${(widget.accountArgs["balance"] as double).toStringAsFixed(2)}"),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        DetailSection(
                          title: 'Security',
                          details: _securitySettings.entries.map((entry) {
                            return SwitchDetailRow(
                              label: entry.key,
                              isEnabled: entry.value,
                              isCardActive: _isCardActive,
                              onChanged: (newValue) {
                                setSheetState(() {
                                  _securitySettings[entry.key] = newValue;
                                });
                              },
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 16.h),
                        DetailSection(
                          title: 'Card Controls',
                          details: [ 
                            CardBlockingRow(
                              isCardActive: _isCardActive,
                              cardStatus: _cardStatus,
                              statusColor: _statusColor,
                              onReportStolen: () => _showBlockCardDialog(
                                setSheetState: setSheetState,
                                isTemporary: false,
                                isStolen: true,
                              ),
                              onTemporarilyBlock: () => _showBlockCardDialog(
                                setSheetState: setSheetState,
                                isTemporary: true,
                              ),
                              onPermanentlyBlock: () => _showBlockCardDialog(
                                setSheetState: setSheetState,
                                isTemporary: false,
                              ),
                              onUnblock: () => _showUnblockCardDialog(setSheetState),
                            )
                          ],
                        ),
                        SizedBox(height: 20.h),
                        _buildActionButtons(widget.accountArgs),
                        SizedBox(height: 24.h),
                        _buildDocumentsSection(),
                        SizedBox(height: 24.h),
                        _buildTransferInfoSection(),
                        SizedBox(height: 16.h),
                        _buildCurrencyTransferButton(),
                        SizedBox(height: 16.h),
                        _buildGetHelpButton(),
                        SizedBox(height: 20.h),
                        _buildSecurityNotice(),
                        SizedBox(height: 24.h),
                        
                        // Added Enter Amount section
                        Text(
                          'Enter Amount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
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
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  _getCurrencySymbol(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: TextField(
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '0.00',
                                    hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.3),
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // Added Quick Amounts section
                        Text(
                          'Quick Amounts',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildQuickAmountButton('${_getCurrencySymbol()}1,000'),
                            _buildQuickAmountButton('${_getCurrencySymbol()}5,000'),
                            _buildQuickAmountButton('${_getCurrencySymbol()}10,000'),
                            _buildQuickAmountButton('${_getCurrencySymbol()}50,000'),
                          ],
                        ),
                        SizedBox(height: 32.h),
                        
                        // Action Button
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 16.h),
                          child: ElevatedButton(
                            onPressed: () {
                              Get.snackbar(
                                'Transaction Initiated',
                                'Your transaction is being processed',
                                backgroundColor: Colors.green.withOpacity(0.1),
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                                duration: const Duration(seconds: 3),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Proceed with Transaction',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
  }

    void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Copied!',
      '$label copied to clipboard',
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      icon: Icon(
        Icons.check_circle_outline_rounded,
        color: Colors.green[400],
      ),
    );
  }

 

   Widget _buildDocumentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
          'Documents',
            style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        _buildDocumentButton(
          'Account Statement',
          'View and download your monthly statements',
          Icons.description_outlined,
          onTap: () {
            Get.snackbar(
              'Download Started',
              'Your statement is being prepared',
              backgroundColor: Colors.blue.withOpacity(0.1),
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2),
            );
          },
        ),
        SizedBox(height: 12.h),
        _buildDocumentButton(
          'Account Confirmation',
          'Download your account confirmation letter',
          Icons.verified_outlined,
          onTap: () {
            Get.snackbar(
              'Download Started',
              'Your confirmation letter is being prepared',
              backgroundColor: Colors.blue.withOpacity(0.1),
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCardActionButton(String label, IconData icon, VoidCallback onTap) {
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
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
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

  Widget _buildDocumentButton(String title, String subtitle, IconData icon, {required VoidCallback onTap}) {
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

  Widget _buildActionButtons(Map<String, dynamic> accountArgs) {
    return Column(
      children: [
        // Primary actions: Deposit & Withdraw
        Row(
          children: [
            Expanded(
              child: _buildPrimaryActionButton(
                'Deposit',
                Icons.add_rounded,
                Colors.green,
                () {
                  Get.back(); // Close bottom sheet
                  Get.to(
                    () => _DepositFlowNavigator(selectedAccount: accountArgs),
                    transition: Transition.rightToLeft,
                  );
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildPrimaryActionButton(
                'Withdraw',
                Icons.arrow_upward_rounded,
                Colors.orange,
                () {
                  Get.back(); // Close bottom sheet
                  Get.to(
                    () => _WithdrawalFlowNavigator(selectedAccount: accountArgs),
                    transition: Transition.rightToLeft,
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        // Secondary actions: Copy & Share
        Row(
          children: [
            Expanded(
              child: _buildCardActionButton(
                'Copy Details',
                Icons.copy_rounded,
                () {
                  Clipboard.setData(ClipboardData(
                    text: 'Card Number: ${accountArgs["accountNumber"]}\n'
                        'Expiry: 12/25\n'
                        'Currency: ${accountArgs["currency"]}',
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
                  Get.snackbar(
                    'Coming Soon',
                    'Share functionality will be available in the next update',
                    backgroundColor: Colors.blue.withValues(alpha: 0.1),
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPrimaryActionButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.8)],
            ),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
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
          () {
            // Implement learn more action
            Get.snackbar(
              'Bank Information',
              'We partner with top-tier banks to ensure your funds are secure',
              backgroundColor: Colors.blue.withOpacity(0.1),
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );
          },
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
          Get.snackbar(
            'Currency Transfers',
            'Additional currency options will be available soon',
            backgroundColor: Colors.blue.withOpacity(0.1),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
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
          Get.snackbar(
            'Support',
            'Connecting you to customer support...',
            backgroundColor: Colors.blue.withOpacity(0.1),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
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

  Widget _buildSecurityNotice() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
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
    );
  }

  void _showBlockCardDialog({ required void Function(VoidCallback) setSheetState, required bool isTemporary, bool isStolen = false}) {
    final reasonController = TextEditingController();
    
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          isStolen 
              ? 'Report Stolen Card'
              : isTemporary
                  ? 'Block Card Temporarily'
                  : 'Block Card Permanently',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isStolen
                  ? 'This will permanently block your card and issue a replacement. Are you sure?'
                  : isTemporary
                      ? 'You can unblock your card at any time. Your card will remain blocked until you choose to unblock it.'
                      : 'This will permanently block your card. You\'ll need to order a new card if you want to use this account again.',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: reasonController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Reason for blocking (optional)',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14.sp,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _processBlockCard(
                setSheetState: setSheetState,
                isTemporary: isTemporary,
                reason: reasonController.text.trim(),
                isStolen: isStolen,
              );
            },
            child: Text(
              'Confirm',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _processBlockCard({ required void Function(VoidCallback) setSheetState, required bool isTemporary, required String reason, bool isStolen = false }) {
    // Show loading indicator
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      Get.back(); // Close loading dialog

      setSheetState(() {
        _isCardActive = false;
        _cardStatus = isTemporary ? 'Temporarily Blocked' : 'Permanently Blocked';
        _statusColor = Colors.red;
        
        // Disable security settings when card is blocked
        for (var key in _securitySettings.keys) {
          _securitySettings[key] = false;
        }
      });

      if (isStolen) {
        _showStolenCardInstructions();
      } else {
        Get.snackbar(
          'Card Blocked',
          isTemporary
              ? 'Your card has been temporarily blocked'
              : 'Your card has been permanently blocked',
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      }
    });
  }

  void _showStolenCardInstructions() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Card Reported as Stolen',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your card has been permanently blocked. Please follow these steps:',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 16.h),
            _buildSecurityStep(
              '1',
              'A new card will be shipped to your registered address',
              Icons.local_shipping_outlined,
            ),
            SizedBox(height: 12.h),
            _buildSecurityStep(
              '2',
              'Monitor your account for any suspicious activity',
              Icons.security_outlined,
            ),
            SizedBox(height: 12.h),
            _buildSecurityStep(
              '3',
              'Update your card details with any services where it was saved',
              Icons.update_outlined,
            ),
            SizedBox(height: 12.h),
            _buildSecurityStep(
              '4',
              'If you suspect fraud, contact our support team immediately',
              Icons.headset_mic_outlined,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Understood',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityStep(String number, String text, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24.w,
          height: 24.h,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Colors.blue[300],
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Colors.blue[300],
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showUnblockCardDialog(void Function(VoidCallback) setSheetState) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Unblock Card',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Are you sure you want to unblock your card? This will allow all transactions again.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14.sp,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              
              // Show loading indicator
              Get.dialog(
                const Center(
                  child: CircularProgressIndicator(),
                ),
                barrierDismissible: false,
              );

              // Simulate API call
              Future.delayed(const Duration(seconds: 2), () {
                Get.back(); // Close loading dialog

                setSheetState(() {
                  _isCardActive = true;
                  _cardStatus = 'Active';
                  _statusColor = Colors.green;
                  
                  // Reset security settings to default
                  _securitySettings['3D Secure'] = true;
                  _securitySettings['Contactless'] = true;
                  _securitySettings['Online Payments'] = true;
                });

                Get.snackbar(
                  'Card Unblocked',
                  'Your card has been successfully unblocked',
                  backgroundColor: Colors.green.withOpacity(0.1),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 3),
                );
              });
            },
            child: Text(
              'Unblock',
              style: TextStyle(
                color: Colors.green,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPINWithAuthentication(void Function(VoidCallback) setSheetState) {
    // In a real app, this would trigger biometric authentication
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Authentication Required',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.fingerprint,
              color: Colors.blue[300],
              size: 48.sp,
            ),
            SizedBox(height: 16.h),
            Text(
              'Please authenticate to view your PIN',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14.sp,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _showPINRevealDialog(setSheetState);
            },
            child: Text(
              'Authenticate',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPINRevealDialog(void Function(VoidCallback) setSheetState) {
    setSheetState(() => _isPinVisible = true);
    
    // Simulate loading PIN from secure storage
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Your PIN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 4; i++)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    width: 40.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.blue.withOpacity(0.3)),
                    ),
                    child: Center(
                      child: Text(
                        ['1', '2', '3', '4'][i],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              'Your PIN will be hidden in 30 seconds for security',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              setSheetState(() => _isPinVisible = false);
            },
            child: Text(
              'Done',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
    
    // Auto-hide PIN after 30 seconds
    Future.delayed(const Duration(seconds: 30), () {
      if (_isPinVisible) {
        setSheetState(() => _isPinVisible = false);
        Get.back(closeOverlays: true);
        Get.snackbar(
          'PIN Hidden',
          'Your PIN has been hidden for security',
          backgroundColor: Colors.blue.withOpacity(0.1),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    });
  }

  Widget _buildQuickAmountButton(String amount) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Handle quick amount selection
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            amount,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

/// Navigator widget for Deposit Flow
class _DepositFlowNavigator extends StatelessWidget {
  final Map<String, dynamic> selectedAccount;

  const _DepositFlowNavigator({required this.selectedAccount});

  @override
  Widget build(BuildContext context) {
    return DepositFlowScreen(selectedAccount: selectedAccount);
  }
}

/// Navigator widget for Withdrawal Flow
class _WithdrawalFlowNavigator extends StatelessWidget {
  final Map<String, dynamic> selectedAccount;

  const _WithdrawalFlowNavigator({required this.selectedAccount});

  @override
  Widget build(BuildContext context) {
    return WithdrawalFlowScreen(selectedAccount: selectedAccount);
  }
} 