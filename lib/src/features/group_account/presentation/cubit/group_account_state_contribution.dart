part of 'group_account_state.dart';

class GroupAccountContributionCreated extends GroupAccountState {
  final Contribution contribution;
  
  const GroupAccountContributionCreated(this.contribution);
  
  @override
  List<Object?> get props => [contribution];
}

class GroupAccountPaymentCompleted extends GroupAccountState {
  final ContributionPayment payment;

  const GroupAccountPaymentCompleted(this.payment);

  @override
  List<Object?> get props => [payment];
}

/// Payment processing state - shown during payment
class ContributionPaymentProcessing extends GroupAccountState {
  final String contributionId;
  final double amount;
  final String? message;

  const ContributionPaymentProcessing({
    required this.contributionId,
    required this.amount,
    this.message,
  });

  @override
  List<Object?> get props => [contributionId, amount, message];
}

/// Payment success with detailed response
class ContributionPaymentSuccess extends GroupAccountState {
  final ContributionPayment payment;
  final String message;
  final Contribution? updatedContribution;

  const ContributionPaymentSuccess({
    required this.payment,
    required this.message,
    this.updatedContribution,
  });

  @override
  List<Object?> get props => [payment, message, updatedContribution];
}

/// Payment failed with specific error type
class ContributionPaymentFailed extends GroupAccountState {
  final String error;
  final bool isInsufficientBalance;
  final bool isPinInvalid;
  final bool isDuplicate;
  final double? requiredAmount;
  final double? availableBalance;

  const ContributionPaymentFailed({
    required this.error,
    this.isInsufficientBalance = false,
    this.isPinInvalid = false,
    this.isDuplicate = false,
    this.requiredAmount,
    this.availableBalance,
  });

  @override
  List<Object?> get props => [
        error,
        isInsufficientBalance,
        isPinInvalid,
        isDuplicate,
        requiredAmount,
        availableBalance,
      ];
}

class GroupAccountReceiptGenerated extends GroupAccountState {
  final ContributionReceipt receipt;
  
  const GroupAccountReceiptGenerated(this.receipt);
  
  @override
  List<Object?> get props => [receipt];
}

class GroupAccountTranscriptGenerated extends GroupAccountState {
  final ContributionTranscript transcript;
  
  const GroupAccountTranscriptGenerated(this.transcript);
  
  @override
  List<Object?> get props => [transcript];
}

/// Members added to contribution successfully
class ContributionMembersAdded extends GroupAccountState {
  final List<ContributionMember> members;
  final String message;

  const ContributionMembersAdded({
    required this.members,
    required this.message,
  });

  @override
  List<Object?> get props => [members, message];
}
