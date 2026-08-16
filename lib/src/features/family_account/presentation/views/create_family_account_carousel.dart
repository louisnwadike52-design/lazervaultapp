import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/username_search_bottom_sheet.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';

/// One member the user has queued to invite while creating the account.
/// [allocation] rides on the invitation and is only applied once the invitee
/// accepts — money never sits in a non-member's balance.
class _DraftMember {
  final UserSearchResultEntity user;
  double allocation = 0;
  double dailyLimit = 0;
  double monthlyLimit = 0;

  _DraftMember(this.user);
}

/// Consolidated invoice-style flow that creates a Family & Friends account,
/// funds the shared pool immediately, invites multiple members at once, and
/// activates — all in a single submit pipeline.
///
/// Replaces the old two-wizard flow (setup + activation). See
/// [FamilyActivationSetupScreen] which remains only for resuming a
/// pending-setup account.
class CreateFamilyAccountCarousel extends StatefulWidget {
  const CreateFamilyAccountCarousel({super.key});

  @override
  State<CreateFamilyAccountCarousel> createState() => _CreateFamilyAccountCarouselState();
}

class _CreateFamilyAccountCarouselState extends State<CreateFamilyAccountCarousel> {
  final FamilyAccountCubit _cubit = serviceLocator<FamilyAccountCubit>();
  final PageController _pageController = PageController();

  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _card = Color(0xFF1F1F1F);
  static const Color _border = Color(0xFF2D2D2D);
  static const Color _muted = Color(0xFF9CA3AF);
  static const Color _blue = Color(0xFF3B82F6);
  static const Color _purple = Color.fromARGB(255, 78, 3, 208);

  int _currentPage = 0;
  final int _totalPages = 3;
  final List<String> _pageNames = ['Details & Funding', 'Add Members', 'Review'];

  // Step 1
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _fundingController = TextEditingController();
  bool _allowMemberContributions = true;
  late String _currency;

  // Step 2
  final List<_DraftMember> _draftMembers = [];

