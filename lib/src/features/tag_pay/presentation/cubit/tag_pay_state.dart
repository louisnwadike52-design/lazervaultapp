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

class BatchTagsCreatedSuccess extends TagPayState {
  final List<UserTagEntity> tags;
  final List<String> failedUsers;
  final String message;

  const BatchTagsCreatedSuccess({
    required this.tags,
    this.failedUsers = const [],
    required this.message,
  });

  @override
  List<Object?> get props => [tags, failedUsers, message];
}

class MyTagsLoaded extends TagPayState {
  final List<UserTagEntity> tags;

  const MyTagsLoaded(this.tags);

  @override
  List<Object?> get props => [tags];
}

class MyOutgoingTagsLoaded extends TagPayState {
  final List<UserTagEntity> tags;
  final int total;
  final int page;
  final int totalPages;

  const MyOutgoingTagsLoaded(
    this.tags, {
    this.total = 0,
    this.page = 1,
    this.totalPages = 1,
  });

  @override
  List<Object?> get props => [tags, total, page, totalPages];
}

class MyIncomingTagsLoaded extends TagPayState {
  final List<UserTagEntity> tags;
  final int total;
  final int page;
  final int totalPages;

  const MyIncomingTagsLoaded(
    this.tags, {
    this.total = 0,
    this.page = 1,
    this.totalPages = 1,
  });

  @override
  List<Object?> get props => [tags, total, page, totalPages];
}

class TagPayHomeLoaded extends TagPayState {
  final TagPayEntity? tagPay;
  final List<UserTagEntity> incomingTags;
  final List<UserTagEntity> outgoingTags;
  final int incomingTotal;
  final int incomingPage;
  final int incomingTotalPages;
  final int outgoingTotal;
  final int outgoingPage;
  final int outgoingTotalPages;

  const TagPayHomeLoaded({
    this.tagPay,
    this.incomingTags = const [],
    this.outgoingTags = const [],
    this.incomingTotal = 0,
    this.incomingPage = 1,
    this.incomingTotalPages = 1,
    this.outgoingTotal = 0,
    this.outgoingPage = 1,
    this.outgoingTotalPages = 1,
  });

  int get incomingPendingCount =>
      incomingTags.where((t) => t.status == TagStatus.pending).length;
  int get incomingPaidCount =>
      incomingTags.where((t) => t.status == TagStatus.paid).length;
  int get outgoingPendingCount =>
      outgoingTags.where((t) => t.status == TagStatus.pending).length;
  int get outgoingPaidCount =>
      outgoingTags.where((t) => t.status == TagStatus.paid).length;

  TagPayHomeLoaded copyWith({
    TagPayEntity? tagPay,
    List<UserTagEntity>? incomingTags,
    List<UserTagEntity>? outgoingTags,
    int? incomingTotal,
    int? incomingPage,
    int? incomingTotalPages,
    int? outgoingTotal,
    int? outgoingPage,
    int? outgoingTotalPages,
  }) {
    return TagPayHomeLoaded(
      tagPay: tagPay ?? this.tagPay,
      incomingTags: incomingTags ?? this.incomingTags,
      outgoingTags: outgoingTags ?? this.outgoingTags,
      incomingTotal: incomingTotal ?? this.incomingTotal,
      incomingPage: incomingPage ?? this.incomingPage,
      incomingTotalPages: incomingTotalPages ?? this.incomingTotalPages,
      outgoingTotal: outgoingTotal ?? this.outgoingTotal,
      outgoingPage: outgoingPage ?? this.outgoingPage,
      outgoingTotalPages: outgoingTotalPages ?? this.outgoingTotalPages,
    );
  }

  @override
  List<Object?> get props => [
        tagPay,
        incomingTags,
        outgoingTags,
        incomingTotal,
        incomingPage,
        incomingTotalPages,
        outgoingTotal,
        outgoingPage,
        outgoingTotalPages,
      ];
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

/// State emitted when a tag creation is queued for offline retry.
class TagCreationQueued extends TagPayState {
  final String taggedUserTagPay;
  final double amount;
  final String currency;
  final String message;
  final String? mutationId;

  const TagCreationQueued({
    required this.taggedUserTagPay,
    required this.amount,
    required this.currency,
    required this.message,
    this.mutationId,
  });

  @override
  List<Object?> get props => [taggedUserTagPay, amount, currency, message, mutationId];
}
