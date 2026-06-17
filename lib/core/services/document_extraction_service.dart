import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../config/country_config.dart';

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

/// Service for extracting data from identity documents using AI/OCR
class DocumentExtractionService {
  static String get _defaultApiUrl =>
      dotenv.env['DOCUMENT_EXTRACTION_API_URL'] ??
      dotenv.env['CHAT_GATEWAY_URL'] ??
      'https://api.lazervault.com/v1';

  static String get _defaultApiKey =>
      dotenv.env['DOCUMENT_EXTRACTION_API_KEY'] ??
      dotenv.env['API_KEY'] ??
      '';

  final String baseUrl;
  final String apiKey;

  DocumentExtractionService({
    String? baseUrl,
    String? apiKey,
  })  : baseUrl = baseUrl ?? _defaultApiUrl,
        apiKey = apiKey ?? _defaultApiKey;

  /// Extract data from an image of an identity document
  ///
  /// [imageFile] - The image file to process
  /// [countryCode] - ISO country code to help with extraction
  /// [documentType] - Expected document type (optional, auto-detected if not provided)
  /// [manualEntryData] - If OCR fails, provide manual entry for validation
  Future<DocumentExtractionResult> extractFromDocument({
    required File imageFile,
    required String countryCode,
    DocumentTypeForExtraction? documentType,
    Map<String, String>? manualEntryData,
  }) async {
    // First, try AI-based extraction
    final result = await _extractWithAI(
      imageFile: imageFile,
      countryCode: countryCode,
      documentType: documentType,
    );

    // If AI extraction failed or has low confidence, check for manual entry
    if (!result.success || result.confidence == ExtractionConfidence.low) {
      if (manualEntryData != null) {
        return _validateManualEntry(
          manualEntryData: manualEntryData,
          countryCode: countryCode,
          documentType: documentType,
        );
      }
    }

    return result;
  }

  /// Extract data using AI/OCR
  Future<DocumentExtractionResult> _extractWithAI({
    required File imageFile,
    required String countryCode,
    DocumentTypeForExtraction? documentType,
  }) async {
    // Check if API key is configured
    if (apiKey.isEmpty) {
      return DocumentExtractionResult.failure(
        'Document extraction API key not configured. Please set DOCUMENT_EXTRACTION_API_KEY in your environment.',
      );
    }

    try {
      // Read image file
      final imageBytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(imageBytes);

      // Detect document type if not provided
      final detectedType = documentType ?? await _detectDocumentType(imageFile);

      // Prepare the request
      final request = {
        'image': base64Image,
        'country_code': countryCode,
        'document_type': detectedType.name,
        'options': {
          'extract_faces': true,
          'extract_barcode': true,
          'validate_checksums': true,
        },
      };

      // Call AI extraction API
      final response = await http.post(
        Uri.parse('$baseUrl/documents/extract'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
          'X-API-Version': '2024-01',
        },
        body: jsonEncode(request),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        // Determine confidence level
        final extractedConfidence = _parseConfidence(data['confidence'] as String?);

        // Validate extracted data against country requirements
        final validationResult = _validateExtractedData(
          extractedData: data,
          countryCode: countryCode,
          documentType: detectedType,
          extractedConfidence: extractedConfidence,
        );

        return validationResult;
      } else if (response.statusCode == 422) {
        // Unprocessable entity - image quality issues
        final errorData = jsonDecode(response.body);
        return DocumentExtractionResult.failure(
          _formatImageQualityError(errorData),
        );
      } else if (response.statusCode == 401) {
        return DocumentExtractionResult.failure(
          'Invalid API key. Please check your configuration.',
        );
      } else {
        return DocumentExtractionResult.failure(
          'Extraction failed: ${response.statusCode}',
        );
      }
    } catch (e) {
      return DocumentExtractionResult.failure(
        'Failed to connect to extraction service: ${e.toString()}',
      );
    }
  }

  /// Detect document type from image
  Future<DocumentTypeForExtraction> _detectDocumentType(File imageFile) async {
    // In production, this would call an AI endpoint
    // For now, return unknown and let the backend handle it
    return DocumentTypeForExtraction.unknown;
  }

