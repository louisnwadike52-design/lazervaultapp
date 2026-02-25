import 'package:equatable/equatable.dart';
import '../../domain/entities/family_account_entities.dart';

// Base State
abstract class FamilyAccountState extends Equatable {
  const FamilyAccountState();

  @override
  List<Object?> get props => [];
}

// Initial State
class FamilyAccountInitial extends FamilyAccountState {
  const FamilyAccountInitial();
}

// Loading States
class FamilyAccountLoading extends FamilyAccountState {
  const FamilyAccountLoading();
}

class FamilyAccountCreating extends FamilyAccountState {
  const FamilyAccountCreating();
}

class FamilyMemberAdding extends FamilyAccountState {
  const FamilyMemberAdding();
}

class FamilyMemberUpdating extends FamilyAccountState {
  const FamilyMemberUpdating();
}

class FamilyMemberRemoving extends FamilyAccountState {
  const FamilyMemberRemoving();
}

class FundsAllocating extends FamilyAccountState {
  const FundsAllocating();
}

// Loaded States
class FamilyAccountsLoaded extends FamilyAccountState {
  final List<FamilyAccount> familyAccounts;
  final int totalCount;

  const FamilyAccountsLoaded(this.familyAccounts, {this.totalCount = 0});

  @override
  List<Object?> get props => [familyAccounts, totalCount];
}

class FamilyAccountLoaded extends FamilyAccountState {
  final FamilyAccount familyAccount;

  const FamilyAccountLoaded(this.familyAccount);

  @override
  List<Object?> get props => [familyAccount];
}

class FamilyAccountCreated extends FamilyAccountState {
  final FamilyAccount familyAccount;

  const FamilyAccountCreated(this.familyAccount);

  @override
  List<Object?> get props => [familyAccount];
}

class FamilyMemberAdded extends FamilyAccountState {
  final FamilyMember member;

  const FamilyMemberAdded(this.member);

  @override
  List<Object?> get props => [member];
}

class FamilyMemberUpdated extends FamilyAccountState {
  final FamilyMember member;

  const FamilyMemberUpdated(this.member);

  @override
  List<Object?> get props => [member];
}

class FamilyMemberRemoved extends FamilyAccountState {
  final double returnedBalance;

  const FamilyMemberRemoved(this.returnedBalance);

  @override
  List<Object?> get props => [returnedBalance];
}

class FundsAllocated extends FamilyAccountState {
  final FamilyMember member;
  final double remainingPoolBalance;

  const FundsAllocated(this.member, this.remainingPoolBalance);

  @override
  List<Object?> get props => [member, remainingPoolBalance];
}

class FamilyTransactionsLoaded extends FamilyAccountState {
  final List<FamilyTransaction> transactions;
  final int totalCount;
  final int currentPage;
  final int totalPages;

  const FamilyTransactionsLoaded(
    this.transactions, {
    this.totalCount = 0,
    this.currentPage = 1,
    this.totalPages = 1,
  });

  @override
  List<Object?> get props => [transactions, totalCount, currentPage, totalPages];
}

class PendingInvitationsLoaded extends FamilyAccountState {
  final List<PendingInvitation> invitations;
  final int totalCount;

  const PendingInvitationsLoaded(this.invitations, {this.totalCount = 0});

  @override
  List<Object?> get props => [invitations, totalCount];
}

class InvitationAccepted extends FamilyAccountState {
  final FamilyAccount familyAccount;

  const InvitationAccepted(this.familyAccount);

  @override
  List<Object?> get props => [familyAccount];
}

class InvitationDeclined extends FamilyAccountState {
  final bool success;

  const InvitationDeclined(this.success);

  @override
  List<Object?> get props => [success];
}

class MemberCardGenerated extends FamilyAccountState {
  final FamilyMember member;

  const MemberCardGenerated(this.member);

  @override
  List<Object?> get props => [member];
}

class FamilyAccountFrozen extends FamilyAccountState {
  final FamilyAccount familyAccount;

  const FamilyAccountFrozen(this.familyAccount);

  @override
  List<Object?> get props => [familyAccount];
}

class FamilyAccountUnfrozen extends FamilyAccountState {
  final FamilyAccount familyAccount;

  const FamilyAccountUnfrozen(this.familyAccount);

  @override
  List<Object?> get props => [familyAccount];
}

class FamilyAccountDeleted extends FamilyAccountState {
  final double returnedBalance;

  const FamilyAccountDeleted(this.returnedBalance);

  @override
  List<Object?> get props => [returnedBalance];
}

class MemberContributionProcessed extends FamilyAccountState {
  final FamilyAccount familyAccount;

  const MemberContributionProcessed(this.familyAccount);

  @override
  List<Object?> get props => [familyAccount];
}

class FamilyAccountSettingUp extends FamilyAccountState {
  const FamilyAccountSettingUp();
}

class FamilyAccountSetupCompleted extends FamilyAccountState {
  final FamilyAccount familyAccount;

  const FamilyAccountSetupCompleted(this.familyAccount);

  @override
  List<Object?> get props => [familyAccount];
}

// Error State
class FamilyAccountError extends FamilyAccountState {
  final String message;

  const FamilyAccountError(this.message);

  @override
  List<Object?> get props => [message];
}
