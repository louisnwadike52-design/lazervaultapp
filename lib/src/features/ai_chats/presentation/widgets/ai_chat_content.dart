import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import '../../cubit/ai_chat_cubit.dart';
import '../../cubit/ai_chat_state.dart';
import '../../domain/entities/ai_chat_message_entity.dart';

// Local UI ChatMessage model wrapping the domain entity
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final ChatMessageType type;
  final List<ActionButtonEntity>? actionButtons;
  final ConfirmationDataEntity? confirmationData;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.type = ChatMessageType.text,
    this.actionButtons,
    this.confirmationData,
  });

  factory ChatMessage.fromEntity(ChatMessageEntity entity) {
    return ChatMessage(
      text: entity.text,
      isUser: entity.isUser,
      timestamp: entity.timestamp,
      type: entity.type,
      actionButtons: entity.actionButtons,
      confirmationData: entity.confirmationData,
    );
  }
}

class AiChatContent extends StatefulWidget {
  const AiChatContent({super.key});

  @override
  State<AiChatContent> createState() => _AiChatContentState();
}

class _AiChatContentState extends State<AiChatContent> with TickerProviderStateMixin {
  // --- State variables ---
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  // final List<ChatMessage> _messages = []; // REMOVED - Managed by Cubit state
  // bool _isTyping = false; // REMOVED - Managed by Cubit state
  bool _isAttaching = false; // Kept for local UI state during image preview
  late AnimationController _typingDotsController;
  // Suggestions are now part of the state, but keeping a default here for fallback if needed
  final List<String> _defaultSuggestions = [
    "How do I send money internationally?",
    "What are the best investment options?",
    "Explain cryptocurrency trading",
    "How to manage my spending?",
    "Set up recurring payments",
  ];
  // --- End State Variables ---

