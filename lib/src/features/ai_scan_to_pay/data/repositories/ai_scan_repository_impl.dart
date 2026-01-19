import '../../../../core/network/grpc_client.dart';
import '../../../../../core/services/secure_storage_service.dart';
import '../../domain/entities/scan_entities.dart';
import '../../domain/repositories/ai_scan_repository.dart';
import '../datasources/ai_scan_remote_datasource.dart';
import '../models/scan_models.dart';

class AiScanRepositoryImpl implements AiScanRepository {
  final AiScanRemoteDataSource remoteDataSource;
  final GrpcClient grpcClient;
  final SecureStorageService secureStorage;

  // Track current session for convenience
  String? _currentSessionId;

  AiScanRepositoryImpl({
    required this.remoteDataSource,
    required this.grpcClient,
    required this.secureStorage,
  });

  Future<String> _getUserId() async {
    final userId = await grpcClient.getCurrentUserId();
    if (userId == null) {
      throw Exception('User not authenticated');
    }
    return userId;
  }

  @override
  Future<ScanSession> createScanSession(ScanType scanType) async {
    final userId = await _getUserId();
    final session = await remoteDataSource.createScanSession(scanType, userId);
    _currentSessionId = session.id;
    return session;
  }

  @override
  Future<ScanSession> updateScanSession(ScanSession session) async {
    final model = ScanSessionModel.fromEntity(session);
    return await remoteDataSource.updateScanSession(model);
  }

  @override
  Future<List<ScanSession>> getScanHistory() async {
    final userId = await _getUserId();
    final models = await remoteDataSource.getScanHistory(userId);
    return models.cast<ScanSession>();
  }

  @override
  Future<void> deleteScanSession(String sessionId) async {
    return await remoteDataSource.deleteScanSession(sessionId);
  }

  @override
  Future<String> processImage(String imagePath, ScanType scanType) async {
    if (_currentSessionId == null) {
      throw Exception('No active scan session');
    }

    final extractedData = await remoteDataSource.extractDataFromImage(
      imagePath,
      scanType,
      _currentSessionId!,
    );
    return 'Processing completed: ${extractedData.keys.join(', ')}';
  }

  @override
  Future<Map<String, dynamic>> extractDataFromImage(String imagePath, ScanType scanType) async {
    if (_currentSessionId == null) {
      throw Exception('No active scan session');
    }

    return await remoteDataSource.extractDataFromImage(
      imagePath,
      scanType,
      _currentSessionId!,
    );
  }

  @override
  Future<List<AiChatMessage>> getChatHistory(String sessionId) async {
    final models = await remoteDataSource.getChatHistory(sessionId);
    return models.cast<AiChatMessage>();
  }

  @override
  Future<AiChatMessage> sendMessage(String sessionId, String message) async {
    return await remoteDataSource.processAiResponse(sessionId, message, null);
  }

  @override
  Future<AiChatMessage> processAiResponse(String sessionId, String userMessage, Map<String, dynamic>? extractedData) async {
    return await remoteDataSource.processAiResponse(sessionId, userMessage, extractedData);
  }

  @override
  Future<PaymentInstruction> generatePaymentInstruction(Map<String, dynamic> extractedData, ScanType scanType) async {
    if (_currentSessionId == null) {
      throw Exception('No active scan session');
    }

    final model = await remoteDataSource.generatePaymentInstruction(
      extractedData,
      scanType,
      _currentSessionId!,
    );
    return model;
  }

  @override
  Future<bool> processPayment(PaymentInstruction instruction) async {
    if (_currentSessionId == null) {
      throw Exception('No active scan session');
    }

    final userId = await _getUserId();
    final model = PaymentInstructionModel.fromEntity(instruction);
    return await remoteDataSource.processPayment(model, userId, _currentSessionId!);
  }

  @override
  Future<bool> validatePaymentData(Map<String, dynamic> paymentData) async {
    // Validate required fields based on payment type
    if (paymentData['amount'] == null || paymentData['amount'] <= 0) {
      return false;
    }

    if (paymentData['recipient'] == null || paymentData['recipient'].toString().isEmpty) {
      return false;
    }

    if (paymentData['currency'] == null || paymentData['currency'].toString().isEmpty) {
      return false;
    }

    return true;
  }

  @override
  Future<BankDetails> scanBankDetails(String imagePath, String sessionId) async {
    final userId = await _getUserId();
    final accessToken = await secureStorage.getAccessToken();

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('User not authenticated');
    }

    return await remoteDataSource.scanBankDetails(
      imagePath,
      userId,
      sessionId,
      accessToken,
    );
  }

  @override
  Future<PaymentReceipt> processBankDetailsPayment({
    required BankDetails bankDetails,
    required double amount,
    required String description,
    required String verificationToken,
    required String transactionId,
  }) async {
    final userId = await _getUserId();
    final bankDetailsModel = BankDetailsModel.fromEntity(bankDetails);

    return await remoteDataSource.processBankDetailsPayment(
      bankDetails: bankDetailsModel,
      amount: amount,
      description: description,
      verificationToken: verificationToken,
      transactionId: transactionId,
      userId: userId,
    );
  }

  /// Set the current session ID for subsequent operations
  void setCurrentSession(String sessionId) {
    _currentSessionId = sessionId;
  }

  /// Clear the current session
  void clearCurrentSession() {
    _currentSessionId = null;
  }
}
