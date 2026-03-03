import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import '../domain/entities/microservice_chat_message_entity.dart';
import '../domain/usecases/send_microservice_chat_message_usecase.dart';
import '../domain/usecases/send_direct_chat_message_usecase.dart';
import '../domain/usecases/load_microservice_chat_history_usecase.dart';
import '../domain/usecases/load_direct_chat_history_usecase.dart';
import 'microservice_chat_state.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

class MicroserviceChatCubit extends Cubit<MicroserviceChatState> {
  final SendMicroserviceChatMessageUseCase sendMessageUseCase;
  final SendDirectChatMessageUseCase? directMessageUseCase;
  final LoadMicroserviceChatHistoryUseCase? loadHistoryUseCase;
  final LoadDirectChatHistoryUseCase? loadDirectHistoryUseCase;
  final AuthenticationCubit authCubit;
  final String sourceContext;
  final bool isDirect;

  List<MicroserviceChatMessageEntity> _currentMessages = [];
  late String _sessionId;

  /// Entity storage for direct chat round-tripping.
  Map<String, dynamic> _entities = {};

  /// Guard against concurrent sendMessage calls from rapid taps.
  bool _isSending = false;

  MicroserviceChatCubit({
    required this.sendMessageUseCase,
    this.directMessageUseCase,
    this.loadHistoryUseCase,
    this.loadDirectHistoryUseCase,
    required this.authCubit,
    required this.sourceContext,
    this.isDirect = false,
  }) : super(const MicroserviceChatInitial());

  /// Initialize chat with a deterministic or provided session ID.
  /// Includes locale in session_id so each locale gets its own session.
  void initializeChat({String? persistentSessionId}) {
    final locale = serviceLocator<LocaleManager>().currentLocale;
    if (persistentSessionId != null) {
      _sessionId = persistentSessionId;
    } else {
      final authState = authCubit.state;
      final prefix = isDirect ? 'direct' : 'svc';
      if (authState is AuthenticationSuccess) {
        _sessionId = '${prefix}_${authState.profile.user.id}_${sourceContext}_$locale';
      } else {
        _sessionId = '${prefix}_unknown_${sourceContext}_$locale';
      }
    }
    _currentMessages = [];
    _entities = {};
    emit(MicroserviceChatInitial(messages: _currentMessages));
  }