  @override
  void initState() {
    super.initState();
    _typingDotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _loadHistory();
      }
    });
  }

  Future<void> _loadHistory() async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      context.read<AIChatCubit>().loadChatHistory(accessToken: authState.profile.session.accessToken);
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _typingDotsController.dispose();
    super.dispose();
  }

  // --- Methods --- 

  // REMOVED - Initial suggestions shown based on state.messages in builder
  // void _showInitialSuggestions() { ... }

  void _scrollToBottom({bool isDelayed = false}) {
    Future.delayed(Duration(milliseconds: isDelayed ? 100 : 0), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _handleSubmitted(String text, {File? image}) async {
    final messageText = text.trim();
    if (messageText.isEmpty && image == null) return;

    _messageController.clear();
    FocusScope.of(context).unfocus();

    // REMOVED setState for adding user message locally - Cubit handles it
    // final userMessage = ChatMessage(...);
    // setState(() { ... });

    // Scroll happens optimistically, or can be triggered by listener/builder on state change
    _scrollToBottom(isDelayed: true);

    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      Get.snackbar('Error', 'User not authenticated. Please log in.');
      // REMOVED setState(() => _isTyping = false);
      return;
    }
    final accessToken = authState.profile.session.accessToken;

    // Call cubit method
    context.read<AIChatCubit>().sendMessage(messageText, accessToken: accessToken);

    // Set attaching state back to false if an image was sent
    if (image != null && mounted) {
       setState(() => _isAttaching = false);
    }
  }

  Future<void> _handleImagePicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (!mounted) return;
      setState(() => _isAttaching = true); // Local UI state for preview

      Get.bottomSheet(
        _buildImagePreviewSheet(File(image.path)),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
      ).whenComplete(() {
        if (_isAttaching && mounted) { // If sheet closed without sending
          setState(() => _isAttaching = false);
        }
      });
    }
  }

  Widget _buildImagePreviewSheet(File image) {
    final captionController = TextEditingController();
    return Container(
      height: 0.4.sh,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.file(image, fit: BoxFit.contain),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: captionController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Add a caption...',
                      hintStyle: const TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                GestureDetector(
                  onTap: () {
                    final caption = captionController.text;
                    captionController.dispose();
                    Get.back();
                    // _isAttaching is set to false within _handleSubmitted
                    _handleSubmitted(caption, image: image);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.send_rounded, color: Colors.white, size: 20.sp),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showOptionsSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            _buildOptionTile(
              'Clear Chat',
              Icons.delete_outline_rounded,
              Colors.red,
              () {
                Get.back();
                // Call cubit to clear chat
                context.read<AIChatCubit>().clearChat();
                // REMOVED setState
                // UI will rebuild via builder showing initial state
              },
            ),
            _buildOptionTile(
              'Export Chat',
              Icons.download_rounded,
              Colors.blue,
              () {
                Get.back();
                Get.snackbar('Info', 'Export chat not implemented yet.');
              },
            ),
            _buildOptionTile(
              'AI Settings',
              Icons.settings_rounded,
              Colors.green,
              () {
                Get.back();
                Get.snackbar('Info', 'AI settings not implemented yet.');
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildOptionTile(String title, IconData icon, Color color, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20.sp),
      ),
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
      onTap: onTap,
    );
  }

  // --- Build methods --- 

  // Updated to accept isTyping status
  PreferredSizeWidget _buildAppBar(bool isTyping) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.smart_toy_rounded, color: Colors.blue, size: 24.sp),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LazerAI Assistant',
                style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              // Pass isTyping down
              _buildStatusIndicator(isTyping),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
          onPressed: _showOptionsSheet,
        ),
      ],
    );
  }

  // Updated to accept isTyping status
  Widget _buildStatusIndicator(bool isTyping) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          margin: EdgeInsets.only(right: 4.w),
          decoration: BoxDecoration(
            color: isTyping ? Colors.blue : Colors.green, // Use parameter
            shape: BoxShape.circle,
          ),
        ),
        Text(
          isTyping ? 'Typing...' : 'Online', // Use parameter
          style: TextStyle(color: isTyping ? Colors.blue : Colors.green, fontSize: 12.sp),
        ),
      ],
    );
  }

  Widget _buildChatHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.05),
        border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, color: Colors.blue, size: 20.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'I can help you with various tasks. Feel free to ask anything!',
              style: TextStyle(color: Colors.white70, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  // Updated to accept the list of messages
  Widget _buildMessagesList(List<ChatMessageEntity> messageEntities) {
     // Map entities to UI models
     final messages = messageEntities.map((entity) => ChatMessage.fromEntity(entity)).toList();

     // Add initial bot message if the list is empty
     if (messages.isEmpty) {
        messages.add(ChatMessage(
          text: "Hello! I'm your LazerAI financial assistant. How can I help you today?",
          isUser: false,
          timestamp: DateTime.now(),
        ));
     }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        itemCount: messages.length, 
        itemBuilder: (context, index) {
          final message = messages[index]; 
          return _buildMessageBubble(message);
        },
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final bool isUser = message.isUser;

    // Render rich message types for AI responses
    if (!isUser && message.type == ChatMessageType.confirmation && message.confirmationData != null) {
      return _buildConfirmationCard(message);
    }
    if (!isUser && message.type == ChatMessageType.actionCard && message.actionButtons != null) {
      return _buildActionCard(message);
    }

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 16.h,
          left: isUser ? 64.w : 0,
          right: isUser ? 0 : 64.w,
        ),
        child: Column(
          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (message.text.isNotEmpty)
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: isUser ? Colors.blue.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                    bottomLeft: Radius.circular(isUser ? 16.r : 4.r),
                    bottomRight: Radius.circular(isUser ? 4.r : 16.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MarkdownBody(
                      data: message.text,
                      selectable: true,
                      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                        p: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white, fontSize: 14.sp),
                        code: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: 'monospace',
                          backgroundColor: Colors.black.withValues(alpha: 0.2),
                          color: Colors.lightBlueAccent,
                          fontSize: 13.sp,
                        ),
                        blockSpacing: 8.0,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(_formatTime(message.timestamp), style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 10.sp)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationCard(ChatMessage message) {
    final cd = message.confirmationData!;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h, right: 32.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.text.isNotEmpty) ...[
              MarkdownBody(
                data: message.text,
                styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                  p: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white, fontSize: 14.sp),
                ),
              ),
              SizedBox(height: 12.h),
            ],
            // Confirmation details card
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _buildConfirmRow('Action', cd.actionType.replaceAll('_', ' ').toUpperCase()),
                  if (cd.amount.isNotEmpty) _buildConfirmRow('Amount', '${cd.currency} ${cd.amount}'),
                  if (cd.recipientName.isNotEmpty) _buildConfirmRow('To', cd.recipientName),
                  if (cd.description != null && cd.description!.isNotEmpty)
                    _buildConfirmRow('Note', cd.description!),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            // Confirm / Cancel buttons
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _handleSubmitted('Cancel'),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text('Cancel', style: TextStyle(color: Colors.white70, fontSize: 14.sp)),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _handleSubmitted('Yes, confirm'),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(_formatTime(message.timestamp), style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 10.sp)),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
          Flexible(
            child: Text(value, style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w500),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(ChatMessage message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h, right: 32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.text.isNotEmpty)
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                    bottomLeft: Radius.circular(4.r),
                    bottomRight: Radius.circular(16.r),
                  ),
                ),
                child: MarkdownBody(
                  data: message.text,
                  styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                    p: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white, fontSize: 14.sp),
                  ),
                ),
              ),
            SizedBox(height: 8.h),
            // Action buttons as horizontal scrollable chips
            SizedBox(
              height: 40.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: message.actionButtons!.length,
                itemBuilder: (context, index) {
                  final btn = message.actionButtons![index];
                  return GestureDetector(
                    onTap: () {
                      if (btn.actionType == 'quick_reply') {
                        _handleSubmitted(btn.payload);
                      } else if (btn.actionType == 'navigate') {
                        Get.toNamed(btn.payload);
                      } else {
                        _handleSubmitted(btn.label);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 8.w),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.4)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (btn.icon != null && btn.icon!.isNotEmpty) ...[
                            Icon(Icons.arrow_forward_rounded, color: const Color(0xFF3B82F6), size: 14.sp),
                            SizedBox(width: 4.w),
                          ],
                          Text(btn.label, style: TextStyle(color: const Color(0xFF3B82F6), fontSize: 12.sp, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 4.h),
            Text(_formatTime(message.timestamp), style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 10.sp)),
          ],
        ),
      ),
    );
  }

  // Updated to accept isTyping status
  Widget _buildTypingIndicator(bool isTyping) {
    if (!isTyping) return const SizedBox.shrink(); 
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _typingDotsController,
                  builder: (context, child) {
                    final double opacity = _typingDotsController.isAnimating
                                        ? ((index / 3 + _typingDotsController.value) % 1)
                                        : (index / 3.0);
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                      height: 8.h,
                      width: 8.w,
                      decoration: BoxDecoration(color: Colors.blue.withValues(alpha: opacity), shape: BoxShape.circle),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // Updated to accept the list of messages and suggestions from state
  Widget _buildInputArea(List<ChatMessageEntity> messages, List<String> suggestions) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
      ),
      child: Column(
        children: [
          // Show suggestions if message list is effectively empty (only initial bot message maybe) 
          // or if the text field is empty
          if (messages.isEmpty || _messageController.text.isEmpty)
            Container(
              height: 40.h,
              margin: EdgeInsets.only(bottom: 12.h),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: suggestions.isNotEmpty ? suggestions.length : _defaultSuggestions.length,
                itemBuilder: (context, index) {
                  final suggestionText = suggestions.isNotEmpty ? suggestions[index] : _defaultSuggestions[index];
                  return GestureDetector(
                    onTap: () => _handleSubmitted(suggestionText),
                    child: Container(
                      margin: EdgeInsets.only(right: 8.w),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                      ),
                      child: Text(suggestionText, style: TextStyle(color: Colors.blue[300], fontSize: 12.sp)),
                    ),
                  );
                },
              ),
            ),
          Row(
            children: [
              _buildAttachButton(),
              SizedBox(width: 8.w),
              _buildMicButton(),
              SizedBox(width: 8.w),
              Expanded(child: _buildTextField()),
              SizedBox(width: 8.w),
              _buildSendButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttachButton() {
    return GestureDetector(
      onTap: _handleImagePicker,
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), shape: BoxShape.circle),
        child: Icon(Icons.add_photo_alternate_rounded, color: Colors.white.withValues(alpha: 0.7), size: 20.sp),
      ),
    );
  }

  Widget _buildMicButton() {
    return GestureDetector(
      onTap: () {
        Get.snackbar('Info', 'Voice input is currently disabled.', snackPosition: SnackPosition.BOTTOM);
      },
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.1), shape: BoxShape.circle),
        child: Icon(Icons.mic_off, color: Colors.grey, size: 20.sp),
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: TextField(
        controller: _messageController,
        style: const TextStyle(color: Colors.white),
        textInputAction: TextInputAction.send,
        onSubmitted: (text) {
          _handleSubmitted(text);
        },
        onChanged: (text) {
          setState(() {}); // Keep setState here to update Send button state
        },
        decoration: InputDecoration(
          hintText: 'Type a message...',
          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
          border: InputBorder.none,
        ),
        maxLines: null,
      ),
    );
  }

  Widget _buildSendButton() {
    // Send button enabled state depends on text field or attaching state
    final bool isEnabled = _messageController.text.trim().isNotEmpty || _isAttaching;
    return GestureDetector(
      onTap: isEnabled ? () => _handleSubmitted(_messageController.text) : null,
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: isEnabled ? Colors.blue : Colors.grey,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.send_rounded, color: Colors.white, size: 20.sp),
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AIChatCubit, AIChatState>(
      listener: (context, state) {
        // Listener now only handles side-effects not directly tied to build
        if (!mounted) return; 

        // Handle errors with Snackbars
        if (state is AIChatHistoryError) {
          Get.snackbar('Error Loading History', state.message);
        } else if (state is AIChatMessageError) {
          Get.snackbar(
            'Error', state.errorMessage,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withValues(alpha: 0.8),
            colorText: Colors.white
          );
        }

        // Trigger scroll to bottom when new messages arrive or history loads
        if (state is AIChatHistorySuccess || state is AIChatMessageSuccess || state is AIChatMessageLoading) {
           _scrollToBottom(isDelayed: true); // This scrolls to the bottom
        }

        // Optional: Print statements for debugging state changes
        // print("State changed: ${state.runtimeType}, isTyping: ${state.isTyping}, messages: ${state.messages.length}");
      },
      builder: (context, state) {
        // Builder uses the state to construct the UI
        // Map ChatMessageEntity to ChatMessage UI model here or in build methods
        final messageEntities = state.messages;
        final isTyping = state.isTyping;
        final suggestions = state.suggestions;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 60.h),
            decoration: const BoxDecoration(color: Color(0xFF1E1E1E)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              // Pass isTyping status to AppBar
              appBar: _buildAppBar(isTyping), 
              body: Column(
                children: [
                  _buildChatHeader(),
                  // Pass message entities to list builder
                  Expanded(child: _buildMessagesList(messageEntities)), 
                  // Pass isTyping status to indicator
                  _buildTypingIndicator(isTyping), 
                  // Pass messages and suggestions to input area
                  _buildInputArea(messageEntities, suggestions), 
                ],
              ),
            ),
          ),
        );
      }
    );
  }
} 