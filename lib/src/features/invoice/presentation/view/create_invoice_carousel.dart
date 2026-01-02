import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/create_invoice_cubit.dart';
import '../cubit/create_invoice_state.dart';
import '../cubit/invoice_cubit.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../../domain/entities/invoice_entity.dart';
import '../widgets/create_invoice/invoice_type_basic_info_screen.dart';
import '../widgets/create_invoice/recipient_details_screen.dart';
import '../widgets/create_invoice/payer_details_screen.dart';
import '../widgets/create_invoice/items_amounts_screen.dart';
import '../widgets/create_invoice/invoice_review_screen.dart';
import '../../../../../core/theme/invoice_theme_colors.dart';

/// Main carousel controller for invoice creation
///
/// Manages 5-screen flow with PageView, progress indicators, and validation
class CreateInvoiceCarousel extends StatefulWidget {
  const CreateInvoiceCarousel({super.key});

  @override
  State<CreateInvoiceCarousel> createState() => _CreateInvoiceCarouselState();
}

class _CreateInvoiceCarouselState extends State<CreateInvoiceCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  final int _totalPages = 5;

  final List<String> _pageNames = [
    'Basic Info',
    'Recipient',
    'Payer',
    'Items & Amounts',
    'Review & Confirm',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Initialize form with user data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthenticationCubit>().state;
      if (authState is AuthenticationSuccess) {
        context
            .read<CreateInvoiceCubit>()
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
    final cubit = context.read<CreateInvoiceCubit>();

    // Validate current page
    bool isValid = false;
    switch (_currentPage) {
      case 0:
        isValid = cubit.validateScreen1();
        break;
      case 1:
        isValid = cubit.validateScreen2();
        break;
      case 2:
        isValid = cubit.validateScreen3();
        break;
      case 3:
        isValid = cubit.validateScreen4();
        break;
      case 4:
        isValid = cubit.validateScreen5();
        break;
    }

    if (!isValid) {
      // Show error message if validation failed
      if (cubit.state is CreateInvoiceValidationError) {
        final errorState = cubit.state as CreateInvoiceValidationError;
        _showErrorSnackBar(errorState.message);
      }
      return;
    }

    if (_currentPage < _totalPages - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Last page - create invoice
      _createInvoice();
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // First page - go back to list screen
      Navigator.of(context).pop();
    }
  }

  Future<void> _createInvoice() async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      _showErrorSnackBar('Authentication required');
      return;
    }

    try {
      final cubit = context.read<CreateInvoiceCubit>();
      final invoice = cubit.buildInvoice(authState.profile.user.id);

      // Create invoice via InvoiceCubit using individual parameters
      await context.read<InvoiceCubit>().createInvoice(
        title: invoice.title,
        description: invoice.description,
        items: invoice.items,
        type: invoice.type,
        toEmail: invoice.recipientDetails?.email,
        toName: invoice.recipientDetails?.contactName,
        dueDate: invoice.dueDate,
        taxAmount: invoice.taxAmount,
        discountAmount: invoice.discountAmount,
        notes: invoice.notes,
        sendImmediately: false,
        recipientDetails: invoice.recipientDetails != null
            ? AddressDetails(
                companyName: invoice.recipientDetails!.companyName,
                contactName: invoice.recipientDetails!.contactName,
                email: invoice.recipientDetails!.email,
                phone: invoice.recipientDetails!.phone,
                addressLine1: invoice.recipientDetails!.addressLine1,
                addressLine2: invoice.recipientDetails!.addressLine2,
                city: invoice.recipientDetails!.city,
                state: invoice.recipientDetails!.state,
                postcode: invoice.recipientDetails!.postcode,
                country: invoice.recipientDetails!.country,
              )
            : null,
        payerDetails: invoice.payerDetails != null
            ? AddressDetails(
                companyName: invoice.payerDetails!.companyName,
                contactName: invoice.payerDetails!.contactName,
                email: invoice.payerDetails!.email,
                phone: invoice.payerDetails!.phone,
                addressLine1: invoice.payerDetails!.addressLine1,
                addressLine2: invoice.payerDetails!.addressLine2,
                city: invoice.payerDetails!.city,
                state: invoice.payerDetails!.state,
                postcode: invoice.payerDetails!.postcode,
                country: invoice.payerDetails!.country,
              )
            : null,
      );

      if (!mounted) return;

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Invoice created successfully!',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          margin: EdgeInsets.all(16.w),
        ),
      );

      // Reset form and navigate back
      cubit.reset();
      Navigator.of(context).pop();
    } catch (e) {
      _showErrorSnackBar('Failed to create invoice: ${e.toString()}');
    }
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
      backgroundColor: InvoiceThemeColors.primaryBackground,
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
                InvoiceTypeBasicInfoScreen(),
                RecipientDetailsScreen(),
                PayerDetailsScreen(),
                ItemsAmountsScreen(),
                InvoiceReviewScreen(),
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
      backgroundColor: InvoiceThemeColors.primaryBackground,
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
            'New Invoice',
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
          // Linear progress bar
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
                        : [const Color(0xFF3B82F6), const Color(0xFF8B5CF6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
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
                      ? const Color(0xFF3B82F6)
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
        color: InvoiceThemeColors.primaryBackground,
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
              flex: _currentPage == 0 ? 1 : 1,
              child: GestureDetector(
                onTap: _goToNextPage,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
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
                          isLastPage ? 'Create Invoice' : 'Continue',
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        if (!isLastPage) ...[
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20.sp,
                          ),
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
