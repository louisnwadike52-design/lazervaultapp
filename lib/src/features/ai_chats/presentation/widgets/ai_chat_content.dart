import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:lazervault/core/services/chat_language_preference.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/utils/pin_mask_utils.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_media_bubble.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_voice_note_player.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_pin_prompt_card.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_receipt_card.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_receipt_card_v2.dart';
import '../../cubit/ai_chat_cubit.dart';
import '../../cubit/ai_chat_state.dart';
import '../../domain/entities/ai_chat_message_entity.dart';

/// Local model for AI chat settings, persisted via SharedPreferences.
class AiChatSettings {
  String responseStyle; // concise, balanced, detailed, professional
  String textSize; // small, medium, large
  bool showTimestamps;
  bool emojiUsage;
  bool quickSuggestions;

  AiChatSettings({
    this.responseStyle = 'balanced',
    this.textSize = 'medium',
    this.showTimestamps = true,
    this.emojiUsage = true,
    this.quickSuggestions = true,
  });

  double get fontSizeMultiplier => switch (textSize) {
    'small' => 0.85,
    'large' => 1.18,
    _ => 1.0,
  };

  static const _prefix = 'ai_chat_settings_';

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('${_prefix}response_style', responseStyle);
    await prefs.setString('${_prefix}text_size', textSize);
    await prefs.setBool('${_prefix}show_timestamps', showTimestamps);
    await prefs.setBool('${_prefix}emoji_usage', emojiUsage);
    await prefs.setBool('${_prefix}quick_suggestions', quickSuggestions);
  }

  static Future<AiChatSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    return AiChatSettings(
      responseStyle: prefs.getString('${_prefix}response_style') ?? 'balanced',
      textSize: prefs.getString('${_prefix}text_size') ?? 'medium',
      showTimestamps: prefs.getBool('${_prefix}show_timestamps') ?? true,
      emojiUsage: prefs.getBool('${_prefix}emoji_usage') ?? true,
      quickSuggestions: prefs.getBool('${_prefix}quick_suggestions') ?? true,
    );
  }
}

// Local UI ChatMessage model wrapping the domain entity
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final ChatMessageType type;
  final List<ActionButtonEntity>? actionButtons;
  final ConfirmationDataEntity? confirmationData;
  final String? mediaType;
  final String? mediaUrl;
  final String? localMediaPath;
  final int? audioDurationMs;
  final String? transcript;
  final Map<String, dynamic>? receiptData;
  // ReceiptCard V2 payload — single dict OR a list (batch transfer).
  final dynamic receiptCard;
  final Map<String, dynamic>? pinPrompt;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.type = ChatMessageType.text,
    this.actionButtons,
    this.confirmationData,
    this.mediaType,
    this.mediaUrl,
    this.localMediaPath,
    this.audioDurationMs,
    this.transcript,
    this.receiptData,
    this.receiptCard,
    this.pinPrompt,
  });

  factory ChatMessage.fromEntity(ChatMessageEntity entity) {
    return ChatMessage(
      text: entity.text,
      isUser: entity.isUser,
      timestamp: entity.timestamp,
      type: entity.type,
      actionButtons: entity.actionButtons,
      confirmationData: entity.confirmationData,
      mediaType: entity.mediaType,
      mediaUrl: entity.mediaUrl,
      localMediaPath: entity.localMediaPath,
      audioDurationMs: entity.audioDurationMs,
      transcript: entity.transcript,
      receiptData: entity.receiptData,
      receiptCard: entity.receiptCard,
      pinPrompt: entity.pinPrompt,
    );
  }
}

/// Custom painter for iMessage-style bubble tail protrusion.
class BubbleTailPainter extends CustomPainter {
  final Color color;
  final bool isUser;

  BubbleTailPainter({required this.color, required this.isUser});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    if (isUser) {
      // Right-side tail curving outward and back
      path.moveTo(0, 0);
      path.lineTo(size.width * 0.35, 0);
      path.quadraticBezierTo(
        size.width, size.height * 0.05,
        size.width * 0.75, size.height,
      );
      path.quadraticBezierTo(
        size.width * 0.12, size.height * 0.85,
        0, 0,
      );
    } else {
      // Left-side tail (mirrored)
      path.moveTo(size.width, 0);
      path.lineTo(size.width * 0.65, 0);
      path.quadraticBezierTo(
        0, size.height * 0.05,
        size.width * 0.25, size.height,
      );
      path.quadraticBezierTo(
        size.width * 0.88, size.height * 0.85,
        size.width, 0,
      );
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant BubbleTailPainter oldDelegate) =>
      color != oldDelegate.color || isUser != oldDelegate.isUser;
}

