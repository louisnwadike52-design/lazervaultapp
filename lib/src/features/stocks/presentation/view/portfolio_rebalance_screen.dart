import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/stock_entity.dart';

class PortfolioRebalanceScreen extends StatefulWidget {
  final List<StockHolding> holdings;
  final double totalValue;
  final DateTime? lastRebalancedDate;
  final String currency;

  const PortfolioRebalanceScreen({
    super.key,
    required this.holdings,
    required this.totalValue,
    this.lastRebalancedDate,
    this.currency = 'USD',
  });

  @override
  State<PortfolioRebalanceScreen> createState() => _PortfolioRebalanceScreenState();
}

class _PortfolioRebalanceScreenState extends State<PortfolioRebalanceScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  
  String _selectedStrategy = 'Conservative';
  final List<String> _strategies = ['Conservative', 'Moderate', 'Aggressive'];

  late List<Map<String, dynamic>> _currentAllocations;

  @override
  void initState() {
    super.initState();
    _buildAllocationsFromHoldings();
    _setupAnimations();
  }

  void _buildAllocationsFromHoldings() {
    final holdings = widget.holdings;
    final totalValue = widget.totalValue;
    final targetPercent = holdings.isNotEmpty ? 100.0 / holdings.length : 0.0;

    _currentAllocations = holdings.map((holding) {
      final currentPercent = totalValue > 0
          ? (holding.totalValue / totalValue) * 100.0
          : 0.0;
      return {
        'symbol': holding.symbol,
        'name': holding.name,
        'current': currentPercent,
        'target': targetPercent,
        'value': holding.totalValue,
      };
    }).toList();
  }

  String _lastRebalancedLabel() {
    final date = widget.lastRebalancedDate;
    if (date == null) return 'Never rebalanced';
    final diff = DateTime.now().difference(date);
    if (diff.inDays < 1) return 'Last rebalanced: today';
    if (diff.inDays == 1) return 'Last rebalanced: yesterday';
    if (diff.inDays < 30) return 'Last rebalanced: ${diff.inDays} days ago';
    final months = (diff.inDays / 30).floor();
    if (months == 1) return 'Last rebalanced: 1 month ago';
    return 'Last rebalanced: $months months ago';
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
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24.w),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCurrentPortfolio(),
                          SizedBox(height: 24.h),
                          _buildStrategySelector(),
                          SizedBox(height: 24.h),
                          _buildRebalancePreview(),
                          SizedBox(height: 24.h),
                          _buildRebalanceActions(),
                          SizedBox(height: 24.h),
                          _buildRebalanceInfo(),
                          SizedBox(height: 40.h),
                          _buildRebalanceButton(),
                        ],
                      ),
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
      padding: EdgeInsets.all(24.w),
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
              onPressed: () => Navigator.pop(context),
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
                  'Rebalance Portfolio',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Optimize your allocation',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFF4A90E2), const Color(0xFF357ABD)],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              Icons.balance,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentPortfolio() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF4A90E2).withValues(alpha: 0.3),
                      const Color(0xFF357ABD).withValues(alpha: 0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  Icons.pie_chart,
                  color: const Color(0xFF4A90E2),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  'Current Portfolio',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Builder(builder: (context) {
                final isBalanced = _currentAllocations.every((a) {
                  final diff = (a['target'] as double) - (a['current'] as double);
                  return diff.abs() < 1.0;
                });
                final statusColor = isBalanced ? Colors.green : Colors.orange;
                final statusText = isBalanced ? 'BALANCED' : 'UNBALANCED';
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    statusText,
                    style: GoogleFonts.inter(
                      color: statusColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              }),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            'Total Value: ${CurrencySymbols.formatAmountWithCurrency(widget.totalValue, widget.currency)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _lastRebalancedLabel(),
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStrategySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rebalancing Strategy',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 16.h),
        ..._strategies.map((strategy) => _buildStrategyOption(strategy)),
      ],
    );
  }

  Widget _buildStrategyOption(String strategy) {
    final isSelected = _selectedStrategy == strategy;
    Color color;
    String description;
    
    switch (strategy) {
      case 'Conservative':
        color = Colors.green;
        description = 'Low risk, stable allocation';
        break;
      case 'Moderate':
        color = const Color(0xFF4A90E2);
        description = 'Balanced risk and growth';
        break;
      case 'Aggressive':
        color = Colors.red;
        description = 'High growth potential';
        break;
      default:
        color = Colors.grey;
        description = '';
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        gradient: isSelected
            ? LinearGradient(
                colors: [
                  color.withValues(alpha: 0.2),
                  color.withValues(alpha: 0.1),
                ],
              )
            : null,
        color: isSelected ? null : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            setState(() {
              _selectedStrategy = strategy;
            });
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    strategy == 'Conservative' ? Icons.security :
                    strategy == 'Moderate' ? Icons.balance :
                    Icons.trending_up,
                    color: color,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strategy,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        description,
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: color,
                    size: 24.sp,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRebalancePreview() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rebalance Preview',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),
          ..._currentAllocations.map((allocation) => _buildAllocationItem(allocation)),
        ],
      ),
    );
  }

  Widget _buildAllocationItem(Map<String, dynamic> allocation) {
    final current = allocation['current'] as double;
    final target = allocation['target'] as double;
    final difference = target - current;
    final isIncrease = difference > 0;
    
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
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
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF4A90E2).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    allocation['symbol'][0],
                    style: GoogleFonts.inter(
                      color: const Color(0xFF4A90E2),
                      fontSize: 16.sp,
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
                      allocation['symbol'],
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      allocation['name'],
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
                    '${CurrencySymbols.getSymbol(widget.currency)}${(allocation['value'] as double).toStringAsFixed(0)}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: (isIncrease ? Colors.green : Colors.red).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      '${isIncrease ? '+' : ''}${difference.toStringAsFixed(1)}%',
                      style: GoogleFonts.inter(
                        color: isIncrease ? Colors.green : Colors.red,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current: ${current.toStringAsFixed(1)}%',
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    LinearProgressIndicator(
                      value: current / 100,
                      backgroundColor: Colors.white.withValues(alpha: 0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                      minHeight: 4.h,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Icon(
                Icons.arrow_forward,
                color: Colors.grey[500],
                size: 16.sp,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Target: ${target.toStringAsFixed(1)}%',
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    LinearProgressIndicator(
                      value: target / 100,
                      backgroundColor: Colors.white.withValues(alpha: 0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF4A90E2)),
                      minHeight: 4.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRebalanceActions() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rebalance Actions',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          ..._buildRebalanceActionItems(),
        ],
      ),
    );
  }

  List<Widget> _buildRebalanceActionItems() {
    final items = <Widget>[];
    for (final allocation in _currentAllocations) {
      final current = allocation['current'] as double;
      final target = allocation['target'] as double;
      final value = allocation['value'] as double;
      final symbol = allocation['symbol'] as String;
      final diff = target - current;
      final diffValue = (diff / 100.0) * widget.totalValue;

      if (diff.abs() < 0.5) continue; // Skip negligible differences

      final isBuy = diff > 0;
      final action = isBuy ? 'Buy $symbol' : 'Sell $symbol';
      final amountStr = isBuy
          ? '+\$${diffValue.abs().toStringAsFixed(0)}'
          : '-\$${diffValue.abs().toStringAsFixed(0)}';
      final description = isBuy
          ? 'Increase underweight position'
          : 'Reduce overweight position';
      final color = isBuy ? Colors.green : Colors.red;

      items.add(_buildActionItem(action, amountStr, description, color));
    }
    return items;
  }

  Widget _buildActionItem(String action, String amount, String description, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              action.startsWith('Sell') ? Icons.remove : Icons.add,
              color: color,
              size: 16.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRebalanceInfo() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.blue,
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rebalancing Information',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Rebalancing will execute market orders during trading hours. A small fee may apply for each transaction.',
                  style: GoogleFonts.inter(
                    color: Colors.grey[300],
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

  Widget _buildRebalanceButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF4A90E2), const Color(0xFF357ABD)],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A90E2).withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _proceedToRebalance,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          'Rebalance Portfolio',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  void _proceedToRebalance() {
    // Calculate estimated fee based on the number of trades required
    final tradeCount = _currentAllocations.where((a) {
      final diff = (a['target'] as double) - (a['current'] as double);
      return diff.abs() >= 0.5;
    }).length;
    final estimatedFee = tradeCount * 0.50; // $0.50 per rebalance trade

    Get.toNamed(AppRoutes.stockTradePayment, arguments: {
      'type': 'rebalance_portfolio',
      'amount': 0.0,
      'fee': estimatedFee,
      'total': estimatedFee,
      'paymentMethod': 'Portfolio Cash',
      'description': 'Portfolio rebalancing transaction fees',
      'strategy': _selectedStrategy,
    });
  }
} 
