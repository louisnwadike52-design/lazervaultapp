import '../entities/scan_entities.dart';

abstract class AiScanRepository {
  // Scan operations
  Future<ScanSession> createScanSession(ScanType scanType);
  Future<ScanSession> updateScanSession(ScanSession session);
  Future<List<ScanSession>> getScanHistory();
  Future<void> deleteScanSession(String sessionId);

  // Image processing
  Future<String> processImage(String imagePath, ScanType scanType);
  Future<Map<String, dynamic>> extractDataFromImage(String imagePath, ScanType scanType);
  
  // AI Chat operations
  Future<List<AiChatMessage>> getChatHistory(String sessionId);
  Future<AiChatMessage> sendMessage(String sessionId, String message);
  Future<AiChatMessage> processAiResponse(String sessionId, String userMessage, Map<String, dynamic>? extractedData);
  
  // Payment operations
  Future<PaymentInstruction> generatePaymentInstruction(Map<String, dynamic> extractedData, ScanType scanType);
  Future<bool> processPayment(PaymentInstruction instruction);
  Future<bool> validatePaymentData(Map<String, dynamic> paymentData);
} 