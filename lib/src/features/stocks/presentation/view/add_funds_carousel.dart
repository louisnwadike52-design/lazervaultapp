import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

import '../widgets/funds/add_funds_amount_screen.dart';
import '../widgets/funds/add_funds_payment_method_screen.dart';
import '../widgets/funds/add_funds_review_screen.dart';
import 'add_funds_processing_screen.dart';

/// Multi-step carousel for adding funds to portfolio
class AddFundsCarousel extends StatefulWidget {
  final double? initialAmount;
  final double availableCash;
  final String currency;

  const AddFundsCarousel({
    super.key,
    this.initialAmount,
    required this.availableCash,
    this.currency = 'USD',
  });

  @override
  State<AddFundsCarousel> createState() => _AddFundsCarouselState();
}

class _AddFundsCarouselState extends State<AddFundsCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  final int _totalPages = 3;

  // Form state
  double _amount = 0.0;
  String _paymentMethod = 'Bank Transfer';
  Map<String, String> _paymentDetails = {};

  final List<String> _pageNames = [
    'Amount',
    'Payment Method',
    'Review',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _amount = widget.initialAmount ?? 0.0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      // Validate current page
      if (!_validateCurrentPage()) return;

      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage++;
      });
    } else {
      // Last page - proceed to processing
      if (_validateCurrentPage()) {
        _proceedToProcessing();
      }
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage--;
      });
    } else {
      Get.back();
    }
  }

  bool _validateCurrentPage() {
    switch (_currentPage) {
      case 0: // Amount
        if (_amount <= 0) {
          _showError('Please enter an amount greater than ${CurrencySymbols.getSymbol(widget.currency)}0');
          return false;
        }
        if (_amount < 10) {
          _showError('Minimum deposit amount is ${CurrencySymbols.getSymbol(widget.currency)}10');
          return false;
        }
        if (_amount > 100000) {
          _showError('Maximum deposit amount is ${CurrencySymbols.getSymbol(widget.currency)}100,000');
          return false;
        }
        return true;
      case 1: // Payment method
        if (_paymentMethod.isEmpty) {
          _showError('Please select a payment method');
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

  void _proceedToProcessing() {
    Get.to(() => AddFundsProcessingScreen(
      amount: _amount,
      paymentMethod: _paymentMethod,
      paymentDetails: _paymentDetails,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _previousPage,
        ),
        title: Column(
          children: [
            Text(
              'Add Funds',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Step ${_currentPage + 1} of $_totalPages - ${_pageNames[_currentPage]}',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: Column(
            children: [
              // Linear progress bar
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: (screenWidth - 32.w) * ((_currentPage + 1) / _totalPages),
                height: 4.h,
                decoration: BoxDecoration(
                  gradient: _currentPage == _totalPages - 1
                      ? const LinearGradient(
                          colors: [Color(0xFF4CAF50), Color(0xFF45A049)],
                        )
                      : const LinearGradient(
                          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                        ),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),
              // Dot indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _totalPages,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: _currentPage == index ? 24.w : 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? const Color(0xFF6366F1)
                          : Colors.grey[700],
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
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                // Step 1: Amount
                AddFundsAmountScreen(
                  initialAmount: _amount,
                  availableCash: widget.availableCash,
                  currency: widget.currency,
                  onChanged: (amount) {
                    setState(() {
                      _amount = amount;
                    });
                  },
                ),
                // Step 2: Payment Method
                AddFundsPaymentMethodScreen(
                  selectedMethod: _paymentMethod,
                  currency: widget.currency,
                  onChanged: (method, details) {
                    setState(() {
                      _paymentMethod = method;
                      _paymentDetails = details;
                    });
                  },
                ),
                // Step 3: Review
                AddFundsReviewScreen(
                  amount: _amount,
                  paymentMethod: _paymentMethod,
                  paymentDetails: _paymentDetails,
                  currency: widget.currency,
                ),
              ],
            ),
          ),
          // Bottom button
          Container(
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
                    backgroundColor: _currentPage == _totalPages - 1
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFF6366F1),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    _currentPage == _totalPages - 1 ? 'Add Funds' : 'Continue',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