  // Step 3
  FundDistributionMode _mode = FundDistributionMode.sharedPool;
  // Who may fund the pool: any_member (default) | creator_only | specific_members.
  String _fundingPolicy = 'any_member';
  // Draft members (by username) allowed to fund when policy == specific_members.
  // Mapped to real member ids after the add-member loop at submit time.
  final Set<String> _specificContributorUsernames = {};

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _currency = serviceLocator<LocaleManager>().currentCurrency;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _descController.dispose();
    _fundingController.dispose();
    super.dispose();
  }

  double get _funding => double.tryParse(_fundingController.text.trim()) ?? 0;
  double get _totalAllocated =>
      _draftMembers.fold(0.0, (sum, m) => sum + m.allocation);

  // ─── Navigation ────────────────────────────────────────────────────

  void _goToPage(int page) {
    setState(() => _currentPage = page);
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onContinue() {
    if (_isSubmitting) return;
    // Per-step validation.
    if (_currentPage == 0) {
      final name = _nameController.text.trim();
      if (name.isEmpty) {
        _snack('Please enter an account name', isError: true);
        return;
      }
      if (name.length < 3) {
        _snack('Name must be at least 3 characters', isError: true);
        return;
      }
      if (_fundingController.text.trim().isNotEmpty &&
          double.tryParse(_fundingController.text.trim()) == null) {
        _snack('Enter a valid funding amount', isError: true);
        return;
      }
    }
    // On the members/allocation step, block advancing while the total
    // allocation exceeds the funded pool — surface a modal rather than a
    // silent inline hint (the user asked for an explicit acknowledgement).
    if (_currentPage == 1 && _funding > 0 && _totalAllocated > _funding) {
      _showAllocationErrorDialog(
          'The total allocated to members (${CurrencySymbols.currentSymbol}${_totalAllocated.toStringAsFixed(2)}) exceeds the pool funding (${CurrencySymbols.currentSymbol}${_funding.toStringAsFixed(2)}). Top up the funding or lower the allocations before continuing.');
      return;
    }
    if (_currentPage < _totalPages - 1) {
      _goToPage(_currentPage + 1);
    } else {
      _submit();
    }
  }

  /// Modal shown when member allocations exceed the funded pool. Preferred
  /// over the inline hint alone so the user must acknowledge before retrying.
  void _showAllocationErrorDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _card,
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
                color: _muted,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onBack() {
    if (_isSubmitting) return;
    if (_currentPage > 0) {
      _goToPage(_currentPage - 1);
    } else {
      Get.back();
    }
  }

  // ─── Submit pipeline ───────────────────────────────────────────────

  /// Bridges a fire-and-forget cubit call to an awaitable result. Listens
  /// for the first state matching [match], fires [trigger], and resolves.
  /// Cancels immediately so intermediate emissions of later steps can't
  /// resolve an earlier step (the cubit is a shared singleton).
  Future<FamilyAccountState> _awaitNext(
    bool Function(FamilyAccountState) match,
    void Function() trigger, {
    Duration timeout = const Duration(seconds: 30),
  }) {
    final completer = Completer<FamilyAccountState>();
    late final StreamSubscription<FamilyAccountState> sub;
    sub = _cubit.stream.where(match).listen((s) {
      if (!completer.isCompleted) completer.complete(s);
      sub.cancel();
    });
    trigger();
    return completer.future.timeout(
      timeout,
      onTimeout: () {
        sub.cancel();
        return const FamilyAccountError('Request timed out. Please try again.');
      },
    );
  }

  Future<void> _submit() async {
    setState(() => _isSubmitting = true);
    final funding = _funding;

    // 1) Create the account (funds the pool with real money immediately).
    final created = await _awaitNext(
      (s) => s is FamilyAccountCreated || s is FamilyAccountError,
      () => _cubit.createAccount(
        name: _nameController.text.trim(),
        description: _descController.text.trim().isEmpty
            ? null
            : _descController.text.trim(),
        initialCurrency: _currency,
        initialFunding: funding,
        allowMemberContributions: _allowMemberContributions,
      ),
    );

    if (created is! FamilyAccountCreated) {
      if (mounted) setState(() => _isSubmitting = false);
      _snack(
        created is FamilyAccountError
            ? created.message
            : 'Could not create the account. Please try again.',
        isError: true,
      );
      return;
    }

    final account = created.familyAccount;
    final familyId = account.id;

    // Money-safety: funding requested but the pool is still 0 (e.g. wallet
    // short) — surface a non-blocking hint and continue.
    if (funding > 0 && account.totalPoolBalance == 0) {
      _snack(
        'Account created. We couldn\'t move your initial '
        '${CurrencySymbols.currentSymbol}${funding.toStringAsFixed(2)} — add funds anytime from the account.',
        isError: false,
        warning: true,
      );
    }

    // 2) Invite each queued member (invite-only; no money moves now — the
    //    per-member allocation is stored on the invite and applied on accept).
    //    Capture the created member id per username so specific_members funding
    //    can be mapped to real ids at setup.
    final failed = <String>[];
    final addedMemberIdByUsername = <String, String>{};
    for (final m in _draftMembers) {
      final res = await _awaitNext(
        (s) => s is FamilyMemberAdded || s is FamilyAccountError,
        () => _cubit.addMember(
          familyId: familyId,
          invitationMethod: 'username',
          invitationDestination: m.user.username,
          initialAllocation: m.allocation,
          dailyLimit: m.dailyLimit,
          monthlyLimit: m.monthlyLimit,
          perTransactionLimit: 0,
          allocationPercentageCap: 100,
          role: 'member',
          displayName: m.user.fullName.trim().isEmpty ? null : m.user.fullName.trim(),
        ),
        timeout: const Duration(seconds: 20),
      );
      if (res is FamilyMemberAdded) {
        addedMemberIdByUsername[m.user.username] = res.member.id;
      } else {
        failed.add(m.user.username);
      }
    }

    // 3) Activate the account with the chosen distribution mode + funding policy.
    //    Allocations only apply to active members (just the creator now), so pass
    //    none. For specific_members, map the selected usernames to the real member
    //    ids just created (skips any that failed to invite).
    final specificMemberIds = _fundingPolicy == 'specific_members'
        ? _specificContributorUsernames
            .map((u) => addedMemberIdByUsername[u])
            .whereType<String>()
            .toList()
        : const <String>[];
    await _awaitNext(
      (s) => s is FamilyAccountSetupCompleted || s is FamilyAccountError,
      () => _cubit.setupAccount(
        familyId: familyId,
        fundDistributionMode: _mode.value,
        spendingVisibilityEnabled: true,
        allocations: const [],
        fundingPolicy: _fundingPolicy,
        specificMemberIds: specificMemberIds,
      ),
    );

    _cubit.reset();

    if (!mounted) return;

    // Refresh the wallet carousel so the new family card appears.
    try {
      final accountsCubit = context.read<AccountCardsSummaryCubit>();
      if (accountsCubit.currentUserId != null) {
        accountsCubit.fetchAccountSummaries(userId: accountsCubit.currentUserId!);
      }
    } catch (_) {
      // Non-fatal: dashboard refreshes on return regardless.
    }

    if (failed.isNotEmpty) {
      _snack(
        'Account created. Couldn\'t invite: ${failed.join(', ')}. Add them later from the account.',
        isError: false,
        warning: true,
      );
    } else {
      _snack('"${account.name}" created!', isError: false);
    }

    Get.offNamed(AppRoutes.familyDetails, arguments: {'familyId': familyId});
  }

  // ─── Snackbar ──────────────────────────────────────────────────────

  void _snack(String message, {required bool isError, bool warning = false}) {
    if (!mounted) return;
    final color = isError
        ? const Color(0xFFEF4444)
        : (warning ? const Color(0xFFFB923C) : const Color(0xFF10B981));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontSize: 14.sp, color: Colors.white)),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: warning ? 5 : 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        margin: EdgeInsets.all(16.w),
      ),
    );
  }

  // ─── Build ─────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildProgressIndicators(),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (page) => setState(() => _currentPage = page),
              children: [
                _buildDetailsStep(),
                _buildMembersStep(),
                _buildReviewStep(),
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
      backgroundColor: _bg,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
        onPressed: _onBack,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Family & Friends',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Text(
            'Step ${_currentPage + 1} of $_totalPages · ${_pageNames[_currentPage]}',
            style: TextStyle(fontSize: 12.sp, color: _muted),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.close, color: Colors.white, size: 24.sp),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }

  Widget _buildProgressIndicators() {
    final isLast = _currentPage == _totalPages - 1;
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
                    colors: isLast
                        ? [Colors.green, Colors.green.shade700]
                        : [_blue, _purple],
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
                      ? _blue
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
    final isLast = _currentPage == _totalPages - 1;
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: _bg,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (_currentPage > 0) ...[
              Expanded(
                child: GestureDetector(
                  onTap: _isSubmitting ? null : _onBack,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      color: _card,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
            ],
            Expanded(
              child: GestureDetector(
                onTap: _isSubmitting ? null : _onContinue,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [_blue, _purple]),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: _blue.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isLast && _isSubmitting) ...[
                          LazerVaultLoader.small(),
                          SizedBox(width: 8.w),
                        ],
                        Text(
                          isLast
                              ? (_isSubmitting ? 'Creating...' : 'Create & Activate')
                              : 'Continue',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        if (!isLast) ...[
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

  // ─── Step 1: Details & Funding ─────────────────────────────────────

  Widget _buildDetailsStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Account details', 'Name your shared account and fund it to get started.'),
          SizedBox(height: 20.h),
          _fieldLabel('Account name'),
          SizedBox(height: 8.h),
          _textField(
            controller: _nameController,
            hint: 'e.g. Smith Family, Vacation Fund',
            maxLength: 50,
          ),
          SizedBox(height: 20.h),
          _fieldLabel('Description (optional)'),
          SizedBox(height: 8.h),
          _textField(
            controller: _descController,
            hint: 'What is this account for?',
            maxLines: 2,
          ),
          SizedBox(height: 20.h),
          _fieldLabel('Initial funding (optional)'),
          SizedBox(height: 8.h),
          _textField(
            controller: _fundingController,
            hint: '0.00',
            prefix: '${CurrencySymbols.currentSymbol} ',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
            onChanged: (_) => setState(() {}),
          ),
          SizedBox(height: 6.h),
          Text(
            'Funds move from your wallet into the shared pool right away.',
            style: TextStyle(color: _muted, fontSize: 11.sp),
          ),
          SizedBox(height: 20.h),
          _toggleCard(
            title: 'Allow member contributions',
            subtitle: 'Let members add their own money to the pool',
            value: _allowMemberContributions,
            onChanged: (v) => setState(() => _allowMemberContributions = v),
          ),
        ],
      ),
    );
  }

  // ─── Step 2: Add members (multiple) ────────────────────────────────

  Widget _buildMembersStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Add members',
              'Invite Lazervault users. Each member\'s amount is applied when they accept.'),
          SizedBox(height: 20.h),
          if (_draftMembers.isEmpty)
            _emptyMembersCard()
          else
            ..._draftMembers.asMap().entries.map((e) => _memberCard(e.key, e.value)),
          SizedBox(height: 12.h),
          _addMemberButton(),
          if (_draftMembers.isNotEmpty) ...[
            SizedBox(height: 20.h),
            _membersSummaryCard(),
          ],
        ],
      ),
    );
  }

  Widget _emptyMembersCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _border),
      ),
      child: Column(
        children: [
          Icon(Icons.group_add_outlined, color: _muted, size: 36.sp),
          SizedBox(height: 10.h),
          Text('No members yet',
              style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 4.h),
          Text(
            'You can add members now or invite them later.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _muted, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _memberCard(int index, _DraftMember m) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: _blue.withValues(alpha: 0.2),
            backgroundImage:
                m.user.profilePicture.isNotEmpty ? NetworkImage(m.user.profilePicture) : null,
            child: m.user.profilePicture.isEmpty
                ? Text(
                    m.user.initials,
                    style: TextStyle(
                        color: _blue, fontSize: 14.sp, fontWeight: FontWeight.bold),
                  )
                : null,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  m.user.fullName.trim().isEmpty ? m.user.username : m.user.fullName,
                  style: TextStyle(
                      color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  m.allocation > 0
                      ? '@${m.user.username} · ${CurrencySymbols.currentSymbol}${m.allocation.toStringAsFixed(2)}'
                      : '@${m.user.username}',
                  style: TextStyle(color: _muted, fontSize: 12.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit_outlined, color: _blue, size: 20.sp),
            onPressed: () => _showMemberEditor(existing: m),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444)),
            iconSize: 20.sp,
            onPressed: () => setState(() => _draftMembers.removeAt(index)),
          ),
        ],
      ),
    );
  }

  Widget _addMemberButton() {
    return GestureDetector(
      onTap: _onAddMember,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _blue.withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, color: _blue, size: 22.sp),
            SizedBox(width: 8.w),
            Text('Add member',
                style: TextStyle(
                    color: _blue, fontSize: 15.sp, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  Widget _membersSummaryCard() {
    final over = _funding > 0 && _totalAllocated > _funding;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: over ? const Color(0xFFEF4444).withValues(alpha: 0.5) : _border),
      ),
      child: Column(
        children: [
          _summaryRow('Members to invite', '${_draftMembers.length}'),
          SizedBox(height: 8.h),
          _summaryRow('Total allocated',
              '${CurrencySymbols.currentSymbol}${_totalAllocated.toStringAsFixed(2)}'),
          if (over) ...[
            SizedBox(height: 8.h),
            Text(
              'Allocated amount exceeds the pool — top up funding or lower allocations.',
              style: const TextStyle(color: Color(0xFFEF4444), fontWeight: FontWeight.w500)
                  .copyWith(fontSize: 11.sp),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _onAddMember() async {
    final user = await UsernameSearchBottomSheet.show(context);
    if (user == null) return;
    if (!user.isLazervaultUser) {
      _snack('Only Lazervault users can be invited', isError: false, warning: true);
      return;
    }
    final dup = _draftMembers.any((m) =>
        (m.user.userId.isNotEmpty && m.user.userId == user.userId) ||
        m.user.username.toLowerCase() == user.username.toLowerCase());
    if (dup) {
      _snack('${user.username} is already added', isError: false, warning: true);
      return;
    }
    final draft = _DraftMember(user);
    setState(() => _draftMembers.add(draft));
    // Offer to set an optional allocation / limits straight away.
    _showMemberEditor(existing: draft);
  }

  /// Bottom-sheet editor for a queued member's optional allocation + limits.
  void _showMemberEditor({required _DraftMember existing}) {
    final allocationCtrl = TextEditingController(
        text: existing.allocation > 0 ? existing.allocation.toStringAsFixed(2) : '');
    final dailyCtrl = TextEditingController(
        text: existing.dailyLimit > 0 ? existing.dailyLimit.toStringAsFixed(2) : '');
    final monthlyCtrl = TextEditingController(
        text: existing.monthlyLimit > 0 ? existing.monthlyLimit.toStringAsFixed(2) : '');

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                existing.user.fullName.trim().isEmpty
                    ? '@${existing.user.username}'
                    : existing.user.fullName,
                style: TextStyle(
                    color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 4.h),
              Text('Optional — applied when they accept the invite',
                  style: TextStyle(color: _muted, fontSize: 12.sp)),
              SizedBox(height: 20.h),
              _fieldLabel('Allocation'),
              SizedBox(height: 8.h),
              _textField(
                controller: allocationCtrl,
                hint: '0.00',
                prefix: '${CurrencySymbols.currentSymbol} ',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _fieldLabel('Daily limit'),
                        SizedBox(height: 8.h),
                        _textField(
                          controller: dailyCtrl,
                          hint: '0 = none',
                          prefix: '${CurrencySymbols.currentSymbol} ',
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _fieldLabel('Monthly limit'),
                        SizedBox(height: 8.h),
                        _textField(
                          controller: monthlyCtrl,
                          hint: '0 = none',
                          prefix: '${CurrencySymbols.currentSymbol} ',
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      existing.allocation =
                          (double.tryParse(allocationCtrl.text.trim()) ?? 0).clamp(0, double.infinity);
                      existing.dailyLimit =
                          (double.tryParse(dailyCtrl.text.trim()) ?? 0).clamp(0, double.infinity);
                      existing.monthlyLimit =
                          (double.tryParse(monthlyCtrl.text.trim()) ?? 0).clamp(0, double.infinity);
                    });
                    Navigator.of(ctx).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text('Save',
                      style: TextStyle(
                          color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(() {
      allocationCtrl.dispose();
      dailyCtrl.dispose();
      monthlyCtrl.dispose();
    });
  }

  // ─── Step 3: Distribution & Review ─────────────────────────────────

  Widget _buildReviewStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Distribution', 'How should the pool be shared among members?'),
          SizedBox(height: 16.h),
          ...FundDistributionMode.values.map(_modeCard),
          // Who-can-fund selector. Only meaningful when member contributions are
          // allowed — otherwise only the creator can fund regardless of policy.
          if (_allowMemberContributions) ...[
            SizedBox(height: 24.h),
            _sectionTitle('Who can fund the pool', 'Choose who is allowed to add money.'),
            SizedBox(height: 16.h),
            _fundingPolicyCard('any_member', 'Any member',
                'Every member can add money to the pool.', Icons.groups),
            _fundingPolicyCard('creator_only', 'Only me',
                'Only you (the creator) can add money to the pool.', Icons.person),
            _fundingPolicyCard('specific_members', 'Specific members',
                'Only members you pick can add money.', Icons.checklist),
            if (_fundingPolicy == 'specific_members') _specificContributorsPicker(),
          ],
          SizedBox(height: 24.h),
          _sectionTitle('Review', 'Confirm and create your account.'),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: _border),
            ),
            child: Column(
              children: [
                _summaryRow('Name', _nameController.text.trim().isEmpty
                    ? '—'
                    : _nameController.text.trim()),
                SizedBox(height: 10.h),
                _summaryRow('Initial funding',
                    '${CurrencySymbols.currentSymbol}${_funding.toStringAsFixed(2)}'),
                SizedBox(height: 10.h),
                _summaryRow('Members to invite', '${_draftMembers.length}'),
                SizedBox(height: 10.h),
                _summaryRow('Distribution', _mode.displayName),
                SizedBox(height: 10.h),
                _summaryRow('Member contributions',
                    _allowMemberContributions ? 'Allowed' : 'Off'),
                if (_allowMemberContributions) ...[
                  SizedBox(height: 10.h),
                  _summaryRow('Who can fund', _fundingPolicyLabel()),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _modeCard(FundDistributionMode mode) {
    final selected = _mode == mode;
    final icon = switch (mode) {
      FundDistributionMode.sharedPool => Icons.group,
      FundDistributionMode.equalSplit => Icons.balance,
      FundDistributionMode.customAllocation => Icons.tune,
    };
    return GestureDetector(
      onTap: () => setState(() => _mode = mode),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: selected ? _blue : _border, width: selected ? 2 : 1),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: selected ? _blue.withValues(alpha: 0.2) : _border,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: selected ? _blue : _muted, size: 22.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mode.displayName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 3.h),
                  Text(mode.description,
                      style: TextStyle(color: _muted, fontSize: 11.sp, height: 1.3)),
                ],
              ),
            ),
            if (selected) Icon(Icons.check_circle, color: _blue, size: 22.sp),
          ],
        ),
      ),
    );
  }

  String _fundingPolicyLabel() {
    switch (_fundingPolicy) {
      case 'creator_only':
        return 'Only me';
      case 'specific_members':
        final n = _specificContributorUsernames.length;
        return 'Specific members ($n)';
      default:
        return 'Any member';
    }
  }

  Widget _fundingPolicyCard(
      String value, String title, String desc, IconData icon) {
    final selected = _fundingPolicy == value;
    return GestureDetector(
      onTap: () => setState(() => _fundingPolicy = value),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: selected ? _blue : _border, width: selected ? 2 : 1),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: selected ? _blue.withValues(alpha: 0.2) : _border,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: selected ? _blue : _muted, size: 22.sp),
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
                      style: TextStyle(color: _muted, fontSize: 11.sp, height: 1.3)),
                ],
              ),
            ),
            if (selected) Icon(Icons.check_circle, color: _blue, size: 22.sp),
          ],
        ),
      ),
    );
  }

  /// Checklist of invited members that may fund the pool (specific_members).
  /// The creator can always fund, so they're not listed. Invited members are
  /// pending until they accept — the permission applies once they do.
  Widget _specificContributorsPicker() {
    if (_draftMembers.isEmpty) {
      return Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _border),
        ),
        child: Text(
          'Add members on the previous step to choose who can fund. Until then, only you can fund the pool.',
          style: TextStyle(color: _muted, fontSize: 12.sp, height: 1.4),
        ),
      );
    }
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _border),
      ),
      child: Column(
        children: [
          for (final m in _draftMembers)
            _contributorCheckTile(m),
        ],
      ),
    );
  }

  Widget _contributorCheckTile(_DraftMember m) {
    final username = m.user.username;
    final checked = _specificContributorUsernames.contains(username);
    final name = m.user.fullName.trim().isEmpty ? '@$username' : m.user.fullName.trim();
    return InkWell(
      onTap: () => setState(() {
        if (checked) {
          _specificContributorUsernames.remove(username);
        } else {
          _specificContributorUsernames.add(username);
        }
      }),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        child: Row(
          children: [
            Icon(
              checked ? Icons.check_box : Icons.check_box_outline_blank,
              color: checked ? _blue : _muted,
              size: 20.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 14.sp)),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Shared small widgets ──────────────────────────────────────────

  Widget _sectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 6.h),
        Text(subtitle, style: TextStyle(color: _muted, fontSize: 13.sp, height: 1.4)),
      ],
    );
  }

  Widget _fieldLabel(String label) => Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600),
      );

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: _muted, fontSize: 13.sp)),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
                color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _toggleCard({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 3.h),
                Text(subtitle, style: TextStyle(color: _muted, fontSize: 12.sp)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: _blue,
          ),
        ],
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    String? hint,
    String? prefix,
    int maxLines = 1,
    int? maxLength,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onChanged,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      style: TextStyle(color: Colors.white, fontSize: 15.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: _muted.withValues(alpha: 0.7), fontSize: 14.sp),
        prefixText: prefix,
        prefixStyle: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600),
        counterText: '',
        filled: true,
        fillColor: _bg,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: _border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: _blue, width: 2),
        ),
      ),
    );
  }
}
