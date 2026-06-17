import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/ai_scan_session_store.dart';
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

  // Local journal — survives nav-away so a partial scan can resume.
  // Injected via DI; tests can pass a fake. See K3 (session persistence).
  final AiScanSessionStore _store;

  AiScanCubit({
    required this.startScanSessionUseCase,
    required this.processScanUseCase,
    required this.aiChatUseCase,
    required this.generatePaymentUseCase,
    required this.processPaymentUseCase,
    required this.getScanHistoryUseCase,
    required this.scanBankDetailsUseCase,
    required this.processBankDetailsPaymentUseCase,
    AiScanSessionStore? sessionStore,
  })  : _store = sessionStore ?? AiScanSessionStore(),
        super(AiScanInitial());

  /// Surfaced scan types — curated subset of [ScanType.values] that have a
  /// real end-to-end flow wired up (extraction → confirm → pay/redeem).
  ///
  /// Hidden (kept in the enum + proto so backend responses still deserialise,
  /// but not offered in the UI):
  ///   - [ScanType.accountDetails] — duplicate of [ScanType.bankDetails];
  ///     bankDetails is the canonical one-shot "scan + pay" entry point.
  ///   - [ScanType.barcode]        — no end-to-end integration; would dead-end
  ///     at the "Unknown" mock data path.
  ///   - [ScanType.receipt]        — expense-tracking artefact, not a payment
  ///     surface. Out of scope for "Scan to Pay".
  static const List<ScanType> _supportedScanTypes = <ScanType>[
    ScanType.bankDetails,
    ScanType.invoice,
    ScanType.utilityBill,
    ScanType.giftCard,
    ScanType.qrCode,
  ];

  /// Public read of the curated list — exposed so tests / debug UIs can
  /// assert the surface area without poking at private state.
  static List<ScanType> get supportedScanTypes =>
      List.unmodifiable(_supportedScanTypes);

  // Initialize and show scan type selection. Checks for a resumable
  // session first; when one exists the UI shows a "Resume?" prompt and
  // can dispatch [resumeStoredSession] or [discardStoredSession].
  Future<void> initializeScanTypes() async {
    if (isClosed) return;
    final restored = await _store.restore();
    if (restored != null) {
      if (isClosed) return;
      emit(AiScanResumable(
        session: restored.session,
        bankDetails: restored.bankDetails,
        availableTypes: _supportedScanTypes,
      ));
      return;
    }
    emit(AiScanTypeSelection(_supportedScanTypes));
  }

  /// Accept the restored session — jump straight to where the user was.
  /// If we already have extracted bank details, land on the extracted
  /// state so the bottom-sheet pops; otherwise hand back to the camera.
  Future<void> resumeStoredSession() async {
    final current = state;
    if (current is! AiScanResumable) return;
    _currentSession = current.session;
    if (current.bankDetails != null) {
      emit(AiScanBankDetailsExtracted(
        session: current.session,
        bankDetails: current.bankDetails!,
      ));
    } else {
      emit(AiScanCamera(session: current.session));
    }
  }

  /// Decline the restore — clear the journal and reveal scan-type tiles.
  Future<void> discardStoredSession() async {
    await _store.clear();
    _currentSession = null;
    if (isClosed) return;
    emit(AiScanTypeSelection(_supportedScanTypes));
  }

  // Start a new scan session with selected type
  Future<void> startScanSession(ScanType scanType) async {
    try {
      if (isClosed) return;
      emit(const AiScanLoading(message: 'Initializing scan session...'));

      final session = await startScanSessionUseCase(scanType);
      _currentSession = session;

      // Journal the freshly-created session so it can be resumed if
      // the user navigates away before completing the scan.
      // Fire-and-forget — a write failure must not block the scan.
      // ignore: discarded_futures
      _store.save(session: session);

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

  // NOTE: the legacy processPayment / AiScanPaymentProcessing /
  // AiScanPaymentSuccess flow was removed. It was emitted only via the
  // generic AiScanChatActive path and never reached the canonical
  // money path (the bank-details flow via processBankDetailsImage →
  // initiatePayment → processPaymentWithPIN is the source of truth).
  // The data-layer `processPaymentUseCase` / `generatePaymentUseCase`
  // remain in place because they're independent of the UI flow; if a
  // future "pay-via-chat" surface is rebuilt it'll wire to them
  // directly.

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
    emit(AiScanTypeSelection(_supportedScanTypes));
  }

  // Return to camera from chat
  void returnToCamera() {
    final currentState = state;
    if (currentState is AiScanChatActive) {
      if (isClosed) return;
      emit(AiScanCamera(session: currentState.session));
    }
  }

  // Reset to initial state. Also clears the resume journal — a manual
  // reset is the user saying "discard whatever was in flight".
  void reset() {
    if (isClosed) return;
    _currentSession = null;
    // ignore: discarded_futures
    _store.clear();
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

      // Re-journal — the user has invested OCR work; persist both the
      // session and the extracted details so a nav-away can resume
      // straight back into the bottom sheet without re-scanning.
      // ignore: discarded_futures
      _store.save(session: _currentSession!, bankDetails: bankDetails);

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

      // Show receipt. Payment landed — drop the resume journal so the
      // next AI Scan visit starts fresh instead of offering to resume
      // an already-paid session.
      // ignore: discarded_futures
      _store.clear();
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