import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/scan_entities.dart';
import '../../domain/exceptions/scan_exceptions.dart';
import '../../domain/usecases/ai_scan_usecases.dart';
import 'ai_scan_state.dart';

class AiScanCubit extends Cubit<AiScanState> {
  final StartScanSessionUseCase startScanSessionUseCase;
  final ProcessScanUseCase processScanUseCase;
  final AiChatUseCase aiChatUseCase;
  final GeneratePaymentUseCase generatePaymentUseCase;
  final ProcessPaymentUseCase processPaymentUseCase;
  final GetScanHistoryUseCase getScanHistoryUseCase;
  final ScanBankDetailsUseCase scanBankDetailsUseCase;
  final ProcessBankDetailsPaymentUseCase processBankDetailsPaymentUseCase;

  // Track current session for bank details flow
  ScanSession? _currentSession;

  AiScanCubit({
    required this.startScanSessionUseCase,
    required this.processScanUseCase,
    required this.aiChatUseCase,
    required this.generatePaymentUseCase,
    required this.processPaymentUseCase,
    required this.getScanHistoryUseCase,
    required this.scanBankDetailsUseCase,
    required this.processBankDetailsPaymentUseCase,
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

  // ========== Bank Details Flow Methods ==========

  /// Process bank details image and extract data
  Future<void> processBankDetailsImage(String imagePath) async {
    try {
      if (isClosed) return;
      emit(AiScanProcessing(
        session: _currentSession!,
        status: 'Extracting bank details...',
        progress: 0.3,
      ));

      // Extract bank details via OCR
      final bankDetails = await scanBankDetailsUseCase(imagePath, _currentSession!.id);

      // Show bottomsheet for editing (confidence warnings shown in UI)
      if (isClosed) return;
      emit(AiScanBankDetailsExtracted(
        session: _currentSession!,
        bankDetails: bankDetails,
      ));
    } on OCRException catch (e) {
      if (isClosed) return;
      emit(AiScanError(
        message: e.getUserMessage(),
        details: e.details,
      ));
    } on NetworkException catch (e) {
      if (isClosed) return;
      emit(AiScanError(
        message: e.getUserMessage(),
        details: e.details,
      ));
    } on AuthenticationException catch (e) {
      if (isClosed) return;
      emit(AiScanError(
        message: e.getUserMessage(),
        details: e.details,
      ));
    } on RateLimitException catch (e) {
      if (isClosed) return;
      emit(AiScanError(
        message: e.getUserMessage(),
        details: e.details,
      ));
    } on ScanException catch (e) {
      if (isClosed) return;
      emit(AiScanError(
        message: e.getUserMessage(),
        details: e.details,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(AiScanError(
        message: 'An unexpected error occurred',
        details: e.toString(),
      ));
    }
  }

  /// Initiate payment with bank details
  Future<void> initiatePayment({
    required BankDetails bankDetails,
    required double amount,
    required String description,
  }) async {
    try {
      // Generate transaction ID for idempotency
      final transactionId = 'TRF-${DateTime.now().millisecondsSinceEpoch}';

      // Show PIN modal by emitting awaiting PIN state
      if (isClosed) return;
      emit(AiScanBankDetailsAwaitingPIN(
        bankDetails: bankDetails,
        amount: amount,
        description: description,
        transactionId: transactionId,
      ));

      // PIN entry handled by UI, wait for PIN verification
      // processPaymentWithPIN will be called after PIN is verified
    } catch (e) {
      if (isClosed) return;
      emit(AiScanError(message: 'Payment initiation failed: ${e.toString()}'));
    }
  }

  /// Process payment with verified PIN
  Future<void> processPaymentWithPIN({
    required BankDetails bankDetails,
    required double amount,
    required String description,
    required String verificationToken,
    required String transactionId,
  }) async {
    try {
      // Step 1: Verifying PIN
      if (isClosed) return;
      emit(const AiScanBankDetailsProcessing(
        status: 'Verifying your PIN...',
        progress: 0.2,
      ));

      await Future.delayed(const Duration(milliseconds: 500)); // Simulate PIN verification

      // Step 2: Validating account
      if (isClosed) return;
      emit(const AiScanBankDetailsProcessing(
        status: 'Validating account details...',
        progress: 0.4,
      ));

      await Future.delayed(const Duration(milliseconds: 500));

      // Step 3: Processing payment
      if (isClosed) return;
      emit(AiScanBankDetailsProcessing(
        status: bankDetails.isExternal
            ? 'Initiating bank transfer...'
            : 'Processing payment...',
        progress: 0.6,
      ));

      final receipt = await processBankDetailsPaymentUseCase(
        bankDetails: bankDetails,
        amount: amount,
        description: description,
        verificationToken: verificationToken,
        transactionId: transactionId,
      );

      // Step 4: Updating balance
      if (isClosed) return;
      emit(AiScanBankDetailsProcessing(
        status: bankDetails.isExternal
            ? 'Awaiting confirmation...'
            : 'Updating your balance...',
        progress: 0.8,
      ));

      await Future.delayed(const Duration(milliseconds: 500));

      // Step 5: Generating receipt
      if (isClosed) return;
      emit(const AiScanBankDetailsProcessing(
        status: 'Generating receipt...',
        progress: 1.0,
      ));

      await Future.delayed(const Duration(milliseconds: 300));

      // Show receipt
      if (isClosed) return;
      emit(AiScanBankDetailsPaymentSuccess(receipt: receipt));
    } on PaymentException catch (e) {
      if (isClosed) return;

      emit(AiScanBankDetailsPaymentFailed(
        errorMessage: e.getUserMessage(),
        bankDetails: bankDetails,
        canRetry: e.canRetry,
      ));
    } on ValidationException catch (e) {
      if (isClosed) return;

      emit(AiScanBankDetailsPaymentFailed(
        errorMessage: e.getUserMessage(),
        bankDetails: bankDetails,
        canRetry: false,
      ));
    } on BankValidationException catch (e) {
      if (isClosed) return;

      emit(AiScanBankDetailsPaymentFailed(
        errorMessage: e.getUserMessage(),
        bankDetails: bankDetails,
        canRetry: e.canRetry,
      ));
    } on NetworkException catch (e) {
      if (isClosed) return;

      emit(AiScanBankDetailsPaymentFailed(
        errorMessage: e.getUserMessage(),
        bankDetails: bankDetails,
        canRetry: e.canRetry,
      ));
    } on AuthenticationException catch (e) {
      if (isClosed) return;

      emit(AiScanBankDetailsPaymentFailed(
        errorMessage: e.getUserMessage(),
        bankDetails: bankDetails,
        canRetry: false,
      ));
    } on RateLimitException catch (e) {
      if (isClosed) return;

      emit(AiScanBankDetailsPaymentFailed(
        errorMessage: e.getUserMessage(),
        bankDetails: bankDetails,
        canRetry: e.canRetry,
      ));
    } on ScanException catch (e) {
      if (isClosed) return;

      emit(AiScanBankDetailsPaymentFailed(
        errorMessage: e.getUserMessage(),
        bankDetails: bankDetails,
        canRetry: e.canRetry,
      ));
    } catch (e) {
      if (isClosed) return;

      emit(AiScanBankDetailsPaymentFailed(
        errorMessage: 'An unexpected error occurred. Please try again.',
        bankDetails: bankDetails,
        canRetry: true,
      ));
    }
  }

  /// Retry payment after failure
  Future<void> retryBankDetailsPayment({
    required BankDetails bankDetails,
    required double amount,
    required String description,
  }) async {
    // Re-initiate payment flow
    await initiatePayment(
      bankDetails: bankDetails,
      amount: amount,
      description: description,
    );
  }
} 