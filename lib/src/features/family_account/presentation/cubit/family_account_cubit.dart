import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/family_account_entities.dart';
import '../../domain/repositories/family_account_repository.dart' show MemberAllocationEntry;
import '../../domain/usecases/family_account_usecases.dart';
import 'family_account_state.dart';

class FamilyAccountCubit extends Cubit<FamilyAccountState> {
  final GetFamilyAccountsUseCase getFamilyAccounts;
  final GetFamilyAccountUseCase getFamilyAccount;
  final CreateFamilyAccountUseCase createFamilyAccount;
  final AddFamilyMemberUseCase addFamilyMember;
  final UpdateFamilyMemberUseCase updateFamilyMember;
  final RemoveFamilyMemberUseCase removeFamilyMember;
  final AcceptFamilyInvitationUseCase _acceptInvitationUseCase;
  final DeclineFamilyInvitationUseCase _declineInvitationUseCase;
  final GetPendingInvitationsUseCase getPendingInvitations;
  final GetFamilyTransactionsUseCase getFamilyTransactions;
  final AllocateFundsUseCase allocateFunds;
  final GenerateMemberCardUseCase generateMemberCard;
  final FreezeFamilyAccountUseCase freezeFamilyAccount;
  final UnfreezeFamilyAccountUseCase unfreezeFamilyAccount;
  final DeleteFamilyAccountUseCase deleteFamilyAccount;
  final LeaveFamilyAccountUseCase leaveFamilyAccount;
  final ProcessMemberContributionUseCase processMemberContribution;
  final SetupFamilyAccountUseCase setupFamilyAccount;
  final UpdateFundDistributionModeUseCase updateFundDistributionMode;
  final GetMyInvitationHistoryUseCase getMyInvitationHistory;
  final GetSentInvitationsUseCase getSentInvitations;

  FamilyAccountCubit({
    required this.getFamilyAccounts,
    required this.getFamilyAccount,
    required this.createFamilyAccount,
    required this.addFamilyMember,
    required this.updateFamilyMember,
    required this.removeFamilyMember,
    required AcceptFamilyInvitationUseCase acceptInvitationUseCase,
    required DeclineFamilyInvitationUseCase declineInvitationUseCase,
    required this.getPendingInvitations,
    required this.getFamilyTransactions,
    required this.allocateFunds,
    required this.generateMemberCard,
    required this.freezeFamilyAccount,
    required this.unfreezeFamilyAccount,
    required this.deleteFamilyAccount,
    required this.leaveFamilyAccount,
    required this.processMemberContribution,
    required this.setupFamilyAccount,
    required this.updateFundDistributionMode,
    required this.getMyInvitationHistory,
    required this.getSentInvitations,
  })  : _acceptInvitationUseCase = acceptInvitationUseCase,
        _declineInvitationUseCase = declineInvitationUseCase,
        super(FamilyAccountInitial());

