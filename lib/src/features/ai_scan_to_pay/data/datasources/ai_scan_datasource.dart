import 'dart:math' as math;
import '../../domain/entities/scan_entities.dart';
import '../models/scan_models.dart';

abstract class AiScanDataSource {
  Future<ScanSessionModel> createScanSession(ScanType scanType, String userId);
  Future<ScanSessionModel> updateScanSession(ScanSessionModel session);
  Future<List<ScanSessionModel>> getScanHistory(String userId);
  Future<void> deleteScanSession(String sessionId);
  Future<Map<String, dynamic>> extractDataFromImage(String imagePath, ScanType scanType, String sessionId);
  Future<List<AiChatMessageModel>> getChatHistory(String sessionId);
  Future<AiChatMessageModel> processAiResponse(String sessionId, String userMessage, Map<String, dynamic>? extractedData);
  Future<PaymentInstructionModel> generatePaymentInstruction(Map<String, dynamic> extractedData, ScanType scanType, String sessionId);
  Future<bool> processPayment(PaymentInstructionModel instruction, String userId, String sessionId);

  // Bank details scan methods
  Future<BankDetailsModel> scanBankDetails(String imagePath, String userId, String sessionId, String accessToken);
  Future<PaymentReceiptModel> processBankDetailsPayment({
    required BankDetailsModel bankDetails,
    required double amount,
    required String description,
    required String verificationToken,
    required String transactionId,
    required String userId,
  });
}

class AiScanDataSourceImpl implements AiScanDataSource {
  final List<ScanSessionModel> _scanSessions = [];
  final Map<String, List<AiChatMessageModel>> _chatHistory = {};

  @override
  Future<ScanSessionModel> createScanSession(ScanType scanType, String userId) async {
    final session = ScanSessionModel(
      id: 'scan_${DateTime.now().millisecondsSinceEpoch}_${math.Random().nextInt(1000)}',
      scanType: scanType,
      createdAt: DateTime.now(),
      status: ScanStatus.pending,
    );

    _scanSessions.add(session);
    _chatHistory[session.id] = [];

    // Add initial AI greeting message
    final greeting = _generateGreeting(scanType);
    _chatHistory[session.id]!.add(greeting);

    return session;
  }

  @override
  Future<ScanSessionModel> updateScanSession(ScanSessionModel session) async {
    final index = _scanSessions.indexWhere((s) => s.id == session.id);
    if (index != -1) {
      _scanSessions[index] = session;
    }
    return session;
  }

  @override
  Future<List<ScanSessionModel>> getScanHistory(String userId) async {
    return List.from(_scanSessions);
  }

  @override
  Future<void> deleteScanSession(String sessionId) async {
    _scanSessions.removeWhere((session) => session.id == sessionId);
    _chatHistory.remove(sessionId);
  }

  @override
  Future<Map<String, dynamic>> extractDataFromImage(String imagePath, ScanType scanType, String sessionId) async {
    // Simulate AI processing delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock data extraction based on scan type
    return _mockDataExtraction(scanType);
  }

  @override
  Future<List<AiChatMessageModel>> getChatHistory(String sessionId) async {
    return _chatHistory[sessionId] ?? [];
  }

  @override
  Future<AiChatMessageModel> processAiResponse(String sessionId, String userMessage, Map<String, dynamic>? extractedData) async {
    // Add user message to history
    final userMsg = AiChatMessageModel(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}_user',
      content: userMessage,
      isUser: true,
      timestamp: DateTime.now(),
    );
    
    _chatHistory[sessionId]?.add(userMsg);
    
    // Simulate AI processing delay
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // Generate AI response based on context
    final aiResponse = _generateAiResponse(userMessage, extractedData);
    
