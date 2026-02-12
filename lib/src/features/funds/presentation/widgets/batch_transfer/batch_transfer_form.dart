import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fixnum/fixnum.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:lazervault/core/utils/debouncer.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_theme.dart';

class BatchRecipientItem {
  final RecipientModel recipient;
  final TextEditingController amountController;
  final TextEditingController referenceController;
  bool isExpanded;

  BatchRecipientItem({
    required this.recipient,
    String? initialAmount,
    String? initialReference,
    this.isExpanded = false,
  }) : amountController = TextEditingController(text: initialAmount ?? ''),
       referenceController = TextEditingController(text: initialReference ?? '');

  void dispose() {
    amountController.dispose();
    referenceController.dispose();
  }

  double get amount => double.tryParse(amountController.text) ?? 0.0;
  bool get isValid => amount > 0;
}

// --- Enhanced Multi-Select Recipient Bottom Sheet with User Search ---
class MultiSelectRecipientBottomSheet extends StatefulWidget {
  final Function(List<RecipientModel>) onRecipientsSelected;
  final List<String> alreadySelectedIds;

  const MultiSelectRecipientBottomSheet({
    super.key,
    required this.onRecipientsSelected,
    required this.alreadySelectedIds,
  });

  @override
  State<MultiSelectRecipientBottomSheet> createState() => _MultiSelectRecipientBottomSheetState();
}

