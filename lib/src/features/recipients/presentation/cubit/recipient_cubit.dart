import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/cache/swr_cache_manager.dart';
import 'package:lazervault/core/cache/cache_config.dart';
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
  final SWRCacheManager? _cacheManager;

  StreamSubscription<SWRResult<List<RecipientModel>>>? _cacheSubscription;

  RecipientCubit({
    required GetRecipientsUseCase getRecipientsUseCase,
    required AddRecipientUseCase addRecipientUseCase,
    required ToggleFavoriteUseCase toggleFavoriteUseCase,
    required UpdateAliasUseCase updateAliasUseCase,
    required DeleteRecipientUseCase deleteRecipientUseCase,
    SWRCacheManager? cacheManager,
  })  : _getRecipientsUseCase = getRecipientsUseCase,
        _addRecipientUseCase = addRecipientUseCase,
        _toggleFavoriteUseCase = toggleFavoriteUseCase,
        _updateAliasUseCase = updateAliasUseCase,
        _deleteRecipientUseCase = deleteRecipientUseCase,
        _cacheManager = cacheManager,
        super(RecipientInitial());

  @override
  Future<void> close() {
    _cacheSubscription?.cancel();
    return super.close();
  }

  String _getCacheKey({String? countryCode, String? currency, bool? favoritesOnly}) {
    return 'recipients:${countryCode ?? 'all'}:${currency ?? 'all'}:${favoritesOnly ?? false}';
  }

  Future<void> getRecipients({
    required String accessToken,
    String? countryCode,
    String? currency,
    bool? favoritesOnly,
    bool forceRefresh = false,
  }) async {
    if (isClosed) return;

    // Cancel any existing subscription
    await _cacheSubscription?.cancel();

    final cacheKey = _getCacheKey(
      countryCode: countryCode,
      currency: currency,
      favoritesOnly: favoritesOnly,
    );

    // Use SWR cache if available
    if (_cacheManager != null && !forceRefresh) {
      _cacheSubscription = _cacheManager!.get<List<RecipientModel>>(
        key: cacheKey,
        fetcher: () => _fetchRecipients(
          accessToken: accessToken,
          countryCode: countryCode,
          currency: currency,
          favoritesOnly: favoritesOnly,
        ),
        config: CacheConfig.recipients,
        deserializer: (json) {
          final list = (jsonDecode(json) as List);
          return list.map((e) => RecipientModel.fromJson(e as Map<String, dynamic>)).toList();
        },
        serializer: (data) => jsonEncode(data.map((e) => e.toJson()).toList()),
      ).listen(
        (result) {
          if (isClosed) return;
          if (result.data != null) {
            final currentState = state;
            if (currentState is RecipientLoaded && result.isRevalidating) {
              // Keep existing data, just update flags
              emit(currentState.copyWith(
                isStale: result.isStale,
                isRevalidating: result.isRevalidating,
              ));
            } else {
              emit(RecipientLoaded(
                result.data!,
                isStale: result.isStale,
                isRevalidating: result.isRevalidating,
              ));
            }
          } else if (result.error != null) {
            // Only emit error if we don't have cached data
            if (state is! RecipientLoaded) {
              emit(RecipientError(result.error.toString()));
            }
          }
        },
        onError: (error) {
          if (isClosed) return;
          if (state is! RecipientLoaded) {
            emit(RecipientError(error.toString()));
          }
        },
      );
    } else {
      // Fallback to direct fetch without caching
      emit(RecipientLoading());
      try {
        final recipients = await _fetchRecipients(
          accessToken: accessToken,
          countryCode: countryCode,
          currency: currency,
          favoritesOnly: favoritesOnly,
        );
        if (isClosed) return;
        emit(RecipientLoaded(recipients));
      } catch (e) {
        if (isClosed) return;
        emit(RecipientError(e.toString()));
      }
    }
  }

  Future<List<RecipientModel>> _fetchRecipients({
    required String accessToken,
    String? countryCode,
    String? currency,
    bool? favoritesOnly,
  }) async {
    final result = await _getRecipientsUseCase(
      accessToken: accessToken,
      countryCode: countryCode,
      currency: currency,
      favoritesOnly: favoritesOnly,
    );
    return result.fold(
      (failure) => throw Exception(failure.message),
      (recipients) => recipients,
    );
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
          // Invalidate cache to ensure fresh data on next fetch
          _cacheManager?.invalidatePattern('recipients:');
          emit(RecipientSuccess('Recipient added successfully', recipient: newRecipient));
          getRecipients(accessToken: accessToken, forceRefresh: true);
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
          // Invalidate cache after successful update
          _cacheManager?.invalidatePattern('recipients:');
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
        (_) {
          // Invalidate cache after successful update
          _cacheManager?.invalidatePattern('recipients:');
        },
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
        (_) {
          // Invalidate cache after successful deletion
          _cacheManager?.invalidatePattern('recipients:');
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(previousState);
      emit(RecipientError(e.toString()));
    }
  }
}
