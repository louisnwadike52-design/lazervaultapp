import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:grpc/grpc.dart';
import 'package:http/http.dart' as http;
import '../../../../core/network/grpc_client.dart';
import '../../../../../core/services/secure_storage_service.dart';
import '../../../../../core/utils/api_headers.dart';
import '../../../../generated/ai_scan.pb.dart' as pb;
import '../../domain/entities/scan_entities.dart';
import '../../domain/exceptions/scan_exceptions.dart';
import '../models/scan_models.dart';

abstract class AiScanRemoteDataSource {
  Future<ScanSessionModel> createScanSession(ScanType scanType, String userId);
  Future<ScanSessionModel> updateScanSession(ScanSessionModel session);
  Future<List<ScanSessionModel>> getScanHistory(String userId, {int page = 1, int pageSize = 20});
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

class AiScanRemoteDataSourceImpl implements AiScanRemoteDataSource {
  final GrpcClient grpcClient;
  final http.Client httpClient;
  final SecureStorageService secureStorage;
  final String chatGatewayBaseUrl;

  AiScanRemoteDataSourceImpl({
    required this.grpcClient,
    required this.httpClient,
    required this.secureStorage,
    required this.chatGatewayBaseUrl,
  });

  /// Build HTTP headers with all required metadata
  Future<Map<String, String>> _getHeaders({String? overrideAccessToken}) async {
    final headers = await ApiHeaders.build(secureStorage: secureStorage);
    // Override access token if provided (for bank details scan with specific token)
    if (overrideAccessToken != null && overrideAccessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $overrideAccessToken';
    }
    return headers;
  }

  @override
  Future<ScanSessionModel> createScanSession(ScanType scanType, String userId) async {
    try {
      final request = pb.StartScanSessionRequest()
        ..userId = userId
        ..scanType = _mapScanTypeToProto(scanType);

      final callOptions = await grpcClient.callOptions;
      final response = await grpcClient.aiScanClient.startScanSession(request, options: callOptions);

      return ScanSessionModel(
        id: response.sessionId,
        scanType: _mapProtoToScanType(response.scanType),
        createdAt: DateTime.fromMillisecondsSinceEpoch(response.createdAt.toInt() * 1000),
        status: _mapProtoToScanStatus(response.status),
      );
    } on GrpcError catch (e) {
      throw Exception('Failed to create scan session: ${e.message}');
    }
  }

  @override
  Future<Map<String, dynamic>> extractDataFromImage(String imagePath, ScanType scanType, String sessionId) async {
    try {
      // Read image file
      final imageFile = File(imagePath);
      final imageBytes = await imageFile.readAsBytes();

      final request = pb.ProcessImageRequest()
        ..sessionId = sessionId
        ..imageData = imageBytes
        ..scanType = _mapScanTypeToProto(scanType);

      final callOptions = await grpcClient.callOptions;
      final response = await grpcClient.aiScanClient.processImage(request, options: callOptions);

      if (!response.success) {
        throw Exception(response.errorMessage);
      }

      // Convert protobuf extracted data to map
      final extractedData = _convertExtractedDataToMap(response.extractedData);

      // Add AI message to the extracted data
      extractedData['ai_message'] = response.aiMessage;
      extractedData['session_id'] = response.sessionId;

      return extractedData;
    } on GrpcError catch (e) {
      throw Exception('Failed to process image: ${e.message}');
    }
  }

  @override
  Future<AiChatMessageModel> processAiResponse(String sessionId, String userMessage, Map<String, dynamic>? extractedData) async {
    try {
      final request = pb.SendChatMessageRequest()
        ..sessionId = sessionId
        ..userMessage = userMessage;

      if (extractedData != null) {
        request.contextData = _convertMapToExtractedData(extractedData);
      }

      final callOptions = await grpcClient.callOptions;
      final response = await grpcClient.aiScanClient.sendChatMessage(request, options: callOptions);

      return AiChatMessageModel(
        id: response.messageId,
        content: response.aiResponse,
        isUser: false,
        timestamp: DateTime.fromMillisecondsSinceEpoch(response.timestamp.toInt() * 1000),
      );
    } on GrpcError catch (e) {
      throw Exception('Failed to send chat message: ${e.message}');
    }
  }

