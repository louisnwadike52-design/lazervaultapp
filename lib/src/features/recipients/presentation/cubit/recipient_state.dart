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

  const RecipientLoaded(this.recipients);

  @override
  List<Object> get props => [recipients];
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