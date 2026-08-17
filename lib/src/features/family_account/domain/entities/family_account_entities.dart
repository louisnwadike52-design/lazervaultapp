import 'package:equatable/equatable.dart';
part 'family_account_entities_widgets.dart';


// Main Entities

class FamilyAccount extends Equatable {
  final String id;
  final String creatorId;
  final String creatorName;
  final String name;
  final String? description;
  final double totalAllocatedBalance;
  final double totalPoolBalance;
  final double totalBalance;
  final bool allowMemberContributions;
  final FamilyAccountStatus status;
  final List<FamilyMember> members;
  final int memberCount;
  final int activeMemberCount;
  final FundDistributionMode fundDistributionMode;
  final bool setupCompleted;
  final bool spendingVisibilityEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;
  // Funding policy + pool virtual-account details (from the backend).
  final String fundingPolicy; // any_member | creator_only | specific_members
  final String? accountNumber; // pool NUBAN (only once provisioned/active)
  final String? bankName; // pool bank name (only once provisioned/active)
  final String? virtualAccountStatus; // processing | active | frozen
  /// Aggregated stats (funders + spenders breakdown + monthly totals) attached
  /// to GetFamilyAccount. Null on list responses.
  final FamilyAccountSummary? summary;

  const FamilyAccount({
    required this.id,
    required this.creatorId,
    required this.creatorName,
    required this.name,
    this.description,
    required this.totalAllocatedBalance,
    required this.totalPoolBalance,
    required this.totalBalance,
    required this.allowMemberContributions,
    required this.status,
    required this.members,
    required this.memberCount,
    required this.activeMemberCount,
    this.fundDistributionMode = FundDistributionMode.customAllocation,
    this.setupCompleted = false,
    this.spendingVisibilityEnabled = true,
    required this.createdAt,
    required this.updatedAt,
    this.fundingPolicy = 'any_member',
    this.accountNumber,
    this.bankName,
    this.virtualAccountStatus,
    this.summary,
  });

  /// Whether the pool's virtual account is still being provisioned (no spendable
  /// NUBAN yet). Drives the "Setting up" state on the detail screen.
  bool get isVirtualAccountProcessing => virtualAccountStatus == 'processing';

  @override
  List<Object?> get props => [
        id,
        creatorId,
        creatorName,
        name,
        description,
        totalAllocatedBalance,
        totalPoolBalance,
        totalBalance,
        allowMemberContributions,
        status,
        members,
        memberCount,
        activeMemberCount,
        fundDistributionMode,
        setupCompleted,
        spendingVisibilityEnabled,
        createdAt,
        updatedAt,
        fundingPolicy,
        accountNumber,
        bankName,
        virtualAccountStatus,
        summary,
      ];

  FamilyAccount copyWith({
    String? id,
    String? creatorId,
    String? creatorName,
    String? name,
    String? description,
    double? totalAllocatedBalance,
    double? totalPoolBalance,
    double? totalBalance,
    bool? allowMemberContributions,
    FamilyAccountStatus? status,
    List<FamilyMember>? members,
    int? memberCount,
    int? activeMemberCount,
    FundDistributionMode? fundDistributionMode,
    bool? setupCompleted,
    bool? spendingVisibilityEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? fundingPolicy,
    String? accountNumber,
    String? bankName,
    String? virtualAccountStatus,
    FamilyAccountSummary? summary,
  }) {
    return FamilyAccount(
      id: id ?? this.id,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
      name: name ?? this.name,
      description: description ?? this.description,
      totalAllocatedBalance: totalAllocatedBalance ?? this.totalAllocatedBalance,
      totalPoolBalance: totalPoolBalance ?? this.totalPoolBalance,
      totalBalance: totalBalance ?? this.totalBalance,
      allowMemberContributions: allowMemberContributions ?? this.allowMemberContributions,
      status: status ?? this.status,
      members: members ?? this.members,
      memberCount: memberCount ?? this.memberCount,
      activeMemberCount: activeMemberCount ?? this.activeMemberCount,
      fundDistributionMode: fundDistributionMode ?? this.fundDistributionMode,
      setupCompleted: setupCompleted ?? this.setupCompleted,
      spendingVisibilityEnabled: spendingVisibilityEnabled ?? this.spendingVisibilityEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      fundingPolicy: fundingPolicy ?? this.fundingPolicy,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      virtualAccountStatus: virtualAccountStatus ?? this.virtualAccountStatus,
      summary: summary ?? this.summary,
    );
  }

  // Computed properties
  bool get isActive => status == FamilyAccountStatus.active;
  bool get isFrozen => status == FamilyAccountStatus.frozen;
  bool get isPendingSetup => status == FamilyAccountStatus.pendingSetup;
  bool get needsSetup => !setupCompleted && isPendingSetup;
  bool get canAcceptMembers => isActive || isPendingSetup;

  // ─── Role helpers ──────────────────────────────────────────────────
  // These mirror the backend's isFamilyAdmin / creator checks. UI must
  // call them with the currently-authenticated user's ID (typically
  // pulled from AuthenticationCubit state).

  /// The current user's member record on this family, or null if they
  /// aren't a member (e.g. an admin dashboard viewer).
  FamilyMember? memberForUser(String? userId) {
    if (userId == null || userId.isEmpty) return null;
    for (final m in members) {
      if (m.userId == userId) return m;
    }
    return null;
  }

  /// True iff the given user has the admin role AND has accepted the
  /// invitation. Mirrors backend isFamilyAdmin (role=admin AND
  /// invitation_status=accepted).
  bool isCurrentUserAdmin(String? userId) {
    final m = memberForUser(userId);
    return m != null &&
        m.role == FamilyMemberRole.admin &&
        m.invitationStatus == InvitationStatus.accepted;
  }

  /// True iff the given user originally created this family. Creator is
  /// always treated as admin and is the only role allowed to delete.
  bool isCurrentUserCreator(String? userId) =>
      userId != null && userId.isNotEmpty && userId == creatorId;

  /// True if the given user is an accepted member of any kind. Read
  /// access is gated on this on the backend (GetFamilyAccount,
  /// GetFamilyTransactions).
  bool isCurrentUserMember(String? userId) {
    final m = memberForUser(userId);
    return m != null && m.invitationStatus == InvitationStatus.accepted;
  }
}