    final aiMsg = AiChatMessageModel(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}_ai',
      content: aiResponse,
      isUser: false,
      timestamp: DateTime.now(),
    );
    
    _chatHistory[sessionId]?.add(aiMsg);
    
    return aiMsg;
  }

  @override
  Future<PaymentInstructionModel> generatePaymentInstruction(Map<String, dynamic> extractedData, ScanType scanType, String sessionId) async {
    return PaymentInstructionModel(
      id: 'payment_${DateTime.now().millisecondsSinceEpoch}',
      recipient: extractedData['recipient'] ?? 'Unknown Recipient',
      amount: (extractedData['amount'] ?? 0.0).toDouble(),
      currency: extractedData['currency'] ?? 'USD',
      reference: extractedData['reference'],
      description: 'Payment via AI Scan - ${scanType.displayName}',
      additionalData: extractedData,
    );
  }

  @override
  Future<bool> processPayment(PaymentInstructionModel instruction, String userId, String sessionId) async {
    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 3));

    // Mock success/failure (90% success rate)
    return math.Random().nextDouble() > 0.1;
  }

  // Helper methods for mock data generation
  Map<String, dynamic> _mockDataExtraction(ScanType scanType) {
    switch (scanType) {
      case ScanType.invoice:
        return {
          'recipient': 'ABC Corporation',
          'amount': 1250.00,
          'currency': 'USD',
          'reference': 'INV-2024-001',
          'dueDate': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
          'description': 'Professional services invoice',
        };
      case ScanType.utilityBill:
        return {
          'recipient': 'City Power & Light',
          'amount': 89.45,
          'currency': 'USD',
          'reference': 'UTIL-456789',
          'accountNumber': '1234567890',
          'dueDate': DateTime.now().add(const Duration(days: 14)).toIso8601String(),
          'billPeriod': 'March 2024',
        };
      case ScanType.accountDetails:
        return {
          'accountNumber': '1234567890123456',
          'routingNumber': '021000021',
          'bankName': 'First National Bank',
          'accountHolder': 'John Doe',
          'accountType': 'Checking',
        };
      case ScanType.qrCode:
        return {
          'recipient': 'Coffee Shop',
          'amount': 15.50,
          'currency': 'USD',
          'reference': 'ORDER-789',
          'merchantId': 'COFFEE123',
        };
      case ScanType.giftCard:
        return {
          'cardNumber': '1234 5678 9012 3456',
          'securityCode': '789',
          'balance': 100.00,
          'currency': 'USD',
          'merchant': 'Amazon',
          'expiryDate': '12/2026',
        };
      default:
        return {
          'recipient': 'Unknown',
          'amount': 0.0,
          'currency': 'USD',
        };
    }
  }

  AiChatMessageModel _generateGreeting(ScanType scanType) {
    String greeting;
    switch (scanType) {
      case ScanType.invoice:
        greeting = "Hi! I'm here to help you pay your invoice. Please take a clear photo of your invoice, and I'll extract the payment details for you.";
        break;
      case ScanType.utilityBill:
        greeting = "Hello! I'll help you pay your utility bill. Scan or photograph your bill, and I'll guide you through the payment process.";
        break;
      case ScanType.qrCode:
        greeting = "Hi there! Ready to scan a QR code for payment? Point your camera at the QR code and I'll process the payment details.";
        break;
      case ScanType.giftCard:
        greeting = "Welcome! I'll help you redeem your gift card. Please scan the card or enter the details, and I'll process it for you.";
        break;
      default:
        greeting = "Hello! I'm your AI payment assistant. I'll help you scan and process your payment. What would you like to do?";
    }

    return AiChatMessageModel(
      id: 'greeting_${DateTime.now().millisecondsSinceEpoch}',
      content: greeting,
      isUser: false,
      timestamp: DateTime.now(),
    );
  }

  String _generateAiResponse(String userMessage, Map<String, dynamic>? extractedData) {
    final lowerMessage = userMessage.toLowerCase();
    
    if (extractedData != null && extractedData.isNotEmpty) {
      // Response when data is extracted
      final amount = extractedData['amount'];
      final recipient = extractedData['recipient'];
      
      return "Great! I've extracted the payment details:\n\n"
          "• Recipient: $recipient\n"
          "• Amount: \$${amount?.toStringAsFixed(2) ?? '0.00'}\n"
          "• Currency: ${extractedData['currency'] ?? 'USD'}\n\n"
          "Would you like me to proceed with this payment? I can walk you through the process step by step.";
    }
    
    if (lowerMessage.contains('yes') || lowerMessage.contains('proceed') || lowerMessage.contains('pay')) {
      return "Perfect! I'll initiate the payment process for you. Please confirm your payment method and I'll handle the rest. "
          "Would you like to use your default payment method or select a different one?";
    }
    
    if (lowerMessage.contains('help') || lowerMessage.contains('how')) {
      return "I'm here to help! Here's what I can do:\n\n"
          "1. Extract payment details from scanned documents\n"
          "2. Guide you through secure payment processes\n"
          "3. Answer questions about your transaction\n"
          "4. Provide payment confirmations\n\n"
          "Just tell me what you need assistance with!";
    }
    
    if (lowerMessage.contains('cancel') || lowerMessage.contains('stop')) {
      return "No problem! I've cancelled the current process. If you need help with anything else, just let me know.";
    }
    
    // Default response
    return "I understand. Could you please clarify what you'd like me to help you with? "
        "I can assist with payment processing, answer questions about the extracted details, or guide you through any step of the process.";
  }

  @override
  Future<BankDetailsModel> scanBankDetails(String imagePath, String userId, String sessionId, String accessToken) async {
    // Stub implementation - actual implementation is in AiScanRemoteDataSource
    throw UnimplementedError('scanBankDetails is not implemented in mock datasource');
  }

  @override
  Future<PaymentReceiptModel> processBankDetailsPayment({
    required BankDetailsModel bankDetails,
    required double amount,
    required String description,
    required String verificationToken,
    required String transactionId,
    required String userId,
  }) async {
    // Stub implementation - actual implementation is in AiScanRemoteDataSource
    throw UnimplementedError('processBankDetailsPayment is not implemented in mock datasource');
  }
} 