part of 'invoice_preview_screen.dart';

class _TagUserBottomSheetState extends State<_TagUserBottomSheet>
    with TickerProviderStateMixin, TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  late TabController _tabController;
  late InvoiceRepository _invoiceRepository;
  late ContactSyncRepository _contactSyncRepository;

  String _searchQuery = '';
  final Set<String> _selectedUserIds = {};
  // Display identity for each tagged user id, captured at selection time from
  // the unified search result so the preview shows the real name/username
  // immediately (never "Unknown user") without a round-trip.
  final Map<String, InvoiceUser> _taggedUserDetails = {};
  final Set<String> _selectedEmails = {};
  final Set<String> _selectedPhones = {};
  Set<String> _alreadyTaggedUserIds = {};

  Invoice get invoice => widget.invoice;

  List<InvoiceUser> _searchResults = [];
  List<Map<String, dynamic>> _contacts = [];

  bool _loadingSearch = false;
  bool _loadingContacts = false;
  int _currentTab = 0;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _invoiceRepository = serviceLocator<InvoiceRepository>();
    _contactSyncRepository = serviceLocator<ContactSyncRepository>();

    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTab = _tabController.index;
        if (_currentTab == 2) {
          _requestContactsPermission();
        }
      });
    });

    // Fetch already-tagged user IDs to prevent double-tagging
    _fetchAlreadyTaggedUsers();

    // Add search listener with debounce
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    _debounceTimer?.cancel();
    final query = _searchController.text.trim();
    if (query.length >= 2) {
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        _searchUsers(query);
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  Future<void> _fetchAlreadyTaggedUsers() async {
    try {
      final result = await _invoiceRepository.getInvoiceById(widget.invoice.id);
      if (result != null && result.taggedUsers != null) {
        setState(() {
          _alreadyTaggedUserIds = result.taggedUsers!
              .map((u) => u.userId)
              .where((id) => id.isNotEmpty)
              .toSet();
        });
      }
    } catch (e) {
      // Also try from the widget's invoice if it has tagged users
      if (widget.invoice.taggedUsers != null) {
        setState(() {
          _alreadyTaggedUserIds = widget.invoice.taggedUsers!
              .map((u) => u.userId)
              .where((id) => id.isNotEmpty)
              .toSet();
        });
      }
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSearchTab(),
                _buildManualTab(),
                _buildContactsTab(),
              ],
            ),
          ),
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          // Drag handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      InvoiceThemeColors.infoBlue.withValues(alpha: 0.2),
                      const Color(0xFF1D4ED8).withValues(alpha: 0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                ),
                child: Icon(
                  Icons.group_add,
                  color: InvoiceThemeColors.infoBlue,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tag Users for Payment',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Select multiple users to tag for this invoice',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14.sp,
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
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white.withValues(alpha: 0.7),
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
          if (_selectedUserIds.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: _selectedUserIds.map((id) {
                final u = _taggedUserDetails[id];
                final label = (u?.name.trim().isNotEmpty ?? false)
                    ? u!.name.trim()
                    : ((u?.username.trim().isNotEmpty ?? false)
                        ? '@${u!.username.trim()}'
                        : 'Lazervault user');
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                  decoration: BoxDecoration(
                    color: InvoiceThemeColors.infoBlue.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                        color: InvoiceThemeColors.infoBlue
                            .withValues(alpha: 0.35)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person,
                          size: 14.sp, color: InvoiceThemeColors.infoBlue),
                      SizedBox(width: 6.w),
                      Text(
                        label,
                        style: GoogleFonts.inter(
                          color: InvoiceThemeColors.infoBlue,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      GestureDetector(
                        onTap: () => setState(() {
                          _selectedUserIds.remove(id);
                          _taggedUserDetails.remove(id);
                        }),
                        child: Icon(Icons.close,
                            size: 15.sp,
                            color: InvoiceThemeColors.infoBlue
                                .withValues(alpha: 0.8)),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              InvoiceThemeColors.infoBlue,
              const Color(0xFF1D4ED8),
            ],
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(4.w),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withValues(alpha: 0.6),
        labelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        dividerColor: Colors.transparent,
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, size: 16.sp),
                SizedBox(width: 6.w),
                Text('Search'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit, size: 16.sp),
                SizedBox(width: 6.w),
                Text('Manual'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.contacts, size: 16.sp),
                SizedBox(width: 6.w),
                Text('Contacts'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTab() {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          // Search bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
            ),
            child: TextField(
              controller: _searchController,
              readOnly: true,
              onTap: _openUnifiedSearch,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Search people to tag',
                hintStyle: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 16.sp,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: InvoiceThemeColors.infoBlue,
                  size: 20.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          
          // User list
          Expanded(
            child: _buildUserList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    // Show loading indicator
    if (_loadingSearch) {
      return Center(
        child: LazerVaultLoader.small(),
      );
    }

    // Show empty state if no search performed
    if (_searchQuery.isEmpty || _searchQuery.length < 2) {
      return _buildSearchPrompt();
    }

    // Show empty state if no results
    if (_searchResults.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final user = _searchResults[index];
        final isSelected = _selectedUserIds.contains(user.id);

        return _buildUserTile(user, isSelected);
      },
    );
  }

  Widget _buildUserTile(InvoiceUser user, bool isSelected) {
    final isAlreadyTagged = _alreadyTaggedUserIds.contains(user.id);

    return GestureDetector(
      onTap: isAlreadyTagged ? null : () {
        HapticFeedback.lightImpact();
        setState(() {
          if (isSelected) {
            _selectedUserIds.remove(user.id);
          } else {
            _selectedUserIds.add(user.id);
          }
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isAlreadyTagged
              ? Colors.white.withValues(alpha: 0.03)
              : isSelected
                  ? InvoiceThemeColors.infoBlue.withValues(alpha: 0.1)
                  : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            // Avatar with selection indicator
            Stack(
              children: [
                CircleAvatar(
                  radius: 26.r,
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                  child: Text(
                    user.name.isNotEmpty ? user.name.substring(0, 1).toUpperCase() : '?',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (isSelected)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            InvoiceThemeColors.infoBlue,
                            const Color(0xFF1D4ED8),
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12.sp,
                      ),
                    ),
                  ),
                if (user.isOnline && !isSelected)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 14.w,
                      height: 14.w,
                      decoration: BoxDecoration(
                        color: InvoiceThemeColors.successGreen,
                        shape: BoxShape.circle,
                        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 16.w),
            
            // User info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          user.name,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (user.isOnline && !isSelected)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: InvoiceThemeColors.successGreen.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],

                          ),
                          child: Text(
                            'Online',
                            style: GoogleFonts.inter(
                              color: InvoiceThemeColors.successGreen,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    user.username,
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    user.email,
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            
            // Selection indicator or Already Tagged badge
            if (isAlreadyTagged)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Tagged',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            else
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: isSelected
                      ? InvoiceThemeColors.infoBlue
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16.sp,
                      )
                    : null,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildManualTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add by Phone or Email',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Enter phone number or email to invite users to pay this invoice',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 24.h),
          
          // Phone input
          _buildInputField(
            controller: _phoneController,
            label: 'Phone Number',
            hint: '+44 7700 900000',
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 16.h),
          
          // Email input
          _buildInputField(
            controller: _emailController,
            label: 'Email Address',
            hint: 'user@example.com',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 24.h),
          
          // Add button
          Container(
            width: double.infinity,
            height: 52.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  InvoiceThemeColors.infoBlue,
                  const Color(0xFF1D4ED8),
                ],
              ),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: InvoiceThemeColors.infoBlue.withValues(alpha: 0.3),
                  offset: const Offset(0, 4),
                  blurRadius: 12,
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: _addManualUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 20.sp,
              ),
              label: Text(
                'Add User',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 32.h),
          
          // Info card
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: InvoiceThemeColors.infoBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: InvoiceThemeColors.infoBlue,
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Users not on Lazervault will receive an invitation link',
                    style: GoogleFonts.inter(
                      color: InvoiceThemeColors.infoBlue,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          // Header with permission button
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Device Contacts',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Import from your phone contacts',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          
          // Contacts list
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4, // Fixed height for contacts list
            child: _loadingContacts
                ? _buildLoadingState()
                : _contacts.isEmpty
                    ? _buildNoContactsState()
                    : _buildContactsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required TextInputType keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 16.sp,
              ),
              prefixIcon: Icon(
                icon,
                color: InvoiceThemeColors.infoBlue,
                size: 20.sp,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(
              Icons.search,
              size: 48.sp,
              color: InvoiceThemeColors.infoBlue,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Search for users',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Type at least 2 characters to start searching',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(
              Icons.search_off,
              size: 48.sp,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No users found',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try searching with different keywords',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LazerVaultLoader.small(),
          SizedBox(height: 16.h),
          Text(
            'Loading contacts...',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoContactsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(
              Icons.contacts_outlined,
              size: 48.sp,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No contacts available',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Grant permission to access your contacts',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactsList() {
    return ListView.builder(
      itemCount: _contacts.length,
      itemBuilder: (context, index) {
        final contact = _contacts[index];
        return _buildContactTile(contact);
      },
    );
  }

  Widget _buildContactTile(Map<String, dynamic> contact) {
    final isOnPlatform = contact['isOnPlatform'] == true && contact['userId'] != null;
    final userId = contact['userId']?.toString() ?? '';
    final phone = contact['phone']?.toString() ?? '';
    final email = contact['email']?.toString() ?? '';

    final isSelected = isOnPlatform
        ? _selectedUserIds.contains(userId)
        : _selectedPhones.contains(phone) || _selectedEmails.contains(email);

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() {
          if (isOnPlatform) {
            // User is on platform, add/remove from selected user IDs
            if (isSelected) {
              _selectedUserIds.remove(userId);
            } else {
              _selectedUserIds.add(userId);
            }
          } else {
            // User is not on platform, add/remove phone/email for invitation
            if (isSelected) {
              _selectedPhones.remove(phone);
              _selectedEmails.remove(email);
            } else {
              if (phone.isNotEmpty) _selectedPhones.add(phone);
              if (email.isNotEmpty) _selectedEmails.add(email);
            }
          }
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected 
              ? InvoiceThemeColors.infoBlue.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundColor: Colors.white.withValues(alpha: 0.1),
              child: Text(
                (contact['name']?.isNotEmpty == true 
                    ? contact['name'][0].toUpperCase() 
                    : '?'),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact['name'] ?? 'Unknown',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (contact['phone']?.isNotEmpty == true) ...[
                    SizedBox(height: 2.h),
                    Text(
                      contact['phone'] ?? '',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                  if (contact['email']?.isNotEmpty == true) ...[
                    SizedBox(height: 2.h),
                    Text(
                      contact['email'] ?? '',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (!isOnPlatform) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: InvoiceThemeColors.infoBlue.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  'Invite',
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.infoBlue,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
            ],
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? InvoiceThemeColors.infoBlue
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6.r),
                boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16.sp,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _selectedUserIds.isNotEmpty
                        ? [InvoiceThemeColors.infoBlue, const Color(0xFF1D4ED8)]
                        : [Colors.grey.shade700, Colors.grey.shade800],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: _selectedUserIds.isNotEmpty ? [
                    BoxShadow(
                      color: InvoiceThemeColors.infoBlue.withValues(alpha: 0.3),
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                    ),
                  ] : null,
                ),
                child: ElevatedButton.icon(
                  onPressed: _selectedUserIds.isNotEmpty ? _tagSelectedUsers : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  icon: Icon(
                    Icons.group_add,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                  label: Text(
                    () {
                      final totalCount = _selectedUserIds.length + _selectedEmails.length + _selectedPhones.length;
                      if (totalCount == 0) {
                        return 'Select Users';
                      } else {
                        return 'Tag $totalCount User${totalCount == 1 ? '' : 's'}';
                      }
                    }(),
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
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

  void _addManualUser() {
    final phone = _phoneController.text.trim();
    final email = _emailController.text.trim();

    if (phone.isEmpty && email.isEmpty) {
      _showErrorSnackbar('Please enter a phone number or email address');
      return;
    }

    setState(() {
      if (phone.isNotEmpty) {
        _selectedPhones.add(phone);
      }
      if (email.isNotEmpty) {
        _selectedEmails.add(email);
      }
    });

    // Clear inputs
    _phoneController.clear();
    _emailController.clear();

    // Show success
    HapticFeedback.heavyImpact();

    String message = '';
    if (phone.isNotEmpty && email.isNotEmpty) {
      message = 'Email and phone number added';
    } else if (phone.isNotEmpty) {
      message = 'Phone number added';
    } else {
      message = 'Email address added';
    }
    _showSuccessSnackbar(message);
  }

  Future<void> _requestContactsPermission() async {
    final status = await Permission.contacts.request();
    
    if (status.isGranted) {
      _loadContacts();
    } else if (status.isDenied) {
      _showErrorSnackbar('Contacts permission denied');
    } else if (status.isPermanentlyDenied) {
      _showErrorSnackbar('Please enable contacts permission in settings');
    }
  }

  /// Opens the shared unified search (saved contacts incl. alias → global) and
  /// toggles the picked user into the tagged set.
  Future<void> _openUnifiedSearch() async {
    final result =
        await UnifiedUserSearchSheet.show(context, title: 'Tag people');
    if (result == null || !mounted) return;
    final id = result.userId;
    if (id.isEmpty) return;
    setState(() {
      if (_selectedUserIds.contains(id)) {
        _selectedUserIds.remove(id);
        _taggedUserDetails.remove(id);
      } else {
        _selectedUserIds.add(id);
        // Capture the resolved identity so the preview chip shows a real name.
        final display = result.displayName.trim().isNotEmpty
            ? result.displayName.trim()
            : (result.name.trim().isNotEmpty
                ? result.name.trim()
                : (result.username.trim().isNotEmpty
                    ? '@${result.username.trim()}'
                    : 'Lazervault user'));
        _taggedUserDetails[id] = InvoiceUser(
          id: id,
          name: display,
          email: result.email,
          username: result.username,
          phone: result.phoneNumber,
          isOnline: false,
        );
      }
    });
  }

  Future<void> _searchUsers(String query) async {
    if (_loadingSearch) return;

    setState(() {
      _loadingSearch = true;
    });

    try {
      final profileCubit = serviceLocator<ProfileCubit>();
      final results = await profileCubit.searchUsers(query, limit: 20);
      setState(() {
        _searchResults = results.map((user) => InvoiceUser(
          id: user.userId,
          name: user.fullName,
          email: user.email,
          username: user.username,
          phone: '',
          isOnline: false,
        )).toList();
      });
    } catch (e) {
      _showErrorSnackbar('Failed to search users');
      setState(() {
        _searchResults = [];
      });
    } finally {
      setState(() {
        _loadingSearch = false;
      });
    }
  }

  Future<void> _loadContacts() async {
    if (_loadingContacts) return;

    setState(() {
      _loadingContacts = true;
    });

    try {
      final permission = await Permission.contacts.status;
      if (permission.isGranted) {
        // Load real contacts from contact sync service
        final syncedContactsResult = await _contactSyncRepository.getSyncedContacts();

        // Convert to display format
        final contactsList = syncedContactsResult.contacts.map((contact) {
          return {
            'id': contact.id,
            'name': contact.name,
            'phone': contact.phoneNumbers.isNotEmpty ? contact.phoneNumbers.first : '',
            'email': contact.emails.isNotEmpty ? contact.emails.first : '',
            'isOnPlatform': contact.isLazervaultUser,
            'userId': contact.lazervaultUserId,
          };
        }).toList();

        setState(() {
          _contacts = contactsList;
        });
      }
    } catch (e) {
      _showErrorSnackbar('Failed to load contacts');
    } finally {
      setState(() {
        _loadingContacts = false;
      });
    }
  }

  Future<void> _tagSelectedUsers() async {
    if (_selectedUserIds.isEmpty && _selectedEmails.isEmpty && _selectedPhones.isEmpty) {
      _showErrorSnackbar('Please select at least one user');
      return;
    }

    try {
      final response = await _invoiceRepository.tagUsersToInvoice(
        widget.invoice.id,
        _selectedUserIds.toList(),
        _selectedEmails.toList(),
        _selectedPhones.toList(),
      );

      if (response.success) {
        if (!mounted) return;
        Navigator.pop(context);

        // Show detailed success message
        final totalTagged = response.taggedUserIds.length;
        final totalInvited = response.invitedEmails.length + response.invitedPhones.length;

        String message = '';
        if (totalTagged > 0 && totalInvited > 0) {
          message = '$totalTagged user${totalTagged == 1 ? '' : 's'} tagged, $totalInvited invitation${totalInvited == 1 ? '' : 's'} sent';
        } else if (totalTagged > 0) {
          message = '$totalTagged user${totalTagged == 1 ? '' : 's'} tagged for payment';
        } else if (totalInvited > 0) {
          message = '$totalInvited invitation${totalInvited == 1 ? '' : 's'} sent';
        }

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Successfully Tagged!',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        message,
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: InvoiceThemeColors.successGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 200.h,
              right: 20.w,
              left: 20.w,
            ),
            duration: Duration(seconds: 4),
          ),
        );

        HapticFeedback.heavyImpact();
      } else {
        _showErrorSnackbar(response.message);
      }
    } catch (e) {
      _showErrorSnackbar('Failed to tag users: ${e.toString()}');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: InvoiceThemeColors.errorRed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: InvoiceThemeColors.successGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

}
