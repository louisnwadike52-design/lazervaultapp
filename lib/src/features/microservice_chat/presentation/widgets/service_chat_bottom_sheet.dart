import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import '../../cubit/microservice_chat_cubit.dart';
import '../../cubit/microservice_chat_state.dart';
import '../../domain/entities/microservice_chat_message_entity.dart';
import '../../domain/usecases/send_microservice_chat_message_usecase.dart';
import '../../domain/usecases/send_direct_chat_message_usecase.dart';
import '../../domain/usecases/load_microservice_chat_history_usecase.dart';
import '../../domain/usecases/load_direct_chat_history_usecase.dart';
import 'chat_media_bubble.dart';
import 'chat_media_input_bar.dart';

/// Shows a scoped chat bottom sheet for a specific service.
///
/// When [isDirect] is true, uses the Go Chat Proxy Gateway (direct to microservice,
/// no intent classification). When false, uses the Python Chat Agent Gateway.
void showServiceChatBottomSheet(
  BuildContext context, {
  required String serviceName,
  required String sourceContext,
  String? agentDescription,
  Color accentColor = const Color(0xFF8B5CF6),
  bool isDirect = true,
}) {
  // Read auth cubit from the widget tree (the actual authenticated instance),
  // NOT from serviceLocator which creates a new unauthenticated factory instance.
  final authCubit = context.read<AuthenticationCubit>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider(
      create: (_) => MicroserviceChatCubit(
        sendMessageUseCase: serviceLocator<SendMicroserviceChatMessageUseCase>(),
        directMessageUseCase: isDirect ? serviceLocator<SendDirectChatMessageUseCase>() : null,
        loadHistoryUseCase: serviceLocator<LoadMicroserviceChatHistoryUseCase>(),
        loadDirectHistoryUseCase: isDirect ? serviceLocator<LoadDirectChatHistoryUseCase>() : null,
        authCubit: authCubit,
        sourceContext: sourceContext,
        isDirect: isDirect,
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

class _ServiceChatBottomSheetState extends State<ServiceChatBottomSheet>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _typingDotsController;
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;
  String? _userAvatarUrl;
  bool _isExpanded = false;

  // Media state
  final ImagePicker _imagePicker = ImagePicker();
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  bool _isPickingMedia = false; // Guard against concurrent picker calls
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
    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _expandController, curve: Curves.easeInOut),
    );
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
    _messageController.dispose();
    _scrollController.dispose();
    _typingDotsController.dispose();
    _expandController.dispose();
    _recordingTimer?.cancel();
    if (_isRecording) {
      _audioRecorder.stop();
    }
    _audioRecorder.dispose();
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
          text: _messageController.text.trim(),
        );
        _messageController.clear();
      }
    } catch (_) {
      // Picker cancelled or permission denied — no action needed
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
          text: _messageController.text.trim(),
        );
        _messageController.clear();
      }
    } catch (_) {
      // Picker cancelled or permission denied
    } finally {
      _isPickingMedia = false;
    }
  }

  String _inferMimeType(String path) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    if (lower.endsWith('.gif')) return 'image/gif';
    return 'image/jpeg';
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      await _stopRecording();
    } else {
      await _startRecording();
    }
  }

  Future<void> _startRecording() async {
    if (_isRecording) return; // Guard against double-start
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
      // Auto-stop at max duration
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

  void _toggleExpand() {
    setState(() => _isExpanded = !_isExpanded);
    if (_isExpanded) {
      _expandController.forward();
    } else {
      _expandController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _expandAnimation,
      builder: (context, child) {
        return Container(
          height: screenHeight * _expandAnimation.value,
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
              Expanded(child: _buildMessageList()),
              _buildInputArea(),
            ],
          ),
        );
      },
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

              // Expand / collapse toggle
              GestureDetector(
                onTap: _toggleExpand,
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isExpanded ? Icons.close_fullscreen : Icons.open_in_full,
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

  Widget _buildUserAvatar() {
    if (_userAvatarUrl != null) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: _userAvatarUrl!,
          width: 32.w,
          height: 32.w,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(
            width: 32.w,
            height: 32.w,
            decoration: const BoxDecoration(
              color: Color(0xFF2D2D2D),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, color: Colors.grey[400], size: 16.sp),
          ),
          errorWidget: (_, __, ___) => Container(
            width: 32.w,
            height: 32.w,
            decoration: const BoxDecoration(
              color: Color(0xFF2D2D2D),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, color: Colors.grey[400], size: 16.sp),
          ),
        ),
      );
    }
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: const BoxDecoration(
        color: Color(0xFF2D2D2D),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.person, color: Colors.grey[400], size: 16.sp),
    );
  }

  Widget _buildMessageBubble(MicroserviceChatMessageEntity message) {
    final isUser = message.isUser;
    final maxBubbleWidth = MediaQuery.of(context).size.width * 0.72;

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
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxBubbleWidth),
                  child: Container(
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
                          SizedBox(height: 8.h),
                      ],
                      if (message.mediaType == null ||
                          (message.text.isNotEmpty &&
                              message.text != 'Sent an image' &&
                              message.text != 'Sent a voice note'))
                        isUser
                            ? Text(
                                message.text,
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  height: 1.4,
                                ),
                              )
                            : MarkdownBody(
                          data: message.text,
                          selectable: true,
                          styleSheet:
                              MarkdownStyleSheet.fromTheme(Theme.of(context))
                                  .copyWith(
                            p: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: Colors.white,
                              height: 1.45,
                            ),
                            strong: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            em: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: Colors.white.withValues(alpha: 0.85),
                              fontStyle: FontStyle.italic,
                            ),
                            listBullet: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: const Color(0xFF9CA3AF),
                              height: 1.45,
                            ),
                            listBulletPadding: EdgeInsets.only(right: 6.w),
                            listIndent: 16.w,
                            blockSpacing: 6.0,
                            code: GoogleFonts.robotoMono(
                              fontSize: 13.sp,
                              color: const Color(0xFF86EFAC),
                              backgroundColor:
                                  Colors.black.withValues(alpha: 0.3),
                            ),
                            a: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: const Color(0xFF60A5FA),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                    ],
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
            _buildUserAvatar(),
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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
                bottomLeft: Radius.circular(4.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _typingDotsController,
                  builder: (context, child) {
                    final double phase =
                        (_typingDotsController.value + index / 3) % 1.0;
                    final double bounce = (phase < 0.5)
                        ? (phase * 2)
                        : (2 - phase * 2);
                    return Transform.translate(
                      offset: Offset(0, -bounce * 6),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: widget.accentColor
                              .withValues(alpha: 0.4 + bounce * 0.6),
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

  Widget _buildInputArea() {
    return BlocBuilder<MicroserviceChatCubit, MicroserviceChatState>(
      builder: (context, state) {
        final isLoading = state is MicroserviceChatMessageLoading;

        if (_isRecording) {
          return Container(
            padding: EdgeInsets.all(20.w),
            decoration: const BoxDecoration(
              color: Color(0xFF1F1F1F),
              border: Border(top: BorderSide(color: Color(0xFF2D2D2D), width: 1)),
            ),
            child: SafeArea(
              child: RecordingIndicator(
                duration: _recordingDuration,
                onStop: _stopRecording,
              ),
            ),
          );
        }

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
                if (!isLoading)
                  ChatMediaInputBar(
                    onImagePick: _pickImage,
                    onCameraCapture: _captureImage,
                    onVoiceRecord: _toggleRecording,
                    isRecording: _isRecording,
                  ),
                if (!isLoading) SizedBox(width: 8.w),
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
