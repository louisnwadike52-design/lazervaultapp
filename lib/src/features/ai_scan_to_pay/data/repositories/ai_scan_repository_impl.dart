import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/entities/scan_entities.dart';
import '../../domain/repositories/ai_scan_repository.dart';
import '../datasources/ai_scan_datasource.dart';
import '../models/scan_models.dart';

class AiScanRepositoryImpl implements AiScanRepository {
  final AiScanDataSource dataSource;
  final FlutterSecureStorage storage;

  // Track the current active scan session
  ScanSession? _currentSession;

  // Storage keys
  static const String _userIdKey = 'user_id';

  AiScanRepositoryImpl(this.dataSource, this.storage);

  // Get userId from secure storage
  Future<String> get _currentUserId async {
    final userId = await storage.read(key: _userIdKey);
    return userId ?? '';
  }

  // Get current sessionId from active session
  String get _currentSessionId => _currentSession?.id ?? '';

  @override
  Future<ScanSession> createScanSession(ScanType scanType) async {
    final userId = await _currentUserId;
    final session = await dataSource.createScanSession(scanType, userId);
    _currentSession = session; // Track the current session
    return session;
  }

  @override
  Future<ScanSession> updateScanSession(ScanSession session) async {
    final model = ScanSessionModel.fromEntity(session);
    return await dataSource.updateScanSession(model);
  }

  @override
  Future<List<ScanSession>> getScanHistory() async {
    final userId = await _currentUserId;
    final models = await dataSource.getScanHistory(userId);
    return models.cast<ScanSession>();
  }

  @override
  Future<void> deleteScanSession(String sessionId) async {
    return await dataSource.deleteScanSession(sessionId);
  }

  @override
  Future<String> processImage(String imagePath, ScanType scanType) async {
    // Process the image and return a status or result
    final extractedData = await dataSource.extractDataFromImage(imagePath, scanType, _currentSessionId);
    return 'Processing completed: ${extractedData.keys.join(', ')}';
  }

  @override
  Future<Map<String, dynamic>> extractDataFromImage(String imagePath, ScanType scanType) async {
    return await dataSource.extractDataFromImage(imagePath, scanType, _currentSessionId);
  }

  @override
  Future<List<AiChatMessage>> getChatHistory(String sessionId) async {
    final models = await dataSource.getChatHistory(sessionId);
    return models.cast<AiChatMessage>();
  }

  @override
  Future<AiChatMessage> sendMessage(String sessionId, String message) async {
    return await dataSource.processAiResponse(sessionId, message, null);
  }

  @override
  Future<AiChatMessage> processAiResponse(String sessionId, String userMessage, Map<String, dynamic>? extractedData) async {
    return await dataSource.processAiResponse(sessionId, userMessage, extractedData);
  }

  @override
  Future<PaymentInstruction> generatePaymentInstruction(Map<String, dynamic> extractedData, ScanType scanType) async {
    return await dataSource.generatePaymentInstruction(extractedData, scanType, _currentSessionId);
  }

  @override
  Future<bool> processPayment(PaymentInstruction instruction) async {
    final userId = await _currentUserId;
    final model = PaymentInstructionModel.fromEntity(instruction);
    return await dataSource.processPayment(model, userId, _currentSessionId);
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
} 