import '../../domain/entities/scan_entities.dart';
import '../../domain/repositories/ai_scan_repository.dart';
import '../datasources/ai_scan_datasource.dart';
import '../models/scan_models.dart';

class AiScanRepositoryImpl implements AiScanRepository {
  final AiScanDataSource dataSource;

  AiScanRepositoryImpl(this.dataSource);

  @override
  Future<ScanSession> createScanSession(ScanType scanType) async {
    return await dataSource.createScanSession(scanType);
  }

  @override
  Future<ScanSession> updateScanSession(ScanSession session) async {
    final model = ScanSessionModel.fromEntity(session);
    return await dataSource.updateScanSession(model);
  }

  @override
  Future<List<ScanSession>> getScanHistory() async {
    final models = await dataSource.getScanHistory();
    return models.cast<ScanSession>();
  }

  @override
  Future<void> deleteScanSession(String sessionId) async {
    return await dataSource.deleteScanSession(sessionId);
  }

  @override
  Future<String> processImage(String imagePath, ScanType scanType) async {
    // Process the image and return a status or result
    final extractedData = await dataSource.extractDataFromImage(imagePath, scanType);
    return 'Processing completed: ${extractedData.keys.join(', ')}';
  }

  @override
  Future<Map<String, dynamic>> extractDataFromImage(String imagePath, ScanType scanType) async {
    return await dataSource.extractDataFromImage(imagePath, scanType);
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
    final model = await dataSource.generatePaymentInstruction(extractedData, scanType);
    return model;
  }

  @override
  Future<bool> processPayment(PaymentInstruction instruction) async {
    final model = PaymentInstructionModel.fromEntity(instruction);
    return await dataSource.processPayment(model);
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