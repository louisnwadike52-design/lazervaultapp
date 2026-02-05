import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/group_entities.dart';
import '../../data/datasources/group_account_remote_data_source.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';
import '../../../tag_pay/presentation/cubit/tag_pay_cubit.dart';
import '../../../tag_pay/domain/entities/user_search_result_entity.dart';

/// Create Contribution Bottom Sheet with carousel-style multi-step flow
///
/// Steps:
/// 1. Type Selection (required)
/// 2. Basic Info (required: title, description, amount, deadline)
/// 3. Schedule (for recurring types: frequency, regular amount + optional fields)
/// 4. Settings (optional fields via chips)
/// 5. Review
class CreateContributionBottomSheet extends StatefulWidget {
  final String groupId;
  final List<GroupMember> groupMembers;
  final GroupAccountRemoteDataSource? dataSource;
  final String? createdBy;
  final String currency;
  final String currencySymbol;

  const CreateContributionBottomSheet({
    super.key,
    required this.groupId,
    required this.groupMembers,
    this.dataSource,
    this.createdBy,
    this.currency = 'NGN',
    this.currencySymbol = '₦',
  });

  @override
  State<CreateContributionBottomSheet> createState() => _CreateContributionBottomSheetState();
}

class _CreateContributionBottomSheetState extends State<CreateContributionBottomSheet> {
  late PageController _pageController;
  int _currentPage = 0;

  // Form controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetAmountController = TextEditingController();
  final _regularAmountController = TextEditingController();
  final _totalCyclesController = TextEditingController();
  final _penaltyAmountController = TextEditingController();
  final _gracePeriodController = TextEditingController();
  final _minimumBalanceController = TextEditingController();

  // Form values
  ContributionType _selectedType = ContributionType.oneTime;
  ContributionFrequency? _selectedFrequency;
  DateTime _selectedDeadline = DateTime.now().add(const Duration(days: 30));
  DateTime? _selectedStartDate;
  bool _autoPayEnabled = false;
  bool _allowPartialPayments = true;
  List<String> _rotationOrder = [];

  // Map temp IDs to original user IDs for backend submission
  // Key: display ID (temp_xxx or actual UUID), Value: original user ID from server
  final Map<String, String> _tempIdToOriginalId = {};

  // Track visible optional fields
  final Set<String> _visibleOptionalFields = {};
  bool _showFieldChipsBasic = false;
  bool _showFieldChipsSchedule = false;
  bool _showFieldChipsSettings = false;

  // Local copy of group members that can be updated when new members are added
  late List<GroupMember> _localGroupMembers;

  // Validation error tracking
  String? _errorBannerMessage;
  final Map<String, String> _fieldErrors = {};

  // Page configuration - Simple approach with 4 or 5 pages based on type
  List<String> get _pageNames {
    if (_selectedType == ContributionType.oneTime) {
      return ['Type', 'Details', 'Settings', 'Review'];
    }
    return ['Type', 'Details', 'Schedule', 'Settings', 'Review'];
  }

  int get _totalPages => _pageNames.length;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _localGroupMembers = List.from(widget.groupMembers);

    // Build rotation order with unique, valid user IDs only
    final seenUserIds = <String>{};
    final nullUuid = '00000000-0000-0000-0000-000000000000';
    _rotationOrder = _localGroupMembers
        .where((m) => m.status == GroupMemberStatus.active)
        .where((m) => m.userId.isNotEmpty && m.userId != nullUuid)
        .where((m) => seenUserIds.add(m.userId)) // Only adds if not already seen
        .map((m) {
          // For valid UUIDs, the display ID is the same as the original ID
          _tempIdToOriginalId[m.userId] = m.userId;
          return m.userId;
        })
        .toList();

