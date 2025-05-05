import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/add_recipient_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/get_recipients_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/toggle_favorite_usecase.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';

class RecipientCubit extends Cubit<RecipientState> {
  final GetRecipientsUseCase _getRecipientsUseCase;
  final AddRecipientUseCase _addRecipientUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;

  RecipientCubit({
    required GetRecipientsUseCase getRecipientsUseCase,
    required AddRecipientUseCase addRecipientUseCase,
    required ToggleFavoriteUseCase toggleFavoriteUseCase,
  })  : _getRecipientsUseCase = getRecipientsUseCase,
        _addRecipientUseCase = addRecipientUseCase,
        _toggleFavoriteUseCase = toggleFavoriteUseCase,
        super(RecipientInitial());

  Future<void> getRecipients({required String accessToken}) async {
    emit(RecipientLoading());
    try {
      final result = await _getRecipientsUseCase(accessToken: accessToken);
      result.fold(
        (failure) => emit(RecipientError(failure.message)),
        (recipients) => emit(RecipientLoaded(recipients)),
      );
    } catch (e) {
      emit(RecipientError(e.toString()));
    }
  }

  Future<void> addRecipient({
    required RecipientModel recipient,
    required String accessToken,
  }) async {
    emit(RecipientLoading());
    try {
      final result = await _addRecipientUseCase(
        recipient: recipient,
        accessToken: accessToken,
      );
      result.fold(
        (failure) => emit(RecipientError(failure.message)),
        (newRecipient) {
          emit(RecipientSuccess('Recipient added successfully'));
          getRecipients(accessToken: accessToken);
        },
      );
    } catch (e) {
      emit(RecipientError(e.toString()));
    }
  }

  Future<void> toggleFavorite({
    required String recipientId,
    required String accessToken,
  }) async {
    final previousState = state;
    if (previousState is RecipientLoaded) {
       final updatedRecipients = previousState.recipients.map((r) {
         if (r.id == recipientId) {
           return r.copyWith(isFavorite: !r.isFavorite);
         }
         return r;
       }).toList();
       emit(RecipientLoaded(updatedRecipients));
    }

    try {
      final result = await _toggleFavoriteUseCase(
          recipientId: recipientId, accessToken: accessToken);
      result.fold(
        (failure) {
            emit(previousState);
            emit(RecipientError(failure.message));
         },
        (_) { 
        },
      );
    } catch (e) {
       emit(previousState);
       emit(RecipientError(e.toString()));
    }
  }
} 