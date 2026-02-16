import '../../domain/entities/id_pay_entity.dart';
import '../../domain/entities/id_pay_transaction_entity.dart';

sealed class IDPayState {}

class IDPayInitial extends IDPayState {}

class IDPayLoading extends IDPayState {}

class IDPayCreated extends IDPayState {
  final IDPayEntity idPay;
  IDPayCreated({required this.idPay});
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
  IDPayDetailsLoaded({required this.idPay});
}

class IDPayError extends IDPayState {
  final String message;
  IDPayError({required this.message});
}
