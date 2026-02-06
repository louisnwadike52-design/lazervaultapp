import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';

abstract class RecipientState extends Equatable {
  const RecipientState();

  @override
  List<Object> get props => [];
}

class RecipientInitial extends RecipientState {}

class RecipientLoading extends RecipientState {}

class RecipientLoaded extends RecipientState {
  final List<RecipientModel> recipients;
  final bool isStale;
  final bool isRevalidating;
  final bool hasMore;
  final int currentPage;
  final int totalItems;
  final int totalPages;

  const RecipientLoaded(
    this.recipients, {
    this.isStale = false,
    this.isRevalidating = false,
    this.hasMore = true,
    this.currentPage = 1,
    this.totalItems = 0,
    this.totalPages = 0,
  });

  RecipientLoaded copyWith({
    List<RecipientModel>? recipients,
    bool? isStale,
    bool? isRevalidating,
    bool? hasMore,
    int? currentPage,
    int? totalItems,
    int? totalPages,
  }) {
    return RecipientLoaded(
      recipients ?? this.recipients,
      isStale: isStale ?? this.isStale,
      isRevalidating: isRevalidating ?? this.isRevalidating,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      totalItems: totalItems ?? this.totalItems,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object> get props => [recipients, isStale, isRevalidating, hasMore, currentPage, totalItems, totalPages];
}

class RecipientError extends RecipientState {
  final String message;

  const RecipientError(this.message);

  @override
  List<Object> get props => [message];
}

class RecipientSuccess extends RecipientState {
  final String message;
  final RecipientModel? recipient;

  const RecipientSuccess(this.message, {this.recipient});

  @override
  List<Object> get props => [message, if (recipient != null) recipient!];
}

class RecipientLoadingMore extends RecipientState {
  final List<RecipientModel> currentRecipients;
  final bool hasMore;
  final int currentPage;

  const RecipientLoadingMore({
    required this.currentRecipients,
    required this.hasMore,
    required this.currentPage,
  });

  @override
  List<Object> get props => [currentRecipients, hasMore, currentPage];
} 