  /// Validate extracted data against country requirements
  DocumentExtractionResult _validateExtractedData({
    required Map<String, dynamic> extractedData,
    required String countryCode,
    required DocumentTypeForExtraction? documentType,
    ExtractionConfidence extractedConfidence = ExtractionConfidence.unknown,
  }) {
    final config = CountryConfigs.getByCode(countryCode);
    if (config == null) {
      return DocumentExtractionResult.failure('Country not supported');
    }

    // Extract common fields
    final extractedFields = <String, dynamic>{};
    var confidence = extractedConfidence;

    // Extract document number
    final documentNumber = extractedData['document_number'] as String?;
    if (documentNumber != null && documentNumber.isNotEmpty) {
      extractedFields['documentNumber'] = documentNumber;
    } else {
      confidence = ExtractionConfidence.medium;
    }

    // Extract name fields
    final firstName = extractedData['first_name'] as String?;
    final lastName = extractedData['last_name'] as String?;
    if (firstName != null) extractedFields['firstName'] = firstName;
    if (lastName != null) extractedFields['lastName'] = lastName;

    // Extract date of birth
    final dateOfBirth = extractedData['date_of_birth'] as String?;
    if (dateOfBirth != null) extractedFields['dateOfBirth'] = dateOfBirth;

    // Extract expiration date
    final expirationDate = extractedData['expiration_date'] as String?;
    if (expirationDate != null) extractedFields['expirationDate'] = expirationDate;

    // Extract sex/gender
    final sex = extractedData['sex'] as String?;
    if (sex != null) extractedFields['sex'] = sex;

    // Extract address (if available)
    final address = extractedData['address'] as String?;
    if (address != null) extractedFields['address'] = address;

    // Country-specific extractions
    switch (countryCode) {
      case 'NG':
        // Nigeria: BVN, NIN validation
        final bvn = extractedData['bvn'] as String?;
        final nin = extractedData['nin'] as String?;
        if (bvn != null) extractedFields['bvn'] = bvn;
        if (nin != null) extractedFields['nin'] = nin;
        break;

      case 'GB':
        // UK: NI Number extraction
        final niNumber = extractedData['ni_number'] as String?;
        if (niNumber != null) extractedFields['niNumber'] = niNumber;
        break;

      case 'US':
        // US: SSN (partial extraction for security)
        final ssnLast4 = extractedData['ssn_last4'] as String?;
        if (ssnLast4 != null) extractedFields['ssnLast4'] = ssnLast4;
        break;

      case 'GH':
        // Ghana: Ghana Card format
        final ghanaCard = extractedData['ghana_card'] as String?;
        if (ghanaCard != null) extractedFields['ghanaCard'] = ghanaCard;
        break;

      case 'KE':
        // Kenya: National ID
        final nationalId = extractedData['national_id'] as String?;
        if (nationalId != null) extractedFields['nationalId'] = nationalId;
        break;

      case 'ZA':
        // South Africa: SA ID
        final saId = extractedData['sa_id'] as String?;
        if (saId != null) extractedFields['saId'] = saId;
        break;
    }

    // Extract face image data (if available for liveness check)
    final faceData = extractedData['face_image'] as String?;
    if (faceData != null) {
      extractedFields['faceImage'] = faceData;
    }

    // Determine final confidence
    final missingRequiredFields = _getMissingRequiredFields(
      extractedFields,
      countryCode,
      documentType,
    );

    if (missingRequiredFields.isNotEmpty) {
      confidence = ExtractionConfidence.medium;
    }

    if (confidence == ExtractionConfidence.high && missingRequiredFields.isEmpty) {
      return DocumentExtractionResult.success(extractedFields, ExtractionConfidence.high);
    } else if (confidence == ExtractionConfidence.medium) {
      return DocumentExtractionResult.success(extractedFields, ExtractionConfidence.medium);
    } else {
      return DocumentExtractionResult.success(extractedFields, ExtractionConfidence.low);
    }
  }

  /// Validate manually entered data
  DocumentExtractionResult _validateManualEntry({
    required Map<String, String> manualEntryData,
    required String countryCode,
    required DocumentTypeForExtraction? documentType,
  }) {
    final config = CountryConfigs.getByCode(countryCode);
    if (config == null) {
      return DocumentExtractionResult.failure('Country not supported');
    }

    // Validate against country requirements
    final validatedData = <String, dynamic>{};
    var hasAllRequired = true;

    for (final entry in manualEntryData.entries) {
      final key = entry.key;
      final value = entry.value;

      // Basic validation
      if (value.isNotEmpty) {
        validatedData[key] = value;
      } else {
        // Check if this is a required field
        if (_isRequiredField(key, countryCode)) {
          hasAllRequired = false;
        }
      }
    }

    final confidence = hasAllRequired
        ? ExtractionConfidence.high
        : ExtractionConfidence.medium;

    return DocumentExtractionResult.success(validatedData, confidence);
  }

  /// Check if a field is required for a country
  bool _isRequiredField(String field, String countryCode) {
    final requiredFieldsByCountry = {
      'NG': ['documentNumber', 'bvn', 'nin'],
      'GB': ['documentNumber', 'firstName', 'lastName'],
      'US': ['ssnLast4', 'firstName', 'lastName'],
      'GH': ['ghanaCard', 'firstName', 'lastName'],
      'KE': ['nationalId', 'firstName', 'lastName'],
      'ZA': ['saId', 'firstName', 'lastName'],
    };

    return requiredFieldsByCountry[countryCode]?.contains(field) ?? false;
  }

