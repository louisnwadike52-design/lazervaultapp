import '../../domain/entities/group_entities.dart';
part 'group_account_models_contribution.dart';
part 'group_account_models_payout.dart';


/// Parses a payment-status JSON value into the [PaymentStatus] enum,
/// accepting both the dart enum-name (e.g. "awaitingVerification") and
/// the canonical snake-case server value ("awaiting_verification"). The
/// snake-case form is what the backend's GORM column stores.
///
/// Money-safety note: unknown values fall back to `pending` (the safest
/// in-flight state), but every known status — including the ones that
/// indicate a user-impacting condition (refunding / manual_review) — must
/// be mapped explicitly so the UI can render the right messaging. NEVER
/// silently coerce these to a friendlier-but-wrong status like completed.
PaymentStatus _parsePaymentStatus(dynamic raw) {
  if (raw is! String) return PaymentStatus.pending;
  switch (raw) {
    case 'pending':
    case 'PaymentStatus.pending':
      return PaymentStatus.pending;
    case 'processing':
    case 'PaymentStatus.processing':
      return PaymentStatus.processing;
    case 'awaiting_verification':
    case 'awaitingVerification':
    case 'PaymentStatus.awaitingVerification':
      return PaymentStatus.awaitingVerification;
    case 'completed':
    case 'PaymentStatus.completed':
      return PaymentStatus.completed;
    case 'failed':
    case 'PaymentStatus.failed':
      return PaymentStatus.failed;
    case 'cancelled':
    case 'PaymentStatus.cancelled':
      return PaymentStatus.cancelled;
    case 'refunding':
    case 'PaymentStatus.refunding':
      return PaymentStatus.refunding;
    case 'refunded':
    case 'PaymentStatus.refunded':
      return PaymentStatus.refunded;
    case 'manual_review':
    case 'manualReview':
    case 'PaymentStatus.manualReview':
      return PaymentStatus.manualReview;
    default:
      return PaymentStatus.pending;
  }
}

// Group Account Model
class GroupAccountModel extends GroupAccount {
  const GroupAccountModel({
    required super.id,
    required super.name,
    required super.description,
    required super.adminId,
    required super.members,
    required super.contributions,
    required super.createdAt,
    required super.updatedAt,
    required super.status,
    super.metadata,
    super.visibility,
    super.memberCount,
    super.totalRaised,
    super.imageUrl,
    super.contributionCount,
    super.isMember,
  });

  factory GroupAccountModel.fromJson(Map<String, dynamic> json) {
    return GroupAccountModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      adminId: json['adminId'] as String,
      members: (json['members'] as List<dynamic>?)
              ?.map((x) => GroupMemberModel.fromJson(x as Map<String, dynamic>))
              .toList() ??
          [],
      contributions: (json['contributions'] as List<dynamic>?)
              ?.map((x) => ContributionModel.fromJson(x as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      status: GroupAccountStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => GroupAccountStatus.active,
      ),
      metadata: json['metadata'] as Map<String, dynamic>?,
      visibility: json['visibility'] != null
          ? GroupVisibility.values.firstWhere(
              (e) => e.toString().split('.').last == json['visibility'],
              orElse: () => GroupVisibility.private,
            )
          : GroupVisibility.private,
      memberCount: json['memberCount'] as int? ?? 0,
      totalRaised: json['totalRaised'] != null
          ? (json['totalRaised'] as num).toDouble()
          : 0.0,
      imageUrl: json['imageUrl'] as String?,
      contributionCount: json['contributionCount'] as int? ?? 0,
      isMember: json['isMember'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'adminId': adminId,
      'members': members.map((x) => (x as GroupMemberModel).toJson()).toList(),
      'contributions': contributions.map((x) => (x as ContributionModel).toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'status': status.toString().split('.').last,
      'metadata': metadata,
      'visibility': visibility.toString().split('.').last,
      'memberCount': memberCount,
      'totalRaised': totalRaised,
      'imageUrl': imageUrl,
      'contributionCount': contributionCount,
      'isMember': isMember,
    };
  }

  factory GroupAccountModel.fromEntity(GroupAccount entity) {
    return GroupAccountModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      adminId: entity.adminId,
      members: entity.members,
      contributions: entity.contributions,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      status: entity.status,
      metadata: entity.metadata,
      visibility: entity.visibility,
      memberCount: entity.memberCount,
      totalRaised: entity.totalRaised,
      imageUrl: entity.imageUrl,
      contributionCount: entity.contributionCount,
      isMember: entity.isMember,
    );
  }

  @override
  GroupAccountModel copyWith({
    String? id,
    String? name,
    String? description,
    String? adminId,
    List<GroupMember>? members,
    List<Contribution>? contributions,
    DateTime? createdAt,
    DateTime? updatedAt,
    GroupAccountStatus? status,
    Map<String, dynamic>? metadata,
    GroupVisibility? visibility,
    int? memberCount,
    double? totalRaised,
    String? imageUrl,
    int? contributionCount,
    bool? isMember,
  }) {
    return GroupAccountModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      adminId: adminId ?? this.adminId,
      members: members ?? this.members,
      contributions: contributions ?? this.contributions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      metadata: metadata ?? this.metadata,
      visibility: visibility ?? this.visibility,
      memberCount: memberCount ?? this.memberCount,
      totalRaised: totalRaised ?? this.totalRaised,
      imageUrl: imageUrl ?? this.imageUrl,
      contributionCount: contributionCount ?? this.contributionCount,
      isMember: isMember ?? this.isMember,
    );
  }
}

