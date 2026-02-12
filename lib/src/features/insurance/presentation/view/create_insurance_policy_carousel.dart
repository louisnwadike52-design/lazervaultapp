import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/create_policy_cubit.dart';
import '../cubit/insurance_cubit.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../widgets/create_policy/insurance_category_products_screen.dart';
import '../widgets/create_policy/insurance_form_screen.dart';
import '../widgets/create_policy/insurance_quote_review_screen.dart';
import '../widgets/create_policy/insurance_payment_confirm_screen.dart';
import 'insurance_payment_processing_screen.dart';

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
    extends State<CreateInsurancePolicyCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  final int _totalPages = 4;

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
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(
            child: CircularProgressIndicator(color: Color(0xFF6366F1)),
          ),
        );
        bool timedOut = false;
        final timeout = Future.delayed(const Duration(seconds: 30), () {
          timedOut = true;
        });
        await Future.any([cubit.getQuote(), timeout]);
        if (mounted) Navigator.of(context, rootNavigator: true).pop();
        if (timedOut && mounted) {
          _showErrorSnackBar('Quote request timed out. Please try again.');
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
        // Confirm & Pay -> validate account selection then trigger PIN entry
        if (cubit.selectedAccountId == null) {
          _showErrorSnackBar('Please select an account to pay from');
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

  void _proceedToPurchase() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      _showErrorSnackBar('Authentication required');
      return;
    }

    final cubit = context.read<CreatePolicyCubit>();
    final insuranceCubit = context.read<InsuranceCubit>();
    final authCubit = context.read<AuthenticationCubit>();

    // Navigate to processing screen which handles PIN entry
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: cubit),
            BlocProvider.value(value: insuranceCubit),
            BlocProvider.value(value: authCubit),
          ],
          child: const InsurancePaymentProcessingScreen(),
        ),
      ),
    );
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
      title: Column(
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
            'Step ${_currentPage + 1} of $_totalPages - ${_pageNames[_currentPage]}',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
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
                        : [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
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
                onTap: _goToNextPage,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isLastPage
                          ? [const Color(0xFF10B981), const Color(0xFF059669)]
                          : [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
