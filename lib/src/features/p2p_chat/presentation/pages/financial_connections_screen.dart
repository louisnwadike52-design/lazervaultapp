import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
  bool _contactsExpanded = true;

  /// Saved internal recipients (deduped by internalUserId)
  List<RecipientModel> _savedContacts = [];
  bool _contactsLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<P2PConversationsCubit>().loadConversations();
    _loadSavedContacts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  /// Load saved internal recipients from the backend.
  Future<void> _loadSavedContacts() async {
    if (!mounted) return;
    setState(() => _contactsLoading = true);

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

  void _onSearchChanged(String query) {
    _debouncer.run(() {
      context.read<P2PConversationsCubit>().searchUsers(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
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
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  context.read<P2PConversationsCubit>().loadConversations();
                }
              });
            },
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: BlocBuilder<P2PConversationsCubit, P2PConversationsState>(
        builder: (context, state) {
          if (state is P2PConversationsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
            );
          }

          if (state is P2PConversationsError) {
            return _buildErrorState(state.message);
          }

          if (state is P2PUserSearchLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
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
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
      decoration: InputDecoration(
        hintText: 'Search users...',
        hintStyle: GoogleFonts.inter(
          color: const Color(0xFF9CA3AF),
          fontSize: 16.sp,
        ),
        border: InputBorder.none,
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
    final hasRequests = state.incomingRequests.isNotEmpty;
    final hasConnections = state.conversations.isNotEmpty;
    final contactsWithoutConv = _getContactsWithoutConversation(
      state.conversations,
      state.incomingRequests,
    );
    final hasContacts = contactsWithoutConv.isNotEmpty;

    if (!hasRequests && !hasConnections && !hasContacts && !_contactsLoading) {
      return RefreshIndicator(
        onRefresh: _refreshAll,
        color: const Color(0xFF3B82F6),
        backgroundColor: const Color(0xFF1F1F1F),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: 120.h),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.people_outline,
                      size: 64.w, color: const Color(0xFF9CA3AF)),
                  SizedBox(height: 16.h),
                  Text(
                    'No connections yet',
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
                      'Search for users to start a conversation and build your financial network.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
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

    return RefreshIndicator(
      onRefresh: _refreshAll,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 8.h),
        children: [
          if (hasRequests) ...[
            _buildRequestsSection(state.incomingRequests),
            if (hasConnections || hasContacts || _contactsLoading)
              Divider(
                color: const Color(0xFF2D2D2D),
                height: 1,
                indent: 16.w,
                endIndent: 16.w,
              ),
          ],
          if (hasConnections)
            ...state.conversations.map(_buildConnectionTile),
          // Contacts section or loading indicator
          if (hasContacts || _contactsLoading) ...[
            if (hasConnections)
              Divider(
                color: const Color(0xFF2D2D2D),
                height: 1,
                indent: 16.w,
                endIndent: 16.w,
              ),
            if (_contactsLoading && !hasContacts)
              _buildContactsLoadingIndicator()
            else if (hasContacts)
              _buildContactsSection(contactsWithoutConv),
          ],
        ],
      ),
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          SizedBox(
            width: 16.w,
            height: 16.w,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              color: Color(0xFF3B82F6),
            ),
          ),
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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                  'Connection Requests',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
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

  Widget _buildContactsSection(List<RecipientModel> contacts) {
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _contactsExpanded = !_contactsExpanded),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '${contacts.length}',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF3B82F6),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Saved Contacts',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const Spacer(),
                Icon(
                  _contactsExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xFF9CA3AF),
                  size: 20.w,
                ),
              ],
            ),
          ),
        ),
        if (_contactsExpanded)
          ...contacts.map(_buildContactTile),
      ],
    );
  }

  Widget _buildRequestTile(P2PConversationEntity request) {
    final name = request.otherUserName ?? 'Unknown User';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFFFB923C).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: const Color(0xFF3B82F6),
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
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

    return InkWell(
      onTap: () => _openChat(conversation),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundColor: const Color(0xFF3B82F6),
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
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
                        child: Text(
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
    );
  }

  Widget _buildContactTile(RecipientModel recipient) {
    final name = recipient.alias?.isNotEmpty == true
        ? recipient.alias!
        : recipient.name;
    final displayName = name.isNotEmpty ? name : 'Unknown';

    return InkWell(
      onTap: () => _openContactChat(recipient),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundColor: const Color(0xFF3B82F6).withOpacity(0.7),
              child: Text(
                displayName[0].toUpperCase(),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
      },
    )?.then((_) {
      if (mounted) _refreshAll();
    });
  }

  void _openContactChat(RecipientModel recipient) {
    final userId = recipient.internalUserId;
    if (userId == null || userId.isEmpty) return;

    final name = recipient.alias?.isNotEmpty == true
        ? recipient.alias!
        : recipient.name;

    Get.toNamed(
      AppRoutes.p2pChat,
      arguments: {
        'otherUserId': userId,
        'otherUserName': name.isNotEmpty ? name : 'Unknown',
      },
    )?.then((_) {
      if (mounted) _refreshAll();
    });
  }

  void _onUserTapped(Map<String, dynamic> user) {
    final userId = user['user_id'] as String? ?? user['id'] as String? ?? '';
    final name = _getUserDisplayName(user);

    if (userId.isEmpty) return;

    Get.toNamed(
      AppRoutes.p2pChat,
      arguments: {
        'otherUserId': userId,
        'otherUserName': name,
        'otherUserAvatar': user['profile_picture'] as String?,
      },
    )?.then((_) {
      if (mounted) _refreshAll();
    });
  }

  String _getUserDisplayName(Map<String, dynamic> user) {
    final first = user['first_name'] as String? ?? '';
    final last = user['last_name'] as String? ?? '';
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
