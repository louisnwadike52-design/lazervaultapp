import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../domain/entities/stock_entity.dart';
import '../../../../../core/types/app_routes.dart';

class StockTradePaymentScreen extends StatefulWidget {
  const StockTradePaymentScreen({super.key});

  @override
  State<StockTradePaymentScreen> createState() => _StockTradePaymentScreenState();
}

class _StockTradePaymentScreenState extends State<StockTradePaymentScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  
  Stock? _selectedStock;
  String _tradeType = 'buy';
  double _amount = 0.0;
  int _shares = 0;
  double _fees = 0.0;
  double _estimatedTotal = 0.0;
  
  String _selectedPaymentMethod = 'account';
  String _selectedAccountId = '';
  String _selectedCryptoWallet = '';
  String _selectedInternationalWallet = '';

  final List<Map<String, dynamic>> _accounts = [
    {
      'id': '1',
      'name': 'Personal Account',
      'type': 'Personal',
      'balance': 2500.00,
      'currency': 'USD',
      'accountNumber': '•••• 0001',
    },
    {
      'id': '2',
      'name': 'Investment Account',
      'type': 'Investment',
      'balance': 5920.00,
      'currency': 'USD',
      'accountNumber': '•••• 0002',
    },
  ];

  final List<Map<String, dynamic>> _cryptoWallets = [
    {
      'id': 'btc_wallet',
      'name': 'Bitcoin Wallet',
      'symbol': 'BTC',
      'balance': 0.15,
      'usdValue': 6750.00,
      'icon': '₿',
      'color': Colors.orange,
    },
    {
      'id': 'eth_wallet',
      'name': 'Ethereum Wallet',
      'symbol': 'ETH',
      'balance': 2.5,
      'usdValue': 5000.00,
      'icon': 'Ξ',
      'color': Colors.blue,
    },
    {
      'id': 'usdc_wallet',
      'name': 'USD Coin Wallet',
      'symbol': 'USDC',
      'balance': 1500.00,
      'usdValue': 1500.00,
      'icon': '\$',
      'color': Colors.green,
    },
  ];

  final List<Map<String, dynamic>> _internationalWallets = [
    {
      'id': 'gbp_wallet',
      'name': 'British Pound Wallet',
      'currency': 'GBP',
      'balance': 800.00,
      'usdValue': 1000.00,
      'flag': '🇬🇧',
    },
    {
      'id': 'eur_wallet',
      'name': 'Euro Wallet',
      'currency': 'EUR',
      'balance': 750.00,
      'usdValue': 825.00,
      'flag': '🇪🇺',
    },
    {
      'id': 'cad_wallet',
      'name': 'Canadian Dollar Wallet',
      'currency': 'CAD',
      'balance': 1200.00,
      'usdValue': 900.00,
      'flag': '🇨🇦',
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupAnimations();
    _selectedAccountId = _accounts.first['id'];
    _selectedCryptoWallet = _cryptoWallets.first['id'];
    _selectedInternationalWallet = _internationalWallets.first['id'];
  }

  void _initializeData() {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    _selectedStock = args['stock'] as Stock?;
    _tradeType = args['tradeType'] ?? 'buy';
    _amount = args['amount'] ?? 0.0;
    _shares = args['shares'] ?? 0;
    _fees = args['fees'] ?? 0.0;
    _estimatedTotal = args['estimatedTotal'] ?? 0.0;
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _animationController.forward();
  }

  void _proceedToReview() {
    String selectedPaymentId = '';
    Map<String, dynamic> paymentDetails = {};

    switch (_selectedPaymentMethod) {
      case 'account':
        selectedPaymentId = _selectedAccountId;
        paymentDetails = _accounts.firstWhere((acc) => acc['id'] == _selectedAccountId);
        break;
      case 'crypto':
        selectedPaymentId = _selectedCryptoWallet;
        paymentDetails = _cryptoWallets.firstWhere((wallet) => wallet['id'] == _selectedCryptoWallet);
        break;
      case 'international':
        selectedPaymentId = _selectedInternationalWallet;
        paymentDetails = _internationalWallets.firstWhere((wallet) => wallet['id'] == _selectedInternationalWallet);
        break;
    }

    Get.toNamed(AppRoutes.stockTradeReview, arguments: {
      'stock': _selectedStock,
      'tradeType': _tradeType,
      'amount': _amount,
      'shares': _shares,
      'fees': _fees,
      'estimatedTotal': _estimatedTotal,
      'paymentMethod': _selectedPaymentMethod,
      'paymentId': selectedPaymentId,
      'paymentDetails': paymentDetails,
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
                child: AnimatedBuilder(
                  animation: _slideAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: _buildContent(),
                      ),
                    );
                  },
                ),
              ),
              _buildBottomSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
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
                  'Payment Method',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Choose how to pay for your trade',
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

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildTradeSummaryCard(),
          SizedBox(height: 24.h),
          _buildPaymentMethodSelector(),
          SizedBox(height: 24.h),
          _buildPaymentOptions(),
        ],
      ),
    );
  }

  Widget _buildTradeSummaryCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A5E),
            const Color(0xFF1A1A3E),
          ],
        ),
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
        children: [
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
                child: Center(
                  child: Text(
                    _selectedStock?.symbol.substring(0, 2) ?? 'ST',
                    style: GoogleFonts.inter(
                      color: Colors.blue,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
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
                      '${_tradeType.capitalizeFirst} ${_selectedStock?.symbol ?? 'Stock'}',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '$_shares shares • ${CurrencySymbols.formatAmountWithCurrency(_amount, _selectedStock?.currency ?? 'USD')}',
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
                    CurrencySymbols.formatAmountWithCurrency(_estimatedTotal, _selectedStock?.currency ?? 'USD'),
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Total ${_tradeType == 'buy' ? 'Cost' : 'Proceeds'}',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildMethodTab('account', 'Accounts', Icons.account_balance),
          ),
          Expanded(
            child: _buildMethodTab('crypto', 'Crypto', Icons.currency_bitcoin),
          ),
          Expanded(
            child: _buildMethodTab('international', 'Wallets', Icons.account_balance_wallet),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodTab(String method, String label, IconData icon) {
    final isSelected = _selectedPaymentMethod == method;
    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentMethod = method),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[400],
              size: 20.sp,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: GoogleFonts.inter(
                color: isSelected ? Colors.white : Colors.grey[400],
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOptions() {
    switch (_selectedPaymentMethod) {
      case 'account':
        return _buildAccountOptions();
      case 'crypto':
        return _buildCryptoOptions();
      case 'international':
        return _buildInternationalOptions();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildAccountOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Account',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        ..._accounts.map((account) => _buildAccountCard(account)),
      ],
    );
  }

  Widget _buildAccountCard(Map<String, dynamic> account) {
    final isSelected = _selectedAccountId == account['id'];
    final hasEnoughBalance = account['balance'] >= _estimatedTotal;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedAccountId = account['id']),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withValues(alpha: 0.1) : Colors.grey[900],
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
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.account_balance,
                color: Colors.blue,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account['name'],
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${account['type']} ${account['accountNumber']}',
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
                  CurrencySymbols.formatAmountWithCurrency(account['balance'], account['currency'] ?? 'USD'),
                  style: GoogleFonts.inter(
                    color: hasEnoughBalance ? Colors.white : Colors.red,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (!hasEnoughBalance)
                  Text(
                    'Insufficient',
                    style: GoogleFonts.inter(
                      color: Colors.red,
                      fontSize: 10.sp,
                    ),
                  ),
              ],
            ),
            if (isSelected) ...[
              SizedBox(width: 8.w),
              Icon(
                Icons.check_circle,
                color: Colors.blue,
                size: 20.sp,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCryptoOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Crypto Wallet',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        ..._cryptoWallets.map((wallet) => _buildCryptoCard(wallet)),
      ],
    );
  }

  Widget _buildCryptoCard(Map<String, dynamic> wallet) {
    final isSelected = _selectedCryptoWallet == wallet['id'];
    final hasEnoughBalance = wallet['usdValue'] >= _estimatedTotal;

    return GestureDetector(
      onTap: () => setState(() => _selectedCryptoWallet = wallet['id']),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withValues(alpha: 0.1) : Colors.grey[900],
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
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: wallet['color'].withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(
                  wallet['icon'],
                  style: GoogleFonts.inter(
                    color: wallet['color'],
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
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
                    wallet['name'],
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${wallet['balance']} ${wallet['symbol']}',
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
                  CurrencySymbols.formatAmountWithCurrency(wallet['usdValue'], 'USD'),
                  style: GoogleFonts.inter(
                    color: hasEnoughBalance ? Colors.white : Colors.red,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (!hasEnoughBalance)
                  Text(
                    'Insufficient',
                    style: GoogleFonts.inter(
                      color: Colors.red,
                      fontSize: 10.sp,
                    ),
                  ),
              ],
            ),
            if (isSelected) ...[
              SizedBox(width: 8.w),
              Icon(
                Icons.check_circle,
                color: Colors.blue,
                size: 20.sp,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInternationalOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select International Wallet',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        ..._internationalWallets.map((wallet) => _buildInternationalCard(wallet)),
      ],
    );
  }

  Widget _buildInternationalCard(Map<String, dynamic> wallet) {
    final isSelected = _selectedInternationalWallet == wallet['id'];
    final hasEnoughBalance = wallet['usdValue'] >= _estimatedTotal;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedInternationalWallet = wallet['id']),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withValues(alpha: 0.1) : Colors.grey[900],
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
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(
                  wallet['flag'],
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
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
                    wallet['name'],
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${wallet['balance']} ${wallet['currency']}',
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
                  CurrencySymbols.formatAmountWithCurrency(wallet['usdValue'], 'USD'),
                  style: GoogleFonts.inter(
                    color: hasEnoughBalance ? Colors.white : Colors.red,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (!hasEnoughBalance)
                  Text(
                    'Insufficient',
                    style: GoogleFonts.inter(
                      color: Colors.red,
                      fontSize: 10.sp,
                    ),
                  ),
              ],
            ),
            if (isSelected) ...[
              SizedBox(width: 8.w),
              Icon(
                Icons.check_circle,
                color: Colors.blue,
                size: 20.sp,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A3E),
        border: Border(
          top: BorderSide(
            color: Colors.grey[800]!,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _proceedToReview,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text(
              'Review Trade',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
} 