    debugPrint('🔵 initState: _localGroupMembers count=${_localGroupMembers.length}');
    debugPrint('🔵 initState: _rotationOrder (deduplicated)=$_rotationOrder');
  }

  @override
  void dispose() {
    _pageController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _targetAmountController.dispose();
    _regularAmountController.dispose();
    _totalCyclesController.dispose();
    _penaltyAmountController.dispose();
    _gracePeriodController.dispose();
    _minimumBalanceController.dispose();
    super.dispose();
  }

  void _clearErrors() {
    setState(() {
      _errorBannerMessage = null;
      _fieldErrors.clear();
    });
  }

  void _setFieldError(String field, String message) {
    setState(() {
      _fieldErrors[field] = message;
    });
  }

  void _showErrorBanner(String message) {
    setState(() {
      _errorBannerMessage = message;
    });
    // Auto-dismiss after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && _errorBannerMessage == message) {
        setState(() => _errorBannerMessage = null);
      }
    });
  }

  bool _validateCurrentPage() {
    debugPrint('🔵 _validateCurrentPage: currentPage=$_currentPage, type=$_selectedType, totalPages=$_totalPages');
    _clearErrors();

    switch (_currentPage) {
      case 0: // Type selection - always valid
        debugPrint('🟢 Page 0 (Type) validation: PASS');
        return true;
      case 1: // Basic info
        debugPrint('🔵 Page 1 (Details) validation: title="${_titleController.text}", desc="${_descriptionController.text}", amount="${_targetAmountController.text}"');
        bool hasErrors = false;

        if (_titleController.text.trim().isEmpty) {
          debugPrint('🔴 Validation failed: Title is required');
          _setFieldError('title', 'Title is required');
          hasErrors = true;
        }
        if (_descriptionController.text.trim().isEmpty) {
          debugPrint('🔴 Validation failed: Description is required');
          _setFieldError('description', 'Description is required');
          hasErrors = true;
        }
        final amount = double.tryParse(_targetAmountController.text);
        if (amount == null || amount <= 0) {
          debugPrint('🔴 Validation failed: Target amount invalid (parsed: $amount)');
          _setFieldError('targetAmount', 'Please enter a valid amount');
          hasErrors = true;
        }

        if (hasErrors) {
          _showErrorBanner('Please fill in all required fields');
          return false;
        }
        debugPrint('🟢 Page 1 (Details) validation: PASS');
        return true;

      case 2: // Schedule (for recurring) or Settings (for one-time)
        if (_selectedType == ContributionType.oneTime) {
          debugPrint('🟢 Page 2 (Settings for oneTime) validation: PASS');
          return true; // Settings page - optional fields
        }
        // Schedule validation for recurring types
        debugPrint('🔵 Page 2 (Schedule) validation: frequency=$_selectedFrequency, regularAmount="${_regularAmountController.text}"');
        bool hasScheduleErrors = false;

        if (_selectedFrequency == null) {
          debugPrint('🔴 Validation failed: Frequency is required');
          _setFieldError('frequency', 'Please select a payment frequency');
          hasScheduleErrors = true;
        }
        final regularAmount = double.tryParse(_regularAmountController.text);
        if (regularAmount == null || regularAmount <= 0) {
          debugPrint('🔴 Validation failed: Regular amount invalid (parsed: $regularAmount)');
          _setFieldError('regularAmount', 'Please enter a valid payment amount');
          hasScheduleErrors = true;
        }

        if (hasScheduleErrors) {
          _showErrorBanner('Please fill in all required schedule fields');
          return false;
        }
        debugPrint('🟢 Page 2 (Schedule) validation: PASS');
        return true;

      default:
        debugPrint('🟢 Page $_currentPage validation: PASS (default)');
        return true;
    }
  }

  Future<void> _goToNextPage() async {
    debugPrint('🔵 _goToNextPage called: currentPage=$_currentPage, totalPages=$_totalPages');
    if (!_validateCurrentPage()) {
      debugPrint('🔴 Validation failed, not advancing');
      return;
    }

    if (_currentPage < _totalPages - 1) {
      debugPrint('🟢 Advancing from page $_currentPage to ${_currentPage + 1}');
      // Don't manually increment _currentPage here - PageView's onPageChanged handles it
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      debugPrint('🟢 On last page, submitting contribution');
      _submitContribution();
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      // Don't manually decrement _currentPage here - PageView's onPageChanged handles it
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  Widget _buildErrorBanner() {
    if (_errorBannerMessage == null) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: const Color(0xFFEF4444),
            size: 22.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              _errorBannerMessage!,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFEF4444),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _errorBannerMessage = null),
            child: Icon(
              Icons.close,
              color: const Color(0xFFEF4444),
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldError(String fieldKey) {
    final error = _fieldErrors[fieldKey];
    if (error == null) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(top: 6.h, left: 4.w),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: const Color(0xFFEF4444),
            size: 14.sp,
          ),
          SizedBox(width: 6.w),
          Text(
            error,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFEF4444),
            ),
          ),
        ],
      ),
    );
  }

  void _submitContribution() {
    final cubit = context.read<GroupAccountCubit>();
    final targetAmount = double.tryParse(_targetAmountController.text) ?? 0;
    final regularAmount = double.tryParse(_regularAmountController.text);
    final penaltyAmount = double.tryParse(_penaltyAmountController.text);
    final gracePeriodDays = int.tryParse(_gracePeriodController.text);
    final totalCycles = int.tryParse(_totalCyclesController.text);
    final minimumBalance = double.tryParse(_minimumBalanceController.text);

    debugPrint('🔵 _submitContribution: cubit.currentUserId=${cubit.currentUserId}');
    debugPrint('🔵 _submitContribution: groupId=${widget.groupId}, type=${_selectedType}, frequency=$_selectedFrequency');

    // Convert display IDs back to original user IDs for backend submission
    List<String>? backendRotationOrder;
    if (_selectedType == ContributionType.rotatingSavings) {
      backendRotationOrder = _rotationOrder.map((displayId) {
        final originalId = _tempIdToOriginalId[displayId] ?? displayId;
        debugPrint('🔵 Converting rotation: $displayId -> $originalId');
        return originalId;
      }).toList();
      debugPrint('🔵 Backend rotation order: $backendRotationOrder');
    }

    cubit.createNewContribution(
      groupId: widget.groupId,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      targetAmount: targetAmount,
      currency: widget.currency,
      deadline: _selectedDeadline,
      type: _selectedType,
      frequency: _selectedFrequency,
      regularAmount: regularAmount,
      startDate: _selectedStartDate,
      totalCycles: totalCycles,
      memberRotationOrder: backendRotationOrder,
      autoPayEnabled: _autoPayEnabled,
      penaltyAmount: _visibleOptionalFields.contains('penalty') ? penaltyAmount : null,
      gracePeriodDays: _visibleOptionalFields.contains('penalty') ? gracePeriodDays : null,
      allowPartialPayments: _allowPartialPayments,
      minimumBalance: _visibleOptionalFields.contains('minimumBalance') ? minimumBalance : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1F1F1F), Color(0xFF0A0A0A)],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: BlocConsumer<GroupAccountCubit, GroupAccountState>(
        listener: (context, state) {
          if (state is GroupAccountContributionCreated) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Contribution created successfully'),
                backgroundColor: const Color(0xFF10B981),
              ),
            );
          } else if (state is GroupAccountError) {
            _showErrorBanner(state.message);
          } else if (state is GroupAccountSuccess) {
            // Member was successfully added to the group
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFF10B981),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is GroupAccountLoading;

          return Column(
            children: [
              _buildHeader(isLoading),
              _buildProgressIndicators(),
              _buildErrorBanner(), // Error banner at top
              Expanded(
                child: PageView(
                  key: ValueKey('pageview_${_selectedType.name}'),
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (page) {
                    debugPrint('🔵 PageView onPageChanged: $page (was $_currentPage)');
                    setState(() {
                      _currentPage = page;
                      _clearErrors(); // Clear errors when page changes
                    });
                  },
                  children: _buildPages(),
                ),
              ),
              _buildNavigationButtons(isLoading),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(bool isLoading) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: isLoading ? null : _goToPreviousPage,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                _currentPage == 0 ? Icons.close : Icons.arrow_back,
                color: isLoading ? Colors.grey : Colors.white,
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
                  'New Contribution',
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
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicators() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
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
                        ? [const Color(0xFF10B981), const Color(0xFF059669)]
                        : [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
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
                  color: index <= _currentPage
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

  List<Widget> _buildPages() {
    if (_selectedType == ContributionType.oneTime) {
      return [
        _buildTypeSelectionPage(),
        _buildBasicInfoPage(),
        _buildSettingsPage(),
        _buildReviewPage(),
      ];
    }
    return [
      _buildTypeSelectionPage(),
      _buildBasicInfoPage(),
      _buildSchedulePage(),
      _buildSettingsPage(),
      _buildReviewPage(),
    ];
  }

  // ==================== PAGE 1: TYPE SELECTION ====================
  Widget _buildTypeSelectionPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose Contribution Type',
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Select the type that best fits your group\'s goal',
            style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey[400]),
          ),
          SizedBox(height: 24.h),
          ...ContributionType.values.map((type) => _buildTypeCard(type)),
        ],
      ),
    );
  }

  Widget _buildTypeCard(ContributionType type) {
    final isSelected = _selectedType == type;
    final iconData = _getTypeIcon(type);
    final color = _getTypeColor(type);

    return GestureDetector(
      onTap: () {
        debugPrint('🔵 Type card tapped: ${type.displayName}, current type: ${_selectedType.displayName}');
        final oldType = _selectedType;
        setState(() {
          _selectedType = type;
          if (type == ContributionType.oneTime) {
            _selectedFrequency = null;
            _autoPayEnabled = false;
          } else if (type == ContributionType.rotatingSavings) {
            _selectedFrequency = ContributionFrequency.monthly;
            _autoPayEnabled = false;
          } else {
            _selectedFrequency ??= ContributionFrequency.monthly;
          }
          // Reset to page 0 if type changed (PageView will rebuild with new key)
          if (oldType != type) {
            _currentPage = 0;
            // Recreate PageController for fresh start
            _pageController.dispose();
            _pageController = PageController();
          }
          debugPrint('🟢 Type set to: ${_selectedType.displayName}, totalPages now: $_totalPages, currentPage: $_currentPage');
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: 0.15)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? color : const Color(0xFF2D2D2D),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 12)]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? color.withValues(alpha: 0.2)
                    : Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(iconData, color: isSelected ? color : Colors.grey[500], size: 24.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type.displayName,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    type.description,
                    style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? color : Colors.grey[600],
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTypeIcon(ContributionType type) {
    switch (type) {
      case ContributionType.oneTime:
        return Icons.flag_outlined;
      case ContributionType.rotatingSavings:
        return Icons.sync;
      case ContributionType.investmentPool:
        return Icons.trending_up;
      case ContributionType.recurringGoal:
        return Icons.repeat;
    }
  }

  Color _getTypeColor(ContributionType type) {
    switch (type) {
      case ContributionType.oneTime:
        return const Color(0xFF3B82F6);
      case ContributionType.rotatingSavings:
        return const Color(0xFF8B5CF6);
      case ContributionType.investmentPool:
        return const Color(0xFF10B981);
      case ContributionType.recurringGoal:
        return const Color(0xFFF59E0B);
    }
  }

  // ==================== PAGE 2: BASIC INFO ====================
  Widget _buildBasicInfoPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contribution Details',
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Enter the basic information for your contribution',
            style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey[400]),
          ),
          SizedBox(height: 24.h),

          // Required: Title
          _buildFieldLabel('Title', required: true),
          SizedBox(height: 8.h),
          _buildTextField(
            controller: _titleController,
            hint: 'e.g., Monthly Savings Goal',
            maxLength: 100,
            hasError: _fieldErrors.containsKey('title'),
          ),
          _buildFieldError('title'),
          SizedBox(height: 20.h),

          // Required: Description
          _buildFieldLabel('Description', required: true),
          SizedBox(height: 8.h),
          _buildTextField(
            controller: _descriptionController,
            hint: 'Describe the purpose of this contribution...',
            maxLines: 3,
            maxLength: 500,
            hasError: _fieldErrors.containsKey('description'),
          ),
          _buildFieldError('description'),
          SizedBox(height: 20.h),

          // Required: Target Amount (with currency prefix)
          _buildFieldLabel('Target Amount', required: true),
          SizedBox(height: 8.h),
          _buildAmountField(
            controller: _targetAmountController,
            hasError: _fieldErrors.containsKey('targetAmount'),
          ),
          _buildFieldError('targetAmount'),
          SizedBox(height: 20.h),

          // Required: Target Date
          _buildFieldLabel('Target Date', required: true),
          SizedBox(height: 8.h),
          _buildDatePicker(
            selectedDate: _selectedDeadline,
            onDateSelected: (date) => setState(() => _selectedDeadline = date),
          ),

          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  // ==================== PAGE 3: SCHEDULE (FOR RECURRING) ====================
  Widget _buildSchedulePage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Schedule',
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Set up when and how much members should pay',
            style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey[400]),
          ),
          SizedBox(height: 24.h),

          // Required: Frequency
          _buildFieldLabel('Payment Frequency', required: true),
          SizedBox(height: 8.h),
          _buildFrequencySelector(hasError: _fieldErrors.containsKey('frequency')),
          _buildFieldError('frequency'),
          SizedBox(height: 20.h),

          // Required: Regular Amount
          _buildFieldLabel('Regular Payment Amount', required: true),
          SizedBox(height: 8.h),
          _buildAmountField(
            controller: _regularAmountController,
            hint: 'Amount per payment cycle',
            hasError: _fieldErrors.containsKey('regularAmount'),
          ),
          _buildFieldError('regularAmount'),
          SizedBox(height: 24.h),

          // Rotation Order (for rotating savings)
          if (_selectedType == ContributionType.rotatingSavings) ...[
            _buildFieldLabel('Payout Rotation Order', required: true),
            SizedBox(height: 8.h),
            _buildRotationOrderWidget(),
            SizedBox(height: 24.h),
          ],

          // Add More Fields button
          _buildAddMoreFieldsWidget(
            fields: [
              if (!_visibleOptionalFields.contains('startDate'))
                _ChipField('startDate', 'Start Date', Icons.event),
              if (!_visibleOptionalFields.contains('totalCycles'))
                _ChipField('totalCycles', 'Total Cycles', Icons.repeat),
            ],
            showChips: _showFieldChipsSchedule,
            onToggle: () => setState(() => _showFieldChipsSchedule = !_showFieldChipsSchedule),
          ),

          // Optional: Start Date
          if (_visibleOptionalFields.contains('startDate')) ...[
            SizedBox(height: 20.h),
            _buildOptionalFieldContainer(
              title: 'Start Date',
              icon: Icons.event,
              onRemove: () => setState(() => _visibleOptionalFields.remove('startDate')),
              child: _buildDatePicker(
                selectedDate: _selectedStartDate ?? DateTime.now(),
                onDateSelected: (date) => setState(() => _selectedStartDate = date),
              ),
            ),
          ],

          // Optional: Total Cycles
          if (_visibleOptionalFields.contains('totalCycles')) ...[
            SizedBox(height: 16.h),
            _buildOptionalFieldContainer(
              title: 'Total Cycles',
              icon: Icons.repeat,
              onRemove: () {
                setState(() {
                  _visibleOptionalFields.remove('totalCycles');
                  _totalCyclesController.clear();
                });
              },
              child: _buildIntegerField(
                controller: _totalCyclesController,
                hint: 'Number of payment cycles',
              ),
            ),
          ],

          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildFrequencySelector({bool hasError = false}) {
    final errorColor = const Color(0xFFEF4444);

    return Container(
      padding: hasError ? EdgeInsets.all(8.w) : EdgeInsets.zero,
      decoration: hasError
          ? BoxDecoration(
              color: errorColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: errorColor.withValues(alpha: 0.5)),
            )
          : null,
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: ContributionFrequency.values.map((freq) {
          final isSelected = _selectedFrequency == freq;
          return GestureDetector(
            onTap: () => setState(() {
              _selectedFrequency = freq;
              _fieldErrors.remove('frequency'); // Clear error on selection
            }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF6366F1).withValues(alpha: 0.2)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isSelected ? const Color(0xFF6366F1) : const Color(0xFF2D2D2D),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Text(
                freq.displayName,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? const Color(0xFF6366F1) : Colors.grey[300],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ==================== PAGE 4: SETTINGS (OPTIONAL) ====================
  Widget _buildSettingsPage() {
    final isRotatingSavings = _selectedType == ContributionType.rotatingSavings;

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Settings',
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Configure optional settings for your contribution',
            style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey[400]),
          ),
          SizedBox(height: 24.h),

          // Core toggles (always visible)
          _buildSwitchTile(
            title: 'Auto-Pay',
            subtitle: isRotatingSavings
                ? 'Disabled for rotating savings transparency'
                : 'Automatically process payments when due',
            value: _autoPayEnabled,
            enabled: !isRotatingSavings,
            onChanged: (value) => setState(() => _autoPayEnabled = value),
            icon: Icons.payment,
          ),
          SizedBox(height: 12.h),
          _buildSwitchTile(
            title: 'Allow Partial Payments',
            subtitle: 'Members can pay less than the full amount',
            value: _allowPartialPayments,
            enabled: true,
            onChanged: (value) => setState(() => _allowPartialPayments = value),
            icon: Icons.pie_chart_outline,
          ),

          SizedBox(height: 24.h),

          // Add More Fields button for optional settings
          _buildAddMoreFieldsWidget(
            fields: [
              if (!_visibleOptionalFields.contains('penalty'))
                _ChipField('penalty', 'Late Penalty', Icons.warning_amber_outlined),
              if (!_visibleOptionalFields.contains('minimumBalance'))
                _ChipField('minimumBalance', 'Min Balance', Icons.account_balance_wallet_outlined),
            ],
            showChips: _showFieldChipsSettings,
            onToggle: () => setState(() => _showFieldChipsSettings = !_showFieldChipsSettings),
          ),

          // Optional: Penalty fields
          if (_visibleOptionalFields.contains('penalty')) ...[
            SizedBox(height: 20.h),
            _buildOptionalFieldContainer(
              title: 'Late Payment Penalty',
              icon: Icons.warning_amber_outlined,
              iconColor: const Color(0xFFF59E0B),
              onRemove: () {
                setState(() {
                  _visibleOptionalFields.remove('penalty');
                  _penaltyAmountController.clear();
                  _gracePeriodController.clear();
                });
              },
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Penalty Amount', style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey[400])),
                        SizedBox(height: 6.h),
                        _buildAmountField(controller: _penaltyAmountController, hint: '0.00'),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Grace Period (Days)', style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey[400])),
                        SizedBox(height: 6.h),
                        _buildIntegerField(controller: _gracePeriodController, hint: '0'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Optional: Minimum Balance
          if (_visibleOptionalFields.contains('minimumBalance')) ...[
            SizedBox(height: 16.h),
            _buildOptionalFieldContainer(
              title: 'Minimum Balance for Payout',
              icon: Icons.account_balance_wallet_outlined,
              iconColor: const Color(0xFF10B981),
              onRemove: () {
                setState(() {
                  _visibleOptionalFields.remove('minimumBalance');
                  _minimumBalanceController.clear();
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Minimum amount that must be collected before any payout can occur',
                    style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey[500]),
                  ),
                  SizedBox(height: 8.h),
                  _buildAmountField(controller: _minimumBalanceController, hint: '0.00'),
                ],
              ),
            ),
          ],

          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  // ==================== PAGE 5: REVIEW ====================
  Widget _buildReviewPage() {
    final currencyFormat = NumberFormat.currency(
      symbol: widget.currencySymbol,
      decimalDigits: 2,
    );
    final targetAmount = double.tryParse(_targetAmountController.text) ?? 0;
    final regularAmount = double.tryParse(_regularAmountController.text);

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review & Confirm',
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Review your contribution details before creating',
            style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey[400]),
          ),
          SizedBox(height: 24.h),

          // Type badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: _getTypeColor(_selectedType).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              _selectedType.displayName,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: _getTypeColor(_selectedType),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Title
          Text(
            _titleController.text.isNotEmpty ? _titleController.text : 'Untitled',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _descriptionController.text,
            style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey[400]),
          ),
          SizedBox(height: 24.h),

          // Summary cards
          _buildReviewCard([
            _ReviewItem('Target Amount', currencyFormat.format(targetAmount)),
            _ReviewItem('Deadline', DateFormat('MMM dd, yyyy').format(_selectedDeadline)),
            if (_selectedType != ContributionType.oneTime && regularAmount != null)
              _ReviewItem('Regular Payment', currencyFormat.format(regularAmount)),
            if (_selectedFrequency != null)
              _ReviewItem('Frequency', _selectedFrequency!.displayName),
          ]),
          SizedBox(height: 16.h),

          _buildReviewCard([
            _ReviewItem('Auto-Pay', _autoPayEnabled ? 'Enabled' : 'Disabled'),
            _ReviewItem('Partial Payments', _allowPartialPayments ? 'Allowed' : 'Not allowed'),
            if (_visibleOptionalFields.contains('penalty'))
              _ReviewItem(
                'Late Penalty',
                '${currencyFormat.format(double.tryParse(_penaltyAmountController.text) ?? 0)} after ${_gracePeriodController.text.isEmpty ? '0' : _gracePeriodController.text} days',
              ),
            if (_visibleOptionalFields.contains('minimumBalance'))
              _ReviewItem(
                'Min Balance',
                currencyFormat.format(double.tryParse(_minimumBalanceController.text) ?? 0),
              ),
          ]),

          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildReviewCard(List<_ReviewItem> items) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final isLast = entry.key == items.length - 1;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.value.label,
                    style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey[400]),
                  ),
                  Text(
                    entry.value.value,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              if (!isLast) ...[
                SizedBox(height: 12.h),
                Divider(color: const Color(0xFF2D2D2D), height: 1),
                SizedBox(height: 12.h),
              ],
            ],
          );
        }).toList(),
      ),
    );
  }

  // ==================== SHARED WIDGETS ====================

  Widget _buildFieldLabel(String label, {bool required = false}) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        if (required) ...[
          SizedBox(width: 4.w),
          Text('*', style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFFEF4444))),
        ],
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    int? maxLength,
    bool hasError = false,
  }) {
    final errorColor = const Color(0xFFEF4444);
    final normalColor = const Color(0xFF2D2D2D);

    return TextField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      style: GoogleFonts.inter(fontSize: 16.sp, color: Colors.white),
      onChanged: (_) {
        // Clear error when user starts typing
        if (hasError) setState(() {});
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(fontSize: 16.sp, color: Colors.grey[600]),
        filled: true,
        fillColor: hasError ? errorColor.withValues(alpha: 0.1) : const Color(0xFF1F1F1F),
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: hasError ? errorColor : normalColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: hasError ? errorColor : normalColor, width: hasError ? 1.5 : 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: hasError ? errorColor : const Color(0xFF6366F1), width: 2),
        ),
        contentPadding: EdgeInsets.all(16.w),
      ),
    );
  }

  Widget _buildAmountField({
    required TextEditingController controller,
    String hint = '0.00',
    bool hasError = false,
    bool showCurrencyPrefix = true,
  }) {
    final errorColor = const Color(0xFFEF4444);
    final normalColor = const Color(0xFF2D2D2D);

    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: GoogleFonts.inter(fontSize: 16.sp, color: Colors.white),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
      onChanged: (_) {
        // Clear error when user starts typing
        if (hasError) setState(() {});
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(fontSize: 16.sp, color: Colors.grey[600]),
        filled: true,
        fillColor: hasError ? errorColor.withValues(alpha: 0.1) : const Color(0xFF1F1F1F),
        prefixIcon: showCurrencyPrefix
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.currencySymbol,
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6366F1),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      width: 1,
                      height: 24.h,
                      color: const Color(0xFF3D3D3D),
                    ),
                  ],
                ),
              )
            : null,
        prefixIconConstraints: showCurrencyPrefix
            ? BoxConstraints(minWidth: 0, minHeight: 0)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: hasError ? errorColor : normalColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: hasError ? errorColor : normalColor, width: hasError ? 1.5 : 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: hasError ? errorColor : const Color(0xFF6366F1), width: 2),
        ),
        contentPadding: EdgeInsets.all(16.w),
      ),
    );
  }

  Widget _buildIntegerField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey[600]),
        filled: true,
        fillColor: const Color(0xFF0A0A0A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      ),
    );
  }

  Widget _buildDatePicker({
    required DateTime selectedDate,
    required ValueChanged<DateTime> onDateSelected,
  }) {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xFF6366F1),
                  surface: Color(0xFF1F1F1F),
                ),
              ),
              child: child!,
            );
          },
        );
        if (date != null) onDateSelected(date);
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.grey[400], size: 20.sp),
            SizedBox(width: 12.w),
            Text(
              DateFormat('MMM dd, yyyy').format(selectedDate),
              style: GoogleFonts.inter(fontSize: 16.sp, color: Colors.white),
            ),
            const Spacer(),
            Icon(Icons.keyboard_arrow_down, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required bool enabled,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: (enabled && value)
                  ? const Color(0xFF6366F1).withValues(alpha: 0.2)
                  : Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              color: (enabled && value) ? const Color(0xFF6366F1) : Colors.grey[500],
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: enabled ? Colors.white : Colors.grey[500],
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeThumbColor: const Color(0xFF6366F1),
            activeTrackColor: const Color(0xFF6366F1).withValues(alpha: 0.3),
            inactiveThumbColor: Colors.grey[400],
            inactiveTrackColor: Colors.grey[800],
          ),
        ],
      ),
    );
  }

  Widget _buildAddMoreFieldsWidget({
    required List<_ChipField> fields,
    required bool showChips,
    required VoidCallback onToggle,
  }) {
    if (fields.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        GestureDetector(
          onTap: onToggle,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  showChips ? Icons.remove_circle_outline : Icons.add_circle_outline,
                  color: const Color(0xFF60A5FA),
                  size: 22.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  showChips ? 'Hide options' : 'Add more fields',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF60A5FA),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: fields.map((field) {
                return ActionChip(
                  avatar: Icon(field.icon, size: 16.sp, color: const Color(0xFF60A5FA)),
                  label: Text(
                    field.label,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: const Color(0xFF1E293B),
                  side: BorderSide.none,
                  elevation: 4,
                  shadowColor: Colors.black.withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  onPressed: () {
                    setState(() {
                      _visibleOptionalFields.add(field.key);
                    });
                  },
                );
              }).toList(),
            ),
          ),
          crossFadeState: showChips ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 250),
        ),
      ],
    );
  }

  Widget _buildOptionalFieldContainer({
    required String title,
    required IconData icon,
    Color? iconColor,
    required VoidCallback onRemove,
    required Widget child,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor ?? const Color(0xFF6366F1), size: 20.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onRemove,
                child: Icon(Icons.close, color: Colors.grey[500], size: 20.sp),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }

  Widget _buildRotationOrderWidget() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.swap_vert, color: const Color(0xFF6366F1), size: 18.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Drag to reorder payout sequence',
                  style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey[400]),
                ),
              ),
              // Add Member button
              GestureDetector(
                onTap: _showAddMemberForRotation,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.5)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person_add_alt_1, color: const Color(0xFF6366F1), size: 16.sp),
                      SizedBox(width: 6.w),
                      Text(
                        'Add',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF6366F1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            buildDefaultDragHandles: false, // Disable default drag, we'll add custom
            itemCount: _rotationOrder.length,
            proxyDecorator: (child, index, animation) {
              // Custom drag feedback with elevation and color
              return AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  final double elevation = Tween<double>(begin: 0, end: 8).animate(animation).value;
                  return Material(
                    elevation: elevation,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                    child: child,
                  );
                },
                child: child,
              );
            },
            onReorder: (oldIndex, newIndex) {
              debugPrint('🔵 Reorder: $oldIndex -> $newIndex');
              setState(() {
                if (newIndex > oldIndex) newIndex--;
                final item = _rotationOrder.removeAt(oldIndex);
                _rotationOrder.insert(newIndex, item);
              });
              debugPrint('🟢 New order: $_rotationOrder');
            },
            itemBuilder: (context, index) {
              final rotationId = _rotationOrder[index];
              GroupMember? foundMember;

              // Try to find member by userId first
              try {
                foundMember = _localGroupMembers.firstWhere((m) => m.userId == rotationId);
              } catch (_) {
                // If not found by userId, try to find by member id
                try {
                  foundMember = _localGroupMembers.firstWhere((m) => m.id == rotationId);
                } catch (_) {
                  foundMember = null;
                }
              }

              debugPrint('🔵 itemBuilder[$index]: rotationId=$rotationId, foundMember=${foundMember?.userName ?? "null"}, membersCount=${_localGroupMembers.length}');

              if (foundMember == null) {
                return SizedBox.shrink(key: ValueKey('empty_$index'));
              }
              final member = foundMember;

              // Use a unique key combining rotationId and index to prevent GlobalKey conflicts
              final uniqueKey = '${rotationId}_$index';

              return Container(
                key: ValueKey(uniqueKey),
                margin: EdgeInsets.only(bottom: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFF3D3D3D)),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () {}, // Enable ripple effect
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Row(
                        children: [
                          // Drag handle with ReorderableDragStartListener for immediate drag
                          ReorderableDragStartListener(
                            index: index,
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3D3D3D),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Icons.drag_indicator,
                                color: const Color(0xFF6366F1),
                                size: 20.sp,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          // Position badge
                          Container(
                            width: 28.w,
                            height: 28.w,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF6366F1),
                                  const Color(0xFF8B5CF6),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          // Avatar
                          CircleAvatar(
                            radius: 18.r,
                            backgroundColor: const Color(0xFF4B5563),
                            child: Text(
                              member.userName.isNotEmpty ? member.userName[0].toUpperCase() : 'U',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          // Name and info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  member.userName,
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  index == 0 ? 'Receives first payout' : 'Payout #${index + 1}',
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    color: index == 0 ? const Color(0xFF10B981) : Colors.grey[500],
                                    fontWeight: index == 0 ? FontWeight.w500 : FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showAddMemberForRotation() {
    final cubit = context.read<GroupAccountCubit>();

    // Create a temporary GroupAccount object to pass to AddMemberBottomSheet
    final tempGroup = GroupAccount(
      id: widget.groupId,
      name: 'Group',
      description: '',
      adminId: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      status: GroupAccountStatus.active,
      members: _localGroupMembers,
      contributions: [],
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: cubit,
        child: BlocListener<GroupAccountCubit, GroupAccountState>(
          listener: (listenerContext, state) {
            if (state is GroupAccountSuccess) {
              // Close the add member bottom sheet
              Navigator.pop(bottomSheetContext);
            }
          },
          child: _AddMemberForContributionSheet(
            group: tempGroup,
            existingMembers: _localGroupMembers,
            rotationOrder: _rotationOrder,
            onMemberAdded: (String newUserId, String userName, String email, String? profileImage) {
              // Add the new member to local state (with duplicate prevention)
              setState(() {
                // Generate a unique identifier for this member
                // Use email hash if userId is null UUID, otherwise use userId
                final nullUuid = '00000000-0000-0000-0000-000000000000';
                final isNullUuid = newUserId.isEmpty || newUserId == nullUuid;
                final uniqueId = isNullUuid
                    ? 'temp_${email.hashCode}_${DateTime.now().millisecondsSinceEpoch}'
                    : newUserId;

                // Store the mapping from display ID to original ID for backend submission
                // If the original is a null UUID, we still need to send it to the backend
                _tempIdToOriginalId[uniqueId] = newUserId;
                debugPrint('🔵 Stored mapping: $uniqueId -> $newUserId');

                // Check if member already exists to prevent duplicate keys
                final existsInMembers = _localGroupMembers.any((m) => m.userId == uniqueId || m.email == email);
                final existsInRotation = _rotationOrder.contains(uniqueId);

                debugPrint('🔵 onMemberAdded: originalUserId=$newUserId, uniqueId=$uniqueId, existsInMembers=$existsInMembers, existsInRotation=$existsInRotation');

                if (!existsInMembers) {
                  final newMember = GroupMember(
                    id: uniqueId, // Use uniqueId as the member's id too
                    userId: uniqueId, // Use the unique ID instead of null UUID
                    userName: userName,
                    email: email,
                    profileImage: profileImage,
                    role: GroupMemberRole.member,
                    status: GroupMemberStatus.active,
                    joinedAt: DateTime.now(),
                  );
                  _localGroupMembers.add(newMember);
                  debugPrint('🟢 Added member to _localGroupMembers: $userName (uniqueId=$uniqueId)');
                }

                // Add to rotation order at the end (only if not already present)
                if (!existsInRotation) {
                  _rotationOrder.add(uniqueId);
                  debugPrint('🟢 Added uniqueId to _rotationOrder: $uniqueId');
                }

                debugPrint('🟢 Current rotation order: $_rotationOrder');
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(bool isLoading) {
    final isLastPage = _currentPage == _totalPages - 1;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (_currentPage > 0)
              Expanded(
                child: GestureDetector(
                  onTap: isLoading ? null : _goToPreviousPage,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1.5),
                    ),
                    child: Center(
                      child: Text(
                        'Back',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isLoading ? Colors.grey : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (_currentPage > 0) SizedBox(width: 12.w),
            Expanded(
              child: GestureDetector(
                onTap: isLoading ? null : _goToNextPage,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    gradient: isLoading
                        ? null
                        : const LinearGradient(
                            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                          ),
                    color: isLoading ? Colors.grey : null,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: isLoading
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isLastPage ? 'Create Contribution' : 'Continue',
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

class _ChipField {
  final String key;
  final String label;
  final IconData icon;
  const _ChipField(this.key, this.label, this.icon);
}

class _ReviewItem {
  final String label;
  final String value;
  const _ReviewItem(this.label, this.value);
}

/// Add member sheet for contribution creation flow with search-on-type
/// Uses the same user search service as TagPay and Transfer flows
class _AddMemberForContributionSheet extends StatefulWidget {
  final GroupAccount group;
  final List<GroupMember> existingMembers;
  final List<String> rotationOrder; // User IDs already in rotation
  final void Function(String userId, String userName, String email, String? profileImage) onMemberAdded;

  const _AddMemberForContributionSheet({
    required this.group,
    required this.existingMembers,
    required this.rotationOrder,
    required this.onMemberAdded,
  });

  @override
  State<_AddMemberForContributionSheet> createState() => _AddMemberForContributionSheetState();
}

class _AddMemberForContributionSheetState extends State<_AddMemberForContributionSheet> {
  final _searchController = TextEditingController();
  Timer? _debounceTimer;

  // Search state
  bool _isSearching = false;
  List<UserSearchResultEntity> _searchResults = [];
  String _searchQuery = '';
  String? _errorMessage;

  // Selected user state
  UserSearchResultEntity? _selectedUser;
  bool _isAddingMember = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    setState(() {
      _searchQuery = query;
      _selectedUser = null; // Clear selection when search changes
      _errorMessage = null;
    });

    // Cancel previous timer
    _debounceTimer?.cancel();

    // Clean the query (remove @ and $ symbols)
    final cleanQuery = query.replaceAll('@', '').replaceAll('\$', '').trim();

    if (cleanQuery.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    // Minimum 2 characters required
    if (cleanQuery.length < 2) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    // Set loading state
    setState(() => _isSearching = true);

    // Debounce: 500ms delay after user stops typing
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(cleanQuery);
    });
  }

  Future<void> _performSearch(String query) async {
    try {
      final tagPayCubit = GetIt.I<TagPayCubit>();
      final results = await tagPayCubit.searchUsers(query, limit: 20);

      if (mounted) {
        setState(() {
          _searchResults = results;
          _isSearching = false;
          _errorMessage = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _searchResults = [];
          _isSearching = false;
          _errorMessage = 'Search failed. Please try again.';
        });
      }
    }
  }

  bool _isUserAlreadyMember(String userId, {String? email}) {
    // Check both existing members and rotation order
    // Also check by email since userId might be null UUID
    final inExistingMembers = widget.existingMembers.any((m) =>
        m.userId == userId || (email != null && email.isNotEmpty && m.email == email));
    final inRotationOrder = widget.rotationOrder.contains(userId);
    return inExistingMembers || inRotationOrder;
  }

  void _selectUser(UserSearchResultEntity user) {
    setState(() {
      _selectedUser = user;
    });
  }

  Future<void> _addMember() async {
    if (_selectedUser == null) return;

    setState(() => _isAddingMember = true);

    // Store user info for fallback if needed
    final userName = _selectedUser!.fullName;
    final userEmail = _selectedUser!.email;
    final profilePicture = _selectedUser!.profilePicture;
    final userUsername = _selectedUser!.username;

    try {
      final cubit = context.read<GroupAccountCubit>();

      // Set up a listener for when the member is added
      late final void Function() cancelListener;
      final completer = Completer<GroupMember?>();

      cancelListener = () {
        // Listen for MemberAddedSuccess which contains the newly added member directly
        final subscription = cubit.stream.listen((state) {
          if (state is MemberAddedSuccess) {
            // Use the member directly from the success state
            if (!completer.isCompleted) {
              completer.complete(state.member);
            }
          } else if (state is GroupAccountError) {
            if (!completer.isCompleted) {
              completer.completeError(state.message);
            }
          }
        });

        // Auto-cancel after 10 seconds
        Future.delayed(const Duration(seconds: 10), () {
          if (!completer.isCompleted) {
            subscription.cancel();
            completer.complete(null);
          }
        });

        completer.future.then((_) => subscription.cancel());
      };

      // Start listening before adding member
      cancelListener();

      // Add member to group - emits MemberAddedSuccess on success
      await cubit.addMemberToGroupAccount(
        groupId: widget.group.id,
        userId: _selectedUser!.userId,
        userName: userName,
        email: userEmail,
        username: userUsername,
        role: GroupMemberRole.member,
      );

      // Wait for the member to be added
      final addedMember = await completer.future;

      // IMPORTANT: Always use the ORIGINAL user ID from search result (_selectedUser!.userId)
      // The server response may return a null UUID, but the search result has the real user ID
      final originalUserId = _selectedUser!.userId;

      if (addedMember != null && mounted) {
        // Use search result data as primary, server response as fallback
        final memberName = userName.isNotEmpty ? userName : addedMember.userName;
        final memberEmail = userEmail.isNotEmpty ? userEmail : addedMember.email;
        debugPrint('🔵 _addMember success: originalUserId=$originalUserId, serverUserId=${addedMember.userId}, name=$memberName');
        widget.onMemberAdded(
          originalUserId, // Use the REAL user ID from search, not the server's null UUID
          memberName,
          memberEmail,
          profilePicture.isNotEmpty ? profilePicture : addedMember.profileImage,
        );
        Navigator.pop(context);
      } else if (mounted) {
        // Fallback: member was likely added but listener timed out
        // Use the original user info
        debugPrint('🟡 _addMember fallback: originalUserId=$originalUserId, name=$userName');
        widget.onMemberAdded(
          originalUserId, // Use the REAL user ID from search
          userName,
          userEmail,
          profilePicture.isNotEmpty ? profilePicture : null,
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isAddingMember = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add member: ${e.toString()}'),
            backgroundColor: const Color(0xFFEF4444),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchField(),
                  SizedBox(height: 16.h),
                  _buildSearchResults(),
                  SizedBox(height: 24.h),
                  _buildActionButtons(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.person_add, color: Colors.white, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add to Rotation',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Search for LazerVault users by name or @tag',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.close, color: Colors.white, size: 20.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search Users',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Type at least 2 characters to search',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Colors.grey[500],
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: _searchController,
          style: GoogleFonts.inter(fontSize: 16.sp, color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter name or @username',
            hintStyle: GoogleFonts.inter(fontSize: 16.sp, color: Colors.grey[500]),
            filled: true,
            fillColor: const Color(0xFF0A0A0A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            prefixIcon: Icon(Icons.search, color: Colors.grey[500], size: 20.sp),
            suffixIcon: _isSearching
                ? Padding(
                    padding: EdgeInsets.all(12.w),
                    child: SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
                      ),
                    ),
                  )
                : _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey[500], size: 20.sp),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    // Error state
    if (_errorMessage != null) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: const Color(0xFFEF4444), size: 24.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                _errorMessage!,
                style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    // Initial state - no search yet
    if (_searchQuery.isEmpty) {
      return Container(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            Icon(Icons.person_search, color: Colors.grey[600], size: 48.sp),
            SizedBox(height: 12.h),
            Text(
              'Search for users',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Type a name or @username to find LazerVault users',
              style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // Loading state
    if (_isSearching) {
      return Container(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            SizedBox(
              width: 32.w,
              height: 32.w,
              child: const CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Searching...',
              style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey[400]),
            ),
          ],
        ),
      );
    }

    // Query too short
    final cleanQuery = _searchQuery.replaceAll('@', '').replaceAll('\$', '').trim();
    if (cleanQuery.length < 2) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.grey[500], size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Type at least 2 characters to search',
                style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.grey[400]),
              ),
            ),
          ],
        ),
      );
    }

    // No results
    if (_searchResults.isEmpty) {
      return Container(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            Icon(Icons.person_off, color: Colors.grey[600], size: 48.sp),
            SizedBox(height: 12.h),
            Text(
              'No users found',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Try a different search term',
              style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // Results list
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${_searchResults.length} user${_searchResults.length == 1 ? '' : 's'} found',
          style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey[500]),
        ),
        SizedBox(height: 8.h),
        ...List.generate(_searchResults.length, (index) {
          final user = _searchResults[index];
          final isAlreadyMember = _isUserAlreadyMember(user.userId, email: user.email);
          final isSelected = _selectedUser?.userId == user.userId;

          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: _buildUserCard(user, isAlreadyMember, isSelected),
          );
        }),
      ],
    );
  }

  Widget _buildUserCard(UserSearchResultEntity user, bool isAlreadyMember, bool isSelected) {
    return GestureDetector(
      onTap: isAlreadyMember ? null : () => _selectUser(user),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6366F1).withValues(alpha: 0.2)
              : isAlreadyMember
                  ? const Color(0xFFF59E0B).withValues(alpha: 0.1)
                  : const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6366F1)
                : isAlreadyMember
                    ? const Color(0xFFF59E0B).withValues(alpha: 0.3)
                    : const Color(0xFF2D2D2D),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: user.profilePicture.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(22.r),
                      child: Image.network(
                        user.profilePicture,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Center(
                          child: Text(
                            user.initials,
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        user.initials,
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
            SizedBox(width: 12.w),
            // User info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          user.fullName,
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: isAlreadyMember ? Colors.grey[400] : Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isAlreadyMember) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Already added',
                            style: GoogleFonts.inter(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFF59E0B),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    user.username.isNotEmpty ? '@${user.username}' : user.email,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: const Color(0xFF6366F1),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Selection indicator
            if (isSelected)
              Icon(Icons.check_circle, color: const Color(0xFF6366F1), size: 24.sp)
            else if (!isAlreadyMember)
              Icon(Icons.radio_button_unchecked, color: Colors.grey[600], size: 24.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    final canAdd = _selectedUser != null && !_isUserAlreadyMember(_selectedUser!.userId, email: _selectedUser!.email);

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _isAddingMember ? null : () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey[700]!),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: ElevatedButton(
            onPressed: _isAddingMember || !canAdd ? null : _addMember,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              disabledBackgroundColor: Colors.grey[800],
            ),
            child: _isAddingMember
                ? SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    _selectedUser != null ? 'Add to Rotation' : 'Select a User',
                    style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
          ),
        ),
      ],
    );
  }
}
