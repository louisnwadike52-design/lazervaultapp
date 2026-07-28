import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../data/datasources/ai_scan_session_store.dart';
import '../../domain/entities/scan_entities.dart';
import '../../domain/exceptions/scan_exceptions.dart';
import '../../domain/repositories/ai_scan_repository.dart';
import '../../domain/services/scanned_code_classifier.dart';
import '../../domain/usecases/ai_scan_usecases.dart';
import '../../../qr_payment/domain/repositories/qr_payment_repository.dart';
import '../../../pay_invoice/domain/repositories/pay_invoice_repository.dart';
import '../../../funds/data/datasources/payments_transfer_data_source.dart';
import '../../../profile/domain/repositories/i_profile_repository.dart';
import '../../../recipients/data/datasources/bank_scan_datasource.dart'
    show SmartScanResult;
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

  // Unified intelligent-scan dependencies.
  final AiScanRepository aiScanRepository;
  final QRPaymentRepository qrPaymentRepository;
  final PayInvoiceRepository payInvoiceRepository;
  final IPaymentsTransferDataSource paymentsTransferDataSource;
  final IProfileRepository profileRepository;
  final ScannedCodeClassifier _classifier = const ScannedCodeClassifier();

  // Track current session for bank details flow
  ScanSession? _currentSession;

  // Local journal — survives nav-away so a partial scan can resume.
  // Injected via DI; tests can pass a fake. See K3 (session persistence).
  final AiScanSessionStore _store;

  // Backend-driven "Previous scans" history is recorded via [aiScanRepository].
  // The history entry id for the scan currently in flight, so the matching
  // payment can be marked completed against it.
  String? _currentHistoryId;

  AiScanCubit({
    required this.startScanSessionUseCase,
    required this.processScanUseCase,
    required this.aiChatUseCase,
    required this.generatePaymentUseCase,
    required this.processPaymentUseCase,
    required this.getScanHistoryUseCase,
    required this.scanBankDetailsUseCase,
    required this.processBankDetailsPaymentUseCase,
    required this.aiScanRepository,
    required this.qrPaymentRepository,
    required this.payInvoiceRepository,
    required this.paymentsTransferDataSource,
    required this.profileRepository,
    AiScanSessionStore? sessionStore,
  })  : _store = sessionStore ?? AiScanSessionStore(),
        super(AiScanInitial());

  /// Record backend "Previous scans" history off the state stream, so every
  /// resolution / completion path is covered without touching each emit site.
  /// Best-effort — history writes never block or break the money flow.
  @override
  void onChange(Change<AiScanState> change) {
    super.onChange(change);
    final next = change.nextState;
    if (next is AiScanIntentResolved) {
      _currentHistoryId = 'scan-${DateTime.now().microsecondsSinceEpoch}';
      final i = next.intent;
      // ignore: discarded_futures
      aiScanRepository.recordScanHistory(AiScanHistoryEntry(
        id: _currentHistoryId!,
        createdAt: DateTime.now(),
        title: i.title,
        subtitle: i.subtitle,
        typeName: i.type.name,
        amount: i.amount ?? 0,
        currency: i.currency,
        status: 'incomplete',
      ));
    } else if (next is AiScanPaymentCompleted) {
      final id = _currentHistoryId;
      if (id != null) {
        final r = next.receipt;
        // ignore: discarded_futures
        aiScanRepository.recordScanHistory(AiScanHistoryEntry(
          id: id,
          createdAt: r.transactionDate,
          title: r.recipientName,
          subtitle: r.maskedAccountNumber,
          typeName: 'unknown',
          amount: r.amount,
          currency: r.currency,
          status: 'completed',
          receipt: r,
        ));
      }
    }
  }

  /// Load the backend "Previous scans" history.
  Future<void> loadLocalHistory() async {
    if (isClosed) return;
    emit(const AiScanLoading(message: 'Loading your scans...'));
    try {
      final entries = await aiScanRepository.listScanHistory();
      if (isClosed) return;
      emit(AiScanLocalHistoryLoaded(entries));
    } catch (e) {
      if (isClosed) return;
      emit(const AiScanLocalHistoryLoaded([]));
    }
  }

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

  // NOTE: the legacy processPayment / AiScanPaymentProcessing /
  // AiScanPaymentSuccess flow was removed. It was emitted only via the
  // generic AiScanChatActive path and never reached the canonical
  // money path (the bank-details flow via processBankDetailsImage →
  // initiatePayment → processPaymentWithPIN is the source of truth).
  // The data-layer `processPaymentUseCase` / `generatePaymentUseCase`
  // remain in place because they're independent of the UI flow; if a
  // future "pay-via-chat" surface is rebuilt it'll wire to them
  // directly.

  // Reset to initial state. Also clears the resume journal — a manual
  // reset is the user saying "discard whatever was in flight".
  void reset() {
    if (isClosed) return;
    _currentSession = null;
    // ignore: discarded_futures
    _store.clear();
    emit(AiScanInitial());
  }

  // ========== Unified Intelligent-Scan Flow ==========

  /// Analyze a captured/uploaded image and resolve it to a single payable
  /// [ScanPaymentIntent]. Runs the local QR decode and the OCR analysis in
  /// PARALLEL, then applies bank-details-priority routing.
  Future<void> analyzeImage(String imagePath, ScanSource source,
      {bool lean = false}) async {
    if (isClosed) return;
    emit(const AiScanAnalyzing());

    // Ensure a session id exists for the OCR call (server-side session is
    // optional — the OCR endpoint is stateless HTTP).
    final sessionId = _currentSession?.id ??
        'local-${DateTime.now().microsecondsSinceEpoch}';
    _currentSession ??= ScanSession(
      id: sessionId,
      scanType: ScanType.bankDetails,
      createdAt: DateTime.now(),
      status: ScanStatus.analyzing,
    );

    try {
      final results = await Future.wait<dynamic>([
        _decodeQr(imagePath),
        _runOcr(imagePath, sessionId, lean: lean),
      ]);

      final qrIntent = results[0] as ScanPaymentIntent?;
      final analysis = results[1] as ScanAnalysis?;

      if (isClosed) return;

      // 1) Bank-details PRIORITY — a confident document extraction wins. Route
      //    it (and every other OCR-derived target below) through the shared
      //    verify sheet BEFORE any amount is entered, exactly mirroring the
      //    send-funds "Scan Account" flow: the extracted account is confirmed
      //    (NUBAN name resolution) first, so we never send to an unverified
      //    OCR-read account number.
      if (analysis != null && analysis.isBankDetails) {
        emit(AiScanOcrResolved(analysis));
        return;
      }

      // 2) A recognized LazerVault QR (qr-pay / invoice / recipient). A QR code
      //    carries no OCR-read account name to verify, so it goes straight to
      //    the confirm/amount path.
      if (qrIntent != null) {
        emit(AiScanIntentResolved(qrIntent));
        return;
      }

      // 3) Any other OCR-derived payable target — internal user, phone, email,
      //    or an ambiguous value. All get the same review/verify sheet (which
      //    also renders the disambiguation choices) before amount.
      if (analysis != null &&
          (analysis.isInternalUser ||
              analysis.isPhone ||
              analysis.isEmail ||
              analysis.isAmbiguous)) {
        emit(AiScanOcrResolved(analysis));
        return;
      }

      // 4) Nothing payable.
      emit(const AiScanNoDataResult());
    } on ScanException catch (e) {
      if (isClosed) return;
      emit(AiScanNoDataResult(message: e.getUserMessage()));
    } catch (e) {
      if (isClosed) return;
      emit(const AiScanNoDataResult());
    }
  }

  /// On-device fast-path entry: the captured still was OCR'd + parsed on-device
  /// (OnDeviceScanExtractor) into a [SmartScanResult] — no backend GPT-vision
  /// call. Feed it through the SAME state machine as [analyzeImage] so the host
  /// screen opens the identical Verify sheet (NIP name-enquiry + PIN unchanged).
  /// Emits [AiScanAnalyzing] first (so the camera page pops back to the host,
  /// exactly like the backend path), then the resolved state.
  Future<void> resolveOnDeviceScan(SmartScanResult result) async {
    if (isClosed) return;
    emit(const AiScanAnalyzing());
    // Let the Analyzing state settle so the camera page pops back to the host
    // (its listener pops on a post-frame callback) BEFORE we emit the resolved
    // state — otherwise the Verify sheet would open under the camera. The
    // backend path gets this gap for free from the OCR round-trip; on-device we
    // add a short one explicitly.
    await Future.delayed(const Duration(milliseconds: 150));
    final analysis = _analysisFromSmartScan(result);
    if (isClosed) return;
    if (analysis.isBankDetails ||
        analysis.isInternalUser ||
        analysis.isPhone ||
        analysis.isEmail ||
        analysis.isAmbiguous) {
      emit(AiScanOcrResolved(analysis));
    } else {
      emit(const AiScanNoDataResult());
    }
  }

  /// Bridge the send-funds [SmartScanResult] shape onto the AI-scan
  /// [ScanAnalysis] entity (the reverse of the mapping `_handleOcrResolved`
  /// does when opening the sheet). amount_minor → major units.
  ScanAnalysis _analysisFromSmartScan(SmartScanResult r) {
    return ScanAnalysis(
      extractionType: r.extractionType,
      accountNumber: r.accountNumber,
      accountName: r.accountName,
      bankName: r.bankName,
      bankCode: r.bankCode,
      username: r.username,
      displayName: r.displayName,
      phoneNumber: r.phoneNumber,
      email: r.email,
      amount: (r.amountMinor != null && r.amountMinor! > 0)
          ? r.amountMinor! / 100.0
          : null,
      description: r.description,
      possibleTypes: r.possibleTypes,
      disambiguationHint: r.disambiguationHint,
      confidence: r.confidence,
    );
  }

  /// Resolve an ambiguous scan to a concrete intent (user picked account vs
  /// phone in the disambiguation sheet) → drives the confirm screen.
  void emitIntent(ScanPaymentIntent intent) {
    if (isClosed) return;
    emit(AiScanIntentResolved(intent));
  }

  /// Decode the first barcode in a still image and classify it. Never throws —
  /// returns null so the OCR result can still win.
  Future<ScanPaymentIntent?> _decodeQr(String imagePath) async {
    final controller = MobileScannerController();
    try {
      final capture = await controller.analyzeImage(imagePath);
      final barcodes = capture?.barcodes ?? const [];
      for (final b in barcodes) {
        final raw = b.rawValue;
        if (raw == null || raw.isEmpty) continue;
        final intent = _classifier.classify(raw);
        if (intent != null) return intent;
      }
      return null;
    } catch (_) {
      return null;
    } finally {
      // ignore: discarded_futures
      controller.dispose();
    }
  }

  /// Run the OCR analysis. Never throws for "no data" cases — returns null so
  /// a QR result can win; only genuine auth/network errors propagate.
  Future<ScanAnalysis?> _runOcr(String imagePath, String sessionId,
      {bool lean = false}) async {
    try {
      return await aiScanRepository.analyzeScan(imagePath, sessionId,
          lean: lean);
    } on ScanException {
      rethrow;
    } catch (_) {
      return null;
    }
  }

  /// Pay the resolved [intent]. Branches by [ScanIntentType] to the matching
  /// existing domain repo and maps the response into the unified
  /// [PaymentReceipt]. The PIN [verificationToken] is obtained on the confirm
  /// screen via TransactionPinMixin BEFORE calling.
  Future<void> pay({
    required ScanPaymentIntent intent,
    required String verificationToken,
    required String sourceAccountId,
    required double amount,
    String? description,
  }) async {
    if (isClosed) return;
    emit(const AiScanPaying(status: 'Processing payment...', progress: 0.3));

    try {
      switch (intent.type) {
        case ScanIntentType.bankDetails:
          await _payBankDetails(intent, verificationToken, amount, description);
          break;
        case ScanIntentType.qrPay:
          await _payQr(intent, verificationToken, sourceAccountId, amount);
          break;
        case ScanIntentType.invoice:
          await _payInvoice(intent, sourceAccountId, amount, description);
          break;
        case ScanIntentType.recipient:
          await _payRecipient(
              intent, verificationToken, sourceAccountId, amount, description);
          break;
        case ScanIntentType.unknown:
          _failPayment(intent, 'This scan target is not supported.', false);
          break;
      }
    } on ScanException catch (e) {
      _failPayment(intent, e.getUserMessage(), e.canRetry);
    } catch (e) {
      _failPayment(
          intent, e.toString().replaceAll('Exception: ', ''), true);
    }
  }

  void _failPayment(ScanPaymentIntent intent, String message, bool canRetry) {
    if (isClosed) return;
    emit(AiScanPaymentFailedResult(
      message: message,
      intent: intent,
      canRetry: canRetry,
    ));
  }

  Future<void> _payBankDetails(
    ScanPaymentIntent intent,
    String verificationToken,
    double amount,
    String? description,
  ) async {
    final bank = intent.bankDetails;
    if (bank == null) {
      _failPayment(intent, 'Bank details are missing.', false);
      return;
    }
    final transactionId = 'TRF-${DateTime.now().millisecondsSinceEpoch}';
    final receipt = await processBankDetailsPaymentUseCase(
      bankDetails: bank,
      amount: amount,
      description: description ?? intent.description ?? '',
      verificationToken: verificationToken,
      transactionId: transactionId,
    );
    if (isClosed) return;
    // ignore: discarded_futures
    _store.clear();
    emit(AiScanPaymentCompleted(receipt));
  }

  Future<void> _payQr(
    ScanPaymentIntent intent,
    String verificationToken,
    String sourceAccountId,
    double amount,
  ) async {
    final qrCode = intent.qrCode;
    if (qrCode == null || qrCode.isEmpty) {
      _failPayment(intent, 'QR code is missing.', false);
      return;
    }
    final result = await qrPaymentRepository.processQRPayment(
      qrCode: qrCode,
      sourceAccountId: sourceAccountId,
      amount: amount,
      transactionPin: verificationToken,
    );
    if (isClosed) return;
    result.fold(
      (failure) => _failPayment(intent, failure.message, true),
      (tuple) {
        final txn = tuple.$1;
        emit(AiScanPaymentCompleted(PaymentReceipt(
          id: txn.id,
          reference: txn.referenceNumber,
          recipientName: txn.recipientName.isNotEmpty
              ? txn.recipientName
              : (intent.title),
          accountNumber: txn.recipientUsername,
          bankName: 'LazerVault',
          amount: txn.amount,
          currency: txn.currency,
          status: txn.status.name,
          description: txn.description,
          transactionDate: txn.createdAt,
          isExternal: false,
        )));
      },
    );
  }

  Future<void> _payInvoice(
    ScanPaymentIntent intent,
    String sourceAccountId,
    double amount,
    String? description,
  ) async {
    final invoiceId = intent.invoiceId;
    if (invoiceId == null || invoiceId.isEmpty) {
      _failPayment(intent, 'Invoice id is missing.', false);
      return;
    }
    final result = await payInvoiceRepository.payInvoice(
      invoiceId,
      PaymentDetails(
        method: PaymentMethod.accountBalance,
        amount: amount,
        currency: intent.currency,
        accountId: sourceAccountId,
        reference: 'AISCAN-${DateTime.now().millisecondsSinceEpoch}',
      ),
    );
    if (isClosed) return;
    if (result.success) {
      emit(AiScanPaymentCompleted(PaymentReceipt(
        id: result.transactionId ?? invoiceId,
        reference: result.paymentReference ?? result.transactionId ?? invoiceId,
        recipientName: intent.title,
        accountNumber: invoiceId,
        bankName: 'Invoice',
        amount: amount,
        currency: intent.currency,
        status: result.status.name,
        description: description ?? intent.description,
        transactionDate: result.processedAt,
        isExternal: false,
      )));
    } else {
      _failPayment(intent, result.errorMessage ?? 'Invoice payment failed.', true);
    }
  }

  Future<void> _payRecipient(
    ScanPaymentIntent intent,
    String verificationToken,
    String sourceAccountId,
    double amount,
    String? description,
  ) async {
    // Resolve the destination account. The QR/OCR carry a userId/username (and
    // sometimes a phone) but the C2C send-funds RPC needs an account number /
    // account UUID, so resolve via the user search (returns primaryAccountId).
    String? toAccountId = intent.userId;
    String? toAccountNumber = intent.accountNumber;

    if (toAccountNumber == null || toAccountNumber.isEmpty) {
      final query = intent.username ?? intent.userId;
      if (query != null && query.isNotEmpty) {
        final matches = await profileRepository.searchUsers(query: query, limit: 5);
        if (matches.isNotEmpty) {
          final match = matches.first;
          toAccountId = match.primaryAccountId ?? toAccountId ?? match.userId;
          toAccountNumber = match.primaryAccountId ?? toAccountId;
        }
      }
    }

    // Fall back to the userId as the destination identifier when nothing else
    // resolved — the send-funds RPC accepts an account UUID for internal type.
    toAccountId ??= intent.userId;
    toAccountNumber ??= toAccountId ?? '';

    if ((toAccountId == null || toAccountId.isEmpty) && toAccountNumber.isEmpty) {
      _failPayment(intent, 'Could not resolve the recipient account.', false);
      return;
    }

    final transactionId = 'C2C-${DateTime.now().millisecondsSinceEpoch}';
    final result = await paymentsTransferDataSource.sendFunds(
      fromAccountId: sourceAccountId,
      toAccountNumber: toAccountNumber,
      toAccountId: toAccountId,
      type: 'internal',
      amount: amount,
      description: description ?? intent.description ?? 'Scan to pay',
      transactionId: transactionId,
      verificationToken: verificationToken,
    );
    if (isClosed) return;
    if (result.success) {
      emit(AiScanPaymentCompleted(PaymentReceipt(
        id: result.transferId ?? transactionId,
        reference: result.reference ?? transactionId,
        recipientName: result.recipientName ?? intent.title,
        accountNumber: toAccountNumber,
        bankName: 'LazerVault',
        amount: amount,
        currency: intent.currency,
        status: result.status ?? 'completed',
        description: description ?? intent.description,
        transactionDate: result.createdAt ?? DateTime.now(),
        isExternal: false,
      )));
    } else {
      _failPayment(intent, result.errorMessage ?? 'Transfer failed.', true);
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

} 