// Group Member Model
class GroupMemberModel extends GroupMember {
  const GroupMemberModel({
    required super.id,
    required super.userId,
    required super.userName,
    required super.email,
    super.profileImage,
    required super.role,
    required super.joinedAt,
    required super.status,
    super.permissions,
    super.phoneNumber,
    super.isPartial = false,
    super.userUsername,
    super.emailMatchesSearchQuery = false,
    super.phoneMatchesSearchQueryExact = false,
  });

  factory GroupMemberModel.fromJson(Map<String, dynamic> json) {
    return GroupMemberModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      profileImage: json['profileImage'] as String?,
      role: GroupMemberRole.values.firstWhere(
        (e) => e.toString().split('.').last == json['role'],
        orElse: () => GroupMemberRole.member,
      ),
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      status: GroupMemberStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => GroupMemberStatus.active,
      ),
      permissions: json['permissions'] as Map<String, dynamic>?,
      phoneNumber: json['phoneNumber'] as String?,
      isPartial: json['isPartial'] as bool? ?? false,
      userUsername: json['userUsername'] as String?,
      emailMatchesSearchQuery: json['emailMatchesSearchQuery'] as bool? ?? false,
      phoneMatchesSearchQueryExact:
          json['phoneMatchesSearchQueryExact'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'email': email,
      'profileImage': profileImage,
      'role': role.toString().split('.').last,
      'joinedAt': joinedAt.toIso8601String(),
      'status': status.toString().split('.').last,
      'permissions': permissions,
      'phoneNumber': phoneNumber,
      'isPartial': isPartial,
      'userUsername': userUsername,
      'emailMatchesSearchQuery': emailMatchesSearchQuery,
      'phoneMatchesSearchQueryExact': phoneMatchesSearchQueryExact,
    };
  }

  factory GroupMemberModel.fromEntity(GroupMember entity) {
    return GroupMemberModel(
      id: entity.id,
      userId: entity.userId,
      userName: entity.userName,
      email: entity.email,
      profileImage: entity.profileImage,
      role: entity.role,
      joinedAt: entity.joinedAt,
      status: entity.status,
      permissions: entity.permissions,
      phoneNumber: entity.phoneNumber,
      isPartial: entity.isPartial,
      userUsername: entity.userUsername,
      emailMatchesSearchQuery: entity.emailMatchesSearchQuery,
      phoneMatchesSearchQueryExact: entity.phoneMatchesSearchQueryExact,
    );
  }

  @override
  GroupMemberModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? email,
    String? profileImage,
    GroupMemberRole? role,
    DateTime? joinedAt,
    GroupMemberStatus? status,
    Map<String, dynamic>? permissions,
    String? phoneNumber,
    bool? isPartial,
    String? userUsername,
    bool? emailMatchesSearchQuery,
    bool? phoneMatchesSearchQueryExact,
  }) {
    return GroupMemberModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      status: status ?? this.status,
      permissions: permissions ?? this.permissions,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isPartial: isPartial ?? this.isPartial,
      userUsername: userUsername ?? this.userUsername,
      emailMatchesSearchQuery:
          emailMatchesSearchQuery ?? this.emailMatchesSearchQuery,
      phoneMatchesSearchQueryExact:
          phoneMatchesSearchQueryExact ?? this.phoneMatchesSearchQueryExact,
    );
  }
}

// MemberExitPreview / MemberExitResult are domain entities, defined
// in domain/entities/group_entities.dart and used directly by the
// data source — no data-model wrapper needed since the shape is a
// simple value type with no JSON / extra logic. 