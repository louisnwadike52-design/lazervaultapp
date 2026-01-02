import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../domain/entities/stock_entity.dart';
import '../../cubit/stock_cubit.dart';
import '../widgets/trade/trade_action_selector_screen.dart';
import '../widgets/trade/trade_quantity_screen.dart';
import '../widgets/trade/trade_review_screen.dart';
import 'stock_trade_processing_screen.dart';

/// Multi-step stock trade placement carousel following insurance pattern
class CreateStockTradeCarousel extends StatefulWidget {
  final Stock stock;
  final OrderSide? initialSide;

  const CreateStockTradeCarousel({
    super.key,
    required this.stock,
    this.initialSide,
  });

  @override
  State<CreateStockTradeCarousel> createState() => _CreateStockTradeCarouselState();
}

class _CreateStockTradeCarouselState extends State<CreateStockTradeCarousel>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  final int _totalPages = 3;

  // Form state
  late OrderSide _orderSide;
  OrderType _orderType = OrderType.market;
  int _quantity = 1;
  double? _limitPrice;
  double? _stopPrice;

  final List<String> _pageNames = [
    'Action & Type',
    'Quantity',
    'Review',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _orderSide = widget.initialSide ?? OrderSide.buy;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  Future<void> _goToNextPage() async {
    if (_currentPage < _totalPages - 1) {
      // Validate current page before proceeding
      bool isValid = await _validateCurrentPage();
      if (!isValid) {
        return;
      }

      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Final page - place order
      await _placeOrder();
    }
  }

  Future<bool> _validateCurrentPage() async {
    switch (_currentPage) {
      case 0:
        // Action and type selection - always valid
        return true;
      case 1:
        // Quantity validation
        if (_quantity <= 0) {
          _showErrorSnackBar('Please enter a valid quantity');
          return false;
        }
        if (_orderType == OrderType.limit && (_limitPrice == null || _limitPrice! <= 0)) {
          _showErrorSnackBar('Please enter a valid limit price');
          return false;
        }
        if (_orderType == OrderType.stopLoss && (_stopPrice == null || _stopPrice! <= 0)) {
          _showErrorSnackBar('Please enter a valid stop price');
          return false;
        }
        if (_orderType == OrderType.stopLimit) {
          if ((_limitPrice == null || _limitPrice! <= 0) ||
              (_stopPrice == null || _stopPrice! <= 0)) {
            _showErrorSnackBar('Please enter valid limit and stop prices');
            return false;
          }
        }
        return true;
      case 2:
        // Review screen - always valid
        return true;
      default:
        return true;
    }
  }

  Future<void> _placeOrder() async {
    // Navigate to processing screen
    Get.to(() => StockTradeProcessingScreen(
      stock: widget.stock,
      orderSide: _orderSide,
      orderType: _orderType,
      quantity: _quantity,
      limitPrice: _limitPrice,
      stopPrice: _stopPrice,
    ));
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.back();
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24.sp,
          ),
          onPressed: _goToPreviousPage,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trade ${widget.stock.symbol}',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Step ${_currentPage + 1} of $_totalPages - ${_pageNames[_currentPage]}',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: Column(
            children: [
              // Linear progress bar
              Container(
                width: MediaQuery.of(context).size.width,
                height: 4.h,
                color: Colors.white.withValues(alpha: 0.1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: (MediaQuery.of(context).size.width) * ((_currentPage + 1) / _totalPages),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _currentPage == _totalPages - 1
                          ? [Colors.green, Colors.green.shade700]
                          : [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              // Dot indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _totalPages,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: _currentPage == index ? 24.w : 8.w,
                    height: 8.h,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? const Color(0xFF6366F1)
                          : Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                TradeActionSelectorScreen(
                  stock: widget.stock,
                  initialSide: _orderSide,
                  initialType: _orderType,
                  onChanged: (side, type) {
                    setState(() {
                      _orderSide = side;
                      _orderType = type;
                    });
                  },
                ),
                TradeQuantityScreen(
                  stock: widget.stock,
                  orderSide: _orderSide,
                  orderType: _orderType,
                  initialQuantity: _quantity,
                  initialLimitPrice: _limitPrice,
                  initialStopPrice: _stopPrice,
                  onChanged: (quantity, limitPrice, stopPrice) {
                    setState(() {
                      _quantity = quantity;
                      _limitPrice = limitPrice;
                      _stopPrice = stopPrice;
                    });
                  },
                ),
                TradeReviewScreen(
                  stock: widget.stock,
                  orderSide: _orderSide,
                  orderType: _orderType,
                  quantity: _quantity,
                  limitPrice: _limitPrice,
                  stopPrice: _stopPrice,
                ),
              ],
            ),
          ),
          // Action buttons
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                if (_currentPage > 0) ...[
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: _goToPreviousPage,
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Back',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                ],
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _goToNextPage,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      backgroundColor: _currentPage == _totalPages - 1
                          ? Colors.green
                          : const Color(0xFF6366F1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      _currentPage == _totalPages - 1 ? 'Place Order' : 'Continue',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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
}
