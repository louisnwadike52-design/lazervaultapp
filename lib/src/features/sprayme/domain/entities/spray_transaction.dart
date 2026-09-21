class SprayTransaction {
  final String id;
  final String sessionId;
  final String senderUserId;
  final String senderName;
  final String senderAvatarUrl;
  final String recipientUserId;
  final String recipientName;
  final String type;
  final String? giftId;
  final String? giftName;
  final String? giftEmoji;
  final int amount;
  final int quantity;
  final String reference;
  final String currency;
  final DateTime createdAt;

  const SprayTransaction({
    required this.id,
    this.sessionId = '',
    this.senderUserId = '',
    this.senderName = '',
    this.senderAvatarUrl = '',
    this.recipientUserId = '',
    this.recipientName = '',
    required this.type,
    this.giftId,
    this.giftName,
    this.giftEmoji,
    this.amount = 0,
    this.quantity = 1,
    this.reference = '',
    this.currency = 'NGN',
    required this.createdAt,
  });

  String get description {
    switch (type) {
      case 'gift':
        return giftName != null ? 'Sent $giftName gift' : 'Sent a gift';
      case 'money_spray':
        return 'Sprayed money';
      case 'like':
        return 'Sent a like';
      case 'fund':
        return 'Funded wallet';
      case 'withdraw':
        return 'Withdrew from wallet';
      case 'purchase':
        return 'Bought gift credit';
      default:
        // Never fall through to the raw wire value. `type` is a protobuf enum
        // name, so an unmapped case used to print "TRANSACTION_TYPE_PURCHASE"
        // straight onto a wallet row. A neutral word is a worse label but not a
        // broken one.
        return 'Lazerspray activity';
    }
  }

  /// Normalises a transaction type from the wire.
  ///
  /// lifestyle-gateway emits `t.Type.String()` — the protobuf CONSTANT NAME
  /// (`TRANSACTION_TYPE_GIFT`), not the short form this entity switches on. So
  /// every row fell to the default branch and rendered the enum name as its own
  /// description.
  ///
  /// SPRAY is mapped to `money_spray` rather than `spray` because that is the
  /// name the rest of the app already uses for the same event; renaming it here
  /// would just move the mismatch somewhere else.
  static String normalizeType(String? raw) {
    var s = (raw ?? '').trim();
    if (s.isEmpty) return '';
    s = s.toUpperCase();
    const prefix = 'TRANSACTION_TYPE_';
    if (s.startsWith(prefix)) s = s.substring(prefix.length);
    if (s == 'UNSPECIFIED') return '';
    if (s == 'SPRAY') return 'money_spray';
    return s.toLowerCase();
  }

  double get amountMajor => amount / 100;

  factory SprayTransaction.fromJson(Map<String, dynamic> json) {
    return SprayTransaction(
      id: json['id'] as String? ?? '',
      sessionId: json['session_id'] as String? ?? '',
      senderUserId: json['sender_user_id'] as String? ?? '',
      senderName: json['sender_name'] as String? ?? '',
      senderAvatarUrl: json['sender_avatar_url'] as String? ?? '',
      recipientUserId: json['recipient_user_id'] as String? ?? '',
      recipientName: json['recipient_name'] as String? ?? '',
      type: normalizeType(json['type'] as String?),
      giftId: json['gift_id'] as String?,
      giftName: json['gift_name'] as String?,
      giftEmoji: json['gift_emoji'] as String?,
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      reference: json['reference'] as String? ?? '',
      currency: json['currency'] as String? ?? 'NGN',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
