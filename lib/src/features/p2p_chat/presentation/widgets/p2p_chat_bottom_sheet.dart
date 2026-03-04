import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_message_entity.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_chat_cubit.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_chat_state.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/widgets/p2p_chat_input_bar.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/widgets/p2p_text_bubble.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/widgets/p2p_transfer_bubble.dart';
import 'package:lazervault/src/features/p2p_chat/services/p2p_chat_websocket_service.dart';

/// Shows the P2P chat bottom sheet for a specific user.
void showP2PChatBottomSheet(
  BuildContext context, {
  required String otherUserId,
  required String otherUserName,
  String? otherUserAvatar,
}) {
  final authCubit = context.read<AuthenticationCubit>();
  final currentUserId = switch (authCubit.state) {
    AuthenticationAuthenticated s => s.profile.userId,
    AuthenticationSuccess s => s.profile.userId,
    _ => '',
  };

  // Guard: don't open chat if not authenticated
  if (currentUserId.isEmpty) return;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    enableDrag: false, // We handle drag via expand/collapse
    builder: (_) => BlocProvider(
      create: (_) => P2PChatCubit(
        repository: serviceLocator(),
        wsService: serviceLocator<P2PChatWebSocketService>(),
        secureStorage: serviceLocator<SecureStorageService>(),
        currentUserId: currentUserId,
      )..initializeChat(otherUserId),
      child: P2PChatBottomSheet(
        otherUserId: otherUserId,
        otherUserName: otherUserName,
        otherUserAvatar: otherUserAvatar,
        currentUserId: currentUserId,
      ),
    ),
  );
}

class P2PChatBottomSheet extends StatefulWidget {
  final String otherUserId;
  final String otherUserName;
  final String? otherUserAvatar;
  final String currentUserId;

  const P2PChatBottomSheet({
    super.key,
    required this.otherUserId,
    required this.otherUserName,
    this.otherUserAvatar,
    required this.currentUserId,
  });

  @override
  State<P2PChatBottomSheet> createState() => _P2PChatBottomSheetState();
}

