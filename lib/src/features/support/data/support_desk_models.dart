/// THE IN-APP SUPPORT DESK's own models.
///
/// Separate from [SupportTicket] on purpose. The customer's model answers "what
/// is MY ticket doing"; the desk's answers "whose ticket is this, and is
/// anybody waiting on me" — `user_name`, `user_email` and `unread_for_admin`
/// are fields the customer's view has no business carrying, and an agent
/// working a queue cannot work without.
library;

/// Whether this signed-in person may use the desk, and whether they want it to
/// notify them.
class DeskAccess {
  /// The authority, as the server resolved it from the role claim. The app
  /// renders no desk unless this is true — though hiding the UI is never the
  /// control: every desk request is re-checked server-side.
  final bool canUse;

  /// This agent's own notification switch. Being entitled to the desk and not
  /// wanting a buzz for every ticket are different things, and the alternative
  /// to this switch is giving up the desk.
  final bool pushEnabled;

  /// Why not, when [canUse] is false — so a desk that fails to appear is
  /// diagnosable from the app rather than from a server log.
  final String reason;

  const DeskAccess({
    this.canUse = false,
    this.pushEnabled = false,
    this.reason = '',
  });

  /// Deliberately fails CLOSED. An unreadable or malformed answer means no
  /// desk: showing admin UI because a response could not be parsed is the one
  /// outcome worth ruling out by construction.
  factory DeskAccess.fromJson(Map<String, dynamic> j) => DeskAccess(
        canUse: j['can_use'] == true,
        pushEnabled: j['push_enabled'] == true,
        reason: (j['reason'] ?? '').toString(),
      );

  static const none = DeskAccess();
}

/// One ticket as the QUEUE needs it.
class DeskTicket {
  final String id;
  final String ticketNumber;
  final String subject;
  final String category;
  final String status;
  final String priority;
  final String kind;

  /// Who is waiting. The queue is unusable without a name against each row.
  final String userName;
  final String userEmail;

  /// How the ticket was raised: "app", "email", or "pre_auth".
  ///
  /// PRE_AUTH CHANGES WHERE A REPLY GOES. Those threads are raised by
  /// somebody who could not sign in, so they are parked under a sentinel
  /// owner — which means there is no device to push to and no in-app thread
  /// the customer can open. The address on the ticket is the only way to
  /// reach them, and it is UNVERIFIED: typed by whoever was holding the
  /// phone, never checked. A responder has to know both facts before they
  /// answer, which is what [repliesGoToEmailOnly] and the badge are for.
  final String channel;

  /// True when the only route to this customer is the email on the ticket.
  bool get repliesGoToEmailOnly =>
      channel.trim().toLowerCase() == 'pre_auth' && userEmail.trim().isNotEmpty;

  /// True when the ticket says it is pre-auth but carries no address at all —
  /// nothing can reach them, and a responder must not be told otherwise.
  bool get hasNoWayToReply =>
      channel.trim().toLowerCase() == 'pre_auth' && userEmail.trim().isEmpty;

  /// Messages this agent has not read. The count that decides what to open
  /// next — `unread_for_user` is the customer's side and means nothing here.
  final int unreadForAdmin;

  final DateTime? lastMessageAt;
  final bool assigned;

  /// "" or "technical". A SECOND AXIS, not a status: a ticket with
  /// engineering is still open and may still be waiting on the customer.
  final String escalationTier;

  /// What support said was wrong, in their words. Shown to the technical team
  /// at the top of the thread — the customer's own description is the text the
  /// agent already decided was not enough to act on.
  final String escalationNote;

  final String escalatedByName;
  final DateTime? escalatedAt;

  const DeskTicket({
    required this.id,
    required this.ticketNumber,
    required this.subject,
    required this.category,
    required this.status,
    required this.priority,
    required this.kind,
    required this.userName,
    required this.userEmail,
    this.channel = 'app',
    required this.unreadForAdmin,
    required this.assigned,
    this.lastMessageAt,
    this.escalationTier = '',
    this.escalationNote = '',
    this.escalatedByName = '',
    this.escalatedAt,
  });

