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
      default:
        return type;
    }
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
      type: json['type'] as String? ?? '',
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
