import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProExchangeScreen extends StatefulWidget {
  const ProExchangeScreen({super.key});

  @override
  State<ProExchangeScreen> createState() => _ProExchangeScreenState();
}

class _ProExchangeScreenState extends State<ProExchangeScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPair = 'BTC/GBP';
  String _orderType = 'Market';
  String _selectedTimeframe = '1H';
  bool _isAdvancedView = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildPairSelector(),
              _buildPriceDisplay(),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildTradeTab(),
                    _buildOrderBookTab(),
                    _buildChartsTab(),
                    _buildPortfolioTab(),
                  ],
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
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2746),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pro Exchange',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Advanced trading tools',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.candlestick_chart, color: Colors.orange, size: 20.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildPairSelector() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton<String>(
              value: _selectedPair,
              dropdownColor: const Color(0xFF1E2746),
              style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
              underline: Container(),
              items: ['BTC/GBP', 'ETH/GBP', 'SOL/GBP', 'ADA/GBP']
                  .map((pair) => DropdownMenuItem(value: pair, child: Text(pair)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedPair = value!),
            ),
          ),
          Switch(
            value: _isAdvancedView,
            onChanged: (value) => setState(() => _isAdvancedView = value),
            activeColor: Colors.orange,
          ),
          Text(
            'Pro',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: _isAdvancedView ? Colors.orange : Colors.white.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceDisplay() {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.withOpacity(0.2), const Color(0xFF1E2746)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '£66,175.43',
                    style: GoogleFonts.robotoMono(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.arrow_upward, color: Colors.green, size: 16.sp),
                      Text(
                        '+1,247.23 (+1.93%)',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '24h Volume',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                  Text(
                    '£2.34B',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPriceStat('High', '£67,234.12'),
              _buildPriceStat('Low', '£64,892.56'),
              _buildPriceStat('Open', '£65,928.20'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(12.r),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withOpacity(0.6),
        labelStyle: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w600),
        tabs: [
          Tab(text: 'Trade'),
          Tab(text: 'Order Book'),
          Tab(text: 'Charts'),
          Tab(text: 'Portfolio'),
        ],
      ),
    );
  }

  Widget _buildTradeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          _buildOrderTypeSelector(),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(child: _buildBuyPanel()),
              SizedBox(width: 16.w),
              Expanded(child: _buildSellPanel()),
            ],
          ),
          SizedBox(height: 20.h),
          _buildOpenOrdersCard(),
          SizedBox(height: 20.h),
          _buildTradingToolsCard(),
        ],
      ),
    );
  }

  Widget _buildOrderBookTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          _buildOrderBookHeader(),
          SizedBox(height: 16.h),
          _buildOrderBookList(),
          SizedBox(height: 20.h),
          _buildMarketDepthChart(),
        ],
      ),
    );
  }

  Widget _buildChartsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          _buildTimeframeSelector(),
          SizedBox(height: 20.h),
          _buildTradingChart(),
          SizedBox(height: 20.h),
          _buildTechnicalIndicators(),
        ],
      ),
    );
  }

  Widget _buildPortfolioTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          _buildBalanceOverview(),
          SizedBox(height: 20.h),
          _buildAssetAllocation(),
          SizedBox(height: 20.h),
          _buildPerformanceMetrics(),
        ],
      ),
    );
  }

  Widget _buildOrderTypeSelector() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: ['Market', 'Limit', 'Stop'].map((type) {
          bool isSelected = _orderType == type;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _orderType = type),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.orange : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  type,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBuyPanel() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Buy BTC',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 16.h),
          _buildInputField('Amount (BTC)', '0.00'),
          SizedBox(height: 12.h),
          if (_orderType != 'Market')
            _buildInputField('Price (GBP)', '66,175'),
          SizedBox(height: 16.h),
          _buildQuickAmounts(['25%', '50%', '75%', '100%']),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: _placeBuyOrder,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: Size(double.infinity, 44.h),
            ),
            child: Text(
              'Buy BTC',
              style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSellPanel() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sell BTC',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 16.h),
          _buildInputField('Amount (BTC)', '0.00'),
          SizedBox(height: 12.h),
          if (_orderType != 'Market')
            _buildInputField('Price (GBP)', '66,175'),
          SizedBox(height: 16.h),
          _buildQuickAmounts(['25%', '50%', '75%', '100%']),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: _placeSellOrder,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: Size(double.infinity, 44.h),
            ),
            child: Text(
              'Sell BTC',
              style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpenOrdersCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Open Orders',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: _viewAllOrders,
                child: Text(
                  'View All',
                  style: GoogleFonts.inter(color: Colors.orange),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildOrderItem('BUY', '0.1 BTC', '£65,000', 'Pending'),
          _buildOrderItem('SELL', '0.05 BTC', '£67,000', 'Partial'),
        ],
      ),
    );
  }

  Widget _buildTradingToolsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trading Tools',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(child: _buildToolButton('Stop Loss', Icons.shield_outlined)),
              SizedBox(width: 12.w),
              Expanded(child: _buildToolButton('Take Profit', Icons.trending_up)),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(child: _buildToolButton('DCA Bot', Icons.repeat)),
              SizedBox(width: 12.w),
              Expanded(child: _buildToolButton('Grid Trading', Icons.grid_on)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderBookHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Price (GBP)',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ),
        Expanded(
          child: Text(
            'Amount (BTC)',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ),
        Expanded(
          child: Text(
            'Total (GBP)',
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderBookList() {
    return Container(
      height: 400.h,
      child: Column(
        children: [
          // Sell orders (red)
          Expanded(
            child: Column(
              children: List.generate(8, (index) {
                double price = 66200 + (index * 50);
                return _buildOrderBookItem(
                  price.toString(),
                  (0.1 + index * 0.05).toStringAsFixed(3),
                  (price * (0.1 + index * 0.05)).toStringAsFixed(0),
                  Colors.red,
                );
              }).reversed.toList(),
            ),
          ),
          // Current price
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Text(
              '£66,175.43 ↗',
              style: GoogleFonts.robotoMono(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          // Buy orders (green)
          Expanded(
            child: Column(
              children: List.generate(8, (index) {
                double price = 66150 - (index * 50);
                return _buildOrderBookItem(
                  price.toString(),
                  (0.1 + index * 0.05).toStringAsFixed(3),
                  (price * (0.1 + index * 0.05)).toStringAsFixed(0),
                  Colors.green,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketDepthChart() {
    return Container(
      height: 200.h,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Market Depth',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: Row(
              children: [
                // Simplified depth chart representation
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.withOpacity(0.1), Colors.green.withOpacity(0.3)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Text(
                        'Buy Orders',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Container(
                  width: 2.w,
                  color: Colors.white,
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red.withOpacity(0.1), Colors.red.withOpacity(0.3)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Text(
                        'Sell Orders',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
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

  Widget _buildTimeframeSelector() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: ['1m', '5m', '15m', '1H', '4H', '1D'].map((timeframe) {
          bool isSelected = _selectedTimeframe == timeframe;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTimeframe = timeframe),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.orange : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  timeframe,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTradingChart() {
    return Container(
      height: 300.h,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BTC/GBP Chart',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: _toggleChartType,
                    icon: Icon(Icons.candlestick_chart, color: Colors.orange, size: 20.sp),
                  ),
                  IconButton(
                    onPressed: _addIndicator,
                    icon: Icon(Icons.add_chart, color: Colors.blue, size: 20.sp),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.show_chart, size: 48.sp, color: Colors.white.withOpacity(0.3)),
                    SizedBox(height: 8.h),
                    Text(
                      'Advanced Chart',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      'Candlestick chart with indicators',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicalIndicators() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Technical Indicators',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildIndicatorItem('RSI (14)', '67.3', 'Neutral', Colors.orange),
          _buildIndicatorItem('MACD', '0.24', 'Bullish', Colors.green),
          _buildIndicatorItem('Bollinger Bands', 'Upper', 'Overbought', Colors.red),
          _buildIndicatorItem('Moving Average', '£65,420', 'Above', Colors.green),
        ],
      ),
    );
  }

  Widget _buildBalanceOverview() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trading Balance',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBalanceItem('Total Balance', '£8,432.50'),
              _buildBalanceItem('Available', '£6,234.80'),
              _buildBalanceItem('In Orders', '£2,197.70'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAssetAllocation() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Asset Allocation',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildAllocationItem('BTC', '0.1234', '£8,168.44', '65%'),
          _buildAllocationItem('ETH', '2.456', '£3,798.32', '30%'),
          _buildAllocationItem('GBP', '-', '£632.74', '5%'),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Metrics',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricItem('P&L Today', '+£234.56', Colors.green),
              _buildMetricItem('Total Trades', '142', Colors.blue),
              _buildMetricItem('Win Rate', '73%', Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  // Helper widgets
  Widget _buildPriceStat(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        SizedBox(height: 4.h),
        TextFormField(
          style: GoogleFonts.inter(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: Colors.white.withOpacity(0.3)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAmounts(List<String> amounts) {
    return Row(
      children: amounts.map((amount) {
        return Expanded(
          child: GestureDetector(
            onTap: () => _setQuickAmount(amount),
            child: Container(
              margin: EdgeInsets.only(right: amounts.last == amount ? 0 : 4.w),
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                amount,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildOrderItem(String type, String amount, String price, String status) {
    Color typeColor = type == 'BUY' ? Colors.green : Colors.red;
    Color statusColor = status == 'Pending' ? Colors.orange : Colors.blue;
    
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: typeColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              type,
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: typeColor,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  amount,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  price,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              status,
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton(String title, IconData icon) {
    return GestureDetector(
      onTap: () => _openTradingTool(title),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.orange.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.orange, size: 24.sp),
            SizedBox(height: 8.h),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderBookItem(String price, String amount, String total, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
      child: Row(
        children: [
          Expanded(
            child: Text(
              price,
              style: GoogleFonts.robotoMono(
                fontSize: 12.sp,
                color: color,
              ),
            ),
          ),
          Expanded(
            child: Text(
              amount,
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoMono(
                fontSize: 12.sp,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Text(
              total,
              textAlign: TextAlign.right,
              style: GoogleFonts.robotoMono(
                fontSize: 12.sp,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorItem(String name, String value, String signal, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  signal,
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceItem(String label, String amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        Text(
          amount,
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildAllocationItem(String asset, String amount, String value, String percentage) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                asset,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                amount,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                percentage,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  // Action methods
  void _placeBuyOrder() {
    Get.snackbar(
      'Order Placed',
      'Buy order has been submitted',
      backgroundColor: Colors.green.withOpacity(0.2),
      colorText: Colors.white,
    );
  }

  void _placeSellOrder() {
    Get.snackbar(
      'Order Placed',
      'Sell order has been submitted',
      backgroundColor: Colors.red.withOpacity(0.2),
      colorText: Colors.white,
    );
  }

  void _setQuickAmount(String percentage) {
    Get.snackbar(
      'Amount Set',
      'Set to $percentage of available balance',
      backgroundColor: Colors.orange.withOpacity(0.2),
      colorText: Colors.white,
    );
  }

  void _viewAllOrders() {
    Get.snackbar(
      'Orders',
      'Opening detailed order history',
      backgroundColor: Colors.blue.withOpacity(0.2),
      colorText: Colors.white,
    );
  }

  void _openTradingTool(String tool) {
    Get.snackbar(
      tool,
      'Opening $tool configuration',
      backgroundColor: Colors.orange.withOpacity(0.2),
      colorText: Colors.white,
    );
  }

  void _toggleChartType() {
    Get.snackbar(
      'Chart Type',
      'Switching chart visualization',
      backgroundColor: Colors.orange.withOpacity(0.2),
      colorText: Colors.white,
    );
  }

  void _addIndicator() {
    Get.snackbar(
      'Indicator',
      'Adding technical indicator',
      backgroundColor: Colors.blue.withOpacity(0.2),
      colorText: Colors.white,
    );
  }
} 