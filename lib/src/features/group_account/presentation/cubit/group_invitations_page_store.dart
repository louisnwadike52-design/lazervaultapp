import 'package:lazervault/core/cache/session_page_store.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';

/// The last "my invitations" answer, per user and per query shape, so the
/// Group Funds Invites tab (and its badge) paints from the last answer on
/// open — the groups list already does this from [GroupFundsPageCache]; this
/// gives invitations the same head start, disk mirror included.
class GroupInvitationsPageStore {
  GroupInvitationsPageStore._();

  static final SessionPageStore<GroupInvitation> store =
      SessionPageStore<GroupInvitation>(
    'group_invitations',
    toJson: encode,
    fromJson: decode,
  );

  /// Scope by the filter the request was made with: a pending-only page must
  /// never be painted as the answer to an all-statuses request.
  static String scope(List<GroupInvitationStatus> statuses, int limit) =>
      '${statuses.map((s) => s.name).join(',')}:$limit';

  static Map<String, dynamic> encode(GroupInvitation i) => {
        'id': i.id,
        'group_id': i.groupId,
        'invitee_user_id': i.inviteeUserId,
        'inviter_user_id': i.inviterUserId,
        'role': i.role,
        'status': i.status.name,
        'invited_at': i.invitedAt.toIso8601String(),
        'decided_at': i.decidedAt?.toIso8601String(),
        'expires_at': i.expiresAt.toIso8601String(),
        'message': i.message,
        'group_name': i.groupName,
        'group_description': i.groupDescription,
        'inviter_name': i.inviterName,
      };

  static GroupInvitation decode(Map<String, dynamic> j) => GroupInvitation(
        id: j['id'] as String? ?? '',
        groupId: j['group_id'] as String? ?? '',
        inviteeUserId: j['invitee_user_id'] as String? ?? '',
        inviterUserId: j['inviter_user_id'] as String? ?? '',
        role: j['role'] as String? ?? '',
        status: GroupInvitationStatus.fromString(j['status'] as String?),
        invitedAt: _date(j['invited_at']) ?? DateTime.now(),
        decidedAt: _date(j['decided_at']),
        expiresAt: _date(j['expires_at']) ?? DateTime.now(),
        message: j['message'] as String? ?? '',
        groupName: j['group_name'] as String? ?? '',
        groupDescription: j['group_description'] as String? ?? '',
        inviterName: j['inviter_name'] as String? ?? '',
      );

  static DateTime? _date(Object? v) =>
      v is String ? DateTime.tryParse(v) : null;
}
