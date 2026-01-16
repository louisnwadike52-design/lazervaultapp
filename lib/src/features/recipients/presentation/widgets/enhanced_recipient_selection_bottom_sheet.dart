import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/models/device_contact.dart';
import 'package:lazervault/core/services/contact_service.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

// Model for lazertag user search results
class LazertagUser {
  final String id;
  final String username;
  final String name;
  final String? email;
  final String? avatar;
  final bool isOnline;
  final bool isVerified;

  const LazertagUser({
    required this.id,
    required this.username,
    required this.name,
    this.email,
    this.avatar,
    this.isOnline = false,
    this.isVerified = false,
  });
}

enum RecipientSelectionTab { saved, lazertag, contacts }

class EnhancedRecipientSelectionBottomSheet extends StatefulWidget {
  final Function(RecipientModel) onRecipientSelected;
  final Function(LazertagUser)? onLazertagUserSelected;
  final Function(DeviceContact)? onContactSelected;
  final bool allowLazertagUsers;
  final bool allowContacts;
  final String? initialSearch;

  const EnhancedRecipientSelectionBottomSheet({
    super.key,
    required this.onRecipientSelected,
    this.onLazertagUserSelected,
    this.onContactSelected,
    this.allowLazertagUsers = true,
    this.allowContacts = true,
    this.initialSearch,
  });

  @override
  State<EnhancedRecipientSelectionBottomSheet> createState() => _EnhancedRecipientSelectionBottomSheetState();
}