  /// Load chat history from backend.
  Future<void> loadHistory() async {
    emit(MicroserviceChatHistoryLoading(messages: _currentMessages));

    final locale = serviceLocator<LocaleManager>().currentLocale;

    // Use direct history use case when in direct mode
    if (isDirect && loadDirectHistoryUseCase != null) {
      final result = await loadDirectHistoryUseCase!(
        sourceContext: sourceContext,
        sessionId: _sessionId,
        accessToken: '',
        locale: locale,
      );

      if (isClosed) return;
      result.fold(
        (failure) {
          emit(MicroserviceChatInitial(messages: _currentMessages));
        },
        (history) {
          _currentMessages = history;
          if (_currentMessages.isEmpty) {
            emit(MicroserviceChatInitial(messages: _currentMessages));
          } else {
            emit(MicroserviceChatMessageSuccess(messages: List.from(_currentMessages)));
          }
        },
      );
      return;
    }

    // Fallback to standard history loading
    if (loadHistoryUseCase == null) return;

    final result = await loadHistoryUseCase!(
      sourceContext: sourceContext,
      sessionId: _sessionId,
      accessToken: '',
      locale: locale,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        emit(MicroserviceChatInitial(messages: _currentMessages));
      },
      (history) {
        _currentMessages = history;
        if (_currentMessages.isEmpty) {
          emit(MicroserviceChatInitial(messages: _currentMessages));
        } else {
          emit(MicroserviceChatMessageSuccess(messages: List.from(_currentMessages)));
        }
      },
    );
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty || _isSending) return;
    _isSending = true;

    try {
      final authState = authCubit.state;
      if (authState is! AuthenticationSuccess) {
        emit(MicroserviceChatMessageError(
          errorMessage: 'User not authenticated',
          messages: List.from(_currentMessages),
        ));
        return;
      }

      // Add user message immediately
      final userMessage = MicroserviceChatMessageEntity(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      );
      _currentMessages.add(userMessage);

      emit(MicroserviceChatMessageLoading(messages: List.from(_currentMessages)));

      final locale = serviceLocator<LocaleManager>().currentLocale;

      // Use direct path if enabled and use case available
      if (isDirect && directMessageUseCase != null) {
        final result = await directMessageUseCase!(
          message: text,
          sessionId: _sessionId,
          userId: authState.profile.user.id,
          accessToken: '',
          sourceContext: sourceContext,
          entities: _entities,
          accountId: '',  // Resolved from JWT by Go gateway
          userCountry: authState.profile.user.country ?? '',
          currency: authState.profile.user.currency ?? '',
          language: 'en',
          locale: locale,
        );

        if (isClosed) return;
        result.fold(
          (failure) {
            emit(MicroserviceChatMessageError(
              errorMessage: failure.message,
              messages: List.from(_currentMessages),
            ));
          },
          (chatResponse) {
            // REPLACE, not merge — agent is source of truth
            // Always replace, even with empty map (agent clears state after completed operations)
            _entities = Map<String, dynamic>.from(chatResponse.entities);

            final botMessage = MicroserviceChatMessageEntity(
              text: chatResponse.response,
              isUser: false,
              timestamp: DateTime.now(),
              serviceRoutedTo: chatResponse.serviceRoutedTo,
            );
            _currentMessages.add(botMessage);

            emit(MicroserviceChatMessageSuccess(messages: List.from(_currentMessages)));
          },
        );
        return;
      }

      // Standard path (Python gateway) — clear entities since this path doesn't support them
      _entities = {};

      final result = await sendMessageUseCase(
        message: text,
        sessionId: _sessionId,
        userId: authState.profile.user.id,
        accessToken: '',
        sourceContext: sourceContext,
        language: 'en',
        locale: locale,
      );

      if (isClosed) return;
      result.fold(
        (failure) {
          emit(MicroserviceChatMessageError(
            errorMessage: failure.message,
            messages: List.from(_currentMessages),
          ));
        },
        (response) {
          final botMessage = MicroserviceChatMessageEntity(
            text: response,
            isUser: false,
            timestamp: DateTime.now(),
          );
          _currentMessages.add(botMessage);

          emit(MicroserviceChatMessageSuccess(messages: List.from(_currentMessages)));
        },
      );
    } finally {
      _isSending = false;
    }
  }

  /// Maximum media file size (10MB for images, 25MB for audio).
  static const int _maxImageSize = 10 * 1024 * 1024;
  static const int _maxAudioSize = 25 * 1024 * 1024;

  /// Send a media message (image or voice note) through the Python gateway path.
  Future<void> sendMediaMessage({
    required String mediaType, // 'image' | 'voice'
    required String localFilePath,
    required String mimeType,
    String text = '',
    int? audioDurationMs,
  }) async {
    final authState = authCubit.state;
    if (authState is! AuthenticationSuccess) {
      emit(MicroserviceChatMessageError(
        errorMessage: 'User not authenticated',
        messages: List.from(_currentMessages),
      ));
      return;
    }

    // Validate file exists and check size before reading into memory
    final file = File(localFilePath);
    if (!file.existsSync()) {
      emit(MicroserviceChatMessageError(
        errorMessage: 'The media file could not be found. Please try again.',
        messages: List.from(_currentMessages),
      ));
      return;
    }

    final fileSize = file.lengthSync();
    final maxSize = mediaType == 'image' ? _maxImageSize : _maxAudioSize;
    if (fileSize > maxSize) {
      final maxMB = maxSize ~/ (1024 * 1024);
      emit(MicroserviceChatMessageError(
        errorMessage: 'File is too large (max ${maxMB}MB). Please choose a smaller file.',
        messages: List.from(_currentMessages),
      ));
      return;
    }
    if (fileSize == 0) {
      emit(MicroserviceChatMessageError(
        errorMessage: 'The file appears to be empty. Please try again.',
        messages: List.from(_currentMessages),
      ));
      return;
    }

    // Read file and base64-encode
    final bytes = await file.readAsBytes();
    if (isClosed) return;
    final base64Data = base64Encode(bytes);

    // Add user message with media preview immediately
    final displayText = text.isNotEmpty
        ? text
        : (mediaType == 'image' ? 'Sent an image' : 'Sent a voice note');
    final userMessage = MicroserviceChatMessageEntity(
      text: displayText,
      isUser: true,
      timestamp: DateTime.now(),
      mediaType: mediaType,
      localMediaPath: localFilePath,
      audioDurationMs: audioDurationMs,
    );
    _currentMessages.add(userMessage);
    emit(MicroserviceChatMessageLoading(messages: List.from(_currentMessages)));

    final locale = serviceLocator<LocaleManager>().currentLocale;

    // Always use standard (Python gateway) path for media
    final result = await sendMessageUseCase(
      message: text,
      sessionId: _sessionId,
      userId: authState.profile.user.id,
      accessToken: '',
      sourceContext: sourceContext,
      language: 'en',
      locale: locale,
      mediaBase64: base64Data,
      mediaType: mediaType,
      mediaMimeType: mimeType,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        emit(MicroserviceChatMessageError(
          errorMessage: failure.message,
          messages: List.from(_currentMessages),
        ));
      },
      (response) {
        final botMessage = MicroserviceChatMessageEntity(
          text: response,
          isUser: false,
          timestamp: DateTime.now(),
        );
        _currentMessages.add(botMessage);
        emit(MicroserviceChatMessageSuccess(messages: List.from(_currentMessages)));
      },
    );
  }

  void clearChat() {
    _currentMessages = [];
    _entities = {};
    emit(MicroserviceChatInitial(messages: _currentMessages));
  }
}
