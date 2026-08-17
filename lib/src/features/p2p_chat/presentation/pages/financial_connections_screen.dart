import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/connection_birthday_entity.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/services/auto_logout_guard.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/debouncer.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_conversation_entity.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_conversations_cubit.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_conversations_state.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/get_recipients_usecase.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/unified_user_search_sheet.dart';
import 'package:lazervault/src/features/widgets/user_avatar.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_chat_snapshot_cache.dart';
part 'financial_connections_screen_widgets.dart';


class FinancialConnectionsScreen extends StatefulWidget {
  const FinancialConnectionsScreen({super.key});

  @override
  State<FinancialConnectionsScreen> createState() =>
      _FinancialConnectionsScreenState();
}

class _FinancialConnectionsScreenState
    extends State<FinancialConnectionsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer.search();
  bool _isSearching = false;
  bool _requestsExpanded = true;

  /// The active chat-list filter pill (Chats / Unread / Archived).
  _ChatFilter _filter = _ChatFilter.chats;

  /// Whether the manual "add someone" button (arbitrary search-to-add) is
  /// shown. Kept OFF: a financial connection is established only by sending
  /// money to a Lazervault user. Flip to true to re-expose the wired-but-hidden
  /// [_openUnifiedSearch] flow.
  static const bool _kManualAddVisible = false;

  /// Live text used to filter the ON-PAGE listing (connections + requests +
  /// saved contacts). Search is an in-place filter of what's already loaded —
  /// it does NOT open a bottom sheet or hit the server. (Starting a chat with
  /// someone brand new is the "New chat" FAB.)
  String _query = '';

  /// Saved internal recipients (deduped by internalUserId)
  List<RecipientModel> _savedContacts = [];
  bool _contactsLoading = false;

  /// Removes this page's inactivity-auto-logout suppression on dispose.
  VoidCallback? _releaseAutoLogout;

  @override
  void initState() {
    super.initState();
    // Financial connections is an exempt page: don't auto-logout while it's open
    // (re-enables on navigate-away, since dispose always fires on route pop).
    _releaseAutoLogout = AutoLogoutGuard.register(() => true);
    // Paint cached saved contacts immediately (no "Loading..." flash on
    // re-entry); the fetch below reconciles them silently.
    _savedContacts = List<RecipientModel>.from(p2pSavedContactsCache);
    context.read<P2PConversationsCubit>().loadConversations();
    _loadSavedContacts();
  }

  @override
  void dispose() {
    _releaseAutoLogout?.call();
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  /// Load saved internal recipients from the backend.
  /// Stable value-signature of a saved-contacts list (id + name + avatar), used
  /// to skip a redundant rebuild when a refresh returns the same contacts.
  String _contactsSignature(List<RecipientModel> xs) => xs
      .map((r) => '${r.internalUserId}|${r.name}|${r.profileImageUrl ?? ''}')
      .join(',');

  Future<void> _loadSavedContacts() async {
    if (!mounted) return;
    // Only show the inline loading row on a true cold load (no cache yet).
    // A warm re-entry reconciles silently behind the already-painted list.
    if (!p2pSavedContactsCacheLoaded) {
      setState(() => _contactsLoading = true);
    }

    try {
      // Get access token — handle missing AuthenticationCubit gracefully
      String? accessToken;
      try {
        final authState = context.read<AuthenticationCubit>().state;
        accessToken = switch (authState) {
          AuthenticationSuccess s => s.profile.session.accessToken,
          AuthenticationAuthenticated s => s.profile.session.accessToken,
          _ => null,
        };
      } catch (_) {
        // AuthenticationCubit not in tree
        if (mounted) setState(() => _contactsLoading = false);
        return;
      }

      if (accessToken == null) {
        if (mounted) setState(() => _contactsLoading = false);
        return;
      }

      // Get recipients use case — handle missing DI registration
      GetRecipientsUseCase getRecipientsUseCase;
      try {
        getRecipientsUseCase = serviceLocator<GetRecipientsUseCase>();
      } catch (_) {
        debugPrint('GetRecipientsUseCase not registered in DI');
        if (mounted) setState(() => _contactsLoading = false);
        return;
      }

      final result = await getRecipientsUseCase(accessToken: accessToken);

      if (!mounted) return;

      result.fold(
        (failure) {
          debugPrint('Failed to load saved contacts: ${failure.message}');
          setState(() => _contactsLoading = false);
        },
        (recipients) {
          // Filter to only internal (LazerVault) recipients with internalUserId
          final internalRecipients = recipients
              .where((r) =>
                  r.bankName == 'LazerVault' &&
                  r.internalUserId != null &&
                  r.internalUserId!.isNotEmpty)
              .toList();

          // Dedup by internalUserId — keep the first (most recently saved) occurrence
          final seen = <String>{};
          final deduped = <RecipientModel>[];
          for (final r in internalRecipients) {
            if (seen.add(r.internalUserId!)) {
              deduped.add(r);
            }
          }

          // Refresh the process-lifetime cache so the next entry is instant.
          p2pSavedContactsCache = deduped;
          p2pSavedContactsCacheLoaded = true;
          // Skip the rebuild entirely when nothing changed (the common case on a
          // warm re-entry from a chat/image viewer). A no-op setState would
          // rebuild the whole screen and re-fade the "pill" avatars — the
          // flicker. Only setState when the contact set or the loading flag
          // actually changed.
          final unchanged = !_contactsLoading &&
              _contactsSignature(deduped) == _contactsSignature(_savedContacts);
          if (unchanged) return;
          setState(() {
            _savedContacts = deduped;
            _contactsLoading = false;
          });
        },
      );
    } catch (e) {
      debugPrint('Error loading saved contacts: $e');
      if (mounted) setState(() => _contactsLoading = false);
    }
  }

  /// Filter saved contacts to exclude those who already have a conversation
  /// OR an incoming request (prevents duplicates across all sections).
  List<RecipientModel> _getContactsWithoutConversation(
    List<P2PConversationEntity> conversations,
    List<P2PConversationEntity> incomingRequests,
  ) {
    final existingUserIds = <String>{};
    for (final c in conversations) {
      existingUserIds.add(c.otherUserId);
    }
    for (final r in incomingRequests) {
      existingUserIds.add(r.otherUserId);
    }
    return _savedContacts
        .where((r) => !existingUserIds.contains(r.internalUserId))
        .toList();
  }

  /// In-place filter of the already-loaded listing — no server call, no sheet.
  void _onSearchChanged(String query) {
    setState(() => _query = query.trim());
  }

  void _closeSearch() {
    _searchController.clear();
    setState(() {
      _isSearching = false;
      _query = '';
    });
    FocusScope.of(context).unfocus();
  }

  /// Case-insensitive match of a person's display name against the live query.
  bool _matchesQuery(String? name) {
    if (_query.isEmpty) return true;
    return (name ?? '').toLowerCase().contains(_query.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Slightly lifted off pure black — softer, more professional surface.
      backgroundColor: const Color(0xFF101012),
      appBar: AppBar(
        backgroundColor: const Color(0xFF101012),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            if (_isSearching) {
              _closeSearch();
            } else {
              Get.back();
            }
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        titleSpacing: 0,
        title: _isSearching
            ? _buildSearchField()
            : Text(
                'Financial Connections',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
        centerTitle: !_isSearching,
        actions: [
          // The search filters the on-page listing in place (no bottom sheet).
          IconButton(
            tooltip: _isSearching ? 'Close search' : 'Search connections',
            onPressed: () {
              if (_isSearching) {
                _closeSearch();
              } else {
                setState(() => _isSearching = true);
              }
            },
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      // A financial connection is established ONLY when you send money to a
      // Lazervault user — so the manual "add someone" button is hidden. The
      // search-to-add flow (_openUnifiedSearch) is kept fully wired behind
      // [_kManualAddVisible] so it can be re-enabled without rebuilding it.
      floatingActionButton: (!_kManualAddVisible || _isSearching)
          ? null
          : FloatingActionButton(
              onPressed: _openUnifiedSearch,
              backgroundColor: const Color(0xFF3B82F6),
              tooltip: 'New chat',
              child: const Icon(Icons.add_comment_rounded, color: Colors.white),
            ),
      // Tap anywhere outside the search field dismisses the keyboard.
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<P2PConversationsCubit, P2PConversationsState>(
          listener: (context, state) {
            // Also dismiss the keyboard when a search errors or returns no
            // matches, so the error / "no users found" state isn't hidden
            // behind the keyboard.
            if (state is P2PConversationsError ||
                (state is P2PUserSearchResults && state.users.isEmpty)) {
              FocusScope.of(context).unfocus();
            }
          },
          builder: (context, state) {
            if (state is P2PConversationsLoading) {
              return const Center(
                child: LazerVaultLoader.small(),
              );
            }

            if (state is P2PConversationsError) {
              return _buildErrorState(state.message);
            }

            if (state is P2PUserSearchLoading) {
              return const Center(
                child: LazerVaultLoader.small(),
              );
            }

            if (state is P2PUserSearchResults) {
              return _buildSearchResults(state.users);
            }

            if (state is P2PConversationsLoaded) {
              return _buildConnectionsList(state);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
      decoration: InputDecoration(
        hintText: 'Search connections...',
        hintStyle: GoogleFonts.inter(
          color: const Color(0xFF9CA3AF),
          fontSize: 16.sp,
        ),
        border: InputBorder.none,
        isCollapsed: true,
      ),
      onChanged: _onSearchChanged,
    );
  }

  Widget _buildSearchResults(List<Map<String, dynamic>> users) {
    if (users.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person_search, size: 48.w, color: const Color(0xFF9CA3AF)),
            SizedBox(height: 12.h),
            Text(
              'No users found',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final name = _getUserDisplayName(user);
        final username = user['username'] as String? ?? '';

        return ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 4.h),
          leading: CircleAvatar(
            radius: 22.r,
            backgroundColor: const Color(0xFF3B82F6),
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          title: Text(
            name,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: username.isNotEmpty
              ? Text(
                  '@$username',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                  ),
                )
              : null,
          onTap: () => _onUserTapped(user),
        );
      },
    );
  }

  Widget _buildConnectionsList(P2PConversationsLoaded state) {
    // Apply the in-place search filter, then split by the selected pill.
    final requests = state.incomingRequests
        .where((c) => _matchesQuery(c.otherUserName))
        .toList();
    final searched = state.conversations
        .where((c) => _matchesQuery(c.otherUserName))
        .toList();

    final conversations = switch (_filter) {
      _ChatFilter.chats => searched.where((c) => !c.isArchived).toList(),
      _ChatFilter.unread =>
        searched.where((c) => !c.isArchived && c.unreadCount > 0).toList(),
      _ChatFilter.archived => searched.where((c) => c.isArchived).toList(),
      // Birthdays is its own tab — it lists upcoming birthdays, not conversations.
      _ChatFilter.birthdays => searched.where((c) => false).toList(),
    };

    // Pill badge counts (from the full, unsearched list).
    final unreadPillCount = state.conversations
        .where((c) => !c.isArchived && c.unreadCount > 0)
        .length;
    final archivedPillCount =
        state.conversations.where((c) => c.isArchived).length;
    final birthdaysPillCount = state.upcomingBirthdays.length;

    // Requests + saved-contacts belong to the main "Chats" view only.
    final onChats = _filter == _ChatFilter.chats;
    // The Birthdays tab shows upcoming-birthday tiles instead of conversations.
    final onBirthdays = _filter == _ChatFilter.birthdays;
    final contactsWithoutConv = onChats
        ? _getContactsWithoutConversation(
            state.conversations,
            state.incomingRequests,
          ).where((r) => _matchesQuery(r.displayName)).toList()
        : <RecipientModel>[];

    final hasRequests = onChats && requests.isNotEmpty;
    final hasConnections = conversations.isNotEmpty;
    // Saved-contacts (start a chat without sending money) is a manual add path,
    // so it's hidden alongside the add button — connections form on money send.
    final hasContacts = _kManualAddVisible && contactsWithoutConv.isNotEmpty;
    final hasBirthdays = onBirthdays && state.upcomingBirthdays.isNotEmpty;
    final anything = onBirthdays
        ? hasBirthdays
        : (hasRequests || hasConnections || hasContacts);

    return Column(
      children: [
        _buildFilterPills(
          unread: unreadPillCount,
          archived: archivedPillCount,
          birthdays: birthdaysPillCount,
        ),
        Expanded(
          // Enables Slidable `groupTag` auto-close: opening one row's swipe
          // actions closes any other open row.
          child: SlidableAutoCloseBehavior(
          child: RefreshIndicator(
            onRefresh: _refreshAll,
            color: const Color(0xFF3B82F6),
            backgroundColor: const Color(0xFF1A1A1C),
            child: (!anything && !_contactsLoading)
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(height: 100.h),
                      _emptyForFilter(),
                    ],
                  )
                : ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 96.h),
                    children: onBirthdays
                        ? [
                            // Birthdays tab: only upcoming-birthday tiles (7-day window).
                            _buildSectionHeader('UPCOMING BIRTHDAYS'),
                            ...state.upcomingBirthdays.map(_buildBirthdayTile),
                          ]
                        : [
                            if (hasRequests) ...[
                              _buildRequestsSection(requests),
                              SizedBox(height: 8.h),
                            ],
                            if (hasConnections) ...[
                              _buildSectionHeader(switch (_filter) {
                                _ChatFilter.chats => 'CONNECTIONS',
                                _ChatFilter.unread => 'UNREAD',
                                _ChatFilter.archived => 'ARCHIVED',
                                _ChatFilter.birthdays => 'BIRTHDAYS',
                              }),
                              ...conversations.map(_buildConnectionTile),
                            ],
                            if (_kManualAddVisible &&
                                (hasContacts ||
                                    (_contactsLoading && !hasConnections))) ...[
                              if (hasConnections) SizedBox(height: 8.h),
                              if (_contactsLoading && !hasContacts)
                                _buildContactsLoadingIndicator()
                              else if (hasContacts) ...[
                                _buildSectionHeader('SAVED CONTACTS'),
                                ...contactsWithoutConv.map(_buildContactTile),
                              ],
                            ],
                          ],
                  ),
          ),
          ),
        ),
      ],
    );
  }

  /// The Chats / Unread / Archived filter pills. Always visible so the user can
  /// switch even when the current filter is empty.
  Widget _buildFilterPills({
    required int unread,
    required int archived,
    required int birthdays,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 10.h),
      // Horizontally scrollable so the pills never overflow on narrow screens.
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _filterPill(label: 'Chats', filter: _ChatFilter.chats),
            SizedBox(width: 8.w),
            _filterPill(
                label: 'Unread', filter: _ChatFilter.unread, count: unread),
            SizedBox(width: 8.w),
            _filterPill(
                label: 'Archived',
                filter: _ChatFilter.archived,
                count: archived),
            SizedBox(width: 8.w),
            _filterPill(
                label: 'Birthdays',
                filter: _ChatFilter.birthdays,
                count: birthdays),
          ],
        ),
      ),
    );
  }

  Widget _filterPill({
    required String label,
    required _ChatFilter filter,
    int count = 0,
  }) {
    final selected = _filter == filter;
    return GestureDetector(
      onTap: () {
        if (_filter != filter) setState(() => _filter = filter);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF3B82F6) : const Color(0xFF202024),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: selected ? Colors.white : const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (count > 0) ...[
              SizedBox(width: 6.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: selected
                      ? Colors.white.withValues(alpha: 0.25)
                      : const Color(0xFF3B82F6),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  count > 99 ? '99+' : '$count',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Per-filter empty state (also covers a search that matches nothing).
  Widget _emptyForFilter() {
    if (_query.isNotEmpty) {
      return _buildEmptyState(
        icon: Icons.search_off_rounded,
        title: 'No matches',
        subtitle: 'No connection matches "$_query".',
        shrink: true,
      );
    }
    return switch (_filter) {
      _ChatFilter.unread => _buildEmptyState(
          icon: Icons.mark_chat_read_outlined,
          title: 'You\'re all caught up',
          subtitle: 'No unread messages right now.',
          shrink: true,
        ),
      _ChatFilter.archived => _buildEmptyState(
          icon: Icons.archive_outlined,
          title: 'No archived chats',
          subtitle:
              'Swipe a chat and tap Archive to tuck it away here and keep your list clean.',
          shrink: true,
        ),
      _ChatFilter.chats => _buildEmptyState(
          icon: Icons.people_outline,
          title: 'No connections yet',
          subtitle:
              'Send money to a Lazervault user and a financial connection is created automatically.',
          shrink: true,
        ),
      _ChatFilter.birthdays => _buildEmptyState(
          icon: Icons.cake_outlined,
          title: 'No birthdays coming up',
          subtitle:
              'Birthdays of your connections appear here 7 days before the date.',
          shrink: true,
        ),
    };
  }

  /// Finer section label — uppercase, tracked, secondary color.
  /// One "upcoming birthday" row for a financial connection. Highlights the day
  /// itself; otherwise shows a soft "in N days" pill.
  Widget _buildBirthdayTile(ConnectionBirthdayEntity b) {
    final today = b.isToday;
    final accent =
        today ? const Color(0xFFDB2777) : const Color(0xFF7C3AED);
    return _cardShell(
      child: Row(
        children: [
          _peerAvatar(name: b.name, size: 44),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  b.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  today
                      ? '🎂 Birthday today — send your wishes!'
                      : '🎈 Birthday ${b.whenLabel.toLowerCase()}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              b.whenLabel,
              style: GoogleFonts.inter(
                color: accent,
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String label) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, top: 8.h, bottom: 8.h),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: const Color(0xFF6B7280),
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  /// Rounded card shell shared by every list row — the "finer" item styling.
  Widget _cardShell(
      {required Widget child, VoidCallback? onTap, VoidCallback? onLongPress}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        // Contrasting raised surface instead of a thin hairline border: a
        // slightly lighter card on the dark page + a soft shadow reads as an
        // elevated item and fits the theme better than tiny borders.
        color: const Color(0xFF202024),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.28),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    bool shrink = false,
  }) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 64.w, color: const Color(0xFF9CA3AF)),
        SizedBox(height: 16.h),
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.w),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
    return shrink ? Center(child: content) : Center(child: content);
  }

  /// Peer avatar for list rows: profile picture if present, else 2-initial
  /// fallback (the shared dashboard [UserAvatar]).
  Widget _peerAvatar({
    required String name,
    String? imageUrl,
    double size = 46,
    Color? backgroundColor,
  }) {
    final parts = name.trim().split(RegExp(r'\s+'));
    final first = parts.isNotEmpty ? parts.first : '';
    final last = parts.length > 1 ? parts.last : '';
    return UserAvatar(
      size: size.w,
      imageUrl: imageUrl,
      firstName: first,
      lastName: last,
      backgroundColor: backgroundColor,
    );
  }

  Future<void> _refreshAll() async {
    await Future.wait([
      context.read<P2PConversationsCubit>().refresh(),
      _loadSavedContacts(),
    ]);
  }

  Widget _buildContactsLoadingIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
      child: Row(
        children: [
          LazerVaultLoader.tiny(),
          SizedBox(width: 12.w),
          Text(
            'Loading saved contacts...',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestsSection(List<P2PConversationEntity> requests) {
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _requestsExpanded = !_requestsExpanded),
          child: Padding(
            padding: EdgeInsets.only(left: 4.w, top: 8.h, bottom: 8.h),
            child: Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFB923C).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '${requests.length}',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFFB923C),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'CONNECTION REQUESTS',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6B7280),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
                const Spacer(),
                Icon(
                  _requestsExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xFF9CA3AF),
                  size: 20.w,
                ),
              ],
            ),
          ),
        ),
        if (_requestsExpanded)
          ...requests.map(_buildRequestTile),
      ],
    );
  }

  Widget _buildRequestTile(P2PConversationEntity request) {
    final name = request.otherUserName ?? 'Unknown User';
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1C),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFFB923C).withOpacity(0.35),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          _peerAvatar(name: name, imageUrl: request.otherUserAvatar, size: 42),
          SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (request.lastMessagePreview != null)
                    Text(
                      request.lastMessagePreview!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                      ),
                    ),
                ],
              ),
            ),
          SizedBox(width: 8.w),
          _buildAcceptButton(request.id),
          SizedBox(width: 6.w),
          _buildDeclineButton(request.id),
        ],
      ),
    );
  }

  Widget _buildAcceptButton(String convId) {
    return InkWell(
      onTap: () => context.read<P2PConversationsCubit>().acceptRequest(convId),
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: const Color(0xFF10B981),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          'Accept',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildDeclineButton(String convId) {
    return InkWell(
      onTap: () =>
          context.read<P2PConversationsCubit>().declineRequest(convId),
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Text(
          'Decline',
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildConnectionTile(P2PConversationEntity conversation) {
    final name = conversation.otherUserName ?? 'Unknown User';
    final hasUnread = conversation.unreadCount > 0;
    final timeStr = _formatTime(conversation.lastMessageAt);
    final isPendingOutgoing = conversation.connectionStatus == 'pending';

    return KeyedSubtree(
      // Stable key so Flutter reuses this element across the (now silent)
      // list refreshes instead of rebuilding every tile.
      key: ValueKey('p2p-conv-${conversation.id}'),
      child: Slidable(
        key: ValueKey('p2p-slide-${conversation.id}'),
        // Auto-close any other open row when this one is swiped.
        groupTag: 'connections',
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.5,
          children: [
            SlidableAction(
              onPressed: (_) =>
                  _setArchived(conversation, !conversation.isArchived),
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
              icon: conversation.isArchived
                  ? Icons.unarchive_rounded
                  : Icons.archive_rounded,
              label: conversation.isArchived ? 'Unarchive' : 'Archive',
              borderRadius: BorderRadius.circular(16.r),
              padding: EdgeInsets.symmetric(horizontal: 4.w),
            ),
            SlidableAction(
              onPressed: (_) => _confirmDelete(conversation),
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
              icon: Icons.delete_rounded,
              label: 'Delete',
              borderRadius: BorderRadius.circular(16.r),
              padding: EdgeInsets.symmetric(horizontal: 4.w),
            ),
          ],
        ),
        child: _cardShell(
          onTap: () => _openChat(conversation),
          onLongPress: () => _showConversationActions(conversation),
          child: Row(
          children: [
            _peerAvatar(name: name, imageUrl: conversation.otherUserAvatar),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (conversation.safetyWarning) ...[
                        Text('⚠️', style: TextStyle(fontSize: 13.sp)),
                        SizedBox(width: 4.w),
                      ],
                      Expanded(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight:
                                hasUnread ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      ),
                      if (timeStr.isNotEmpty)
                        Text(
                          timeStr,
                          style: GoogleFonts.inter(
                            color: hasUnread
                                ? const Color(0xFF3B82F6)
                                : const Color(0xFF9CA3AF),
                            fontSize: 12.sp,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Expanded(
                        child: ValueListenableBuilder<Set<String>>(
                          valueListenable: context
                              .read<P2PConversationsCubit>()
                              .typingConversations,
                          builder: (context, typingIds, _) {
                            // When the peer is typing, replace the last-message
                            // preview with a live "typing…" indicator (same
                            // signal the chat screen shows), for THIS peer only.
                            if (typingIds.contains(conversation.id)) {
                              return const _ConnectionTypingIndicator();
                            }
                            return Text(
                              isPendingOutgoing &&
                                      conversation.lastMessagePreview == null
                                  ? 'Connection pending'
                                  : conversation.lastMessagePreview ??
                                      'No messages yet',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                color: isPendingOutgoing
                                    ? const Color(0xFFFB923C)
                                    : hasUnread
                                        ? Colors.white70
                                        : const Color(0xFF9CA3AF),
                                fontSize: 13.sp,
                                fontWeight: hasUnread
                                    ? FontWeight.w500
                                    : FontWeight.w400,
                              ),
                            );
                          },
                        ),
                      ),
                      if (hasUnread) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 7.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3B82F6),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            conversation.unreadCount > 99
                                ? '99+'
                                : '${conversation.unreadCount}',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }

  // ── Conversation organisation actions (archive / per-user delete) ──────────

  void _setArchived(P2PConversationEntity c, bool archived) {
    final cubit = context.read<P2PConversationsCubit>();
    cubit.setArchived(c.id, archived);
    if (archived) {
      Get.snackbar(
        'Chat archived',
        'Moved to Archived to keep your list clean.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF202024),
        colorText: Colors.white,
        margin: EdgeInsets.all(12.w),
        duration: const Duration(seconds: 3),
        mainButton: TextButton(
          onPressed: () {
            Get.closeCurrentSnackbar();
            cubit.setArchived(c.id, false);
          },
          child: Text('Undo',
              style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontWeight: FontWeight.w700)),
        ),
      );
    }
  }

  Future<void> _confirmDelete(P2PConversationEntity c) async {
    final name = c.otherUserName ?? 'this chat';
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Delete chat?',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w700)),
        content: Text(
          'This removes “$name” from your chats. Your messages stay saved, '
          'and the chat comes back if you message each other again.',
          style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF), fontSize: 14.sp, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancel',
                style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text('Delete',
                style: GoogleFonts.inter(
                    color: const Color(0xFFEF4444),
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
    if (ok == true && mounted) {
      context.read<P2PConversationsCubit>().deleteConversationForMe(c.id);
    }
  }

  /// Long-press menu — the full action set (mirrors the swipe actions).
  void _showConversationActions(P2PConversationEntity c) {
    final name = c.otherUserName ?? 'Unknown User';
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1A1A1C),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 10.h),
              child: Row(
                children: [
                  _peerAvatar(name: name, imageUrl: c.otherUserAvatar),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            Divider(color: const Color(0xFF2D2D2D), height: 1),
            _actionRow(
              icon: c.isArchived
                  ? Icons.unarchive_rounded
                  : Icons.archive_rounded,
              label: c.isArchived ? 'Unarchive chat' : 'Archive chat',
              color: const Color(0xFF3B82F6),
              onTap: () {
                Navigator.of(ctx).pop();
                _setArchived(c, !c.isArchived);
              },
            ),
            _actionRow(
              icon: Icons.delete_rounded,
              label: 'Delete chat',
              color: const Color(0xFFEF4444),
              onTap: () {
                Navigator.of(ctx).pop();
                _confirmDelete(c);
              },
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Widget _actionRow({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color, size: 22.sp),
      title: Text(label,
          style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildContactTile(RecipientModel recipient) {
    // displayName already prefers alias, then a real name, and falls back to
    // email/masked-account — never surfacing an account-TYPE token (e.g.
    // "personal") that legacy connection records stored in `name`.
    final displayName = recipient.displayName;

    return _cardShell(
      onTap: () => _openContactChat(recipient),
      child: Row(
        children: [
          _peerAvatar(
            name: displayName,
            imageUrl: null,
            backgroundColor: const Color(0xFF3B82F6).withOpacity(0.7),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Saved recipient',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chat_bubble_outline,
            color: const Color(0xFF9CA3AF),
            size: 18.w,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 48.w, color: const Color(0xFFEF4444)),
          SizedBox(height: 12.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16.h),
          TextButton(
            onPressed: () {
              context.read<P2PConversationsCubit>().loadConversations();
              _loadSavedContacts();
            },
            child: Text(
              'Retry',
              style: GoogleFonts.inter(
                color: const Color(0xFF3B82F6),
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openChat(P2PConversationEntity conversation) {
    Get.toNamed(
      AppRoutes.p2pChat,
      arguments: {
        'otherUserId': conversation.otherUserId,
        'otherUserName': conversation.otherUserName ?? 'Unknown User',
        'otherUserAvatar': conversation.otherUserAvatar,
        'safetyWarning': conversation.safetyWarning,
        'safetyWarningReason': conversation.safetyWarningReason,
      },
    )?.then((_) {
      if (mounted) _refreshAll();
    });
  }

  void _openContactChat(RecipientModel recipient) {
    final userId = recipient.internalUserId;
    if (userId == null || userId.isEmpty) return;

    Get.toNamed(
      AppRoutes.p2pChat,
      arguments: {
        'otherUserId': userId,
        'otherUserName': recipient.displayName,
        'isSavedRecipient': true,
      },
    )?.then((_) {
      if (mounted) _refreshAll();
    });
  }

  /// Manual "find people" search (saved contacts incl. alias → global), then
  /// opens a chat with the picked person.
  ///
  /// NOTE: this path is intentionally NOT surfaced by any visible button — a
  /// financial connection is established only when you send money to a
  /// Lazervault user. The code is kept wired (gated behind [_kManualAddVisible])
  /// so it can be re-enabled without rebuilding the flow.
  Future<void> _openUnifiedSearch() async {
    final result =
        await UnifiedUserSearchSheet.show(context, title: 'Find people');
    if (result == null || !mounted) return;
    if (result.userId.isEmpty) return;
    Get.toNamed(
      AppRoutes.p2pChat,
      arguments: {
        'otherUserId': result.userId,
        'otherUserName': result.displayName,
        'otherUserAvatar':
            result.profilePicture.isNotEmpty ? result.profilePicture : null,
        'isSavedRecipient': result.isSavedHit,
      },
    )?.then((_) {
      if (mounted) _refreshAll();
    });
  }

  void _onUserTapped(Map<String, dynamic> user) {
    // gRPC-Gateway returns camelCase JSON keys; also handle snake_case for safety
    final userId = user['userId'] as String?
        ?? user['user_id'] as String?
        ?? user['id'] as String?
        ?? '';
    final name = _getUserDisplayName(user);

    if (userId.isEmpty) return;

    Get.toNamed(
      AppRoutes.p2pChat,
      arguments: {
        'otherUserId': userId,
        'otherUserName': name,
        'otherUserAvatar': user['profilePicture'] as String?
            ?? user['profile_picture'] as String?,
        'isSavedRecipient': false,
      },
    )?.then((_) {
      if (mounted) _refreshAll();
    });
  }

  String _getUserDisplayName(Map<String, dynamic> user) {
    // gRPC-Gateway returns camelCase JSON keys; also handle snake_case for safety
    final first = user['firstName'] as String?
        ?? user['first_name'] as String?
        ?? '';
    final last = user['lastName'] as String?
        ?? user['last_name'] as String?
        ?? '';
    final full = '$first $last'.trim();
    if (full.isNotEmpty) return full;
    return user['username'] as String? ?? 'Unknown';
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inDays == 0) {
      return DateFormat.Hm().format(dateTime);
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return DateFormat.E().format(dateTime);
    } else {
      return DateFormat('dd/MM').format(dateTime);
    }
  }
}
