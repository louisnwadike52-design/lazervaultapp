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

  const RecipientLoaded(
    this.recipients, {
    this.isStale = false,
    this.isRevalidating = false,
  });

  RecipientLoaded copyWith({
    List<RecipientModel>? recipients,
    bool? isStale,
    bool? isRevalidating,
  }) {
    return RecipientLoaded(
      recipients ?? this.recipients,
      isStale: isStale ?? this.isStale,
      isRevalidating: isRevalidating ?? this.isRevalidating,
    );
  }

  @override
  List<Object> get props => [recipients, isStale, isRevalidating];
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