import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
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
  const AiChatContent({super.key});

  @override
  State<AiChatContent> createState() => _AiChatContentState();
}

class _AiChatContentState extends State<AiChatContent> with TickerProviderStateMixin {
  // --- State variables ---
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isAttaching = false; // Kept for local UI state during image preview
  bool _isPinMode = false; // Hides chat history when entering a PIN
  late AnimationController _typingDotsController;
  AiChatSettings _settings = AiChatSettings();
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _loadHistory();
      }
    });
  }

  Future<void> _loadSettings() async {
    final settings = await AiChatSettings.load();
    if (mounted) {
      setState(() => _settings = settings);
    }
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
                _showClearChatConfirmation();
              },
            ),
            _buildOptionTile(
              'Export Chat',
              Icons.download_rounded,
              Colors.blue,
              () {
                Get.back();
                _exportChat();
              },
            ),
            _buildOptionTile(
              'AI Settings',
              Icons.tune_rounded,
              const Color(0xFF3B82F6),
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
        backgroundColor: const Color(0xFF1E1E1E),
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
    buffer.writeln('LazerVault AI Chat Export');
    buffer.writeln('Exported on: ${DateTime.now().toString().split('.').first}');
    buffer.writeln('${'─' * 40}\n');

    for (final msg in messages) {
      final sender = msg.isUser ? 'You' : 'LazerAI';
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
        title: 'LazerVault Chat Export',
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
                color: const Color(0xFF1A1A2E),
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
                        Icon(Icons.tune_rounded, color: const Color(0xFF3B82F6), size: 22.sp),
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
                          backgroundColor: const Color(0xFF3B82F6),
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
              color: isActive ? const Color(0xFF3B82F6).withValues(alpha: 0.15) : Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isActive ? const Color(0xFF3B82F6) : Colors.white.withValues(alpha: 0.1),
                width: isActive ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icons[i], size: 16.sp, color: isActive ? const Color(0xFF3B82F6) : Colors.white54),
                SizedBox(width: 6.w),
                Text(
                  labels[i],
                  style: TextStyle(
                    color: isActive ? const Color(0xFF3B82F6) : Colors.white70,
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
          activeTrackColor: const Color(0xFF3B82F6),
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
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF1A1A2E),
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

  Widget _buildPinOverlay() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.lock_rounded, color: const Color(0xFF3B82F6), size: 48.sp),
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

  // iMessage-style bubble colors
  static const _userBubbleColor = Color(0xFF0A84FF);
  static const _aiBubbleColor = Color(0xFF166534);

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
            if (message.text.isNotEmpty)
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
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MarkdownBody(
                          data: message.text,
                          selectable: true,
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
                              color: isUser ? const Color(0xFFBFDBFE) : const Color(0xFF86EFAC),
                              fontSize: 13.sp * _settings.fontSizeMultiplier,
                            ),
                            listBullet: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isUser ? const Color(0xFF93C5FD) : const Color(0xFF6EE7B7),
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
          border: Border.all(color: const Color(0xFF22C55E).withValues(alpha: 0.25)),
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
                        color: const Color(0xFF22C55E).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: const Color(0xFF22C55E).withValues(alpha: 0.35)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (btn.icon != null && btn.icon!.isNotEmpty) ...[
                            Icon(Icons.arrow_forward_rounded, color: const Color(0xFF4ADE80), size: 14.sp),
                            SizedBox(width: 4.w),
                          ],
                          Text(btn.label, style: TextStyle(color: const Color(0xFF4ADE80), fontSize: 12.sp, fontWeight: FontWeight.w500)),
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
                      decoration: BoxDecoration(color: const Color(0xFF4ADE80).withValues(alpha: opacity), shape: BoxShape.circle),
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

        // Scroll to bottom: instant jump on history load, animated for new messages
        if (state is AIChatHistorySuccess) {
          _scrollToBottom(isDelayed: true, animate: false);
        } else if (state is AIChatMessageSuccess || state is AIChatMessageLoading) {
          _scrollToBottom(isDelayed: true);
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