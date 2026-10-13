import 'dart:async';
import 'package:lazervault/core/utils/receipt_fonts.dart';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/services/auto_logout_guard.dart';
import 'package:lazervault/core/services/chat_language_preference.dart';
import 'package:lazervault/core/services/active_account_snapshot.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/utils/pin_mask_utils.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_media_bubble.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_voice_note_player.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_pin_prompt_card.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_pin_auto_opener.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_recipient_card.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_receipt_card.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_receipt_card_v2.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_qr_card.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_markdown_style.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_analytics_card.dart';
import '../../cubit/ai_chat_cubit.dart';
import '../../cubit/ai_chat_state.dart';
import '../../domain/entities/ai_chat_message_entity.dart';
import 'package:lazervault/core/services/voice_record_configs.dart';
part 'ai_chat_content_widgets.dart';

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

class _AiChatContentState extends State<AiChatContent>
    with TickerProviderStateMixin {
  // --- State variables ---
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  /// Live scroll position, driving BOTH the app bar's fade and the
  /// scroll-to-latest button — one read, so the two can never disagree about
  /// where the list is.
  double _scrollOffset = 0;

  /// True once the user has scrolled meaningfully away from the newest
  /// message. See _onScroll for why it is a threshold, not an equality.
  bool _awayFromBottom = false;
  bool _isAttaching = false; // Kept for local UI state during image preview
  bool _isPinMode = false; // Hides chat history when entering a PIN
  // Re-entrancy guard for _handleSubmitted. Without this, a rapid double-tap
  // on a suggestion pill or send button fires two simultaneous /chat POSTs
  // (same session, same message) — the user sees the message echoed twice
  // and the LLM responds twice. The guard releases on the next tick after
  // the cubit's sendMessage call is dispatched (the cubit owns the typing
  // state from there) so the user can immediately type a follow-up.
  bool _isSubmitting = false;
  // True while an older-history page is being fetched + prepended (scroll-up
  // pagination). Suppresses the auto-scroll-to-bottom that a normal history
  // emit triggers, so the viewport can be re-anchored to the same message.
  bool _isPrependingOlder = false;
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
  /// Shared with every other chat surface so the PIN sheet opens under ONE set of
  /// rules. Replaces a local one-shot set that had no route guard and no memory of a
  /// cancellation — so a sheet could appear over a screen the user had navigated to,
  /// and a dismissal was not recorded anywhere.
  final ChatPinAutoOpener _pinAutoOpener = ChatPinAutoOpener();

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

  /// Removes this tab's inactivity-auto-logout suppression predicate on dispose.
  VoidCallback? _releaseAutoLogout;

  /// The route this kept-alive tab lives in (the dashboard). Captured in
  /// didChangeDependencies; `isCurrent` tells the suppression predicate whether
  /// the dashboard is topmost (false while a flow is pushed over it).
  ModalRoute<dynamic>? _hostRoute;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _hostRoute = ModalRoute.of(context);
  }

  @override
  void initState() {
    super.initState();
    _typingDotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    _loadSettings();

    // Suppress inactivity auto-logout while the chatbot tab is the visible,
    // foreground surface. This page is KEPT ALIVE by the dashboard TabBarView,
    // so a plain register/dispose pair would keep suppressing even after the
    // user switched tabs or pushed a flow over the dashboard. Instead the
    // predicate is evaluated FRESH each idle tick and is true only when: this
    // is the active bottom-nav tab AND the dashboard is the topmost route
    // (isCurrent) — so it re-enables the moment the user leaves, with no leak.
    _releaseAutoLogout = AutoLogoutGuard.register(
      () =>
          mounted &&
          widget.activeTab?.value == widget.chatTabIndex &&
          (_hostRoute?.isCurrent ?? true),
    );

    // Load older history when the user scrolls to the very top (reverse
    // pagination). Prior messages are preserved and older ones are prepended.
    _scrollController.addListener(_onScroll);

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

  /// Shown in the chat when conversation history could not be loaded.
  ///
  /// Replaces a snackbar. The snackbar covered the conversation, vanished after
  /// a few seconds, and left an empty-looking chat with no explanation — so a
  /// load failure was indistinguishable from having no messages, and retrying
  /// meant leaving the screen and coming back.
  ///
  /// Deliberately NOT an error-red block filling the screen: any messages that
  /// did load are still usable and the user can still send a new one, so this is
  /// a strip that explains and offers Retry, not a barrier.
  Widget _buildHistoryErrorBanner(String message) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 4.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2A1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF5A3030), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.history_toggle_off_rounded,
              size: 18.sp, color: const Color(0xFFE0A0A0)),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Couldn't load earlier messages",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  // The cubit's message where it is useful, and a plain fallback
                  // where it is a raw exception string that would mean nothing.
                  message.trim().isEmpty
                      ? 'You can still send a new message.'
                      : '$message You can still send a new message.',
                  style: TextStyle(
                    color: const Color(0xFFB6B9C6),
                    fontSize: 11.5.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          TextButton(
            onPressed: _loadHistory,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Retry',
              style: TextStyle(
                color: const Color(0xFFA78BFA),
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadHistory() async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      context
          .read<AIChatCubit>()
          .loadChatHistory(accessToken: authState.profile.session.accessToken);
    }
  }

  /// Trigger "load older" once the user scrolls near the very top of the list.
  /// The cubit + [_isPrependingOlder] guard collapse a burst of scroll events
  /// into a single fetch.
  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;

    // Drive the bar's fade and the jump button from the same read.
    //
    // "Away from the bottom" is a 220pt threshold, not "not exactly at the
    // bottom": a list that sits a few pixels off the end after a keyboard
    // resize would otherwise flash the button at someone who is already
    // reading the newest message.
    final away = (pos.maxScrollExtent - pos.pixels) > 220;
    if (away != _awayFromBottom || (pos.pixels - _scrollOffset).abs() > 4) {
      setState(() {
        _awayFromBottom = away;
        _scrollOffset = pos.pixels;
      });
    }

    if (_isPrependingOlder) return;
    if (pos.pixels <= 120) {
      _loadOlderHistory();
    }
  }

  /// Fetch the next older page and prepend it, then re-anchor the viewport to
  /// the message the user was looking at (advance pixels by the growth in the
  /// scroll extent) so the list doesn't jump.
  Future<void> _loadOlderHistory() async {
    if (_isPrependingOlder) return;
    final cubit = context.read<AIChatCubit>();
    if (!cubit.hasMoreHistory || cubit.isLoadingOlder) return;
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    if (!_scrollController.hasClients) return;

    _isPrependingOlder = true;
    final beforeExtent = _scrollController.position.maxScrollExtent;
    final beforePixels = _scrollController.position.pixels;

    await cubit.loadOlderHistory(
      accessToken: authState.profile.session.accessToken,
    );

    if (!mounted) {
      _isPrependingOlder = false;
      return;
    }
    // After the prepended messages lay out, keep the same message under the
    // viewport by advancing by however much the extent grew. Media (chat
    // images / receipt cards) finish laying out and GROW the list AFTER the
    // first post-frame, so a single jump drifts. Re-apply the anchoring jump at
    // a few staggered delays — mirroring _scrollChatToBottom — so the anchored
    // message survives late layout growth. _isPrependingOlder stays true for the
    // whole window so _onScroll can't re-fire a fetch when an intermediate jump
    // lands the viewport back near the top (pixels <= 120).
    void reAnchor() {
      if (!mounted || !_scrollController.hasClients) return;
      final delta = _scrollController.position.maxScrollExtent - beforeExtent;
      if (delta > 0) {
        _scrollController.jumpTo(beforePixels + delta);
      }
    }

    for (final ms in const [0, 120, 300]) {
      Future.delayed(Duration(milliseconds: ms), reAnchor);
    }
    // Release the guard only after the last re-anchor settles.
    Future.delayed(const Duration(milliseconds: 320), () {
      if (mounted) _isPrependingOlder = false;
    });
  }

  /// Auto-open the PIN bottom sheet for the latest assistant message that
  /// carries a pin_prompt, once per transaction_id. Only ever called from the
  /// AIChatMessageSuccess branch of the listener (live turn), so historical
  /// prompts replayed by loadChatHistory never trigger it. The sheet is the
  /// SAME native modal the in-chat card opens — we just drive that card's
  /// state via its stable GlobalKey, so there is one verification code path.
  void _maybeAutoOpenPinPrompt(List<ChatMessageEntity> messages) {
    final prompts = <Map<String, dynamic>>[];
    for (final m in messages) {
      if (!m.isUser && m.pinPrompt != null) {
        prompts.add(Map<String, dynamic>.from(m.pinPrompt!));
      }
    }
    // Called only from the AIChatMessageSuccess branch, so this IS a live turn; the
    // opener still applies its own priming, expiry, cancellation and route guards.
    _pinAutoOpener.sync(context: context, prompts: prompts, isLiveTurn: true);
  }

  @override
  void dispose() {
    _releaseAutoLogout?.call();
    _scrollController.removeListener(_onScroll);
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
    context
        .read<AIChatCubit>()
        .sendMessage(messageText, accessToken: accessToken);

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
      // The shared voice-note profile. This was a bare RecordConfig, which
      // defaults to STEREO — and stereo silently fails to initialise on most
      // Android mics, recording an empty clip. So voice notes to the assistant
      // "did not send" on Android while iOS worked, in all four chat surfaces
      // that omitted it. See voice_record_configs.dart.
      kVoiceNoteRecordConfig,
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
                _showExportFormatSheet();
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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Clear Chat',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600)),
        content: Text(
          'This will clear your entire conversation history. This action cannot be undone.',
          style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel',
                style: TextStyle(color: Colors.white70, fontSize: 14.sp)),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              // Deletes server-side (Redis + Postgres soft-delete) THEN resets
              // local state; only confirm on success so a failed clear isn't
              // reported as done (it would reappear on reload).
              final ok = await context.read<AIChatCubit>().clearChat();
              if (ok) {
                Get.snackbar('Done', 'Chat cleared',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFF1F1F1F),
                    colorText: Colors.white);
              } else {
                Get.snackbar('Could not clear chat', 'Please try again.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFFEF4444),
                    colorText: Colors.white);
              }
            },
            child: Text('Clear',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  /// Present the export-format chooser. Each option shares the FULL transcript
  /// in a different container: PDF (portable document), CSV (spreadsheet),
  /// WhatsApp-style .txt (the `[dd/mm/yy, hh:mm:ss] Sender: message` format
  /// WhatsApp's chat export/import tools recognise), or plain text.
  void _showExportFormatSheet() {
    Widget tile(String label, String sub, IconData icon, ChatExportFormat fmt) {
      return ListTile(
        leading:
            Icon(icon, color: InvoiceThemeColors.primaryPurple, size: 22.sp),
        title: Text(label,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600)),
        subtitle: Text(sub,
            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
        onTap: () {
          Get.back();
          _exportChat(fmt);
        },
      );
    }

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
        decoration: BoxDecoration(
          color: InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 12.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.w, bottom: 4.h),
              child: Text('Export chat as',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700)),
            ),
            tile('PDF document', 'Formatted, shareable transcript',
                Icons.picture_as_pdf_rounded, ChatExportFormat.pdf),
            tile('CSV spreadsheet', 'Time, sender and message columns',
                Icons.grid_on_rounded, ChatExportFormat.csv),
            tile('WhatsApp format', 'Import into a WhatsApp chat',
                Icons.chat_rounded, ChatExportFormat.whatsapp),
            tile('Plain text', 'Simple .txt transcript', Icons.notes_rounded,
                ChatExportFormat.text),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Future<void> _exportChat(ChatExportFormat format) async {
    final cubit = context.read<AIChatCubit>();
    // Export the COMPLETE transcript, not just the pages currently scrolled into
    // view. Pull the full history from the server; fall back to the in-memory
    // messages if the fetch yields nothing (offline / error).
    List<ChatMessageEntity> messages = cubit.state.messages;
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      try {
        final full = await cubit.fetchAllForExport(
            accessToken: authState.profile.session.accessToken);
        if (full.isNotEmpty) messages = full;
      } catch (_) {
        // Keep the in-memory messages — export is best-effort, never blocks.
      }
    }
    if (messages.isEmpty) {
      Get.snackbar('Info', 'No messages to export',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      final dir = await getTemporaryDirectory();
      final stamp = DateFormat('yyyyMMdd_HHmm').format(DateTime.now());
      late final File file;
      switch (format) {
        case ChatExportFormat.pdf:
          file = File('${dir.path}/lazervault_chat_$stamp.pdf');
          await file.writeAsBytes(await _buildTranscriptPdf(messages));
          break;
        case ChatExportFormat.csv:
          file = File('${dir.path}/lazervault_chat_$stamp.csv');
          await file.writeAsString(_buildTranscriptCsv(messages));
          break;
        case ChatExportFormat.whatsapp:
          // WhatsApp names its exports "WhatsApp Chat with X.txt"; matching the
          // "_chat.txt" suffix + line format helps import tools recognise it.
          file = File('${dir.path}/lazervault_nova_chat.txt');
          await file.writeAsString(_buildTranscriptWhatsapp(messages));
          break;
        case ChatExportFormat.text:
          file = File('${dir.path}/lazervault_chat_$stamp.txt');
          await file.writeAsString(_buildTranscriptText(messages));
          break;
      }
      await SharePlus.instance.share(ShareParams(
        // iOS: a non-zero popover anchor is required — CGRectZero throws
        // PlatformException and the share silently fails on iPhone/iPad.
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
        files: [XFile(file.path)],
        title: 'Lazervault Chat Export',
      ));
    } catch (_) {
      Get.snackbar('Error', 'Failed to export chat',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// Plain-text transcript (the original format).
  String _buildTranscriptText(List<ChatMessageEntity> messages) {
    final buffer = StringBuffer()
      ..writeln('Lazervault AI Chat Export')
      ..writeln(
          'Exported on: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())}')
      ..writeln('${'─' * 40}\n');
    for (final msg in messages) {
      final sender = msg.isUser ? 'You' : 'Nova';
      final time = DateFormat('HH:mm').format(msg.timestamp);
      buffer
        ..writeln('[$time] $sender:')
        ..writeln(msg.text)
        ..writeln();
    }
    return buffer.toString();
  }

  /// WhatsApp export format: one line per message,
  /// `dd/MM/yyyy, HH:mm - Sender: message` (newlines within a message are
  /// collapsed to spaces, as WhatsApp's line-per-message parser expects).
  String _buildTranscriptWhatsapp(List<ChatMessageEntity> messages) {
    final fmt = DateFormat('dd/MM/yyyy, HH:mm');
    final buffer = StringBuffer();
    for (final msg in messages) {
      final sender = msg.isUser ? 'You' : 'Nova';
      final body = msg.text.replaceAll('\n', ' ').trim();
      buffer.writeln('${fmt.format(msg.timestamp)} - $sender: $body');
    }
    return buffer.toString();
  }

  /// CSV with a header row + Timestamp, Sender, Message columns.
  String _buildTranscriptCsv(List<ChatMessageEntity> messages) {
    final fmt = DateFormat('yyyy-MM-dd HH:mm:ss');
    final rows = <List<String>>[
      ['Timestamp', 'Sender', 'Message'],
      for (final msg in messages)
        [fmt.format(msg.timestamp), msg.isUser ? 'You' : 'Nova', msg.text],
    ];
    return const ListToCsvConverter().convert(rows);
  }

  /// A simple, readable PDF: a title page header then one block per message.
  Future<List<int>> _buildTranscriptPdf(
      List<ChatMessageEntity> messages) async {
    final doc = await ReceiptFonts.document();
    final fmt = DateFormat('yyyy-MM-dd HH:mm');
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text('Lazervault AI Chat',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Text('Exported ${fmt.format(DateTime.now())}',
              style:
                  const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
          pw.SizedBox(height: 12),
          ...messages.map((msg) {
            final isUser = msg.isUser;
            return pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 10),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    '${isUser ? 'You' : 'Nova'}  ·  ${fmt.format(msg.timestamp)}',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                      color: isUser ? PdfColors.blue800 : PdfColors.purple800,
                    ),
                  ),
                  pw.SizedBox(height: 2),
                  pw.Text(msg.text, style: const pw.TextStyle(fontSize: 11)),
                ],
              ),
            );
          }),
        ],
      ),
    );
    return doc.save();
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
                    width: 40.w,
                    height: 4.h,
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
                        Icon(Icons.tune_rounded,
                            color: InvoiceThemeColors.primaryPurple,
                            size: 22.sp),
                        SizedBox(width: 10.w),
                        Text('AI Settings',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.of(ctx).pop(),
                          child: Icon(Icons.close_rounded,
                              color: Colors.white54, size: 22.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Divider(
                      color: Colors.white.withValues(alpha: 0.08), height: 1),
                  // Settings body
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 16.h),
                      children: [
                        // --- Language ---
                        _settingsLabel('Language'),
                        SizedBox(height: 8.h),
                        Text(
                          'The assistant replies in this language and also '
                          'auto-detects the language you type in.',
                          style:
                              TextStyle(color: Colors.white38, fontSize: 11.sp),
                        ),
                        SizedBox(height: 8.h),
                        _buildChipGroup(
                          options: ChatLanguagePreference
                              .supportedLanguages.keys
                              .toList(),
                          labels: ChatLanguagePreference
                              .supportedLanguages.values
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
                          options: const [
                            'concise',
                            'balanced',
                            'detailed',
                            'professional'
                          ],
                          labels: const [
                            'Concise',
                            'Balanced',
                            'Detailed',
                            'Professional'
                          ],
                          icons: const [
                            Icons.short_text_rounded,
                            Icons.balance_rounded,
                            Icons.article_rounded,
                            Icons.business_center_rounded
                          ],
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
                          icons: const [
                            Icons.text_fields_rounded,
                            Icons.format_size_rounded,
                            Icons.title_rounded
                          ],
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
                            _balancePreviewText(),
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
                          Get.snackbar(
                            'Saved',
                            'AI settings updated',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: const Color(0xFF1F1F1F),
                            colorText: Colors.white,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: InvoiceThemeColors.primaryPurple,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r)),
                        ),
                        child: Text('Save Settings',
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.w600)),
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

  /// Live text-size preview using the dashboard's ACTIVE account balance — the
  /// same source the dashboard shows (AccountManager.activeAccountDetails) —
  /// formatted with that account's own currency. Falls back to a neutral line
  /// when no account is selected yet (e.g. right after login).
  String _balancePreviewText() {
    try {
      // Read the SAME live source the dashboard + money flows use.
      //
      // This used to read the state of a cubit pulled from the locator, which
      // is a FACTORY registration — always a brand-new instance in its initial
      // state, so `summaries` was always empty and this always returned the
      // generic line. activeAccountSnapshot() reads the shared store the
      // dashboard's instance publishes into.
      final active = activeAccountSnapshot();
      if (active == null) {
        return 'Preview: This is how your messages will look';
      }
      final amount = NumberFormat('#,##0.00').format(active.balanceMajor);
      return 'Preview: Your balance is ${active.currency} $amount';
    } catch (_) {
      return 'Preview: This is how your messages will look';
    }
  }

  Widget _settingsLabel(String text) {
    return Text(
      text,
      style: TextStyle(
          color: const Color(0xFF9CA3AF),
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5),
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
              color: isActive
                  ? InvoiceThemeColors.primaryPurple.withValues(alpha: 0.15)
                  : Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isActive
                    ? InvoiceThemeColors.primaryPurple
                    : Colors.white.withValues(alpha: 0.1),
                width: isActive ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icons[i],
                    size: 16.sp,
                    color: isActive
                        ? InvoiceThemeColors.primaryPurple
                        : Colors.white54),
                SizedBox(width: 6.w),
                Text(
                  labels[i],
                  style: TextStyle(
                    color: isActive
                        ? InvoiceThemeColors.primaryPurple
                        : Colors.white70,
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

  Widget _buildSettingsToggle(String title, String subtitle, IconData icon,
      bool value, ValueChanged<bool> onChanged) {
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
        title:
            Text(title, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
        subtitle: Text(subtitle,
            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 11.sp)),
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

  Widget _buildOptionTile(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20.sp),
      ),
      title:
          Text(title, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
      onTap: onTap,
    );
  }

  // --- Build methods ---

  // Updated to accept isTyping status
  PreferredSizeWidget _buildAppBar(bool isTyping) {
    // Shorter, and it settles as you read.
    //
    // The bar is chrome: it names who you are talking to and gets out of the
    // way. At 60pt it took a tenth of a phone screen away from the thread.
    // The tint deepens slightly once the list has scrolled, which is what
    // separates the bar from the message sliding under it — without a border,
    // which would draw a hard line across the screen at rest.
    final scrolled = (_scrollOffset / 60.0).clamp(0.0, 1.0);
    return PreferredSize(
      preferredSize: Size.fromHeight(48.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                InvoiceThemeColors.primaryPurple
                    .withValues(alpha: 0.15 + 0.25 * scrolled),
                InvoiceThemeColors.gradientPurple
                    .withValues(alpha: 0.08 + 0.18 * scrolled),
                InvoiceThemeColors.primaryBackground,
              ],
            ),
            boxShadow: scrolled > 0.05
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.28 * scrolled),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : const [],
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
              child: Icon(Icons.smart_toy_rounded,
                  color: InvoiceThemeColors.gradientPurple, size: 24.sp),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NOVA',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
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
            color: isTyping
                ? InvoiceThemeColors.primaryPurple
                : InvoiceThemeColors.successGreen,
            shape: BoxShape.circle,
          ),
        ),
        Text(
          isTyping ? 'Typing...' : 'Online',
          style: TextStyle(
              color: isTyping
                  ? InvoiceThemeColors.primaryPurple
                  : InvoiceThemeColors.successGreen,
              fontSize: 12.sp),
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
        border:
            Border(bottom: BorderSide(color: InvoiceThemeColors.borderColor)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded,
              color: InvoiceThemeColors.gradientPurple, size: 18.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Ask me anything — transfers, bills, investments & more',
              style: TextStyle(
                  color: InvoiceThemeColors.textGray400, fontSize: 12.sp),
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
            child: Icon(Icons.lock_rounded,
                color: InvoiceThemeColors.primaryPurple, size: 48.sp),
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
    final messages = messageEntities
        .map((entity) => ChatMessage.fromEntity(entity))
        .toList();

    // Add initial bot message if the list is empty
    if (messages.isEmpty) {
      messages.add(ChatMessage(
        text:
            "Hello! I'm NOVA, your financial assistant. How can I help you today?",
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
  static final _userBubbleColor =
      InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2);
  static const _aiBubbleColor = InvoiceThemeColors.secondaryBackground;

  /// Whether to render a message's text bubble. Voice notes carry a "Sent a
  /// voice note" placeholder as their text, which is redundant next to the
  /// player — suppress it (their real transcript still shows inside the player).
  bool _showMessageText(ChatMessage message) =>
      message.text.isNotEmpty && message.mediaType != 'voice';

  /// Which answers the user has rated, keyed by message timestamp.
  ///
  /// Held on the widget rather than the message so a rating survives the
  /// list rebuilding, and so an un-rated answer costs nothing to render.
  /// Ratings are also sent upstream; this map is only what the UI draws.
  /// Ratings tapped in THIS session, by _ratingKey.
  ///
  /// The value is nullable on purpose: a key present with a null value means
  /// "cleared just now", which has to outrank the rating the server sent with
  /// the message — otherwise untapping a thumb restored from history would
  /// immediately paint itself back.
  final Map<String, String?> _answerRatings = {};

  /// Identity of a rateable answer.
  ///
  /// The SERVER id when there is one, so a rating follows the message across
  /// a reload instead of being keyed to a timestamp that is regenerated when
  /// history is reparsed. Falls back to the timestamp for an answer that has
  /// not been persisted yet (the live turn, before its id comes back).
  String _ratingKey(ChatMessage m) => m.serverMessageId != null
      ? 'id:${m.serverMessageId}'
      : 'ts:${m.timestamp.millisecondsSinceEpoch}';

  /// What thumb to paint: the local tap if there is one, otherwise whatever
  /// the server said when the thread loaded.
  ///
  /// Local wins so a tap is reflected instantly rather than waiting for a
  /// round trip, and an untap (which clears to null) is not overwritten by
  /// the stale stored value — `_answerRatings` holds the key with a null
  /// value in that case, which `containsKey` distinguishes from "never
  /// touched".
  String? _ratingFor(ChatMessage m) {
    final key = _ratingKey(m);
    if (_answerRatings.containsKey(key)) return _answerRatings[key];
    final stored = m.rating;
    return (stored != null && stored.isNotEmpty) ? stored : null;
  }

  /// Copy, helpful, not helpful.
  ///
  /// Deliberately quiet: low-contrast icons that do not compete with the
  /// answer. Rating is one tap and reversible — tapping the same thumb again
  /// clears it, because a mis-tap on feedback should not be permanent.
  Widget _buildAnswerActions(ChatMessage message) {
    final rating = _ratingFor(message);
    return Padding(
      padding: EdgeInsets.only(left: 6.w, top: 4.h, bottom: 2.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _answerAction(
            icon: Icons.content_copy_rounded,
            tooltip: 'Copy',
            active: false,
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: message.text));
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Copied'),
                  duration: const Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: InvoiceThemeColors.secondaryBackground,
                ),
              );
            },
          ),
          SizedBox(width: 2.w),
          _answerAction(
            icon: rating == 'up'
                ? Icons.thumb_up_rounded
                : Icons.thumb_up_outlined,
            tooltip: 'Helpful',
            active: rating == 'up',
            onTap: () => _rateAnswer(message, 'up'),
          ),
          SizedBox(width: 2.w),
          _answerAction(
            icon: rating == 'down'
                ? Icons.thumb_down_rounded
                : Icons.thumb_down_outlined,
            tooltip: 'Not helpful',
            active: rating == 'down',
            onTap: () => _rateAnswer(message, 'down'),
          ),
        ],
      ),
    );
  }

  Widget _answerAction({
    required IconData icon,
    required String tooltip,
    required bool active,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Padding(
          padding: EdgeInsets.all(6.w),
          child: Icon(
            icon,
            size: 15.sp,
            color: active
                ? InvoiceThemeColors.primaryPurple
                : Colors.white.withValues(alpha: 0.38),
          ),
        ),
      ),
    );
  }

  /// Record a rating, and send it upstream so the answers can be improved.
  ///
  /// Fire-and-forget on purpose: feedback is not the user's errand. A failed
  /// send must never interrupt the conversation or undo what they just
  /// tapped, so the UI state is authoritative locally and the network call is
  /// best-effort.
  Future<void> _rateAnswer(ChatMessage message, String rating) async {
    final key = _ratingKey(message);
    // Toggle against what is SHOWING, which may have come from the server
    // rather than from a tap in this session — otherwise tapping the thumb
    // that is already lit from history would set it again instead of
    // clearing it.
    final current = _ratingFor(message);
    setState(() {
      if (current == rating) {
        // Keep the key with a null value: that is how _ratingFor tells
        // "cleared just now" from "never touched", so the stored rating does
        // not immediately paint itself back.
        _answerRatings[key] = null;
      } else {
        _answerRatings[key] = rating;
      }
    });
    HapticFeedback.selectionClick();
    // CLEARING is sent too, as the empty string — the endpoint takes 'up',
    // 'down' or '' and '' nulls the column.
    //
    // This used to return early on a clear, which was invisible while
    // ratings were never read back: the thumb went out, nothing contradicted
    // it. Now that history restores the stored rating, an un-tap that never
    // reached the server would come back the next time the thread loaded,
    // and the user would be told they had said something they had just
    // retracted.
    final applied = _answerRatings[key] ?? '';
    unawaited(context.read<AIChatCubit>().rateAnswer(
          serverMessageId: message.serverMessageId,
          rating: applied,
        ));
  }

  /// The jump-to-latest control.
  ///
  /// A plain circle rather than a labelled pill: it appears over the
  /// conversation, and a word here would compete with the message underneath
  /// it for the one moment it is visible.
  /// What to offer next, based on what was just said.
  ///
  /// The chips were a fixed list of five, shown identically on the first turn
  /// and the fiftieth — so after asking about a transfer you were still being
  /// offered "Explain cryptocurrency trading". Follow-ups are drawn from the
  /// service the last answer came from, which is the one thing we reliably
  /// know about where the conversation is.
  ///
  /// Server-provided suggestions always win: the agent knows more about the
  /// turn than this does. The fixed list survives only for an empty thread,
  /// where there is genuinely nothing to follow.
  List<String> _activeSuggestions(
      List<ChatMessageEntity> messages, List<String> fromServer) {
    if (fromServer.isNotEmpty) return fromServer;
    if (messages.isEmpty) return _defaultSuggestions;

    ChatMessageEntity? lastAnswer;
    for (final m in messages.reversed) {
      if (!m.isUser) {
        lastAnswer = m;
        break;
      }
    }
    if (lastAnswer == null) return _defaultSuggestions;

    final followUps = _followUpsFor(lastAnswer);
    return followUps.isEmpty ? _defaultSuggestions : followUps;
  }

  /// Follow-ups keyed off the last answer's intent/service.
  ///
  /// Kept deliberately small and concrete. A chip is a shortcut, not a menu:
  /// three good ones beat eight that make the user read.
  List<String> _followUpsFor(ChatMessageEntity answer) {
    final intent = (answer.intent ?? '').toLowerCase();
    final text = answer.text.toLowerCase();
    String area = intent;
    if (area.isEmpty) {
      for (final probe in const [
        'transfer', 'invest', 'crypto', 'bill', 'budget',
        // Stems, not whole words: an answer says "you SPENT", not "spend",
        // and "SAVINGS", not "save". Matching the full word meant the most
        // common phrasings fell through to the generic chips.
        'spen', 'sav', 'card', 'loan',
      ]) {
        if (text.contains(probe)) {
          area = probe;
          break;
        }
      }
    }

    if (area.contains('transfer') || area.contains('send')) {
      return const [
        'What are the fees?',
        'How long will it take?',
        'Show my recent transfers',
      ];
    }
    if (area.contains('invest')) {
      return const [
        'What are the risks?',
        'How much should I start with?',
        'Show my portfolio',
      ];
    }
    if (area.contains('crypto')) {
      return const [
        "What's the current rate?",
        'Show my crypto balance',
        'How do I withdraw?',
      ];
    }
    if (area.contains('bill') ||
        area.contains('airtime') ||
        area.contains('data')) {
      return const [
        'Show my recent bills',
        'Set up auto-recharge',
        'What did I spend on bills?',
      ];
    }
    if (area.contains('budget') ||
        area.contains('spen') ||
        area.contains('expense')) {
      return const [
        'Where did most of it go?',
        'Compare with last month',
        'Set a budget for this',
      ];
    }
    if (area.contains('sav') || area.contains('goal')) {
      return const [
        'How close am I?',
        'Increase my savings',
        'When will I reach it?',
      ];
    }
    return const [];
  }

  Widget _buildJumpToLatest() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _scrollToBottom(),
        borderRadius: BorderRadius.circular(22.r),
        child: Container(
          width: 38.w,
          height: 38.w,
          decoration: BoxDecoration(
            color: InvoiceThemeColors.secondaryBackground,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white.withValues(alpha: 0.85),
            size: 22.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final bool isUser = message.isUser;

    // Render rich message types for AI responses
    if (!isUser &&
        message.type == ChatMessageType.confirmation &&
        message.confirmationData != null) {
      return _buildConfirmationCard(message);
    }
    if (!isUser &&
        message.type == ChatMessageType.actionCard &&
        message.actionButtons != null) {
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
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
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
                          : Border.all(
                              color: InvoiceThemeColors.borderColor,
                              width: 0.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MarkdownBody(
                          data: isUser ? maskIfPin(message.text) : message.text,
                          selectable: !isUser || !isPinText(message.text),
                          styleSheet:
                              MarkdownStyleSheet.fromTheme(Theme.of(context))
                                  .copyWith(
                            p: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontSize:
                                      14.sp * _settings.fontSizeMultiplier,
                                  height: 1.45,
                                ),
                            strong: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontSize:
                                      14.sp * _settings.fontSizeMultiplier,
                                  fontWeight: FontWeight.w700,
                                ),
                            em: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.85),
                                  fontSize:
                                      14.sp * _settings.fontSizeMultiplier,
                                  fontStyle: FontStyle.italic,
                                ),
                            code: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontFamily: 'monospace',
                                  backgroundColor:
                                      Colors.black.withValues(alpha: 0.2),
                                  color: isUser
                                      ? const Color(0xFFD8B4FE)
                                      : const Color(0xFFD8B4FE),
                                  fontSize:
                                      13.sp * _settings.fontSizeMultiplier,
                                ),
                            listBullet: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: isUser
                                      ? const Color(0xFFD8B4FE)
                                      : const Color(0xFFD8B4FE),
                                  fontSize:
                                      14.sp * _settings.fontSizeMultiplier,
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
                      painter:
                          BubbleTailPainter(color: bubbleColor, isUser: isUser),
                      size: Size(10.w, 12.h),
                    ),
                  ),
                ],
              ),
            // Copy / helpful / not helpful, under the answer itself.
            //
            // Placed after the bubble rather than inside it so the row sits
            // under any card the answer carried too — rating "the answer"
            // means the chart as much as the sentence above it.
            if (!isUser && message.text.trim().isNotEmpty)
              _buildAnswerActions(message),
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
            // Scannable QR code. Rendered independently of the receipt cards
            // above: creating a QR is not a receipt, and the two never appear
            // on the same message.
            if (!isUser && message.qrCard != null)
              ChatQrCard(payload: message.qrCard!),
            // Charts for a "how am I doing?" / "show my transactions" turn.
            // Independent of the receipt cards: this is a read, not a money
            // move, so the two never appear on the same message.
            if (!isUser && message.analyticsCard != null)
              ChatAnalyticsCard(payload: message.analyticsCard!),
            // The confirmed counterparty, as a card with their avatar. The
            // voice HUD has rendered this identity all along; chat showed a
            // line of prose at the one moment a misread costs money.
            if (!isUser && message.recipientCard != null)
              ChatRecipientCard(
                data: message.recipientCard!,
                onChangeRecipient: () => _handleSubmitted('change recipient'),
              ),
            // PIN prompt card — chat-driven money moves collect the PIN inline.
            // "Enter PIN" opens the native modal; on success the single-use
            // token round-trips to the agent (submitPinVerification) and the
            // transaction continues in this same conversation.
            if (!isUser && message.pinPrompt != null)
              ChatPinPromptCard(
                // NO shared key here. The card registers itself by
                // transaction_id when it mounts, so the auto-open listener can
                // still drive it. A GlobalKey keyed on transaction_id could be
                // claimed by two cards at once — the agent re-emits a prompt
                // for the SAME transfer on a retry — and Flutter then refuses
                // to build either of them, which is how the confirmation card
                // disappeared.
                payload: message.pinPrompt!,
                // Dismissing means "not now". Recorded so no rebuild reopens the sheet
                // the user just closed; their own "Enter PIN" tap still works.
                onCancelled: () => _pinAutoOpener.noteCancelled(
                  ChatPinAutoOpener.transactionIdOf(message.pinPrompt!),
                ),
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
          border: Border.all(
              color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.text.isNotEmpty) ...[
              MarkdownBody(
                data: message.text,
                // The shared dark-bubble sheet. Overriding only `p` left every
                // other element on the light theme's defaults, so an inline
                // reference like `C2C-a1b2c3` rendered as a pale grey block with
                // near-black text on a dark bubble, and bold headings came
                // through no brighter than the body.
                styleSheet: chatAssistantMarkdownStyle(context),
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
                  _buildConfirmRow('Action',
                      cd.actionType.replaceAll('_', ' ').toUpperCase()),
                  if (cd.amount.isNotEmpty)
                    _buildConfirmRow('Amount', '${cd.currency} ${cd.amount}'),
                  if (cd.recipientName.isNotEmpty)
                    _buildConfirmRow('To', cd.recipientName),
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
                        child: Text('Cancel',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 14.sp)),
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
                        child: Text('Confirm',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_settings.showTimestamps) ...[
              SizedBox(height: 4.h),
              Text(_formatTime(message.timestamp),
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 10.sp)),
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
          Text(label,
              style:
                  TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500),
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
                  // Same shared dark-bubble sheet as above.
                  styleSheet: chatAssistantMarkdownStyle(context),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: InvoiceThemeColors.primaryPurple
                            .withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                            color: InvoiceThemeColors.primaryPurple
                                .withValues(alpha: 0.35)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (btn.icon != null && btn.icon!.isNotEmpty) ...[
                            Icon(Icons.arrow_forward_rounded,
                                color: InvoiceThemeColors.primaryPurple,
                                size: 14.sp),
                            SizedBox(width: 4.w),
                          ],
                          Text(btn.label,
                              style: TextStyle(
                                  color: InvoiceThemeColors.primaryPurple,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_settings.showTimestamps) ...[
              SizedBox(height: 4.h),
              Text(_formatTime(message.timestamp),
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 10.sp)),
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
                      decoration: BoxDecoration(
                          color: InvoiceThemeColors.primaryPurple
                              .withValues(alpha: opacity),
                          shape: BoxShape.circle),
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
  Widget _buildInputArea(
      List<ChatMessageEntity> messages, List<String> suggestions) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.primaryBackground,
        border: Border(top: BorderSide(color: InvoiceThemeColors.borderColor)),
      ),
      child: Column(
        children: [
          // Show suggestions if enabled and message list is effectively empty or text field empty
          if (_settings.quickSuggestions &&
              (messages.isEmpty || _messageController.text.isEmpty))
            Container(
              height: 40.h,
              margin: EdgeInsets.only(bottom: 12.h),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _activeSuggestions(messages, suggestions).length,
                itemBuilder: (context, index) {
                  final suggestionText =
                      _activeSuggestions(messages, suggestions)[index];
                  return GestureDetector(
                    onTap: () => _handleSubmitted(suggestionText),
                    child: Container(
                      margin: EdgeInsets.only(right: 8.w),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: InvoiceThemeColors.primaryPurple
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                            color: InvoiceThemeColors.primaryPurple
                                .withValues(alpha: 0.3)),
                      ),
                      child: Text(suggestionText,
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp)),
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
        decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1), shape: BoxShape.circle),
        child: Icon(Icons.add_photo_alternate_rounded,
            color: Colors.white.withValues(alpha: 0.7), size: 20.sp),
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
                      style: TextStyle(
                          color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded,
                  color: Colors.white.withValues(alpha: 0.3), size: 22.sp),
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
          color: _isRecording
              ? Colors.red.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          _isRecording ? Icons.stop : Icons.mic,
          color:
              _isRecording ? Colors.red : Colors.white.withValues(alpha: 0.7),
          size: 20.sp,
        ),
      ),
    );
  }

  Widget _buildRecordingIndicator() {
    final minutes = _recordingDuration.inMinutes.toString().padLeft(2, '0');
    final seconds =
        (_recordingDuration.inSeconds % 60).toString().padLeft(2, '0');
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
            child:
                Icon(Icons.delete_outline, color: Colors.red[300], size: 20.sp),
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
    final bool isEnabled =
        _messageController.text.trim().isNotEmpty || _isAttaching;
    return GestureDetector(
      onTap: isEnabled ? () => _handleSubmitted(_messageController.text) : null,
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          gradient: isEnabled
              ? LinearGradient(colors: [
                  InvoiceThemeColors.primaryPurple,
                  InvoiceThemeColors.gradientPurple
                ])
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
    return BlocConsumer<AIChatCubit, AIChatState>(listener: (context, state) {
      // Listener now only handles side-effects not directly tied to build
      if (!mounted) return;

      // A history-load failure is NOT a snackbar. The snackbar appeared over the
      // conversation, disappeared after a few seconds, and left the chat looking
      // empty with no explanation and nothing to press — so the failure was
      // indistinguishable from "you have no messages yet", and the only way to
      // retry was to leave the screen and come back.
      //
      // It is rendered inline in the chat instead (see _buildHistoryErrorBanner),
      // where it persists, says what failed, and offers Retry.
      if (state is AIChatMessageError) {
        Get.snackbar('Error', state.errorMessage,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withValues(alpha: 0.8),
            colorText: Colors.white);
      }

      // Scroll to bottom: instant settle on history load (staggered so it
      // reaches the true bottom as media expands the list), animated for new messages
      if (state is AIChatHistorySuccess) {
        // A prepend (scroll-up "load older") also emits AIChatHistorySuccess —
        // don't yank the view to the bottom; _loadOlderHistory re-anchors it.
        if (!_isPrependingOlder) _scrollChatToBottom();
      } else if (state is AIChatMessageSuccess ||
          state is AIChatMessageLoading) {
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
    }, builder: (context, state) {
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
          decoration:
              const BoxDecoration(color: InvoiceThemeColors.primaryBackground),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            // Pass isTyping status to AppBar
            appBar: _buildAppBar(isTyping),
            body: Column(
              children: [
                _buildChatHeader(),
                // Inline, persistent, and dismissible only by succeeding. Sits
                // above the list rather than inside it so it stays visible while
                // the user scrolls whatever history DID load.
                if (state is AIChatHistoryError && !_isPinMode)
                  _buildHistoryErrorBanner(state.message),
                // Hide chat history when user is entering a PIN
                Expanded(
                  child: Stack(
                    children: [
                      _isPinMode
                          ? _buildPinOverlay()
                          : _buildMessagesList(messageEntities),
                      // Back to the newest message.
                      //
                      // Shown ONLY once the user has scrolled up — a button
                      // that is always there is one more thing on screen that
                      // does nothing most of the time. Hidden during PIN
                      // entry, where the list is not what you are looking at.
                      if (!_isPinMode)
                        Positioned(
                          right: 14.w,
                          bottom: 14.h,
                          child: AnimatedOpacity(
                            opacity: _awayFromBottom ? 1 : 0,
                            duration: const Duration(milliseconds: 160),
                            child: IgnorePointer(
                              ignoring: !_awayFromBottom,
                              child: _buildJumpToLatest(),
                            ),
                          ),
                        ),
                    ],
                  ),
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
    });
  }
}