class _EnhancedRecipientSelectionBottomSheetState extends State<EnhancedRecipientSelectionBottomSheet>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isLoadingContacts = false;
  bool _isLoadingLazertag = false;
  List<DeviceContact> _deviceContacts = [];
  List<LazertagUser> _lazertagResults = [];
  RecipientSelectionTab _currentTab = RecipientSelectionTab.saved;

  @override
  void initState() {
    super.initState();
    _setupTabs();
    _searchController.addListener(_onSearchChanged);
    if (widget.initialSearch != null) {
      _searchController.text = widget.initialSearch!;
      _handleInitialSearch();
    }
  }

  void _setupTabs() {
    final tabCount = _getTabCount();
    _tabController = TabController(length: tabCount, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTab = _getTabFromIndex(_tabController.index);
        if (_currentTab == RecipientSelectionTab.contacts && _deviceContacts.isEmpty) {
          _loadDeviceContacts();
        }
      });
    });
  }

  int _getTabCount() {
    int count = 1; // Saved recipients always available
    if (widget.allowLazertagUsers) count++;
    if (widget.allowContacts) count++;
    return count;
  }

  RecipientSelectionTab _getTabFromIndex(int index) {
    if (index == 0) return RecipientSelectionTab.saved;
    if (widget.allowLazertagUsers && index == 1) return RecipientSelectionTab.lazertag;
    if (widget.allowContacts) return RecipientSelectionTab.contacts;
    return RecipientSelectionTab.saved;
  }

  void _handleInitialSearch() {
    final query = widget.initialSearch!;
    if (query.startsWith('@')) {
      // Switch to lazertag tab and search
      if (widget.allowLazertagUsers) {
        _tabController.animateTo(1);
        _searchLazertagUsers(query);
      }
    } else {
      // Search in saved recipients
      _onSearchChanged();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });

    // Handle lazertag search
    if (_searchQuery.startsWith('@') && widget.allowLazertagUsers) {
      _searchLazertagUsers(_searchQuery);
    }
  }

  Future<void> _searchLazertagUsers(String query) async {
    if (query.length < 2) {
      setState(() => _lazertagResults = []);
      return;
    }

    setState(() => _isLoadingLazertag = true);

    try {
      // Simulate API call to search lazertag users
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Mock lazertag user results
      final mockResults = [
        LazertagUser(
          id: 'lz1',
          username: '@louis',
          name: 'Louis Lawrence',
          email: 'louis@example.com',
          isOnline: true,
          isVerified: true,
        ),
        LazertagUser(
          id: 'lz2',
          username: '@sarah',
          name: 'Sarah Johnson',
          email: 'sarah@example.com',
          isOnline: false,
          isVerified: true,
        ),
        LazertagUser(
          id: 'lz3',
          username: '@mike',
          name: 'Mike Davis',
          email: 'mike@example.com',
          isOnline: true,
          isVerified: false,
        ),
      ];

      final filteredResults = mockResults.where((user) =>
        user.username.toLowerCase().contains(query.toLowerCase().replaceAll('@', '')) ||
        user.name.toLowerCase().contains(query.toLowerCase())
      ).toList();

      setState(() {
        _lazertagResults = filteredResults;
        _isLoadingLazertag = false;
      });
    } catch (e) {
      setState(() {
        _lazertagResults = [];
        _isLoadingLazertag = false;
      });
    }
  }

  Future<void> _loadDeviceContacts() async {
    setState(() => _isLoadingContacts = true);

    try {
      final contactService = ContactService();

      // Check permission first
      final hasPermission = await contactService.hasPermission();

      if (!hasPermission) {
        // Request permission
        final granted = await contactService.requestPermission();

        if (!granted) {
          // Permission denied - show empty state
          setState(() {
            _deviceContacts = [];
            _isLoadingContacts = false;
          });

          // Show permission rationale
          if (mounted) {
            _showPermissionDeniedDialog();
          }
          return;
        }
      }

      // Load contacts from device
      final contacts = await contactService.getContactsWithPhone();

      setState(() {
        _deviceContacts = contacts;
        _isLoadingContacts = false;
      });

    } catch (e) {
      // Handle error - show empty state
      setState(() {
        _deviceContacts = [];
        _isLoadingContacts = false;
      });

      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to load contacts: ${e.toString()}',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            backgroundColor: Colors.red[600],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        );
      }
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A3E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[600]!, Colors.orange[400]!],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.contacts, color: Colors.white, size: 24.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                'Contacts Permission',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          'LazerVault needs access to your contacts to help you quickly send money to friends and family. You can grant permission in Settings.',
          style: GoogleFonts.inter(
            color: Colors.grey[300],
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await ContactService().openSettings();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[600],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Open Settings',
              style: GoogleFonts.inter(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  List<RecipientModel> _filterRecipients(List<RecipientModel> recipients) {
    if (_searchQuery.isEmpty || _searchQuery.startsWith('@')) return recipients;
    
    return recipients.where((recipient) {
      return recipient.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             recipient.accountNumber.contains(_searchQuery);
    }).toList();
  }

  List<DeviceContact> _filterContacts() {
    if (_searchQuery.isEmpty || _searchQuery.startsWith('@')) return _deviceContacts;
    
    return _deviceContacts.where((contact) {
      return contact.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             (contact.phoneNumber?.contains(_searchQuery) ?? false);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0F0F23),
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _buildTabViews(scrollController),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(bottom: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Recipient',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Get.back();
                      Get.toNamed(AppRoutes.addRecipient);
                    },
                    icon: Icon(Icons.add, color: Colors.blue[400], size: 20.sp),
                    label: Text(
                      'Add New',
                      style: GoogleFonts.inter(
                        color: Colors.blue[400],
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey[400],
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: _getSearchHintText(),
          hintStyle: GoogleFonts.inter(
            color: Colors.grey[500],
            fontSize: 14.sp,
          ),
          prefixIcon: Icon(
            _searchQuery.startsWith('@') ? Icons.alternate_email : Icons.search,
            color: Colors.grey[400],
            size: 20.sp,
          ),
          suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    _searchQuery = '';
                    _lazertagResults = [];
                  });
                },
                icon: Icon(
                  Icons.clear,
                  color: Colors.grey[400],
                  size: 20.sp,
                ),
              )
            : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        ),
      ),
    );
  }

  String _getSearchHintText() {
    switch (_currentTab) {
      case RecipientSelectionTab.saved:
        return 'Search recipients or type @username';
      case RecipientSelectionTab.lazertag:
        return 'Search @username (e.g., @louis)';
      case RecipientSelectionTab.contacts:
        return 'Search contacts by name or phone';
    }
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.blue[600],
          borderRadius: BorderRadius.circular(10.r),
        ),
        indicatorPadding: EdgeInsets.all(2.w),
        dividerHeight: 0,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[400],
        labelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
        tabs: _buildTabs(),
      ),
    );
  }

  List<Tab> _buildTabs() {
    final tabs = <Tab>[
      Tab(
        height: 40.h,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.people_outline, size: 16.sp),
              SizedBox(width: 6.w),
              Text('Saved'),
            ],
          ),
        ),
      ),
    ];

    if (widget.allowLazertagUsers) {
      tabs.add(
        Tab(
          height: 40.h,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.alternate_email, size: 16.sp),
                SizedBox(width: 6.w),
                Text('LazerTag'),
              ],
            ),
          ),
        ),
      );
    }

    if (widget.allowContacts) {
      tabs.add(
        Tab(
          height: 40.h,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.contacts_outlined, size: 16.sp),
                SizedBox(width: 6.w),
                Text('Contacts'),
              ],
            ),
          ),
        ),
      );
    }

    return tabs;
  }

  List<Widget> _buildTabViews(ScrollController scrollController) {
    final views = <Widget>[
      _buildSavedRecipientsTab(scrollController),
    ];

    if (widget.allowLazertagUsers) {
      views.add(_buildLazertagTab(scrollController));
    }

    if (widget.allowContacts) {
      views.add(_buildContactsTab(scrollController));
    }

    return views;
  }

  Widget _buildSavedRecipientsTab(ScrollController scrollController) {
    return BlocConsumer<RecipientCubit, RecipientState>(
      listener: (context, state) {
        if (state is RecipientSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is RecipientLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.blue),
          );
        } else if (state is RecipientLoaded) {
          final filteredRecipients = _filterRecipients(state.recipients);
          
          if (filteredRecipients.isEmpty) {
            return _buildEmptyState(
              icon: _searchQuery.isNotEmpty ? Icons.search_off : Icons.people_outline,
              title: _searchQuery.isNotEmpty 
                ? 'No recipients found'
                : 'No saved recipients',
              subtitle: _searchQuery.isNotEmpty 
                ? 'Try searching with @username for LazerTag users'
                : 'Add your first recipient to get started',
              actionText: _searchQuery.isEmpty ? 'Add Recipient' : null,
              onAction: _searchQuery.isEmpty ? () {
                Get.back();
                Get.toNamed(AppRoutes.addRecipient);
              } : null,
            );
          }
          
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            itemCount: filteredRecipients.length,
            itemBuilder: (context, index) {
              final recipient = filteredRecipients[index];
              return _buildRecipientItem(recipient);
            },
          );
        } else if (state is RecipientError) {
          return _buildErrorState(state.message);
        }
        
        return const SizedBox();
      },
    );
  }

  Widget _buildLazertagTab(ScrollController scrollController) {
    if (_isLoadingLazertag) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.blue),
      );
    }

    if (_searchQuery.isEmpty || !_searchQuery.startsWith('@')) {
      return _buildEmptyState(
        icon: Icons.alternate_email,
        title: 'Search LazerTag Users',
        subtitle: 'Type @username to find LazerVault users\nExample: @louis, @sarah',
        showExamples: true,
      );
    }

    if (_lazertagResults.isEmpty && _searchQuery.length > 1) {
      return _buildEmptyState(
        icon: Icons.search_off,
        title: 'No users found',
        subtitle: 'No LazerVault users match "$_searchQuery"',
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      itemCount: _lazertagResults.length,
      itemBuilder: (context, index) {
        final user = _lazertagResults[index];
        return _buildLazertagUserItem(user);
      },
    );
  }

  Widget _buildContactsTab(ScrollController scrollController) {
    if (_isLoadingContacts) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.blue),
      );
    }

    final filteredContacts = _filterContacts();

    if (filteredContacts.isEmpty) {
      return _buildEmptyState(
        icon: _searchQuery.isNotEmpty ? Icons.search_off : Icons.contacts_outlined,
        title: _searchQuery.isNotEmpty ? 'No contacts found' : 'No contacts available',
        subtitle: _searchQuery.isNotEmpty 
          ? 'No contacts match your search'
          : 'Grant permission to access your contacts',
        actionText: _searchQuery.isEmpty ? 'Reload Contacts' : null,
        onAction: _searchQuery.isEmpty ? _loadDeviceContacts : null,
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      itemCount: filteredContacts.length,
      itemBuilder: (context, index) {
        final contact = filteredContacts[index];
        return _buildContactItem(contact);
      },
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    String? actionText,
    VoidCallback? onAction,
    bool showExamples = false,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64.sp,
              color: Colors.grey[600],
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            if (showExamples) ...[
              SizedBox(height: 16.h),
              _buildExampleTags(),
            ],
            if (actionText != null && onAction != null) ...[
              SizedBox(height: 16.h),
              TextButton(
                onPressed: onAction,
                child: Text(
                  actionText,
                  style: GoogleFonts.inter(
                    color: Colors.blue[400],
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildExampleTags() {
    final examples = ['@louis', '@sarah', '@mike'];
    
    return Wrap(
      spacing: 8.w,
      children: examples.map((example) => 
        GestureDetector(
          onTap: () {
            _searchController.text = example;
            _onSearchChanged();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.blue[600]!.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.blue[600]!.withValues(alpha: 0.3)),
            ),
            child: Text(
              example,
              style: GoogleFonts.inter(
                color: Colors.blue[400],
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ).toList(),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.sp,
            color: Colors.red[400],
          ),
          SizedBox(height: 16.h),
          Text(
            'Error loading recipients',
            style: GoogleFonts.inter(
              color: Colors.red[400],
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          TextButton(
            onPressed: () {
              final authState = context.read<AuthenticationCubit>().state;
              if (authState is AuthenticationSuccess) {
                context.read<RecipientCubit>().getRecipients(
                  accessToken: authState.profile.session.accessToken,
                );
              }
            },
            child: Text(
              'Retry',
              style: GoogleFonts.inter(
                color: Colors.blue[400],
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientItem(RecipientModel recipient) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
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
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        leading: Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[600]!, Colors.blue[400]!],
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              recipient.name.isNotEmpty ? recipient.name.substring(0, 1).toUpperCase() : 'R',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        title: Text(
          recipient.name,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipient.accountNumber.length > 4
                ? '••• ${recipient.accountNumber.substring(recipient.accountNumber.length - 4)}'
                : recipient.accountNumber,
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 14.sp,
              ),
            ),
            if (recipient.bankName.isNotEmpty)
              Text(
                recipient.bankName,
                style: GoogleFonts.inter(
                  color: Colors.grey[500],
                  fontSize: 12.sp,
                ),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (recipient.isFavorite)
              Icon(Icons.favorite, color: Colors.red[400], size: 20.sp),
            SizedBox(width: 8.w),
            Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey[400],
              size: 24.sp,
            ),
          ],
        ),
        onTap: () {
          widget.onRecipientSelected(recipient);
          Get.back();
        },
      ),
    );
  }

  Widget _buildLazertagUserItem(LazertagUser user) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
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
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        leading: Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple[600]!, Colors.purple[400]!],
            ),
            shape: BoxShape.circle,
          ),
          child: user.avatar != null
            ? ClipOval(
                child: Image.network(
                  user.avatar!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Text(
                      user.name.isNotEmpty ? user.name.substring(0, 1).toUpperCase() : '@',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              )
            : Center(
                child: Text(
                  user.name.isNotEmpty ? user.name.substring(0, 1).toUpperCase() : '@',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
        ),
        title: Row(
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
            if (user.isVerified)
              Icon(
                Icons.verified,
                color: Colors.blue[400],
                size: 16.sp,
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  user.username,
                  style: GoogleFonts.inter(
                    color: Colors.purple[300],
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: user.isOnline ? Colors.green[400] : Colors.grey[600],
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  user.isOnline ? 'Online' : 'Offline',
                  style: GoogleFonts.inter(
                    color: user.isOnline ? Colors.green[400] : Colors.grey[500],
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            if (user.email != null)
              Text(
                user.email!,
                style: GoogleFonts.inter(
                  color: Colors.grey[500],
                  fontSize: 12.sp,
                ),
              ),
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey[400],
          size: 24.sp,
        ),
        onTap: () {
          if (widget.onLazertagUserSelected != null) {
            widget.onLazertagUserSelected!(user);
          }
          Get.back();
        },
      ),
    );
  }

  Widget _buildContactItem(DeviceContact contact) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
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
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        leading: Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green[600]!, Colors.green[400]!],
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              contact.initials,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        title: Text(
          contact.name,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (contact.phoneNumber != null)
              Text(
                contact.phoneNumber!,
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 14.sp,
                ),
              ),
            if (contact.email != null)
              Text(
                contact.email!,
                style: GoogleFonts.inter(
                  color: Colors.grey[500],
                  fontSize: 12.sp,
                ),
              ),
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey[400],
          size: 24.sp,
        ),
        onTap: () {
          if (widget.onContactSelected != null) {
            widget.onContactSelected!(contact);
          }
          Get.back();
        },
      ),
    );
  }
} 