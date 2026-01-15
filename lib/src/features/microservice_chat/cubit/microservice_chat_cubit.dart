import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../domain/entities/microservice_chat_message_entity.dart';
import '../domain/usecases/send_microservice_chat_message_usecase.dart';
import 'microservice_chat_state.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

class MicroserviceChatCubit extends Cubit<MicroserviceChatState> {
  final SendMicroserviceChatMessageUseCase sendMessageUseCase;
  final AuthenticationCubit authCubit;
  final String sourceContext;

  List<MicroserviceChatMessageEntity> _currentMessages = [];
  late String _sessionId;

  MicroserviceChatCubit({
    required this.sendMessageUseCase,
    required this.authCubit,
    required this.sourceContext,
  }) : super(const MicroserviceChatInitial()) {
    _sessionId = const Uuid().v4();
  }

  void initializeChat() {
    _sessionId = const Uuid().v4();
    _currentMessages = [];
    emit(MicroserviceChatInitial(messages: _currentMessages));
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

    final result = await sendMessageUseCase(
      message: text,
      sessionId: _sessionId,
      userId: authState.profile.user.id,
      accessToken: '', // Access token is managed by GrpcCallOptionsHelper
      sourceContext: sourceContext,
      language: 'en', // Can be made dynamic
    );

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
    _sessionId = const Uuid().v4();
    emit(MicroserviceChatInitial(messages: _currentMessages));
  }
}