  @override
  Future<PaymentInstructionModel> generatePaymentInstruction(Map<String, dynamic> extractedData, ScanType scanType, String sessionId) async {
    try {
      final request = pb.GeneratePaymentInstructionRequest()
        ..sessionId = sessionId
        ..extractedData = _convertMapToExtractedData(extractedData)
        ..scanType = _mapScanTypeToProto(scanType);

      final callOptions = await grpcClient.callOptions;
      final response = await grpcClient.aiScanClient.generatePaymentInstruction(request, options: callOptions);

      if (!response.success) {
        throw Exception(response.errorMessage);
      }

      final instruction = response.instruction;
      return PaymentInstructionModel(
        id: instruction.instructionId,
        recipient: instruction.recipient,
        amount: instruction.amount,
        currency: instruction.currency,
        reference: instruction.reference,
        description: instruction.description,
        additionalData: Map<String, String>.from(instruction.metadata),
      );
    } on GrpcError catch (e) {
      throw Exception('Failed to generate payment instruction: ${e.message}');
    }
  }

  @override
  Future<bool> processPayment(PaymentInstructionModel instruction, String userId, String sessionId) async {
    try {
      final pbInstruction = pb.PaymentInstruction()
        ..instructionId = instruction.id
        ..recipient = instruction.recipient
        ..amount = instruction.amount
        ..currency = instruction.currency
        ..reference = instruction.reference ?? ''
        ..description = instruction.description ?? ''
        ..metadata.addAll(
          (instruction.additionalData ?? {}).map((key, value) => MapEntry(key, value.toString()))
        );

      final request = pb.ScanProcessPaymentRequest()
        ..userId = userId
        ..sessionId = sessionId
        ..instruction = pbInstruction;

      final callOptions = await grpcClient.callOptions;
      final response = await grpcClient.aiScanClient.processPayment(request, options: callOptions);

      return response.success;
    } on GrpcError catch (e) {
      throw Exception('Failed to process payment: ${e.message}');
    }
  }

  @override
  Future<List<ScanSessionModel>> getScanHistory(String userId, {int page = 1, int pageSize = 20}) async {
    try {
      final request = pb.GetScanHistoryRequest()
        ..userId = userId
        ..page = page
        ..pageSize = pageSize;

      final callOptions = await grpcClient.callOptions;
      final response = await grpcClient.aiScanClient.getScanHistory(request, options: callOptions);

      return response.sessions.map((session) {
        return ScanSessionModel(
          id: session.sessionId,
          scanType: _mapProtoToScanType(session.scanType),
          createdAt: DateTime.fromMillisecondsSinceEpoch(session.createdAt.toInt() * 1000),
          status: _mapProtoToScanStatus(session.status),
          extractedData: session.hasExtractedData() ? jsonEncode(_convertExtractedDataToMap(session.extractedData)) : null,
        );
      }).toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to get scan history: ${e.message}');
    }
  }

  @override
  Future<ScanSessionModel> updateScanSession(ScanSessionModel session) async {
    // This is handled server-side, return the session as-is
    return session;
  }

  @override
  Future<void> deleteScanSession(String sessionId) async {
    // To be implemented if needed
    throw UnimplementedError('Delete scan session not yet implemented');
  }

  @override
  Future<List<AiChatMessageModel>> getChatHistory(String sessionId) async {
    // Chat history is managed through processAiResponse
    // Return empty list as messages are returned individually
    return [];
  }

