import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:lazervault/src/features/microservice_chat/cubit/microservice_chat_cubit.dart';
import 'package:lazervault/src/features/microservice_chat/cubit/microservice_chat_state.dart';
import 'package:lazervault/src/features/microservice_chat/domain/entities/microservice_chat_message_entity.dart';
import 'chat_media_bubble.dart';
import 'chat_media_input_bar.dart';

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

class _MicroserviceChatContentState extends State<MicroserviceChatContent>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _typingDotsController;
  String? _userAvatarUrl;

  // Media state
  final ImagePicker _imagePicker = ImagePicker();
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  bool _isPickingMedia = false;
  Duration _recordingDuration = Duration.zero;
  Timer? _recordingTimer;
  static const _maxRecordingDuration = Duration(minutes: 5);

  @override
  void initState() {
    super.initState();
    _typingDotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _loadUserAvatar();
  }

  Future<void> _loadUserAvatar() async {
    const storage = FlutterSecureStorage();
    final url = await storage.read(key: 'user_avatar_url');
    if (mounted && url != null && url.isNotEmpty) {
      setState(() => _userAvatarUrl = url);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _typingDotsController.dispose();
    _recordingTimer?.cancel();
    if (_isRecording) {
      _audioRecorder.stop();
    }
    _audioRecorder.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 300), () {
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

  String _inferMimeType(String path) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    if (lower.endsWith('.gif')) return 'image/gif';
    return 'image/jpeg';
  }

  Future<void> _pickImage() async {
    if (_isPickingMedia) return;
    _isPickingMedia = true;
    try {
      final picked = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      if (picked != null && mounted) {
        final mimeType = picked.mimeType ?? _inferMimeType(picked.path);
        context.read<MicroserviceChatCubit>().sendMediaMessage(
          mediaType: 'image',
          localFilePath: picked.path,
          mimeType: mimeType,
          text: _textController.text.trim(),
        );
        _textController.clear();
      }
    } catch (_) {
      // Picker cancelled or permission denied
    } finally {
      _isPickingMedia = false;
    }
  }

  Future<void> _captureImage() async {
    if (_isPickingMedia) return;
    _isPickingMedia = true;
    try {
      final picked = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      if (picked != null && mounted) {
        final mimeType = picked.mimeType ?? _inferMimeType(picked.path);
        context.read<MicroserviceChatCubit>().sendMediaMessage(
          mediaType: 'image',
          localFilePath: picked.path,
          mimeType: mimeType,
          text: _textController.text.trim(),
        );
        _textController.clear();
      }
    } catch (_) {
      // Picker cancelled or permission denied
    } finally {
      _isPickingMedia = false;
    }
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      await _stopRecording();
    } else {
      await _startRecording();
    }
  }

  Future<void> _startRecording() async {
    if (_isRecording) return;
    final hasPermission = await _audioRecorder.hasPermission();
    if (!hasPermission) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Microphone permission is required for voice notes'),
            backgroundColor: Color(0xFFEF4444),
          ),
        );
      }
      return;
    }
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
    await _audioRecorder.start(
      const RecordConfig(encoder: AudioEncoder.aacLc),
      path: path,
    );
    setState(() {
      _isRecording = true;
      _recordingDuration = Duration.zero;
    });
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _recordingDuration += const Duration(seconds: 1));
      if (_recordingDuration >= _maxRecordingDuration) {
        _stopRecording();
      }
    });
  }

  Future<void> _stopRecording() async {
    _recordingTimer?.cancel();
    _recordingTimer = null;
    if (!_isRecording) return;
    final path = await _audioRecorder.stop();
    final durationMs = _recordingDuration.inMilliseconds;
    setState(() {
      _isRecording = false;
      _recordingDuration = Duration.zero;
    });
    if (path != null && mounted && durationMs > 500) {
      context.read<MicroserviceChatCubit>().sendMediaMessage(
        mediaType: 'voice',
        localFilePath: path,
        mimeType: 'audio/mp4',
        audioDurationMs: durationMs,
      );
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
      body: BlocConsumer<MicroserviceChatCubit, MicroserviceChatState>(
        listener: (context, state) {
          if (state is MicroserviceChatMessageSuccess) {
            _scrollToBottom();
          } else if (state is MicroserviceChatMessageLoading) {
            _scrollToBottom();
          } else if (state is MicroserviceChatMessageError) {
            Get.snackbar(
              'Error',
              state.errorMessage,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withValues(alpha: 0.8),
              colorText: Colors.white,
            );
          }
        },
        builder: (context, state) {
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

  Widget _buildUserAvatar() {
    if (_userAvatarUrl != null) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: _userAvatarUrl!,
          width: 36,
          height: 36,
          fit: BoxFit.cover,
          placeholder: (_, __) => CircleAvatar(
            backgroundColor: Colors.blue.withValues(alpha: 0.2),
            child: const Icon(Icons.person, color: Colors.blue, size: 20),
          ),
          errorWidget: (_, __, ___) => CircleAvatar(
            backgroundColor: Colors.blue.withValues(alpha: 0.2),
            child: const Icon(Icons.person, color: Colors.blue, size: 20),
          ),
        ),
      );
    }
    return CircleAvatar(
      backgroundColor: Colors.blue.withValues(alpha: 0.2),
      child: const Icon(Icons.person, color: Colors.blue, size: 20),
    );
  }

  Widget _buildMessageBubble(MicroserviceChatMessageEntity message) {
    final isUser = message.isUser;
    final maxBubbleWidth = MediaQuery.of(context).size.width * 0.72;

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
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxBubbleWidth),
              child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isUser ? Colors.blue : Colors.grey[800],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.mediaType != null) ...[
                    ChatMediaBubble(
                      mediaType: message.mediaType,
                      localMediaPath: message.localMediaPath,
                      mediaUrl: message.mediaUrl,
                      audioDurationMs: message.audioDurationMs,
                      transcript: message.transcript,
                      isUser: isUser,
                    ),
                    if (message.text.isNotEmpty &&
                        message.text != 'Sent an image' &&
                        message.text != 'Sent a voice note')
                      const SizedBox(height: 8),
                  ],
                  if (message.text.isNotEmpty &&
                      message.text != 'Sent an image' &&
                      message.text != 'Sent a voice note') ...[
                    isUser
                        ? Text(
                            message.text,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          )
                        : MarkdownBody(
                            data: message.text,
                            selectable: true,
                            styleSheet:
                                MarkdownStyleSheet.fromTheme(Theme.of(context))
                                    .copyWith(
                              p: TextStyle(
                                color: Colors.grey[100],
                                fontSize: 15,
                                height: 1.45,
                              ),
                              strong: TextStyle(
                                color: Colors.grey[100],
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                              em: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                              ),
                              listBullet: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 15,
                                height: 1.45,
                              ),
                              listBulletPadding: const EdgeInsets.only(right: 6),
                              listIndent: 16,
                              blockSpacing: 6.0,
                              a: const TextStyle(
                                color: Color(0xFF60A5FA),
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                  ],
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
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            _buildUserAvatar(),
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
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _typingDotsController,
                  builder: (context, child) {
                    final double phase =
                        (_typingDotsController.value + index / 3) % 1.0;
                    final double bounce =
                        (phase < 0.5) ? (phase * 2) : (2 - phase * 2);
                    return Transform.translate(
                      offset: Offset(0, -bounce * 6),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.4 + bounce * 0.6),
                          shape: BoxShape.circle,
                        ),
                      ),
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
        child: _isRecording
            ? RecordingIndicator(
                duration: _recordingDuration,
                onStop: _stopRecording,
              )
            : Row(
                children: [
                  if (state is! MicroserviceChatMessageLoading)
                    ChatMediaInputBar(
                      onImagePick: _pickImage,
                      onCameraCapture: _captureImage,
                      onVoiceRecord: _toggleRecording,
                      isRecording: _isRecording,
                    ),
                  if (state is! MicroserviceChatMessageLoading)
                    const SizedBox(width: 6),
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
