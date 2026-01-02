import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/scan_entities.dart';
import '../../domain/usecases/ai_scan_usecases.dart';
import 'ai_scan_state.dart';

class AiScanCubit extends Cubit<AiScanState> {
  final StartScanSessionUseCase startScanSessionUseCase;
  final ProcessScanUseCase processScanUseCase;
  final AiChatUseCase aiChatUseCase;
  final GeneratePaymentUseCase generatePaymentUseCase;
  final ProcessPaymentUseCase processPaymentUseCase;
  final GetScanHistoryUseCase getScanHistoryUseCase;

  AiScanCubit({
    required this.startScanSessionUseCase,
    required this.processScanUseCase,
    required this.aiChatUseCase,
    required this.generatePaymentUseCase,
    required this.processPaymentUseCase,
    required this.getScanHistoryUseCase,
  }) : super(AiScanInitial());

  // Initialize and show scan type selection
  void initializeScanTypes() {
    if (isClosed) return;
    emit(AiScanTypeSelection(ScanType.values));
  }

  // Start a new scan session with selected type
  Future<void> startScanSession(ScanType scanType) async {
    try {
      if (isClosed) return;
      emit(const AiScanLoading(message: 'Initializing scan session...'));
      
      final session = await startScanSessionUseCase(scanType);
      
      // Navigate to camera for scanning
      if (isClosed) return;
      emit(AiScanCamera(session: session));
    } catch (e) {
      if (isClosed) return;
      emit(AiScanError(message: 'Failed to start scan session: ${e.toString()}'));
    }
  }

  // Capture and process image
  Future<void> captureAndProcessImage(String imagePath) async {
    final currentState = state;
    if (currentState is! AiScanCamera) return;

    try {
      if (isClosed) return;
      emit(AiScanCamera(session: currentState.session, isCapturing: true));
      
      // Update session status
      if (isClosed) return;
      emit(AiScanProcessing(
        session: currentState.session,
        status: 'Processing image...',
        progress: 0.3,
      ));

      // Extract data from image
      final extractedData = await processScanUseCase(imagePath, currentState.session.scanType);
      
      if (isClosed) return;
      emit(AiScanProcessing(
        session: currentState.session,
        status: 'Analyzing content...',
        progress: 0.7,
      ));

      // Get initial chat history and add AI response with extracted data
      final chatHistory = <AiChatMessage>[];
      
      // Generate AI response based on extracted data
      final aiResponse = await aiChatUseCase(
        currentState.session.id,
        'Image processed',
        extractedData: extractedData,
      );

      chatHistory.add(aiResponse);

      // Transition to chat with extracted data
      if (isClosed) return;
      emit(AiScanChatActive(
        session: currentState.session,
        messages: chatHistory,
        extractedData: extractedData,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(AiScanError(message: 'Failed to process image: ${e.toString()}'));
    }
  }

  // Send message in chat
  Future<void> sendChatMessage(String message) async {
    final currentState = state;
    if (currentState is! AiScanChatActive) return;

    try {
      // Add user message immediately
      final userMessage = AiChatMessage(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        content: message,
        isUser: true,
        timestamp: DateTime.now(),
      );

      final updatedMessages = [...currentState.messages, userMessage];
      
      if (isClosed) return;
      emit(currentState.copyWith(
        messages: updatedMessages,
        isTyping: true,
      ));

      // Get AI response
      final aiResponse = await aiChatUseCase(
        currentState.session.id,
        message,
        extractedData: currentState.extractedData,
      );

      final finalMessages = [...updatedMessages, aiResponse];

      if (isClosed) return;
      emit(currentState.copyWith(
        messages: finalMessages,
        isTyping: false,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(AiScanError(message: 'Failed to send message: ${e.toString()}'));
    }
  }

  // Process payment based on extracted data
  Future<void> processPayment() async {
    final currentState = state;
    if (currentState is! AiScanChatActive || currentState.extractedData == null) return;

    try {
      if (isClosed) return;
      emit(const AiScanLoading(message: 'Generating payment instructions...'));

      final paymentInstruction = await generatePaymentUseCase(
        currentState.extractedData!,
        currentState.session.scanType,
      );

      if (isClosed) return;
      emit(AiScanPaymentProcessing(
        instruction: paymentInstruction,
        status: 'Processing payment...',
      ));

      final success = await processPaymentUseCase(paymentInstruction);

      if (success) {
        if (isClosed) return;
        emit(AiScanPaymentSuccess(
          instruction: paymentInstruction,
          transactionId: 'txn_${DateTime.now().millisecondsSinceEpoch}',
        ));
      } else {
        if (isClosed) return;
        emit(const AiScanError(message: 'Payment processing failed. Please try again.'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(AiScanError(message: 'Payment failed: ${e.toString()}'));
    }
  }

  // Load scan history
  Future<void> loadScanHistory() async {
    try {
      if (isClosed) return;
      emit(const AiScanLoading(message: 'Loading scan history...'));
      
      final sessions = await getScanHistoryUseCase();
      
      if (isClosed) return;
      emit(AiScanHistoryLoaded(sessions));
    } catch (e) {
      if (isClosed) return;
      emit(AiScanError(message: 'Failed to load scan history: ${e.toString()}'));
    }
  }

  // Return to scan type selection
  void returnToScanTypeSelection() {
    if (isClosed) return;
    emit(AiScanTypeSelection(ScanType.values));
  }

  // Return to camera from chat
  void returnToCamera() {
    final currentState = state;
    if (currentState is AiScanChatActive) {
      if (isClosed) return;
      emit(AiScanCamera(session: currentState.session));
    }
  }

  // Reset to initial state
  void reset() {
    if (isClosed) return;
    emit(AiScanInitial());
  }

  // Handle manual image upload instead of camera
  Future<void> uploadImage(String imagePath) async {
    final currentState = state;
    if (currentState is! AiScanCamera) return;

    await captureAndProcessImage(imagePath);
  }

  // Update scan session status
  Future<void> updateSessionStatus(ScanStatus status) async {
    final currentState = state;
    ScanSession? session;
    
    if (currentState is AiScanCamera) {
      session = currentState.session;
    } else if (currentState is AiScanChatActive) {
      session = currentState.session;
    } else if (currentState is AiScanSessionActive) {
      session = currentState.session;
    }

    if (session != null) {
      final updatedSession = session.copyWith(status: status);
      
      // Emit updated state based on current state type
      if (currentState is AiScanCamera) {
        if (isClosed) return;
        emit(AiScanCamera(session: updatedSession));
      } else if (currentState is AiScanChatActive) {
        if (isClosed) return;
        emit(currentState.copyWith(session: updatedSession));
      }
    }
  }
} 