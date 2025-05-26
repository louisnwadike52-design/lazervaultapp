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
  late PageController _pageController;
  
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _convertedAmountController =
      TextEditingController();
  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _receiverAccountController =
      TextEditingController();
  final TextEditingController _receiverBankController = TextEditingController();
  final TextEditingController _receiverSwiftController =
      TextEditingController();
  

  
  String _selectedFromCurrency = 'GBP';
  String _selectedToCurrency = 'USD';
  int _currentCardIndex = 0;
  bool _isProcessing = false;
  final bool _isVoiceEnabled = false;
  List<Map<String, dynamic>> _recentTransactions = [];
  Map<String, dynamic>? _selectedRecipient;

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
      'hasTransactions': true,
    },
    'USD': {
      'name': 'US Dollar',
      'symbol': '\$',
      'flag': 'https://flagcdn.com/w320/us.png',
      'country': 'United States',
      'balance': 3200.50,
      'rate': 1.25,
      'color': const Color(0xFF059669),
      'hasTransactions': true,
    },
    'EUR': {
      'name': 'Euro',
      'symbol': '€',
      'flag': 'https://flagcdn.com/w320/eu.png',
      'country': 'European Union',
      'balance': 1850.30,
      'rate': 1.15,
      'color': const Color(0xFF7C3AED),
      'hasTransactions': true,
    },
    'JPY': {
      'name': 'Japanese Yen',
      'symbol': '¥',
      'flag': 'https://flagcdn.com/w320/jp.png',
      'country': 'Japan',
      'balance': 125000.0,
      'rate': 150.25,
      'color': const Color(0xFFDC2626),
      'hasTransactions': true,
    },
    'AUD': {
      'name': 'Australian Dollar',
      'symbol': 'A\$',
      'flag': 'https://flagcdn.com/w320/au.png',
      'country': 'Australia',
      'balance': 1750.80,
      'rate': 1.45,
      'color': const Color(0xFFEA580C),
      'hasTransactions': false,
    },
    'CAD': {
      'name': 'Canadian Dollar',
      'symbol': 'C\$',
      'flag': 'https://flagcdn.com/w320/ca.png',
      'country': 'Canada',
      'balance': 2100.25,
      'rate': 1.35,
      'color': const Color(0xFF0891B2),
      'hasTransactions': true,
    },
    'CHF': {
      'name': 'Swiss Franc',
      'symbol': 'CHF',
      'flag': 'https://flagcdn.com/w320/ch.png',
      'country': 'Switzerland',
      'balance': 1950.60,
      'rate': 1.10,
      'color': const Color(0xFF7C2D12),
      'hasTransactions': false,
    },
    'CNY': {
      'name': 'Chinese Yuan',
      'symbol': '¥',
      'flag': 'https://flagcdn.com/w320/cn.png',
      'country': 'China',
      'balance': 8500.40,
      'rate': 8.75,
      'color': const Color(0xFFBE123C),
      'hasTransactions': false,
    },
    'INR': {
      'name': 'Indian Rupee',
      'symbol': '₹',
      'flag': 'https://flagcdn.com/w320/in.png',
      'country': 'India',
      'balance': 95000.0,
      'rate': 102.50,
      'color': const Color(0xFF9333EA),
      'hasTransactions': false,
    },
  };

  // Mock saved recipients
  final List<Map<String, dynamic>> _savedRecipients = [
    {
      'id': '1',
      'name': 'John Smith',
      'email': 'john.smith@email.com',
      'account': '****1234',
      'bank': 'Chase Bank',
      'swift': 'CHASUS33',
      'country': 'United States',
      'currency': 'USD',
      'isFrequent': true,
      'lastUsed': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'id': '2',
      'name': 'Marie Dubois',
      'email': 'marie.dubois@email.fr',
      'account': '****5678',
      'bank': 'BNP Paribas',
      'swift': 'BNPAFRPP',
      'country': 'France',
      'currency': 'EUR',
      'isFrequent': true,
      'lastUsed': DateTime.now().subtract(const Duration(days: 5)),
    },
    {
      'id': '3',
      'name': 'Hiroshi Tanaka',
      'email': 'h.tanaka@email.jp',
      'account': '****9012',
      'bank': 'Mitsubishi UFJ',
      'swift': 'BOTKJPJT',
      'country': 'Japan',
      'currency': 'JPY',
      'isFrequent': false,
      'lastUsed': DateTime.now().subtract(const Duration(days: 15)),
    },
    {
      'id': '4',
      'name': 'Sarah Wilson',
      'email': 'sarah.wilson@email.ca',
      'account': '****3456',
      'bank': 'Royal Bank of Canada',
      'swift': 'ROYCCAT2',
      'country': 'Canada',
      'currency': 'CAD',
      'isFrequent': true,
      'lastUsed': DateTime.now().subtract(const Duration(days: 1)),
    },
  ];

  // Get currencies that have been used in transactions, ordered by selection
  List<Map<String, dynamic>> get _currencyCards {
    final List<Map<String, dynamic>> cards = [];
    
    // Add selected currencies first
    if (_selectedFromCurrency != _selectedToCurrency) {
      final fromCurrency = _allCurrencies[_selectedFromCurrency];
      final toCurrency = _allCurrencies[_selectedToCurrency];
      
      if (fromCurrency != null && fromCurrency['hasTransactions'] == true) {
        cards.add({'code': _selectedFromCurrency, ...fromCurrency});
      }
      if (toCurrency != null && toCurrency['hasTransactions'] == true && _selectedToCurrency != _selectedFromCurrency) {
        cards.add({'code': _selectedToCurrency, ...toCurrency});
      }
    } else {
      final selectedCurrency = _allCurrencies[_selectedFromCurrency];
      if (selectedCurrency != null && selectedCurrency['hasTransactions'] == true) {
        cards.add({'code': _selectedFromCurrency, ...selectedCurrency});
      }
    }
    
    // Add remaining currencies with transactions
    _allCurrencies.entries.forEach((entry) {
      if (entry.value['hasTransactions'] == true && 
          entry.key != _selectedFromCurrency && 
          entry.key != _selectedToCurrency) {
        cards.add({'code': entry.key, ...entry.value});
      }
    });
    
    return cards;
  }

  // Get ordered currency rates with selected currencies first
  List<Map<String, dynamic>> get _orderedCurrencyRates {
    final List<Map<String, dynamic>> rates = [];
    
    // Add selected currencies first
    if (_selectedFromCurrency != _selectedToCurrency) {
      final fromCurrency = _allCurrencies[_selectedFromCurrency];
      final toCurrency = _allCurrencies[_selectedToCurrency];
      
      if (fromCurrency != null) {
        rates.add({'code': _selectedFromCurrency, ...fromCurrency});
      }
      if (toCurrency != null) {
        rates.add({'code': _selectedToCurrency, ...toCurrency});
      }
    } else {
      final selectedCurrency = _allCurrencies[_selectedFromCurrency];
      if (selectedCurrency != null) {
        rates.add({'code': _selectedFromCurrency, ...selectedCurrency});
      }
    }
    
    // Add remaining currencies
    _allCurrencies.entries.forEach((entry) {
      if (entry.key != _selectedFromCurrency && entry.key != _selectedToCurrency) {
        rates.add({'code': entry.key, ...entry.value});
      }
    });
    
    return rates;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9, initialPage: 0);
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
    _pageController.dispose();
    _amountController.dispose();
    _convertedAmountController.dispose();
    _receiverNameController.dispose();
    _receiverAccountController.dispose();
    _receiverBankController.dispose();
    _receiverSwiftController.dispose();
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
          'status': 'Completed'
        },
        {
          'from': 'USD',
          'to': 'EUR',
          'amount': 500.00,
          'converted': 460.00,
          'rate': 0.92,
          'date': '2024-03-19',
          'status': 'Completed'
        },
      ];
    });
  }





  void _convertCurrency() {
    if (_amountController.text.isEmpty) return;

    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final fromCurrency = _allCurrencies[_selectedFromCurrency];
    final toCurrency = _allCurrencies[_selectedToCurrency];
    
    if (fromCurrency == null || toCurrency == null) return;
    
    final fromRate = fromCurrency['rate'] ?? 1.0;
    final toRate = toCurrency['rate'] ?? 1.0;
    final convertedAmount = (amount / fromRate) * toRate;

    setState(() {
      _convertedAmountController.text = convertedAmount.toStringAsFixed(2);
    });
  }

  void _onCardChanged(int index) {
    setState(() {
      _currentCardIndex = index;
      _selectedFromCurrency = _currencyCards[index]['code'];
    });
    _convertCurrency();
  }

  void _onCurrencyRateSelected(String currencyCode) {
    // Find the currency in the cards list
    final cardIndex = _currencyCards.indexWhere((card) => card['code'] == currencyCode);
    
    setState(() {
      _selectedFromCurrency = currencyCode;
      if (cardIndex != -1) {
        _currentCardIndex = cardIndex;
        // Update the page controller to show the selected card
        _pageController.animateToPage(
          cardIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
    _convertCurrency();
  }

  void _showVoiceAgentSheet() {
    final currencyExchangeSuggestions = [
      'Convert 500 pounds to dollars',
      'Send money to John in USA',
      'Check exchange rate for Euro',
      'Add new recipient details',
      'Show my recent transfers',
      'Convert Japanese Yen to GBP',
      'Send 1000 euros to France',
      'Check my currency balances',
      'Transfer to saved recipient',
      'Calculate exchange fees',
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
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  _buildSwipeableCurrencyCards(),
                  SizedBox(height: 16.h),
                  _buildCurrencyRatesList(),
                  SizedBox(height: 16.h),
                  _buildQuickRecipients(),
                  SizedBox(height: 24.h),
                  _buildExchangeRateDisplay(),
                  SizedBox(height: 24.h),
                  if (_selectedRecipient != null) _buildSelectedRecipient(),
                  if (_selectedRecipient != null) SizedBox(height: 16.h),
                  _buildCurrencySelection(),
                  SizedBox(height: 24.h),
                  _buildAmountInputs(),
                  SizedBox(height: 24.h),
                  _buildExchangeButton(),
                  SizedBox(height: 24.h),
                  _buildRecentTransactions(),
                  SizedBox(height: 24.h),
                ],
              ),
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

  Widget _buildSwipeableCurrencyCards() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          SizedBox(
            height: 160.h,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onCardChanged,
              itemCount: _currencyCards.length,
              itemBuilder: (context, index) {
                final card = _currencyCards[index];
                final isActive = index == _currentCardIndex;
                
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.only(
                    left: index == 0 ? 0 : (isActive ? 6.w : 12.w),
                    right: isActive ? 6.w : 12.w,
                    top: isActive ? 4.h : 8.h,
                    bottom: isActive ? 4.h : 8.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                                                 card['color'].withValues(alpha: 0.8),
                         card['color'].withValues(alpha: 0.6),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24.r),
                    border: isActive ? Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 2,
                    ) : null,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                _buildCurrencyFlag(card['code'], size: 32),
                                SizedBox(width: 12.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      card['code'],
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      card['country'],
                                      style: GoogleFonts.inter(
                                        color: Colors.white.withValues(alpha: 0.8),
                                        fontSize: 10.sp,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (isActive)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Text(
                                  'ACTIVE',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Available Balance',
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 10.sp,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '${card['symbol']}${card['balance'].toStringAsFixed(2)}',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Flexible(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  card['name'],
                                  style: GoogleFonts.inter(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Icon(
                                Icons.account_balance_wallet,
                                color: Colors.white.withValues(alpha: 0.8),
                                size: 14.sp,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _currencyCards.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                width: index == _currentCardIndex ? 24.w : 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: index == _currentCardIndex 
                      ? Colors.blue 
                      : Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyRatesList() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                Text(
                  'Live Exchange Rates',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle, color: Colors.green, size: 6.sp),
                      SizedBox(width: 4.w),
                      Text(
                        'LIVE',
                        style: GoogleFonts.inter(
                          color: Colors.green,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 120.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: _orderedCurrencyRates.length,
              itemBuilder: (context, index) {
                final currency = _orderedCurrencyRates[index];
                final isFromCurrency = currency['code'] == _selectedFromCurrency;
                final isToCurrency = currency['code'] == _selectedToCurrency;
                final isSelected = isFromCurrency || isToCurrency;
                
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _onCurrencyRateSelected(currency['code']),
                    borderRadius: BorderRadius.circular(16.r),
                    child: Container(
                  width: 140.w,
                  margin: EdgeInsets.only(right: 12.w),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? Colors.blue.withValues(alpha: 0.2) 
                        : Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: isSelected 
                          ? Colors.blue.withValues(alpha: 0.5) 
                          : Colors.white.withValues(alpha: 0.1),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _buildCurrencyFlag(currency['code'], size: 24),
                          SizedBox(width: 8.w),
                          Text(
                            currency['code'],
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (isFromCurrency || isToCurrency) ...[
                            SizedBox(width: 4.w),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: isFromCurrency ? Colors.orange : Colors.blue,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                isFromCurrency ? 'FROM' : 'TO',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        currency['name'],
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 10.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '${currency['symbol']}${currency['rate'].toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'per GBP',
                        style: GoogleFonts.inter(
                          color: Colors.grey[500],
                          fontSize: 8.sp,
                        ),
                      ),
                    ],
                  ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExchangeRateDisplay() {
    final fromCurrency = _allCurrencies[_selectedFromCurrency];
    final toCurrency = _allCurrencies[_selectedToCurrency];
    
    if (fromCurrency == null || toCurrency == null) return const SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withValues(alpha: 0.2),
            Colors.purple.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCurrencyFlag(_selectedFromCurrency, size: 24),
                SizedBox(width: 8.w),
                Text(
                  _selectedFromCurrency,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 12.w),
                Icon(Icons.arrow_forward, color: Colors.white.withValues(alpha: 0.7), size: 20.sp),
                SizedBox(width: 12.w),
                _buildCurrencyFlag(_selectedToCurrency, size: 24),
                SizedBox(width: 8.w),
                Text(
                  _selectedToCurrency,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              'Current Exchange Rate',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '1 $_selectedFromCurrency = ${(toCurrency['rate'] / fromCurrency['rate']).toStringAsFixed(4)} $_selectedToCurrency',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencySelection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: _buildCurrencySelector(
              _selectedFromCurrency,
              'From',
              (value) => setState(() => _selectedFromCurrency = value),
            ),
          ),
          SizedBox(width: 16.w),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  final temp = _selectedFromCurrency;
                  _selectedFromCurrency = _selectedToCurrency;
                  _selectedToCurrency = temp;
                });
                _convertCurrency();
              },
              child: Icon(
                Icons.swap_horiz,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: _buildCurrencySelector(
              _selectedToCurrency,
              'To',
              (value) => setState(() => _selectedToCurrency = value),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencySelector(String selectedCurrency, String label, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: DropdownButton<String>(
            value: selectedCurrency,
            dropdownColor: Colors.grey[900],
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            underline: const SizedBox(),
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 20.sp),
            isExpanded: true,
            selectedItemBuilder: (BuildContext context) {
              return _allCurrencies.entries.map((entry) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCurrencyFlag(entry.key, size: 20),
                    SizedBox(width: 8.w),
                    Text(
                      entry.key,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                );
              }).toList();
            },
            items: _allCurrencies.entries.map((entry) {
              final currency = entry.value;
              final code = entry.key;
              return DropdownMenuItem<String>(
                value: code,
                child: Row(
                  children: [
                    _buildCurrencyFlag(code, size: 24),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            code,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            currency['name'],
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
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                onChanged(newValue);
                _convertCurrency();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAmountInputs() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          _buildAmountInput(
            'You Send',
            _amountController,
            _selectedFromCurrency,
            true,
          ),
          SizedBox(height: 16.h),
          _buildAmountInput(
            'You Receive',
            _convertedAmountController,
            _selectedToCurrency,
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildAmountInput(String label, TextEditingController controller, String currency, bool isEditable) {
    final currencyData = _allCurrencies[currency];
    if (currencyData == null) return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Row(
            children: [
              _buildCurrencyFlag(currency, size: 20),
              SizedBox(width: 8.w),
              Text(
                currencyData['symbol'],
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: TextField(
                  controller: controller,
                  enabled: isEditable,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '0.00',
                    hintStyle: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.3),
                      fontSize: 16.sp,
                    ),
                  ),
                  onChanged: isEditable ? (_) => _convertCurrency() : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickRecipients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Recipients',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      _buildCurrencyFlag(_selectedFromCurrency, size: 16),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.grey[400],
                        size: 12.sp,
                      ),
                      SizedBox(width: 4.w),
                      _buildCurrencyFlag(_selectedToCurrency, size: 16),
                      SizedBox(width: 8.w),
                      Text(
                        '$_selectedFromCurrency → $_selectedToCurrency',
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      // Show all recipients
                    },
                    child: Text(
                      'View All',
                      style: GoogleFonts.inter(
                        color: Colors.blue,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: IconButton(
                      onPressed: _showAddRecipientBottomSheet,
                      icon: Icon(
                        Icons.add,
                        color: Colors.blue,
                        size: 18.sp,
                      ),
                      padding: EdgeInsets.all(8.w),
                      constraints: BoxConstraints(
                        minWidth: 32.w,
                        minHeight: 32.h,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 70.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: _savedRecipients.length + 1, // +1 for "Add New" card
            itemBuilder: (context, index) {
              // Show "Add New" card as the last item
              if (index == _savedRecipients.length) {
                return Container(
                  margin: EdgeInsets.only(right: 12.w),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _showAddRecipientBottomSheet,
                      borderRadius: BorderRadius.circular(25.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(25.r),
                          border: Border.all(
                            color: Colors.blue.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 40.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: Colors.blue.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.blue,
                                size: 20.sp,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Add New',
                              style: GoogleFonts.inter(
                                color: Colors.blue,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              
              final recipient = _savedRecipients[index];
              return Container(
                margin: EdgeInsets.only(right: 12.w),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _selectQuickRecipient(recipient),
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(25.r),
                        border: Border.all(
                          color: recipient['isFrequent'] 
                              ? Colors.orange.withValues(alpha: 0.5)
                              : Colors.white.withValues(alpha: 0.1),
                          width: recipient['isFrequent'] ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue[700]!,
                                  Colors.blue[500]!,
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                recipient['name'][0].toUpperCase(),
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                recipient['name'].split(' ')[0],
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    recipient['currency'],
                                    style: GoogleFonts.inter(
                                      color: Colors.grey[400],
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                  if (recipient['isFrequent']) ...[
                                    SizedBox(width: 4.w),
                                    Container(
                                      width: 4.w,
                                      height: 4.h,
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _selectQuickRecipient(Map<String, dynamic> recipient) {
    setState(() {
      _selectedRecipient = recipient;
      _receiverNameController.text = recipient['name'];
      _receiverAccountController.text = recipient['account'];
      _receiverBankController.text = recipient['bank'];
      _receiverSwiftController.text = recipient['swift'];
      
      // Auto-select the recipient's currency as the "to" currency
      _selectedToCurrency = recipient['currency'];
    });
    _convertCurrency();
  }

  void _showAddRecipientBottomSheet() {
    // Clear the controllers for new recipient
    _receiverNameController.clear();
    _receiverAccountController.clear();
    _receiverBankController.clear();
    _receiverSwiftController.clear();
    
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                  'Add New Recipient',
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
            _buildReceiverInputField(
              'Full Name',
              _receiverNameController,
              TextInputType.name,
            ),
            SizedBox(height: 12.h),
            _buildReceiverInputField(
              'Account Number',
              _receiverAccountController,
              TextInputType.number,
            ),
            SizedBox(height: 12.h),
            _buildReceiverInputField(
              'Bank Name',
              _receiverBankController,
              TextInputType.text,
            ),
            SizedBox(height: 12.h),
            _buildReceiverInputField(
              'SWIFT/BIC Code',
              _receiverSwiftController,
              TextInputType.text,
            ),
            SizedBox(height: 12.h),
            _buildCurrencyDropdown(),
            SizedBox(height: 24.h),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[700]!, Colors.blue[500]!],
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _addNewRecipient,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    'Add Recipient',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildCurrencyDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipient Currency',
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: DropdownButton<String>(
            value: _selectedToCurrency,
            dropdownColor: Colors.grey[900],
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            underline: const SizedBox(),
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 20.sp),
            isExpanded: true,
            selectedItemBuilder: (BuildContext context) {
              return _allCurrencies.entries.map((entry) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCurrencyFlag(entry.key, size: 20),
                    SizedBox(width: 8.w),
                    Text(
                      '${entry.key} - ${entry.value['name']}',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                );
              }).toList();
            },
            items: _allCurrencies.entries.map((entry) {
              final currency = entry.value;
              final code = entry.key;
              return DropdownMenuItem<String>(
                value: code,
                child: Row(
                  children: [
                    _buildCurrencyFlag(code, size: 24),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            code,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            currency['name'],
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
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedToCurrency = newValue;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  void _addNewRecipient() {
    if (_receiverNameController.text.isEmpty ||
        _receiverAccountController.text.isEmpty ||
        _receiverBankController.text.isEmpty ||
        _receiverSwiftController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all recipient details',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Create new recipient
    final newRecipient = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'name': _receiverNameController.text,
      'email': '${_receiverNameController.text.toLowerCase().replaceAll(' ', '.')}@email.com',
      'account': _receiverAccountController.text,
      'bank': _receiverBankController.text,
      'swift': _receiverSwiftController.text,
      'country': _allCurrencies[_selectedToCurrency]?['country'] ?? 'Unknown',
      'currency': _selectedToCurrency,
      'isFrequent': false,
      'lastUsed': DateTime.now(),
    };

    // Add to saved recipients list
    setState(() {
      _savedRecipients.insert(0, newRecipient);
      _selectedRecipient = newRecipient;
    });

    Get.back(); // Close bottom sheet

    Get.snackbar(
      'Success',
      'Recipient added successfully',
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    _convertCurrency();
  }

  Widget _buildSelectedRecipient() {
    if (_selectedRecipient == null) return const SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.withValues(alpha: 0.15),
            Colors.blue.withValues(alpha: 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.green.withValues(alpha: 0.4), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green[700]!, Colors.green[500]!],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    _selectedRecipient!['name'][0].toUpperCase(),
                    style: GoogleFonts.inter(
                      color: Colors.white,
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
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 18.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Sending to',
                          style: GoogleFonts.inter(
                            color: Colors.green,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      _selectedRecipient!['name'],
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Text(
                          _selectedRecipient!['bank'],
                          style: GoogleFonts.inter(
                            color: Colors.grey[300],
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            _selectedRecipient!['currency'] ?? 'USD',
                            style: GoogleFonts.inter(
                              color: Colors.blue,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: IconButton(
                  onPressed: () => setState(() => _selectedRecipient = null),
                  icon: Icon(Icons.close, color: Colors.grey[300], size: 20.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExchangeButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[700]!, Colors.blue[500]!],
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isProcessing ? null : _showReceiverDetailsBottomSheet,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: Text(
              _isProcessing 
                  ? 'Processing...' 
                  : _selectedRecipient != null 
                      ? 'Send Money' 
                      : 'Add Receiver Details',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
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
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton(
                onPressed: _showAllTransactions,
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: _recentTransactions
                .map((transaction) => _buildTransactionCard(transaction))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showTransactionDetails(transaction),
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildCurrencyFlag(transaction['from'], size: 20),
                        SizedBox(width: 4.w),
                        Text(
                          transaction['from'],
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(Icons.arrow_forward, color: Colors.grey[400], size: 16.sp),
                        SizedBox(width: 8.w),
                        _buildCurrencyFlag(transaction['to'], size: 20),
                        SizedBox(width: 4.w),
                        Text(
                          transaction['to'],
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      transaction['date'],
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
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
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      transaction['status'],
                      style: GoogleFonts.inter(
                        color: Colors.green,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You Received',
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      '${_getCurrencySymbol(transaction['to'])}${transaction['converted']}',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Exchange Rate',
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      '${transaction['rate']}',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
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
      height: size * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2.r),
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

  void _showReceiverDetailsBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                  'Receiver Details',
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
            _buildReceiverInputField(
              'Full Name',
              _receiverNameController,
              TextInputType.name,
            ),
            SizedBox(height: 12.h),
            _buildReceiverInputField(
              'Account Number',
              _receiverAccountController,
              TextInputType.number,
            ),
            SizedBox(height: 12.h),
            _buildReceiverInputField(
              'Bank Name',
              _receiverBankController,
              TextInputType.text,
            ),
            SizedBox(height: 12.h),
            _buildReceiverInputField(
              'SWIFT/BIC Code',
              _receiverSwiftController,
              TextInputType.text,
            ),
            SizedBox(height: 24.h),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[700]!, Colors.blue[500]!],
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _validateAndProceed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildReceiverInputField(
    String label,
    TextEditingController controller,
    TextInputType keyboardType,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: TextField(
            controller: controller,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter $label',
              hintStyle: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _validateAndProceed() {
    if (_receiverNameController.text.isEmpty ||
        _receiverAccountController.text.isEmpty ||
        _receiverBankController.text.isEmpty ||
        _receiverSwiftController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all receiver details',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    setState(() {
      _selectedRecipient = {
        'name': _receiverNameController.text,
        'account': _receiverAccountController.text,
        'bank': _receiverBankController.text,
        'swift': _receiverSwiftController.text,
      };
    });

    Get.back(); // Close bottom sheet
    _showConfirmationDialog();
  }

  void _showConfirmationDialog() {
    final fromCurrency = _allCurrencies[_selectedFromCurrency];
    final toCurrency = _allCurrencies[_selectedToCurrency];
    
    if (fromCurrency == null || toCurrency == null) return;
    
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Confirm International Payment',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConfirmationRow(
                'Amount', '${fromCurrency['symbol']}${_amountController.text} $_selectedFromCurrency'),
            SizedBox(height: 8.h),
            _buildConfirmationRow('Converted',
                '${toCurrency['symbol']}${_convertedAmountController.text} $_selectedToCurrency'),
            SizedBox(height: 8.h),
            _buildConfirmationRow('Exchange Rate',
                '1 $_selectedFromCurrency = ${(toCurrency['rate'] / fromCurrency['rate']).toStringAsFixed(4)} $_selectedToCurrency'),
            SizedBox(height: 16.h),
            Text(
              'Receiver Details:',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            _buildConfirmationRow('Name', _receiverNameController.text),
            _buildConfirmationRow('Account', _receiverAccountController.text),
            _buildConfirmationRow('Bank', _receiverBankController.text),
            _buildConfirmationRow('SWIFT', _receiverSwiftController.text),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 16.sp,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _handleExchange,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Confirm',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  void _handleExchange() async {
    if (_amountController.text.isEmpty) return;

    setState(() => _isProcessing = true);
    Get.back(); // Close dialog

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        Get.snackbar(
          'Payment Successful',
          'International payment completed successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        // Add to recent transactions
        setState(() {
          _recentTransactions.insert(0, {
            'from': _selectedFromCurrency,
            'to': _selectedToCurrency,
            'amount': double.parse(_amountController.text),
            'converted': double.parse(_convertedAmountController.text),
                         'rate': ((_allCurrencies[_selectedToCurrency]?['rate'] ?? 1.0) / 
                     (_allCurrencies[_selectedFromCurrency]?['rate'] ?? 1.0)).toStringAsFixed(4),
            'date': DateTime.now().toString().split(' ')[0],
            'status': 'Completed',
            'receiver': _receiverNameController.text,
            'bank': _receiverBankController.text,
          });
        });

        // Clear inputs
        _amountController.clear();
        _convertedAmountController.clear();
        _receiverNameController.clear();
        _receiverAccountController.clear();
        _receiverBankController.clear();
        _receiverSwiftController.clear();
        _selectedRecipient = null;

        // Navigate to transfer proof
        Future.delayed(const Duration(seconds: 1), () {
          Get.toNamed(AppRoutes.transferProof, arguments: _receiverNameController.text);
        });
      }
    } catch (e) {
      if (mounted) {
        Get.snackbar(
          'Payment Failed',
          'Failed to process payment. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.8),
          colorText: Colors.white,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
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
        onTap: () => _showTransactionDetails(transaction),
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
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
                      transaction['date'],
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
                          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
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
                      _buildDetailRow('Status', transaction['status']),
                      _buildDetailRow('Processing Fee', 'Free'),
                      _buildDetailRow('Total Sent', '${_getCurrencySymbol(transaction['from'])}${transaction['amount']}'),
                      _buildDetailRow('Total Received', '${_getCurrencySymbol(transaction['to'])}${transaction['converted']}'),
                      
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
              
              // Download Receipt Button
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[700]!, Colors.blue[500]!],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: SizedBox(
                  width: double.infinity,
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
                      'Download Receipt',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
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
}
