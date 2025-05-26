import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:lazervault/core/types/app_routes.dart';

class DepositMethodSelectionScreen extends StatefulWidget {
  const DepositMethodSelectionScreen({super.key});

  @override
  State<DepositMethodSelectionScreen> createState() =>
      _DepositMethodSelectionScreenState();
}

class _DepositMethodSelectionScreenState extends State<DepositMethodSelectionScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  Map<String, dynamic> _currency = {};
  String _selectedMethod = '';

  // Local account wallets from dashboard (similar to dashboard_card_summary.dart)
  final List<Map<String, dynamic>> _localAccounts = [
    {
      "accountType": "Personal Account",
      "currency": "GBP",
      "balance": 12000.00,
      "accountNumber": "•••• 7890",
      "trend": "+2.4%",
      "isUp": true,
      "id": "personal_gbp",
    },
    {
      "accountType": "Savings Account", 
      "currency": "GBP",
      "balance": 5430.00,
      "accountNumber": "•••• 5678",
      "trend": "+1.2%",
      "isUp": true,
      "id": "savings_gbp",
    },
    {
      "accountType": "Investment Account",
      "currency": "GBP", 
      "balance": 8750.00,
      "accountNumber": "•••• 9012",
      "trend": "-0.8%",
      "isUp": false,
      "id": "investment_gbp",
    },
  ];

  // Recently used methods
  final List<Map<String, dynamic>> _recentlyUsedMethods = [
    {
      'id': 'local_transfer_personal_gbp',
      'name': 'Personal Account',
      'icon': Icons.account_balance_wallet,
      'description': 'Transfer from Personal Account',
      'isAvailable': true,
      'processingTime': 'Instant',
      'fee': 'Free',
      'lastUsed': '2 days ago',
      'balance': 12000.00,
      'currency': 'GBP',
      'type': 'local_account',
    },
    {
      'id': 'apple_pay',
      'name': 'Apple Pay',
      'icon': Icons.apple,
      'description': 'Touch ID or Face ID',
      'isAvailable': true,
      'processingTime': 'Instant',
      'fee': 'Free',
      'lastUsed': '1 week ago',
      'type': 'digital_wallet',
    },
  ];

  // Available payment methods
  final List<Map<String, dynamic>> _availableMethods = [
    {
      'id': 'apple_pay',
      'name': 'Apple Pay',
      'icon': Icons.apple,
      'description': 'Touch ID or Face ID',
      'isAvailable': true,
      'processingTime': 'Instant',
      'fee': 'Free',
      'isRecommended': true,
      'type': 'digital_wallet',
    },
    {
      'id': 'google_pay',
      'name': 'Google Pay',
      'icon': Icons.g_mobiledata,
      'description': 'Fingerprint or PIN',
      'isAvailable': true,
      'processingTime': 'Instant',
      'fee': 'Free',
      'isRecommended': false,
      'type': 'digital_wallet',
    },
    {
      'id': 'instant_bank',
      'name': 'Instant Bank Transfer',
      'icon': Icons.flash_on,
      'description': 'From your linked account',
      'isAvailable': true,
      'processingTime': 'Instant',
      'fee': '£0.50',
      'isRecommended': false,
      'type': 'bank_transfer',
    },
    {
      'id': 'regular_bank',
      'name': 'Regular Bank Transfer',
      'icon': Icons.account_balance,
      'description': 'Standard bank transfer',
      'isAvailable': true,
      'processingTime': '1-3 business days',
      'fee': 'Free',
      'isRecommended': false,
      'type': 'bank_transfer',
    },
  ];

  // Crypto payment methods
  final List<Map<String, dynamic>> _cryptoMethods = [
    {
      'id': 'bitcoin',
      'name': 'Bitcoin (BTC)',
      'icon': Icons.currency_bitcoin,
      'description': 'Deposit using Bitcoin',
      'isAvailable': true,
      'processingTime': '10-60 minutes',
      'fee': '0.5%',
      'type': 'crypto',
      'network': 'Bitcoin',
      'minAmount': 0.001,
      'maxAmount': 10.0,
    },
    {
      'id': 'ethereum',
      'name': 'Ethereum (ETH)',
      'icon': Icons.diamond,
      'description': 'Deposit using Ethereum',
      'isAvailable': true,
      'processingTime': '5-30 minutes',
      'fee': '0.3%',
      'type': 'crypto',
      'network': 'Ethereum',
      'minAmount': 0.01,
      'maxAmount': 100.0,
    },
    {
      'id': 'usdc',
      'name': 'USD Coin (USDC)',
      'icon': Icons.monetization_on,
      'description': 'Stable coin deposit',
      'isAvailable': true,
      'processingTime': '5-30 minutes',
      'fee': '0.2%',
      'type': 'crypto',
      'network': 'Ethereum',
      'minAmount': 10.0,
      'maxAmount': 50000.0,
    },
    {
      'id': 'usdt',
      'name': 'Tether (USDT)',
      'icon': Icons.attach_money,
      'description': 'Stable coin deposit',
      'isAvailable': true,
      'processingTime': '5-30 minutes',
      'fee': '0.2%',
      'type': 'crypto',
      'network': 'Ethereum',
      'minAmount': 10.0,
      'maxAmount': 50000.0,
    },
  ];

  // Unavailable methods
  final List<Map<String, dynamic>> _unavailableMethods = [
    {
      'id': 'paypal',
      'name': 'PayPal',
      'icon': Icons.payment,
      'description': 'Coming soon',
      'isAvailable': false,
      'reason': 'Not supported yet',
      'type': 'digital_wallet',
    },
    {
      'id': 'wire_transfer',
      'name': 'Wire Transfer',
      'icon': Icons.send,
      'description': 'International wire',
      'isAvailable': false,
      'reason': 'Not available for this currency',
      'type': 'bank_transfer',
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupAnimations();
  }

  void _initializeData() {
    final args = Get.arguments as Map<String, dynamic>;
    _currency = args['currency'] ?? {};
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectMethod(String methodId) {
    setState(() {
      _selectedMethod = methodId;
    });
  }

  void _proceedToAmount() {
    if (_selectedMethod.isEmpty) return;
    
    Map<String, dynamic> selectedMethodData = {};
    
    // Check in different method lists
    selectedMethodData = _availableMethods.firstWhere(
      (method) => method['id'] == _selectedMethod,
      orElse: () => {},
    );
    
    if (selectedMethodData.isEmpty) {
      selectedMethodData = _cryptoMethods.firstWhere(
        (method) => method['id'] == _selectedMethod,
        orElse: () => {},
      );
    }
    
    if (selectedMethodData.isEmpty) {
      selectedMethodData = _recentlyUsedMethods.firstWhere(
        (method) => method['id'] == _selectedMethod,
        orElse: () => {},
      );
    }
    
    // Check if it's a local account transfer
    if (_selectedMethod.startsWith('local_transfer_')) {
      final accountId = _selectedMethod.replaceFirst('local_transfer_', '');
      final account = _localAccounts.firstWhere(
        (acc) => acc['id'] == accountId,
        orElse: () => {},
      );
      
      if (account.isNotEmpty) {
        selectedMethodData = {
          'id': _selectedMethod,
          'name': 'Transfer from ${account['accountType']}',
          'icon': Icons.account_balance_wallet,
          'description': 'Internal account transfer',
          'isAvailable': true,
          'processingTime': 'Instant',
          'fee': 'Free',
          'type': 'local_account',
          'sourceAccount': account,
        };
      }
    }
    
    Get.toNamed(
      AppRoutes.depositAmount,
      arguments: {
        'currency': _currency,
        'paymentMethod': selectedMethodData,
      },
    );
  }

  // Get available local accounts that have sufficient balance and compatible currency
  List<Map<String, dynamic>> get _availableLocalAccounts {
    return _localAccounts.where((account) {
      // For now, allow transfers from GBP accounts to any currency
      // In production, you might want more sophisticated currency conversion logic
      return account['balance'] > 0;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: SingleChildScrollView(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24.h),
                        _buildCurrencyInfo(),
                        SizedBox(height: 32.h),
                        if (_recentlyUsedMethods.isNotEmpty) ...[
                          _buildRecentlyUsedSection(),
                          SizedBox(height: 32.h),
                        ],
                        if (_availableLocalAccounts.isNotEmpty) ...[
                          _buildLocalAccountsSection(),
                          SizedBox(height: 32.h),
                        ],
                        _buildAvailableMethodsSection(),
                        SizedBox(height: 32.h),
                        _buildCryptoMethodsSection(),
                        SizedBox(height: 32.h),
                        _buildUnavailableMethodsSection(),
                        SizedBox(height: 40.h),
                        _buildContinueButton(),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
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
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deposit Funds',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Choose your payment method',
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

  Widget _buildCurrencyInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withValues(alpha: 0.15),
            Colors.purple.withValues(alpha: 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          _buildCurrencyFlag(_currency['code'] ?? '', size: 40),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Depositing to ${_currency['code']} Wallet',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Current Balance: ${_currency['symbol']}${(_currency['balance'] ?? 0.0).toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
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

  Widget _buildRecentlyUsedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Recently Used',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: _recentlyUsedMethods.length,
          itemBuilder: (context, index) {
            final method = _recentlyUsedMethods[index];
            return _buildMethodCard(method, isRecent: true);
          },
        ),
      ],
    );
  }

  Widget _buildLocalAccountsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Local Accounts',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: _availableLocalAccounts.length,
          itemBuilder: (context, index) {
            final account = _availableLocalAccounts[index];
            return _buildLocalAccountCard(account);
          },
        ),
      ],
    );
  }

  Widget _buildAvailableMethodsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Available Methods',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: _availableMethods.length,
          itemBuilder: (context, index) {
            final method = _availableMethods[index];
            return _buildMethodCard(method);
          },
        ),
      ],
    );
  }

  Widget _buildCryptoMethodsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Crypto Methods',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: _cryptoMethods.length,
          itemBuilder: (context, index) {
            final method = _cryptoMethods[index];
            return _buildMethodCard(method, isCrypto: true);
          },
        ),
      ],
    );
  }

  Widget _buildUnavailableMethodsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Text(
                'Unavailable Methods',
                style: GoogleFonts.inter(
                  color: Colors.grey[500],
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.info_outline, color: Colors.grey[500], size: 16.sp),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: _unavailableMethods.length,
          itemBuilder: (context, index) {
            final method = _unavailableMethods[index];
            return _buildMethodCard(method, isUnavailable: true);
          },
        ),
      ],
    );
  }

  Widget _buildMethodCard(Map<String, dynamic> method, {bool isRecent = false, bool isUnavailable = false, bool isCrypto = false}) {
    final isSelected = _selectedMethod == method['id'];
    final isAvailable = method['isAvailable'] ?? false;
    
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isAvailable ? () => _selectMethod(method['id']) : null,
          borderRadius: BorderRadius.circular(16.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: isSelected && isAvailable
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.green.withValues(alpha: 0.2),
                        Colors.green.withValues(alpha: 0.1),
                      ],
                    )
                  : null,
              color: isSelected && isAvailable
                  ? null
                  : isUnavailable
                      ? Colors.white.withValues(alpha: 0.02)
                      : Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isSelected && isAvailable
                    ? Colors.green.withValues(alpha: 0.5)
                    : isUnavailable
                        ? Colors.grey.withValues(alpha: 0.2)
                        : Colors.white.withValues(alpha: 0.1),
                width: isSelected && isAvailable ? 2 : 1,
              ),
              boxShadow: isSelected && isAvailable ? [
                BoxShadow(
                  color: Colors.green.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                  spreadRadius: -1,
                ),
              ] : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    gradient: isAvailable
                        ? LinearGradient(
                            colors: [Colors.blue[700]!, Colors.blue[500]!],
                          )
                        : null,
                    color: isAvailable ? null : Colors.grey[700],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    method['icon'],
                    color: Colors.white,
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
                          Expanded(
                            child: Text(
                              method['name'],
                              style: GoogleFonts.inter(
                                color: isAvailable ? Colors.white : Colors.grey[500],
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (method['isRecommended'] == true)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.orange[600]!, Colors.orange[400]!],
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                'RECOMMENDED',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          if (isRecent)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: Colors.blue.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                'RECENT',
                                style: GoogleFonts.inter(
                                  color: Colors.blue,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        method['description'],
                        style: GoogleFonts.inter(
                          color: isAvailable ? Colors.grey[400] : Colors.grey[600],
                          fontSize: 12.sp,
                        ),
                      ),
                      if (isAvailable) ...[
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            _buildInfoChip('${method['processingTime']}', Icons.access_time),
                            SizedBox(width: 12.w),
                            _buildInfoChip('${method['fee']}', Icons.payment),
                            if (isRecent) ...[
                              SizedBox(width: 12.w),
                              _buildInfoChip('${method['lastUsed']}', Icons.history),
                            ],
                          ],
                        ),
                      ] else ...[
                        SizedBox(height: 4.h),
                        Text(
                          method['reason'] ?? 'Not available',
                          style: GoogleFonts.inter(
                            color: Colors.grey[600],
                            fontSize: 10.sp,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (isAvailable)
                  Icon(
                    isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: isSelected ? Colors.green : Colors.grey[400],
                    size: 24.sp,
                  )
                else
                  Icon(
                    Icons.block,
                    color: Colors.grey[600],
                    size: 20.sp,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocalAccountCard(Map<String, dynamic> account) {
    final isSelected = _selectedMethod == 'local_transfer_${account['id']}';
    final isUp = account['isUp'] ?? true;
    
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _selectMethod('local_transfer_${account['id']}'),
          borderRadius: BorderRadius.circular(16.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.green.withValues(alpha: 0.2),
                        Colors.green.withValues(alpha: 0.1),
                      ],
                    )
                  : null,
              color: isSelected ? null : Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isSelected
                    ? Colors.green.withValues(alpha: 0.5)
                    : Colors.white.withValues(alpha: 0.1),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected ? [
                BoxShadow(
                  color: Colors.green.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                  spreadRadius: -1,
                ),
              ] : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue[700]!, Colors.blue[500]!],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
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
                          Expanded(
                            child: Text(
                              account['accountType'],
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: isUp
                                  ? Colors.green.withValues(alpha: 0.2)
                                  : Colors.red.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              account['trend'],
                              style: GoogleFonts.inter(
                                color: isUp ? Colors.green[300] : Colors.red[300],
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Balance: £${account['balance'].toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          _buildInfoChip('Instant', Icons.flash_on),
                          SizedBox(width: 12.w),
                          _buildInfoChip('Free', Icons.payment),
                          SizedBox(width: 12.w),
                          _buildInfoChip('Internal', Icons.security),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: isSelected ? Colors.green : Colors.grey[400],
                  size: 24.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.grey[400], size: 12.sp),
          SizedBox(width: 4.w),
          Text(
            text,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    final isEnabled = _selectedMethod.isNotEmpty;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          gradient: isEnabled
              ? LinearGradient(colors: [Colors.green[700]!, Colors.green[500]!])
              : null,
          color: isEnabled ? null : Colors.grey[800],
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: isEnabled ? [
            BoxShadow(
              color: Colors.green.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ] : null,
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isEnabled ? _proceedToAmount : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 18.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Continue to Amount',
                  style: GoogleFonts.inter(
                    color: isEnabled ? Colors.white : Colors.grey[500],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_forward,
                  color: isEnabled ? Colors.white : Colors.grey[500],
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencyFlag(String currencyCode, {double size = 24}) {
    // Mock flag URLs for currencies
    final flagUrls = {
      'USD': 'https://flagcdn.com/w320/us.png',
      'EUR': 'https://flagcdn.com/w320/eu.png',
      'GBP': 'https://flagcdn.com/w320/gb.png',
      'JPY': 'https://flagcdn.com/w320/jp.png',
      'CAD': 'https://flagcdn.com/w320/ca.png',
      'AUD': 'https://flagcdn.com/w320/au.png',
      'CHF': 'https://flagcdn.com/w320/ch.png',
      'CNY': 'https://flagcdn.com/w320/cn.png',
      'INR': 'https://flagcdn.com/w320/in.png',
    };
    
    return Container(
      width: size,
      height: size * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.r),
        child: CachedNetworkImage(
          imageUrl: flagUrls[currencyCode] ?? '',
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey[300],
            child: Icon(Icons.flag, size: size * 0.5, color: Colors.grey[600]),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[300],
            child: Icon(Icons.flag, size: size * 0.5, color: Colors.grey[600]),
          ),
        ),
      ),
    );
  }
} 