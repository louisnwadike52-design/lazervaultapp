import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/group_entities.dart';
import '../../data/datasources/group_account_remote_data_source.dart';
import '../cubit/create_contribution_cubit.dart';
import '../cubit/create_contribution_state.dart';
import '../cubit/group_account_cubit.dart';
import '../widgets/contribution_steps/step1_type_selection.dart';
import '../widgets/contribution_steps/step2_basic_info.dart';
import '../widgets/contribution_steps/step3_schedule.dart';
import '../widgets/contribution_steps/step4_advanced.dart';
import '../widgets/contribution_steps/step5_review.dart';

/// Main carousel controller for contribution creation
///
/// Manages multi-step flow with PageView, progress indicators, and validation
class CreateContributionCarousel extends StatefulWidget {
  final String groupId;
  final List<GroupMember> groupMembers;
  final String createdBy;
  final GroupAccountRemoteDataSource dataSource;

  const CreateContributionCarousel({
    super.key,
    required this.groupId,
    required this.groupMembers,
    required this.createdBy,
    required this.dataSource,
  });

  @override
  State<CreateContributionCarousel> createState() =>
      _CreateContributionCarouselState();
}

class _CreateContributionCarouselState
    extends State<CreateContributionCarousel> {
  late PageController _pageController;
  late CreateContributionCubit _cubit;

  final List<String> _allPageNames = [
    'Type',
    'Details',
    'Schedule',
    'Settings',
    'Review',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _cubit = CreateContributionCubit(
      dataSource: widget.dataSource,
      groupId: widget.groupId,
      groupMembers: widget.groupMembers,
      createdBy: widget.createdBy,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _cubit.close();
    super.dispose();
  }

  List<String> get _currentPageNames {
    if (_cubit.type == ContributionType.oneTime) {
      // Skip Schedule step for one-time contributions
      return [_allPageNames[0], _allPageNames[1], _allPageNames[3], _allPageNames[4]];
    }
    return _allPageNames;
  }

  Future<void> _goToNextPage() async {
    if (_cubit.goToNextStep()) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    if (_cubit.currentStep > 0) {
      _cubit.goToPreviousStep();
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  void _submitContribution() {
    _cubit.submitContribution();
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

  void _showSuccessSnackBar(String message) {
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
        backgroundColor: const Color(0xFF10B981),
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
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: _buildAppBar(),
        body: BlocConsumer<CreateContributionCubit, CreateContributionState>(
          listener: (context, state) {
            if (state is CreateContributionValidationError) {
              _showErrorSnackBar(state.message);
            } else if (state is CreateContributionError) {
              _showErrorSnackBar(state.message);
            } else if (state is CreateContributionSuccess) {
              _showSuccessSnackBar(state.message);
              // Reload group details and close
              context.read<GroupAccountCubit>().loadGroupDetails(widget.groupId);
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            final isSubmitting = state is CreateContributionSubmitting;
            final currentStep = state is CreateContributionFormUpdated
                ? state.currentStep
                : 0;
            final contributionType = state is CreateContributionFormUpdated
                ? state.type
                : ContributionType.oneTime;

            return Column(
              children: [
                _buildProgressIndicators(currentStep, contributionType),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: _buildPages(contributionType),
                  ),
                ),
                _buildNavigationButtons(currentStep, isSubmitting, contributionType),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildPages(ContributionType type) {
    if (type == ContributionType.oneTime) {
      return const [
        Step1TypeSelection(),
        Step2BasicInfo(),
        Step4Advanced(),
        Step5Review(),
      ];
    }
    return const [
      Step1TypeSelection(),
      Step2BasicInfo(),
      Step3Schedule(),
      Step4Advanced(),
      Step5Review(),
    ];
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
      title: BlocBuilder<CreateContributionCubit, CreateContributionState>(
        builder: (context, state) {
          final currentStep = state is CreateContributionFormUpdated
              ? state.currentStep
              : 0;
          final type = state is CreateContributionFormUpdated
              ? state.type
              : ContributionType.oneTime;
          final totalSteps = type == ContributionType.oneTime ? 4 : 5;
          final pageNames = _currentPageNames;

          return Column(
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
                'Step ${currentStep + 1} of $totalSteps - ${pageNames[currentStep]}',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProgressIndicators(int currentStep, ContributionType type) {
    final totalSteps = type == ContributionType.oneTime ? 4 : 5;

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
                    ((currentStep + 1) / totalSteps),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: currentStep == totalSteps - 1
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
              totalSteps,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: currentStep == index ? 24.w : 8.w,
                height: 8.h,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  color: index <= currentStep
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

  Widget _buildNavigationButtons(int currentStep, bool isSubmitting, ContributionType type) {
    final totalSteps = type == ContributionType.oneTime ? 4 : 5;
    final isLastPage = currentStep == totalSteps - 1;

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
            if (currentStep > 0)
              Expanded(
                child: GestureDetector(
                  onTap: isSubmitting ? null : _goToPreviousPage,
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
                          color: isSubmitting ? Colors.grey : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (currentStep > 0) SizedBox(width: 12.w),
            Expanded(
              child: GestureDetector(
                onTap: isSubmitting
                    ? null
                    : (isLastPage ? _submitContribution : _goToNextPage),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    gradient: isSubmitting
                        ? null
                        : const LinearGradient(
                            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    color: isSubmitting ? Colors.grey : null,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: isSubmitting
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
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
