import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_command_sheet.dart';

class InternationalTransferStartScreen extends StatefulWidget {
  const InternationalTransferStartScreen({super.key});

  @override
  State<InternationalTransferStartScreen> createState() =>
      _InternationalTransferStartScreenState();
}

class _InternationalTransferStartScreenState extends State<InternationalTransferStartScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late PageController _pageController;
  
  String _selectedFromCurrency = 'GBP';
  String _selectedToCurrency = 'USD';
  int _currentCardIndex = 0;
  final bool _isVoiceEnabled = false;
  
  late ScrollController _ratesScrollController;
  bool _shouldReorderRates = false;

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

  // Get ordered currency rates with dynamic reordering
  List<Map<String, dynamic>> get _orderedCurrencyRates {
    final List<Map<String, dynamic>> rates = [];
    
    if (_shouldReorderRates) {
      // When reordering is triggered, put selected currencies first
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
    } else {
      // Default order - all currencies in original order
      _allCurrencies.entries.forEach((entry) {
        rates.add({'code': entry.key, ...entry.value});
      });
    }
    
    return rates;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9, initialPage: 0);
    _ratesScrollController = ScrollController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
    
    // Listen to scroll changes to detect when user scrolls to beginning
    _ratesScrollController.addListener(_onRatesScrollChanged);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    _ratesScrollController.dispose();
    super.dispose();
  }

  void _onRatesScrollChanged() {
    // Check if scrolled to the beginning (within 50 pixels)
    if (_ratesScrollController.offset <= 50.0 && !_shouldReorderRates) {
      setState(() {
        _shouldReorderRates = true;
      });
    }
  }

  void _scrollToRatesCurrency(String currencyCode) {
    // Find the index of the currency in the ordered rates list
    final ratesList = _orderedCurrencyRates;
    final index = ratesList.indexWhere((rate) => rate['code'] == currencyCode);
    
    if (index != -1 && _ratesScrollController.hasClients) {
      // Calculate the scroll position (each item is approximately 152.w wide)
      final scrollPosition = index * 152.0;
      
      _ratesScrollController.animateTo(
        scrollPosition,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _onCardChanged(int index) {
    setState(() {
      _currentCardIndex = index;
      _selectedFromCurrency = _currencyCards[index]['code'];
      _shouldReorderRates = false;
    });
    
    // Scroll to the selected currency in the live exchange rates
    _scrollToRatesCurrency(_selectedFromCurrency);
  }

  void _onCurrencyRateSelected(String currencyCode) {
    // Find the currency in the cards list
    final cardIndex = _currencyCards.indexWhere((card) => card['code'] == currencyCode);
    
    setState(() {
      _selectedFromCurrency = currencyCode;
      // Reset reorder flag when a new currency is selected
      _shouldReorderRates = false;
      
      if (cardIndex != -1) {
        _currentCardIndex = cardIndex;
        // Smoothly animate to the selected card
        _pageController.animateToPage(
          cardIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        );
      }
    });
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

  void _proceedToAmountInput() {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final totalSteps = args['totalSteps'] ?? 4;
    
    Get.toNamed(
      AppRoutes.internationalTransferAmount,
      arguments: {
        'fromCurrency': _selectedFromCurrency,
        'toCurrency': _selectedToCurrency,
        'fromCurrencyData': _allCurrencies[_selectedFromCurrency],
        'toCurrencyData': _allCurrencies[_selectedToCurrency],
        'currentStep': 2,
        'totalSteps': totalSteps,
        'stepTitle': 'Enter Amount',
      },
    );
  }

  void _showDepositBottomSheet(Map<String, dynamic> currency) {
    final TextEditingController amountController = TextEditingController();
    bool isAmountValid = false;
    
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return FractionallySizedBox(
            heightFactor: 0.7,
            child: Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A3E),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      margin: EdgeInsets.only(bottom: 24.h),
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  
                  // Header
                  Row(
                    children: [
                      _buildCurrencyFlag(currency['code'], size: 32),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deposit ${currency['code']}',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Add funds to your ${currency['name']} wallet',
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
                  
                  SizedBox(height: 32.h),
                  
                  // Current Balance
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Current Balance',
                          style: GoogleFonts.inter(
                            color: Colors.grey[400],
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          '${currency['symbol']}${currency['balance'].toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 24.h),
                  
                  // Amount Input
                  Text(
                    'Deposit Amount',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
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
                          currency['symbol'],
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: TextField(
                            controller: amountController,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '0.00',
                              hintStyle: GoogleFonts.inter(
                                color: Colors.white.withValues(alpha: 0.3),
                                fontSize: 20.sp,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                final amount = double.tryParse(value) ?? 0.0;
                                isAmountValid = amount > 0;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 24.h),
                  
                  // Quick Amount Buttons
                  Text(
                    'Quick Amounts',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 12.w,
                    runSpacing: 8.h,
                    children: ['100', '500', '1000', '2000'].map((amount) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            amountController.text = amount;
                            setState(() {
                              isAmountValid = true;
                            });
                          },
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
                            ),
                            child: Text(
                              '${currency['symbol']}$amount',
                              style: GoogleFonts.inter(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  Spacer(),
                  
                  // Deposit Button
                  Container(
                    decoration: BoxDecoration(
                      gradient: isAmountValid
                          ? LinearGradient(colors: [Colors.green[700]!, Colors.green[500]!])
                          : null,
                      color: isAmountValid ? null : Colors.grey[800],
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isAmountValid ? () => _processDeposit(currency, amountController.text) : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_balance,
                              color: isAmountValid ? Colors.white : Colors.grey[500],
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Deposit Funds',
                              style: GoogleFonts.inter(
                                color: isAmountValid ? Colors.white : Colors.grey[500],
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _processDeposit(Map<String, dynamic> currency, String amountText) {
    final amount = double.tryParse(amountText) ?? 0.0;
    if (amount <= 0) return;
    
    // Update the currency balance
    setState(() {
      _allCurrencies[currency['code']]!['balance'] = 
          (_allCurrencies[currency['code']]!['balance'] as double) + amount;
    });
    
    // Close the bottom sheet
    Get.back();
    
    // Show success message
    Get.snackbar(
      'Deposit Successful',
      'Added ${currency['symbol']}${amount.toStringAsFixed(2)} to your ${currency['code']} wallet',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      icon: Icon(Icons.check_circle, color: Colors.white),
    );
  }

  void _navigateToDepositFlow(Map<String, dynamic> currency) {
    Get.toNamed(
      AppRoutes.depositMethodSelection,
      arguments: {
        'currency': currency,
        'currencyCode': currency['code'],
        'currencyData': currency,
      },
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
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSwipeableCurrencyCards(),
                      SizedBox(height: 24.h),
                      _buildCurrencyRatesList(),
                      SizedBox(height: 32.h),
                      _buildExchangeRateDisplay(),
                      SizedBox(height: 32.h),
                      _buildCurrencySelection(),
                      SizedBox(height: 40.h),
                      _buildContinueButton(),
                      SizedBox(height: 24.h),
                    ],
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
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final currentStep = args['currentStep'] ?? 1;
    final totalSteps = args['totalSteps'] ?? 4;
    final stepTitle = args['stepTitle'] ?? 'Select Currencies';
    
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'International Transfer',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Step $currentStep of $totalSteps - $stepTitle',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
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
          ],
        ),
      ),
    );
  }

  Widget _buildSwipeableCurrencyCards() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Your Currency Wallets',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 250.h,
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
                    left: index == 0 ? 16.w : (isActive ? 6.w : 12.w),
                    right: isActive ? 16.w : 12.w,
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
                      color: Colors.blue.withValues(alpha: 0.8),
                      width: 3,
                    ) : Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 1,
                    ),
                    boxShadow: isActive ? [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.25),
                        blurRadius: 30,
                        offset: Offset(0, 12),
                        spreadRadius: -2,
                      ),
                      BoxShadow(
                        color: card['color'].withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: Offset(0, 6),
                        spreadRadius: -1,
                      ),
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.1),
                        blurRadius: 40,
                        offset: Offset(0, 16),
                        spreadRadius: -4,
                      ),
                    ] : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                        spreadRadius: -2,
                      ),
                    ],
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  _buildCurrencyFlag(card['code'], size: 36),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          card['code'],
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          card['country'],
                                          style: GoogleFonts.inter(
                                            color: Colors.white.withValues(alpha: 0.8),
                                            fontSize: 12.sp,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isActive)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Text(
                                  'SELECTED',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Available Balance',
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '${card['symbol']}${card['balance'].toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 12.h),
                                                Row(
                          children: [
                            Expanded(
                              child: Text(
                                card['name'],
                                style: GoogleFonts.inter(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              card['code'],
                              style: GoogleFonts.inter(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 14.sp,
                              ),
                            ),
                            Row(
                              children: [
                                _buildActionButton(
                                  "Deposit",
                                  Icons.add_rounded,
                                  onTap: () => _navigateToDepositFlow(card),
                                ),
                                SizedBox(width: 12.w),
                                _buildActionButton(
                                  "Exchange",
                                  Icons.swap_horiz_rounded,
                                  onTap: () => _proceedToAmountInput(),
                                ),
                              ],
                            ),
                          ],
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
              controller: _ratesScrollController,
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
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 140.w,
                        margin: EdgeInsets.only(right: 12.w),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          gradient: isSelected 
                              ? LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.blue.withValues(alpha: 0.3),
                                    Colors.blue.withValues(alpha: 0.15),
                                  ],
                                )
                              : null,
                          color: isSelected 
                              ? null
                              : Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: isSelected 
                                ? Colors.blue.withValues(alpha: 0.8) 
                                : Colors.white.withValues(alpha: 0.1),
                            width: isSelected ? 2.5 : 1,
                          ),
                          boxShadow: isSelected ? [
                            BoxShadow(
                              color: Colors.blue.withValues(alpha: 0.2),
                              blurRadius: 16,
                              offset: Offset(0, 6),
                              spreadRadius: -1,
                            ),
                            BoxShadow(
                              color: Colors.blue.withValues(alpha: 0.1),
                              blurRadius: 24,
                              offset: Offset(0, 10),
                              spreadRadius: -3,
                            ),
                          ] : [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: Offset(0, 3),
                              spreadRadius: -1,
                            ),
                          ],
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
                                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: isFromCurrency 
                                          ? [Colors.orange[600]!, Colors.orange[400]!]
                                          : [Colors.blue[600]!, Colors.blue[400]!],
                                    ),
                                    borderRadius: BorderRadius.circular(6.r),
                                                                         boxShadow: [
                                       BoxShadow(
                                         color: (isFromCurrency ? Colors.orange : Colors.blue).withValues(alpha: 0.25),
                                         blurRadius: 6,
                                         offset: Offset(0, 3),
                                         spreadRadius: -1,
                                       ),
                                       BoxShadow(
                                         color: (isFromCurrency ? Colors.orange : Colors.blue).withValues(alpha: 0.1),
                                         blurRadius: 12,
                                         offset: Offset(0, 6),
                                         spreadRadius: -2,
                                       ),
                                     ],
                                  ),
                                  child: Text(
                                    isFromCurrency ? 'FROM' : 'TO',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
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
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withValues(alpha: 0.2),
            Colors.purple.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            Text(
              'Current Exchange Rate',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCurrencyFlag(_selectedFromCurrency, size: 28),
                SizedBox(width: 12.w),
                Text(
                  _selectedFromCurrency,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 16.w),
                Icon(Icons.arrow_forward, color: Colors.white.withValues(alpha: 0.7), size: 24.sp),
                SizedBox(width: 16.w),
                _buildCurrencyFlag(_selectedToCurrency, size: 28),
                SizedBox(width: 12.w),
                Text(
                  _selectedToCurrency,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              '1 $_selectedFromCurrency = ${(toCurrency['rate'] / fromCurrency['rate']).toStringAsFixed(4)} $_selectedToCurrency',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 22.sp,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Currency Pair',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildCurrencySelector(
                  _selectedFromCurrency,
                  'From',
                  (value) {
                    setState(() {
                      _selectedFromCurrency = value;
                      _shouldReorderRates = false;
                    });
                    _scrollToRatesCurrency(value);
                  },
                ),
              ),
              SizedBox(width: 16.w),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      final temp = _selectedFromCurrency;
                      _selectedFromCurrency = _selectedToCurrency;
                      _selectedToCurrency = temp;
                    });
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
                  (value) {
                    setState(() {
                      _selectedToCurrency = value;
                      _shouldReorderRates = false;
                    });
                    _scrollToRatesCurrency(value);
                  },
                ),
              ),
            ],
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
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
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
                child: Container(
                  constraints: BoxConstraints(maxWidth: 200.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildCurrencyFlag(code, size: 24),
                      SizedBox(width: 12.w),
                      Flexible(
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
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              currency['name'],
                              style: GoogleFonts.inter(
                                color: Colors.grey[400],
                                fontSize: 12.sp,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[700]!, Colors.blue[500]!],
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
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _proceedToAmountInput,
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
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_forward,
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
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
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
                style: GoogleFonts.inter(
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

  Widget _buildCurrencyFlag(String currencyCode, {double size = 24}) {
    final currency = _allCurrencies[currencyCode];
    if (currency == null) return const SizedBox.shrink();
    
    return Container(
      width: size,
      height: size * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
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
} 