  /// Get missing required fields
  List<String> _getMissingRequiredFields(
    Map<String, dynamic> extractedData,
    String countryCode,
    DocumentTypeForExtraction? documentType,
  ) {
    final requiredFieldsByCountry = {
      'NG': ['firstName', 'lastName', 'dateOfBirth'],
      'GB': ['firstName', 'lastName', 'dateOfBirth'],
      'US': ['firstName', 'lastName', 'dateOfBirth'],
      'GH': ['firstName', 'lastName', 'dateOfBirth'],
      'KE': ['firstName', 'lastName', 'dateOfBirth'],
      'ZA': ['firstName', 'lastName', 'dateOfBirth'],
    };

    final requiredFields = requiredFieldsByCountry[countryCode] ?? [];
    final missing = <String>[];

    for (final field in requiredFields) {
      if (!extractedData.containsKey(field) ||
          extractedData[field] == null ||
          extractedData[field].toString().isEmpty) {
        missing.add(field);
      }
    }

    return missing;
  }

  /// Parse confidence from API response
  ExtractionConfidence _parseConfidence(String? confidenceStr) {
    switch (confidenceStr?.toLowerCase()) {
      case 'high':
        return ExtractionConfidence.high;
      case 'medium':
        return ExtractionConfidence.medium;
      case 'low':
        return ExtractionConfidence.low;
      default:
        return ExtractionConfidence.unknown;
    }
  }

  /// Format image quality error message
  String _formatImageQualityError(dynamic errorData) {
    final issues = errorData['issues'] as List<dynamic>?;
    if (issues != null && issues.isNotEmpty) {
      return 'Image quality issues: ${issues.join(', ')}';
    }
    return 'Image quality too low. Please provide a clearer image.';
  }

  /// Verify extracted data against backend
  Future<DocumentExtractionResult> verifyWithBackend({
    required Map<String, dynamic> extractedData,
    required String countryCode,
    required String documentType,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/documents/verify'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'country_code': countryCode,
          'document_type': documentType,
          'data': extractedData,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DocumentExtractionResult.success(
          data as Map<String, dynamic>,
          ExtractionConfidence.high,
        );
      } else {
        return DocumentExtractionResult.failure(
          'Verification failed: ${response.statusCode}',
        );
      }
    } catch (e) {
      return DocumentExtractionResult.failure('Verification error: $e');
    }
  }

  /// Process multiple pages of a document (front and back)
  Future<DocumentExtractionResult> extractFromMultiPageDocument({
    required List<File> imageFiles,
    required String countryCode,
    DocumentTypeForExtraction? documentType,
  }) async {
    if (imageFiles.isEmpty) {
      return DocumentExtractionResult.failure('No images provided');
    }

    // Extract from front side first
    final frontResult = await extractFromDocument(
      imageFile: imageFiles.first,
      countryCode: countryCode,
      documentType: documentType,
    );

    if (!frontResult.success || imageFiles.length == 1) {
      return frontResult;
    }

    // Process back side if available
    final backResult = await extractFromDocument(
      imageFile: imageFiles[1],
      countryCode: countryCode,
      documentType: documentType,
    );

    // Merge results
    if (backResult.success) {
      final mergedData = Map<String, dynamic>.from(frontResult.extractedData ?? {});
      mergedData.addAll(backResult.extractedData ?? {});

      // Use the lower confidence of the two
      final confidence = frontResult.confidence.index < backResult.confidence.index
          ? frontResult.confidence
          : backResult.confidence;

      return DocumentExtractionResult.success(mergedData, confidence);
    }

    return frontResult;
  }

  /// Get user-friendly error message for extraction failure
  static String getUserFriendlyError(String? technicalError) {
    if (technicalError == null) {
      return 'Unable to read the document. Please try again.';
    }

    if (technicalError.contains('blur') || technicalError.contains('focus')) {
      return 'The image is blurry. Please take a clearer photo.';
    }
    if (technicalError.contains('glare') || technicalError.contains('reflection')) {
      return 'There\'s glare on the document. Please retake in better lighting.';
    }
    if (technicalError.contains('corner') || technicalError.contains('edge')) {
      return 'Please ensure all corners of the document are visible.';
    }
    if (technicalError.contains('dark') || technicalError.contains('light')) {
      return 'The lighting is poor. Please retake in better lighting conditions.';
    }
    if (technicalError.contains('document') || technicalError.contains('detect')) {
      return 'We couldn\'t detect the document. Please ensure it\'s a valid ID.';
    }

    return 'Unable to read the document. Please try again or enter manually.';
  }

  /// Get suggested improvements for document photo quality
  static List<String> getPhotoTips({
    required String countryCode,
    IdentityDocumentType? documentType,
  }) {
    return [
      'Ensure the document is well-lit and in focus',
      'All corners of the document should be visible',
      'Avoid glare and shadows on the document',
      'Place the document on a dark, flat surface',
      'Hold the camera steady and parallel to the document',
      'Do not use flash as it can cause glare',
      if (documentType != null)
        'For ${documentType.displayName}, ensure the photo area is clear',
    ];
  }
}
