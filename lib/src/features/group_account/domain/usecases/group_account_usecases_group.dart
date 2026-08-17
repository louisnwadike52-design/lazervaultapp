part of 'group_account_usecases.dart';

// Group Account Use Cases
class GetUserGroups extends UseCase<List<GroupAccount>, String> {
  final GroupAccountRepository repository;

  GetUserGroups(this.repository);

  @override
  Future<List<GroupAccount>> call(String userId) {
    return repository.getUserGroups(userId);
  }
}

class GetGroupById extends UseCase<GroupAccount, String> {
  final GroupAccountRepository repository;

  GetGroupById(this.repository);

  @override
  Future<GroupAccount> call(String groupId) {
    return repository.getGroupById(groupId);
  }
}

class CreateGroup extends UseCase<GroupAccount, CreateGroupParams> {
  final GroupAccountRepository repository;

  CreateGroup(this.repository);

  @override
  Future<GroupAccount> call(CreateGroupParams params) {
    return repository.createGroup(
      name: params.name,
      description: params.description,
      adminId: params.adminId,
      metadata: params.metadata,
      visibility: params.visibility,
      imageUrl: params.imageUrl,
    );
  }
}

class UpdateGroup extends UseCase<GroupAccount, GroupAccount> {
  final GroupAccountRepository repository;

  UpdateGroup(this.repository);

  @override
  Future<GroupAccount> call(GroupAccount group) {
    return repository.updateGroup(group);
  }
}

class DeleteGroup extends UseCase<void, String> {
  final GroupAccountRepository repository;

  DeleteGroup(this.repository);

  @override
  Future<void> call(String groupId) {
    return repository.deleteGroup(groupId);
  }
}

// Group Member Use Cases
class GetGroupMembers extends UseCase<List<GroupMember>, String> {
  final GroupAccountRepository repository;

  GetGroupMembers(this.repository);

  @override
  Future<List<GroupMember>> call(String groupId) {
    return repository.getGroupMembers(groupId);
  }
}

class AddMemberToGroup extends UseCase<GroupMember, AddMemberParams> {
  final GroupAccountRepository repository;

  AddMemberToGroup(this.repository);

  @override
  Future<GroupMember> call(AddMemberParams params) {
    return repository.addMemberToGroup(
      groupId: params.groupId,
      userId: params.userId,
      userName: params.userName,
      email: params.email,
      profileImage: params.profileImage,
      username: params.username,
      role: params.role,
    );
  }
}

class UpdateMemberRole extends UseCase<GroupMember, UpdateMemberRoleParams> {
  final GroupAccountRepository repository;

  UpdateMemberRole(this.repository);

  @override
  Future<GroupMember> call(UpdateMemberRoleParams params) {
    return repository.updateMemberRole(
      groupId: params.groupId,
      memberId: params.memberId,
      newRole: params.newRole,
    );
  }
}

class RemoveMemberFromGroup extends UseCase<void, RemoveMemberParams> {
  final GroupAccountRepository repository;

  RemoveMemberFromGroup(this.repository);

  @override
  Future<void> call(RemoveMemberParams params) {
    return repository.removeMemberFromGroup(
      groupId: params.groupId,
      memberId: params.memberId,
    );
  }
}

class SearchUsers extends UseCase<List<GroupMember>, String> {
  final GroupAccountRepository repository;

  SearchUsers(this.repository);

  @override
  Future<List<GroupMember>> call(String query) {
    return repository.searchUsers(query);
  }
}

// Parameter classes
class CreateGroupParams {
  final String name;
  final String description;
  final String adminId;
  final Map<String, dynamic>? metadata;
  final GroupVisibility? visibility;
  final String? imageUrl;

  CreateGroupParams({
    required this.name,
    required this.description,
    required this.adminId,
    this.metadata,
    this.visibility,
    this.imageUrl,
  });
}

class AddMemberParams {
  final String groupId;
  final String userId;
  final String userName;
  final String email;
  final String? profileImage;
  final String? username;  // LazerTag username for user lookup
  final GroupMemberRole role;

  AddMemberParams({
    required this.groupId,
    required this.userId,
    required this.userName,
    required this.email,
    this.profileImage,
    this.username,
    this.role = GroupMemberRole.member,
  });
}

class UpdateMemberRoleParams {
  final String groupId;
  final String memberId;
  final GroupMemberRole newRole;

  UpdateMemberRoleParams({
    required this.groupId,
    required this.memberId,
    required this.newRole,
  });
}

class RemoveMemberParams {
  final String groupId;
  final String memberId;

  RemoveMemberParams({
    required this.groupId,
    required this.memberId,
  });
}

// Public Group Discovery Use Cases
class ListPublicGroups {
  final GroupAccountRepository repository;

  ListPublicGroups(this.repository);

  Future<List<GroupAccount>> call({
    int page = 1,
    int pageSize = 20,
    String? sortBy,
    String? searchQuery,
  }) {
    return repository.listPublicGroups(
      page: page,
      pageSize: pageSize,
      sortBy: sortBy,
      searchQuery: searchQuery,
    );
  }
}

class GetPublicGroup {
  final GroupAccountRepository repository;

  GetPublicGroup(this.repository);

  Future<PublicGroupDetail> call(String groupId) {
    return repository.getPublicGroup(groupId);
  }
}

class JoinPublicGroup {
  final GroupAccountRepository repository;

  JoinPublicGroup(this.repository);

  Future<GroupAccount> call(String groupId) {
    return repository.joinPublicGroup(groupId);
  }
}
