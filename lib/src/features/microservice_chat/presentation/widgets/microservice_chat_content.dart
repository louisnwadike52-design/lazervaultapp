import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/microservice_chat/cubit/microservice_chat_cubit.dart';
import 'package:lazervault/src/features/microservice_chat/cubit/microservice_chat_state.dart';
import 'package:lazervault/src/features/microservice_chat/domain/entities/microservice_chat_message_entity.dart';

class MicroserviceChatContent extends StatefulWidget {
  final String serviceName;
  final String sourceContext;

  const MicroserviceChatContent({
    super.key,
    required this.serviceName,
    required this.sourceContext,
  });

  @override
  State<MicroserviceChatContent> createState() => _MicroserviceChatContentState();
}

class _MicroserviceChatContentState extends State<MicroserviceChatContent> {
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
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          children: [
            Text(
              '${widget.serviceName} Chat',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Powered by AI',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear, color: Colors.white),
            onPressed: () {
              context.read<MicroserviceChatCubit>().clearChat();
            },
          ),
        ],
      ),
      body: BlocBuilder<MicroserviceChatCubit, MicroserviceChatState>(
        builder: (context, state) {
          // Scroll to bottom when new messages arrive
          if (state is MicroserviceChatMessageSuccess) {
            _scrollToBottom();
          }

          return Column(
            children: [
              Expanded(
                child: _buildMessagesList(state.messages, state.isTyping),
              ),
              _buildInputArea(state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMessagesList(List<MicroserviceChatMessageEntity> messages, bool isTyping) {
    if (messages.isEmpty && !isTyping) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.smart_toy,
              size: 80,
              color: Colors.blue.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Chat with ${widget.serviceName}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ask me anything about ${widget.serviceName.toLowerCase()}',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: messages.length + (isTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= messages.length) {
          // Show typing indicator
          return _buildTypingIndicator();
        }

        final message = messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(MicroserviceChatMessageEntity message) {
    final isUser = message.isUser;

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
                backgroundColor: Colors.blue.withValues(alpha: 0.2),
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
                  if (message.serviceRoutedTo != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'via ${message.serviceRoutedTo}',
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
              backgroundColor: Colors.blue.withValues(alpha: 0.2),
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
              backgroundColor: Colors.blue.withValues(alpha: 0.2),
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

  Widget _buildInputArea(MicroserviceChatState state) {
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
                  hintText: 'Type your message...',
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
                  if (text.trim().isNotEmpty && state is! MicroserviceChatMessageLoading) {
                    context.read<MicroserviceChatCubit>().sendMessage(text);
                    _textController.clear();
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                if (_textController.text.trim().isNotEmpty && state is! MicroserviceChatMessageLoading) {
                  context.read<MicroserviceChatCubit>().sendMessage(_textController.text);
                  _textController.clear();
                }
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: state is MicroserviceChatMessageLoading
                      ? Colors.grey
                      : Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  state is MicroserviceChatMessageLoading
                      ? Icons.hourglass_empty
                      : Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
