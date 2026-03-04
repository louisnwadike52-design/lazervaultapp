class P2PMessageEntity {
  final String id;
  final String conversationId;
  final String senderId;
  final String messageType; // text, transfer_sent, transfer_received, transfer_request, system
  final String? content;
  final String? transferRef;
  final int? transferAmount; // Minor units (kobo)
  final String? transferCurrency;
  final String? transferStatus;
  final String deliveryStatus; // sending, sent, delivered, read, failed
  final String? clientMessageId;
  final DateTime createdAt;

  const P2PMessageEntity({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.messageType,
    this.content,
    this.transferRef,
    this.transferAmount,
    this.transferCurrency,
    this.transferStatus,
    required this.deliveryStatus,
    this.clientMessageId,
    required this.createdAt,
  });

  bool get isText => messageType == 'text';
  bool get isTransferSent => messageType == 'transfer_sent';
  bool get isTransferReceived => messageType == 'transfer_received';
  bool get isTransferRequest => messageType == 'transfer_request';
  bool get isSystem => messageType == 'system';
  bool get isTransfer => isTransferSent || isTransferReceived || isTransferRequest;

  /// Transfer amount in major units (e.g., Naira). Returns null if no amount.
  double? get transferAmountMajor =>
      transferAmount != null ? transferAmount! / 100.0 : null;

  P2PMessageEntity copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    String? messageType,
    String? content,
    String? transferRef,
    int? transferAmount,
    String? transferCurrency,
    String? transferStatus,
    String? deliveryStatus,
    String? clientMessageId,
    DateTime? createdAt,
  }) {
    return P2PMessageEntity(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      messageType: messageType ?? this.messageType,
      content: content ?? this.content,
      transferRef: transferRef ?? this.transferRef,
      transferAmount: transferAmount ?? this.transferAmount,
      transferCurrency: transferCurrency ?? this.transferCurrency,
      transferStatus: transferStatus ?? this.transferStatus,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      clientMessageId: clientMessageId ?? this.clientMessageId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
