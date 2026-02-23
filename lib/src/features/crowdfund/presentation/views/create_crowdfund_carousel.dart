import 'dart:developer' as developer;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import '../../domain/entities/crowdfund_entities.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../widgets/create_crowdfund_steps/basic_info_step.dart';
import '../widgets/create_crowdfund_steps/funding_goal_step.dart';
import '../widgets/create_crowdfund_steps/story_media_step.dart';
import '../widgets/create_crowdfund_steps/category_deadline_step.dart';
import '../widgets/create_crowdfund_steps/social_links_step.dart';
import '../widgets/create_crowdfund_steps/review_step.dart';
import '../../../../../core/services/injection_container.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/services/locale_manager.dart';


/// Main carousel controller for crowdfund creation
///
/// Manages 6-screen flow with PageView, progress indicators, and validation
class CreateCrowdfundCarousel extends StatefulWidget {
  const CreateCrowdfundCarousel({super.key});

  @override
  State<CreateCrowdfundCarousel> createState() =>
      _CreateCrowdfundCarouselState();
}

class _CreateCrowdfundCarouselState extends State<CreateCrowdfundCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  final int _totalPages = 6;
  bool _isProcessing = false;

  final List<String> _pageNames = [
    'Basic Info',
    'Funding Goal',
    'Story & Media',
    'Category & Deadline',
    'Social Links',
    'Review & Create',
  ];

  // Form data
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _storyController = TextEditingController();
  final TextEditingController _targetAmountController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  late String _selectedCurrency;
  String _selectedCategory = 'Medical';
  CrowdfundVisibility _selectedVisibility = CrowdfundVisibility.public;
  DateTime? _selectedDeadline;
  Map<String, String> _socialLinks = {};

  final List<String> _categories = [
    'Medical',
    'Education',
    'Emergency',
    'Community',
    'Creative',
    'Business',
    'Other',
  ];

  // Supported currencies - includes user's local currency
  late List<String> _currencies;
  StreamSubscription<String>? _currencySubscription;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Initialize with user's active locale currency from global LocaleManager
    final localeManager = serviceLocator<LocaleManager>();
    _selectedCurrency = localeManager.currentCurrency;

    // Build currencies list - always include user's currency first, then common options
    _currencies = _buildCurrenciesList(_selectedCurrency);

    // Listen for currency changes (reactive updates)
    _currencySubscription = localeManager.currencyStream.listen((newCurrency) {
      if (mounted && newCurrency != _selectedCurrency) {
        setState(() {
          _selectedCurrency = newCurrency;
          _currencies = _buildCurrenciesList(newCurrency);
        });
      }
    });
  }

  /// Build currencies list with user's currency first for easy selection
  List<String> _buildCurrenciesList(String userCurrency) {
    final commonCurrencies = ['GBP', 'USD', 'EUR'];
    final uniqueCurrencies = <String>{...commonCurrencies, userCurrency}.toList();
    // Sort so user's currency is first, then alphabetically
    uniqueCurrencies.sort((a, b) {
      if (a == userCurrency) return -1;
      if (b == userCurrency) return 1;
      return a.compareTo(b);
    });
    return uniqueCurrencies;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _storyController.dispose();
    _targetAmountController.dispose();
    _imageUrlController.dispose();
    _currencySubscription?.cancel();
    super.dispose();
  }

  Future<void> _goToNextPage() async {
    // Validate current page
    bool isValid = false;
    switch (_currentPage) {
      case 0:
        isValid = _validateBasicInfo();
        break;
      case 1:
        isValid = _validateFundingGoal();
        break;
      case 2:
        isValid = true; // Story and media are optional
        break;
      case 3:
        isValid = true; // Category and deadline are pre-selected
        break;
      case 4:
        isValid = true; // Social links are optional
        break;
      case 5:
        isValid = _validateReview();
        break;
    }

    if (!isValid) {
      return;
    }

    if (_currentPage < _totalPages - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Last page - proceed to create crowdfund
      _proceedToCreateCrowdfund();
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

  bool _validateBasicInfo() {
    if (_titleController.text.trim().isEmpty) {
      _showErrorSnackBar('Please enter a title');
      return false;
    }
    if (_titleController.text.trim().length < 10) {
      _showErrorSnackBar('Title must be at least 10 characters');
      return false;
    }
    if (_descriptionController.text.trim().isEmpty) {
      _showErrorSnackBar('Please enter a description');
      return false;
    }
    if (_descriptionController.text.trim().length < 20) {
      _showErrorSnackBar('Description must be at least 20 characters');
      return false;
    }
    return true;
  }

  bool _validateFundingGoal() {
    if (_targetAmountController.text.trim().isEmpty) {
      _showErrorSnackBar('Please enter target amount');
      return false;
    }
    final amount = double.tryParse(_targetAmountController.text.trim().replaceAll(',', ''));
    if (amount == null || amount <= 0) {
      _showErrorSnackBar('Invalid amount');
      return false;
    }
    if (amount < 10) {
      _showErrorSnackBar('Minimum amount is 10');
      return false;
    }
    return true;
  }

  bool _validateReview() {
    // Double-check validations before final submission
    return _validateBasicInfo() && _validateFundingGoal();
  }

  Future<void> _proceedToCreateCrowdfund() async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      _showErrorSnackBar('Please log in to create a campaign');
      return;
    }

    HapticFeedback.mediumImpact();

    setState(() {
      _isProcessing = true;
    });

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: EdgeInsets.all(24.w),
          margin: EdgeInsets.symmetric(horizontal: 40.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F35),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: const Color(0xFF6366F1),
              ),
              SizedBox(height: 16.h),
              Text(
                'Creating Campaign...',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    developer.log('CreateCrowdfund: Starting creation process', name: 'Crowdfund');
    developer.log('User authenticated: ${authState.profile.user.username ?? 'unknown'}', name: 'Crowdfund');

    // Prepare metadata with social links
    Map<String, dynamic> metadata = {};
    if (_socialLinks.isNotEmpty) {
      metadata['social_links'] = jsonEncode(_socialLinks);
    }

    context.read<CrowdfundCubit>().createCrowdfund(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          story: _storyController.text.trim(),
          targetAmount: double.tryParse(_targetAmountController.text.trim().replaceAll(',', '')) ?? 0,
          currency: _selectedCurrency,
          deadline: _selectedDeadline,
          category: _selectedCategory,
          imageUrl: _imageUrlController.text.trim().isEmpty
              ? null
              : _imageUrlController.text.trim(),
          visibility: _selectedVisibility,
          metadata: metadata.isNotEmpty ? metadata : null,
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
    return BlocListener<CrowdfundCubit, CrowdfundState>(
      listener: (context, state) {
        if (state is CrowdfundCreated) {
          setState(() {
            _isProcessing = false;
          });

          // Close loading dialog if open
          if (ModalRoute.of(context)?.isCurrent == false) {
            Navigator.of(context).pop();
          }

          // Navigate to details screen via named route (provides CrowdfundCubit)
          Get.offNamed(
            AppRoutes.crowdfundDetails,
            arguments: state.crowdfund.id,
          );
        } else if (state is CrowdfundError) {
          setState(() {
            _isProcessing = false;
          });

          // Close loading dialog if open
          if (ModalRoute.of(context)?.isCurrent == false) {
            Navigator.of(context).pop();
          }

          _showErrorSnackBar(state.message);
        }
      },
      child: Scaffold(
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
                children: [
                  BasicInfoStep(
                    titleController: _titleController,
                    descriptionController: _descriptionController,
                  ),
                  FundingGoalStep(
                    targetAmountController: _targetAmountController,
                    selectedCurrency: _selectedCurrency,
                    currencies: _currencies,
                    onCurrencyChanged: (value) {
                      setState(() {
                        _selectedCurrency = value;
                      });
                    },
                  ),
                  StoryMediaStep(
                    storyController: _storyController,
                    imageUrlController: _imageUrlController,
                    onImagePicked: (path) {
                      setState(() {
                        // Image picked, state updated in controller
                      });
                    },
                  ),
                  CategoryDeadlineStep(
                    selectedCategory: _selectedCategory,
                    categories: _categories,
                    selectedDeadline: _selectedDeadline,
                    selectedVisibility: _selectedVisibility,
                    onCategoryChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                    onDeadlineChanged: (date) {
                      setState(() {
                        _selectedDeadline = date;
                      });
                    },
                    onVisibilityChanged: (value) {
                      setState(() {
                        _selectedVisibility = value;
                      });
                    },
                  ),
                  SocialLinksStep(
                    socialLinks: _socialLinks,
                    onLinksChanged: (links) {
                      setState(() {
                        _socialLinks = links;
                      });
                    },
                  ),
                  ReviewStep(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    story: _storyController.text,
                    targetAmount: _targetAmountController.text,
                    currency: _selectedCurrency,
                    category: _selectedCategory,
                    deadline: _selectedDeadline,
                    imageUrl: _imageUrlController.text,
                    visibility: _selectedVisibility,
                    socialLinks: _socialLinks,
                  ),
                ],
              ),
            ),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF0A0A0A),
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
            'Create Campaign',
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
      actions: [
        IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
            size: 24.sp,
          ),
          onPressed: () => Get.offAllNamed(AppRoutes.home),
        ),
      ],
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
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    final isLastPage = _currentPage == _totalPages - 1;

    return Container(
      padding: EdgeInsets.all(20.w),
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
                onTap: _isProcessing ? null : _goToNextPage,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_isProcessing) ...[
                          SizedBox(
                            width: 16.sp,
                            height: 16.sp,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(width: 12.w),
                        ],
                        Text(
                          isLastPage ? 'Create Campaign' : 'Continue',
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        if (!isLastPage && !_isProcessing) ...[
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
