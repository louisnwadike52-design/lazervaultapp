import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_command_sheet.dart';

class CBCurrencyExchangeScreen extends StatefulWidget {
  const CBCurrencyExchangeScreen({super.key});

  @override
  State<CBCurrencyExchangeScreen> createState() =>
      _CBCurrencyExchangeScreenState();
}

class _CBCurrencyExchangeScreenState extends State<CBCurrencyExchangeScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  final bool _isVoiceEnabled = false;
  List<Map<String, dynamic>> _recentTransactions = [];

  // All available currencies
  final Map<String, Map<String, dynamic>> _allCurrencies = {
    'GBP': {
      'name': 'British Pound',
      'symbol': '£',
      'flag': 'https://flagcdn.com/w320/gb.png',
      'country': 'United Kingdom',
      'balance': 2450.75,
      'rate': 1.0, // Base currency
      'color': const Color(0xFF1E3A8A),
    },
    'USD': {
      'name': 'US Dollar',
      'symbol': '\$',
      'flag': 'https://flagcdn.com/w320/us.png',
      'country': 'United States',
      'balance': 3200.50,
      'rate': 1.25,
      'color': const Color(0xFF059669),
    },
    'EUR': {
      'name': 'Euro',
      'symbol': '€',
      'flag': 'https://flagcdn.com/w320/eu.png',
      'country': 'European Union',
      'balance': 1850.30,
      'rate': 1.15,
      'color': const Color(0xFF7C3AED),
    },
    'JPY': {
      'name': 'Japanese Yen',
      'symbol': '¥',
      'flag': 'https://flagcdn.com/w320/jp.png',
      'country': 'Japan',
      'balance': 125000.0,
      'rate': 150.25,
      'color': const Color(0xFFDC2626),
    },
    'AUD': {
      'name': 'Australian Dollar',
      'symbol': 'A\$',
      'flag': 'https://flagcdn.com/w320/au.png',
      'country': 'Australia',
      'balance': 1750.80,
      'rate': 1.45,
      'color': const Color(0xFFEA580C),
    },
    'CAD': {
      'name': 'Canadian Dollar',
      'symbol': 'C\$',
      'flag': 'https://flagcdn.com/w320/ca.png',
      'country': 'Canada',
      'balance': 2100.25,
      'rate': 1.35,
      'color': const Color(0xFF0891B2),
    },
    'CHF': {
      'name': 'Swiss Franc',
      'symbol': 'CHF',
      'flag': 'https://flagcdn.com/w320/ch.png',
      'country': 'Switzerland',
      'balance': 1950.60,
      'rate': 1.10,
      'color': const Color(0xFF7C2D12),
    },
    'CNY': {
      'name': 'Chinese Yuan',
      'symbol': '¥',
      'flag': 'https://flagcdn.com/w320/cn.png',
      'country': 'China',
      'balance': 8500.40,
      'rate': 8.75,
      'color': const Color(0xFFBE123C),
    },
    'INR': {
      'name': 'Indian Rupee',
      'symbol': '₹',
      'flag': 'https://flagcdn.com/w320/in.png',
      'country': 'India',
      'balance': 95000.0,
      'rate': 102.50,
      'color': const Color(0xFF9333EA),
    },
  };

  // Mock saved recipients
  final List<Map<String, dynamic>> _savedRecipients = [
    {
      'id': '1',
      'name': 'John Smith',
      'email': 'john.smith@email.com',
      'account': '****1234',
      'fullAccount': '1234567890',
      'bank': 'Chase Bank',
      'swift': 'CHASUS33',
      'country': 'United States',
      'currency': 'USD',
      'isFrequent': true,
      'lastUsed': DateTime.now().subtract(const Duration(days: 2)),
      'avatar': 'https://i.pravatar.cc/150?img=1',
    },
    {
      'id': '2',
      'name': 'Marie Dubois',
      'email': 'marie.dubois@email.fr',
      'account': '****5678',
      'fullAccount': '5678901234',
      'bank': 'BNP Paribas',
      'swift': 'BNPAFRPP',
      'country': 'France',
      'currency': 'EUR',
      'isFrequent': true,
      'lastUsed': DateTime.now().subtract(const Duration(days: 5)),
      'avatar': 'https://i.pravatar.cc/150?img=2',
    },
    {
      'id': '3',
      'name': 'Hiroshi Tanaka',
      'email': 'h.tanaka@email.jp',
      'account': '****9012',
      'fullAccount': '9012345678',
      'bank': 'Mitsubishi UFJ',
      'swift': 'BOTKJPJT',
      'country': 'Japan',
      'currency': 'JPY',
      'isFrequent': false,
      'lastUsed': DateTime.now().subtract(const Duration(days: 15)),
      'avatar': 'https://i.pravatar.cc/150?img=3',
    },
    {
      'id': '4',
      'name': 'Sarah Wilson',
      'email': 'sarah.wilson@email.ca',
      'account': '****3456',
      'fullAccount': '3456789012',
      'bank': 'Royal Bank of Canada',
      'swift': 'ROYCCAT2',
      'country': 'Canada',
      'currency': 'CAD',
      'isFrequent': true,
      'lastUsed': DateTime.now().subtract(const Duration(days: 1)),
      'avatar': 'https://i.pravatar.cc/150?img=4',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
    _loadRecentTransactions();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _loadRecentTransactions() {
    setState(() {
      _recentTransactions = [
        {
          'from': 'GBP',
          'to': 'USD',
          'amount': 1000.00,
          'converted': 1250.00,
          'rate': 1.25,
          'date': '2024-03-20',
          'status': 'Completed',
          'recipient': 'John Smith'
        },
        {
          'from': 'USD',
          'to': 'EUR',
          'amount': 500.00,
          'converted': 460.00,
          'rate': 0.92,
          'date': '2024-03-19',
          'status': 'Completed',
          'recipient': 'Marie Dubois'
        },
        {
          'from': 'GBP',
          'to': 'JPY',
          'amount': 750.00,
          'converted': 112687.50,
          'rate': 150.25,
          'date': '2024-03-18',
          'status': 'Completed',
          'recipient': 'Hiroshi Tanaka'
        },
      ];
    });
  }

  void _showVoiceAgentSheet() {
    final currencyExchangeSuggestions = [
      'Send money to John in USA',
      'Check exchange rate for Euro',
      'Show my recent transfers',
      'Send money to saved recipient',
      'Start new international transfer',
      'Check currency rates',
      'Send to Marie in France',
      'View transaction history',
      'Add new recipient',
      'Send money to Japan',
    ];
    
    Get.bottomSheet(
      FractionallySizedBox(
        heightFactor: 0.85,
        child: VoiceCommandSheet(suggestions: currencyExchangeSuggestions),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _navigateToAmountWithRecipient(Map<String, dynamic> recipient) {
    // Navigate to amount screen with recipient pre-selected
    // Flow: Amount (2/3) -> Review (3/3)
    Get.toNamed(
      AppRoutes.internationalTransferAmount,
      arguments: {
        'fromCurrency': 'GBP', // Default from currency
        'toCurrency': recipient['currency'],
        'fromCurrencyData': _allCurrencies['GBP'],
        'toCurrencyData': _allCurrencies[recipient['currency']],
        'preSelectedRecipient': recipient,
        'skipRecipientSelection': true, // Flag to skip to page 4
        'currentStep': 2,
        'totalSteps': 3,
        'stepTitle': 'Enter Amount',
      },
    );
  }

  void _navigateToAmountWithTransaction(Map<String, dynamic> transaction) {
    // Show transaction details instead of navigating directly
    _showTransactionDetails(transaction);
  }

  void _navigateToReviewWithTransaction(Map<String, dynamic> transaction) {
    // Navigate directly to review screen (page 4) with transaction data
    // Flow: Review (1/1) - All previous steps completed
    Get.toNamed(
      AppRoutes.internationalTransferReview,
      arguments: {
        'fromCurrency': transaction['from'],
        'toCurrency': transaction['to'],
        'fromCurrencyData': _allCurrencies[transaction['from']],
        'toCurrencyData': _allCurrencies[transaction['to']],
        'amount': transaction['amount'],
        'convertedAmount': transaction['converted'],
        'exchangeRate': transaction['rate'],
        'fees': _calculateFees(transaction['amount']),
        'recipient': _getRecipientByName(transaction['recipient']),
        'currentStep': 1,
        'totalSteps': 1,
        'stepTitle': 'Review & Confirm',
        'isRepeatTransaction': true,
      },
    );
  }

  double _calculateFees(double amount) {
    // Mock fee calculation - typically 0.5% with minimum fee
    const feePercentage = 0.005;
    const minimumFee = 2.0;
    final calculatedFee = amount * feePercentage;
    return calculatedFee < minimumFee ? minimumFee : calculatedFee;
  }

  Map<String, dynamic>? _getRecipientByName(String name) {
    try {
      return _savedRecipients.firstWhere((recipient) => recipient['name'] == name);
    } catch (e) {
      return null;
    }
  }

  void _showAllRecipients() {
    Get.bottomSheet(
      FractionallySizedBox(
        heightFactor: 0.8,
        child: Container(
          padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'All Recipients',
                    style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.close, color: Colors.white, size: 24.sp),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: _savedRecipients.length,
                  itemBuilder: (context, index) {
                    final recipient = _savedRecipients[index];
                    return _buildRecipientListItem(recipient);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildRecipientListItem(Map<String, dynamic> recipient) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.back(); // Close bottom sheet
            _navigateToAmountWithRecipient(recipient);
          },
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: recipient['isFrequent']
                    ? Colors.orange.withValues(alpha: 0.3)
                    : Colors.white.withValues(alpha: 0.1),
                width: recipient['isFrequent'] ? 2 : 1,
            ),
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: recipient['avatar'],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[300],
                            child: Icon(Icons.person, color: Colors.grey[600]),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.blue[700]!, Colors.blue[500]!],
                              ),
                              shape: BoxShape.circle,
                  ),
                            child: Center(
                child: Text(
                                recipient['name'][0].toUpperCase(),
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (recipient['isFrequent'])
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 16.w,
                          height: 16.h,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(Icons.star, color: Colors.white, size: 10.sp),
                        ),
                      ),
                  ],
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
                              recipient['name'],
                              style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                  ),
                ),
              ),
                          if (recipient['isFrequent'])
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: Colors.orange.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(6.r),
      ),
                              child: Text(
                                'FREQUENT',
                                style: GoogleFonts.inter(
                                  color: Colors.orange,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${recipient['bank']} • ${recipient['account']}',
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          _buildCurrencyFlag(recipient['currency'], size: 16),
                          SizedBox(width: 6.w),
                          Text(
                            '${recipient['country']} • ${recipient['currency']}',
                            style: GoogleFonts.inter(
                              color: Colors.grey[500],
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAllTransactions() {
    Get.bottomSheet(
      FractionallySizedBox(
        heightFactor: 0.8,
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
                    'All Transactions',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white, size: 24.sp),
                    onPressed: () => Get.back(),
                  ),
                ],
        ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: _recentTransactions.length,
                  itemBuilder: (context, index) {
                    final transaction = _recentTransactions[index];
                    return _buildTransactionListItem(transaction);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildTransactionListItem(Map<String, dynamic> transaction) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.back(); // Close bottom sheet
          _showTransactionDetails(transaction);
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.all(16.w),
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
          child: Row(
            children: [
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 16.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildCurrencyFlag(transaction['from'], size: 16),
                        SizedBox(width: 4.w),
                        Text(
                          transaction['from'],
                          style: GoogleFonts.inter(
              color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Icon(Icons.arrow_forward, color: Colors.grey[400], size: 12.sp),
                        SizedBox(width: 6.w),
                        _buildCurrencyFlag(transaction['to'], size: 16),
                        SizedBox(width: 4.w),
                        Text(
                          transaction['to'],
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'To ${transaction['recipient']} • ${transaction['date']}',
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 10.sp,
          ),
        ),
      ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${_getCurrencySymbol(transaction['from'])}${transaction['amount']}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      transaction['status'],
                      style: GoogleFonts.inter(
                        color: Colors.green,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    }

  void _showTransactionDetails(Map<String, dynamic> transaction) {
    Get.bottomSheet(
      FractionallySizedBox(
        heightFactor: 0.8,
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(2.r),
        ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transaction Details',
                    style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
          ),
        ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white, size: 24.sp),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                      // Transaction Status
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.withValues(alpha: 0.2),
                              Colors.green.withValues(alpha: 0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green, size: 24.sp),
                            SizedBox(width: 12.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Transaction Completed',
                                  style: GoogleFonts.inter(
                                    color: Colors.green,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  transaction['date'],
                                  style: GoogleFonts.inter(
                                    color: Colors.green.withValues(alpha: 0.8),
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      
                      // Currency Exchange Details
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    _buildCurrencyFlag(transaction['from'], size: 32),
            SizedBox(height: 8.h),
                                    Text(
                                      transaction['from'],
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '${_getCurrencySymbol(transaction['from'])}${transaction['amount']}',
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 24.w),
                                Icon(Icons.arrow_forward, color: Colors.blue, size: 24.sp),
                                SizedBox(width: 24.w),
                                Column(
                                  children: [
                                    _buildCurrencyFlag(transaction['to'], size: 32),
            SizedBox(height: 8.h),
                                    Text(
                                      transaction['to'],
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '${_getCurrencySymbol(transaction['to'])}${transaction['converted']}',
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
            SizedBox(height: 16.h),
                            Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: Colors.blue.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
            Text(
                                    'Exchange Rate: ${transaction['rate']}',
                                    style: GoogleFonts.inter(
                                      color: Colors.blue,
                fontSize: 14.sp,
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
                      
                      // Transaction Details
                      _buildDetailRow('Transaction ID', 'TXN${DateTime.now().millisecondsSinceEpoch}'),
                      _buildDetailRow('Date & Time', '${transaction['date']} 14:30 GMT'),
                      _buildDetailRow('Recipient', transaction['recipient']),
                      _buildDetailRow('Status', transaction['status']),
                      _buildDetailRow('Processing Fee', 'Free'),
                      _buildDetailRow('Total Sent', '${_getCurrencySymbol(transaction['from'])}${transaction['amount']}'),
                      _buildDetailRow('Total Received', '${_getCurrencySymbol(transaction['to'])}${transaction['converted']}'),
                      
                      SizedBox(height: 32.h),
          ],
        ),
                ),
              ),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16.r),
            ),
                      child: ElevatedButton.icon(
                        onPressed: () => _downloadReceipt(transaction),
            style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
              ),
            ),
                        icon: Icon(Icons.download, color: Colors.white, size: 20.sp),
                        label: Text(
                          'Receipt',
                          style: GoogleFonts.inter(
                color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue[700]!, Colors.blue[500]!],
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.back(); // Close bottom sheet
                          _navigateToReviewWithTransaction(transaction);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        icon: Icon(Icons.refresh, color: Colors.white, size: 20.sp),
                        label: Text(
                          'Repeat',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
              ),
            ),
          ),
        ],
      ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _downloadReceipt(Map<String, dynamic> transaction) {
    // Simulate receipt download
    Get.snackbar(
      'Receipt Downloaded',
      'Transaction receipt has been saved to your downloads',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      icon: Icon(Icons.download_done, color: Colors.white),
    );
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                _buildStartTransferButton(),
                SizedBox(height: 32.h),
                _buildLiveExchangeRates(),
                SizedBox(height: 32.h),
                _buildPreviousRecipients(),
                SizedBox(height: 32.h),
                _buildRecentTransactions(),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: FadeTransition(
        opacity: _fadeAnimation,
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
              onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.sp,
              ),
        ),
      ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                'International Payment',
                style: GoogleFonts.inter(
          color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: _isVoiceEnabled ? Colors.blue.withValues(alpha: 0.2) : Colors.grey[900],
                borderRadius: BorderRadius.circular(12.r),
                border: _isVoiceEnabled ? Border.all(color: Colors.blue, width: 1) : null,
              ),
              child: IconButton(
                icon: Icon(
                  _isVoiceEnabled ? Icons.mic : Icons.mic_off,
                  color: _isVoiceEnabled ? Colors.blue : Colors.white,
                  size: 20.sp,
                ),
                onPressed: _showVoiceAgentSheet,
              ),
            ),
            SizedBox(width: 12.w),
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: IconButton(
                icon: Icon(Icons.history, color: Colors.white, size: 20.sp),
                onPressed: () {
                  Get.toNamed(AppRoutes.currencyTransactionHistory);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartTransferButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _startNewTransfer,
          borderRadius: BorderRadius.circular(20.r),
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue[700]!,
                  Colors.blue[500]!,
                ],
              ),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 28.sp,
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
                        'Start New International Transfer',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Send money worldwide with competitive rates',
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.8),
            fontSize: 14.sp,
          ),
        ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLiveExchangeRates() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Text(
                  'Live Exchange Rates',
                  style: GoogleFonts.inter(
                  color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                ),
              ),
                SizedBox(width: 12.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle, color: Colors.green, size: 8.sp),
                      SizedBox(width: 6.w),
                      Text(
                        'LIVE',
                        style: GoogleFonts.inter(
                          color: Colors.green,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
            ),
          ),
          SizedBox(height: 16.h),
                  SizedBox(
          height: 160.h,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: _allCurrencies.length,
              itemBuilder: (context, index) {
                final entry = _allCurrencies.entries.elementAt(index);
                final currency = entry.value;
                final code = entry.key;
                
    return Container(
                  width: 160.w,
                  margin: EdgeInsets.only(right: 16.w),
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
          Row(
            children: [
                          _buildCurrencyFlag(code, size: 28),
                          SizedBox(width: 12.w),
              Text(
                            code,
                            style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                ),
              ),
                        ],
                      ),
                      SizedBox(height: 8.h),
              Text(
                        currency['name'],
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                  fontSize: 12.sp,
                ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        '${currency['symbol']}${currency['rate'].toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'per GBP',
                        style: GoogleFonts.inter(
                          color: Colors.grey[500],
                          fontSize: 10.sp,
                ),
              ),
            ],
          ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviousRecipients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Previous Recipients',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton(
                onPressed: () {
                  _showAllRecipients();
                },
                child: Text(
                  'View All',
                  style: GoogleFonts.inter(
                    color: Colors.blue,
                  fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        // Horizontal Recipients List
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: _savedRecipients.length + 1, // +1 for Add New card
            itemBuilder: (context, index) {
              if (index == 0) {
                // Add New Recipient Card
                return Container(
                  width: 160.w,
                  margin: EdgeInsets.only(right: 16.w),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _startNewTransfer,
                      borderRadius: BorderRadius.circular(20.r),
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.blue.withValues(alpha: 0.3), width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
            children: [
                            Container(
                              width: 60.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                color: Colors.blue.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.add, color: Colors.blue, size: 28.sp),
                            ),
                            SizedBox(height: 16.h),
              Text(
                              'Add New\nRecipient',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: Colors.blue,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Send money to someone new',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: Colors.blue.withValues(alpha: 0.7),
                                fontSize: 10.sp,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              
              final recipient = _savedRecipients[index - 1];
              return _buildRecipientCard(recipient);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecipientCard(Map<String, dynamic> recipient) {
    return Container(
      width: 160.w,
      margin: EdgeInsets.only(right: 16.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _navigateToAmountWithRecipient(recipient),
          borderRadius: BorderRadius.circular(20.r),
          splashColor: Colors.blue.withValues(alpha: 0.2),
          highlightColor: Colors.blue.withValues(alpha: 0.1),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: recipient['isFrequent']
                    ? [
                        Colors.orange.withValues(alpha: 0.15),
                        Colors.orange.withValues(alpha: 0.05),
                      ]
                    : [
                        Colors.white.withValues(alpha: 0.08),
                        Colors.white.withValues(alpha: 0.03),
                      ],
              ),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: recipient['isFrequent']
                    ? Colors.orange.withValues(alpha: 0.4)
                    : Colors.white.withValues(alpha: 0.15),
                width: recipient['isFrequent'] ? 2 : 1,
                ),
              boxShadow: [
                BoxShadow(
                  color: recipient['isFrequent']
                      ? Colors.orange.withValues(alpha: 0.1)
                      : Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Main content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar with star indicator
              SizedBox(
                      width: 70.w,
                      height: 70.h,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 10.w,
                            top: 10.w,
                            child: Container(
                              width: 50.w,
                              height: 50.h,
                decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: recipient['avatar'],
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: Colors.grey[300],
                                    child: Icon(Icons.person, color: Colors.grey[600]),
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.blue[700]!, Colors.blue[500]!],
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                child: Text(
                                        recipient['name'][0].toUpperCase(),
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w600,
                  ),
                ),
              ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (recipient['isFrequent'])
                            Positioned(
                              bottom: 5.h,
                              right: 5.w,
                              child: Container(
                                width: 20.w,
                                height: 20.h,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.orange.withValues(alpha: 0.3),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(Icons.star, color: Colors.white, size: 12.sp),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    
                    // Name with overflow protection
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        recipient['name'],
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    
                    // Bank info with overflow protection
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        recipient['bank'],
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 9.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        recipient['account'],
                        style: GoogleFonts.inter(
                          color: Colors.grey[500],
                          fontSize: 9.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    
                    Spacer(),
                    
                    // Currency info and flags at bottom
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text(
                            recipient['currency'],
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                ),
              ),
                        SizedBox(width: 4.w),
                        Flexible(
                          flex: 3,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildCurrencyFlag('GBP', size: 14),
                              SizedBox(width: 3.w),
                              Icon(Icons.arrow_forward, color: Colors.blue, size: 10.sp),
                              SizedBox(width: 3.w),
                              _buildCurrencyFlag(recipient['currency'], size: 14),
                            ],
                          ),
          ),
        ],
                    ),
                  ],
                ),
                // Clickable indicator at top right edge
                Positioned(
                  top: -5.h,
                  right: -5.w,
                  child: Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(Icons.touch_app, color: Colors.white, size: 12.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transactions',
                style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
          ),
        ),
              TextButton(
            onPressed: () {
                  _showAllTransactions();
                },
                child: Text(
                  'View All',
                  style: GoogleFonts.inter(
                    color: Colors.blue,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
          ),
        ],
      ),
        ),
        SizedBox(height: 16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: _recentTransactions.length,
          itemBuilder: (context, index) {
            final transaction = _recentTransactions[index];
            return _buildTransactionCard(transaction);
          },
        ),
      ],
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _navigateToAmountWithTransaction(transaction),
        borderRadius: BorderRadius.circular(20.r),
        splashColor: Colors.green.withValues(alpha: 0.2),
        highlightColor: Colors.green.withValues(alpha: 0.1),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.only(bottom: 16.h),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.08),
                Colors.white.withValues(alpha: 0.03),
              ],
            ),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Main content
              Row(
                children: [
                  // Left side - Status icon
              Container(
                    width: 50.w,
                    height: 50.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                    colors: [
                          Colors.green.withValues(alpha: 0.3),
                          Colors.green.withValues(alpha: 0.15),
                    ],
                  ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 24.sp,
                    ),
                ),
                  SizedBox(width: 16.w),
                  
                  // Middle - Transaction details with overflow protection
                  Expanded(
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'To ${transaction['recipient']}',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            '${_getCurrencySymbol(transaction['from'])}${transaction['amount']} → ${_getCurrencySymbol(transaction['to'])}${transaction['converted']}',
                            style: GoogleFonts.inter(
                              color: Colors.grey[400],
                        fontSize: 14.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 8.h),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                transaction['date'],
                                style: GoogleFonts.inter(
                                  color: Colors.grey[500],
                                  fontSize: 12.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                ),
              ),
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.green.withValues(alpha: 0.3),
                                    Colors.green.withValues(alpha: 0.2),
                                  ],
                  ),
                                borderRadius: BorderRadius.circular(8.r),
                                boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                              ),
                              child: Text(
                                transaction['status'],
                                style: GoogleFonts.inter(
                                  color: Colors.green,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                    ),
                            ),
                          ],
                  ),
                ],
              ),
                  ),

                  // Right side - Currency flags with enhanced styling
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: _buildCurrencyFlag(transaction['from'], size: 20),
                            ),
                            SizedBox(width: 6.w),
                            Icon(Icons.arrow_forward, color: Colors.blue, size: 14.sp),
                            SizedBox(width: 6.w),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: _buildCurrencyFlag(transaction['to'], size: 20),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                            'Rate: ${transaction['rate']}',
                            style: GoogleFonts.inter(
                              color: Colors.blue,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                      ],
                    ),
                  ),
                ],
              ),
              // Clickable indicator at top right edge
              Positioned(
                top: -5.h,
                right: -5.w,
                child: Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.3),
                        blurRadius: 4,
                        offset: Offset(0, 2),
              ),
                    ],
                  ),
                  child: Icon(Icons.touch_app, color: Colors.white, size: 12.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencyFlag(String currencyCode, {double size = 24}) {
    final currency = _allCurrencies[currencyCode];
    if (currency == null) return const SizedBox.shrink();
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: currency['flag'],
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

  String _getCurrencySymbol(String currencyCode) {
    final currency = _allCurrencies[currencyCode];
    return currency?['symbol'] ?? currencyCode;
  }

  void _startNewTransfer() {
    // Navigate to the start screen for new transfer
    // Flow: Currency Selection (1/4) -> Amount (2/4) -> Recipient (3/4) -> Review (4/4)
    Get.toNamed(
      AppRoutes.internationalTransferStart,
      arguments: {
        'currentStep': 1,
        'totalSteps': 4,
        'stepTitle': 'Select Currencies',
      },
    );
  }
}
