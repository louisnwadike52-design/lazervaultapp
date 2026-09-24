import 'package:flutter/material.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/family_account/domain/repositories/family_account_repository.dart'
    show MemberAllocationEntry;
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/username_search_bottom_sheet.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';

/// Post-creation setup flow for Family & Friends accounts.
/// 5-step wizard: Distribution Mode → Invite Members → Configure Allocation → Spending Visibility → Review & Activate
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

  /// Whether the chosen mode has per-member amounts to enter.
  ///
  /// Only Custom Allocation does. Shared Pool and Equal Split are defined
  /// entirely by the choice already made on step 1.
  bool get _needsAllocationStep =>
      _selectedMode == FundDistributionMode.customAllocation;

  /// Steps this setup actually needs, rather than a fixed five.
  ///
  /// "Configure Allocation" had nothing to configure for Shared Pool or Equal
  /// Split: it rendered a single explanatory card above a Continue button, so
  /// the user spent a whole step of a five-step progress bar re-reading the
  /// description of the mode they had just picked on the card that sent them
  /// there. It now appears only for Custom Allocation, where per-member amounts
  /// genuinely have to be entered.
  int get _totalSteps => _needsAllocationStep ? 5 : 4;

  // Setup data
  FundDistributionMode _selectedMode = FundDistributionMode.sharedPool;
  bool _spendingVisibilityEnabled = true;
  // Who may fund the pool: any_member (default) | creator_only | specific_members.
  String _fundingPolicy = 'any_member';
  // Member ids allowed to fund when policy == specific_members (real ids: members
  // already exist on this resume path).
  final Set<String> _specificContributorIds = {};
  final Map<String, TextEditingController> _allocationControllers = {};

  // Spending limits per member (memberId → controllers)
  final Map<String, TextEditingController> _dailyLimitControllers = {};
  final Map<String, TextEditingController> _monthlyLimitControllers = {};
  final Map<String, TextEditingController> _perTxLimitControllers = {};
  final Set<String> _expandedLimitMembers = {};

  // Invite members data
  //
  // _invitedMembers holds members that ALREADY EXIST server-side (a resumed
  // setup, or someone invited before this change). _stagedInvites holds people
  // chosen in THIS session who have not been contacted yet — they are sent once,
  // on final submit. Keeping them apart is what stops a resumed setup from
  // re-inviting everyone.
  final List<FamilyMember> _invitedMembers = [];
  final List<_StagedInvite> _stagedInvites = [];
  final TextEditingController _usernameController = TextEditingController();
  // Account display name — every family account is named (user request
  // 2026-09-07). Prefilled with the stored name; editable during setup.
  final TextEditingController _accountNameController = TextEditingController();

  /// Inline error under the account-name field, set when Continue is refused.
  String? _accountNameValidationError;
  final TextEditingController _inviteDailyLimitController =
      TextEditingController();
  final TextEditingController _inviteMonthlyLimitController =
      TextEditingController();
  /// Guards the final submit: a second tap would re-send every staged invite
  /// before the server refused the duplicate activation.
  bool _isSubmittingSetup = false;
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
    _accountNameController.dispose();
    _inviteDailyLimitController.dispose();
    _inviteMonthlyLimitController.dispose();
    super.dispose();
  }

  /// Names the account was created with rather than named by a person.
  ///
  /// Matched case- and space-insensitively because the value is compared against
  /// whatever the backend stored, not against a constant we control.
  static bool _isPlaceholderAccountName(String name) {
    final n = name.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
    return n.isEmpty ||
        n == 'family & friends' ||
        n == 'family and friends' ||
        n == 'family account';
  }

  /// The account name must be a real choice before step 1 can be left.
  ///
  /// Enforced here AND on the server: this stops the accidental default, the
  /// server stops a client that skips the flow. Minimum 2 characters so a
  /// single stray keystroke does not count as naming it.
  String? _accountNameError() {
    final name = _accountNameController.text.trim();
    if (name.isEmpty) return 'Give this account a name';
    if (name.length < 2) return 'That name is too short';
    if (_isPlaceholderAccountName(name)) {
      return 'Choose a name your members will recognise';
    }
    return null;
  }

  void _nextStep() {
    // Step 1 owns the account name. Blocking here rather than disabling the
    // button so the user is told WHY, instead of facing a dead control.
    if (_currentStep == 0) {
      final err = _accountNameError();
      if (err != null) {
        setState(() => _accountNameValidationError = err);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(err),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
      if (_accountNameValidationError != null) {
        setState(() => _accountNameValidationError = null);
      }
    }
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

  /// Final submit: send the staged invitations, THEN activate.
  ///
  /// Ordering matters. Invitations first means the members exist before the
  /// account goes active, so allocation and limits apply to a settled roster
  /// rather than one that grows a moment later. It also means a creator who
  /// abandons the wizard has sent nothing at all.
  ///
  /// Guarded against a double-tap: activation is a one-shot transition the
  /// server refuses to repeat, but a second tap would re-send every staged
  /// invitation before hitting that refusal.
  Future<void> _activateAccount() async {
    if (widget.familyId.isEmpty) return;
    if (_isSubmittingSetup) return;
    setState(() => _isSubmittingSetup = true);

    try {
      final failed = await _sendStagedInvites();
      if (!mounted) return;
      if (failed.isNotEmpty) {
        // Named explicitly. "Some invitations failed" leaves the creator with no
        // idea who to re-add, and the account is about to go active either way.
        Get.snackbar(
          'Some invitations were not sent',
          'Could not invite: ${failed.join(', ')}. You can invite them again '
              'from the account details.',
          backgroundColor: const Color(0xFFFB923C).withValues(alpha: 0.95),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 6),
        );
      }
      // Sent (or attempted) exactly once — clear so a retry of the activation
      // step cannot re-invite the same people.
      if (mounted) setState(() => _stagedInvites.clear());
      _submitSetup();
    } finally {
      if (mounted) setState(() => _isSubmittingSetup = false);
    }
  }

  void _submitSetup() {
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

    final specificMemberIds = _fundingPolicy == 'specific_members'
        ? _specificContributorIds.toList()
        : const <String>[];
    _cubit.setupAccount(
      familyId: widget.familyId,
      fundDistributionMode: _selectedMode.value,
      spendingVisibilityEnabled: _spendingVisibilityEnabled,
      allocations: allocations,
      fundingPolicy: _fundingPolicy,
      specificMemberIds: specificMemberIds,
      accountName: _accountNameController.text.trim(),
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
        final daily =
            (double.tryParse(_dailyLimitControllers[member.id]?.text ?? '') ??
                    0.0)
                .clamp(0.0, double.infinity);
        final monthly =
            (double.tryParse(_monthlyLimitControllers[member.id]?.text ?? '') ??
                    0.0)
                .clamp(0.0, double.infinity);
        final perTx =
            (double.tryParse(_perTxLimitControllers[member.id]?.text ?? '') ??
                    0.0)
                .clamp(0.0, double.infinity);

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
    // Force-refresh the dashboard summaries so the newly-ACTIVE family card
    // renders immediately. The dashboard SKIPS re-fetch on navigation when it
    // already has cached data, so returning to it would otherwise show the stale
    // pending card until a manual pull-to-refresh.
    try {
      final accountsCubit = context.read<AccountCardsSummaryCubit>();
      if (accountsCubit.currentUserId != null) {
        accountsCubit.fetchAccountSummaries(
            userId: accountsCubit.currentUserId!);
      }
    } catch (_) {}
    Get.snackbar(
      'Account Activated',
      'Your family account is now active!',
      backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
    Get.offAllNamed(AppRoutes.dashboard);
  }

  /// Modal shown when an allocation exceeds the available pool balance.
  /// Preferred over a red snackbar for over-allocation so the user has to
  /// acknowledge it explicitly.
  void _showAllocationErrorDialog(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Allocation exceeds balance',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            color: const Color(0xFFB0B7C3),
            fontSize: 14.sp,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'OK',
              style: TextStyle(
                color: const Color(0xFF4E03D0),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Distribution Mode';
      case 1:
        return 'Invite Members';
      case 2:
        return 'Configure Allocation';
      case 3:
        return 'Spending Visibility';
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
                // Prefill ONLY a name the user actually chose.
                //
                // A Family & Friends account is created with the placeholder name
                // "Family & Friends" before this screen runs, and prefilling that
                // made step 1 look already-answered: the field showed a real
                // value with a 16/50 counter, so people pressed Continue and
                // shipped an account every member sees as the generic default.
                // Leaving it empty lets the hint do its job and makes the
                // required-field validation below meaningful.
                //
                // Still prefilled when the user HAS named it, so returning to
                // this step edits rather than retypes. Never clobbers in-progress
                // typing on a refresh.
                if (_accountNameController.text.isEmpty &&
                    !_isPlaceholderAccountName(state.familyAccount.name)) {
                  _accountNameController.text = state.familyAccount.name;
                }
                // Initialize allocation and spending limit controllers for active members
                for (final member in state.familyAccount.members) {
                  if (member.isActive &&
                      !_allocationControllers.containsKey(member.id)) {
                    _allocationControllers[member.id] =
                        TextEditingController(text: '0');
                    _dailyLimitControllers[member.id] = TextEditingController();
                    _monthlyLimitControllers[member.id] =
                        TextEditingController();
                    _perTxLimitControllers[member.id] = TextEditingController();
                  }
                }
              });
            // FamilyMemberAdded / FamilyMemberAdding are no longer handled here.
            // Staging is local and the batch send on submit uses
            // addMemberAwaitable, which deliberately emits no cubit state — so
            // these branches could only fire from another screen sharing this
            // cubit, where reacting would be wrong.
            } else if (state is FamilyAccountSetupCompleted) {
              // Apply spending limits to members if any were set
              _applySpendingLimitsAndNavigate();
              return; // Navigation happens in _applySpendingLimitsAndNavigate
            } else if (state is FamilyAccountError) {

              final msg = state.message.toLowerCase();
              if (msg.contains('exceed') || msg.contains('insufficient')) {
                _showAllocationErrorDialog(context, state.message);
              } else {
                Get.snackbar(
                  'Error',
                  state.message,
                  backgroundColor:
                      const Color(0xFFEF4444).withValues(alpha: 0.9),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                );
              }
            }
          },
          builder: (context, state) {
            if (state is FamilyAccountLoading && _familyAccount == null) {
              return const Center(
                child: LazerVaultLoader.small(),
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
                      _buildInviteMembersStep(),
                      // Only when there is something to allocate — see
                      // _needsAllocationStep.
                      if (_needsAllocationStep)
                        _buildConfigureAllocationStep(),
                      _buildSpendingVisibilityStep(),
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
                            colors: [Color(0xFF4E03D0), Color(0xFF7C3AED)],
                          )
                        : null,
                    color:
                        index <= _currentStep ? null : const Color(0xFF2D2D2D),
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
            'Name this account',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Give your Family & Friends account a name everyone will recognise.',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
              height: 1.4,
            ),
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: _accountNameController,
            maxLength: 50,
            style: TextStyle(color: Colors.white, fontSize: 15.sp),
            textCapitalization: TextCapitalization.words,
            // Clear the error as soon as they start fixing it — leaving it up
            // while they type reads as "still wrong" when it no longer is.
            onChanged: (_) {
              if (_accountNameValidationError != null) {
                setState(() => _accountNameValidationError = null);
              }
            },
            decoration: InputDecoration(
              hintText: 'e.g. The Nwadikes, Weekend Crew…',
              errorText: _accountNameValidationError,
              errorStyle: TextStyle(
                  color: const Color(0xFFEF4444), fontSize: 12.sp),
              hintStyle:
                  TextStyle(color: const Color(0xFF6B7280), fontSize: 14.sp),
              counterStyle:
                  TextStyle(color: const Color(0xFF6B7280), fontSize: 11.sp),
              filled: true,
              fillColor: const Color(0xFF1F1F1F),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            ),
          ),
          SizedBox(height: 20.h),
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
      onTap: () => setState(() {
        _selectedMode = mode;
        // Switching away from Custom Allocation removes a page. The mode is only
        // selectable on step 1 so this should already hold, but an out-of-range
        // _currentStep would render a blank wizard with a broken progress bar —
        // cheap to make impossible rather than rely on that.
        if (_currentStep > _totalSteps - 1) {
          _currentStep = _totalSteps - 1;
          _pageController.jumpToPage(_currentStep);
        }
      }),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF4E03D0) : const Color(0xFF2D2D2D),
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
                    ? const Color(0xFF4E03D0).withValues(alpha: 0.3)
                    : const Color(0xFF2D2D2D),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? const Color(0xFF4E03D0)
                    : const Color(0xFF9CA3AF),
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
                color: const Color(0xFF4E03D0),
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
              'All ${activeMembers.length} members will share the total balance of ${CurrencySymbols.currentSymbol}${totalBalance.toStringAsFixed(2)}. Any spending by any member reduces the shared balance.',
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
                'Each of the ${activeMembers.length} active members will receive ${CurrencySymbols.currentSymbol}${(totalBalance / activeMembers.length).toStringAsFixed(2)}.',
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
            '${CurrencySymbols.currentSymbol}${remaining.toStringAsFixed(2)}',
            style: TextStyle(
              color: isOverAllocated
                  ? const Color(0xFFEF4444)
                  : const Color(0xFF10B981),
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberAllocationRow(FamilyMember member, String? fixedAmount,
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
                backgroundColor: const Color(0xFF4E03D0).withValues(alpha: 0.3),
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
                  '${CurrencySymbols.currentSymbol}${fixedAmount ?? '0.00'}',
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
                      prefixText: '${CurrencySymbols.currentSymbol} ',
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
                  color: const Color(0xFF4E03D0),
                  size: 18.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Spending Limits',
                  style: TextStyle(
                    color: const Color(0xFF4E03D0),
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
        prefixText: '${CurrencySymbols.currentSymbol} ',
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
                color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.visibility_outlined,
                size: 40.sp,
                color: const Color(0xFF4E03D0),
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
                  activeThumbColor: const Color(0xFF4E03D0),
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
          Text(
            'Who can fund the pool',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Text(
            'Choose who is allowed to add money to the pool.',
            style: TextStyle(
                color: const Color(0xFF9CA3AF), fontSize: 13.sp, height: 1.4),
          ),
          SizedBox(height: 16.h),
          _buildFundingPolicyCard('any_member', 'Any member',
              'Every member can add money to the pool.', Icons.groups),
          _buildFundingPolicyCard(
              'creator_only',
              'Only me',
              'Only you (the creator) can add money to the pool.',
              Icons.person),
          _buildFundingPolicyCard('specific_members', 'Specific members',
              'Only members you pick can add money.', Icons.checklist),
          if (_fundingPolicy == 'specific_members')
            _buildSpecificContributorsList(),
          SizedBox(height: 32.h),
          _buildContinueButton(onTap: _nextStep),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildFundingPolicyCard(
      String value, String title, String desc, IconData icon) {
    const accent = Color(0xFF4E03D0);
    final selected = _fundingPolicy == value;
    return GestureDetector(
      onTap: () => setState(() => _fundingPolicy = value),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
              color: selected ? accent : const Color(0xFF2D2D2D),
              width: selected ? 2 : 1),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: selected
                    ? accent.withValues(alpha: 0.25)
                    : const Color(0xFF2D2D2D),
                shape: BoxShape.circle,
              ),
              child: Icon(icon,
                  color: selected ? Colors.white : const Color(0xFF9CA3AF),
                  size: 22.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 3.h),
                  Text(desc,
                      style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 11.sp,
                          height: 1.3)),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle, color: accent, size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecificContributorsList() {
    // The creator can always fund, so only invited members are pickable.
    final members = (_familyAccount?.members ?? [])
        .where((m) => m.userId != _familyAccount?.creatorId)
        .toList();
    if (members.isEmpty) {
      return Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Text(
          'No other members yet. Until you add members, only you can fund the pool.',
          style: TextStyle(
              color: const Color(0xFF9CA3AF), fontSize: 12.sp, height: 1.4),
        ),
      );
    }
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          for (final m in members)
            InkWell(
              onTap: () => setState(() {
                if (_specificContributorIds.contains(m.id)) {
                  _specificContributorIds.remove(m.id);
                } else {
                  _specificContributorIds.add(m.id);
                }
              }),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                child: Row(
                  children: [
                    Icon(
                      _specificContributorIds.contains(m.id)
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: _specificContributorIds.contains(m.id)
                          ? const Color(0xFF4E03D0)
                          : const Color(0xFF9CA3AF),
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        m.fullName.trim().isEmpty
                            ? (m.username ?? 'Member')
                            : m.fullName.trim(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
            'Search for Lazervault users by username, phone, name, or email. You can also invite members later from the account details.',
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
                        foregroundColor: const Color(0xFF4E03D0),
                        side: const BorderSide(color: Color(0xFF4E03D0)),
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
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
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
                          prefixText: '${CurrencySymbols.currentSymbol} ',
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
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
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
                          prefixText: '${CurrencySymbols.currentSymbol} ',
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
                    // "Add to invite list", not "Send Invitation": nothing is
                    // sent here any more. Naming it Send was the honest label
                    // for the old behaviour and would be a lie for this one —
                    // the invitations go out when the setup is submitted.
                    //
                    // Disabled until someone is actually picked, so the button
                    // cannot be tapped into a "No User Selected" warning.
                    onPressed: _selectedUser == null ? null : _inviteMember,
                    icon: Icon(Icons.person_add_alt_1, size: 18.sp),
                    label: Text(
                      'Add to invite list',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E03D0),
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

          // People staged in THIS session — not contacted yet, and removable
          // right up to submit. Kept visually distinct from _invitedMembers
          // (already invited server-side) so "will be invited" is never
          // confused with "has been invited".
          if (_stagedInvites.isNotEmpty) ...[
            SizedBox(height: 24.h),
            Row(
              children: [
                Text(
                  'Will be invited',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4E03D0).withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text('${_stagedInvites.length}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              'Invitations are sent when you finish setup.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 12.h),
            ..._stagedInvites.map((s) => Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(12.r),
                    border:
                        Border.all(color: const Color(0xFF4E03D0), width: 1),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.r,
                        backgroundColor:
                            const Color(0xFF4E03D0).withValues(alpha: 0.3),
                        backgroundImage: (s.avatarUrl?.isNotEmpty ?? false)
                            ? NetworkImage(s.avatarUrl!)
                            : null,
                        child: (s.avatarUrl?.isNotEmpty ?? false)
                            ? null
                            : Text(
                                s.displayName.isNotEmpty
                                    ? s.displayName[0].toUpperCase()
                                    : '?',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(s.displayName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600)),
                            Text('@${s.username}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: const Color(0xFFA78BFA),
                                    fontSize: 12.sp)),
                          ],
                        ),
                      ),
                      // Removable right up to submit — nothing has been sent,
                      // so this genuinely un-invites rather than revoking.
                      IconButton(
                        icon: Icon(Icons.close,
                            size: 18.sp,
                            color: Colors.white.withValues(alpha: 0.6)),
                        onPressed: () =>
                            setState(() => _stagedInvites.remove(s)),
                        tooltip: 'Remove',
                      ),
                    ],
                  ),
                )),
          ],

          // Members that already exist server-side (resumed setup).
          if (_invitedMembers.isNotEmpty) ...[
            SizedBox(height: 24.h),
            Text(
              'Already invited',
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
                        backgroundColor:
                            const Color(0xFF4E03D0).withValues(alpha: 0.3),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
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
        border:
            Border.all(color: const Color(0xFF4E03D0).withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: const Color(0xFF4E03D0).withValues(alpha: 0.2),
            backgroundImage: user.profilePicture.isNotEmpty
                ? NetworkImage(user.profilePicture)
                : null,
            child: user.profilePicture.isEmpty
                ? Text(
                    user.initials,
                    style: TextStyle(
                      color: const Color(0xFF4E03D0),
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
    // Checked against BOTH lists. Someone already invited server-side (a
    // resumed setup) and someone staged in this session are both duplicates —
    // and staging the same person twice would send two invitations on submit.
    final lower = username.toLowerCase();
    final alreadyInvited =
        _invitedMembers.any((m) => m.username?.toLowerCase() == lower) ||
            _stagedInvites.any((s) => s.username.toLowerCase() == lower);
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
          (m) =>
              m.username?.toLowerCase() == username.toLowerCase() &&
              (m.isActive || m.isPending),
        ) ??
        false;
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

    final dailyLimit =
        (double.tryParse(_inviteDailyLimitController.text) ?? 0.0)
            .clamp(0.0, double.infinity);
    final monthlyLimit =
        (double.tryParse(_inviteMonthlyLimitController.text) ?? 0.0)
            .clamp(0.0, double.infinity);

    // STAGE, do not send.
    //
    // This used to call _cubit.addMember() immediately, so tapping the button
    // dispatched a real invitation before the wizard had been submitted — the
    // person was notified, appeared as PENDING, and stayed a member of an
    // account whose setup the creator might still abandon. Invitations now go
    // out once, from _activateAccount, after the whole setup is confirmed.
    setState(() {
      _stagedInvites.add(_StagedInvite(
        username: username,
        displayName: _selectedUser?.fullName ?? username,
        avatarUrl: _selectedUser?.profilePicture,
        dailyLimit: dailyLimit,
        monthlyLimit: monthlyLimit,
      ));
      // Clear the picker so the next person can be added without extra taps —
      // the whole point of staging is that several go in before submit.
      _selectedUser = null;
      _usernameController.clear();
      _inviteDailyLimitController.clear();
      _inviteMonthlyLimitController.clear();
    });
  }

  /// Send every staged invitation, then report what failed.
  ///
  /// Sequential rather than concurrent: each invite is a write against the same
  /// family row, and the server takes a row lock per call. Firing them in
  /// parallel would just queue on that lock while making the failure attribution
  /// harder — with a handful of members the wall-clock difference is nil.
  ///
  /// A failure does NOT abort the rest: the creator has already confirmed the
  /// whole setup, and stopping halfway would leave some people invited and
  /// others silently dropped with no record of which.
  Future<List<String>> _sendStagedInvites() async {
    final failed = <String>[];
    for (final invite in _stagedInvites) {
      try {
        await _cubit.addMemberAwaitable(
          familyId: widget.familyId,
          invitationMethod: 'username',
          invitationDestination: invite.username,
          initialAllocation: 0.0,
          dailyLimit: invite.dailyLimit,
          monthlyLimit: invite.monthlyLimit,
          perTransactionLimit: 0.0,
          allocationPercentageCap: 100.0,
          role: 'member',
        );
      } catch (_) {
        failed.add(invite.username);
      }
    }
    return failed;
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
              color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.rocket_launch_outlined,
              size: 40.sp,
              color: const Color(0xFF4E03D0),
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
                  '${CurrencySymbols.currentSymbol}${(_familyAccount?.totalBalance ?? 0).toStringAsFixed(2)}',
                ),
                SizedBox(height: 16.h),
                _buildSummaryRow(
                  'Active Members',
                  '${_familyAccount?.activeMemberCount ?? 0}',
                ),
                // Already sent (a resumed setup) and about-to-be-sent are
                // different facts and are counted separately. Folding the
                // staged ones into "Pending Invitations" would tell the creator
                // invitations exist that have not left the device yet.
                if (_invitedMembers.isNotEmpty) ...[
                  SizedBox(height: 16.h),
                  _buildSummaryRow(
                    'Pending Invitations',
                    '${_invitedMembers.length}',
                  ),
                ],
                if (_stagedInvites.isNotEmpty) ...[
                  SizedBox(height: 16.h),
                  _buildSummaryRow(
                    'Will be invited',
                    '${_stagedInvites.length}',
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
                colors: [Color(0xFF4E03D0), Color(0xFF7C3AED)],
              ),
              borderRadius: BorderRadius.circular(28.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.4),
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
                      ? LazerVaultLoader.small()
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
        color: const Color(0xFF4E03D0).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF4E03D0), size: 24.sp),
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
          colors: [Color(0xFF4E03D0), Color(0xFF7C3AED)],
        ),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4E03D0).withValues(alpha: 0.4),
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

/// A person chosen during setup who has NOT been contacted yet.
///
/// Invitations used to fire the moment the button was tapped, so someone was
/// notified — and became a PENDING member of the account — before the creator
/// had finished, or even committed to, the setup. Abandoning the wizard left
/// real invitations out in the world for an account that was never configured.
///
/// These are held locally and sent once, from _activateAccount.
class _StagedInvite {
  final String username;
  final String displayName;
  final String? avatarUrl;
  final double dailyLimit;
  final double monthlyLimit;

  const _StagedInvite({
    required this.username,
    required this.displayName,
    this.avatarUrl,
    this.dailyLimit = 0.0,
    this.monthlyLimit = 0.0,
  });
}
