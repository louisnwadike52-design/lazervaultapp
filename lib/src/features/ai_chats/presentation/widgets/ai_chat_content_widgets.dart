part of 'ai_chat_content.dart';

/// Container formats offered when exporting the central chatbot transcript.
enum ChatExportFormat { pdf, csv, whatsapp, text }

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
