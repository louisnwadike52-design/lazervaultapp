import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/utils/pin_mask_utils.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/src/features/ai_chats/cubit/ai_chat_cubit.dart';
import 'package:lazervault/src/features/ai_chats/cubit/ai_chat_state.dart';
import 'package:lazervault/src/features/ai_chats/domain/entities/ai_chat_message_entity.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

/// Chatbot-powered transfer screen
/// Uses AI chat interface for seamless transfer experience
/// with bottom navigation for quick actions
class ChatbotTransferScreen extends StatefulWidget {
  const ChatbotTransferScreen({super.key});

  @override
  State<ChatbotTransferScreen> createState() => _ChatbotTransferScreenState();
}

class _ChatbotTransferScreenState extends State<ChatbotTransferScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isPinMode = false;

  // --- Bottom Navigation Items ---
  int _currentIndex = 0;

  // --- Bottom Navigation Items ---
  final List<_BottomNavItem> _bottomNavItems = [
    _BottomNavItem(
      icon: Icons.home_rounded,
      label: 'Dashboard',
      route: '/dashboard',
    ),
    _BottomNavItem(
      icon: Icons.history_rounded,
      label: 'History',
      route: '/transactions/dashboard',
    ),
    _BottomNavItem(
      icon: Icons.people_rounded,
      label: 'Recipients',
      route: '/select-recipient',
    ),
    _BottomNavItem(
      icon: Icons.qr_code_scanner_rounded,
      label: 'Scan QR',
      route: '/qr-scanner',
    ),
    _BottomNavItem(
      icon: Icons.card_giftcard_rounded,
      label: 'Buy Gift Card',
      route: '/gift-cards',
    ),
    _BottomNavItem(
      icon: Icons.receipt_long_rounded,
      label: 'Invoices',
      route: '/invoice',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = 2; // Start on Chat tab (index 2)
    // Load chat history when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _loadChatHistory();
      }
    });
  }

  Future<void> _loadChatHistory() async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      final accessToken = authState.profile.session.accessToken;
      context.read<AIChatCubit>().loadChatHistory(accessToken: accessToken);
    }
  }

  void _handleSubmitted(String text) async {
    final messageText = text.trim();
    if (messageText.isEmpty) return;

    _messageController.clear();
    if (_isPinMode) setState(() => _isPinMode = false);
    FocusScope.of(context).unfocus();

    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      Get.snackbar('Error', 'Please log in first.');
      return;
    }

    final accessToken = authState.profile.session.accessToken;

    // Call cubit method to send message
    context.read<AIChatCubit>().sendMessage(messageText, accessToken: accessToken);

    _scrollToBottom(isDelayed: true);
  }

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

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvoiceThemeColors.primaryBackground,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Chat messages area
          Expanded(
            child: BlocConsumer<AIChatCubit, AIChatState>(
              listener: (context, state) {
                if (state is AIChatHistoryError) {
                  Get.snackbar('Error Loading History', state.message);
                }

                // Scroll to bottom when new messages arrive
                if (state is AIChatHistorySuccess ||
                    state is AIChatMessageSuccess ||
                    state is AIChatMessageLoading) {
                  _scrollToBottom(isDelayed: true);
                }

                // Debug logging
                if (state is AIChatMessageLoading) {
                  print('Chat is typing...');
                }
              },
              builder: (context, state) {
                // Build messages list from state
                final messageEntities = state.messages;

                // Hide chat history when user is entering a PIN
                return _isPinMode
                    ? _buildPinOverlay()
                    : _buildMessagesList(messageEntities);
              },
            ),
          ),

          // Bottom navigation
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: InvoiceThemeColors.primaryPurple,
                  width: 1.5,
                ),
              ),
              child: Icon(Icons.smart_toy_rounded, color: InvoiceThemeColors.gradientPurple, size: 24.sp),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NOVA Transfer',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Tell me what to send',
                  style: TextStyle(color: InvoiceThemeColors.textGray400, fontSize: 12.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Quick action buttons row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: List.generate(_bottomNavItems.length, (index) {
                  final item = _bottomNavItems[index];
                  final isSelected = _currentIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex = index;
                      });

                      // Handle navigation
                      if (item.route.isNotEmpty) {
                        Get.toNamed(item.route);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isSelected ? InvoiceThemeColors.primaryPurple.withValues(alpha: 0.15) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            item.icon,
                            color: isSelected ? InvoiceThemeColors.gradientPurple : InvoiceThemeColors.textGray500,
                            size: 20.sp,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            item.label,
                            style: TextStyle(
                              color: isSelected ? InvoiceThemeColors.gradientPurple : InvoiceThemeColors.textGray500,
                              fontSize: 11.sp,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Input field and send button
            Container(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: InvoiceThemeColors.secondaryBackground,
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(color: InvoiceThemeColors.borderColor),
                      ),
                      child: TextField(
                        controller: _messageController,
                        style: const TextStyle(color: Colors.white),
                        textInputAction: TextInputAction.send,
                        obscureText: _isPinMode,
                        obscuringCharacter: '*',
                        keyboardType: _isPinMode ? TextInputType.number : TextInputType.text,
                        maxLines: _isPinMode ? 1 : null,
                        onSubmitted: (text) {
                          _handleSubmitted(text);
                          if (_isPinMode) setState(() => _isPinMode = false);
                        },
                        onChanged: (text) {
                          final looksLikePin = RegExp(r'^\d{4,6}$').hasMatch(text.trim());
                          if (looksLikePin != _isPinMode) {
                            setState(() => _isPinMode = looksLikePin);
                          }
                        },
                        decoration: InputDecoration(
                          hintText: _isPinMode ? 'Enter your PIN...' : 'Type a message...',
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: () => _handleSubmitted(_messageController.text),
                    child: Container(
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            InvoiceThemeColors.primaryPurple,
                            InvoiceThemeColors.gradientPurple,
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(Icons.send_rounded, color: Colors.white, size: 20.sp),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinOverlay() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.lock_rounded, color: InvoiceThemeColors.primaryPurple, size: 48.sp),
          ),
          SizedBox(height: 16.h),
          Text(
            'Secure PIN Entry',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Chat hidden for your security',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList(List<ChatMessageEntity> messages) {
    // Add initial bot message if list is empty
    final chatMessages = messages.isEmpty
        ? [
            ChatMessageEntity(
              text: "Hi! I'm your AI transfer assistant. How can I help you send money today?",
              isUser: false,
              timestamp: DateTime.now(),
            ),
          ]
        : messages;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        itemCount: chatMessages.length,
        itemBuilder: (context, index) {
          final message = chatMessages[index];
          return _buildMessageBubble(message);
        },
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessageEntity message) {
    final bool isUser = message.isUser;

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
                  color: isUser ? InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2) : InvoiceThemeColors.secondaryBackground,
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
                    if (message.confirmationData != null)
                      _buildConfirmationDetails(message.confirmationData!),
                    MarkdownBody(
                      data: isUser ? maskIfPin(message.text) : message.text,
                      selectable: !isUser || !isPinText(message.text),
                      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                        p: Theme.of(context).textTheme.bodyMedium?.copyWith(color: isUser ? Colors.white70 : Colors.white),
                        code: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: 'monospace',
                          backgroundColor: Colors.black.withValues(alpha: 0.1),
                          color: Colors.lightBlueAccent,
                          fontSize: 13.sp,
                        ),
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

  Widget _buildConfirmationDetails(ConfirmationDataEntity data) {
    return Container(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildConfirmRow('Action', data.actionType.replaceAll('_', ' ').toUpperCase()),
          if (data.amount.isNotEmpty) _buildConfirmRow('Amount', '${data.currency} ${data.amount}'),
          if (data.recipientName.isNotEmpty) _buildConfirmRow('To', data.recipientName),
          if (data.description != null && data.description!.isNotEmpty)
            _buildConfirmRow('Note', data.description!),
        ],
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
            child: Text(value, style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}

class _BottomNavItem {
  final IconData icon;
  final String label;
  final String route;
  _BottomNavItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}