  @override
  Future<BankDetailsModel> scanBankDetails(
    String imagePath,
    String userId,
    String sessionId,
    String accessToken,
  ) async {
    try {
      // Validate image file
      final imageFile = File(imagePath);
      if (!await imageFile.exists()) {
        throw OCRException.invalidImageFormat();
      }

      // Check file size (max 10MB)
      final fileSize = await imageFile.length();
      if (fileSize > 10 * 1024 * 1024) {
        throw OCRException(
          errorType: OCRErrorType.invalidImageFormat,
          message: 'Image file too large',
          userMessage: 'Image is too large. Maximum size: 10MB',
        );
      }

      // Read image file and convert to base64
      final imageBytes = await imageFile.readAsBytes();
      final imageBase64 = base64Encode(imageBytes);

      // Prepare request body
      final requestBody = jsonEncode({
        'image_base64': imageBase64,
        'user_id': userId,
        'session_id': sessionId,
        'access_token': accessToken,
      });

      // Send POST request to chat gateway with timeout
      final uri = Uri.parse('$chatGatewayBaseUrl/scan/bank-details');
      final headers = await _getHeaders(overrideAccessToken: accessToken);
      final response = await httpClient
          .post(
        uri,
        headers: headers,
        body: requestBody,
      )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw OCRException.processingTimeout();
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;

        if (responseData['success'] == true) {
          final extractedData =
              responseData['extracted_data'] as Map<String, dynamic>;

          // Check confidence score
          final confidenceScore =
              (extractedData['confidence_score'] as num?)?.toDouble() ?? 0.0;
          if (confidenceScore < 0.3) {
            throw OCRException.lowConfidence(confidence: confidenceScore);
          }

          return BankDetailsModel.fromJson(extractedData);
        } else {
          // Handle specific error codes from backend
          final errorCode = responseData['error'] as String?;
          final errorMessage = responseData['user_message'] as String?;

          if (errorCode == 'LOW_CONFIDENCE') {
            throw OCRException.lowConfidence(
              confidence:
                  (responseData['confidence_score'] as num?)?.toDouble(),
            );
          } else if (errorCode == 'NO_TEXT_DETECTED') {
            throw OCRException.noTextDetected();
          } else if (errorCode == 'INVALID_FORMAT') {
            throw OCRException.invalidImageFormat();
          } else if (errorCode == 'OCR_FAILED') {
            throw OCRException(
              errorType: OCRErrorType.processingTimeout,
              message: 'OCR processing failed',
              userMessage: errorMessage ??
                  'Could not process image. Please try again.',
            );
          } else {
            throw OCRException(
              errorType: OCRErrorType.processingTimeout,
              message: errorMessage ?? 'Unknown error occurred',
              userMessage: errorMessage ?? 'Failed to scan bank details.',
            );
          }
        }
      } else if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['user_message'] ?? 'Invalid request';
        throw ValidationException(
          validationType: ValidationType.accountNumber,
          message: errorMessage,
          userMessage: errorMessage,
        );
      } else if (response.statusCode == 401) {
        throw AuthenticationException.notAuthenticated();
      } else if (response.statusCode == 403) {
        throw AuthenticationException.unauthorized();
      } else if (response.statusCode == 429) {
        final retryAfter = int.tryParse(
          response.headers['retry-after'] ?? '',
        );
        throw RateLimitException.tooManyRequests(retryAfter: retryAfter);
      } else if (response.statusCode >= 500) {
        throw NetworkException.serverError(statusCode: response.statusCode);
      } else {
        throw NetworkException(
          errorType: NetworkErrorType.badRequest,
          message: 'Unexpected error: ${response.statusCode}',
          userMessage: 'Server error. Please try again.',
        );
      }
    } on SocketException {
      throw NetworkException.noConnection();
    } on TimeoutException {
      throw NetworkException.timeout();
    } on http.ClientException catch (e) {
      throw NetworkException(
        errorType: NetworkErrorType.serverError,
        message: 'Network error: ${e.message}',
        userMessage: 'Connection failed. Please check your network.',
      );
    } on ScanException {
      // Re-throw our custom exceptions
      rethrow;
    } catch (e) {
      throw OCRException(
        errorType: OCRErrorType.processingTimeout,
        message: 'Failed to scan bank details: $e',
        userMessage: 'An unexpected error occurred. Please try again.',
      );
    }
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
    try {
      // Validate amount
      if (amount <= 0) {
        throw PaymentException.amountTooSmall(minAmount: 0.01);
      }
      if (amount > 1000000) {
        throw PaymentException.amountTooLarge(maxAmount: 1000000);
      }

      // Get access token
      final accessToken = await secureStorage.getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        throw AuthenticationException.notAuthenticated();
      }

      // Validate bank details
      if (bankDetails.accountNumber.isEmpty) {
        throw ValidationException.invalidAccountNumber();
      }
      if (bankDetails.accountName.isEmpty) {
        throw ValidationException.missingAccountName();
      }
      if (bankDetails.bankName.isEmpty) {
        throw ValidationException.missingBankName();
      }

