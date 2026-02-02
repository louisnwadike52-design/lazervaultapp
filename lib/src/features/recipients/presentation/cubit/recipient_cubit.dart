import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/add_recipient_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/get_recipients_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/toggle_favorite_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/update_alias_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/delete_recipient_usecase.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';

class RecipientCubit extends Cubit<RecipientState> {
  final GetRecipientsUseCase _getRecipientsUseCase;
  final AddRecipientUseCase _addRecipientUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final UpdateAliasUseCase _updateAliasUseCase;
  final DeleteRecipientUseCase _deleteRecipientUseCase;

  RecipientCubit({
    required GetRecipientsUseCase getRecipientsUseCase,
    required AddRecipientUseCase addRecipientUseCase,
    required ToggleFavoriteUseCase toggleFavoriteUseCase,
    required UpdateAliasUseCase updateAliasUseCase,
    required DeleteRecipientUseCase deleteRecipientUseCase,
  })  : _getRecipientsUseCase = getRecipientsUseCase,
        _addRecipientUseCase = addRecipientUseCase,
        _toggleFavoriteUseCase = toggleFavoriteUseCase,
        _updateAliasUseCase = updateAliasUseCase,
        _deleteRecipientUseCase = deleteRecipientUseCase,
        super(RecipientInitial());

  Future<void> getRecipients({
    required String accessToken,
    String? countryCode,
    String? currency,
    bool? favoritesOnly,
  }) async {
    if (isClosed) return;
    emit(RecipientLoading());
    try {
      final result = await _getRecipientsUseCase(
        accessToken: accessToken,
        countryCode: countryCode,
        currency: currency,
        favoritesOnly: favoritesOnly,
      );
      if (isClosed) return;
      result.fold(
        (failure) => emit(RecipientError(failure.message)),
        (recipients) => emit(RecipientLoaded(recipients)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(RecipientError(e.toString()));
    }
  }

  Future<void> addRecipient({
    required RecipientModel recipient,
    required String accessToken,
  }) async {
    if (isClosed) return;
    emit(RecipientLoading());
    try {
      final result = await _addRecipientUseCase(
        recipient: recipient,
        accessToken: accessToken,
      );
      if (isClosed) return;
      result.fold(
        (failure) => emit(RecipientError(failure.message)),
        (newRecipient) {
          emit(RecipientSuccess('Recipient added successfully', recipient: newRecipient));
          getRecipients(accessToken: accessToken);
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(RecipientError(e.toString()));
    }
  }

  Future<void> toggleFavorite({
    required String recipientId,
    required bool isFavorite,
    required String accessToken,
  }) async {
    final previousState = state;
    if (previousState is RecipientLoaded) {
       final updatedRecipients = previousState.recipients.map((r) {
         if (r.id == recipientId) {
           return r.copyWith(isFavorite: isFavorite);
         }
         return r;
       }).toList();
       if (isClosed) return;
       emit(RecipientLoaded(updatedRecipients));
    }

    try {
      final result = await _toggleFavoriteUseCase(
          recipientId: recipientId, isFavorite: isFavorite, accessToken: accessToken);
      if (isClosed) return;
      result.fold(
        (failure) {
            emit(previousState);
            emit(RecipientError(failure.message));
         },
        (_) {
        },
      );
    } catch (e) {
       if (isClosed) return;
       emit(previousState);
       emit(RecipientError(e.toString()));
    }
  }

  Future<void> updateAlias({
    required String recipientId,
    required String? alias,
    required String accessToken,
  }) async {
    final previousState = state;
    // Optimistic update
    if (previousState is RecipientLoaded) {
      final updatedRecipients = previousState.recipients.map((r) {
        if (r.id == recipientId) {
          return r.copyWith(alias: alias);
        }
        return r;
      }).toList();
      if (isClosed) return;
      emit(RecipientLoaded(updatedRecipients));
    }

    try {
      final result = await _updateAliasUseCase(
        recipientId: recipientId,
        alias: alias,
        accessToken: accessToken,
      );
      if (isClosed) return;
      result.fold(
        (failure) {
          emit(previousState);
          emit(RecipientError(failure.message));
        },
        (_) {},
      );
    } catch (e) {
      if (isClosed) return;
      emit(previousState);
      emit(RecipientError(e.toString()));
    }
  }

  Future<void> deleteRecipient({
    required String recipientId,
    required String accessToken,
  }) async {
    final previousState = state;
    // Optimistic removal
    if (previousState is RecipientLoaded) {
      final updatedRecipients = previousState.recipients
          .where((r) => r.id != recipientId)
          .toList();
      if (isClosed) return;
      emit(RecipientLoaded(updatedRecipients));
    }

    try {
      final result = await _deleteRecipientUseCase(
        recipientId: recipientId,
        accessToken: accessToken,
      );
      if (isClosed) return;
      result.fold(
        (failure) {
          emit(previousState);
          emit(RecipientError(failure.message));
        },
        (_) {},
      );
    } catch (e) {
      if (isClosed) return;
      emit(previousState);
      emit(RecipientError(e.toString()));
    }
  }
}
