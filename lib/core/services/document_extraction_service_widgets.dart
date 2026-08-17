part of 'document_extraction_service.dart';

/// Result of document extraction
class DocumentExtractionResult {
  final bool success;
  final Map<String, dynamic>? extractedData;
  final String? errorMessage;
  final ExtractionConfidence confidence;

  const DocumentExtractionResult({
    required this.success,
    this.extractedData,
    this.errorMessage,
    this.confidence = ExtractionConfidence.unknown,
  });

  factory DocumentExtractionResult.success(Map<String, dynamic> data, ExtractionConfidence confidence) {
    return DocumentExtractionResult(
      success: true,
      extractedData: data,
      confidence: confidence,
    );
  }

  factory DocumentExtractionResult.failure(String error) {
    return DocumentExtractionResult(
      success: false,
      errorMessage: error,
      confidence: ExtractionConfidence.unknown,
    );
  }

  /// Get specific field from extracted data
  String? getField(String key) {
    return extractedData?[key]?.toString();
  }

  /// Check if extraction has high confidence
  bool get isHighConfidence => confidence == ExtractionConfidence.high;
}

/// Confidence level of the extraction
enum ExtractionConfidence {
  high,      // All required fields extracted with high accuracy
  medium,    // Most fields extracted, some may need verification
  low,       // Some fields extracted, manual verification required
  unknown,   // Extraction failed or confidence cannot be determined
}

/// Document type for extraction
enum DocumentTypeForExtraction {
  idCard,
  passport,
  driversLicense,
  voterCard,
  socialSecurityCard,
  taxIdCard,
  unknown,
}
