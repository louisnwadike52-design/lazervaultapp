part of 'ai_chat_content.dart';

/// Container formats offered when exporting the central chatbot transcript.
enum ChatExportFormat { pdf, csv, whatsapp, text }

/// Local model for AI chat settings, persisted via SharedPreferences.
class AiChatSettings {
  String responseStyle; // concise, balanced, detailed, professional
  String textSize; // small, medium, large
  bool showTimestamps;
  bool emojiUsage;

  /// The customer's own choice about the suggestion chips, or NULL when they
  /// have never made one.
  ///
  /// NULLABLE ON PURPOSE — the three states are different things:
  ///
  ///   null  — never chosen: follow whatever the admin default says, and keep
  ///           following it when an operator changes it.
  ///   true  — chose ON: keep them even if the platform default is off.
  ///   false — chose OFF: keep them hidden even if the platform turns them on.
  ///
  /// A plain bool could not express the first, so every customer was pinned
  /// to the compiled default and an admin setting could never reach anybody.
  /// Resolve it through [quickSuggestionsVisible], never read directly.
  bool? quickSuggestions;

  AiChatSettings({
    this.responseStyle = 'balanced',
    this.textSize = 'medium',
    this.showTimestamps = true,
    this.emojiUsage = true,
    this.quickSuggestions,
  });

  /// Whether to show the chips, given the platform default.
  ///
  /// The customer's explicit choice WINS, in both directions — that is what
  /// makes it their setting rather than a suggestion. Once set it is sticky:
  /// a later admin change does not quietly reverse a decision they made.
  bool quickSuggestionsVisible(bool adminDefault) =>
      quickSuggestions ?? adminDefault;

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
    // REMOVE rather than write a bool when there is no choice, so "never
    // chosen" survives a save of the other settings. Writing `false` here
    // would silently convert every untouched user into an explicit opt-out
    // the first time they changed their text size.
    final choice = quickSuggestions;
    if (choice == null) {
      await prefs.remove('${_prefix}quick_suggestions');
    } else {
      await prefs.setBool('${_prefix}quick_suggestions', choice);
    }
  }

  static Future<AiChatSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    return AiChatSettings(
      responseStyle: prefs.getString('${_prefix}response_style') ?? 'balanced',
      textSize: prefs.getString('${_prefix}text_size') ?? 'medium',
      showTimestamps: prefs.getBool('${_prefix}show_timestamps') ?? true,
      emojiUsage: prefs.getBool('${_prefix}emoji_usage') ?? true,
      // No `?? true`: absent MEANS absent, and the admin default decides.
      quickSuggestions: prefs.getBool('${_prefix}quick_suggestions'),
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

  /// Scannable QR payload — see ChatQrCard.
  final Map<String, dynamic>? qrCard;
  final Map<String, dynamic>? pinPrompt;

  /// `recipient_card` — the confirmed transfer counterparty, rendered with
  /// their avatar instead of a line of prose.
  final Map<String, dynamic>? recipientCard;

  /// `analytics_card` — period totals plus chart series, so "how am I doing?"
  /// renders as charts rather than a paragraph of figures.
  final Map<String, dynamic>? analyticsCard;

  /// The server's id for this message, so a thumbs-up can name the answer it
  /// is about. Null for anything the server has not persisted.
  final int? serverMessageId;

  /// The thumb this answer already carries from the server: 'up', 'down', or
  /// null. Lets a rating survive a reload instead of resetting to neutral.
  final String? rating;

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
    this.qrCard,
    this.pinPrompt,
    this.recipientCard,
    this.analyticsCard,
    this.serverMessageId,
    this.rating,
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
      recipientCard: entity.recipientCard,
      receiptCard: entity.receiptCard,
      qrCard: entity.qrCard,
      pinPrompt: entity.pinPrompt,
      analyticsCard: entity.analyticsCard,
      serverMessageId: entity.serverMessageId,
      rating: entity.rating,
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
        size.width,
        size.height * 0.05,
        size.width * 0.75,
        size.height,
      );
      path.quadraticBezierTo(
        size.width * 0.12,
        size.height * 0.85,
        0,
        0,
      );
    } else {
      // Left-side tail (mirrored)
      path.moveTo(size.width, 0);
      path.lineTo(size.width * 0.65, 0);
      path.quadraticBezierTo(
        0,
        size.height * 0.05,
        size.width * 0.25,
        size.height,
      );
      path.quadraticBezierTo(
        size.width * 0.88,
        size.height * 0.85,
        size.width,
        0,
      );
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant BubbleTailPainter oldDelegate) =>
      color != oldDelegate.color || isUser != oldDelegate.isUser;
}
