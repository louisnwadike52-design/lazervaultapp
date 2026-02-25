import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/src/features/family_account/domain/repositories/family_account_repository.dart'
    show MemberAllocationEntry;
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/username_search_bottom_sheet.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';

/// Post-creation setup flow for Family & Friends accounts.
/// 4-step wizard: Distribution Mode → Configure Allocation → Spending Visibility → Review & Activate
class FamilyActivationSetupScreen extends StatefulWidget {
  final String familyId;

  const FamilyActivationSetupScreen({super.key, required this.familyId});

  @override
  State<FamilyActivationSetupScreen> createState() =>
      _FamilyActivationSetupScreenState();
}

class _FamilyActivationSetupScreenState
    extends State<FamilyActivationSetupScreen> {
  final PageController _pageController = PageController();
  final FamilyAccountCubit _cubit = serviceLocator<FamilyAccountCubit>();

  int _currentStep = 0;
  final int _totalSteps = 5;

  // Setup data
  FundDistributionMode _selectedMode = FundDistributionMode.sharedPool;
  bool _spendingVisibilityEnabled = true;
  final Map<String, TextEditingController> _allocationControllers = {};

  // Spending limits per member (memberId → controllers)
  final Map<String, TextEditingController> _dailyLimitControllers = {};
  final Map<String, TextEditingController> _monthlyLimitControllers = {};
  final Map<String, TextEditingController> _perTxLimitControllers = {};
  final Set<String> _expandedLimitMembers = {};

  // Invite members data
  final List<FamilyMember> _invitedMembers = [];
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _inviteDailyLimitController = TextEditingController();
  final TextEditingController _inviteMonthlyLimitController = TextEditingController();
  bool _isInviting = false;
  UserSearchResultEntity? _selectedUser;

  // Loaded family account data
  FamilyAccount? _familyAccount;

  @override
  void initState() {
    super.initState();
    if (widget.familyId.isEmpty) {
      // Missing familyId — show error and navigate back
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Error',
          'Family account ID is missing. Please try again from the dashboard.',
          backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        Get.back();
      });
    } else {
      _cubit.loadFamilyAccount(widget.familyId);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (final c in _allocationControllers.values) {
      c.dispose();
    }
    for (final c in _dailyLimitControllers.values) {
      c.dispose();
    }
    for (final c in _monthlyLimitControllers.values) {
      c.dispose();
    }
    for (final c in _perTxLimitControllers.values) {
      c.dispose();
    }
    _usernameController.dispose();
    _inviteDailyLimitController.dispose();
    _inviteMonthlyLimitController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _activateAccount() {
    if (widget.familyId.isEmpty) return;

    final allocations = <MemberAllocationEntry>[];
    if (_selectedMode == FundDistributionMode.customAllocation &&
        _familyAccount != null) {
      for (final member in _familyAccount!.members) {
        if (member.isActive) {
          final controller = _allocationControllers[member.id];
          final amount = double.tryParse(controller?.text ?? '') ?? 0.0;
          allocations.add(
            MemberAllocationEntry(memberId: member.id, amount: amount),
          );
        }
      }
    }

    _cubit.setupAccount(
      familyId: widget.familyId,
      fundDistributionMode: _selectedMode.value,
      spendingVisibilityEnabled: _spendingVisibilityEnabled,
      allocations: allocations,
    );
  }

  // Guard: prevents the BlocConsumer listener from handling states emitted
  // by updateMember calls during the post-setup limit application.
  bool _isApplyingLimits = false;

  Future<void> _applySpendingLimitsAndNavigate() async {
    _isApplyingLimits = true;
    try {
      // Apply spending limits for members that have them set
      final members = _familyAccount?.members.where((m) => m.isActive) ?? [];
      for (final member in members) {
        final daily = (double.tryParse(_dailyLimitControllers[member.id]?.text ?? '') ?? 0.0).clamp(0.0, double.infinity);
        final monthly = (double.tryParse(_monthlyLimitControllers[member.id]?.text ?? '') ?? 0.0).clamp(0.0, double.infinity);
        final perTx = (double.tryParse(_perTxLimitControllers[member.id]?.text ?? '') ?? 0.0).clamp(0.0, double.infinity);

        if (daily > 0 || monthly > 0 || perTx > 0) {
          try {
            await _cubit.updateMember(
              familyId: widget.familyId,
              memberId: member.id,
              dailySpendingLimit: daily,
              monthlySpendingLimit: monthly,
              perTransactionLimit: perTx,
            );
          } catch (_) {
            // Best-effort: limits can be set later from account details
          }
        }
      }
    } finally {
      _isApplyingLimits = false;
    }

    if (!mounted) return;
    Get.snackbar(
      'Account Activated',
      'Your family account is now active!',
      backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
    Get.offAllNamed(AppRoutes.dashboard);
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Distribution Mode';
      case 1:
        return 'Configure Allocation';
      case 2:
        return 'Spending Visibility';
      case 3:
        return 'Invite Members';
      case 4:
        return 'Review & Activate';
      default:
        return 'Setup';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: BlocConsumer<FamilyAccountCubit, FamilyAccountState>(
          bloc: _cubit,
          listener: (context, state) {
            // Ignore states emitted by updateMember during post-setup limit application
            if (_isApplyingLimits) return;

            if (state is FamilyAccountLoaded) {
              setState(() {
                _familyAccount = state.familyAccount;
                // Initialize allocation and spending limit controllers for active members
                for (final member in state.familyAccount.members) {
                  if (member.isActive &&
                      !_allocationControllers.containsKey(member.id)) {
                    _allocationControllers[member.id] =
                        TextEditingController(text: '0');
                    _dailyLimitControllers[member.id] =
                        TextEditingController();
                    _monthlyLimitControllers[member.id] =
                        TextEditingController();
                    _perTxLimitControllers[member.id] =
                        TextEditingController();
                  }
                }
              });
            } else if (state is FamilyMemberAdded) {
              setState(() {
                _invitedMembers.add(state.member);
                _isInviting = false;
                _selectedUser = null;
                _usernameController.clear();
                _inviteDailyLimitController.clear();
                _inviteMonthlyLimitController.clear();
              });
              Get.snackbar(
                'Invitation Sent',
                '${state.member.fullName.isNotEmpty ? state.member.fullName : 'Member'} has been invited.',
                backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
              );
              // Reload the family account to refresh member list
              _cubit.loadFamilyAccount(widget.familyId);
            } else if (state is FamilyMemberAdding) {
              setState(() => _isInviting = true);
            } else if (state is FamilyAccountSetupCompleted) {
              // Apply spending limits to members if any were set
              _applySpendingLimitsAndNavigate();
              return; // Navigation happens in _applySpendingLimitsAndNavigate
            } else if (state is FamilyAccountError) {
              setState(() => _isInviting = false);
              Get.snackbar(
                'Error',
                state.message,
                backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
              );
            }
          },
          builder: (context, state) {
            if (state is FamilyAccountLoading && _familyAccount == null) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
              );
            }

            return Column(
              children: [
                _buildProgressHeader(),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildDistributionModeStep(),
                      _buildConfigureAllocationStep(),
                      _buildSpendingVisibilityStep(),
                      _buildInviteMembersStep(),
                      _buildReviewStep(state),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProgressHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: _currentStep > 0 ? _previousStep : () => Get.back(),
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1F1F1F),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _currentStep > 0 ? Icons.arrow_back_ios_new : Icons.close,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  _getStepTitle(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 56.w),
            ],
          ),
          SizedBox(height: 24.h),
          // Progress bar
          Row(
            children: List.generate(
              _totalSteps,
              (index) => Expanded(
                child: Container(
                  height: 4.h,
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  decoration: BoxDecoration(
                    gradient: index <= _currentStep
                        ? const LinearGradient(
                            colors: [Color(0xFF1A4747), Color(0xFF2D6B6B)],
                          )
                        : null,
                    color: index <= _currentStep ? null : const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Step ${_currentStep + 1} of $_totalSteps',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Step 1: Choose Distribution Mode
  Widget _buildDistributionModeStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          Text(
            'How should funds be distributed?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Choose how the family balance is shared among members.',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
              height: 1.4,
            ),
          ),
          SizedBox(height: 24.h),
          _buildModeCard(
            FundDistributionMode.sharedPool,
            Icons.group,
          ),
          SizedBox(height: 12.h),
          _buildModeCard(
            FundDistributionMode.equalSplit,
            Icons.balance,
          ),
          SizedBox(height: 12.h),
          _buildModeCard(
            FundDistributionMode.customAllocation,
            Icons.tune,
          ),
          SizedBox(height: 32.h),
          _buildContinueButton(onTap: _nextStep),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildModeCard(FundDistributionMode mode, IconData icon) {
    final isSelected = _selectedMode == mode;
    return GestureDetector(
      onTap: () => setState(() => _selectedMode = mode),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF2D6B6B) : const Color(0xFF2D2D2D),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF2D6B6B).withValues(alpha: 0.3)
                    : const Color(0xFF2D2D2D),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? const Color(0xFF2D6B6B) : const Color(0xFF9CA3AF),
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mode.displayName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    mode.description,
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: const Color(0xFF2D6B6B),
                size: 24.sp,
              ),
          ],
        ),
      ),
    );
  }

  // Step 2: Configure Allocation
  Widget _buildConfigureAllocationStep() {
    final account = _familyAccount;
    final totalBalance = account?.totalBalance ?? 0.0;
    final activeMembers =
        account?.members.where((m) => m.isActive).toList() ?? [];

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          if (_selectedMode == FundDistributionMode.sharedPool) ...[
            _buildInfoCard(
              Icons.group,
              'Shared Pool',
              'All ${activeMembers.length} members will share the total balance of \$${totalBalance.toStringAsFixed(2)}. Any spending by any member reduces the shared balance.',
            ),
          ] else if (_selectedMode == FundDistributionMode.equalSplit) ...[
            if (activeMembers.isEmpty) ...[
              _buildInfoCard(
                Icons.info_outline,
                'No Active Members',
                'Equal split will be applied when members join. Funds will be divided equally among all active members.',
              ),
            ] else ...[
              _buildInfoCard(
                Icons.balance,
                'Equal Split',
                'Each of the ${activeMembers.length} active members will receive \$${(totalBalance / activeMembers.length).toStringAsFixed(2)}.',
              ),
              SizedBox(height: 16.h),
              ...activeMembers.map((member) => _buildMemberAllocationRow(
                    member,
                    (totalBalance / activeMembers.length).toStringAsFixed(2),
                    readOnly: true,
                  )),
            ],
          ] else ...[
            Text(
              'Assign amounts to each member',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            _buildRemainingBalanceIndicator(totalBalance),
            SizedBox(height: 16.h),
            if (activeMembers.isEmpty)
              _buildInfoCard(
                Icons.info_outline,
                'No Active Members',
                'You can complete setup now and allocate funds later when members join.',
              )
            else
              ...activeMembers.map((member) => _buildMemberAllocationRow(
                    member,
                    null,
                    readOnly: false,
                  )),
          ],
          SizedBox(height: 32.h),
          _buildContinueButton(onTap: _nextStep),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildRemainingBalanceIndicator(double totalBalance) {
    double allocated = 0;
    for (final controller in _allocationControllers.values) {
      allocated += double.tryParse(controller.text) ?? 0;
    }
    final remaining = totalBalance - allocated;
    final isOverAllocated = remaining < 0;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isOverAllocated
            ? const Color(0xFFEF4444).withValues(alpha: 0.1)
            : const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isOverAllocated
              ? const Color(0xFFEF4444).withValues(alpha: 0.3)
              : const Color(0xFF2D2D2D),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Remaining in pool:',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
            ),
          ),
          Text(
            '\$${remaining.toStringAsFixed(2)}',
            style: TextStyle(
              color: isOverAllocated ? const Color(0xFFEF4444) : const Color(0xFF10B981),
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberAllocationRow(
      FamilyMember member, String? fixedAmount,
      {required bool readOnly}) {
    final isExpanded = _expandedLimitMembers.contains(member.id);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor: const Color(0xFF2D6B6B).withValues(alpha: 0.3),
                child: Text(
                  member.fullName.isNotEmpty ? member.fullName[0].toUpperCase() : '?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.fullName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      member.role.displayName,
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              if (readOnly)
                Text(
                  '\$${fixedAmount ?? '0.00'}',
                  style: TextStyle(
                    color: const Color(0xFF10B981),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else
                SizedBox(
                  width: 100.w,
                  child: TextFormField(
                    controller: _allocationControllers[member.id],
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      prefixText: '\$ ',
                      prefixStyle: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF2D2D2D),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
            ],
          ),
          // Expandable spending limits
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () => setState(() {
              if (isExpanded) {
                _expandedLimitMembers.remove(member.id);
              } else {
                _expandedLimitMembers.add(member.id);
              }
            }),
            child: Row(
              children: [
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: const Color(0xFF2D6B6B),
                  size: 18.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Spending Limits',
                  style: TextStyle(
                    color: const Color(0xFF2D6B6B),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (isExpanded) ...[
            SizedBox(height: 12.h),
            _buildLimitField(
              controller: _dailyLimitControllers[member.id],
              label: 'Daily limit',
            ),
            SizedBox(height: 8.h),
            _buildLimitField(
              controller: _monthlyLimitControllers[member.id],
              label: 'Monthly limit',
            ),
            SizedBox(height: 8.h),
            _buildLimitField(
              controller: _perTxLimitControllers[member.id],
              label: 'Per-transaction limit',
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLimitField({
    TextEditingController? controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: TextStyle(color: Colors.white, fontSize: 13.sp),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: const Color(0xFF9CA3AF),
          fontSize: 11.sp,
        ),
        hintText: '0 = unlimited',
        hintStyle: TextStyle(
          color: const Color(0xFF9CA3AF).withValues(alpha: 0.4),
          fontSize: 11.sp,
        ),
        filled: true,
        fillColor: const Color(0xFF2D2D2D),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        prefixText: '\$ ',
        prefixStyle: TextStyle(
          color: const Color(0xFF9CA3AF),
          fontSize: 12.sp,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        isDense: true,
      ),
    );
  }

  // Step 3: Spending Visibility
  Widget _buildSpendingVisibilityStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          Center(
            child: Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2D6B6B).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.visibility_outlined,
                size: 40.sp,
                color: const Color(0xFF2D6B6B),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Spending Transparency',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Control whether spending activity is visible to all members.',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              height: 1.4,
            ),
          ),
          SizedBox(height: 32.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enable Spending Tracking',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'See what each member spends, where, and when',
                        style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _spendingVisibilityEnabled,
                  onChanged: (v) =>
                      setState(() => _spendingVisibilityEnabled = v),
                  activeThumbColor: const Color(0xFF2D6B6B),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          _buildInfoCard(
            Icons.analytics_outlined,
            'Admin Dashboard',
            'As the account admin, you will always have access to full spending analytics regardless of this setting.',
          ),
          SizedBox(height: 32.h),
          _buildContinueButton(onTap: _nextStep),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  // Step 4: Invite Members
  Widget _buildInviteMembersStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          Text(
            'Invite family members',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Search for LazerVault users by username, phone, name, or email. You can also invite members later from the account details.',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
              height: 1.4,
            ),
          ),
          SizedBox(height: 24.h),

          // Search & invite member card
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search button or selected user display
                if (_selectedUser == null)
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: OutlinedButton.icon(
                      onPressed: _openUserSearch,
                      icon: Icon(Icons.person_search, size: 20.sp),
                      label: Text(
                        'Search for a user',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF3B82F6),
                        side: const BorderSide(color: Color(0xFF3B82F6)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  )
                else
                  _buildSelectedUserCard(),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _inviteDailyLimitController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                        decoration: InputDecoration(
                          labelText: 'Daily limit (optional)',
                          labelStyle: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 11.sp,
                          ),
                          filled: true,
                          fillColor: const Color(0xFF2D2D2D),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide.none,
                          ),
                          prefixText: '\$ ',
                          prefixStyle: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 13.sp,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 10.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: TextFormField(
                        controller: _inviteMonthlyLimitController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                        decoration: InputDecoration(
                          labelText: 'Monthly limit (optional)',
                          labelStyle: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 11.sp,
                          ),
                          filled: true,
                          fillColor: const Color(0xFF2D2D2D),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide.none,
                          ),
                          prefixText: '\$ ',
                          prefixStyle: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 13.sp,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 10.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 44.h,
                  child: ElevatedButton.icon(
                    onPressed: _isInviting ? null : _inviteMember,
                    icon: _isInviting
                        ? SizedBox(
                            width: 18.w,
                            height: 18.h,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(Icons.person_add, size: 18.sp),
                    label: Text(
                      _isInviting ? 'Inviting...' : 'Send Invitation',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D6B6B),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Invited members list
          if (_invitedMembers.isNotEmpty) ...[
            SizedBox(height: 24.h),
            Text(
              'Invited Members',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            ..._invitedMembers.map((member) => Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFF2D2D2D)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.r,
                        backgroundColor: const Color(0xFF2D6B6B).withValues(alpha: 0.3),
                        child: Text(
                          member.fullName.isNotEmpty
                              ? member.fullName[0].toUpperCase()
                              : '?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              member.fullName.isNotEmpty
                                  ? member.fullName
                                  : (member.username ?? 'Invited Member'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (member.username != null)
                              Text(
                                '@${member.username}',
                                style: TextStyle(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 11.sp,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFB923C).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'Pending',
                          style: TextStyle(
                            color: const Color(0xFFFB923C),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],

          SizedBox(height: 32.h),
          _buildContinueButton(onTap: _nextStep),
          SizedBox(height: 8.h),
          Center(
            child: TextButton(
              onPressed: _nextStep,
              child: Text(
                'Skip & Continue',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Future<void> _openUserSearch() async {
    final user = await UsernameSearchBottomSheet.show(context);
    if (user != null) {
      setState(() {
        _selectedUser = user;
        _usernameController.text = user.username;
      });
    }
  }

  Widget _buildSelectedUserCard() {
    final user = _selectedUser!;
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.2),
            backgroundImage: user.profilePicture.isNotEmpty
                ? NetworkImage(user.profilePicture)
                : null,
            child: user.profilePicture.isEmpty
                ? Text(
                    user.initials,
                    style: TextStyle(
                      color: const Color(0xFF3B82F6),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '@${user.username}',
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedUser = null;
                _usernameController.clear();
              });
            },
            child: Icon(
              Icons.close,
              color: const Color(0xFF9CA3AF),
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  void _inviteMember() {
    final username = _usernameController.text.trim();
    if (username.isEmpty) {
      Get.snackbar(
        'No User Selected',
        'Please search and select a user to invite.',
        backgroundColor: const Color(0xFFFB923C).withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Prevent duplicate invitations to the same username
    final alreadyInvited = _invitedMembers.any(
      (m) => m.username?.toLowerCase() == username.toLowerCase(),
    );
    if (alreadyInvited) {
      Get.snackbar(
        'Already Invited',
        '$username has already been invited.',
        backgroundColor: const Color(0xFFFB923C).withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Also check existing members (active or pending)
    final alreadyMember = _familyAccount?.members.any(
      (m) => m.username?.toLowerCase() == username.toLowerCase() &&
             (m.isActive || m.isPending),
    ) ?? false;
    if (alreadyMember) {
      Get.snackbar(
        'Already a Member',
        '$username is already a member or has a pending invitation.',
        backgroundColor: const Color(0xFFFB923C).withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    final dailyLimit = (double.tryParse(_inviteDailyLimitController.text) ?? 0.0).clamp(0.0, double.infinity);
    final monthlyLimit = (double.tryParse(_inviteMonthlyLimitController.text) ?? 0.0).clamp(0.0, double.infinity);

    _cubit.addMember(
      familyId: widget.familyId,
      invitationMethod: 'username',
      invitationDestination: username,
      initialAllocation: 0.0,
      dailyLimit: dailyLimit,
      monthlyLimit: monthlyLimit,
      perTransactionLimit: 0.0,
      allocationPercentageCap: 100.0,
      role: 'member',
    );
  }

  // Step 5: Review & Activate
  Widget _buildReviewStep(FamilyAccountState state) {
    final isLoading = state is FamilyAccountSettingUp;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 8.h),
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2D6B6B).withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.rocket_launch_outlined,
              size: 40.sp,
              color: const Color(0xFF2D6B6B),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Ready to Activate',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Review your setup and activate the account.',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 24.h),

          // Summary card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryRow(
                    'Account', _familyAccount?.name ?? 'Family Account'),
                SizedBox(height: 16.h),
                _buildSummaryRow(
                    'Distribution Mode', _selectedMode.displayName),
                SizedBox(height: 16.h),
                _buildSummaryRow(
                  'Spending Visibility',
                  _spendingVisibilityEnabled ? 'Enabled' : 'Disabled',
                ),
                SizedBox(height: 16.h),
                _buildSummaryRow(
                  'Total Balance',
                  '\$${(_familyAccount?.totalBalance ?? 0).toStringAsFixed(2)}',
                ),
                SizedBox(height: 16.h),
                _buildSummaryRow(
                  'Active Members',
                  '${_familyAccount?.activeMemberCount ?? 0}',
                ),
                if (_invitedMembers.isNotEmpty) ...[
                  SizedBox(height: 16.h),
                  _buildSummaryRow(
                    'Pending Invitations',
                    '${_invitedMembers.length}',
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 32.h),

          // Activate button
          Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A4747), Color(0xFF2D6B6B)],
              ),
              borderRadius: BorderRadius.circular(28.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1A4747).withValues(alpha: 0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isLoading ? null : _activateAccount,
                borderRadius: BorderRadius.circular(28.r),
                child: Center(
                  child: isLoading
                      ? SizedBox(
                          width: 24.w,
                          height: 24.h,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Activate Account',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String description) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2D6B6B).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF2D6B6B).withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF2D6B6B), size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton({required VoidCallback onTap}) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A4747), Color(0xFF2D6B6B)],
        ),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A4747).withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(28.r),
          child: Center(
            child: Text(
              'Continue',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
