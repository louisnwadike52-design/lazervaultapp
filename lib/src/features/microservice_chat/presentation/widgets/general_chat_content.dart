import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/microservice_chat/cubit/general_chat_cubit.dart';
import 'package:lazervault/src/features/microservice_chat/cubit/general_chat_state.dart';
import 'package:lazervault/src/features/microservice_chat/domain/entities/general_chat_message_entity.dart';

class GeneralChatContent extends StatefulWidget {
  const GeneralChatContent({super.key});

  @override
  State<GeneralChatContent> createState() => _GeneralChatContentState();
}

class _GeneralChatContentState extends State<GeneralChatContent> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: _buildAppBar(context),
      body: BlocBuilder<GeneralChatCubit, GeneralChatState>(
        builder: (context, state) {
          if (state is GeneralChatSuccess) {
            _scrollToBottom();
          }

          return Column(
            children: [
              Expanded(
                child: _buildMessagesList(state.messages, state is GeneralChatLoading),
              ),
              _buildInputArea(state),
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1E1E1E),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: BlocBuilder<GeneralChatCubit, GeneralChatState>(
        builder: (context, state) {
          String? currentService;
          if (state is GeneralChatSuccess) {
            currentService = state.currentService;
          }

          return Column(
            children: [
            const Text(
              'LazerVault Chat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (currentService != null)
              Text(
                'Connected to ${_getServiceDisplayName(currentService)}',
                style: TextStyle(
                  color: Colors.green[400],
                  fontSize: 11,
                ),
              ),
          ],
        );
      },
    ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh, color: Colors.white),
          onPressed: () {
            context.read<GeneralChatCubit>().clearChat();
          },
        ),
        IconButton(
          icon: const Icon(Icons.clear, color: Colors.white),
          onPressed: () {
            _showClearChatDialog(context);
          },
        ),
      ],
    );
  }

  Widget _buildMessagesList(List<GeneralChatMessageEntity> messages, bool isLoading) {
    if (messages.isEmpty && !isLoading) {
      return _buildEmptyState();
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: messages.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= messages.length) {
          return _buildTypingIndicator();
        }

        final message = messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 80,
            color: Colors.blue.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'Welcome to LazerVault Chat!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'I can help you with all LazerVault services',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(GeneralChatMessageEntity message) {
    final isUser = message.isUser;
    final isSystemMessage = message.metadata?['isSystemMessage'] == true;

    if (isSystemMessage) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                backgroundColor: Colors.blue.withOpacity(0.2),
                child: const Icon(Icons.smart_toy, color: Colors.blue, size: 20),
              ),
            ),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isUser ? Colors.blue : Colors.grey[800],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isUser ? Colors.blue : Colors.grey[700]!,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.grey[100],
                      fontSize: 15,
                    ),
                  ),
                  if (message.serviceRoutedTo != null && message.serviceRoutedTo != 'gateway') ...[
                    const SizedBox(height: 4),
                    Text(
                      'via ${_getServiceDisplayName(message.serviceRoutedTo!)}',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Colors.blue.withOpacity(0.2),
              child: const Icon(Icons.person, color: Colors.blue, size: 20),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              backgroundColor: Colors.blue.withOpacity(0.2),
              child: const Icon(Icons.smart_toy, color: Colors.blue, size: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[700]!, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(),
                const SizedBox(width: 4),
                _buildTypingDot(),
                const SizedBox(width: 4),
                _buildTypingDot(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildInputArea(GeneralChatState state) {
    final isLoading = state is GeneralChatLoading;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        border: Border(
          top: BorderSide(color: Colors.grey[800]!, width: 1),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Ask me anything about LazerVault...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                minLines: 1,
                maxLines: 4,
                onSubmitted: (text) {
                  if (text.trim().isNotEmpty && !isLoading) {
                    context.read<GeneralChatCubit>().sendMessage(text);
                    _textController.clear();
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                if (_textController.text.trim().isNotEmpty && !isLoading) {
                  context.read<GeneralChatCubit>().sendMessage(_textController.text);
                  _textController.clear();
                }
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isLoading ? Colors.grey : Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isLoading ? Icons.hourglass_empty : Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showClearChatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Clear Chat?',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'This will clear the conversation history. Continue?',
          style: TextStyle(color: Colors.grey[300]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<GeneralChatCubit>().clearChat();
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  String _getServiceDisplayName(String service) {
    final displayNames = {
      'accounts': 'Accounts',
      'payments': 'Payments',
      'transfers': 'Transfers',
      'investments': 'Investments',
      'financial_products': 'Financial Products',
      'giftcards': 'Gift Cards',
      'invoices': 'Invoices',
      'utility': 'Utility Bills',
    };
    return displayNames[service] ?? service;
  }
}
