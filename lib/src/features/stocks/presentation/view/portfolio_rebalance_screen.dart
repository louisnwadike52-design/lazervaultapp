import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';

class PortfolioRebalanceScreen extends StatefulWidget {
  const PortfolioRebalanceScreen({super.key});

  @override
  State<PortfolioRebalanceScreen> createState() => _PortfolioRebalanceScreenState();
}

class _PortfolioRebalanceScreenState extends State<PortfolioRebalanceScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  
  String _selectedStrategy = 'Conservative';
  final List<String> _strategies = ['Conservative', 'Moderate', 'Aggressive'];
  
  final List<Map<String, dynamic>> _currentAllocations = [
    {'symbol': 'AAPL', 'name': 'Apple Inc.', 'current': 35.2, 'target': 25.0, 'value': 8640.0},
    {'symbol': 'MSFT', 'name': 'Microsoft Corp.', 'current': 28.5, 'target': 25.0, 'value': 7000.0},
    {'symbol': 'GOOGL', 'name': 'Alphabet Inc.', 'current': 22.3, 'target': 25.0, 'value': 5480.0},
    {'symbol': 'TSLA', 'name': 'Tesla Inc.', 'current': 14.0, 'target': 25.0, 'value': 3440.0},
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
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
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'UNBALANCED',
                  style: GoogleFonts.inter(
                    color: Colors.orange,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            'Total Value: \$24,560.00',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Last rebalanced: 3 months ago',
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
        border: Border.all(
          color: isSelected ? color : Colors.white.withValues(alpha: 0.1),
        ),
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
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
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
        border: Border.all(
          color: isIncrease ? Colors.green.withValues(alpha: 0.3) : Colors.red.withValues(alpha: 0.3),
        ),
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
                    '\$${allocation['value'].toStringAsFixed(0)}',
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
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
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
          _buildActionItem('Sell AAPL', '-\$2,500', 'Reduce overweight position', Colors.red),
          _buildActionItem('Sell MSFT', '-\$860', 'Reduce overweight position', Colors.red),
          _buildActionItem('Buy GOOGL', '+\$660', 'Increase underweight position', Colors.green),
          _buildActionItem('Buy TSLA', '+\$2,700', 'Increase underweight position', Colors.green),
        ],
      ),
    );
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
    Get.toNamed(AppRoutes.stockTradePayment, arguments: {
      'type': 'rebalance_portfolio',
      'amount': 0.0,
      'fee': 2.50,
      'total': 2.50,
      'paymentMethod': 'Portfolio Cash',
      'description': 'Portfolio rebalancing transaction fees',
      'strategy': _selectedStrategy,
    });
  }
} 