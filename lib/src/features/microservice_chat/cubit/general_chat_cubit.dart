import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import '../domain/entities/general_chat_message_entity.dart';
import '../domain/usecases/send_general_chat_message_usecase.dart';
import '../domain/usecases/load_microservice_chat_history_usecase.dart';
import 'general_chat_state.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

/// Cubit for managing general chat state through the Enhanced Chat Gateway
///
/// Features:
/// - LLM-based intent classification
/// - Conversation state management (Redis)
/// - Service switching detection
/// - Multi-service conversation support
///
/// This differs from MicroserviceChatCubit in that:
/// - All messages flow through the intelligent gateway
/// - Gateway uses LLM to classify intent and route appropriately
/// - Conversation state maintained across service switches
/// - Supports multi-service conversations with context awareness
class GeneralChatCubit extends Cubit<GeneralChatState> {
  final SendGeneralChatMessageUseCase sendMessageUseCase;
  final LoadMicroserviceChatHistoryUseCase? loadHistoryUseCase;
  final AuthenticationCubit authCubit;

  List<GeneralChatMessageEntity> _currentMessages = [];
  late String _sessionId;
  String? _currentService;
  final List<String> _conversationServices = [];

  GeneralChatCubit({
    required this.sendMessageUseCase,
    this.loadHistoryUseCase,
    required this.authCubit,
  }) : super(const GeneralChatInitial());

  String _buildSessionId() {
    final locale = serviceLocator<LocaleManager>().currentLocale;
    final authState = authCubit.state;
    if (authState is AuthenticationSuccess) {
      return 'general_${authState.profile.user.id}_$locale';
    }
    return 'general_unknown_$locale';
  }

  void initializeChat() {
    _sessionId = _buildSessionId();
    _currentMessages = [];
    _currentService = null;
    _conversationServices.clear();
    emit(GeneralChatInitial(messages: _currentMessages));

    // Add welcome message for Enhanced Gateway
    final welcomeMessage = GeneralChatMessageEntity(
      text: '''👋 Hi! I'm Lazer, your LazerVault assistant!

I use AI to understand what you need and route you to the right service:

🏦 **Banking** - Check balances, transfer money
📈 **Investments** - Manage your portfolio
💳 **Payments** - Pay bills, buy airtime
🎁 **Gift Cards** - Purchase and redeem cards
📋 **Invoices** - Create and track invoices
🏡 **Insurance** - Get insurance policies
💰 **Savings** - Autosave, lock funds, crowdfunding

Just ask me anything naturally! I'll understand your intent and help you.''',
      isUser: false,
      timestamp: DateTime.now(),
      serviceRoutedTo: 'gateway',
      metadata: {
        'type': 'welcome',
        'gateway_version': 'enhanced',
        'isSystemMessage': true,
      },
    );
    _currentMessages.add(welcomeMessage);
    emit(GeneralChatInitial(messages: List.from(_currentMessages)));
  }

  /// Load chat history from backend.
  Future<void> loadHistory() async {
    if (loadHistoryUseCase == null) return;

    emit(GeneralChatHistoryLoading(messages: _currentMessages));

    final locale = serviceLocator<LocaleManager>().currentLocale;

    final result = await loadHistoryUseCase!(
      sourceContext: 'general',
      sessionId: _sessionId,
      accessToken: '', // Token injected by interceptor
      locale: locale,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        // History load failed — keep welcome message
        emit(GeneralChatInitial(messages: _currentMessages));
      },
      (history) {
        if (history.isNotEmpty) {
          // Map MicroserviceChatMessageEntity to GeneralChatMessageEntity
          final historyMessages = history.map((msg) => GeneralChatMessageEntity(
            text: msg.text,
            isUser: msg.isUser,
            timestamp: msg.timestamp,
            serviceRoutedTo: msg.serviceRoutedTo,
          )).toList();

          // Replace welcome message with actual history
          _currentMessages = historyMessages;
          emit(GeneralChatSuccess(messages: List.from(_currentMessages)));
        } else {
          // No history — keep welcome message
          emit(GeneralChatInitial(messages: _currentMessages));
        }
      },
    );
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final authState = authCubit.state;
    if (authState is! AuthenticationSuccess) {
      emit(GeneralChatError(
        errorMessage: 'User not authenticated',
        messages: List.from(_currentMessages),
      ));
      return;
    }

