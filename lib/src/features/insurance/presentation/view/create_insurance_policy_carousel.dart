import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import '../cubit/create_policy_cubit.dart';
import '../cubit/create_policy_state.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../widgets/create_policy/insurance_category_products_screen.dart';
import '../widgets/create_policy/insurance_form_screen.dart';
import '../widgets/create_policy/insurance_quote_review_screen.dart';
import '../widgets/create_policy/insurance_payment_confirm_screen.dart';
import '../widgets/create_policy/insurance_processing_screen.dart';

/// Main carousel for MyCover.ai insurance policy creation
///
/// 4-screen flow: Browse Products -> Fill Details -> Review Quote -> Confirm & Pay
class CreateInsurancePolicyCarousel extends StatefulWidget {
  const CreateInsurancePolicyCarousel({super.key});

  @override
  State<CreateInsurancePolicyCarousel> createState() =>
      _CreateInsurancePolicyCarouselState();
}

class _CreateInsurancePolicyCarouselState
    extends State<CreateInsurancePolicyCarousel>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  late PageController _pageController;
  int _currentPage = 0;
  final int _totalPages = 4;
  bool _isProcessing = false;
  StreamSubscription<CreatePolicyState>? _purchaseSubscription;

  final List<String> _pageNames = [
    'Browse Plans',
    'Your Details',
    'Review Quote',
    'Confirm & Pay',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Initialize form with user data - derives locale and loads categories
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthenticationCubit>().state;
      if (authState is AuthenticationSuccess) {
        context
            .read<CreatePolicyCubit>()
            .initializeWithUserData(authState.profile.user);
      }
    });
  }

  @override
  void dispose() {
    _purchaseSubscription?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _goToNextPage() async {
    final cubit = context.read<CreatePolicyCubit>();

    switch (_currentPage) {
      case 0:
        // Browse Products -> must have selected a product
        if (cubit.selectedProduct == null) {
          _showErrorSnackBar('Please select an insurance product');
          return;
        }
        break;
      case 1:
        // Fill Details -> validate form fields and get quote
        if (!cubit.validateFormFields()) {
          _showErrorSnackBar('Please fill in all required fields');
          return;
        }
        // Show loading while fetching quote with timeout
        if (!mounted) return;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(
            child: CircularProgressIndicator(color: Color(0xFF6366F1)),
          ),
        );
        // Use a simple timeout approach — getQuote completes or 30s elapses
        bool quoteTimedOut = false;
        try {
          await cubit.getQuote().timeout(const Duration(seconds: 30));
        } on TimeoutException {
          quoteTimedOut = true;
        }
        if (mounted) Navigator.of(context, rootNavigator: true).pop();
        if (quoteTimedOut && mounted) {
          _showErrorSnackBar('Quote request timed out. Please try again.');
          return;
        }
        // If quote wasn't obtained (error already emitted by cubit), stay on form
        if (cubit.quote == null && mounted) {
          return;
        }
        break;
      case 2:
        // Review Quote -> check if quote is expired
        if (cubit.quote?.isExpired == true) {
          if (!mounted) return;
          final getNew = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              backgroundColor: const Color(0xFF1F1F1F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              title: Text(
                'Quote Expired',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: Text(
                'Your quote has expired. Would you like to get a new quote?',
                style: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: Text('Cancel',
                      style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: Text('Get New Quote',
                      style: GoogleFonts.inter(color: const Color(0xFF6366F1))),
                ),
              ],
            ),
          );
          if (getNew == true && mounted) {
            await cubit.getQuote();
          }
          return;
        }
        break;
      case 3:
        // Confirm & Pay -> validate account selection and terms then trigger PIN entry
        if (cubit.selectedAccountId == null) {
          _showErrorSnackBar('Please select an account to pay from');
          return;
        }
        if (!cubit.agreedToTerms) {
          _showErrorSnackBar('Please accept the terms and conditions');
          return;
        }
        _proceedToPurchase();
        return;
    }

    if (_currentPage < _totalPages - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<void> _proceedToPurchase() async {
    if (_isProcessing) return;

    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      _showErrorSnackBar('Authentication required');
      return;
    }

    final cubit = context.read<CreatePolicyCubit>();
    final accountId = cubit.selectedAccountId;

    if (accountId == null) {
      _showErrorSnackBar('Please select an account to pay from');
      return;
    }

    // Validate quote is available and not expired
    if (cubit.quote == null) {
      _showErrorSnackBar('Quote not available. Please go back and get a new quote.');
      return;
    }
    if (cubit.quote!.isExpired) {
      _showErrorSnackBar('Your quote has expired. Please go back and get a new quote.');
      return;
    }

    // Capture quote before async PIN flow — it won't change during PIN entry
    final quote = cubit.quote!;

    final transactionId =
        'INS-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';

    String? verificationToken;

    final pinSuccess = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'buy_insurance',
      amount: quote.premium,
      currency: quote.currency,
      currencySymbol: _currencySymbol(quote.currency),
      title: 'Confirm Insurance Purchase',
      message: 'Confirm payment of ${_currencySymbol(quote.currency)}${quote.premium.toStringAsFixed(2)}',
      showProcessingPhase: false,
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );

    if (!pinSuccess || verificationToken == null) {
      // PIN was cancelled, failed, or locked — user stays on confirm screen
      // The mixin already showed appropriate error dialogs
      return;
    }
    if (!mounted) return;

    // Re-check quote after PIN flow (user may have been away for a while)
    if (cubit.quote == null) {
      _showErrorSnackBar('Quote is no longer available. Please go back and get a new quote.');
      return;
    }
    if (cubit.quote!.isExpired) {
      _showErrorSnackBar('Your quote expired while entering PIN. Please go back and get a new quote.');
      return;
    }

    // Navigate to processing screen - it will handle the purchase and show progress
    if (!mounted) return;
    setState(() => _isProcessing = true);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: const InsuranceProcessingScreen(),
        ),
      ),
    ).then((_) {
      setState(() => _isProcessing = false);
    });

    cubit.purchaseInsurance(
      accountId: accountId,
      transactionPin: verificationToken!,
      transactionId: transactionId,
    );
  }

  /// Convert currency code to display symbol
  String _currencySymbol(String currency) {
    final c = currency.toLowerCase().trim();
    if (c == 'ngn' || c.contains('naira')) return '\u20A6';
    if (c == 'usd' || c.contains('dollar')) return '\$';
    if (c == 'gbp' || c.contains('pound')) return '\u00A3';
    if (c == 'eur' || c.contains('euro')) return '\u20AC';
    if (c == 'ghs' || c.contains('cedi')) return '\u20B5';
    if (c == 'kes' || c.contains('shilling')) return 'KSh';
    if (c == 'zar' || c.contains('rand')) return 'R';
    return currency; // fallback to raw value
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.all(16.w),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildProgressIndicators(),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (page) {
                setState(() => _currentPage = page);
              },
              children: const [
                InsuranceCategoryProductsScreen(),
                InsuranceFormScreen(),
                InsuranceQuoteReviewScreen(),
                InsurancePaymentConfirmScreen(),
              ],
            ),
          ),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF0A0A0A),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
        onPressed: _goToPreviousPage,
      ),
      title: Builder(
        builder: (context) {
          final cubit = context.read<CreatePolicyCubit>();
          final selectedProduct = cubit.selectedProduct;
          final subtitle = _currentPage > 0 && selectedProduct != null
              ? '${_pageNames[_currentPage]} · ${selectedProduct.name}'
              : 'Step ${_currentPage + 1} of $_totalPages - ${_pageNames[_currentPage]}';
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'New Insurance Policy',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.close, color: Colors.white, size: 24.sp),
          onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
          tooltip: 'Close',
        ),
      ],
    );
  }

  Widget _buildProgressIndicators() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 4.h,
                width: (MediaQuery.of(context).size.width - 40.w) *
                    ((_currentPage + 1) / _totalPages),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _currentPage == _totalPages - 1
                        ? [Colors.green, Colors.green.shade700]
                        : [const Color(0xFF6366F1), const Color.fromARGB(255, 78, 3, 208)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
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
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    final isLastPage = _currentPage == _totalPages - 1;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (_currentPage > 0)
              Expanded(
                child: GestureDetector(
                  onTap: _goToPreviousPage,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
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
                ),
              ),
            if (_currentPage > 0) SizedBox(width: 12.w),
            Expanded(
              child: GestureDetector(
                onTap: _isProcessing ? null : _goToNextPage,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isLastPage
                          ? [const Color(0xFF10B981), const Color(0xFF059669)]
                          : [const Color(0xFF6366F1), const Color.fromARGB(255, 78, 3, 208)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_isProcessing && isLastPage) ...[
                          SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Processing...',
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ] else ...[
                          Text(
                            isLastPage ? 'Confirm & Pay' : 'Continue',
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          if (!isLastPage) ...[
                            SizedBox(width: 8.w),
                            Icon(Icons.arrow_forward, color: Colors.white, size: 20.sp),
                          ],
                          if (isLastPage) ...[
                            SizedBox(width: 8.w),
                            Icon(Icons.lock, color: Colors.white, size: 18.sp),
                          ],
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