class _MultiSelectRecipientBottomSheetState extends State<MultiSelectRecipientBottomSheet>
    with SingleTickerProviderStateMixin {
  final List<RecipientModel> _tempSelectedRecipients = [];
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _userSearchController = TextEditingController();
  final Debouncer _userSearchDebouncer = Debouncer.search();
  String _searchQuery = '';

  late TabController _tabController;

  // User search state
  List<UserSearchResultEntity> _userSearchResults = [];
  bool _isSearchingUsers = false;
  String? _userSearchError;

  // Current user info for self-transfer prevention
  String? _currentUserId;
  String? _currentUsername;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(_onSearchChanged);
    _loadCurrentUserInfo();
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
    _userSearchController.dispose();
    _userSearchDebouncer.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  void _onUserSearchChanged(String query) {
    _userSearchDebouncer.cancel();

    final cleanQuery = query.replaceAll('@', '').replaceAll('\$', '').trim();

    if (cleanQuery.isEmpty || cleanQuery.length < 2) {
      setState(() {
        _userSearchResults = [];
        _isSearchingUsers = false;
        _userSearchError = null;
      });
      return;
    }

    setState(() {
      _isSearchingUsers = true;
      _userSearchError = null;
    });

    _userSearchDebouncer.run(() => _performUserSearch(cleanQuery));
  }

  Future<void> _performUserSearch(String query) async {
    if (!mounted) return;
    setState(() {
      _isSearchingUsers = true;
      _userSearchError = null;
    });
    try {
      final cubit = serviceLocator<ProfileCubit>();
      final results = await cubit.searchUsers(query);
      if (mounted) {
        // Filter out current user from results
        final filtered = results.where((u) {
          if (_currentUserId != null && u.userId == _currentUserId) return false;
          if (_currentUsername != null && u.username == _currentUsername) return false;
          return true;
        }).toList();
        setState(() {
          _userSearchResults = filtered;
          _isSearchingUsers = false;
          _userSearchError = filtered.isEmpty ? 'No users found for "$query"' : null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _userSearchResults = [];
          _isSearchingUsers = false;
          _userSearchError = 'Search failed. Please try again.';
        });
      }
    }
  }

  RecipientModel _userSearchResultToRecipient(UserSearchResultEntity user) {
    return RecipientModel(
      id: user.userId,
      name: user.fullName,
      accountNumber: user.username,
      bankName: 'LazerVault',
      sortCode: '',
      isFavorite: false,
      email: user.email,
      phoneNumber: user.phoneNumber,
      type: 'internal',
    );
  }

  bool _isSelfTransfer(RecipientModel recipient) {
    if (_currentUserId != null && recipient.id == _currentUserId) return true;
    if (_currentUsername != null && recipient.accountNumber == _currentUsername) return true;
    return false;
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
              tabs: const [
                Tab(text: 'Saved'),
                Tab(text: 'Search Users'),
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
            child: Row(
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
                      widget.onRecipientsSelected(_tempSelectedRecipients);
                      Navigator.pop(context);
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
                return const Center(child: CircularProgressIndicator(color: btBlue));
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
              return const Center(child: CircularProgressIndicator(color: btBlue));
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
        context.read<RecipientCubit>().getRecipients(
          accessToken: authState.profile.session.accessToken,
        );
      }
    } catch (_) {}
  }

  // --- User Search Tab ---
  Widget _buildUserSearchTab() {
    return Column(
      children: [
        // Search input
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: btCardElevated,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TextField(
              controller: _userSearchController,
              style: GoogleFonts.inter(color: btTextPrimary, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'Search by username, email, or phone...',
                hintStyle: GoogleFonts.inter(color: btTextTertiary, fontSize: 14.sp),
                prefixIcon: Icon(Icons.person_search_outlined, color: btTextTertiary, size: 20.sp),
                suffixIcon: _userSearchController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _userSearchController.clear();
                          _onUserSearchChanged('');
                        },
                        child: Icon(Icons.clear, color: btTextTertiary, size: 18.sp),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              onChanged: _onUserSearchChanged,
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Expanded(
          child: _buildUserSearchResults(),
        ),
      ],
    );
  }

  Widget _buildUserSearchResults() {
    if (_isSearchingUsers) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: btBlue),
            SizedBox(height: 16.h),
            Text('Searching...', style: GoogleFonts.inter(color: btTextSecondary, fontSize: 14.sp)),
          ],
        ),
      );
    }

    if (_userSearchController.text.isEmpty) {
      return _buildEmptySearchState(
        icon: Icons.person_search_outlined,
        title: 'Search LazerVault Users',
        subtitle: 'Type a username, email, or phone number\n(minimum 2 characters)',
      );
    }

    if (_userSearchError != null && _userSearchResults.isEmpty) {
      final isNetworkError = _userSearchError!.contains('failed');
      return isNetworkError
          ? _buildErrorRetryState(
              message: _userSearchError!,
              onRetry: () => _performUserSearch(
                _userSearchController.text.replaceAll('@', '').replaceAll('\$', '').trim(),
              ),
            )
          : _buildEmptySearchState(
              icon: Icons.person_off_outlined,
              title: _userSearchError!,
              subtitle: 'Try a different search term',
            );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: _userSearchResults.length,
      itemBuilder: (context, index) {
        final user = _userSearchResults[index];
        final recipient = _userSearchResultToRecipient(user);
        final isSelected = _isRecipientSelected(recipient);
        final isAlreadyAdded = _isAlreadyAdded(recipient);

        return _buildUserSearchResultItem(
          user: user,
          recipient: recipient,
          isSelected: isSelected,
          isAlreadyAdded: isAlreadyAdded,
          onTap: isAlreadyAdded ? null : () => _toggleRecipientSelection(recipient),
        );
      },
    );
  }

  Widget _buildUserSearchResultItem({
    required UserSearchResultEntity user,
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
                ? btPurple.withValues(alpha: 0.1)
                : isAlreadyAdded
                  ? btBorder.withValues(alpha: 0.3)
                  : btBackground,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected ? btPurple : btBorder,
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: isAlreadyAdded
                      ? btBorder
                      : btPurple.withValues(alpha: 0.15),
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
                                  color: isAlreadyAdded ? btTextTertiary : btPurple,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                            user.initials,
                            style: GoogleFonts.inter(
                              color: isAlreadyAdded ? btTextTertiary : btPurple,
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
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              user.fullName,
                              style: GoogleFonts.inter(
                                color: isAlreadyAdded ? btTextTertiary : btTextPrimary,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: btPurple.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              'LV',
                              style: GoogleFonts.inter(
                                color: btPurple,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        user.searchMatchInfo,
                        style: GoogleFonts.inter(
                          color: isAlreadyAdded ? btBorder : btTextSecondary,
                          fontSize: 12.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                      Text(
                        '${recipient.bankName} \u2022 ${recipient.accountNumber.length > 4 ? '\u2022\u2022\u2022 ${recipient.accountNumber.substring(recipient.accountNumber.length - 4)}' : recipient.accountNumber}',
                        style: GoogleFonts.inter(
                          color: isAlreadyAdded ? btBorder : btTextSecondary,
                          fontSize: 12.sp,
                        ),
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

// --- Batch Transfer Form ---
class BatchTransferForm extends StatefulWidget {
  final List<dynamic>? preSelectedRecipients;
  final bool isRepeatTransaction;
  final String? batchReference;

  const BatchTransferForm({
    super.key,
    this.preSelectedRecipients,
    this.isRepeatTransaction = false,
    this.batchReference,
  });

  @override
  State<BatchTransferForm> createState() => _BatchTransferFormState();
}

class _BatchTransferFormState extends State<BatchTransferForm> with TickerProviderStateMixin {
  static const int _maxRecipients = 20;
  final List<BatchRecipientItem> _selectedRecipients = [];
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _batchReferenceController = TextEditingController();
  final TextEditingController _bulkAmountController = TextEditingController();
  final TextEditingController _bulkReferenceController = TextEditingController();

  double _totalAmount = 0.0;
  final bool _isLoading = false;
  late String _currencySymbol;
  late String _currency;

  // Account selection
  int _selectedAccountIndex = 0;
  List<AccountSummaryEntity> _accounts = [];

  @override
  void initState() {
    super.initState();
    final accountManager = GetIt.I<AccountManager>();
    _currency = accountManager.activeAccountDetails?.currency ?? 'NGN';
    _currencySymbol = CurrencyUtils.getSymbol(_currency);
    _loadRecipients();
    _loadAccounts();

    if (widget.batchReference != null) {
      _batchReferenceController.text = widget.batchReference!;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _populatePreSelectedRecipients();
    });
  }

  @override
  void dispose() {
    for (var recipient in _selectedRecipients) {
      recipient.dispose();
    }
    _categoryController.dispose();
    _batchReferenceController.dispose();
    _bulkAmountController.dispose();
    _bulkReferenceController.dispose();
    super.dispose();
  }

  void _loadRecipients() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      context.read<RecipientCubit>().getRecipients(accessToken: authState.profile.session.accessToken);
    }
  }

  void _loadAccounts() {
    try {
      final cubit = context.read<AccountCardsSummaryCubit>();
      final state = cubit.state;
      if (state is AccountCardsSummaryLoaded) {
        _accounts = state.accountSummaries;
        _selectDefaultAccount();
      } else if (state is AccountBalanceUpdated) {
        _accounts = state.accountSummaries;
        _selectDefaultAccount();
      } else {
        final authState = context.read<AuthenticationCubit>().state;
        if (authState is AuthenticationSuccess) {
          cubit.fetchAccountSummaries(
            userId: authState.profile.user.id,
            accessToken: authState.profile.session.accessToken,
          );
        }
      }
    } catch (_) {
      // AccountCardsSummaryCubit not available in this context
    }
  }

  void _selectDefaultAccount() {
    if (_accounts.isEmpty) return;
    // Find the personal account with matching currency, or fallback to first
    final personalIndex = _accounts.indexWhere(
      (acc) => acc.accountType.toLowerCase() == 'personal' && acc.currency == _currency,
    );
    setState(() {
      _selectedAccountIndex = personalIndex >= 0 ? personalIndex : 0;
      _updateCurrencyFromAccount();
    });
  }

  void _updateCurrencyFromAccount() {
    if (_accounts.isNotEmpty && _selectedAccountIndex < _accounts.length) {
      final account = _accounts[_selectedAccountIndex];
      _currency = account.currency;
      _currencySymbol = CurrencyUtils.getSymbol(_currency);
    }
  }

  void _populatePreSelectedRecipients() {
    if (widget.preSelectedRecipients != null && widget.preSelectedRecipients!.isNotEmpty) {
      setState(() {
        _selectedRecipients.clear();

        for (var recipientData in widget.preSelectedRecipients!) {
          final recipient = RecipientModel(
            id: recipientData['id'] ?? '1',
            name: recipientData['name'] ?? 'Unknown',
            accountNumber: recipientData['accountNumber'] ?? '',
            bankName: recipientData['bankName'] ?? 'Bank',
            sortCode: recipientData['sortCode'] ?? '',
            isFavorite: recipientData['isFavorite'] ?? false,
          );

          final recipientItem = BatchRecipientItem(
            recipient: recipient,
            initialAmount: recipientData['amount']?.toString() ?? '',
            initialReference: recipientData['reference'] ?? '',
          );

          _selectedRecipients.add(recipientItem);
        }

        _calculateTotal();
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: btTextPrimary),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Loaded ${widget.preSelectedRecipients!.length} recipients from previous transaction',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              backgroundColor: btGreen,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      });
    }
  }

  void _calculateTotal() {
    double total = 0.0;
    for (var recipient in _selectedRecipients) {
      total += recipient.amount;
    }
    setState(() {
      _totalAmount = total;
    });
  }

  void _showMultipleRecipientSelection() {
    if (_selectedRecipients.length >= _maxRecipients) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Maximum $_maxRecipients recipients reached',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
          backgroundColor: btOrange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      );
      return;
    }
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: context.read<RecipientCubit>(),
        child: MultiSelectRecipientBottomSheet(
          onRecipientsSelected: (recipients) {
            // Filter out duplicates by account number
            final existingAccountNumbers = _selectedRecipients
                .map((r) => r.recipient.accountNumber)
                .toSet();
            final newRecipients = recipients
                .where((r) => !existingAccountNumbers.contains(r.accountNumber))
                .toList();
            final duplicateCount = recipients.length - newRecipients.length;

            setState(() {
              for (var recipient in newRecipients) {
                _selectedRecipients.add(BatchRecipientItem(recipient: recipient));
              }
              _calculateTotal();
            });

            if (duplicateCount > 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '$duplicateCount duplicate recipient${duplicateCount == 1 ? '' : 's'} filtered out',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                  backgroundColor: btOrange,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
              );
            }

            if (newRecipients.length > 1) {
              _showBulkAmountDialog(newRecipients.length);
            }
          },
          alreadySelectedIds: _selectedRecipients.map((r) => r.recipient.id).toList(),
        ),
      ),
    );
  }

  void _showBulkAmountDialog(int recipientCount) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: btCardElevated,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          contentPadding: EdgeInsets.all(24.w),
          title: Column(
            children: [
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: btBlue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(26.r),
                ),
                child: Icon(Icons.payments_outlined, color: btBlue, size: 26.sp),
              ),
              SizedBox(height: 12.h),
              Text(
                'Bulk Amount Setup',
                style: GoogleFonts.inter(
                  color: btTextPrimary,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Apply same amount to $recipientCount recipients',
                style: GoogleFonts.inter(
                  color: btTextSecondary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8.h),

              // Amount input
              TextField(
                controller: _bulkAmountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                style: GoogleFonts.inter(
                  color: btTextPrimary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                onChanged: (value) => setDialogState(() {}),
                decoration: InputDecoration(
                  labelText: 'Amount per recipient',
                  labelStyle: GoogleFonts.inter(color: btTextSecondary, fontSize: 14.sp),
                  hintText: '0.00',
                  hintStyle: GoogleFonts.inter(color: btTextTertiary),
                  prefixText: '$_currencySymbol ',
                  prefixStyle: GoogleFonts.inter(
                    color: btGreen,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  filled: true,
                  fillColor: btBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: btBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: btBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: btBlue, width: 1.5),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                ),
              ),

              SizedBox(height: 12.h),

              // Reference input
              TextField(
                controller: _bulkReferenceController,
                style: GoogleFonts.inter(color: btTextPrimary, fontSize: 14.sp),
                decoration: InputDecoration(
                  labelText: 'Reference (Optional)',
                  labelStyle: GoogleFonts.inter(color: btTextSecondary, fontSize: 14.sp),
                  hintText: 'e.g., Monthly allowance',
                  hintStyle: GoogleFonts.inter(color: btTextTertiary, fontSize: 14.sp),
                  filled: true,
                  fillColor: btBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: btBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: btBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: btBlue, width: 1.5),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                ),
              ),

              // Total preview
              if (_bulkAmountController.text.isNotEmpty &&
                  double.tryParse(_bulkAmountController.text) != null)
                Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: btGreen.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: btGreen.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Per recipient',
                              style: GoogleFonts.inter(color: btTextSecondary, fontSize: 13.sp),
                            ),
                            Text(
                              '$_currencySymbol${double.parse(_bulkAmountController.text).toStringAsFixed(2)}',
                              style: GoogleFonts.inter(
                                color: btTextPrimary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Divider(color: btBorder, height: 1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total ($recipientCount recipients)',
                              style: GoogleFonts.inter(
                                color: btTextPrimary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '$_currencySymbol${(double.parse(_bulkAmountController.text) * recipientCount).toStringAsFixed(2)}',
                              style: GoogleFonts.inter(
                                color: btGreen,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _bulkAmountController.clear();
                      _bulkReferenceController.clear();
                      Navigator.pop(dialogContext);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: btTextSecondary,
                      side: const BorderSide(color: btBorder),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Text(
                      'Skip',
                      style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _bulkAmountController.text.isNotEmpty &&
                        double.tryParse(_bulkAmountController.text) != null &&
                        double.parse(_bulkAmountController.text) > 0
                      ? () {
                          final appliedAmount = double.parse(_bulkAmountController.text);
                          final appliedAmountText = '$_currencySymbol${appliedAmount.toStringAsFixed(2)}';

                          for (int i = 0; i < _selectedRecipients.length; i++) {
                            _selectedRecipients[i].amountController.text = _bulkAmountController.text;
                            if (_bulkReferenceController.text.isNotEmpty) {
                              _selectedRecipients[i].referenceController.text = _bulkReferenceController.text;
                            }
                          }

                          setState(() {
                            _calculateTotal();
                          });

                          _bulkAmountController.clear();
                          _bulkReferenceController.clear();
                          Navigator.pop(dialogContext);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Applied $appliedAmountText to all $recipientCount recipients',
                                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                              ),
                              backgroundColor: btGreen,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                            ),
                          );
                        }
                      : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _bulkAmountController.text.isNotEmpty &&
                          double.tryParse(_bulkAmountController.text) != null &&
                          double.parse(_bulkAmountController.text) > 0
                        ? btBlue
                        : btBorder,
                      foregroundColor: btTextPrimary,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Text(
                      'Apply to All',
                      style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _removeRecipient(int index) {
    setState(() {
      _selectedRecipients[index].dispose();
      _selectedRecipients.removeAt(index);
      _calculateTotal();
    });
  }

  void _toggleRecipientExpansion(int index) {
    setState(() {
      _selectedRecipients[index].isExpanded = !_selectedRecipients[index].isExpanded;
    });
  }

  bool get _canProceed {
    return _selectedRecipients.isNotEmpty &&
        _selectedRecipients.every((r) => r.isValid && r.amount >= 1.0);
  }

  void _proceedToBatchTransfer() {
    if (!_canProceed) return;

    // Self-transfer check
    final accountManager = GetIt.I<AccountManager>();
    final myAccountNumber = accountManager.activeAccountDetails?.accountNumber ?? '';
    if (myAccountNumber.isNotEmpty) {
      final selfTransfers = _selectedRecipients
          .where((r) => r.recipient.accountNumber == myAccountNumber)
          .toList();
      if (selfTransfers.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Cannot transfer to your own account',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            backgroundColor: btRed,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
        );
        return;
      }
    }

    // Balance check
    if (_accounts.isNotEmpty && _selectedAccountIndex < _accounts.length) {
      final selectedAccount = _accounts[_selectedAccountIndex];
      if (_totalAmount > selectedAccount.balance) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Insufficient balance. Available: $_currencySymbol${selectedAccount.balance.toStringAsFixed(2)}',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            backgroundColor: btRed,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
        );
        return;
      }
    }

    final recipients = _selectedRecipients.map((item) {
      final refText = item.referenceController.text.trim();
      return BatchTransferRecipient(
        toAccountNumber: item.recipient.accountNumber,
        amount: Int64((item.amount * 100).round()),
        reference: refText.isNotEmpty
            ? refText.substring(0, min(200, refText.length))
            : null,
        category: _categoryController.text.trim().isNotEmpty
            ? _categoryController.text.trim()
            : null,
      );
    }).toList();

    String fromAccountId;
    if (_accounts.isNotEmpty && _selectedAccountIndex < _accounts.length) {
      fromAccountId = _accounts[_selectedAccountIndex].id;
    } else {
      fromAccountId = accountManager.activeAccountDetails?.id ?? '0';
    }

    Get.toNamed(AppRoutes.batchTransferReview, arguments: {
      'recipients': recipients,
      'recipientItems': _selectedRecipients,
      'totalAmount': _totalAmount,
      'fromAccountId': fromAccountId,
      'category': _categoryController.text,
      'batchReference': _batchReferenceController.text,
      'currency': _currency,
      'currencySymbol': _currencySymbol,
      'selectedAccount': _accounts.isNotEmpty && _selectedAccountIndex < _accounts.length
          ? _accounts[_selectedAccountIndex]
          : null,
      'recipientNames': Map.fromEntries(
        _selectedRecipients.map((item) => MapEntry(item.recipient.accountNumber, item.recipient.name)),
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      listener: (context, state) {
        if (state is AccountCardsSummaryLoaded) {
          setState(() {
            _accounts = state.accountSummaries;
            _selectDefaultAccount();
          });
        } else if (state is AccountBalanceUpdated) {
          setState(() {
            _accounts = state.accountSummaries;
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),

            // Account selector section
            _buildSectionHeader('Transfer From', Icons.account_balance_wallet_outlined),
            SizedBox(height: 12.h),
            _buildAccountSelector(),

            SizedBox(height: 24.h),

            // Batch details section
            _buildSectionHeader('Batch Details', Icons.description_outlined),
            SizedBox(height: 12.h),
            _buildTextField(
              controller: _batchReferenceController,
              label: 'Batch Reference (Optional)',
              hint: 'e.g., Monthly Allowances',
            ),
            SizedBox(height: 10.h),
            _buildTextField(
              controller: _categoryController,
              label: 'Category (Optional)',
              hint: 'e.g., Salary, Commission',
            ),

            SizedBox(height: 28.h),

            // Recipients section header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionHeader(
                  'Recipients (${_selectedRecipients.length}/$_maxRecipients)',
                  Icons.people_outline,
                ),
                GestureDetector(
                  onTap: _showMultipleRecipientSelection,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: btBlue,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, color: btTextPrimary, size: 16.sp),
                        SizedBox(width: 4.w),
                        Text(
                          'Add',
                          style: GoogleFonts.inter(
                            color: btTextPrimary,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Bulk amount button
            if (_selectedRecipients.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: GestureDetector(
                  onTap: () => _showBulkAmountDialog(_selectedRecipients.length),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: btBlue.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: btBlue.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: BoxDecoration(
                            color: btBlue.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          child: Icon(Icons.attach_money, color: btBlue, size: 18.sp),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Set Amount for All',
                                style: GoogleFonts.inter(
                                  color: btTextPrimary,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Apply same amount to ${_selectedRecipients.length} recipients',
                                style: GoogleFonts.inter(
                                  color: btTextSecondary,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right, color: btTextSecondary, size: 20.sp),
                      ],
                    ),
                  ),
                ),
              ),

            SizedBox(height: 16.h),

            // Recipients list or empty state
            if (_selectedRecipients.isEmpty)
              _buildEmptyState()
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _selectedRecipients.length,
                itemBuilder: (context, index) => _buildRecipientCard(index),
              ),

            SizedBox(height: 24.h),

            // Total amount section
            if (_selectedRecipients.isNotEmpty)
              _buildTotalSection(),

            SizedBox(height: 24.h),

            // Proceed button
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: _canProceed ? _proceedToBatchTransfer : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _canProceed ? btBlue : btBorder,
                  foregroundColor: btTextPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                ),
                child: _isLoading
                  ? SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(btTextPrimary),
                      ),
                    )
                  : Text(
                      _selectedRecipients.isEmpty
                        ? 'Add Recipients to Continue'
                        : 'Continue to Review',
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  // --- Account Selector ---
  Widget _buildAccountSelector() {
    if (_accounts.isEmpty) {
      return Container(
        height: 90.h,
        decoration: BoxDecoration(
          color: btCardElevated,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: btBorder),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 16.w,
                height: 16.w,
                child: const CircularProgressIndicator(strokeWidth: 2, color: btBlue),
              ),
              SizedBox(width: 12.w),
              Text(
                'Loading accounts...',
                style: GoogleFonts.inter(color: btTextSecondary, fontSize: 14.sp),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _accounts.length,
        itemBuilder: (context, index) {
          final account = _accounts[index];
          final isSelected = index == _selectedAccountIndex;
          final typeColor = _getAccountTypeColor(account.accountType);

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedAccountIndex = index;
                _updateCurrencyFromAccount();
              });
            },
            child: Container(
              width: 200.w,
              margin: EdgeInsets.only(right: 12.w),
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: isSelected ? typeColor.withValues(alpha: 0.1) : btCardElevated,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isSelected ? typeColor : btBorder,
                  width: isSelected ? 1.5 : 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 28.w,
                        height: 28.w,
                        decoration: BoxDecoration(
                          color: typeColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          _getAccountTypeIcon(account.accountType),
                          color: typeColor,
                          size: 14.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          account.displayName,
                          style: GoogleFonts.inter(
                            color: btTextPrimary,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isSelected)
                        Icon(Icons.check_circle, color: typeColor, size: 18.sp),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${CurrencyUtils.getSymbol(account.currency)}${account.balance.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          color: btTextPrimary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '\u2022\u2022\u2022\u2022 ${account.accountNumberLast4}',
                        style: GoogleFonts.inter(
                          color: btTextSecondary,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getAccountTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'savings':
        return btGreen;
      case 'investment':
        return btOrange;
      case 'family':
      case 'family & friends':
        return btPurple;
      case 'business':
        return const Color(0xFF06B6D4);
      default:
        return btBlue;
    }
  }

  IconData _getAccountTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'savings':
        return Icons.savings_outlined;
      case 'investment':
        return Icons.trending_up;
      case 'family':
      case 'family & friends':
        return Icons.family_restroom;
      case 'business':
        return Icons.business;
      default:
        return Icons.account_balance_wallet_outlined;
    }
  }

  // --- Total Section with balance warning ---
  Widget _buildTotalSection() {
    final hasInsufficientBalance = _accounts.isNotEmpty &&
        _selectedAccountIndex < _accounts.length &&
        _totalAmount > _accounts[_selectedAccountIndex].balance;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: btCardElevated,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: hasInsufficientBalance ? btRed.withValues(alpha: 0.5) : btBorder,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Amount',
                    style: GoogleFonts.inter(
                      color: btTextPrimary,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${_selectedRecipients.length} recipient${_selectedRecipients.length == 1 ? '' : 's'} \u2022 Free',
                    style: GoogleFonts.inter(
                      color: btTextSecondary,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              Text(
                '$_currencySymbol${_totalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: hasInsufficientBalance ? btRed : (_totalAmount > 0 ? btGreen : btTextPrimary),
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          if (hasInsufficientBalance) ...[
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: btRed.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: btRed.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: btRed, size: 16.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Insufficient balance. Available: $_currencySymbol${_accounts[_selectedAccountIndex].balance.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        color: btRed,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: btTextSecondary, size: 18.sp),
        SizedBox(width: 8.w),
        Text(
          title,
          style: GoogleFonts.inter(
            color: btTextPrimary,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.inter(color: btTextPrimary, fontSize: 14.sp),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(color: btTextSecondary, fontSize: 14.sp),
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: btTextTertiary, fontSize: 14.sp),
        filled: true,
        fillColor: btCardElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: btBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: btBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: btBlue, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 24.w),
      decoration: BoxDecoration(
        color: btCardElevated,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: btBorder),
      ),
      child: Column(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: btBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Icon(Icons.group_add_outlined, color: btBlue, size: 32.sp),
          ),
          SizedBox(height: 16.h),
          Text(
            'No recipients added',
            style: GoogleFonts.inter(
              color: btTextPrimary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Tap "Add" to select saved recipients\nor search for LazerVault users',
            style: GoogleFonts.inter(
              color: btTextSecondary,
              fontSize: 13.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientCard(int index) {
    final recipientItem = _selectedRecipients[index];
    final recipient = recipientItem.recipient;
    final isLazerTag = recipient.bankName == 'LazerVault';

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: btCardElevated,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: recipientItem.isValid
            ? btGreen.withValues(alpha: 0.3)
            : recipientItem.amount == 0
              ? btBorder
              : btRed.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          // Main card content
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _toggleRecipientExpansion(index),
              borderRadius: BorderRadius.circular(16.r),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: isLazerTag
                          ? btPurple.withValues(alpha: 0.15)
                          : btBlue.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(22.r),
                      ),
                      child: Center(
                        child: isLazerTag
                          ? Icon(Icons.alternate_email, color: btPurple, size: 20.sp)
                          : Text(
                              recipient.name.isNotEmpty
                                ? recipient.name.substring(0, 1).toUpperCase()
                                : '?',
                              style: GoogleFonts.inter(
                                color: btBlue,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                      ),
                    ),
                    SizedBox(width: 12.w),

                    // Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  recipient.name,
                                  style: GoogleFonts.inter(
                                    color: btTextPrimary,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (isLazerTag) ...[
                                SizedBox(width: 6.w),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: btPurple.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    'LV',
                                    style: GoogleFonts.inter(
                                      color: btPurple,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '${recipient.bankName} \u2022 ${isLazerTag ? recipient.accountNumber : (recipient.accountNumber.length > 4 ? '\u2022\u2022\u2022 ${recipient.accountNumber.substring(recipient.accountNumber.length - 4)}' : recipient.accountNumber)}',
                            style: GoogleFonts.inter(
                              color: btTextSecondary,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Amount badge
                    if (recipientItem.amount > 0)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: btGreen.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: btGreen.withValues(alpha: 0.2)),
                        ),
                        child: Text(
                          '$_currencySymbol${recipientItem.amount.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            color: btGreen,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    else
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: btOrange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: btOrange.withValues(alpha: 0.2)),
                        ),
                        child: Text(
                          'Set amount',
                          style: GoogleFonts.inter(
                            color: btOrange,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                    SizedBox(width: 8.w),

                    // Actions
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => _toggleRecipientExpansion(index),
                          child: Icon(
                            recipientItem.isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: btTextSecondary,
                            size: 22.sp,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        GestureDetector(
                          onTap: () => _removeRecipient(index),
                          child: Icon(
                            Icons.close,
                            color: btRed.withValues(alpha: 0.7),
                            size: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Expanded content
          if (recipientItem.isExpanded)
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.w),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: btBorder)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 14.h),

                  // Amount input
                  TextFormField(
                    controller: recipientItem.amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                    style: GoogleFonts.inter(
                      color: btTextPrimary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    onChanged: (value) => _calculateTotal(),
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      labelStyle: GoogleFonts.inter(color: btTextSecondary, fontSize: 14.sp),
                      hintText: '0.00',
                      hintStyle: GoogleFonts.inter(color: btTextTertiary),
                      prefixText: '$_currencySymbol ',
                      prefixStyle: GoogleFonts.inter(
                        color: btGreen,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      filled: true,
                      fillColor: btBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: btBorder),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: btBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: btBlue, width: 1.5),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // Reference input
                  TextFormField(
                    controller: recipientItem.referenceController,
                    style: GoogleFonts.inter(color: btTextPrimary, fontSize: 14.sp),
                    decoration: InputDecoration(
                      labelText: 'Reference (Optional)',
                      labelStyle: GoogleFonts.inter(color: btTextSecondary, fontSize: 14.sp),
                      hintText: 'e.g., Payment for services',
                      hintStyle: GoogleFonts.inter(color: btTextTertiary, fontSize: 14.sp),
                      filled: true,
                      fillColor: btBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: btBorder),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: btBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: btBlue, width: 1.5),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