class _P2PChatBottomSheetState extends State<P2PChatBottomSheet>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;
  bool _isExpanded = false;
  bool _isAtBottom = true;
  bool _userScrolledUp = false;

  StreamSubscription? _typingSubscription;
  bool _otherUserTyping = false;
  Timer? _typingTimeout;

  @override
  void initState() {
    super.initState();

    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _expandController, curve: Curves.easeInOut),
    );

    // Listen for typing indicators
    final wsService = serviceLocator<P2PChatWebSocketService>();
    _typingSubscription = wsService.typingStream.listen((event) {
      if (event.userId == widget.otherUserId && mounted) {
        setState(() => _otherUserTyping = event.isTyping);

        // Auto-clear typing after 5 seconds if no "stop typing" event
        _typingTimeout?.cancel();
        if (event.isTyping) {
          _typingTimeout = Timer(const Duration(seconds: 5), () {
            if (mounted) {
              setState(() => _otherUserTyping = false);
            }
          });
        }
      }
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    if (_scrollController.position.pixels <=
        _scrollController.position.minScrollExtent + 100) {
      context.read<P2PChatCubit>().loadMore();
    }

    // Track if user is at the bottom
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final atBottom = (maxScroll - currentScroll) <= 50;

    if (!atBottom && _isAtBottom) {
      _userScrolledUp = true;
    }
    if (atBottom) {
      _userScrolledUp = false;
    }
    _isAtBottom = atBottom;
  }

  void _toggleExpand() {
    setState(() => _isExpanded = !_isExpanded);
    if (_isExpanded) {
      _expandController.forward();
    } else {
      _expandController.reverse();
    }
  }

  void _scrollToBottom({bool force = false}) {
    if (!_scrollController.hasClients) return;
    // Don't auto-scroll if user is reading history, unless forced
    if (_userScrolledUp && !force) return;

    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _close() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _expandController.dispose();
    _scrollController.dispose();
    _typingSubscription?.cancel();
    _typingTimeout?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedBuilder(
      animation: _expandAnimation,
      builder: (context, child) {
        return Container(
          height: screenHeight * _expandAnimation.value,
          margin: EdgeInsets.only(bottom: keyboardHeight),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: _isExpanded && _expandAnimation.value >= 0.99
                ? BorderRadius.zero
                : BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
          ),
          child: Column(
            children: [
              _buildHeader(),
              _buildConnectionBanner(),
              Expanded(child: _buildMessageList()),
              _buildInputArea(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    final initials = widget.otherUserName.isNotEmpty
        ? widget.otherUserName[0].toUpperCase()
        : '?';

    return Container(
      padding: EdgeInsets.only(
        top: _isExpanded ? MediaQuery.of(context).padding.top + 8.h : 12.h,
        left: 16.w,
        right: 8.w,
        bottom: 12.h,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF3B82F6).withOpacity(0.3),
            const Color(0xFF1F1F1F),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag indicator
          if (!_isExpanded)
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 12.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          Row(
            children: [
              // Avatar
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF3B82F6).withOpacity(0.2),
                  border: Border.all(
                    color: const Color(0xFF3B82F6).withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF3B82F6),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Name + status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.otherUserName,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      _otherUserTyping ? 'Typing...' : 'LazerVault User',
                      style: GoogleFonts.inter(
                        color: _otherUserTyping
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              // Scroll-to-bottom button (visible when user scrolled up)
              if (_userScrolledUp)
                IconButton(
                  onPressed: () => _scrollToBottom(force: true),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white.withOpacity(0.7),
                    size: 22.w,
                  ),
                ),
              // Expand/collapse button
              IconButton(
                onPressed: _toggleExpand,
                icon: Icon(
                  _isExpanded ? Icons.close_fullscreen : Icons.open_in_full,
                  color: Colors.white.withOpacity(0.7),
                  size: 20.w,
                ),
              ),
              // Close button
              IconButton(
                onPressed: _close,
                icon: Icon(
                  Icons.close,
                  color: Colors.white.withOpacity(0.7),
                  size: 22.w,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Connection status banner — shows when WebSocket is disconnected/reconnecting.
  Widget _buildConnectionBanner() {
    return BlocBuilder<P2PChatCubit, P2PChatState>(
      buildWhen: (prev, curr) {
        if (prev is P2PChatLoaded && curr is P2PChatLoaded) {
          return prev.connectionState != curr.connectionState;
        }
        return false;
      },
      builder: (context, state) {
        if (state is! P2PChatLoaded) return const SizedBox.shrink();

        final conn = state.connectionState;
        if (conn == P2PChatConnectionState.connected) {
          return const SizedBox.shrink();
        }

        final isReconnecting = conn == P2PChatConnectionState.reconnecting;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          color: isReconnecting
              ? const Color(0xFFFB923C).withOpacity(0.15)
              : const Color(0xFFEF4444).withOpacity(0.15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isReconnecting)
                SizedBox(
                  width: 12.w,
                  height: 12.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 1.5,
                    color: Color(0xFFFB923C),
                  ),
                )
              else
                Icon(Icons.cloud_off, size: 14.w, color: const Color(0xFFEF4444)),
              SizedBox(width: 6.w),
              Text(
                isReconnecting
                    ? 'Reconnecting...'
                    : 'Offline — messages sent via fallback',
                style: GoogleFonts.inter(
                  color: isReconnecting
                      ? const Color(0xFFFB923C)
                      : const Color(0xFFEF4444),
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageList() {
    return BlocConsumer<P2PChatCubit, P2PChatState>(
      listener: (context, state) {
        if (state is P2PChatLoaded) {
          _scrollToBottom();
        }
      },
      builder: (context, state) {
        if (state is P2PChatLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
          );
        }

        if (state is P2PChatError) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline,
                      color: const Color(0xFFEF4444), size: 40.w),
                  SizedBox(height: 12.h),
                  Text(
                    state.message,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  if (widget.otherUserId.isNotEmpty)
                    TextButton.icon(
                      onPressed: () => context
                          .read<P2PChatCubit>()
                          .initializeChat(widget.otherUserId),
                      icon: const Icon(Icons.refresh, size: 18),
                      label: Text(
                        'Retry',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF3B82F6),
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }

        if (state is P2PChatLoaded) {
          if (state.messages.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_outlined,
                      color: const Color(0xFF9CA3AF), size: 48.w),
                  SizedBox(height: 12.h),
                  Text(
                    'Start a conversation',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Say hi to ${widget.otherUserName}!',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF).withOpacity(0.6),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            itemCount: state.messages.length + (state.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              // Loading indicator at the top
              if (state.isLoadingMore && index == 0) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF3B82F6),
                      ),
                    ),
                  ),
                );
              }

              final msgIndex = state.isLoadingMore ? index - 1 : index;
              final message = state.messages[msgIndex];
              final isMe = message.senderId == widget.currentUserId;
              final showDate = _shouldShowDate(state.messages, msgIndex);

              return Column(
                children: [
                  if (showDate)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Text(
                        _formatDate(message.createdAt),
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                  if (message.isSystem)
                    _buildSystemMessage(message)
                  else if (message.isTransfer)
                    P2PTransferBubble(
                      message: message,
                      isMe: isMe,
                      otherUserName: widget.otherUserName,
                      otherUserId: widget.otherUserId,
                    )
                  else
                    GestureDetector(
                      onLongPress: isMe && message.deliveryStatus == 'failed'
                          ? () => _showRetryDialog(message)
                          : null,
                      child: P2PTextBubble(
                        message: message,
                        isMe: isMe,
                        onRetry: isMe && message.deliveryStatus == 'failed'
                            ? () => context
                                .read<P2PChatCubit>()
                                .retryMessage(message.clientMessageId ?? '')
                            : null,
                      ),
                    ),
                ],
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSystemMessage(P2PMessageEntity message) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            message.content ?? '',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
            ),
          ),
        ),
      ),
    );
  }

  void _showRetryDialog(P2PMessageEntity message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: Text(
          'Message failed',
          style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
        ),
        content: Text(
          'Would you like to retry sending this message?',
          style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF), fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel',
                style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context
                  .read<P2PChatCubit>()
                  .retryMessage(message.clientMessageId ?? '');
            },
            child: Text('Retry',
                style: GoogleFonts.inter(color: const Color(0xFF3B82F6))),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return BlocBuilder<P2PChatCubit, P2PChatState>(
      buildWhen: (prev, curr) =>
          (prev is P2PChatLoaded) != (curr is P2PChatLoaded) ||
          (prev is P2PChatError) != (curr is P2PChatError),
      builder: (context, state) {
        // Disable input when in error/loading state
        final enabled = state is P2PChatLoaded;
        return P2PChatInputBar(
          enabled: enabled,
          onSend: (content) {
            context.read<P2PChatCubit>().sendMessage(content);
            // Force scroll to bottom when user sends a message
            _scrollToBottom(force: true);
          },
          onTypingChanged: (isTyping) {
            context.read<P2PChatCubit>().sendTyping(isTyping);
          },
        );
      },
    );
  }

  bool _shouldShowDate(List<P2PMessageEntity> messages, int index) {
    if (index == 0) return true;
    final current = messages[index].createdAt;
    final previous = messages[index - 1].createdAt;
    return current.day != previous.day ||
        current.month != previous.month ||
        current.year != previous.year;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    }
    final yesterday = now.subtract(const Duration(days: 1));
    if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return 'Yesterday';
    }
    return DateFormat('MMM d, yyyy').format(date);
  }
}
