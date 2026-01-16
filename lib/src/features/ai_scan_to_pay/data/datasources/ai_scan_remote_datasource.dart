import 'dart:convert';
import 'dart:io';
import 'package:grpc/grpc.dart';
import '../../../../core/network/grpc_client.dart';
import '../../../../generated/ai_scan.pb.dart' as pb;
import '../../domain/entities/scan_entities.dart';
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
}

class AiScanRemoteDataSourceImpl implements AiScanRemoteDataSource {
  final GrpcClient grpcClient;

  AiScanRemoteDataSourceImpl({required this.grpcClient});

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

      final request = pb.ProcessPaymentRequest()
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
