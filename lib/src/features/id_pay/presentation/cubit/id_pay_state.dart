import '../../domain/entities/id_pay_entity.dart';
import '../../domain/entities/id_pay_fee_rule_entity.dart';
import '../../domain/entities/id_pay_organization_entity.dart';
import '../../domain/entities/id_pay_transaction_entity.dart';

sealed class IDPayState {}

class IDPayInitial extends IDPayState {}

class IDPayLoading extends IDPayState {}

/// Intermediate state while the debit + credit pair settles server-side.
/// Rendered by `IDPayProcessingScreen` so the user sees a 4-step indicator
/// instead of a frozen "Loading…" until the receipt screen lands.
class IDPayProcessing extends IDPayState {
  final String payId;
  final double amount;
  IDPayProcessing({required this.payId, required this.amount});
}

/// Distinct from generic IDPayError so the receipt screen can route the
/// user to a "Top up" CTA instead of a generic retry button.
class IDPayInsufficientFunds extends IDPayState {
  final String message;
  IDPayInsufficientFunds({required this.message});
}

class IDPayCreated extends IDPayState {
  final IDPayFeeRuleEntity? feeRule;
  final IDPayEntity idPay;
  IDPayCreated({required this.idPay, this.feeRule});
}

class IDPayLookedUp extends IDPayState {
  final IDPayEntity idPay;
  IDPayLookedUp({required this.idPay});
}

class IDPayPaid extends IDPayState {
  final IDPayTransactionEntity transaction;
  final double newBalance;
  IDPayPaid({required this.transaction, required this.newBalance});
}

class MyIDPaysLoaded extends IDPayState {
  final List<IDPayEntity> idPays;
  final bool isStale;
  MyIDPaysLoaded({required this.idPays, this.isStale = false});
}

class IDPayTransactionsLoaded extends IDPayState {
  final List<IDPayTransactionEntity> transactions;
  IDPayTransactionsLoaded({required this.transactions});
}

class IDPayCancelled extends IDPayState {}

class IDPayDetailsLoaded extends IDPayState {
  final IDPayEntity idPay;
  final IDPayFeeRuleEntity? feeRule;
  IDPayDetailsLoaded({required this.idPay, this.feeRule});
}

class IDPayOrganizationsLoaded extends IDPayState {
  final List<IDPayOrganizationEntity> organizations;
  final bool isStale;
  IDPayOrganizationsLoaded({required this.organizations, this.isStale = false});
}

class IDPayOrganizationCreated extends IDPayState {
  final IDPayOrganizationEntity organization;
  IDPayOrganizationCreated({required this.organization});
}

class IDPayOrganizationUpdated extends IDPayState {
  final IDPayOrganizationEntity organization;
  IDPayOrganizationUpdated({required this.organization});
}

class IDPayOrganizationDeleted extends IDPayState {}

class IDPayOrganizationDetailsLoaded extends IDPayState {
  final IDPayOrganizationEntity organization;
  final List<IDPayEntity> idPays;
  final double totalPaidOut;
  IDPayOrganizationDetailsLoaded({
    required this.organization,
    required this.idPays,
    required this.totalPaidOut,
  });
}

class IDPayLookedUpWithOrg extends IDPayState {
  final IDPayEntity idPay;
  final IDPayOrganizationEntity? organization;
  IDPayLookedUpWithOrg({required this.idPay, this.organization});
}

class IDPayError extends IDPayState {
  final String message;

  /// The gRPC code name the failure carried — "NOT_FOUND", "UNAVAILABLE",
  /// "DEADLINE_EXCEEDED" and so on. Empty when the caller did not pass one.
  ///
  /// The message alone cannot tell "that code does not exist" from "we could
  /// not reach the server", and those need opposite things from the user:
  /// re-read the code, or try again. The lookup screen showed the
  /// check-your-code empty state for both, which sends somebody off to
  /// re-type a code that was right all along.
  final String code;

  IDPayError({required this.message, this.code = ''});

  /// True only when the server actually answered "no such PayID".
  ///
  /// Deliberately a positive test on NOT_FOUND rather than "anything that is
  /// not a network error": an unrecognised code degrades to the generic
  /// "something went wrong, try again", which is annoying but honest, where
  /// the reverse would tell a user their code is wrong on evidence we do not
  /// have.
  bool get isNotFound => code.toUpperCase() == 'NOT_FOUND';
}
