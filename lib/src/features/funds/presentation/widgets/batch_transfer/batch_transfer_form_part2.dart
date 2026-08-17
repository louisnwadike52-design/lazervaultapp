part of 'batch_transfer_form.dart';

class _MultiSelectRecipientBottomSheetState extends State<MultiSelectRecipientBottomSheet>
    with SingleTickerProviderStateMixin {
  final List<RecipientModel> _tempSelectedRecipients = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  late TabController _tabController;

  // Bank account tab state
  final TextEditingController _bankAccountController = TextEditingController();
  String? _selectedBankCode;
  String? _selectedBankName;
  String? _verifiedBeneficiaryName;
  // Bank code/name as returned by the account-verification backend. This is the
  // AUTHORITATIVE code Flutterwave expects for account_bank — the locally-picked
  // _selectedBankCode (static bank list) can differ for some banks and causes a
  // Flutterwave 400. We mirror the working single-transfer path which stores the
  // VERIFIED code (see add_recipient.dart: `sortCode: result.bankCode`).
  String? _verifiedBankCode;
  String? _verifiedBankName;
  bool _isBankSelected = false;
  final TextEditingController _bankAmountController = TextEditingController();

  // Current user info for self-transfer prevention
  String? _currentUserId;
  String? _currentUsername;

  // When on, any newly-entered recipient (not already a saved beneficiary) is
  // persisted to the user's beneficiaries on confirm, so it shows up under the
  // "Saved" tab + the landing-page Beneficiaries section next time.
  bool _saveAsBeneficiaries = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _searchController.addListener(_onSearchChanged);
    _loadCurrentUserInfo();
    // Warm the dynamic (Flutterwave) bank list so the picker uses codes valid
    // for transfer `account_bank`.
    serviceLocator<BankRepository>().warmUp('NG');
  }

  void _loadCurrentUserInfo() {
    try {
      final accountManager = GetIt.I<AccountManager>();
      _currentUsername = accountManager.activeAccountDetails?.accountNumber;
    } catch (_) {}
    // Defer context.read to after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      try {
        final authState = context.read<AuthenticationCubit>().state;
        if (authState is AuthenticationSuccess) {
          _currentUserId = authState.profile.user.id;
        }
      } catch (_) {}
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    _bankAccountController.dispose();
    _bankAmountController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  bool _isSelfTransfer(RecipientModel recipient) {
    if (_currentUserId != null && recipient.id == _currentUserId) return true;
    if (_currentUsername != null && recipient.accountNumber == _currentUsername) return true;
    return false;
  }

  /// Opens the shared unified search (saved contacts incl. alias → global),
  /// then toggles the picked user into the batch selection.
  Future<void> _openUnifiedSearch() async {
    final result =
        await UnifiedUserSearchSheet.show(context, title: 'Add recipient');
    if (result == null || !mounted) return;
    _toggleRecipientSelection(result.toRecipientModel());
  }

  void _toggleRecipientSelection(RecipientModel recipient) {
    // Self-transfer prevention
    if (_isSelfTransfer(recipient)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Cannot transfer to your own account',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: btTextPrimary),
          ),
          backgroundColor: btRed,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      );
      return;
    }

    setState(() {
      if (_tempSelectedRecipients.any((r) => r.id == recipient.id || r.accountNumber == recipient.accountNumber)) {
        _tempSelectedRecipients.removeWhere((r) => r.id == recipient.id || r.accountNumber == recipient.accountNumber);
      } else {
        final totalAfterAdd = widget.alreadySelectedIds.length + _tempSelectedRecipients.length + 1;
        if (totalAfterAdd > 20) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Maximum 20 recipients allowed',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: btTextPrimary),
              ),
              backgroundColor: btOrange,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
          );
          return;
        }
        _tempSelectedRecipients.add(recipient);
      }
    });
  }

  bool _isRecipientSelected(RecipientModel recipient) {
    return _tempSelectedRecipients.any((r) => r.id == recipient.id || r.accountNumber == recipient.accountNumber);
  }

  /// Persist any newly-entered recipient (one that isn't already a saved
  /// beneficiary) to the user's beneficiaries via RecipientService. Fire and
  /// forget — the cubit refreshes its list so the new beneficiary appears in
  /// the Saved tab + landing Beneficiaries section. Internal Lazervault users
  /// and external bank accounts both persist (the proto carries `type` +
  /// `internalUserId`).
  void _persistNewBeneficiaries() {
    try {
      final authState = context.read<AuthenticationCubit>().state;
      if (authState is! AuthenticationSuccess) return;
      final token = authState.profile.session.accessToken;
      final cubit = context.read<RecipientCubit>();
      for (final r in _tempSelectedRecipients) {
        if (r.isSaved) continue; // already a beneficiary
        cubit.addRecipient(
          recipient: r.copyWith(isSaved: true),
          accessToken: token,
        );
      }
    } catch (_) {
      // Saving is best-effort; the transfer itself is unaffected.
    }
  }

  bool _isAlreadyAdded(RecipientModel recipient) {
    return widget.alreadySelectedIds.contains(recipient.id) ||
        widget.alreadySelectedIds.contains(recipient.accountNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: BoxDecoration(
        color: btCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: btBorderLight,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
            child: Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: btBlue.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  child: Icon(Icons.group_add_outlined, color: btBlue, size: 22.sp),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Recipients',
                        style: GoogleFonts.inter(
                          color: btTextPrimary,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Select from saved or search new users',
                        style: GoogleFonts.inter(
                          color: btTextSecondary,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_tempSelectedRecipients.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: btBlue,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      '${_tempSelectedRecipients.length}',
                      style: GoogleFonts.inter(
                        color: btTextPrimary,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Tab bar
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: btCardElevated,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: btBlue,
                borderRadius: BorderRadius.circular(10.r),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: btTextPrimary,
              unselectedLabelColor: const Color(0xFF9CA3AF),
              labelStyle: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600),
              unselectedLabelStyle: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w500),
              labelPadding: EdgeInsets.zero,
              tabs: const [
                Tab(text: 'Saved'),
                Tab(text: 'Users'),
                Tab(text: 'Bank Acct'),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSavedRecipientsTab(),
                _buildUserSearchTab(),
                _buildBankAccountTab(),
              ],
            ),
          ),

          // Bottom actions
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: btCard,
              border: Border(top: BorderSide(color: btBorder)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Save-as-beneficiary toggle — only meaningful when at least one
                // newly-entered (unsaved) recipient is selected.
                if (_tempSelectedRecipients.any((r) => !r.isSaved))
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Row(
                      children: [
                        Icon(Icons.bookmark_added_outlined,
                            color: btBlue, size: 18.sp),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            'Save new recipients to beneficiaries',
                            style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                color: btTextPrimary,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Switch.adaptive(
                          value: _saveAsBeneficiaries,
                          activeThumbColor: btBlue,
                          onChanged: (v) =>
                              setState(() => _saveAsBeneficiaries = v),
                        ),
                      ],
                    ),
                  ),
                Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: btTextSecondary,
                      side: BorderSide(color: btBorderLight),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _tempSelectedRecipients.isEmpty ? null : () {
                      if (_saveAsBeneficiaries) _persistNewBeneficiaries();
                      final selected = List<RecipientModel>.from(_tempSelectedRecipients);
                      // Close THIS sheet first. The callback may itself open a
                      // dialog (e.g. bulk-amount when >1 recipient); if we popped
                      // after, Navigator.pop would close that new dialog instead
                      // and leave this sheet open.
                      Navigator.pop(context);
                      widget.onRecipientsSelected(selected);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _tempSelectedRecipients.isEmpty ? btBorder : btBlue,
                      foregroundColor: btTextPrimary,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Text(
                      _tempSelectedRecipients.isEmpty
                        ? 'Select Recipients'
                        : 'Add ${_tempSelectedRecipients.length} Recipient${_tempSelectedRecipients.length == 1 ? '' : 's'}',
                      style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
              ],
            ),
          ),

          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  // --- Saved Recipients Tab ---
  Widget _buildSavedRecipientsTab() {
    return Column(
      children: [
        // Search bar for saved recipients
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: btCardElevated,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TextField(
              controller: _searchController,
              style: GoogleFonts.inter(color: btTextPrimary, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'Filter saved recipients...',
                hintStyle: GoogleFonts.inter(color: btTextTertiary, fontSize: 14.sp),
                prefixIcon: Icon(Icons.search, color: btTextTertiary, size: 20.sp),
                suffixIcon: _searchQuery.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                        },
                        child: Icon(Icons.clear, color: btTextTertiary, size: 18.sp),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14.h),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Expanded(
          child: BlocBuilder<RecipientCubit, RecipientState>(
            builder: (context, state) {
              if (state is RecipientLoading) {
                return const Center(child: LazerVaultLoader.small());
              } else if (state is RecipientLoaded) {
                final filteredRecipients = _searchQuery.isEmpty
                  ? state.recipients
                  : state.recipients.where((r) =>
                      r.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                      r.accountNumber.contains(_searchQuery) ||
                      (r.email?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
                      (r.phoneNumber?.contains(_searchQuery) ?? false) ||
                      (r.alias?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)
                    ).toList();

                if (filteredRecipients.isEmpty) {
                  return _buildEmptySearchState(
                    icon: Icons.people_outline,
                    title: _searchQuery.isEmpty ? 'No saved recipients' : 'No matches found',
                    subtitle: _searchQuery.isEmpty
                        ? 'Recipients you save will appear here'
                        : 'Try the "Search Users" tab to find new users',
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: filteredRecipients.length,
                  itemBuilder: (context, index) {
                    final recipient = filteredRecipients[index];
                    final isSelected = _isRecipientSelected(recipient);
                    final isAlreadyAdded = _isAlreadyAdded(recipient);

                    return _buildRecipientItem(
                      recipient: recipient,
                      isSelected: isSelected,
                      isAlreadyAdded: isAlreadyAdded,
                      onTap: isAlreadyAdded ? null : () => _toggleRecipientSelection(recipient),
                    );
                  },
                );
              } else if (state is RecipientError) {
                return _buildErrorRetryState(
                  message: 'Failed to load recipients',
                  onRetry: _retryLoadRecipients,
                );
              }
              return const Center(child: LazerVaultLoader.small());
            },
          ),
        ),
      ],
    );
  }

  void _retryLoadRecipients() {
    try {
      final authState = context.read<AuthenticationCubit>().state;
      if (authState is AuthenticationSuccess) {
        final localeManager = serviceLocator<LocaleManager>();
        context.read<RecipientCubit>().getRecipients(
          accessToken: authState.profile.session.accessToken,
          countryCode: localeManager.currentCountry,
          currency: localeManager.currentCurrency,
        );
      }
    } catch (_) {}
  }

  // --- User Search Tab ---
  Widget _buildUserSearchTab() {
    // Uses the SAME shared UnifiedUserSearchSheet as the Send Funds flow —
    // one seamless search over saved contacts, the global directory, AND
    // members of your organizations (group accounts). Tapping the bar opens it;
    // each pick is added to the batch, so you can add several in a row.
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 4.h),
          GestureDetector(
            onTap: _openUnifiedSearch,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: btCardElevated,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: btBorder),
              ),
              child: Row(
                children: [
                  Icon(Icons.person_search_outlined,
                      color: btTextTertiary, size: 20.sp),
                  SizedBox(width: 12.w),
                  Text(
                    'Search people to add',
                    style: GoogleFonts.inter(
                        color: btTextTertiary, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Icon(Icons.groups_2_outlined,
              size: 44.sp, color: btTextTertiary.withValues(alpha: 0.6)),
          SizedBox(height: 12.h),
          Text(
            'Find recipients by name, @username, phone or email — including '
            'members of your organizations. Each person you pick is added to '
            'this batch.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                color: btTextTertiary, fontSize: 13.sp, height: 1.4),
          ),
        ],
      ),
    );
  }


  // --- Bank Account Tab ---
  Widget _buildBankAccountTab() {
    final addedBankRecipients = _tempSelectedRecipients
        .where((r) => r.type == 'external')
        .toList();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Show already-added bank recipients
          if (addedBankRecipients.isNotEmpty) ...[
            Text(
              'Added (${addedBankRecipients.length})',
              style: GoogleFonts.inter(
                color: btTextSecondary,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            ...addedBankRecipients.map((recipient) {
              return Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: btGreen.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: btGreen.withValues(alpha: 0.25)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: btGreen.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Center(
                        child: Text(
                          recipient.name.isNotEmpty
                              ? recipient.name[0].toUpperCase()
                              : '?',
                          style: GoogleFonts.inter(
                            color: btGreen,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipient.name,
                            style: GoogleFonts.inter(
                              color: btTextPrimary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              BankLogo(
                                bankName: recipient.displayBankName,
                                bankCode: recipient.sortCode,
                                size: 14,
                                borderRadius: 4,
                              ),
                              SizedBox(width: 6.w),
                              Flexible(
                                child: Text(
                                  '${recipient.displayBankName} \u2022 ${recipient.accountNumber}',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    color: btTextSecondary,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _tempSelectedRecipients.removeWhere(
                            (r) => r.id == recipient.id &&
                                r.accountNumber == recipient.accountNumber,
                          );
                        });
                      },
                      child: Container(
                        width: 28.w,
                        height: 28.w,
                        decoration: BoxDecoration(
                          color: btRed.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Icon(Icons.close, color: btRed, size: 14.sp),
                      ),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: 12.h),
            Text(
              'Add Another',
              style: GoogleFonts.inter(
                color: btTextSecondary,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
          ],

          // Bank selection
          GestureDetector(
            onTap: _showBankSelectionSheet,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: btCardElevated,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: _isBankSelected ? btGreen : btBorder),
              ),
              child: Row(
                children: [
                  Icon(
                    _isBankSelected ? Icons.account_balance : Icons.account_balance_outlined,
                    color: _isBankSelected ? btGreen : btTextTertiary,
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      _selectedBankName ?? 'Select Bank',
                      style: GoogleFonts.inter(
                        color: _isBankSelected ? btTextPrimary : btTextTertiary,
                        fontSize: 14.sp,
                        fontWeight: _isBankSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: btTextTertiary, size: 20.sp),
                ],
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Account number input
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: btCardElevated,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TextField(
              controller: _bankAccountController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              style: GoogleFonts.inter(color: btTextPrimary, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'Enter 10-digit account number',
                hintStyle: GoogleFonts.inter(color: btTextTertiary, fontSize: 14.sp),
                prefixIcon: Icon(Icons.numbers, color: btTextTertiary, size: 20.sp),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              onChanged: (value) {
                if (value.length == 10 && _isBankSelected) {
                  _verifyBankAccount();
                } else {
                  setState(() {
                    _verifiedBeneficiaryName = null;
                    _verifiedBankCode = null;
                    _verifiedBankName = null;
                  });
                }
              },
            ),
          ),

          SizedBox(height: 12.h),

          // Verify button
          if (_isBankSelected && _bankAccountController.text.length == 10)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _verifyBankAccount,
                icon: Icon(Icons.verified_user_outlined, size: 16.sp),
                label: Text('Verify Account',
                    style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: btBlue,
                  side: const BorderSide(color: btBlue),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
            ),

          SizedBox(height: 12.h),

          // Verification result
          BlocBuilder<AccountVerificationCubit, AccountVerificationState>(
            builder: (context, state) {
              if (state is AccountVerificationLoading) {
                return Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: btBlue.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      LazerVaultLoader.tiny(),
                      SizedBox(width: 12.w),
                      Text('Verifying account...',
                          style: GoogleFonts.inter(color: btTextSecondary, fontSize: 13.sp)),
                    ],
                  ),
                );
              }

              if (state is AccountVerificationSuccess) {
                _verifiedBeneficiaryName = state.accountName;
                // Capture the verified (authoritative) bank code/name to send to
                // the backend, not the locally-picked static code.
                _verifiedBankCode = state.bankCode;
                _verifiedBankName = state.bankName;
                return Column(
                  children: [
                    // Verified beneficiary name
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: btGreen.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: btGreen.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: btGreen, size: 20.sp),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Account Verified',
                                    style: GoogleFonts.inter(
                                        color: btGreen, fontSize: 12.sp, fontWeight: FontWeight.w600)),
                                SizedBox(height: 2.h),
                                Text(state.accountName,
                                    style: GoogleFonts.inter(
                                        color: btTextPrimary, fontSize: 15.sp, fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Add as recipient button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _addBankAccountRecipient,
                        icon: Icon(Icons.person_add, size: 18.sp),
                        label: Text('Add Recipient',
                            style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: btBlue,
                          foregroundColor: btTextPrimary,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        ),
                      ),
                    ),
                  ],
                );
              }

              if (state is AccountVerificationFailure) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: btRed.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: btRed.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: btRed, size: 20.sp),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(state.userMessage,
                            style: GoogleFonts.inter(color: btRed, fontSize: 13.sp)),
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),

          SizedBox(height: 20.h),

          // Instructions
          if (!_isBankSelected || _bankAccountController.text.isEmpty)
            _buildEmptySearchState(
              icon: Icons.account_balance_outlined,
              title: 'Add Bank Account',
              subtitle: 'Select a bank and enter an account number\nto add an external recipient',
            ),
        ],
      ),
    );
  }

  Future<void> _showBankSelectionSheet() async {
    // Reuse the shared bank picker (same one send-funds / add-recipient use):
    // it loads the REAL bank list from the backend (static list first, then
    // refreshes) and renders each with its BankLogo. Dark theme to match this
    // dark-surfaced batch sheet.
    final bank = await BankPickerSheet.show(
      context,
      country: 'NG',
      selectedBankCode: _selectedBankCode,
      theme: BankPickerTheme.dark(),
    );
    if (bank == null || !mounted) return;
    setState(() {
      _selectedBankCode = bank['code'];
      _selectedBankName = bank['name'];
      _isBankSelected = true;
      _verifiedBeneficiaryName = null;
      _verifiedBankCode = null;
      _verifiedBankName = null;
    });
    try {
      context.read<AccountVerificationCubit>().reset();
    } catch (_) {}
    // Auto-verify if the account number is already entered.
    if (_bankAccountController.text.length == 10) {
      _verifyBankAccount();
    }
  }

  void _verifyBankAccount() {
    if (_selectedBankCode == null || _bankAccountController.text.length != 10) return;
    try {
      context.read<AccountVerificationCubit>().verifyAccount(
        bankCode: _selectedBankCode!,
        accountNumber: _bankAccountController.text,
        bankName: _selectedBankName ?? '',
      );
    } catch (_) {}
  }

  void _addBankAccountRecipient() {
    if (_verifiedBeneficiaryName == null || _selectedBankCode == null) return;

    // Prefer the VERIFIED bank code/name (what Flutterwave's account_bank
    // expects); fall back to the locally-picked values only if verification
    // didn't return them.
    final effectiveBankCode = (_verifiedBankCode != null && _verifiedBankCode!.isNotEmpty)
        ? _verifiedBankCode!
        : (_selectedBankCode ?? '');
    final effectiveBankName = (_verifiedBankName != null && _verifiedBankName!.isNotEmpty)
        ? _verifiedBankName!
        : (_selectedBankName ?? '');

    final recipient = RecipientModel(
      id: '${effectiveBankCode}_${_bankAccountController.text}',
      name: _verifiedBeneficiaryName!,
      accountNumber: _bankAccountController.text,
      bankName: effectiveBankName,
      sortCode: effectiveBankCode,
      isFavorite: false,
      isSaved: false,
      type: 'external',
    );

    // Check if already selected
    if (_tempSelectedRecipients.any((r) => r.accountNumber == recipient.accountNumber &&
        r.sortCode == recipient.sortCode)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('This account is already added',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: btTextPrimary)),
          backgroundColor: btOrange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      );
      return;
    }

    setState(() {
      _tempSelectedRecipients.add(recipient);
      // Reset form for next entry
      _bankAccountController.clear();
      _verifiedBeneficiaryName = null;
      _verifiedBankCode = null;
      _verifiedBankName = null;
    });

    try {
      context.read<AccountVerificationCubit>().reset();
    } catch (_) {}

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${recipient.name} added',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: btTextPrimary)),
        backgroundColor: btGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    );
  }

  Widget _buildEmptySearchState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: btBorder.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Icon(icon, color: btTextTertiary, size: 32.sp),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: GoogleFonts.inter(color: btTextSecondary, fontSize: 15.sp, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6.h),
          Text(
            subtitle,
            style: GoogleFonts.inter(color: btTextTertiary, fontSize: 13.sp),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorRetryState({
    required String message,
    required VoidCallback onRetry,
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: btRed.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Icon(Icons.error_outline, color: btRed, size: 32.sp),
          ),
          SizedBox(height: 16.h),
          Text(
            message,
            style: GoogleFonts.inter(color: btTextSecondary, fontSize: 15.sp, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: onRetry,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: btBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh, color: btBlue, size: 16.sp),
                  SizedBox(width: 6.w),
                  Text(
                    'Retry',
                    style: GoogleFonts.inter(
                      color: btBlue,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
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

  Widget _buildRecipientItem({
    required RecipientModel recipient,
    required bool isSelected,
    required bool isAlreadyAdded,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: isSelected
                ? btBlue.withValues(alpha: 0.1)
                : isAlreadyAdded
                  ? btBorder.withValues(alpha: 0.3)
                  : btBackground,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected ? btBlue : btBorder,
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: isAlreadyAdded
                      ? btBorder
                      : btBlue.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  child: Center(
                    child: Text(
                      recipient.name.isNotEmpty
                        ? recipient.name.substring(0, 1).toUpperCase()
                        : '?',
                      style: GoogleFonts.inter(
                        color: isAlreadyAdded ? btTextTertiary : btBlue,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipient.name,
                        style: GoogleFonts.inter(
                          color: isAlreadyAdded ? btTextTertiary : btTextPrimary,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          BankLogo(
                            bankName: recipient.bankName,
                            bankCode: recipient.sortCode,
                            size: 14,
                            borderRadius: 4,
                          ),
                          SizedBox(width: 6.w),
                          Flexible(
                            child: Text(
                              '${recipient.displayBankName} \u2022 ${recipient.accountNumber.length > 4 ? '\u2022\u2022\u2022 ${recipient.accountNumber.substring(recipient.accountNumber.length - 4)}' : recipient.accountNumber}',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                color: isAlreadyAdded ? btBorder : btTextSecondary,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                _buildSelectionIndicator(isSelected, isAlreadyAdded),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionIndicator(bool isSelected, bool isAlreadyAdded) {
    if (isAlreadyAdded) {
      return Container(
        width: 24.w,
        height: 24.w,
        decoration: BoxDecoration(
          color: btBorder,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(Icons.done, color: btTextTertiary, size: 14.sp),
      );
    } else if (isSelected) {
      return Container(
        width: 24.w,
        height: 24.w,
        decoration: BoxDecoration(
          color: btBlue,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(Icons.check, color: btTextPrimary, size: 14.sp),
      );
    } else {
      return Container(
        width: 24.w,
        height: 24.w,
        decoration: BoxDecoration(
          border: Border.all(color: btBorderLight, width: 1.5),
          borderRadius: BorderRadius.circular(12.r),
        ),
      );
    }
  }
}
