import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../widgets/rebalance/rebalance_allocation_screen.dart';
import '../widgets/rebalance/rebalance_strategy_screen.dart';
import '../widgets/rebalance/rebalance_review_screen.dart';
import 'portfolio_rebalance_processing_screen.dart';
import '../../domain/entities/stock_entity.dart';

/// Multi-step carousel for rebalancing portfolio
class PortfolioRebalanceCarousel extends StatefulWidget {
  final List<StockHolding> holdings;
  final double availableCash;
  final double totalValue;

  const PortfolioRebalanceCarousel({
    super.key,
    required this.holdings,
    required this.availableCash,
    required this.totalValue,
  });

  @override
  State<PortfolioRebalanceCarousel> createState() => _PortfolioRebalanceCarouselState();
}

class _PortfolioRebalanceCarouselState extends State<PortfolioRebalanceCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  final int _totalPages = 3;

  // Form state
  String _strategy = 'Balanced'; // Conservative, Balanced, Aggressive, Custom
  Map<String, double> _targetAllocations = {};
  final Map<String, double> _currentAllocations = {};
  final List<RebalanceTrade> _proposedTrades = [];
  String _rebalanceMethod = 'Automatic'; // Automatic or Manual

  final List<String> _pageNames = ['Allocation', 'Strategy', 'Review'];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _calculateCurrentAllocations();
    _initializeTargetAllocations();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _calculateCurrentAllocations() {
    final totalValue = widget.totalValue;
    for (var holding in widget.holdings) {
      final percentage = (holding.totalValue / totalValue) * 100;
      _currentAllocations[holding.symbol] = percentage;
    }
  }

  void _initializeTargetAllocations() {
    // Default to balanced allocation (equal weight)
    final targetPercentage = 100.0 / widget.holdings.length;
    for (var holding in widget.holdings) {
      _targetAllocations[holding.symbol] = targetPercentage;
    }
  }

  void _applyPresetStrategy(String strategy) {
    setState(() {
      _strategy = strategy;
      _targetAllocations.clear();

      switch (strategy) {
        case 'Conservative':
          // Conservative: favor stable stocks, less volatility
          _applyConservativeAllocation();
          break;
        case 'Balanced':
          // Balanced: equal weight
          _applyBalancedAllocation();
          break;
        case 'Aggressive':
          // Aggressive: favor growth stocks
          _applyAggressiveAllocation();
          break;
        case 'Custom':
          // User defines their own allocations
          _applyBalancedAllocation(); // Start with balanced
          break;
      }
    });
  }

  void _applyConservativeAllocation() {
    final targetPercentage = 100.0 / widget.holdings.length;
    for (var holding in widget.holdings) {
      _targetAllocations[holding.symbol] = targetPercentage;
    }
  }

  void _applyBalancedAllocation() {
    final targetPercentage = 100.0 / widget.holdings.length;
    for (var holding in widget.holdings) {
      _targetAllocations[holding.symbol] = targetPercentage;
    }
  }

  void _applyAggressiveAllocation() {
    final targetPercentage = 100.0 / widget.holdings.length;
    for (var holding in widget.holdings) {
      _targetAllocations[holding.symbol] = targetPercentage;
    }
  }

  void _calculateProposedTrades() {
    _proposedTrades.clear();
    final totalValue = widget.totalValue;

    for (var holding in widget.holdings) {
      final currentValue = holding.totalValue;
      final targetPercentage = _targetAllocations[holding.symbol] ?? 0.0;
      final targetValue = (targetPercentage / 100) * totalValue;
      final difference = targetValue - currentValue;

      if (difference.abs() > 10) { // Only rebalance if difference > $10
        final shares = (difference / (holding.totalValue / holding.shares)).round();
        if (shares != 0) {
          _proposedTrades.add(RebalanceTrade(
            symbol: holding.symbol,
            currentShares: holding.shares,
            targetShares: holding.shares + shares,
            sharesToTrade: shares.abs(),
            action: shares > 0 ? 'Buy' : 'Sell',
            estimatedPrice: holding.totalValue / holding.shares,
          ));
        }
      }
    }
  }

  bool _validateCurrentPage() {
    switch (_currentPage) {
      case 0: // Allocation
        final totalAllocation = _targetAllocations.values.fold(0.0, (sum, val) => sum + val);
        if ((totalAllocation - 100.0).abs() > 0.1) {
          _showError('Total allocation must equal 100%. Current: ${totalAllocation.toStringAsFixed(1)}%');
          return false;
        }
        return true;
      case 1: // Strategy
        _calculateProposedTrades();
        if (_proposedTrades.isEmpty) {
          _showError('No rebalancing needed. Portfolio is already balanced.');
          return false;
        }
        return true;
      case 2: // Review
        return true;
      default:
        return true;
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.inter()),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _nextPage() {
    if (_validateCurrentPage()) {
      if (_currentPage < _totalPages - 1) {
        setState(() => _currentPage++);
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _proceedToProcessing();
      }
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _proceedToProcessing() {
    Get.to(() => PortfolioRebalanceProcessingScreen(
      trades: _proposedTrades,
      strategy: _strategy,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _currentPage > 0 ? _previousPage : () => Get.back(),
        ),
        title: Text(
          'Rebalance Portfolio',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: Column(
            children: [
              // Progress bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(_totalPages, (index) {
                        return Text(
                          _pageNames[index],
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: index <= _currentPage
                                ? const Color(0xFF6366F1)
                                : Colors.grey[600],
                            fontWeight: index == _currentPage
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 8.h),
                    LinearProgressIndicator(
                      value: (_currentPage + 1) / _totalPages,
                      backgroundColor: Colors.grey[800],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF6366F1),
                      ),
                      minHeight: 4.h,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              // Dot indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_totalPages, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: index == _currentPage ? 24.w : 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      gradient: index <= _currentPage
                          ? const LinearGradient(
                              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                            )
                          : null,
                      color: index > _currentPage ? Colors.grey[800] : null,
                    ),
                  );
                }),
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                RebalanceAllocationScreen(
                  strategy: _strategy,
                  targetAllocations: _targetAllocations,
                  currentAllocations: _currentAllocations,
                  holdings: widget.holdings,
                  onStrategyChanged: _applyPresetStrategy,
                  onAllocationChanged: (allocations) {
                    setState(() => _targetAllocations = allocations);
                  },
                ),
                RebalanceStrategyScreen(
                  method: _rebalanceMethod,
                  proposedTrades: _proposedTrades,
                  onMethodChanged: (method) {
                    setState(() => _rebalanceMethod = method);
                  },
                ),
                RebalanceReviewScreen(
                  trades: _proposedTrades,
                  strategy: _strategy,
                  totalValue: widget.totalValue,
                ),
              ],
            ),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              _currentPage == _totalPages - 1 ? 'Rebalance Portfolio' : 'Continue',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Data class for rebalance trade
class RebalanceTrade {
  final String symbol;
  final int currentShares;
  final int targetShares;
  final int sharesToTrade;
  final String action; // Buy or Sell
  final double estimatedPrice;

  RebalanceTrade({
    required this.symbol,
    required this.currentShares,
    required this.targetShares,
    required this.sharesToTrade,
    required this.action,
    required this.estimatedPrice,
  });

  double get estimatedTotal => sharesToTrade * estimatedPrice;
}