    // Add user message immediately
    final userMessage = GeneralChatMessageEntity(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );
    _currentMessages.add(userMessage);

    emit(GeneralChatLoading(messages: List.from(_currentMessages)));

    final locale = serviceLocator<LocaleManager>().currentLocale;

    final result = await sendMessageUseCase(
      message: text,
      sessionId: _sessionId,
      userId: authState.profile.user.id,
      accessToken: '', // Access token is managed by GrpcCallOptionsHelper
      sourceContext: 'general', // Always 'general' for this screen
      language: 'en',
      locale: locale,
    );

    result.fold(
      (failure) {
        emit(GeneralChatError(
          errorMessage: failure.message,
          messages: List.from(_currentMessages),
        ));
      },
      (response) {
        // Extract enhanced response fields
        final serviceRoutedTo = response.serviceRoutedTo;
        final intentClassification = response.intentClassification;
        final conversationState = response.conversationState;
        final shouldSwitchService = response.shouldSwitchService;
        final previousService = response.previousService;

        // Update current service if switched
        if (shouldSwitchService == true && previousService != null) {
          _currentService = serviceRoutedTo;
          if (!_conversationServices.contains(serviceRoutedTo)) {
            _conversationServices.add(serviceRoutedTo);
          }
        }

        // Add system message if service switched
        List<GeneralChatMessageEntity> updatedMessages = List.from(_currentMessages);

        if (shouldSwitchService == true && previousService != null && previousService.isNotEmpty) {
          final switchMessage = GeneralChatMessageEntity(
            text: '🔄 Switching to ${_getServiceDisplayName(serviceRoutedTo)} service...\n\n${intentClassification.reasoning}',
            isUser: false,
            timestamp: DateTime.now(),
            serviceRoutedTo: 'gateway',
            metadata: {
              'type': 'service_switch',
              'from': previousService,
              'to': serviceRoutedTo,
              'confidence': intentClassification.confidence,
              'isSystemMessage': true,
            },
          );
          updatedMessages.add(switchMessage);
        }

        // Add bot response with enhanced metadata
        final botMessage = GeneralChatMessageEntity(
          text: response.response,
          isUser: false,
          timestamp: DateTime.now(),
          serviceRoutedTo: serviceRoutedTo,
          metadata: {
            'intent_confidence': intentClassification.confidence,
            'intent_service': intentClassification.service,
            'intent_reasoning': intentClassification.reasoning,
            'suggested_action': intentClassification.suggestedAction,
            'message_count': conversationState.messageCount,
            'key_entities': conversationState.keyEntities,
            'isSystemMessage': false,
          },
        );
        updatedMessages.add(botMessage);

        _currentMessages = updatedMessages;
        emit(GeneralChatSuccess(
          messages: List.from(_currentMessages),
          currentService: _currentService,
          conversationServices: List.from(_conversationServices),
          intentClassification: {
            'service': intentClassification.service,
            'confidence': intentClassification.confidence,
            'reasoning': intentClassification.reasoning,
            'suggestedAction': intentClassification.suggestedAction,
          },
        ));
      },
    );
  }

  void clearChat() {
    _currentMessages = [];
    _sessionId = _buildSessionId();
    _currentService = null;
    _conversationServices.clear();
    emit(GeneralChatInitial(messages: _currentMessages));
    initializeChat();
  }

  String _getServiceDisplayName(String service) {
    final displayNames = {
      'accounts': 'Accounts',
      'payments': 'Payments',
      'transfers': 'Transfers',
      'investments': 'Investments',
      'financial_products': 'Financial Products',
      'giftcards': 'Gift Cards',
      'invoices': 'Invoices',
      'utility': 'Utility Bills',
    };
    return displayNames[service] ?? service;
  }
}