class AiChatContent extends StatefulWidget {
  /// The dashboard's active bottom-nav index. When it becomes [chatTabIndex]
  /// (the chatbot tab is opened), the conversation scrolls to the bottom — the
  /// TabBarView keeps this page alive, so initState fires only once and would
  /// not otherwise re-scroll when the user returns to the tab.
  final ValueListenable<int>? activeTab;

  /// The bottom-nav index this chat occupies (AI Chat == 2 on the dashboard).
  final int chatTabIndex;

  const AiChatContent({super.key, this.activeTab, this.chatTabIndex = 2});

  @override
  State<AiChatContent> createState() => _AiChatContentState();
}

class _AiChatContentState extends State<AiChatContent> with TickerProviderStateMixin {
  // --- State variables ---
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isAttaching = false; // Kept for local UI state during image preview
  bool _isPinMode = false; // Hides chat history when entering a PIN
  // Re-entrancy guard for _handleSubmitted. Without this, a rapid double-tap
  // on a suggestion pill or send button fires two simultaneous /chat POSTs
  // (same session, same message) — the user sees the message echoed twice
  // and the LLM responds twice. The guard releases on the next tick after
  // the cubit's sendMessage call is dispatched (the cubit owns the typing
  // state from there) so the user can immediately type a follow-up.
  bool _isSubmitting = false;
  late AnimationController _typingDotsController;
  AiChatSettings _settings = AiChatSettings();
  // Selected chatbot response language code (en/yo/ig/ha/pcm/fr/es). The AI
  // replies in this language, and also auto-detects the language of each
  // message on the backend.
  String _chatLanguage = ChatLanguagePreference.defaultLanguage;

  // Transaction IDs whose PIN bottom sheet has already been AUTO-opened.
  // Ensures each chat-driven money-move auto-opens its PIN sheet at most once,
  // never re-opening on widget rebuild or after the user dismisses it. The
  // durable in-chat ChatPinPromptCard still re-opens on manual tap regardless.
  final Set<String> _autoOpenedPinPrompts = <String>{};

  // Media state
  final ImagePicker _imagePicker = ImagePicker();
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  bool _isPickingMedia = false;
  Duration _recordingDuration = Duration.zero;
  Timer? _recordingTimer;
  static const _maxRecordingDuration = Duration(minutes: 5);
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

    _loadSettings();

