import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import '../domain/entities/microservice_chat_message_entity.dart';
import '../domain/usecases/send_microservice_chat_message_usecase.dart';
import '../domain/usecases/load_microservice_chat_history_usecase.dart';
import 'microservice_chat_state.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

class MicroserviceChatCubit extends Cubit<MicroserviceChatState> {
  final SendMicroserviceChatMessageUseCase sendMessageUseCase;
  final LoadMicroserviceChatHistoryUseCase? loadHistoryUseCase;
  final AuthenticationCubit authCubit;
  final String sourceContext;

  List<MicroserviceChatMessageEntity> _currentMessages = [];
  late String _sessionId;

  MicroserviceChatCubit({
    required this.sendMessageUseCase,
    this.loadHistoryUseCase,
    required this.authCubit,
    required this.sourceContext,
  }) : super(const MicroserviceChatInitial());

  /// Initialize chat with a deterministic or provided session ID.
  /// Includes locale in session_id so each locale gets its own session.
  void initializeChat({String? persistentSessionId}) {
    final locale = serviceLocator<LocaleManager>().currentLocale;
    if (persistentSessionId != null) {
      _sessionId = persistentSessionId;
    } else {
      // Deterministic ID from user + context + locale
      final authState = authCubit.state;
      if (authState is AuthenticationSuccess) {
        _sessionId = 'svc_${authState.profile.user.id}_${sourceContext}_$locale';
      } else {
        _sessionId = 'svc_unknown_${sourceContext}_$locale';
      }
    }
    _currentMessages = [];
    emit(MicroserviceChatInitial(messages: _currentMessages));
  }

  /// Load chat history from backend.
  Future<void> loadHistory() async {
    if (loadHistoryUseCase == null) return;

    emit(MicroserviceChatHistoryLoading(messages: _currentMessages));

    // Get active locale for locale-filtered history
    final locale = serviceLocator<LocaleManager>().currentLocale;

    final result = await loadHistoryUseCase!(
      sourceContext: sourceContext,
      sessionId: _sessionId,
      accessToken: '', // Token injected by interceptor
      locale: locale,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        // History load failed — start fresh
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
    if (text.trim().isEmpty) return;

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

    final result = await sendMessageUseCase(
      message: text,
      sessionId: _sessionId,
      userId: authState.profile.user.id,
      accessToken: '', // Access token is managed by GrpcCallOptionsHelper
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
  }

  void clearChat() {
    _currentMessages = [];
    emit(MicroserviceChatInitial(messages: _currentMessages));
  }
}