      // Prepare request body for gRPC payment service
      final requestBody = jsonEncode({
        'from_account_id': userId, // TODO: Should be actual account ID
        'bank_details': {
          'account_number': bankDetails.accountNumber,
          'account_name': bankDetails.accountName,
          'bank_name': bankDetails.bankName,
          'bank_code': bankDetails.bankCode,
          'routing_number': bankDetails.routingNumber,
          'account_type': bankDetails.accountType,
          'confidence_score': bankDetails.confidenceScore,
        },
        'amount': amount,
        'currency': 'USD', // TODO: Should be dynamic based on user's currency
        'description': description,
        'transaction_id': transactionId,
        'verification_token': verificationToken,
      });

      // Call payment service via gRPC or HTTP
      // For now, using HTTP to core-payments-service REST endpoint
      final paymentServiceUrl =
          chatGatewayBaseUrl.replaceAll('3011', '8080'); // TODO: Use proper config
      final uri = Uri.parse('$paymentServiceUrl/api/v1/payments/bank-details');

      final headers = await _getHeaders();
      final response = await httpClient
          .post(
        uri,
        headers: headers,
        body: requestBody,
      )
          .timeout(
        const Duration(seconds: 45),
        onTimeout: () {
          throw NetworkException.timeout();
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;

        // Create receipt from response
        final payment = responseData['payment'] as Map<String, dynamic>;
        final recipientName = responseData['recipient_name'] as String;
        final transferReference = responseData['transfer_reference'] as String?;

        return PaymentReceiptModel(
          id: payment['id'] as String,
          reference: payment['reference'] as String,
          recipientName: recipientName,
          accountNumber: bankDetails.accountNumber,
          bankName: bankDetails.bankName,
          amount: amount,
          currency: payment['currency'] as String,
          status: payment['status'] as String,
          description: description,
          transactionDate: DateTime.now(),
          transferReference: transferReference,
          isExternal: bankDetails.isExternal,
        );
      } else if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['message'] as String?;

        // Check for specific error types
        if (errorMessage?.toLowerCase().contains('invalid account') ?? false) {
          throw PaymentException.invalidAccount();
        } else if (errorMessage?.toLowerCase().contains('invalid pin') ?? false) {
          throw PaymentException.invalidPin();
        } else {
          throw PaymentException.transactionFailed(reason: errorMessage);
        }
      } else if (response.statusCode == 401) {
        throw AuthenticationException.sessionExpired();
      } else if (response.statusCode == 402) {
        final errorData = jsonDecode(response.body);
        final availableBalance =
            (errorData['available_balance'] as num?)?.toDouble() ?? 0.0;
        throw PaymentException.insufficientFunds(
          availableBalance: availableBalance,
          requestedAmount: amount,
        );
      } else if (response.statusCode == 403) {
        final errorData = jsonDecode(response.body);
        final unlocksAt = errorData['unlocks_at'] as String?;

        if (unlocksAt != null) {
          throw PaymentException.pinLocked(unlocksAt: unlocksAt);
        } else {
          throw AuthenticationException.unauthorized();
        }
      } else if (response.statusCode == 404) {
        throw PaymentException.invalidAccount();
      } else if (response.statusCode == 422) {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['message'] as String?;

        if (errorMessage?.toLowerCase().contains('bank not supported') ?? false) {
          throw BankValidationException.bankNotSupported(
            bankName: bankDetails.bankName,
          );
        } else {
          throw BankValidationException.validationFailed(reason: errorMessage);
        }
      } else if (response.statusCode == 429) {
        final retryAfter = int.tryParse(
          response.headers['retry-after'] ?? '',
        );
        throw RateLimitException.tooManyRequests(retryAfter: retryAfter);
      } else if (response.statusCode >= 500) {
        throw NetworkException.serverError(statusCode: response.statusCode);
      } else {
        throw PaymentException.transactionFailed(
          reason: 'Unexpected error: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw NetworkException.noConnection();
    } on TimeoutException {
      throw NetworkException.timeout();
    } on http.ClientException catch (e) {
      throw NetworkException(
        errorType: NetworkErrorType.serverError,
        message: 'Network error: ${e.message}',
        userMessage: 'Connection failed. Please check your network.',
      );
    } on ScanException {
      // Re-throw our custom exceptions
      rethrow;
    } catch (e) {
      throw PaymentException.transactionFailed(
        reason: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  // Helper methods for type conversion

  pb.ScanType _mapScanTypeToProto(ScanType scanType) {
    switch (scanType) {
      case ScanType.invoice:
        return pb.ScanType.INVOICE;
      case ScanType.utilityBill:
        return pb.ScanType.UTILITY_BILL;
      case ScanType.qrCode:
        return pb.ScanType.QR_CODE;
      case ScanType.barcode:
        return pb.ScanType.BARCODE;
      case ScanType.accountDetails:
        return pb.ScanType.ACCOUNT_DETAILS;
      case ScanType.giftCard:
        return pb.ScanType.GIFT_CARD;
      case ScanType.receipt:
        return pb.ScanType.RECEIPT;
      case ScanType.bankDetails:
        return pb.ScanType.BANK_DETAILS;
    }
  }

  ScanType _mapProtoToScanType(pb.ScanType protoType) {
    switch (protoType) {
      case pb.ScanType.INVOICE:
        return ScanType.invoice;
      case pb.ScanType.UTILITY_BILL:
        return ScanType.utilityBill;
      case pb.ScanType.QR_CODE:
        return ScanType.qrCode;
      case pb.ScanType.BARCODE:
        return ScanType.barcode;
      case pb.ScanType.ACCOUNT_DETAILS:
        return ScanType.accountDetails;
      case pb.ScanType.GIFT_CARD:
        return ScanType.giftCard;
      case pb.ScanType.RECEIPT:
        return ScanType.receipt;
      case pb.ScanType.BANK_DETAILS:
        return ScanType.bankDetails;
      default:
        return ScanType.invoice;
    }
  }

  ScanStatus _mapProtoToScanStatus(pb.ScanStatus protoStatus) {
    switch (protoStatus) {
      case pb.ScanStatus.PENDING:
        return ScanStatus.pending;
      case pb.ScanStatus.PROCESSING:
        return ScanStatus.analyzing;  // Map PROCESSING to analyzing
      case pb.ScanStatus.COMPLETED:
        return ScanStatus.completed;
      case pb.ScanStatus.FAILED:
        return ScanStatus.failed;
      default:
        return ScanStatus.pending;
    }
  }

  Map<String, dynamic> _convertExtractedDataToMap(pb.ExtractedData data) {
    final map = <String, dynamic>{};

    if (data.recipient.isNotEmpty) map['recipient'] = data.recipient;
    if (data.amount > 0) map['amount'] = data.amount;
    if (data.currency.isNotEmpty) map['currency'] = data.currency;
    if (data.reference.isNotEmpty) map['reference'] = data.reference;
    if (data.dueDate.isNotEmpty) map['due_date'] = data.dueDate;
    if (data.description.isNotEmpty) map['description'] = data.description;
    if (data.accountNumber.isNotEmpty) map['account_number'] = data.accountNumber;
    if (data.routingNumber.isNotEmpty) map['routing_number'] = data.routingNumber;
    if (data.bankName.isNotEmpty) map['bank_name'] = data.bankName;
    if (data.confidenceScore > 0) map['confidence_score'] = data.confidenceScore;

    // Add additional fields
    data.additionalFields.forEach((key, value) {
      map[key] = value;
    });

    return map;
  }

  pb.ExtractedData _convertMapToExtractedData(Map<String, dynamic> map) {
    final data = pb.ExtractedData();

    if (map.containsKey('recipient')) data.recipient = map['recipient'].toString();
    if (map.containsKey('amount')) data.amount = (map['amount'] as num).toDouble();
    if (map.containsKey('currency')) data.currency = map['currency'].toString();
    if (map.containsKey('reference')) data.reference = map['reference'].toString();
    if (map.containsKey('due_date')) data.dueDate = map['due_date'].toString();
    if (map.containsKey('description')) data.description = map['description'].toString();
    if (map.containsKey('account_number')) data.accountNumber = map['account_number'].toString();
    if (map.containsKey('routing_number')) data.routingNumber = map['routing_number'].toString();
    if (map.containsKey('bank_name')) data.bankName = map['bank_name'].toString();
    if (map.containsKey('confidence_score')) data.confidenceScore = (map['confidence_score'] as num).toDouble();

    return data;
  }
}
