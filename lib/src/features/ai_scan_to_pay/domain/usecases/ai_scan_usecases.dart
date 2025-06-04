import '../entities/scan_entities.dart';
import '../repositories/ai_scan_repository.dart';

// Use case for starting a scan session
class StartScanSessionUseCase {
  final AiScanRepository repository;

  StartScanSessionUseCase(this.repository);

  Future<ScanSession> call(ScanType scanType) async {
    return await repository.createScanSession(scanType);
  }
}

// Use case for processing scanned image
class ProcessScanUseCase {
  final AiScanRepository repository;

  ProcessScanUseCase(this.repository);

  Future<Map<String, dynamic>> call(String imagePath, ScanType scanType) async {
    return await repository.extractDataFromImage(imagePath, scanType);
  }
}

// Use case for AI chat interaction
class AiChatUseCase {
  final AiScanRepository repository;

  AiChatUseCase(this.repository);

  Future<AiChatMessage> call(String sessionId, String userMessage, {Map<String, dynamic>? extractedData}) async {
    return await repository.processAiResponse(sessionId, userMessage, extractedData);
  }
}

// Use case for generating payment instructions
class GeneratePaymentUseCase {
  final AiScanRepository repository;

  GeneratePaymentUseCase(this.repository);

  Future<PaymentInstruction> call(Map<String, dynamic> extractedData, ScanType scanType) async {
    return await repository.generatePaymentInstruction(extractedData, scanType);
  }
}

// Use case for processing payment
class ProcessPaymentUseCase {
  final AiScanRepository repository;

  ProcessPaymentUseCase(this.repository);

  Future<bool> call(PaymentInstruction instruction) async {
    return await repository.processPayment(instruction);
  }
}

// Use case for getting scan history
class GetScanHistoryUseCase {
  final AiScanRepository repository;

  GetScanHistoryUseCase(this.repository);

  Future<List<ScanSession>> call() async {
    return await repository.getScanHistory();
  }
} 