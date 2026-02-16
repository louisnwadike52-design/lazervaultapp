import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import '../../cubit/microservice_chat_cubit.dart';
import '../../cubit/microservice_chat_state.dart';
import '../../domain/entities/microservice_chat_message_entity.dart';
import '../../domain/usecases/send_microservice_chat_message_usecase.dart';
import '../../domain/usecases/load_microservice_chat_history_usecase.dart';

/// Shows a scoped chat bottom sheet for a specific service.
void showServiceChatBottomSheet(
  BuildContext context, {
  required String serviceName,
  required String sourceContext,
  String? agentDescription,
  Color accentColor = const Color(0xFF8B5CF6),
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider(
      create: (_) => MicroserviceChatCubit(
        sendMessageUseCase: serviceLocator<SendMicroserviceChatMessageUseCase>(),
        loadHistoryUseCase: serviceLocator<LoadMicroserviceChatHistoryUseCase>(),
        authCubit: serviceLocator<AuthenticationCubit>(),
        sourceContext: sourceContext,
      )
        ..initializeChat()
        ..loadHistory(),
      child: ServiceChatBottomSheet(
        serviceName: serviceName,
        sourceContext: sourceContext,
        agentDescription: agentDescription,
        accentColor: accentColor,
      ),
    ),
  );
}

class ServiceChatBottomSheet extends StatefulWidget {
  final String serviceName;
  final String sourceContext;
  final String? agentDescription;
  final Color accentColor;

  const ServiceChatBottomSheet({
    super.key,
    required this.serviceName,
    required this.sourceContext,
    this.agentDescription,
    this.accentColor = const Color(0xFF8B5CF6),
  });

  @override
  State<ServiceChatBottomSheet> createState() => _ServiceChatBottomSheetState();
}

class _ServiceChatBottomSheetState extends State<ServiceChatBottomSheet> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
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
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      context.read<MicroserviceChatCubit>().sendMessage(text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildMessageList()),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.accentColor,
            widget.accentColor.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          // Drag indicator
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 16.h),

          Row(
            children: [
              // AI avatar
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.smart_toy,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.serviceName} Assistant',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    BlocBuilder<MicroserviceChatCubit, MicroserviceChatState>(
                      builder: (context, state) {
                        final isTyping = state.isTyping;
                        return Text(
                          isTyping ? 'Typing...' : 'Online',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: isTyping
                                ? Colors.white.withValues(alpha: 0.8)
                                : const Color(0xFF10B981),
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Expand to full screen
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Get.toNamed(
                    AppRoutes.microserviceChat,
                    arguments: {
                      'serviceName': widget.serviceName,
                      'sourceContext': widget.sourceContext,
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.open_in_full,
                    size: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 8.w),

              // Close button
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return BlocConsumer<MicroserviceChatCubit, MicroserviceChatState>(
      listener: (context, state) {
        if (state is MicroserviceChatMessageSuccess) {
          _scrollToBottom();
        }
      },
      builder: (context, state) {
        if (state is MicroserviceChatHistoryLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF8B5CF6)),
          );
        }

        final messages = state.messages;
        final isTyping = state.isTyping;

        if (messages.isEmpty && !isTyping) {
          return _buildEmptyState();
        }

        return ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.all(20.w),
          itemCount: messages.length + (isTyping ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == messages.length && isTyping) {
              return _buildTypingIndicator();
            }
            return _buildMessageBubble(messages[index]);
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.smart_toy,
            size: 64.sp,
            color: widget.accentColor.withValues(alpha: 0.5),
          ),
          SizedBox(height: 16.h),
          Text(
            'Hi! I\'m your ${widget.serviceName} assistant.',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            widget.agentDescription ??
                'Ask me anything about ${widget.serviceName.toLowerCase()}.',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(MicroserviceChatMessageEntity message) {
    final isUser = message.isUser;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: widget.accentColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: 16.sp,
              ),
            ),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: isUser
                        ? widget.accentColor
                        : const Color(0xFF0A0A0A),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                      bottomLeft: isUser
                          ? Radius.circular(20.r)
                          : Radius.circular(4.r),
                      bottomRight: isUser
                          ? Radius.circular(4.r)
                          : Radius.circular(20.r),
                    ),
                    border: !isUser
                        ? Border.all(
                            color: const Color(0xFF2D2D2D),
                            width: 1,
                          )
                        : null,
                  ),
                  child: Text(
                    message.text,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Colors.white,
                      height: 1.4,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  DateFormat('hh:mm a').format(message.timestamp),
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          if (isUser) ...[
            SizedBox(width: 8.w),
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                color: Colors.grey[400],
                size: 16.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: widget.accentColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.smart_toy,
              color: Colors.white,
              size: 16.sp,
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
                bottomLeft: Radius.circular(4.r),
              ),
              border: Border.all(
                color: const Color(0xFF2D2D2D),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                3,
                (i) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  width: 6.w,
                  height: 6.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return BlocBuilder<MicroserviceChatCubit, MicroserviceChatState>(
      builder: (context, state) {
        final isLoading = state is MicroserviceChatMessageLoading;

        return Container(
          padding: EdgeInsets.all(20.w),
          decoration: const BoxDecoration(
            color: Color(0xFF1F1F1F),
            border: Border(
              top: BorderSide(color: Color(0xFF2D2D2D), width: 1),
            ),
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A0A0A),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Ask about ${widget.serviceName.toLowerCase()}...',
                        hintStyle: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: Colors.grey[500],
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 12.h,
                        ),
                      ),
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                      maxLines: 3,
                      minLines: 1,
                      enabled: !isLoading,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                GestureDetector(
                  onTap: isLoading ? null : _sendMessage,
                  child: Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: isLoading
                          ? Colors.grey
                          : widget.accentColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isLoading ? Icons.hourglass_empty : Icons.send,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
