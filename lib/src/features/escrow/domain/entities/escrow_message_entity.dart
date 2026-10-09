/// One message on an escrow deal's OWN conversation.
///
/// Not the parties' general direct-message thread. Scoped to the deal so a
/// dispute has "the chat for this deal", and so an admin adjudicating one
/// transaction reads that conversation and nothing else — rather than the
/// pair's entire unrelated correspondence.
class EscrowMessageEntity {
  const EscrowMessageEntity({
    required this.id,
    required this.dealId,
    required this.senderId,
    required this.senderRole,
    required this.senderName,
    required this.body,
    required this.createdAt,
  });

  final String id;
  final String dealId;

  /// Empty for a platform message — an admin is not a party to the deal.
  final String senderId;

  /// 'buyer' | 'seller' | 'admin'. Admin is a first-class role so both
  /// parties can see that support joined the conversation, rather than a
  /// message appearing to come from the person they are in dispute with.
  final String senderRole;
  final String senderName;
  final String body;
  final DateTime? createdAt;

  bool get isFromAdmin => senderRole == 'admin';

  /// Whether the viewer wrote this. Compared on the SENDER ID, not the role:
  /// a buyer reading their own thread and a buyer reading the other side's
  /// are the same role, and aligning bubbles by role would put both parties
  /// on the same side of the screen.
  bool isMine(String viewerUserId) =>
      senderId.isNotEmpty && senderId == viewerUserId;
}
