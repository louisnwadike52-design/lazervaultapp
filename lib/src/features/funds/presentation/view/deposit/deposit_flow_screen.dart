import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/balance_websocket_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/funds/cubit/deposit_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/deposit_state.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/mono_direct_debit_bottomsheet.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/pay_by_transfer_card.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/recurring_access_toggle.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/directpay_authorization_sheet.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_state.dart';
import 'package:lazervault/core/services/injection_container.dart';

/// Deposit Flow Screen - Standard fintech deposit flow
/// Flow: Method Selection → Amount Entry → Review → Processing → Success/Failure
class DepositFlowScreen extends StatefulWidget {
  final Map<String, dynamic> selectedAccount;

  const DepositFlowScreen({
    super.key,
    required this.selectedAccount,
  });

  @override
  State<DepositFlowScreen> createState() => _DepositFlowScreenState();
}

class _DepositFlowScreenState extends State<DepositFlowScreen> {
  // Flow state
  int _currentStep = 0;
  final PageController _pageController = PageController();

  // Form data
  String _selectedMethod = '';
  double _amount = 0;
  String _narration = '';

  // DirectPay vs Mandate toggle
  bool _useRecurringAccess = false; // false = DirectPay (one-time), true = Mandate (recurring)

  // Payment methods for NGN (bank transfer is primary for Nigerian users)
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 'bank_transfer',
      'name': 'Bank Transfer',
      'description': 'Transfer from your bank account',
      'icon': Icons.account_balance,
      'processingTime': 'Instant - 24hrs',
      'fee': 'Free',
      'recommended': true,
    },
    {
      'id': 'card',
      'name': 'Debit Card',
      'description': 'Pay with your debit card',
      'icon': Icons.credit_card,
      'processingTime': 'Instant',
      'fee': '1.5%',
      'recommended': false,
    },
    {
      'id': 'ussd',
      'name': 'USSD',
      'description': 'Pay using USSD code',
      'icon': Icons.dialpad,
      'processingTime': 'Instant',
      'fee': 'Free',
      'recommended': false,
    },
  ];

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currency = widget.selectedAccount['currency'] ?? 'NGN';
    final isNGN = currency.toString().toUpperCase() == 'NGN';

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<DepositCubit>()),
        BlocProvider(create: (_) => serviceLocator<OpenBankingCubit>()),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1A1A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: isNGN && _currentStep == 0 ? () => Navigator.pop(context) : _previousStep,
          ),
          title: Text(
            isNGN ? _getNGNStepTitle() : _getStepTitle(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Progress indicator
            _buildProgressIndicator(),

            // Page content - Different flow for NGN (Mono DirectPay)
            Expanded(
              child: isNGN
                  ? PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildNGNDirectDebitInfoStep(),
                        _buildProcessingStep(),
                      ],
                    )
                  : PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildMethodSelectionStep(),
                        _buildAmountEntryStep(),
                        _buildReviewStep(),
                        _buildProcessingStep(),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _getNGNStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Fund Account';
      case 1:
        return 'Processing';
      default:
        return 'Deposit';
    }
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Select Method';
      case 1:
        return 'Enter Amount';
      case 2:
        return 'Review';
      case 3:
        return 'Processing';
      default:
        return 'Deposit';
    }
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        children: List.generate(4, (index) {
          final isActive = index <= _currentStep;
          final isCompleted = index < _currentStep;
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF3498DB)
                          : Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                if (index < 3) SizedBox(width: 4.w),
              ],
            ),
          );
        }),
      ),
    );
  }

  // =====================================================
  // NGN FLOW: Direct Debit Info Step (Mono)
  // =====================================================
  Widget _buildNGNDirectDebitInfoStep() {
    // Extract account details for Pay by Transfer card
    final accountNumber = widget.selectedAccount['accountNumber'] ??
                          widget.selectedAccount['account_number'] ?? '';
    final accountName = widget.selectedAccount['accountName'] ??
                        widget.selectedAccount['account_name'] ?? 'LazerVault Account';
    final bankName = widget.selectedAccount['bankName'] ??
                     widget.selectedAccount['bank_name'] ?? 'Wema Bank';

    // Debug: Print account details for Pay by Transfer
    debugPrint('[PayByTransfer] Account Number: $accountNumber');
    debugPrint('[PayByTransfer] Account Name: $accountName');
    debugPrint('[PayByTransfer] Bank Name: $bankName');
    debugPrint('[PayByTransfer] Selected Account Keys: ${widget.selectedAccount.keys.toList()}');

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Account info header
          _buildAccountHeader(),
          SizedBox(height: 24.h),

          // ==== LINK BANK & DEPOSIT SECTION (Primary Action) ====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6C5CE7).withOpacity(0.2),
                  const Color(0xFF6C5CE7).withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: const Color(0xFF6C5CE7).withOpacity(0.3),
              ),
            ),
            child: Column(
              children: [
                // Header with icon and title
                Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6C5CE7), Color(0xFF8E7CF3)],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.account_balance,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Link Bank & Deposit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Securely deposit from your bank via Mono',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Recurring Access Toggle
                RecurringAccessToggle(
                  isRecurringEnabled: _useRecurringAccess,
                  onToggle: (value) {
                    setState(() => _useRecurringAccess = value);
                  },
                ),
                SizedBox(height: 16.h),

                // Link & Deposit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _launchMonoDirectDebit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C5CE7),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.link, size: 20.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Link & Deposit',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // ==== OR DIVIDER ====
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'OR',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // ==== PAY BY TRANSFER CARD ====
          PayByTransferCard(
            accountNumber: accountNumber,
            accountName: accountName,
            bankName: bankName,
          ),
          SizedBox(height: 32.h),

          // ==== HOW MONO DIRECT DEBIT WORKS (Info Section) ====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.white.withOpacity(0.7),
                      size: 18.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'How Mono Direct Debit Works',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                _buildInfoItem(Icons.lock_outline, 'Bank-grade security'),
                SizedBox(height: 8.h),
                _buildInfoItem(Icons.flash_on, 'Instant deposits'),
                SizedBox(height: 8.h),
                _buildInfoItem(Icons.credit_card_off, 'No card details needed'),
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF6C5CE7),
          size: 16.sp,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF6C5CE7),
          size: 20.sp,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepItem(int number, String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28.w,
            height: 28.w,
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7).withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF6C5CE7).withOpacity(0.5),
              ),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: TextStyle(
                  color: const Color(0xFF6C5CE7),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
        ],
      ),
    );
  }

  void _launchMonoDirectDebit() {
    showMonoDirectDebitBottomsheet(
      context: context,
      selectedAccount: widget.selectedAccount,
      openBankingCubit: context.read<OpenBankingCubit>(),
      useRecurringAccess: _useRecurringAccess,
      onSuccess: () {
        // Move to processing step
        _nextStep();
        Get.snackbar(
          'Bank Linked Successfully',
          'Your deposit is being processed',
          backgroundColor: Colors.green.withOpacity(0.9),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      onDirectPayAuth: (String paymentUrl, String paymentId) async {
        // Handle DirectPay authorization in-app
        final result = await showDirectPayAuthorizationSheet(
          context: context,
          paymentUrl: paymentUrl,
          paymentId: paymentId,
          redirectScheme: 'lazervault',
          redirectPath: '/deposit/callback',
        );

        if (result.success) {
          // Move to processing step - payment authorized
          _nextStep();
          Get.snackbar(
            'Payment Authorized',
            'Your deposit is being processed',
            backgroundColor: Colors.green.withOpacity(0.9),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          Get.snackbar(
            'Authorization Failed',
            result.errorMessage ?? 'Payment authorization was cancelled',
            backgroundColor: Colors.red.withOpacity(0.9),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
      onError: (message) {
        Get.snackbar(
          'Error',
          message,
          backgroundColor: Colors.red.withOpacity(0.9),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  // =====================================================
  // STEP 1: Method Selection (Non-NGN currencies)
  // =====================================================
  Widget _buildMethodSelectionStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Account info header
          _buildAccountHeader(),
          SizedBox(height: 24.h),

          Text(
            'How would you like to deposit?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),

          // Payment methods
          ...(_paymentMethods.map((method) => _buildPaymentMethodCard(method))),
        ],
      ),
    );
  }

  Widget _buildAccountHeader() {
    final currency = widget.selectedAccount['currency'] ?? 'NGN';
    final balance = widget.selectedAccount['balance'] ?? 0.0;
    final accountType = widget.selectedAccount['accountType'] ?? 'Account';

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF3498DB).withOpacity(0.2),
            const Color(0xFF3498DB).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF3498DB).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF3498DB).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.account_balance_wallet,
              color: const Color(0xFF3498DB),
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  accountType,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '$currency ${balance.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(Map<String, dynamic> method) {
    final isSelected = _selectedMethod == method['id'];
    final isRecommended = method['recommended'] ?? false;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedMethod = method['id']);
        Future.delayed(const Duration(milliseconds: 200), _nextStep);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3498DB).withOpacity(0.1)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF3498DB)
                : Colors.white.withOpacity(0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3498DB).withOpacity(0.2)
                    : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                method['icon'],
                color: isSelected ? const Color(0xFF3498DB) : Colors.white,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        method['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (isRecommended) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Recommended',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    method['description'],
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.white.withOpacity(0.5),
                        size: 14.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        method['processingTime'],
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 11.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        'Fee: ${method['fee']}',
                        style: TextStyle(
                          color: method['fee'] == 'Free'
                              ? Colors.green
                              : Colors.white.withOpacity(0.5),
                          fontSize: 11.sp,
                          fontWeight: method['fee'] == 'Free'
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.white.withOpacity(0.5),
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // STEP 2: Amount Entry
  // =====================================================
  Widget _buildAmountEntryStep() {
    final currency = widget.selectedAccount['currency'] ?? 'NGN';
    final currencySymbol = currency == 'NGN' ? '₦' : '£';

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter deposit amount',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24.h),

          // Amount input
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currencySymbol,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '0.00',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.3),
                            fontSize: 48.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _amount = double.tryParse(value) ?? 0;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Quick amounts
          Text(
            'Quick amounts',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuickAmountButton(currencySymbol, 1000),
              _buildQuickAmountButton(currencySymbol, 5000),
              _buildQuickAmountButton(currencySymbol, 10000),
              _buildQuickAmountButton(currencySymbol, 50000),
            ],
          ),
          SizedBox(height: 24.h),

          // Narration
          Text(
            'Narration (optional)',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
            decoration: InputDecoration(
              hintText: 'What is this deposit for?',
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 14.sp,
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.all(16.w),
            ),
            onChanged: (value) => _narration = value,
          ),
          SizedBox(height: 32.h),

          // Continue button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _amount > 0 ? _nextStep : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _amount > 0
                    ? const Color(0xFF3498DB)
                    : Colors.grey.shade700,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAmountButton(String symbol, int amount) {
    return GestureDetector(
      onTap: () => setState(() => _amount = amount.toDouble()),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: _amount == amount
              ? const Color(0xFF3498DB).withOpacity(0.2)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: _amount == amount
                ? const Color(0xFF3498DB)
                : Colors.transparent,
          ),
        ),
        child: Text(
          '$symbol${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // =====================================================
  // STEP 3: Review
  // =====================================================
  Widget _buildReviewStep() {
    final currency = widget.selectedAccount['currency'] ?? 'NGN';
    final currencySymbol = currency == 'NGN' ? '₦' : '£';
    final accountNumber = widget.selectedAccount['accountNumber'] ?? '';
    final bankName = 'LazerVault MFB'; // VFD partner bank name

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review your deposit',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24.h),

          // Amount card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF3498DB).withOpacity(0.3),
                  const Color(0xFF3498DB).withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Text(
                  'Deposit Amount',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '$currencySymbol${_amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Bank transfer details (shown for bank transfer method)
          if (_selectedMethod == 'bank_transfer') ...[
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.orange,
                    size: 24.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Transfer to the account details below from your bank app',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Bank details
            _buildDetailRow('Bank Name', bankName, canCopy: true),
            _buildDetailRow('Account Number', accountNumber, canCopy: true),
            _buildDetailRow('Account Name', 'Your LazerVault Account', canCopy: false),
          ],

          _buildDetailRow('Payment Method', _getMethodName(_selectedMethod), canCopy: false),
          _buildDetailRow('Fee', 'Free', canCopy: false, isHighlight: true),
          if (_narration.isNotEmpty)
            _buildDetailRow('Narration', _narration, canCopy: false),

          SizedBox(height: 32.h),

          // Confirm button
          BlocConsumer<DepositCubit, DepositState>(
            listener: (context, state) {
              if (state is DepositSuccess) {
                _nextStep(); // Go to processing/success screen
              } else if (state is DepositFailure) {
                Get.snackbar(
                  'Deposit Failed',
                  state.message,
                  backgroundColor: Colors.red.withOpacity(0.9),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is DepositLoading;

              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : () => _initiateDeposit(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3498DB),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: isLoading
                      ? SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                      : Text(
                          _selectedMethod == 'bank_transfer'
                              ? "I've Made the Transfer"
                              : 'Confirm Deposit',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {required bool canCopy, bool isHighlight = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 14.sp,
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  color: isHighlight ? Colors.green : Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (canCopy) ...[
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () {
                    // Copy to clipboard
                    Get.snackbar(
                      'Copied',
                      '$label copied to clipboard',
                      backgroundColor: Colors.green.withOpacity(0.9),
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 2),
                    );
                  },
                  child: Icon(
                    Icons.copy,
                    color: const Color(0xFF3498DB),
                    size: 18.sp,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _getMethodName(String methodId) {
    final method = _paymentMethods.firstWhere(
      (m) => m['id'] == methodId,
      orElse: () => {'name': 'Unknown'},
    );
    return method['name'];
  }

  void _initiateDeposit(BuildContext context) {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      Get.snackbar(
        'Error',
        'Please log in to continue',
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final accessToken = authState.profile.session.accessToken;
    final accountId = widget.selectedAccount['id'] as String; // UUID string
    final currency = widget.selectedAccount['currency'] ?? 'NGN';

    context.read<DepositCubit>().initiateDeposit(
      targetAccountId: accountId, // Pass UUID string directly
      amount: _amount,
      currency: currency,
      sourceBankName: _getMethodName(_selectedMethod),
      accessToken: accessToken,
    );
  }

  // =====================================================
  // STEP 4: Processing/Success
  // =====================================================
  Widget _buildProcessingStep() {
    return BlocBuilder<BalanceWebSocketCubit, BalanceWebSocketState>(
      builder: (context, wsState) {
        // Check if we received a deposit confirmation via WebSocket
        final lastUpdate = wsState.lastUpdate;
        final isDepositConfirmed = lastUpdate != null &&
            lastUpdate.eventType == 'deposit' &&
            lastUpdate.status == 'completed';

        return _DepositProcessingView(
          amount: _amount,
          currency: widget.selectedAccount['currency'] ?? 'NGN',
          isConfirmed: isDepositConfirmed,
          selectedMethod: _selectedMethod,
          onDone: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        );
      },
    );
  }
}

/// Processing view with animations
class _DepositProcessingView extends StatefulWidget {
  final double amount;
  final String currency;
  final bool isConfirmed;
  final String selectedMethod;
  final VoidCallback onDone;

  const _DepositProcessingView({
    required this.amount,
    required this.currency,
    required this.isConfirmed,
    required this.selectedMethod,
    required this.onDone,
  });

  @override
  State<_DepositProcessingView> createState() => _DepositProcessingViewState();
}

class _DepositProcessingViewState extends State<_DepositProcessingView>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currencySymbol = widget.currency == 'NGN' ? '₦' : '£';
    final isBankTransfer = widget.selectedMethod == 'bank_transfer';

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated icon
            ScaleTransition(
              scale: _pulseAnimation,
              child: Container(
                width: 120.w,
                height: 120.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: widget.isConfirmed
                        ? [Colors.green, Colors.green.shade700]
                        : [const Color(0xFF3498DB), const Color(0xFF2980B9)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: (widget.isConfirmed ? Colors.green : const Color(0xFF3498DB))
                          .withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  widget.isConfirmed ? Icons.check : Icons.hourglass_top,
                  color: Colors.white,
                  size: 60.sp,
                ),
              ),
            ),
            SizedBox(height: 32.h),

            // Status text
            Text(
              widget.isConfirmed
                  ? 'Deposit Successful!'
                  : isBankTransfer
                      ? 'Waiting for Transfer'
                      : 'Processing Deposit...',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),

            // Amount
            Text(
              '$currencySymbol${widget.amount.toStringAsFixed(2)}',
              style: GoogleFonts.inter(
                color: widget.isConfirmed ? Colors.green : const Color(0xFF3498DB),
                fontSize: 36.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 24.h),

            // Status message
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.isConfirmed
                        ? Icons.check_circle
                        : isBankTransfer
                            ? Icons.access_time
                            : Icons.sync,
                    color: widget.isConfirmed ? Colors.green : Colors.white.withOpacity(0.7),
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    widget.isConfirmed
                        ? 'Your balance has been updated'
                        : isBankTransfer
                            ? 'We\'ll notify you once the transfer is received'
                            : 'This may take a few moments',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 48.h),

            // Done button (only show when confirmed or for bank transfer)
            if (widget.isConfirmed || isBankTransfer)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: widget.onDone,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.isConfirmed ? Colors.green : const Color(0xFF3498DB),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    widget.isConfirmed ? 'Done' : 'Return to Dashboard',
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
    );
  }
}
