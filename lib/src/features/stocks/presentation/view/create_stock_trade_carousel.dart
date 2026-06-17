import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/investments/presentation/models/invest_asset_hub_config.dart';
import 'package:lazervault/src/features/investments/presentation/theme/invest_trading_ui.dart';
import '../../domain/entities/stock_entity.dart';
import '../widgets/trade/trade_action_selector_screen.dart';
import '../widgets/trade/trade_quantity_screen.dart';
import '../widgets/trade/trade_review_screen.dart';
import '../widgets/trade/trading_shell.dart';

/// Multi-step stock trade placement carousel following insurance pattern
class CreateStockTradeCarousel extends StatefulWidget {
  final Stock stock;
  final OrderSide? initialSide;
  final String? investCollectionId;

  const CreateStockTradeCarousel({
    super.key,
    required this.stock,
    this.initialSide,
    this.investCollectionId,
  });

  @override
  State<CreateStockTradeCarousel> createState() => _CreateStockTradeCarouselState();
}

class _CreateStockTradeCarouselState extends State<CreateStockTradeCarousel>
    with SingleTickerProviderStateMixin {
  late final InvestAssetHubConfig _hub =
      InvestAssetHubConfig.forCollectionId(widget.investCollectionId);

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
    'Set up',
    'Size',
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
    final px = widget.stock.currentPrice;
    final gross = px * _quantity;
    final fees = gross * 0.0025;
    Get.toNamed(
      AppRoutes.stockTradeReview,
      arguments: {
        'stock': widget.stock,
        'investCollection': widget.investCollectionId,
        'tradeType': _orderSide == OrderSide.buy ? 'buy' : 'sell',
        'amount': gross,
        'shares': _quantity,
        'sharesExact': _quantity.toDouble(),
        'fees': fees,
        'estimatedTotal': _orderSide == OrderSide.buy ? gross + fees : gross - fees,
        'paymentMethod': 'wallet',
        'paymentDetails': <String, dynamic>{},
        'orderType': _orderType,
        'limitPrice': _limitPrice,
        'stopPrice': _stopPrice,
      },
    );
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
        backgroundColor: InvestTradingUi.sell,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Color get _barFillColor => _currentPage == _totalPages - 1
      ? (_orderSide == OrderSide.buy
          ? InvestTradingUi.buy
          : InvestTradingUi.sell)
      : _hub.accentColor;

  Color get _primaryCtaBg => _currentPage == _totalPages - 1
      ? (_orderSide == OrderSide.buy
          ? InvestTradingUi.buy
          : InvestTradingUi.sell)
      : _hub.accentColor;

  Color get _primaryCtaFg =>
      _currentPage == _totalPages - 1 && _orderSide == OrderSide.buy
          ? Colors.black
          : Colors.white;

  @override
  Widget build(BuildContext context) {
    final accent = _hub.accentColor;
    return Scaffold(
      backgroundColor: InvestTradingUi.background,
      appBar: AppBar(
        backgroundColor: InvestTradingUi.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: InvestTradingUi.textPrimary,
            size: 20.sp,
          ),
          onPressed: _goToPreviousPage,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _hub.appBarScrolledTitle,
              style: InvestTradingUi.eyebrow(accent),
            ),
            SizedBox(height: 2.h),
            Text(
              '${widget.stock.symbol} · ${_pageNames[_currentPage]}',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: InvestTradingUi.textPrimary,
              ),
            ),
            Text(
              'Step ${_currentPage + 1} of $_totalPages',
              style: InvestTradingUi.labelMuted(),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.h),
          child: TradingCarouselStepBar(
            currentPage: _currentPage,
            totalPages: _totalPages,
            accentColor: accent,
            barFillColor: _barFillColor,
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
                  accentColor: accent,
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
                  accentColor: accent,
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
                  accentColor: accent,
                  quantity: _quantity,
                  limitPrice: _limitPrice,
                  stopPrice: _stopPrice,
                ),
              ],
            ),
          ),
          TradingOrderStepFooter(
            showBack: _currentPage > 0,
            onBack: _goToPreviousPage,
            onPrimary: _goToNextPage,
            primaryLabel:
                _currentPage == _totalPages - 1 ? 'Place order' : 'Continue',
            primaryBackground: _primaryCtaBg,
            primaryForeground: _primaryCtaFg,
          ),
        ],
      ),
    );
  }
}
