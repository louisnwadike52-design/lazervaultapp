import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/utils/debouncer.dart';
import 'package:lazervault/core/utils/user_search_query.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';

import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Bottom sheet for searching and selecting LazerVault users (username, email, or phone).
class UsernameSearchBottomSheet extends StatefulWidget {
  final Function(UserSearchResultEntity) onUserSelected;

  const UsernameSearchBottomSheet({
    super.key,
    required this.onUserSelected,
  });

  /// Show the bottom sheet and return the selected user
  static Future<UserSearchResultEntity?> show(BuildContext context) async {
    UserSearchResultEntity? selectedUser;

    await Get.bottomSheet(
      UsernameSearchBottomSheet(
        onUserSelected: (user) {
          selectedUser = user;
          Get.back();
        },
      ),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
      backgroundColor: Colors.transparent,
    );

    return selectedUser;
  }

  @override
  State<UsernameSearchBottomSheet> createState() =>
      _UsernameSearchBottomSheetState();
}

class _UsernameSearchBottomSheetState extends State<UsernameSearchBottomSheet> {
  // Page size for the user search. Each load-more fetch appends another page.
  static const int _pageSize = 20;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  // snappy() = 250ms; on 80-150ms Nigerian 4G this makes results feel
  // near-instant while still consolidating bursty keypresses.
  final Debouncer _debouncer = Debouncer.snappy();
  List<UserSearchResultEntity> _searchResults = [];
  final Set<String> _seenUserIds = <String>{};
  bool _isSearching = false; // first-page load
  bool _isLoadingMore = false; // appending a subsequent page
  bool _hasMore = false; // more pages may exist on the backend
  String? _errorMessage;
  // The query the current result set belongs to; guards against stale appends.
  String _activeQuery = '';
  // Raw rows fetched so far for the active query == the next backend offset.
  // Tracked separately from _searchResults.length so client-side dedupe never
  // shifts the offset (which would re-fetch / skip rows on the backend).
  int _fetchedCount = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Auto-focus the search field when sheet opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    // Trigger when within 300px of the bottom so the next page is ready by
    // the time the user reaches it.
    if (position.pixels >= position.maxScrollExtent - 300) {
      _loadMore();
    }
  }

  void _onSearchChanged(String query) {
    // Cancel any pending search
    _debouncer.cancel();

    final normalized = normalizeLazerVaultUserSearchQuery(query);

    if (normalized.isEmpty || normalized.length < 2) {
      // Reset everything (covers empty + below-minimum-length).
      setState(() {
        _searchResults = [];
        _seenUserIds.clear();
        _isSearching = false;
        _isLoadingMore = false;
        _hasMore = false;
        _activeQuery = '';
        _fetchedCount = 0;
        _errorMessage = null;
      });
      return;
    }

    // New query: reset pagination state before starting the first page.
    setState(() {
      _isSearching = true;
      _isLoadingMore = false;
      _hasMore = false;
      _searchResults = [];
      _seenUserIds.clear();
      _fetchedCount = 0;
      _errorMessage = null;
    });

    // Debounce the search - wait until the user pauses typing.
    _debouncer.run(() => _performSearch(query));
  }

  Future<void> _performSearch(String query) async {
    final normalized = normalizeLazerVaultUserSearchQuery(query);
    _activeQuery = normalized;
    try {
      print('[UsernameSearch] Searching for: "$query"');
      final cubit = serviceLocator<ProfileCubit>();
      final results = await cubit.searchUsers(query, limit: _pageSize, offset: 0);
      print('[UsernameSearch] Got ${results.length} results');
      // Ignore if the query changed while this request was in flight.
      if (!mounted || normalized != _activeQuery) return;
      final deduped = _dedupe(results);
      setState(() {
        _searchResults = deduped;
        _isSearching = false;
        _fetchedCount = results.length;
        // A full page back implies there may be more to fetch.
        _hasMore = results.length >= _pageSize;
        _errorMessage = deduped.isEmpty ? 'No users found' : null;
      });
    } catch (e) {
      print('[UsernameSearch] Error: $e');
      if (!mounted || normalized != _activeQuery) return;
      setState(() {
        _searchResults = [];
        _seenUserIds.clear();
        _isSearching = false;
        _fetchedCount = 0;
        _hasMore = false;
        _errorMessage = 'Failed to search users';
      });
    }
  }

  Future<void> _loadMore() async {
    // Guard: only page when idle, more exists, and a query is active.
    if (_isLoadingMore || _isSearching || !_hasMore) return;
    if (_activeQuery.length < 2) return;

    final queryAtRequest = _activeQuery;
    setState(() => _isLoadingMore = true);
    try {
      final cubit = serviceLocator<ProfileCubit>();
      final results = await cubit.searchUsers(
        _activeQuery,
        limit: _pageSize,
        offset: _fetchedCount,
      );
      if (!mounted || queryAtRequest != _activeQuery) return;
      final newItems = _dedupe(results);
      setState(() {
        _searchResults = [..._searchResults, ...newItems];
        _isLoadingMore = false;
        _fetchedCount += results.length;
        // Stop when the backend returns a short page (end reached). A full page
        // of all-duplicates also stops paging to avoid an infinite loop.
        _hasMore = results.length >= _pageSize && newItems.isNotEmpty;
      });
    } catch (e) {
      print('[UsernameSearch] Load-more error: $e');
      if (!mounted || queryAtRequest != _activeQuery) return;
      // Keep existing results; allow a retry on the next scroll.
      setState(() => _isLoadingMore = false);
    }
  }

  /// Filters out users already shown (by userId) and records the new ones.
  List<UserSearchResultEntity> _dedupe(List<UserSearchResultEntity> incoming) {
    final out = <UserSearchResultEntity>[];
    for (final u in incoming) {
      final id = u.userId;
      if (id.isEmpty || _seenUserIds.add(id)) {
        out.add(u);
      }
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          // Handle bar
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.close,
                        color: Colors.grey[600],
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      'Find Lazervault user',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Search by username, phone number, or email (partial or full)',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Search Field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _focusNode,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16.sp,
                ),
                decoration: InputDecoration(
                  hintText: 'Username, phone, or email',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16.sp,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[600],
                    size: 22.sp,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            _onSearchChanged('');
                          },
                          child: Icon(
                            Icons.clear,
                            color: Colors.grey[600],
                            size: 20.sp,
                          ),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                ),
                onChanged: _onSearchChanged,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Results Section
          Expanded(
            child: _buildResultsContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsContent() {
    // Loading state
    if (_isSearching) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LazerVaultLoader.small(),
            SizedBox(height: 16.h),
            Text(
              'Searching...',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      );
    }

    // Empty state - no search yet
    if (_searchController.text.isEmpty) {
      return _buildEmptyState(
        icon: Icons.search,
        title: 'Search for users',
        subtitle: 'Type at least 2 characters to search',
      );
    }

    // Error state
    if (_errorMessage != null && _searchResults.isEmpty) {
      return _buildEmptyState(
        icon: Icons.person_off_outlined,
        title: _errorMessage!,
        subtitle: 'Try a different name, @username, phone, or email',
      );
    }

    // Results list with load-more-on-scroll. A trailing footer cell shows the
    // pagination spinner while the next page is being fetched.
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      itemCount: _searchResults.length + (_isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= _searchResults.length) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Center(child: LazerVaultLoader.small()),
          );
        }
        final user = _searchResults[index];
        return _buildUserResultCard(user);
      },
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.grey[400],
              size: 48.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserResultCard(UserSearchResultEntity user) {
    return GestureDetector(
      onTap: () => widget.onUserSelected(user),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: user.profilePicture.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        user.profilePicture,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildInitialsAvatar(user),
                      ),
                    )
                  : _buildInitialsAvatar(user),
            ),
            SizedBox(width: 12.w),

            // User Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    user.searchMatchInfo,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 78, 3, 208),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Select indicator
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialsAvatar(UserSearchResultEntity user) {
    return Center(
      child: Text(
        user.initials,
        style: TextStyle(
          color: const Color.fromARGB(255, 78, 3, 208),
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
