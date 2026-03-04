import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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

class P2PChatPage extends StatefulWidget {
  const P2PChatPage({super.key});

  @override
  State<P2PChatPage> createState() => _P2PChatPageState();
}

class _P2PChatPageState extends State<P2PChatPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isAtBottom = true;
  bool _userScrolledUp = false;
  bool _showScrollToBottom = false;

  StreamSubscription? _typingSubscription;
  bool _otherUserTyping = false;
  Timer? _typingTimeout;

  late final String _otherUserId;
  late final String _otherUserName;
  late final String? _otherUserAvatar;
  late final String _currentUserId;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments as Map<String, dynamic>? ?? {};
    _otherUserId = args['otherUserId'] as String? ?? '';
    _otherUserName = args['otherUserName'] as String? ?? 'Unknown User';
    _otherUserAvatar = args['otherUserAvatar'] as String?;

    final authCubit = context.read<AuthenticationCubit>();
    _currentUserId = switch (authCubit.state) {
      AuthenticationAuthenticated s => s.profile.userId,
      AuthenticationSuccess s => s.profile.userId,
      _ => '',
    };

    // Listen for typing indicators
    final wsService = serviceLocator<P2PChatWebSocketService>();
    _typingSubscription = wsService.typingStream.listen((event) {
      if (event.userId == _otherUserId && mounted) {
        setState(() => _otherUserTyping = event.isTyping);
        _typingTimeout?.cancel();
        if (event.isTyping) {
          _typingTimeout = Timer(const Duration(seconds: 5), () {
            if (mounted) setState(() => _otherUserTyping = false);
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

    final shouldShowButton = !atBottom && (maxScroll - currentScroll) > 200;
    if (shouldShowButton != _showScrollToBottom) {
      setState(() => _showScrollToBottom = shouldShowButton);
    }
  }

  void _scrollToBottom({bool force = false}) {
    if (!_scrollController.hasClients) return;
    if (_userScrolledUp && !force) return;

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted && _scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _typingSubscription?.cancel();
    _typingTimeout?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            _buildConnectionBanner(),
            Expanded(child: _buildMessageList()),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final initials = _otherUserName.isNotEmpty
        ? _otherUserName[0].toUpperCase()
        : '?';

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 34.w,
            height: 34.w,
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
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _otherUserName,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
        ],
      ),
    );
  }

  Widget _buildConnectionBanner() {
    return BlocBuilder<P2PChatCubit, P2PChatState>(
      builder: (context, state) {
        if (state is! P2PChatLoaded) return const SizedBox.shrink();

        // Connection request banner
        if (state.connectionStatus == 'pending') {
          final isInitiator = state.initiatedBy == _currentUserId;
          final hasSentMessage = isInitiator && state.messages.isNotEmpty;

          // Initiator: only show "waiting" banner AFTER they've sent their first message
          if (isInitiator && !hasSentMessage) {
            // No banner yet — they can still send their first message
            return const SizedBox.shrink();
          }

          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            color: const Color(0xFFFB923C).withOpacity(0.15),
            child: Row(
              children: [
                Icon(
                  isInitiator ? Icons.hourglass_top : Icons.person_add,
                  color: const Color(0xFFFB923C),
                  size: 18.w,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    isInitiator
                        ? 'Waiting for $_otherUserName to accept your connection request'
                        : '$_otherUserName wants to connect with you',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFFB923C),
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // WebSocket connection banner
        if (state.connectionState == P2PChatConnectionState.reconnecting) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            color: const Color(0xFFFB923C).withOpacity(0.15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 12.w,
                  height: 12.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 1.5,
                    color: Color(0xFFFB923C),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Reconnecting...',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFFB923C),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          );
        }

        if (state.connectionState == P2PChatConnectionState.disconnected) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            color: const Color(0xFFEF4444).withOpacity(0.15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cloud_off, size: 14.w, color: const Color(0xFFEF4444)),
                SizedBox(width: 6.w),
                Text(
                  'Offline — messages sent via fallback',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFEF4444),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMessageList() {
    return BlocConsumer<P2PChatCubit, P2PChatState>(
      listener: (context, state) {
        if (state is P2PChatLoaded && !_userScrolledUp) {
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline,
                    size: 48.w, color: const Color(0xFFEF4444)),
                SizedBox(height: 12.h),
                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                TextButton(
                  onPressed: () =>
                      context.read<P2PChatCubit>().initializeChat(_otherUserId),
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

        if (state is! P2PChatLoaded) return const SizedBox.shrink();

        if (state.messages.isEmpty) {
          final isPending = state.connectionStatus == 'pending';
          final isInitiator = state.initiatedBy == _currentUserId;
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isPending && isInitiator
                      ? Icons.send_rounded
                      : Icons.chat_bubble_outline,
                  size: 48.w,
                  color: const Color(0xFF9CA3AF),
                ),
                SizedBox(height: 12.h),
                Text(
                  isPending && isInitiator
                      ? 'Send a message to connect with $_otherUserName'
                      : 'Start a conversation',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                  ),
                ),
                if (isPending && isInitiator) ...[
                  SizedBox(height: 4.h),
                  Text(
                    'They\'ll need to accept before you can send more',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF).withOpacity(0.6),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ],
            ),
          );
        }

        return Stack(
          children: [
            ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              itemCount:
                  state.messages.length + (state.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (state.isLoadingMore && index == 0) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF3B82F6),
                        ),
                      ),
                    ),
                  );
                }

                final msgIndex =
                    state.isLoadingMore ? index - 1 : index;
                final message = state.messages[msgIndex];
                final isMe = message.senderId == _currentUserId;

                // Date separator
                Widget? dateSeparator;
                if (msgIndex == 0 ||
                    !_isSameDay(message.createdAt,
                        state.messages[msgIndex - 1].createdAt)) {
                  dateSeparator = _buildDateSeparator(message.createdAt);
                }

                // System message
                if (message.isSystem) {
                  return Column(
                    children: [
                      if (dateSeparator != null) dateSeparator,
                      _buildSystemMessage(message),
                    ],
                  );
                }

                // Transfer message
                if (message.isTransfer) {
                  return Column(
                    children: [
                      if (dateSeparator != null) dateSeparator,
                      P2PTransferBubble(
                        message: message,
                        isMe: isMe,
                        otherUserName: _otherUserName,
                        otherUserId: _otherUserId,
                      ),
                    ],
                  );
                }

                // Text message
                return Column(
                  children: [
                    if (dateSeparator != null) dateSeparator,
                    GestureDetector(
                      onLongPress: message.deliveryStatus == 'failed'
                          ? () => _showRetryDialog(message)
                          : null,
                      child: P2PTextBubble(
                        message: message,
                        isMe: isMe,
                        onRetry: message.deliveryStatus == 'failed' &&
                                message.clientMessageId != null
                            ? () => context
                                .read<P2PChatCubit>()
                                .retryMessage(message.clientMessageId!)
                            : null,
                      ),
                    ),
                  ],
                );
              },
            ),
            // Scroll to bottom button
            if (_showScrollToBottom)
              Positioned(
                right: 16.w,
                bottom: 8.h,
                child: GestureDetector(
                  onTap: () => _scrollToBottom(force: true),
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF1F1F1F),
                      border: Border.all(color: const Color(0xFF2D2D2D)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 24.w,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildInputArea() {
    return BlocBuilder<P2PChatCubit, P2PChatState>(
      builder: (context, state) {
        final canSend = state is P2PChatLoaded && state.canSendMessage;
        final isLoaded = state is P2PChatLoaded;

        if (state is P2PChatLoaded &&
            state.connectionStatus == 'pending' &&
            !state.canSendMessage) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              border: Border(
                top: BorderSide(
                  color: const Color(0xFF2D2D2D),
                  width: 1,
                ),
              ),
            ),
            child: Text(
              '$_otherUserName needs to reply before you can send more messages.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
              ),
            ),
          );
        }

        return P2PChatInputBar(
          enabled: isLoaded && canSend,
          onSend: (content) {
            context.read<P2PChatCubit>().sendMessage(content);
            _scrollToBottom(force: true);
          },
          onTypingChanged: (isTyping) {
            context.read<P2PChatCubit>().sendTyping(isTyping);
          },
        );
      },
    );
  }

  Widget _buildDateSeparator(DateTime date) {
    String label;
    final now = DateTime.now();
    if (_isSameDay(date, now)) {
      label = 'Today';
    } else if (_isSameDay(date, now.subtract(const Duration(days: 1)))) {
      label = 'Yesterday';
    } else {
      label = DateFormat('MMMM d, yyyy').format(date);
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 11.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSystemMessage(P2PMessageEntity message) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D).withOpacity(0.5),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            message.content ?? '',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
              fontStyle: FontStyle.italic,
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
        title: Text(
          'Message failed to send',
          style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (message.clientMessageId != null) {
                context
                    .read<P2PChatCubit>()
                    .retryMessage(message.clientMessageId!);
              }
            },
            child: Text(
              'Retry',
              style: GoogleFonts.inter(color: const Color(0xFF3B82F6)),
            ),
          ),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
