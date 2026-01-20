import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/balance_websocket_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/funds/cubit/withdrawal_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/withdrawal_state.dart';
import 'package:lazervault/core/services/injection_container.dart';

/// Withdrawal Flow Screen - Standard fintech withdrawal flow
/// Flow: Recipient Selection → Amount Entry → Review → PIN Auth → Processing → Success/Failure
class WithdrawalFlowScreen extends StatefulWidget {
  final Map<String, dynamic> selectedAccount;

  const WithdrawalFlowScreen({
    super.key,
    required this.selectedAccount,
  });

  @override
  State<WithdrawalFlowScreen> createState() => _WithdrawalFlowScreenState();
}

class _WithdrawalFlowScreenState extends State<WithdrawalFlowScreen> {
  // Flow state
  int _currentStep = 0;
  final PageController _pageController = PageController();

  // Form data
  Map<String, dynamic>? _selectedRecipient;
  double _amount = 0;
  String _narration = '';
  bool _isNewRecipient = false;

  // New recipient form
  final _bankNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _accountNameController = TextEditingController();

  // Nigerian banks list
  final List<Map<String, dynamic>> _nigerianBanks = [
    {'code': '044', 'name': 'Access Bank', 'icon': Icons.account_balance},
    {'code': '023', 'name': 'Citibank', 'icon': Icons.account_balance},
    {'code': '063', 'name': 'Diamond Bank', 'icon': Icons.account_balance},
    {'code': '050', 'name': 'Ecobank', 'icon': Icons.account_balance},
    {'code': '084', 'name': 'Enterprise Bank', 'icon': Icons.account_balance},
    {'code': '070', 'name': 'Fidelity Bank', 'icon': Icons.account_balance},
    {'code': '011', 'name': 'First Bank', 'icon': Icons.account_balance},
    {'code': '214', 'name': 'First City Monument Bank', 'icon': Icons.account_balance},
    {'code': '058', 'name': 'GTBank', 'icon': Icons.account_balance},
    {'code': '030', 'name': 'Heritage Bank', 'icon': Icons.account_balance},
    {'code': '301', 'name': 'Jaiz Bank', 'icon': Icons.account_balance},
    {'code': '082', 'name': 'Keystone Bank', 'icon': Icons.account_balance},
    {'code': '526', 'name': 'Parallex Bank', 'icon': Icons.account_balance},
    {'code': '076', 'name': 'Polaris Bank', 'icon': Icons.account_balance},
    {'code': '101', 'name': 'Providus Bank', 'icon': Icons.account_balance},
    {'code': '221', 'name': 'Stanbic IBTC', 'icon': Icons.account_balance},
    {'code': '068', 'name': 'Standard Chartered', 'icon': Icons.account_balance},
    {'code': '232', 'name': 'Sterling Bank', 'icon': Icons.account_balance},
    {'code': '100', 'name': 'SunTrust Bank', 'icon': Icons.account_balance},
    {'code': '032', 'name': 'Union Bank', 'icon': Icons.account_balance},
    {'code': '033', 'name': 'United Bank for Africa', 'icon': Icons.account_balance},
    {'code': '215', 'name': 'Unity Bank', 'icon': Icons.account_balance},
    {'code': '035', 'name': 'Wema Bank', 'icon': Icons.account_balance},
    {'code': '057', 'name': 'Zenith Bank', 'icon': Icons.account_balance},
    {'code': '999', 'name': 'Kuda MFB', 'icon': Icons.account_balance},
    {'code': '090110', 'name': 'VFD MFB', 'icon': Icons.account_balance},
    {'code': '090267', 'name': 'Kuda MFB', 'icon': Icons.account_balance},
    {'code': '090405', 'name': 'Moniepoint MFB', 'icon': Icons.account_balance},
    {'code': '100004', 'name': 'Opay', 'icon': Icons.account_balance},
    {'code': '100033', 'name': 'PalmPay', 'icon': Icons.account_balance},
  ];

