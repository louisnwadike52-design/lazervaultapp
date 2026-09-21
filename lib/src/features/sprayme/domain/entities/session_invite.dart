import 'package:lazervault/src/features/sprayme/domain/entities/spray_session.dart';

/// One person tagged into a session.
class SessionInvite {
  final String sessionId;
  final String inviteeUserId;
  final String inviteeName;
  final String inviterUserId;
  final String inviterName;

  /// `pending` | `accepted` | `declined`.
  ///
  /// A plain lower-case string on the wire, deliberately — this surface has
  /// shipped proto-enum `.String()` leaks three times, emitting constant names
  /// like `SESSION_STATUS_ACTIVE` to an app comparing short forms. Normalised
  /// here anyway, so a future leak degrades to `pending` rather than to a status
  /// nothing matches.
  final String status;

  final DateTime? createdAt;
  final DateTime? respondedAt;

  const SessionInvite({
    required this.sessionId,
    required this.inviteeUserId,
    this.inviteeName = '',
    this.inviterUserId = '',
    this.inviterName = '',
    this.status = 'pending',
    this.createdAt,
    this.respondedAt,
  });

  bool get isPending => status == 'pending';
  bool get isAccepted => status == 'accepted';

  static String normalizeStatus(String? raw) {
    var s = (raw ?? '').trim();
    if (s.isEmpty) return 'pending';
    s = s.toUpperCase();
    const prefix = 'INVITE_STATUS_';
    if (s.startsWith(prefix)) s = s.substring(prefix.length);
    if (s == 'UNSPECIFIED') return 'pending';
    return s.toLowerCase();
  }

  factory SessionInvite.fromJson(Map<String, dynamic> json) => SessionInvite(
        sessionId: json['session_id'] as String? ?? '',
        inviteeUserId: json['invitee_user_id'] as String? ?? '',
        inviteeName: json['invitee_name'] as String? ?? '',
        inviterUserId: json['inviter_user_id'] as String? ?? '',
        inviterName: json['inviter_name'] as String? ?? '',
        status: normalizeStatus(json['status'] as String?),
        createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
        respondedAt: DateTime.tryParse(json['responded_at'] as String? ?? ''),
      );
}

/// A session the user was tagged into, with who tagged them.
///
/// Wraps rather than extends [SpraySession] so the invite fields cannot be
/// mistaken for session fields by anything that already handles sessions.
class InvitedSession {
  final SpraySession session;
  final String inviteStatus;
  final String inviterName;
  final String inviterUserId;
  final DateTime? invitedAt;

  const InvitedSession({
    required this.session,
    this.inviteStatus = 'pending',
    this.inviterName = '',
    this.inviterUserId = '',
    this.invitedAt,
  });

  /// Whether this invite can still be acted on — the session is live AND the
  /// user has not already joined.
  bool get isActionable => session.isActive && inviteStatus == 'pending';

  factory InvitedSession.fromJson(Map<String, dynamic> json) => InvitedSession(
        // The gateway FLATTENS the invite fields onto the session object, so
        // the same map is both.
        session: SpraySession.fromJson(json),
        inviteStatus: SessionInvite.normalizeStatus(
          json['invite_status'] as String?,
        ),
        inviterName: json['inviter_name'] as String? ?? '',
        inviterUserId: json['inviter_user_id'] as String? ?? '',
        invitedAt: DateTime.tryParse(json['invited_at'] as String? ?? ''),
      );
}

/// One person being tagged, as the picker hands them over.
///
/// A named type rather than a record so the two string fields cannot be passed
/// the wrong way round — `(userId, name)` and `(name, userId)` are the same
/// shape to the compiler, and the failure would be a silent invite to nobody.
class SprayInvitee {
  final String userId;
  final String name;

  const SprayInvitee({required this.userId, required this.name});
}

/// What a tagging request produced.
class InviteResult {
  final List<SessionInvite> invited;

  /// People who were already tagged. Reported so the UI can say "3 tagged, 2
  /// already tagged" instead of silently showing fewer than were selected.
  final int alreadyInvited;

  const InviteResult({this.invited = const [], this.alreadyInvited = 0});
}
