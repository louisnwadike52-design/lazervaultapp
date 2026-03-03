import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:lazervault/src/features/microservice_chat/cubit/general_chat_cubit.dart';
import 'package:lazervault/src/features/microservice_chat/cubit/general_chat_state.dart';
import 'package:lazervault/src/features/microservice_chat/domain/entities/general_chat_message_entity.dart';
import 'chat_media_bubble.dart';
import 'chat_media_input_bar.dart';

class GeneralChatContent extends StatefulWidget {
  const GeneralChatContent({super.key});

  @override
  State<GeneralChatContent> createState() => _GeneralChatContentState();
}

class _GeneralChatContentState extends State<GeneralChatContent>
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
        context.read<GeneralChatCubit>().sendMediaMessage(
          mediaType: 'image',
          localFilePath: picked.path,
          mimeType: picked.mimeType ?? _inferMimeType(picked.path),
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
        context.read<GeneralChatCubit>().sendMediaMessage(
          mediaType: 'image',
          localFilePath: picked.path,
          mimeType: picked.mimeType ?? _inferMimeType(picked.path),
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
    final path =
        '${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
    await _audioRecorder.start(
      const RecordConfig(encoder: AudioEncoder.aacLc),
      path: path,
    );
    setState(() {
      _isRecording = true;
      _recordingDuration = Duration.zero;
    });
    _recordingTimer =
        Timer.periodic(const Duration(seconds: 1), (_) {
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
      context.read<GeneralChatCubit>().sendMediaMessage(
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
            color: Colors.blue.withValues(alpha: 0.5),
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
                    if (message.text.isNotEmpty) const SizedBox(height: 8),
                  ],
                  if (message.text.isNotEmpty)
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
            if (!isLoading && !_isRecording)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChatMediaInputBar(
                  onImagePick: _pickImage,
                  onCameraCapture: _captureImage,
                  onVoiceRecord: _toggleRecording,
                  isRecording: _isRecording,
                ),
              ),
            Expanded(
              child: _isRecording
                  ? RecordingIndicator(
                      duration: _recordingDuration,
                      onStop: _stopRecording,
                    )
                  : TextField(
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
            if (!_isRecording) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  if (_textController.text.trim().isNotEmpty && !isLoading) {
                    context
                        .read<GeneralChatCubit>()
                        .sendMessage(_textController.text);
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
