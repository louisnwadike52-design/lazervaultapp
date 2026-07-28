/// A single user's reaction to a message (WhatsApp-style, one per user).
class P2PReaction {
  final String userId;
  final String emoji;
  const P2PReaction({required this.userId, required this.emoji});

  factory P2PReaction.fromJson(Map<String, dynamic> j) => P2PReaction(
        userId: (j['user_id'] ?? '').toString(),
        emoji: (j['emoji'] ?? '').toString(),
      );
  Map<String, dynamic> toJson() => {'user_id': userId, 'emoji': emoji};
}

class P2PMessageEntity {
  final String id;
  final String conversationId;
  final String senderId;
  final String messageType; // text, transfer_sent, transfer_received, transfer_request, system, image, voice
  final String? content;
  final String? mediaUrl; // Storage object URL for image/voice messages
  final String? mediaType; // 'image' | 'voice'
  final String? localMediaPath; // Local file path for optimistic preview before upload completes
  final String? transferRef;
  final int? transferAmount; // Minor units (kobo)
  final String? transferCurrency;
  final String? transferStatus;
  final String deliveryStatus; // sending, sent, delivered, read, failed
  final String? clientMessageId;
  final DateTime createdAt;

  // --- Reply threading (WhatsApp-style quote) ---
  final String? replyToMessageId;
  final String? replyToContent; // denormalized snippet of the quoted message
  final String? replyToSenderId;

  // --- Edit ---
  final DateTime? editedAt; // non-null ⇒ show an "edited" marker

  // --- Reactions (at most one per user) ---
  final List<P2PReaction> reactions;

  // --- Forwarding (WhatsApp-style) ---
  final bool forwarded; // true ⇒ show a "Forwarded" label

  const P2PMessageEntity({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.messageType,
    this.content,
    this.mediaUrl,
    this.mediaType,
    this.localMediaPath,
    this.transferRef,
    this.transferAmount,
    this.transferCurrency,
    this.transferStatus,
    required this.deliveryStatus,
    this.clientMessageId,
    required this.createdAt,
    this.replyToMessageId,
    this.replyToContent,
    this.replyToSenderId,
    this.editedAt,
    this.reactions = const [],
    this.forwarded = false,
  });

  bool get isEdited => editedAt != null;
  bool get hasReply => replyToMessageId != null && replyToMessageId!.isNotEmpty;

  bool get isText => messageType == 'text';
  bool get isTransferGeneric => messageType == 'transfer';
  bool get isTransferSent => messageType == 'transfer_sent';
  bool get isTransferReceived => messageType == 'transfer_received';
  bool get isTransferRequest => messageType == 'transfer_request';
  bool get isSystem => messageType == 'system';
  bool get isImage => messageType == 'image';
  bool get isVoice => messageType == 'voice';
  bool get isMedia => isImage || isVoice;
  bool get isTransfer => isTransferGeneric || isTransferSent || isTransferReceived || isTransferRequest;

  /// Transfer amount in major units (e.g., Naira). Returns null if no amount.
  double? get transferAmountMajor =>
      transferAmount != null ? transferAmount! / 100.0 : null;

  /// Currency symbol for the transfer's currency (falls back to the code).
  String get transferCurrencySymbol {
    switch ((transferCurrency ?? 'NGN').toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'USD':
        return '\$';
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      case 'GHS':
        return 'GH₵';
      case 'KES':
        return 'KSh';
      case 'ZAR':
        return 'R';
      default:
        return '${transferCurrency ?? ''} ';
    }
  }

  /// A short, perspective-NEUTRAL snippet for a transfer used in reply quotes
  /// and the "replying to" banner (shown identically to both parties, so it
  /// carries the amount but not a direction like "you sent"). e.g. "💸 ₦5,000".
  String get transferSnippet {
    final amt = transferAmountMajor;
    if (amt == null) return '💸 Money transfer';
    final formatted = amt == amt.roundToDouble()
        ? amt.toInt().toString()
        : amt.toStringAsFixed(2);
    // Group thousands.
    final withCommas = formatted.replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');
    return '💸 $transferCurrencySymbol$withCommas';
  }

  P2PMessageEntity copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    String? messageType,
    String? content,
    String? mediaUrl,
    String? mediaType,
    String? localMediaPath,
    String? transferRef,
    int? transferAmount,
    String? transferCurrency,
    String? transferStatus,
    String? deliveryStatus,
    String? clientMessageId,
    DateTime? createdAt,
    String? replyToMessageId,
    String? replyToContent,
    String? replyToSenderId,
    DateTime? editedAt,
    List<P2PReaction>? reactions,
    bool? forwarded,
  }) {
    return P2PMessageEntity(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      messageType: messageType ?? this.messageType,
      content: content ?? this.content,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaType: mediaType ?? this.mediaType,
      localMediaPath: localMediaPath ?? this.localMediaPath,
      transferRef: transferRef ?? this.transferRef,
      transferAmount: transferAmount ?? this.transferAmount,
      transferCurrency: transferCurrency ?? this.transferCurrency,
      transferStatus: transferStatus ?? this.transferStatus,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      clientMessageId: clientMessageId ?? this.clientMessageId,
      createdAt: createdAt ?? this.createdAt,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
      replyToContent: replyToContent ?? this.replyToContent,
      replyToSenderId: replyToSenderId ?? this.replyToSenderId,
      editedAt: editedAt ?? this.editedAt,
      reactions: reactions ?? this.reactions,
      forwarded: forwarded ?? this.forwarded,
    );
  }
}
