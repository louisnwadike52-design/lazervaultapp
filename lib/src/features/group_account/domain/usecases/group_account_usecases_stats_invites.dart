part of 'group_account_usecases.dart';

// Statistics Use Cases
class GetGroupStatistics extends UseCase<Map<String, dynamic>, String> {
  final GroupAccountRepository repository;

  GetGroupStatistics(this.repository);

  @override
  Future<Map<String, dynamic>> call(String groupId) {
    return repository.getGroupStatistics(groupId);
  }
}

class GetUserContributionStats extends UseCase<Map<String, dynamic>, String> {
  final GroupAccountRepository repository;

  GetUserContributionStats(this.repository);

  @override
  Future<Map<String, dynamic>> call(String userId) {
    return repository.getUserContributionStats(userId);
  }
}

// Activity Log Use Cases
class GetGroupActivityLogs extends UseCase<List<ActivityLogEntry>, String> {
  final GroupAccountRepository repository;

  GetGroupActivityLogs(this.repository);

  @override
  Future<List<ActivityLogEntry>> call(String groupId) {
    return repository.getGroupActivityLogs(groupId);
  }
}

class GetContributionActivityLogs extends UseCase<List<ActivityLogEntry>, String> {
  final GroupAccountRepository repository;

  GetContributionActivityLogs(this.repository);

  @override
  Future<List<ActivityLogEntry>> call(String contributionId) {
    return repository.getContributionActivityLogs(contributionId);
  }
}

 

// =====================================================================
// Invite-first membership use cases (slice 5)
// =====================================================================

class InviteToGroupParams {
  final String groupId;
  final String inviteeUserId;
  final String? role;
  final String? message;
  const InviteToGroupParams({
    required this.groupId,
    required this.inviteeUserId,
    this.role,
    this.message,
  });
}

class InviteToGroup extends UseCase<GroupInvitation, InviteToGroupParams> {
  final GroupAccountRepository repository;
  InviteToGroup(this.repository);
  @override
  Future<GroupInvitation> call(InviteToGroupParams p) {
    return repository.inviteToGroup(
      groupId: p.groupId,
      inviteeUserId: p.inviteeUserId,
      role: p.role,
      message: p.message,
    );
  }
}

class RespondToGroupInviteParams {
  final String invitationId;
  final bool accept;
  const RespondToGroupInviteParams({
    required this.invitationId,
    required this.accept,
  });
}

class RespondToGroupInvite extends UseCase<GroupInvitation, RespondToGroupInviteParams> {
  final GroupAccountRepository repository;
  RespondToGroupInvite(this.repository);
  @override
  Future<GroupInvitation> call(RespondToGroupInviteParams p) {
    return repository.respondToGroupInvite(
      invitationId: p.invitationId,
      accept: p.accept,
    );
  }
}

class CancelGroupInvite extends UseCase<void, String> {
  final GroupAccountRepository repository;
  CancelGroupInvite(this.repository);
  @override
  Future<void> call(String invitationId) {
    return repository.cancelGroupInvite(invitationId: invitationId);
  }
}

class ListMyInvitationsParams {
  final List<GroupInvitationStatus>? statuses;
  final int limit;
  const ListMyInvitationsParams({this.statuses, this.limit = 50});
}

class ListMyInvitations extends UseCase<List<GroupInvitation>, ListMyInvitationsParams> {
  final GroupAccountRepository repository;
  ListMyInvitations(this.repository);
  @override
  Future<List<GroupInvitation>> call(ListMyInvitationsParams p) {
    return repository.listMyInvitations(statuses: p.statuses, limit: p.limit);
  }
}

class ListGroupInvitationsParams {
  final String groupId;
  final List<GroupInvitationStatus>? statuses;
  final int limit;
  const ListGroupInvitationsParams({
    required this.groupId,
    this.statuses,
    this.limit = 100,
  });
}

class ListGroupInvitations extends UseCase<List<GroupInvitation>, ListGroupInvitationsParams> {
  final GroupAccountRepository repository;
  ListGroupInvitations(this.repository);
  @override
  Future<List<GroupInvitation>> call(ListGroupInvitationsParams p) {
    return repository.listGroupInvitations(
      groupId: p.groupId,
      statuses: p.statuses,
      limit: p.limit,
    );
  }
}