  factory DeskTicket.fromJson(Map<String, dynamic> j) {
    int asInt(Object? v) =>
        v is int ? v : int.tryParse('${v ?? ''}') ?? 0;
    return DeskTicket(
      id: (j['id'] ?? '').toString(),
      ticketNumber: (j['ticket_number'] ?? '').toString(),
      subject: (j['subject'] ?? '').toString(),
      category: (j['category'] ?? 'general').toString(),
      status: (j['status'] ?? 'open').toString(),
      priority: (j['priority'] ?? 'medium').toString(),
      kind: (j['kind'] ?? 'chat').toString(),
      userName: (j['user_name'] ?? '').toString(),
      userEmail: (j['user_email'] ?? '').toString(),
      channel: (j['channel'] ?? 'app').toString(),
      unreadForAdmin: asInt(j['unread_for_admin']),
      assigned: (j['assigned_admin_id'] ?? '').toString().isNotEmpty,
      lastMessageAt: DateTime.tryParse('${j['last_message_at'] ?? ''}'),
      escalationTier: (j['escalation_tier'] ?? '').toString(),
      escalationNote: (j['escalation_note'] ?? '').toString(),
      escalatedByName: (j['escalated_by_name'] ?? '').toString(),
      escalatedAt: DateTime.tryParse('${j['escalated_at'] ?? ''}'),
    );
  }

  /// With the technical team right now.
  bool get isEscalated => escalationTier.trim().isNotEmpty;

  bool get isClosed => status == 'resolved' || status == 'closed';

  /// What to show when a customer never set a subject — every chat ticket.
  /// Falling back to the ticket number keeps each row identifiable instead of
  /// rendering a column of blanks.
  String get title {
    final s = subject.trim();
    if (s.isNotEmpty) return s;
    final c = category.trim();
    if (c.isNotEmpty && c != 'general') return 'About $c';
    return ticketNumber.isNotEmpty ? ticketNumber : 'Support chat';
  }

  /// The person, however much of them the server knew.
  String get who {
    final n = userName.trim();
    if (n.isNotEmpty) return n;
    final e = userEmail.trim();
    return e.isNotEmpty ? e : 'Customer';
  }
}

/// A suggested reply, and how much to trust it.
///
/// NOT A MESSAGE. Nothing here has been sent or stored; it exists so a
/// responder can start from something rather than a blank box on a thumb
/// keyboard. It reaches the thread only when they post it through
/// [SupportDeskApi.reply], the same way a typed reply does.
class DeskDraft {
  const DeskDraft({
    required this.draft,
    required this.confident,
    this.note = '',
    this.usedKnowledge = false,
    this.answeredMessageId = '',
  });

  /// The suggested text. May be empty when the assistant declined, in which
  /// case [note] says why.
  final String draft;

  /// The assistant's own view on whether this was safe to send unreviewed.
  /// Shown as a caution, never used to withhold — the responder is the
  /// reviewer, and hiding a draft they asked for helps nobody.
  final bool confident;

  /// The reservation or the failure. Staff-facing, never customer-facing.
  final String note;

  /// Whether our own knowledge base contributed. A responder who cannot tell
  /// a grounded answer from a general one will eventually send one.
  final bool usedKnowledge;

  /// Which message this answers. Echoed back because when no message was
  /// selected the server picks the newest customer line itself, and the
  /// responder should see which question was answered rather than infer it.
  final String answeredMessageId;

  factory DeskDraft.fromJson(Map<String, dynamic> j) => DeskDraft(
        draft: (j['draft'] ?? '').toString(),
        confident: j['confident'] == true,
        note: (j['note'] ?? '').toString(),
        usedKnowledge: j['used_knowledge'] == true,
        answeredMessageId: (j['answered_message_id'] ?? '').toString(),
      );
}