  // Get all family accounts
  Future<void> loadFamilyAccounts({String? statusFilter}) async {
    emit(FamilyAccountLoading());
    final result = await getFamilyAccounts(GetFamilyAccountsParams(statusFilter: statusFilter));
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (accounts) => emit(FamilyAccountsLoaded(accounts)),
    );
  }

  // Get specific family account
  Future<void> loadFamilyAccount(String familyId) async {
    emit(FamilyAccountLoading());
    final result = await getFamilyAccount(familyId);
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (account) => emit(FamilyAccountLoaded(account)),
    );
  }

  // Create new family account
  Future<void> createAccount({
    required String name,
    String? description,
    required String initialCurrency,
    required double initialFunding,
    required bool allowMemberContributions,
  }) async {
    emit(FamilyAccountCreating());
    final result = await createFamilyAccount(CreateFamilyAccountParams(
      name: name,
      description: description,
      initialCurrency: initialCurrency,
      initialFunding: initialFunding,
      allowMemberContributions: allowMemberContributions,
    ));
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (account) => emit(FamilyAccountCreated(account)),
    );
  }

  // Add member to family account
  Future<void> addMember({
    required String familyId,
    required String invitationMethod,
    required String invitationDestination,
    required double initialAllocation,
    required double dailyLimit,
    required double monthlyLimit,
    required double perTransactionLimit,
    required double allocationPercentageCap,
    required String role,
    String? personalMessage,
    String? displayName,
  }) async {
    emit(FamilyMemberAdding());
    final result = await addFamilyMember(AddFamilyMemberParams(
      familyId: familyId,
      invitationMethod: invitationMethod,
      invitationDestination: invitationDestination,
      initialAllocation: initialAllocation,
      dailyLimit: dailyLimit,
      monthlyLimit: monthlyLimit,
      perTransactionLimit: perTransactionLimit,
      allocationPercentageCap: allocationPercentageCap,
      role: role,
      personalMessage: personalMessage,
      displayName: displayName,
    ));
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (member) => emit(FamilyMemberAdded(member)),
    );
  }

  // Update family member
  Future<void> updateMember({
    required String familyId,
    required String memberId,
    double? allocatedBalance,
    double? dailySpendingLimit,
    double? monthlySpendingLimit,
    double? perTransactionLimit,
    double? allocationPercentageCap,
    String? role,
  }) async {
    emit(FamilyMemberUpdating());
    final result = await updateFamilyMember(UpdateFamilyMemberParams(
      familyId: familyId,
      memberId: memberId,
      allocatedBalance: allocatedBalance,
      dailySpendingLimit: dailySpendingLimit,
      monthlySpendingLimit: monthlySpendingLimit,
      perTransactionLimit: perTransactionLimit,
      allocationPercentageCap: allocationPercentageCap,
      role: role,
    ));
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (member) => emit(FamilyMemberUpdated(member)),
    );
  }

  // Remove family member
  Future<void> removeMember({
    required String familyId,
    required String memberId,
    String? reason,
    bool returnBalanceToPool = true,
  }) async {
    emit(FamilyMemberRemoving());
    final result = await removeFamilyMember(RemoveFamilyMemberParams(
      familyId: familyId,
      memberId: memberId,
      reason: reason,
      returnBalanceToPool: returnBalanceToPool,
    ));
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (returnedBalance) => emit(FamilyMemberRemoved(returnedBalance)),
    );
  }

  // Accept family invitation
  Future<void> acceptInvitation(String invitationToken) async {
    emit(FamilyAccountLoading());
    final result = await _acceptInvitationUseCase(invitationToken);
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (account) => emit(InvitationAccepted(account)),
    );
  }

  // Decline family invitation
  Future<void> declineInvitation(String invitationToken) async {
    emit(FamilyAccountLoading());
    final result = await _declineInvitationUseCase(invitationToken);
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (success) => emit(InvitationDeclined(success)),
    );
  }

  // Get pending invitations
  Future<void> loadPendingInvitations() async {
    emit(FamilyAccountLoading());
    final result = await getPendingInvitations(NoParams());
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (invitations) => emit(PendingInvitationsLoaded(invitations)),
    );
  }

  /// Invitee-side history. statusFilter ∈ {'', 'pending', 'accepted',
  /// 'declined', 'expired', 'removed', 'all'}.
  Future<void> loadInvitationHistory({String statusFilter = ''}) async {
    emit(InvitationHistoryLoading());
    final result = await getMyInvitationHistory(
      GetMyInvitationHistoryParams(statusFilter: statusFilter),
    );
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (entries) => emit(InvitationHistoryLoaded(entries, statusFilter: statusFilter)),
    );
  }

  /// Inviter-side history. Optional familyId narrows to one family.
  Future<void> loadSentInvitations({
    String? familyId,
    String statusFilter = '',
  }) async {
    emit(SentInvitationsLoading());
    final result = await getSentInvitations(
      GetSentInvitationsParams(
        familyId: familyId,
        statusFilter: statusFilter,
      ),
    );
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (entries) => emit(SentInvitationsLoaded(
        entries,
        familyIdFilter: familyId,
        statusFilter: statusFilter,
      )),
    );
  }

  // Get family transactions
  Future<void> loadTransactions({
    required String familyId,
    String? memberId,
    FamilyTransactionType? type,
    int page = 1,
    int pageSize = 20,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    emit(FamilyAccountLoading());
    final result = await getFamilyTransactions(GetFamilyTransactionsParams(
      familyId: familyId,
      memberId: memberId,
      type: type,
      page: page,
      pageSize: pageSize,
      startDate: startDate,
      endDate: endDate,
    ));
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (transactions) => emit(FamilyTransactionsLoaded(transactions)),
    );
  }

  // Allocate funds to member
  Future<void> allocateFundsToMember({
    required String familyId,
    required String memberId,
    required double amount,
    String? description,
    String? idempotencyKey,
  }) async {
    emit(FundsAllocating());
    // Money-safety: a stable per-allocation key so a retry after a network
    // error never double-allocates (mirrors contributeToPool).
    final key = idempotencyKey ?? const Uuid().v4();
    final result = await allocateFunds(AllocateFundsParams(
      familyId: familyId,
      memberId: memberId,
      amount: amount,
      description: description,
      idempotencyKey: key,
    ));
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (member) => emit(FundsAllocated(member, 0)),
    );
  }

  // Generate member card
  Future<void> generateCard({
    required String familyId,
    required String memberId,
    String? cardName,
  }) async {
    emit(FamilyAccountLoading());
    final result = await generateMemberCard(GenerateMemberCardParams(
      familyId: familyId,
      memberId: memberId,
      cardName: cardName,
    ));
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (member) => emit(MemberCardGenerated(member)),
    );
  }

  // Freeze family account
  Future<void> freezeAccount({
    required String familyId,
    String? reason,
  }) async {
    emit(FamilyAccountLoading());
    final result = await freezeFamilyAccount(FreezeFamilyAccountParams(
      familyId: familyId,
      reason: reason,
    ));
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (account) => emit(FamilyAccountFrozen(account)),
    );
  }

  // Unfreeze family account
  Future<void> unfreezeAccount(String familyId) async {
    emit(FamilyAccountLoading());
    final result = await unfreezeFamilyAccount(familyId);
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (account) => emit(FamilyAccountUnfrozen(account)),
    );
  }

  // Delete family account
  Future<void> deleteAccount({
    required String familyId,
    required String confirmationCode,
  }) async {
    emit(FamilyAccountLoading());
    final result = await deleteFamilyAccount(DeleteFamilyAccountParams(
      familyId: familyId,
      confirmationCode: confirmationCode,
    ));
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (returnedBalance) => emit(FamilyAccountDeleted(returnedBalance)),
    );
  }

  // Leave family account (self-serve, non-creator member)
  Future<void> leaveFamily({required String familyId}) async {
    emit(FamilyAccountLoading());
    final result = await leaveFamilyAccount(LeaveFamilyAccountParams(familyId: familyId));
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (returnedBalance) => emit(FamilyAccountLeft(returnedBalance)),
    );
  }

  // Process member contribution (hybrid funding)
  Future<void> contributeToPool({
    required String familyId,
    required String memberId,
    required double amount,
    String? description,
    String? idempotencyKey,
  }) async {
    emit(FamilyAccountLoading());
    // Money-safety (audit H2): a stable per-contribution key so a retry after a
    // network error never double-debits the contributor. Generated once here.
    final key = idempotencyKey ?? const Uuid().v4();
    final result = await processMemberContribution(ProcessMemberContributionParams(
      familyId: familyId,
      memberId: memberId,
      amount: amount,
      description: description,
      idempotencyKey: key,
    ));
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (account) => emit(MemberContributionProcessed(account)),
    );
  }

  // Setup family account (choose distribution mode, activate)
  Future<void> setupAccount({
    required String familyId,
    required String fundDistributionMode,
    required bool spendingVisibilityEnabled,
    List<MemberAllocationEntry> allocations = const [],
  }) async {
    emit(const FamilyAccountSettingUp());
    final result = await setupFamilyAccount(SetupFamilyAccountParams(
      familyId: familyId,
      fundDistributionMode: fundDistributionMode,
      spendingVisibilityEnabled: spendingVisibilityEnabled,
      allocations: allocations,
    ));
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (account) => emit(FamilyAccountSetupCompleted(account)),
    );
  }

  // Update fund distribution mode for an active account
  Future<void> updateDistributionMode({
    required String familyId,
    required String fundDistributionMode,
    List<MemberAllocationEntry> allocations = const [],
  }) async {
    emit(FamilyAccountLoading());
    final result = await updateFundDistributionMode(UpdateFundDistributionModeParams(
      familyId: familyId,
      fundDistributionMode: fundDistributionMode,
      allocations: allocations,
    ));
    result.fold(
      (failure) => emit(FamilyAccountError(failure.message)),
      (account) => emit(FundDistributionModeUpdated(account)),
    );
  }

  // Reset to initial state
  void reset() {
    emit(FamilyAccountInitial());
  }
}