    // Scroll to the bottom each time the chatbot tab is opened (the page is
    // kept alive by TabBarView, so this is the only signal that it became
    // visible again after the first build).
    widget.activeTab?.addListener(_onActiveTabChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _loadHistory();
      }
    });
  }

  /// Fired when the dashboard's active tab changes. When this chat becomes the
  /// visible tab, settle the conversation at the bottom.
  void _onActiveTabChanged() {
    if (widget.activeTab?.value == widget.chatTabIndex) {
      _scrollChatToBottom();
    } else {
      // Left the chat tab (bottom-nav) — stop any playing voice note. While the
      // user stays on the chat tab it keeps playing even as the list scrolls.
      ChatVoiceNotePlayer.instance.stop();
    }
  }

  /// Pin the conversation to the very bottom on load / tab-open. Unlike a single
  /// jump, this re-jumps a few times over ~0.6s so the list lands at the TRUE
  /// bottom even as async media (chat images) finish laying out and grow the
  /// scroll extent after the first frame.
  void _scrollChatToBottom() {
    for (final ms in const [0, 120, 300, 600]) {
      Future.delayed(Duration(milliseconds: ms), () {
        if (!mounted || !_scrollController.hasClients) return;
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    }
  }

  Future<void> _loadSettings() async {
    final settings = await AiChatSettings.load();
    final language = await ChatLanguagePreference.getLanguage();
    if (mounted) {
      setState(() {
        _settings = settings;
        _chatLanguage = language;
      });
    }
  }

  Future<void> _loadHistory() async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      context.read<AIChatCubit>().loadChatHistory(accessToken: authState.profile.session.accessToken);
    }
  }

  /// Auto-open the PIN bottom sheet for the latest assistant message that
  /// carries a pin_prompt, once per transaction_id. Only ever called from the
  /// AIChatMessageSuccess branch of the listener (live turn), so historical
  /// prompts replayed by loadChatHistory never trigger it. The sheet is the
  /// SAME native modal the in-chat card opens — we just drive that card's
  /// state via its stable GlobalKey, so there is one verification code path.
  void _maybeAutoOpenPinPrompt(List<ChatMessageEntity> messages) {
    // Find the most recent assistant message with a pin_prompt. Iterate from
    // the end so we only consider the newest prompt of this turn.
    ChatMessageEntity? latest;
    for (var i = messages.length - 1; i >= 0; i--) {
      final m = messages[i];
      if (!m.isUser && m.pinPrompt != null) {
        latest = m;
        break;
      }
    }
    if (latest == null) return;

    final txId = latest.pinPrompt!['transaction_id']?.toString() ?? '';
    if (txId.isEmpty) return;
    if (_autoOpenedPinPrompts.contains(txId)) return;

    // Mark consumed BEFORE the async open so a same-frame rebuild can't
    // double-fire. Manual re-tap on the card is unaffected (it doesn't read
    // this set) — only the auto-open is one-shot.
    _autoOpenedPinPrompts.add(txId);

    // Defer to after this frame so the ChatPinPromptCard (and its GlobalKey)
    // is actually mounted in the rebuilt list before we drive its modal.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ChatPinPromptCard.autoOpenFor(txId);
    });
  }

  @override
  void dispose() {
    widget.activeTab?.removeListener(_onActiveTabChanged);
    // Leaving the chat page entirely — stop any playing voice note.
    ChatVoiceNotePlayer.instance.stop();
    _messageController.dispose();
    _scrollController.dispose();
    _typingDotsController.dispose();
    _recordingTimer?.cancel();
    if (_isRecording) {
      _audioRecorder.stop();
    }
    _audioRecorder.dispose();
    super.dispose();
  }

  // --- Methods --- 

  // REMOVED - Initial suggestions shown based on state.messages in builder
  // void _showInitialSuggestions() { ... }

  void _scrollToBottom({bool isDelayed = false, bool animate = true}) {
    Future.delayed(Duration(milliseconds: isDelayed ? 150 : 0), () {
      if (_scrollController.hasClients) {
        if (animate) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        } else {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      }
    });
  }

  Future<void> _handleSubmitted(String text, {File? image}) async {
    final messageText = text.trim();
    if (messageText.isEmpty && image == null) return;

    // Drop duplicate taps within the same frame (pill double-tap, accidental
    // tap-then-Enter, framework re-fires on hot-reload). Re-armed on the
    // next microtask so legitimate back-to-back sends still work.
    if (_isSubmitting) return;
    _isSubmitting = true;
    scheduleMicrotask(() => _isSubmitting = false);

    _messageController.clear();
    if (_isPinMode) {
      setState(() => _isPinMode = false);
    }
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

  String _inferMimeType(String path) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    if (lower.endsWith('.gif')) return 'image/gif';
    return 'image/jpeg';
  }

  Future<void> _handleImagePicker() async {
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
        await _showImageCaptionComposer(picked);
      }
    } catch (_) {
      // Picker cancelled or permission denied
    } finally {
      _isPickingMedia = false;
    }
  }

  Future<void> _handleCameraCapture() async {
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
        await _showImageCaptionComposer(picked);
      }
    } catch (_) {
      // Picker cancelled or permission denied
    } finally {
      _isPickingMedia = false;
    }
  }

  /// Show a preview of the picked image with an editable caption field and a
  /// Send button. The typed caption travels with the image via
  /// [AIChatCubit.sendMediaMessage]'s `text` arg (the backend extracts + routes
  /// any transfer intent from it). An empty caption is allowed.
  Future<void> _showImageCaptionComposer(XFile picked) async {
    final captionController = TextEditingController(
      text: _messageController.text.trim(),
    );
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Padding(
          // Lift above the keyboard.
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: InvoiceThemeColors.primaryBackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              border: Border.all(color: InvoiceThemeColors.borderColor),
            ),
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 14.h),
                  decoration: BoxDecoration(
                    color: InvoiceThemeColors.borderColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 260.h),
                    child: Image.file(
                      File(picked.path),
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Container(
                        height: 160.h,
                        color: InvoiceThemeColors.secondaryBackground,
                        child: Icon(Icons.broken_image_outlined,
                            color: const Color(0xFF9CA3AF), size: 40.sp),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: InvoiceThemeColors.secondaryBackground,
                          borderRadius: BorderRadius.circular(24.r),
                          border:
                              Border.all(color: InvoiceThemeColors.borderColor),
                        ),
                        child: TextField(
                          controller: captionController,
                          autofocus: true,
                          style: const TextStyle(color: Colors.white),
                          minLines: 1,
                          maxLines: 4,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) =>
                              _sendImageWithCaption(picked, captionController),
                          decoration: InputDecoration(
                            hintText: 'Add a caption...',
                            hintStyle: TextStyle(
                                color: Colors.white.withValues(alpha: 0.5)),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () =>
                          _sendImageWithCaption(picked, captionController),
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            InvoiceThemeColors.primaryPurple,
                            InvoiceThemeColors.gradientPurple,
                          ]),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.send_rounded,
                            color: Colors.white, size: 20.sp),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    captionController.dispose();
  }

  void _sendImageWithCaption(
    XFile picked,
    TextEditingController captionController,
  ) {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      Get.snackbar('Error', 'User not authenticated. Please log in.');
      return;
    }
    final caption = captionController.text.trim();
    context.read<AIChatCubit>().sendMediaMessage(
          mediaType: 'image',
          localFilePath: picked.path,
          mimeType: picked.mimeType ?? _inferMimeType(picked.path),
          accessToken: authState.profile.session.accessToken,
          text: caption, // empty caption is allowed
        );
    // Clear the main composer (its text was prefilled into the caption field).
    _messageController.clear();
    Navigator.of(context).pop(); // close the composer sheet
    _scrollToBottom(isDelayed: true);
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
      final authState = context.read<AuthenticationCubit>().state;
      if (authState is! AuthenticationSuccess) return;
      context.read<AIChatCubit>().sendMediaMessage(
        mediaType: 'voice',
        localFilePath: path,
        mimeType: 'audio/mp4',
        accessToken: authState.profile.session.accessToken,
        audioDurationMs: durationMs,
      );
      _scrollToBottom(isDelayed: true);
    }
  }

  void _showOptionsSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: InvoiceThemeColors.secondaryBackground,
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
              InvoiceThemeColors.errorRed,
              () {
                Get.back();
                _showClearChatConfirmation();
              },
            ),
            _buildOptionTile(
              'Export Chat',
              Icons.download_rounded,
              InvoiceThemeColors.primaryPurple,
              () {
                Get.back();
                _exportChat();
              },
            ),
            _buildOptionTile(
              'AI Settings',
              Icons.tune_rounded,
              InvoiceThemeColors.primaryPurple,
              () {
                Get.back();
                _showAiSettingsModal();
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  void _showClearChatConfirmation() {
    Get.dialog(
      AlertDialog(
        backgroundColor: InvoiceThemeColors.secondaryBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Clear Chat', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600)),
        content: Text(
          'This will clear your entire conversation history. This action cannot be undone.',
          style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: TextStyle(color: Colors.white70, fontSize: 14.sp)),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              context.read<AIChatCubit>().clearChat();
              Get.snackbar('Done', 'Chat cleared', snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFF1F1F1F), colorText: Colors.white);
            },
            child: Text('Clear', style: TextStyle(color: Colors.red, fontSize: 14.sp, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Future<void> _exportChat() async {
    final state = context.read<AIChatCubit>().state;
    final messages = state.messages;
    if (messages.isEmpty) {
      Get.snackbar('Info', 'No messages to export', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final buffer = StringBuffer();
    buffer.writeln('Lazervault AI Chat Export');
    buffer.writeln('Exported on: ${DateTime.now().toString().split('.').first}');
    buffer.writeln('${'─' * 40}\n');

    for (final msg in messages) {
      final sender = msg.isUser ? 'You' : 'NOVA';
      final time = '${msg.timestamp.hour}:${msg.timestamp.minute.toString().padLeft(2, '0')}';
      buffer.writeln('[$time] $sender:');
      buffer.writeln(msg.text);
      buffer.writeln();
    }

    try {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/lazervault_chat_export.txt');
      await file.writeAsString(buffer.toString());
      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        title: 'Lazervault Chat Export',
      ));
    } catch (e) {
      Get.snackbar('Error', 'Failed to export chat', snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _showAiSettingsModal() {
    // Use a StatefulBuilder inside the modal to enable local state updates
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return Container(
              height: 0.72.sh,
              decoration: BoxDecoration(
                color: InvoiceThemeColors.primaryBackground,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: Column(
                children: [
                  // Handle bar
                  Container(
                    width: 40.w, height: 4.h,
                    margin: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  // Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Icon(Icons.tune_rounded, color: InvoiceThemeColors.primaryPurple, size: 22.sp),
                        SizedBox(width: 10.w),
                        Text('AI Settings', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.of(ctx).pop(),
                          child: Icon(Icons.close_rounded, color: Colors.white54, size: 22.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),
                  // Settings body
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                      children: [
                        // --- Language ---
                        _settingsLabel('Language'),
                        SizedBox(height: 8.h),
                        Text(
                          'The assistant replies in this language and also '
                          'auto-detects the language you type in.',
                          style: TextStyle(color: Colors.white38, fontSize: 11.sp),
                        ),
                        SizedBox(height: 8.h),
                        _buildChipGroup(
                          options:
                              ChatLanguagePreference.supportedLanguages.keys.toList(),
                          labels: ChatLanguagePreference.supportedLanguages.values
                              .toList(),
                          icons: List.filled(
                            ChatLanguagePreference.supportedLanguages.length,
                            Icons.translate_rounded,
                          ),
                          selected: _chatLanguage,
                          onSelected: (v) {
                            setModalState(() => _chatLanguage = v);
                            setState(() => _chatLanguage = v);
                          },
                        ),
                        SizedBox(height: 20.h),

                        // --- Response Style ---
                        _settingsLabel('Response Style'),
                        SizedBox(height: 8.h),
                        _buildChipGroup(
                          options: const ['concise', 'balanced', 'detailed', 'professional'],
                          labels: const ['Concise', 'Balanced', 'Detailed', 'Professional'],
                          icons: const [Icons.short_text_rounded, Icons.balance_rounded, Icons.article_rounded, Icons.business_center_rounded],
                          selected: _settings.responseStyle,
                          onSelected: (v) {
                            setModalState(() => _settings.responseStyle = v);
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 20.h),

                        // --- Text Size ---
                        _settingsLabel('Text Size'),
                        SizedBox(height: 8.h),
                        _buildChipGroup(
                          options: const ['small', 'medium', 'large'],
                          labels: const ['Small', 'Medium', 'Large'],
                          icons: const [Icons.text_fields_rounded, Icons.format_size_rounded, Icons.title_rounded],
                          selected: _settings.textSize,
                          onSelected: (v) {
                            setModalState(() => _settings.textSize = v);
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 6.h),
                        // Preview text
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.04),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            'Preview: Your balance is NGN 45,200.00',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14.sp * _settings.fontSizeMultiplier,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // --- Toggles ---
                        _settingsLabel('Display Options'),
                        SizedBox(height: 8.h),
                        _buildSettingsToggle(
                          'Show Timestamps',
                          'Display time under each message',
                          Icons.access_time_rounded,
                          _settings.showTimestamps,
                          (v) {
                            setModalState(() => _settings.showTimestamps = v);
                            setState(() {});
                          },
                        ),
                        _buildSettingsToggle(
                          'Emoji in Responses',
                          'Allow AI to use emojis',
                          Icons.emoji_emotions_rounded,
                          _settings.emojiUsage,
                          (v) {
                            setModalState(() => _settings.emojiUsage = v);
                            setState(() {});
                          },
                        ),
                        _buildSettingsToggle(
                          'Quick Suggestions',
                          'Show suggestion chips at the bottom',
                          Icons.lightbulb_outline_rounded,
                          _settings.quickSuggestions,
                          (v) {
                            setModalState(() => _settings.quickSuggestions = v);
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                  // Save button
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final cubit = context.read<AIChatCubit>();
                          await _settings.save();
                          // Persist + apply the selected chatbot language so the
                          // next message instructs the backend to reply in it.
                          await cubit.setLanguage(_chatLanguage);
                          // Sync to backend
                          cubit.updateSettings(
                            responseStyle: _settings.responseStyle,
                            emojiUsage: _settings.emojiUsage,
                          );
                          if (ctx.mounted) Navigator.of(ctx).pop();
                          Get.snackbar('Saved', 'AI settings updated',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: const Color(0xFF1F1F1F),
                            colorText: Colors.white,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: InvoiceThemeColors.primaryPurple,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        ),
                        child: Text('Save Settings', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _settingsLabel(String text) {
    return Text(
      text,
      style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp, fontWeight: FontWeight.w500, letterSpacing: 0.5),
    );
  }

  Widget _buildChipGroup({
    required List<String> options,
    required List<String> labels,
    required List<IconData> icons,
    required String selected,
    required ValueChanged<String> onSelected,
  }) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: List.generate(options.length, (i) {
        final isActive = selected == options[i];
        return GestureDetector(
          onTap: () => onSelected(options[i]),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isActive ? InvoiceThemeColors.primaryPurple.withValues(alpha: 0.15) : Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isActive ? InvoiceThemeColors.primaryPurple : Colors.white.withValues(alpha: 0.1),
                width: isActive ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icons[i], size: 16.sp, color: isActive ? InvoiceThemeColors.primaryPurple : Colors.white54),
                SizedBox(width: 6.w),
                Text(
                  labels[i],
                  style: TextStyle(
                    color: isActive ? InvoiceThemeColors.primaryPurple : Colors.white70,
                    fontSize: 13.sp,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSettingsToggle(String title, String subtitle, IconData icon, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: Colors.white54, size: 20.sp),
        ),
        title: Text(title, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
        subtitle: Text(subtitle, style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 11.sp)),
        trailing: Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeTrackColor: InvoiceThemeColors.primaryPurple,
          activeThumbColor: Colors.white,
          inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
        ),
      ),
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
    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                InvoiceThemeColors.primaryPurple.withValues(alpha: 0.15),
                InvoiceThemeColors.gradientPurple.withValues(alpha: 0.08),
                InvoiceThemeColors.primaryBackground,
              ],
            ),
          ),
        ),
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
                  'NOVA',
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
      ),
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
            color: isTyping ? InvoiceThemeColors.primaryPurple : InvoiceThemeColors.successGreen,
            shape: BoxShape.circle,
          ),
        ),
        Text(
          isTyping ? 'Typing...' : 'Online',
          style: TextStyle(color: isTyping ? InvoiceThemeColors.primaryPurple : InvoiceThemeColors.successGreen, fontSize: 12.sp),
        ),
      ],
    );
  }

  Widget _buildChatHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            InvoiceThemeColors.primaryPurple.withValues(alpha: 0.08),
            Colors.transparent,
          ],
        ),
        border: Border(bottom: BorderSide(color: InvoiceThemeColors.borderColor)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, color: InvoiceThemeColors.gradientPurple, size: 18.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Ask me anything — transfers, bills, investments & more',
              style: TextStyle(color: InvoiceThemeColors.textGray400, fontSize: 12.sp),
            ),
          ),
        ],
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

  // Updated to accept the list of messages
  Widget _buildMessagesList(List<ChatMessageEntity> messageEntities) {
     // Map entities to UI models
     final messages = messageEntities.map((entity) => ChatMessage.fromEntity(entity)).toList();

     // Add initial bot message if the list is empty
     if (messages.isEmpty) {
        messages.add(ChatMessage(
          text: "Hello! I'm NOVA, your financial assistant. How can I help you today?",
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

  // Bubble colors — matching sendfunds chatbot theme
  static final _userBubbleColor = InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2);
  static const _aiBubbleColor = InvoiceThemeColors.secondaryBackground;

  /// Whether to render a message's text bubble. Voice notes carry a "Sent a
  /// voice note" placeholder as their text, which is redundant next to the
  /// player — suppress it (their real transcript still shows inside the player).
  bool _showMessageText(ChatMessage message) =>
      message.text.isNotEmpty && message.mediaType != 'voice';

  Widget _buildMessageBubble(ChatMessage message) {
    final bool isUser = message.isUser;

    // Render rich message types for AI responses
    if (!isUser && message.type == ChatMessageType.confirmation && message.confirmationData != null) {
      return _buildConfirmationCard(message);
    }
    if (!isUser && message.type == ChatMessageType.actionCard && message.actionButtons != null) {
      return _buildActionCard(message);
    }

    final bubbleColor = isUser ? _userBubbleColor : _aiBubbleColor;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 16.h,
          left: isUser ? 64.w : 12.w,
          right: isUser ? 12.w : 64.w,
        ),
        child: Column(
          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
              // Voice notes need no caption — the player already reads as a voice
              // note, so skip the "Sent a voice note" placeholder text. Images
              // keep their caption.
              if (_showMessageText(message)) SizedBox(height: 4.h),
            ],
            if (_showMessageText(message))
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: bubbleColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.r),
                        topRight: Radius.circular(18.r),
                        bottomLeft: Radius.circular(isUser ? 18.r : 4.r),
                        bottomRight: Radius.circular(isUser ? 4.r : 18.r),
                      ),
                      border: isUser
                          ? null
                          : Border.all(color: InvoiceThemeColors.borderColor, width: 0.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MarkdownBody(
                          data: isUser ? maskIfPin(message.text) : message.text,
                          selectable: !isUser || !isPinText(message.text),
                          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                            p: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontSize: 14.sp * _settings.fontSizeMultiplier,
                              height: 1.45,
                            ),
                            strong: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontSize: 14.sp * _settings.fontSizeMultiplier,
                              fontWeight: FontWeight.w700,
                            ),
                            em: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 14.sp * _settings.fontSizeMultiplier,
                              fontStyle: FontStyle.italic,
                            ),
                            code: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontFamily: 'monospace',
                              backgroundColor: Colors.black.withValues(alpha: 0.2),
                              color: isUser ? const Color(0xFFD8B4FE) : const Color(0xFFD8B4FE),
                              fontSize: 13.sp * _settings.fontSizeMultiplier,
                            ),
                            listBullet: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isUser ? const Color(0xFFD8B4FE) : const Color(0xFFD8B4FE),
                              fontSize: 14.sp * _settings.fontSizeMultiplier,
                              height: 1.45,
                            ),
                            listBulletPadding: EdgeInsets.only(right: 6.w),
                            listIndent: 16.w,
                            blockSpacing: 6.0,
                          ),
                        ),
                        if (_settings.showTimestamps) ...[
                          SizedBox(height: 4.h),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              _formatTime(message.timestamp),
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.55),
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // iMessage-style tail protrusion
                  Positioned(
                    bottom: 0,
                    right: isUser ? -7.w : null,
                    left: isUser ? null : -7.w,
                    child: CustomPaint(
                      painter: BubbleTailPainter(color: bubbleColor, isUser: isUser),
                      size: Size(10.w, 12.h),
                    ),
                  ),
                ],
              ),
            // Receipt card — displayed immediately after the message bubble
            if (!isUser && message.receiptData != null)
              ChatReceiptCard(
                receipt: TransferReceiptData.fromJson(message.receiptData!),
              )
            // V2 receipt card(s) — single (ChatReceiptCardV2) or a list for a
            // batch transfer (ChatReceiptCardV2List). Mirrors the general chat's
            // _buildReceiptCardV2 so batch receipts render here too. Rendered
            // ONLY when there's no receiptData: a successful transfer surfaces
            // both payloads, but the self-contained ChatReceiptCard above is the
            // single card we show — the V2 card is a fallback for flows that
            // emit only receipt_card (e.g. batch transfers).
            else if (!isUser && message.receiptCard != null)
              _buildReceiptCardV2(message.receiptCard),
            // PIN prompt card — chat-driven money moves collect the PIN inline.
            // "Enter PIN" opens the native modal; on success the single-use
            // token round-trips to the agent (submitPinVerification) and the
            // transaction continues in this same conversation.
            if (!isUser && message.pinPrompt != null)
              ChatPinPromptCard(
                // Stable key per transaction_id so the auto-open listener can
                // drive THIS card's modal — keeps one code path into the PIN
                // sheet shared by the manual tap and the auto-open.
                key: ChatPinPromptCard.keyFor(
                  message.pinPrompt!['transaction_id']?.toString() ?? '',
                ),
                payload: message.pinPrompt!,
                onPinVerified: (verificationToken) async {
                  final payload = message.pinPrompt!;
                  final callbackArgsRaw = payload['callback_args'];
                  await context.read<AIChatCubit>().submitPinVerification(
                        verificationToken: verificationToken,
                        callbackIntent:
                            payload['callback_intent']?.toString() ?? '',
                        callbackArgs: callbackArgsRaw is Map
                            ? Map<String, dynamic>.from(callbackArgsRaw)
                            : const {},
                      );
                },
              ),
          ],
        ),
      ),
    );
  }

  /// Render the generic ReceiptCard V2 payload (single dict or list). Mirrors
  /// general_chat_content._buildReceiptCardV2 so batch receipts render in the
  /// per-service chat too. See chat_services_shared/receipt_protocol.py.
  Widget _buildReceiptCardV2(dynamic payload) {
    if (payload is List) {
      return ChatReceiptCardV2List(payloads: payload);
    }
    if (payload is Map) {
      return ChatReceiptCardV2(payload: Map<String, dynamic>.from(payload));
    }
    return const SizedBox.shrink();
  }

  Widget _buildConfirmationCard(ChatMessage message) {
    final cd = message.confirmationData!;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h, left: 12.w, right: 32.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: _aiBubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.r),
            topRight: Radius.circular(18.r),
            bottomLeft: Radius.circular(4.r),
            bottomRight: Radius.circular(18.r),
          ),
          border: Border.all(color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.25)),
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
                        color: InvoiceThemeColors.primaryPurple,
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
            if (_settings.showTimestamps) ...[
              SizedBox(height: 4.h),
              Text(_formatTime(message.timestamp), style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 10.sp)),
            ],
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
        margin: EdgeInsets.only(bottom: 16.h, left: 12.w, right: 32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.text.isNotEmpty)
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: _aiBubbleColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.r),
                    topRight: Radius.circular(18.r),
                    bottomLeft: Radius.circular(4.r),
                    bottomRight: Radius.circular(18.r),
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
                        color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.35)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (btn.icon != null && btn.icon!.isNotEmpty) ...[
                            Icon(Icons.arrow_forward_rounded, color: InvoiceThemeColors.primaryPurple, size: 14.sp),
                            SizedBox(width: 4.w),
                          ],
                          Text(btn.label, style: TextStyle(color: InvoiceThemeColors.primaryPurple, fontSize: 12.sp, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_settings.showTimestamps) ...[
              SizedBox(height: 4.h),
              Text(_formatTime(message.timestamp), style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 10.sp)),
            ],
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
              color: _aiBubbleColor.withValues(alpha: 0.6),
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
                      decoration: BoxDecoration(color: InvoiceThemeColors.primaryPurple.withValues(alpha: opacity), shape: BoxShape.circle),
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
        color: InvoiceThemeColors.primaryBackground,
        border: Border(top: BorderSide(color: InvoiceThemeColors.borderColor)),
      ),
      child: Column(
        children: [
          // Show suggestions if enabled and message list is effectively empty or text field empty
          if (_settings.quickSuggestions && (messages.isEmpty || _messageController.text.isEmpty))
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
                        color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.3)),
                      ),
                      child: Text(suggestionText, style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                    ),
                  );
                },
              ),
            ),
          if (_isRecording)
            _buildRecordingIndicator()
          else
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
      onTap: _showImageSourceSheet,
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), shape: BoxShape.circle),
        child: Icon(Icons.add_photo_alternate_rounded, color: Colors.white.withValues(alpha: 0.7), size: 20.sp),
      ),
    );
  }

  /// Themed bottom sheet for picking an image source (gallery vs camera).
  /// Replaces the cramped popup menu so the affordance matches the rest of the
  /// app (P2P + service chats) and is reliably tappable.
  void _showImageSourceSheet() {
    FocusScope.of(context).unfocus();
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => Container(
        decoration: BoxDecoration(
          color: InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.w, bottom: 10.h),
                    child: Text(
                      'Add a photo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                _buildImageSourceTile(
                  icon: Icons.photo_library_rounded,
                  iconColor: InvoiceThemeColors.primaryPurple,
                  label: 'Choose from Gallery',
                  subtitle: 'Pick an existing photo',
                  onTap: () {
                    Navigator.of(sheetCtx).pop();
                    _handleImagePicker();
                  },
                ),
                SizedBox(height: 10.h),
                _buildImageSourceTile(
                  icon: Icons.camera_alt_rounded,
                  iconColor: const Color(0xFF10B981),
                  label: 'Take a Photo',
                  subtitle: 'Use your camera',
                  onTap: () {
                    Navigator.of(sheetCtx).pop();
                    _handleCameraCapture();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSourceTile({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: iconColor, size: 22.sp),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: Colors.white.withValues(alpha: 0.3), size: 22.sp),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMicButton() {
    return GestureDetector(
      onTap: _toggleRecording,
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: _isRecording ? Colors.red.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          _isRecording ? Icons.stop : Icons.mic,
          color: _isRecording ? Colors.red : Colors.white.withValues(alpha: 0.7),
          size: 20.sp,
        ),
      ),
    );
  }

  Widget _buildRecordingIndicator() {
    final minutes = _recordingDuration.inMinutes.toString().padLeft(2, '0');
    final seconds = (_recordingDuration.inSeconds % 60).toString().padLeft(2, '0');
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          '$minutes:$seconds',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            _recordingTimer?.cancel();
            _recordingTimer = null;
            _audioRecorder.stop();
            setState(() {
              _isRecording = false;
              _recordingDuration = Duration.zero;
            });
          },
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.delete_outline, color: Colors.red[300], size: 20.sp),
          ),
        ),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: _stopRecording,
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: InvoiceThemeColors.primaryPurple,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.send_rounded, color: Colors.white, size: 20.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField() {
    return Container(
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
        onSubmitted: (text) {
          _handleSubmitted(text);
        },
        onChanged: (text) {
          final trimmed = text.trim();
          final looksLikePin = RegExp(r'^\d{4,6}$').hasMatch(trimmed);
          if (looksLikePin != _isPinMode) {
            setState(() => _isPinMode = looksLikePin);
          } else {
            setState(() {}); // Update Send button state
          }
        },
        decoration: InputDecoration(
          hintText: _isPinMode ? 'Enter your PIN...' : 'Type a message...',
          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
          border: InputBorder.none,
        ),
        maxLines: _isPinMode ? 1 : null,
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
          gradient: isEnabled
              ? LinearGradient(colors: [InvoiceThemeColors.primaryPurple, InvoiceThemeColors.gradientPurple])
              : null,
          color: isEnabled ? null : Colors.grey,
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

        // Scroll to bottom: instant settle on history load (staggered so it
        // reaches the true bottom as media expands the list), animated for new messages
        if (state is AIChatHistorySuccess) {
          _scrollChatToBottom();
        } else if (state is AIChatMessageSuccess || state is AIChatMessageLoading) {
          _scrollToBottom(isDelayed: true);
        }

        // Auto-open the transaction-PIN bottom sheet the moment a live turn
        // (AIChatMessageSuccess — NOT history load) yields an assistant
        // message carrying a pin_prompt. Dedupe by transaction_id so it opens
        // exactly once per prompt: never on rebuild, never after dismissal,
        // and never for historical prompts replayed by loadChatHistory.
        if (state is AIChatMessageSuccess) {
          _maybeAutoOpenPinPrompt(state.messages);
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
            // Keep bottom-nav clearance when the keyboard is closed, but rise
            // with the keyboard so the input isn't covered. 72.h lifts the
            // typing area clear of the curved nav bar (it previously sat a few
            // px behind it).
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom > 0
                  ? MediaQuery.of(context).viewInsets.bottom
                  : 72.h,
            ),
            decoration: const BoxDecoration(color: InvoiceThemeColors.primaryBackground),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              // Pass isTyping status to AppBar
              appBar: _buildAppBar(isTyping), 
              body: Column(
                children: [
                  _buildChatHeader(),
                  // Hide chat history when user is entering a PIN
                  Expanded(
                    child: _isPinMode
                        ? _buildPinOverlay()
                        : _buildMessagesList(messageEntities),
                  ),
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