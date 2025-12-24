import 'package:equatable/equatable.dart';
import '../../domain/entities/tag_pay_entity.dart';
import '../../domain/entities/user_tag_entity.dart';

abstract class TagPayState extends Equatable {
  const TagPayState();

  @override
  List<Object?> get props => [];
}

class TagPayInitial extends TagPayState {}

class TagPayLoading extends TagPayState {}

class TagPayLoaded extends TagPayState {
  final TagPayEntity tagPay;

  const TagPayLoaded(this.tagPay);

  @override
  List<Object?> get props => [tagPay];
}

class TagPayError extends TagPayState {
  final String message;

  const TagPayError(this.message);

  @override
  List<Object?> get props => [message];
}

class TagPayAvailabilityChecked extends TagPayState {
  final bool available;
  final String message;
  final List<String> suggestions;

  const TagPayAvailabilityChecked({
    required this.available,
    required this.message,
    required this.suggestions,
  });

  @override
  List<Object?> get props => [available, message, suggestions];
}

class TagPaySearchResults extends TagPayState {
  final List<TagPayEntity> results;

  const TagPaySearchResults(this.results);

  @override
  List<Object?> get props => [results];
}

class TagPayTransactionsLoaded extends TagPayState {
  final List<TagPayTransactionEntity> transactions;

  const TagPayTransactionsLoaded(this.transactions);

  @override
  List<Object?> get props => [transactions];
}

class MoneyRequestsLoaded extends TagPayState {
  final List<MoneyRequestEntity> requests;

  const MoneyRequestsLoaded(this.requests);

  @override
  List<Object?> get props => [requests];
}

class MoneyTransferSuccess extends TagPayState {
  final TagPayTransactionEntity transaction;
  final String message;

  const MoneyTransferSuccess({
    required this.transaction,
    required this.message,
  });

  @override
  List<Object?> get props => [transaction, message];
}

class MoneyRequestSuccess extends TagPayState {
  final MoneyRequestEntity request;
  final String message;

  const MoneyRequestSuccess({
    required this.request,
    required this.message,
  });

  @override
  List<Object?> get props => [request, message];
}

class TagCreatedSuccess extends TagPayState {
  final UserTagEntity tag;
  final String message;

  const TagCreatedSuccess({
    required this.tag,
    required this.message,
  });

  @override
  List<Object?> get props => [tag, message];
}

class MyTagsLoaded extends TagPayState {
  final List<UserTagEntity> tags;

  const MyTagsLoaded(this.tags);

  @override
  List<Object?> get props => [tags];
}

class MyOutgoingTagsLoaded extends TagPayState {
  final List<UserTagEntity> tags;

  const MyOutgoingTagsLoaded(this.tags);

  @override
  List<Object?> get props => [tags];
}

class MyIncomingTagsLoaded extends TagPayState {
  final List<UserTagEntity> tags;

  const MyIncomingTagsLoaded(this.tags);

  @override
  List<Object?> get props => [tags];
}

class TagPaidSuccess extends TagPayState {
  final TagPayTransactionEntity transaction;
  final String message;

  const TagPaidSuccess({
    required this.transaction,
    required this.message,
  });

  @override
  List<Object?> get props => [transaction, message];
}
