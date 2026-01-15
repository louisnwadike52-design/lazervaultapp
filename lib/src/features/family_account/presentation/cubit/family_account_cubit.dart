import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/family_account_entities.dart';
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
  final ProcessMemberContributionUseCase processMemberContribution;

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
    required this.processMemberContribution,
  })  : _acceptInvitationUseCase = acceptInvitationUseCase,
        _declineInvitationUseCase = declineInvitationUseCase,
        super(FamilyAccountInitial());

  // Get all family accounts
  Future<void> loadFamilyAccounts({String? statusFilter}) async {
    emit(FamilyAccountLoading());
    final result = await getFamilyAccounts(GetFamilyAccountsParams(statusFilter: statusFilter));
    result.fold(
      (failure) => emit(FamilyAccountError(failure.toString())),
      (accounts) => emit(FamilyAccountsLoaded(accounts)),
    );
  }

  // Get specific family account
  Future<void> loadFamilyAccount(String familyId) async {
    emit(FamilyAccountLoading());
    final result = await getFamilyAccount(familyId);
    result.fold(
      (failure) => emit(FamilyAccountError(failure.toString())),
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
      (failure) => emit(FamilyAccountError(failure.toString())),
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
    ));
    result.fold(
      (failure) => emit(FamilyAccountError(failure.toString())),
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
      (failure) => emit(FamilyAccountError(failure.toString())),
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
      (failure) => emit(FamilyAccountError(failure.toString())),
      (returnedBalance) => emit(FamilyMemberRemoved(returnedBalance)),
    );
  }

  // Accept family invitation
  Future<void> acceptInvitation(String invitationToken) async {
    emit(FamilyAccountLoading());
    final result = await _acceptInvitationUseCase(invitationToken);
    result.fold(
      (failure) => emit(FamilyAccountError(failure.toString())),
      (account) => emit(InvitationAccepted(account)),
    );
  }

  // Decline family invitation
  Future<void> declineInvitation(String invitationToken) async {
    emit(FamilyAccountLoading());
    final result = await _declineInvitationUseCase(invitationToken);
    result.fold(
      (failure) => emit(FamilyAccountError(failure.toString())),
      (success) => emit(InvitationDeclined(success)),
    );
  }

  // Get pending invitations
  Future<void> loadPendingInvitations() async {
    emit(FamilyAccountLoading());
    final result = await getPendingInvitations(NoParams());
    result.fold(
      (failure) => emit(FamilyAccountError(failure.toString())),
      (invitations) => emit(PendingInvitationsLoaded(invitations)),
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
      (failure) => emit(FamilyAccountError(failure.toString())),
      (transactions) => emit(FamilyTransactionsLoaded(transactions)),
    );
  }

  // Allocate funds to member
  Future<void> allocateFundsToMember({
    required String familyId,
    required String memberId,
    required double amount,
    String? description,
  }) async {
    emit(FundsAllocating());
    final result = await allocateFunds(AllocateFundsParams(
      familyId: familyId,
      memberId: memberId,
      amount: amount,
      description: description,
    ));
    result.fold(
      (failure) => emit(FamilyAccountError(failure.toString())),
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
      (failure) => emit(FamilyAccountError(failure.toString())),
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
      (failure) => emit(FamilyAccountError(failure.toString())),
      (account) => emit(FamilyAccountFrozen(account)),
    );
  }

  // Unfreeze family account
  Future<void> unfreezeAccount(String familyId) async {
    emit(FamilyAccountLoading());
    final result = await unfreezeFamilyAccount(familyId);
    result.fold(
      (failure) => emit(FamilyAccountError(failure.toString())),
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
      (failure) => emit(FamilyAccountError(failure.toString())),
      (returnedBalance) => emit(FamilyAccountDeleted(returnedBalance)),
    );
  }

  // Process member contribution (hybrid funding)
  Future<void> contributeToPool({
    required String familyId,
    required String memberId,
    required double amount,
    String? description,
  }) async {
    emit(FamilyAccountLoading());
    final result = await processMemberContribution(ProcessMemberContributionParams(
      familyId: familyId,
      memberId: memberId,
      amount: amount,
      description: description,
    ));
    result.fold(
      (failure) => emit(FamilyAccountError(failure.toString())),
      (account) => emit(MemberContributionProcessed(account)),
    );
  }

  // Reset to initial state
  void reset() {
    emit(FamilyAccountInitial());
  }
}