  // Saved recipients (mock data - would come from backend)
  final List<Map<String, dynamic>> _savedRecipients = [
    {
      'id': '1',
      'name': 'John Doe',
      'bank': 'GTBank',
      'bankCode': '058',
      'accountNumber': '0123456789',
      'lastUsed': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': '2',
      'name': 'Jane Smith',
      'bank': 'Access Bank',
      'bankCode': '044',
      'accountNumber': '9876543210',
      'lastUsed': DateTime.now().subtract(const Duration(days: 7)),
    },
  ];

  void _nextStep() {
    if (_currentStep < 4) {
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
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _accountNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<WithdrawalCubit>(),
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1A1A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: _previousStep,
          ),
          title: Text(
            _getStepTitle(),
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

            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildRecipientSelectionStep(),
                  _buildAmountEntryStep(),
                  _buildReviewStep(),
                  _buildPinAuthStep(),
                  _buildProcessingStep(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Select Recipient';
      case 1:
        return 'Enter Amount';
      case 2:
        return 'Review';
      case 3:
        return 'Confirm';
      case 4:
        return 'Processing';
      default:
        return 'Withdraw';
    }
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        children: List.generate(5, (index) {
          final isActive = index <= _currentStep;
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.orange
                          : Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                if (index < 4) SizedBox(width: 4.w),
              ],
            ),
          );
        }),
      ),
    );
  }

  // =====================================================
  // STEP 1: Recipient Selection
  // =====================================================
  Widget _buildRecipientSelectionStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Account balance header
          _buildBalanceHeader(),
          SizedBox(height: 24.h),

          // Saved recipients
          if (_savedRecipients.isNotEmpty && !_isNewRecipient) ...[
            Text(
              'Recent Recipients',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            ..._savedRecipients.map((r) => _buildRecipientCard(r)),
            SizedBox(height: 24.h),
          ],

          // New recipient option
          if (!_isNewRecipient)
            GestureDetector(
              onTap: () => setState(() => _isNewRecipient = true),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.orange.withValues(alpha: 0.3),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.orange,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New Recipient',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Enter new bank account details',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
            ),

          // New recipient form
          if (_isNewRecipient) ...[
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => setState(() => _isNewRecipient = false),
                ),
                Text(
                  'Add New Recipient',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildNewRecipientForm(),
          ],
        ],
      ),
    );
  }

  Widget _buildBalanceHeader() {
    final currency = widget.selectedAccount['currency'] ?? 'NGN';
    final currencySymbol = currency == 'NGN' ? '₦' : '£';
    final balance = widget.selectedAccount['balance'] ?? 0.0;
    final availableBalance = widget.selectedAccount['availableBalance'] ?? balance;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orange.withValues(alpha: 0.2),
            Colors.orange.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Balance',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '$currencySymbol${availableBalance.toStringAsFixed(2)}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (balance != availableBalance) ...[
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                '$currencySymbol${(balance - availableBalance).toStringAsFixed(2)} on hold',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRecipientCard(Map<String, dynamic> recipient) {
    final isSelected = _selectedRecipient?['id'] == recipient['id'];

    return GestureDetector(
      onTap: () {
        setState(() => _selectedRecipient = recipient);
        Future.delayed(const Duration(milliseconds: 200), _nextStep);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.orange.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? Colors.orange
                : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  recipient['name'].toString().substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
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
                    recipient['name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${recipient['bank']} • ${_maskAccountNumber(recipient['accountNumber'])}',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return '****${accountNumber.substring(accountNumber.length - 4)}';
  }

  Widget _buildNewRecipientForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bank selection
        Text(
          'Select Bank',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: _showBankSelectionBottomSheet,
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.account_balance,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    _bankNameController.text.isEmpty
                        ? 'Select bank'
                        : _bankNameController.text,
                    style: TextStyle(
                      color: _bankNameController.text.isEmpty
                          ? Colors.white.withValues(alpha: 0.3)
                          : Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),

        // Account number
        Text(
          'Account Number',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: _accountNumberController,
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
          keyboardType: TextInputType.number,
          maxLength: 10,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: 'Enter 10-digit account number',
            hintStyle: TextStyle(
              color: Colors.white.withValues(alpha: 0.3),
              fontSize: 14.sp,
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            counterText: '',
          ),
          onChanged: (value) {
            if (value.length == 10) {
              // TODO: Call name enquiry API
              _accountNameController.text = 'Account Name (Verified)';
            }
          },
        ),
        SizedBox(height: 16.h),

        // Account name (auto-filled after verification)
        if (_accountNameController.text.isNotEmpty) ...[
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account Name',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        _accountNameController.text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],

        // Continue button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _canProceedWithNewRecipient() ? _proceedWithNewRecipient : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _canProceedWithNewRecipient()
                  ? Colors.orange
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
    );
  }

  bool _canProceedWithNewRecipient() {
    return _bankNameController.text.isNotEmpty &&
        _accountNumberController.text.length == 10 &&
        _accountNameController.text.isNotEmpty;
  }

  void _proceedWithNewRecipient() {
    final bank = _nigerianBanks.firstWhere(
      (b) => b['name'] == _bankNameController.text,
      orElse: () => {'code': '', 'name': _bankNameController.text},
    );

    setState(() {
      _selectedRecipient = {
        'id': 'new',
        'name': _accountNameController.text,
        'bank': _bankNameController.text,
        'bankCode': bank['code'],
        'accountNumber': _accountNumberController.text,
        'isNew': true,
      };
    });
    _nextStep();
  }

  void _showBankSelectionBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                'Select Bank',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: _nigerianBanks.length,
                itemBuilder: (context, index) {
                  final bank = _nigerianBanks[index];
                  return ListTile(
                    leading: Icon(
                      bank['icon'],
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                    title: Text(
                      bank['name'],
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                    onTap: () {
                      setState(() => _bankNameController.text = bank['name']);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
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
    final availableBalance = widget.selectedAccount['availableBalance'] ??
        widget.selectedAccount['balance'] ?? 0.0;
    final exceedsBalance = _amount > availableBalance;

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recipient info
          if (_selectedRecipient != null)
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        _selectedRecipient!['name'].toString().substring(0, 1).toUpperCase(),
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
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
                          'Sending to',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          _selectedRecipient!['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: _previousStep,
                    child: Text(
                      'Change',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 24.h),

          Text(
            'Enter amount to send',
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
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: exceedsBalance
                  ? Border.all(color: Colors.red, width: 2)
                  : null,
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
                          color: exceedsBalance ? Colors.red : Colors.white,
                          fontSize: 48.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '0.00',
                          hintStyle: TextStyle(
                            color: Colors.white.withValues(alpha: 0.3),
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
                if (exceedsBalance) ...[
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 16.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Exceeds available balance',
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 8.h),

          // Available balance
          Text(
            'Available: $currencySymbol${availableBalance.toStringAsFixed(2)}',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 16.h),

          // Quick amounts
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
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
            decoration: InputDecoration(
              hintText: 'What is this payment for?',
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: 14.sp,
              ),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.05),
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
              onPressed: _amount > 0 && !exceedsBalance ? _nextStep : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _amount > 0 && !exceedsBalance
                    ? Colors.orange
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
    final availableBalance = widget.selectedAccount['availableBalance'] ??
        widget.selectedAccount['balance'] ?? 0.0;
    final isDisabled = amount > availableBalance;

    return GestureDetector(
      onTap: isDisabled ? null : () => setState(() => _amount = amount.toDouble()),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: _amount == amount
              ? Colors.orange.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: isDisabled ? 0.02 : 0.05),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: _amount == amount ? Colors.orange : Colors.transparent,
          ),
        ),
        child: Text(
          '$symbol${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
          style: TextStyle(
            color: isDisabled
                ? Colors.white.withValues(alpha: 0.3)
                : Colors.white,
            fontSize: 13.sp,
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
    const fee = 10.0; // VFD transfer fee
    final total = _amount + fee;

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review your transfer',
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
                  Colors.orange.withValues(alpha: 0.3),
                  Colors.orange.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Text(
                  'Amount to Send',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
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

          // Recipient details
          _buildReviewSection('Recipient', [
            {'label': 'Name', 'value': _selectedRecipient?['name'] ?? ''},
            {'label': 'Bank', 'value': _selectedRecipient?['bank'] ?? ''},
            {'label': 'Account', 'value': _selectedRecipient?['accountNumber'] ?? ''},
          ]),
          SizedBox(height: 16.h),

          // Transaction details
          _buildReviewSection('Transaction Details', [
            {'label': 'Amount', 'value': '$currencySymbol${_amount.toStringAsFixed(2)}'},
            {'label': 'Transfer Fee', 'value': '$currencySymbol${fee.toStringAsFixed(2)}'},
            {'label': 'Total Debit', 'value': '$currencySymbol${total.toStringAsFixed(2)}', 'isTotal': true},
            if (_narration.isNotEmpty) {'label': 'Narration', 'value': _narration},
          ]),
          SizedBox(height: 32.h),

          // Continue to PIN
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Confirm & Enter PIN',
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

  Widget _buildReviewSection(String title, List<Map<String, dynamic>> items) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          ...items.map((item) => Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item['label'],
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  item['value'],
                  style: TextStyle(
                    color: item['isTotal'] == true ? Colors.orange : Colors.white,
                    fontSize: 14.sp,
                    fontWeight: item['isTotal'] == true ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  // =====================================================
  // STEP 4: PIN Authentication
  // =====================================================
  Widget _buildPinAuthStep() {
    return _PinEntryWidget(
      onPinComplete: (pin) {
        // Verify PIN and initiate transfer
        _initiateWithdrawal(context, pin);
      },
    );
  }

  void _initiateWithdrawal(BuildContext context, String pin) {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      Get.snackbar(
        'Error',
        'Please log in to continue',
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final accessToken = authState.profile.session.accessToken;
    final accountId = widget.selectedAccount['id'];
    final currency = widget.selectedAccount['currency'] ?? 'NGN';

    context.read<WithdrawalCubit>().initiateWithdrawal(
      sourceAccountId: accountId is int ? accountId : int.parse(accountId.toString()),
      amount: _amount,
      currency: currency,
      targetBankName: _selectedRecipient?['bank'] ?? '',
      targetAccountNumber: _selectedRecipient?['accountNumber'] ?? '',
      accessToken: accessToken,
    );

    _nextStep();
  }

  // =====================================================
  // STEP 5: Processing
  // =====================================================
  Widget _buildProcessingStep() {
    return BlocConsumer<WithdrawalCubit, WithdrawalState>(
      listener: (context, state) {
        if (state is WithdrawalFailure) {
          Get.snackbar(
            'Transfer Failed',
            state.message,
            backgroundColor: Colors.red.withValues(alpha: 0.9),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
      builder: (context, withdrawalState) {
        return BlocBuilder<BalanceWebSocketCubit, BalanceWebSocketState>(
          builder: (context, wsState) {
            // Check for real-time status update
            final lastUpdate = wsState.lastUpdate;
            final isCompleted = withdrawalState is WithdrawalSuccess ||
                (lastUpdate != null &&
                    lastUpdate.eventType == 'withdrawal' &&
                    lastUpdate.status == 'completed');
            final isFailed = withdrawalState is WithdrawalFailure ||
                (lastUpdate != null &&
                    lastUpdate.eventType == 'withdrawal' &&
                    lastUpdate.status == 'failed');

            return _WithdrawalProcessingView(
              amount: _amount,
              currency: widget.selectedAccount['currency'] ?? 'NGN',
              recipientName: _selectedRecipient?['name'] ?? '',
              isCompleted: isCompleted,
              isFailed: isFailed,
              failureMessage: withdrawalState is WithdrawalFailure
                  ? withdrawalState.message
                  : null,
              onDone: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            );
          },
        );
      },
    );
  }
}

/// PIN Entry Widget
class _PinEntryWidget extends StatefulWidget {
  final Function(String) onPinComplete;

  const _PinEntryWidget({required this.onPinComplete});

  @override
  State<_PinEntryWidget> createState() => _PinEntryWidgetState();
}

class _PinEntryWidgetState extends State<_PinEntryWidget> {
  String _pin = '';

  void _addDigit(String digit) {
    if (_pin.length < 4) {
      setState(() => _pin += digit);
      if (_pin.length == 4) {
        widget.onPinComplete(_pin);
      }
    }
  }

  void _removeDigit() {
    if (_pin.isNotEmpty) {
      setState(() => _pin = _pin.substring(0, _pin.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock_outline,
            color: Colors.orange,
            size: 48.sp,
          ),
          SizedBox(height: 24.h),
          Text(
            'Enter your PIN',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Enter your 4-digit PIN to confirm this transfer',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),

          // PIN dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              final isFilled = index < _pin.length;
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: isFilled ? Colors.orange : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isFilled ? Colors.orange : Colors.white.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 48.h),

          // Number pad
          _buildNumberPad(),
        ],
      ),
    );
  }

  Widget _buildNumberPad() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['1', '2', '3'].map((d) => _buildNumberButton(d)).toList(),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['4', '5', '6'].map((d) => _buildNumberButton(d)).toList(),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['7', '8', '9'].map((d) => _buildNumberButton(d)).toList(),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 80.w), // Empty space
            _buildNumberButton('0'),
            GestureDetector(
              onTap: _removeDigit,
              child: Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.backspace_outlined,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNumberButton(String digit) {
    return GestureDetector(
      onTap: () => _addDigit(digit),
      child: Container(
        width: 80.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            digit,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

/// Processing view with animations
class _WithdrawalProcessingView extends StatefulWidget {
  final double amount;
  final String currency;
  final String recipientName;
  final bool isCompleted;
  final bool isFailed;
  final String? failureMessage;
  final VoidCallback onDone;

  const _WithdrawalProcessingView({
    required this.amount,
    required this.currency,
    required this.recipientName,
    required this.isCompleted,
    required this.isFailed,
    this.failureMessage,
    required this.onDone,
  });

  @override
  State<_WithdrawalProcessingView> createState() => _WithdrawalProcessingViewState();
}

class _WithdrawalProcessingViewState extends State<_WithdrawalProcessingView>
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

    Color statusColor;
    IconData statusIcon;
    String statusText;

    if (widget.isCompleted) {
      statusColor = Colors.green;
      statusIcon = Icons.check;
      statusText = 'Transfer Successful!';
    } else if (widget.isFailed) {
      statusColor = Colors.red;
      statusIcon = Icons.close;
      statusText = 'Transfer Failed';
    } else {
      statusColor = Colors.orange;
      statusIcon = Icons.hourglass_top;
      statusText = 'Processing Transfer...';
    }

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated icon
            ScaleTransition(
              scale: widget.isCompleted || widget.isFailed
                  ? const AlwaysStoppedAnimation(1.0)
                  : _pulseAnimation,
              child: Container(
                width: 120.w,
                height: 120.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [statusColor, statusColor.withValues(alpha: 0.7)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: statusColor.withValues(alpha: 0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  statusIcon,
                  color: Colors.white,
                  size: 60.sp,
                ),
              ),
            ),
            SizedBox(height: 32.h),

            // Status text
            Text(
              statusText,
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
                color: statusColor,
                fontSize: 36.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),

            // Recipient
            Text(
              'to ${widget.recipientName}',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 24.h),

            // Status message
            if (widget.failureMessage != null)
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 20.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        widget.failureMessage!,
                        style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ),

            if (!widget.isFailed && !widget.isCompleted)
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.orange),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'This may take a few moments',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: 48.h),

            // Done button (only show when finished)
            if (widget.isCompleted || widget.isFailed)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: widget.onDone,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: statusColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    widget.isCompleted ? 'Done' : 'Try Again',
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
