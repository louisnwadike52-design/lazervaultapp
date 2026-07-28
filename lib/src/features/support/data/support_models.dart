/// Lightweight models mirroring support-service's JSON.
class SupportTicket {
  final String id;
  final String ticketNumber;
  final String kind; // chat | report
  final String category;
  final String subject;
  final String status;
  final String priority;
  final int unreadForUser;
  final DateTime? lastMessageAt;

  const SupportTicket({
    required this.id,
    required this.ticketNumber,
    required this.kind,
    required this.category,
    required this.subject,
    required this.status,
    required this.priority,
    required this.unreadForUser,
    this.lastMessageAt,
  });

  factory SupportTicket.fromJson(Map<String, dynamic> j) => SupportTicket(
        id: (j['id'] ?? '').toString(),
        ticketNumber: (j['ticket_number'] ?? '').toString(),
        kind: (j['kind'] ?? 'chat').toString(),
        category: (j['category'] ?? 'general').toString(),
        subject: (j['subject'] ?? '').toString(),
        status: (j['status'] ?? 'open').toString(),
        priority: (j['priority'] ?? 'medium').toString(),
        unreadForUser: (j['unread_for_user'] ?? 0) is int
            ? j['unread_for_user'] as int
            : int.tryParse('${j['unread_for_user']}') ?? 0,
        lastMessageAt: DateTime.tryParse('${j['last_message_at'] ?? ''}'),
      );

  bool get isClosed => status == 'resolved' || status == 'closed';
  bool get isOpen => !isClosed;
}

class SupportMessage {
  final String id;
  final String ticketId;
  final String senderType; // user | staff | system
  final String senderName;
  final String body;
  final bool viaEmail;
  final DateTime? createdAt;

  const SupportMessage({
    required this.id,
    required this.ticketId,
    required this.senderType,
    required this.senderName,
    required this.body,
    required this.viaEmail,
    this.createdAt,
  });

  bool get isStaff => senderType == 'staff';
  bool get isSystem => senderType == 'system';

  factory SupportMessage.fromJson(Map<String, dynamic> j) => SupportMessage(
        id: (j['id'] ?? '').toString(),
        ticketId: (j['ticket_id'] ?? '').toString(),
        senderType: (j['sender_type'] ?? 'user').toString(),
        senderName: (j['sender_name'] ?? '').toString(),
        body: (j['body'] ?? '').toString(),
        viaEmail: j['via_email'] == true,
        createdAt: DateTime.tryParse('${j['created_at'] ?? ''}'),
      );
}
