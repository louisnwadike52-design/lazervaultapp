import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

enum KYCLevel {
  none,
  basic,
  intermediate,
  advanced,
}

enum VerificationStatus {
  pending,
  inProgress,
  approved,
  rejected,
  expired,
  resubmit,
}

enum DocumentType {
  passport,
  driversLicense,
  nationalId,
  residencePermit,
  utilityBill,
  bankStatement,
  selfie,
}

class KYCService {
  final String baseUrl;
  final String apiKey;

  KYCService({
    required this.baseUrl,
    required this.apiKey,
  });

  // Get current KYC status
  Future<KYCStatus> getKYCStatus(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/kyc/status'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return KYCStatus.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get KYC status');
    }
  }

  // Create new verification
  Future<VerificationResponse> createVerification({
    required String userId,
    required KYCLevel targetLevel,
    PersonalInfo? personalInfo,
    AddressInfo? addressInfo,
    List<DocumentUpload>? documents,
  }) async {
    final body = {
      'user_id': userId,
      'target_level': targetLevel.toString().split('.').last,
      if (personalInfo != null) 'personal_info': personalInfo.toJson(),
      if (addressInfo != null) 'address_info': addressInfo.toJson(),
      if (documents != null) 'documents': documents.map((d) => d.toJson()).toList(),
    };

    final response = await http.post(
      Uri.parse('$baseUrl/kyc/verify'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return VerificationResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create verification');
    }
  }

  // Upload document
  Future<String> uploadDocument({
    required String verificationId,
    required DocumentType documentType,
    required XFile file,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/kyc/documents/upload'),
    );

    request.headers['Authorization'] = 'Bearer $apiKey';
    request.fields['verification_id'] = verificationId;
    request.fields['document_type'] = documentType.toString().split('.').last;

    request.files.add(
      await http.MultipartFile.fromPath('file', file.path),
    );

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final data = json.decode(responseBody);
      return data['document_url'];
    } else {
      throw Exception('Failed to upload document');
    }
  }

  // Submit liveness check
  Future<void> submitLivenessCheck({
    required String verificationId,
    required XFile selfie,
    XFile? video,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/kyc/liveness'),
    );

    request.headers['Authorization'] = 'Bearer $apiKey';
    request.fields['verification_id'] = verificationId;

    request.files.add(
      await http.MultipartFile.fromPath('selfie', selfie.path),
    );

    if (video != null) {
      request.files.add(
        await http.MultipartFile.fromPath('video', video.path),
      );
    }

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Failed to submit liveness check');
    }
  }

  // Get verification by ID
  Future<Verification> getVerification(String verificationId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/kyc/verification/$verificationId'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Verification.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get verification');
    }
  }

  // Check if transaction is within limits
  Future<TransactionLimitsCheck> checkTransactionLimits({
    required String userId,
    required double amount,
  }) async {
    final body = {
      'user_id': userId,
      'transaction_amount': amount,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/kyc/check-limits'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      return TransactionLimitsCheck.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to check transaction limits');
    }
  }
}

// Models

class KYCStatus {
  final KYCLevel level;
  final TransactionLimits limits;
  final Verification? verification;

  KYCStatus({
    required this.level,
    required this.limits,
    this.verification,
  });

  factory KYCStatus.fromJson(Map<String, dynamic> json) {
    return KYCStatus(
      level: _parseKYCLevel(json['kyc_level']),
      limits: TransactionLimits.fromJson(json['limits']),
      verification: json['verification'] != null
          ? Verification.fromJson(json['verification'])
          : null,
    );
  }

  static KYCLevel _parseKYCLevel(String level) {
    switch (level) {
      case 'basic':
        return KYCLevel.basic;
      case 'intermediate':
        return KYCLevel.intermediate;
      case 'advanced':
        return KYCLevel.advanced;
      default:
        return KYCLevel.none;
    }
  }
}

class TransactionLimits {
  final double maxTransactionAmount;
  final double maxMonthlyAmount;
  final int maxDailyTransactions;

  TransactionLimits({
    required this.maxTransactionAmount,
    required this.maxMonthlyAmount,
    required this.maxDailyTransactions,
  });

  factory TransactionLimits.fromJson(Map<String, dynamic> json) {
    return TransactionLimits(
      maxTransactionAmount: json['max_transaction_amount'].toDouble(),
      maxMonthlyAmount: json['max_monthly_amount'].toDouble(),
      maxDailyTransactions: json['max_daily_transactions'],
    );
  }
}

class Verification {
  final String id;
  final String userId;
  final KYCLevel targetLevel;
  final KYCLevel currentLevel;
  final VerificationStatus status;
  final String? rejectionReason;
  final String? rejectionNote;
  final List<String> nextSteps;
  final DateTime createdAt;
  final DateTime? expiresAt;

  Verification({
    required this.id,
    required this.userId,
    required this.targetLevel,
    required this.currentLevel,
    required this.status,
    this.rejectionReason,
    this.rejectionNote,
    required this.nextSteps,
    required this.createdAt,
    this.expiresAt,
  });

  factory Verification.fromJson(Map<String, dynamic> json) {
    return Verification(
      id: json['id'],
      userId: json['user_id'],
      targetLevel: KYCStatus._parseKYCLevel(json['target_level'].toString()),
      currentLevel: KYCStatus._parseKYCLevel(json['current_level'].toString()),
      status: _parseStatus(json['status']),
      rejectionReason: json['rejection_reason'],
      rejectionNote: json['rejection_note'],
      nextSteps: List<String>.from(json['next_steps'] ?? []),
      createdAt: DateTime.parse(json['created_at']),
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'])
          : null,
    );
  }

  static VerificationStatus _parseStatus(String status) {
    switch (status) {
      case 'pending':
        return VerificationStatus.pending;
      case 'in_progress':
        return VerificationStatus.inProgress;
      case 'approved':
        return VerificationStatus.approved;
      case 'rejected':
        return VerificationStatus.rejected;
      case 'expired':
        return VerificationStatus.expired;
      case 'resubmit':
        return VerificationStatus.resubmit;
      default:
        return VerificationStatus.pending;
    }
  }
}

class VerificationResponse {
  final Verification verification;
  final List<String> nextSteps;
  final String message;

  VerificationResponse({
    required this.verification,
    required this.nextSteps,
    required this.message,
  });

  factory VerificationResponse.fromJson(Map<String, dynamic> json) {
    return VerificationResponse(
      verification: Verification.fromJson(json['verification']),
      nextSteps: List<String>.from(json['next_steps'] ?? []),
      message: json['message'] ?? '',
    );
  }
}

class PersonalInfo {
  final String firstName;
  final String? middleName;
  final String lastName;
  final DateTime dateOfBirth;
  final String? nationality;
  final String? documentNumber;
  final String? issuingCountry;
  final DateTime? expiryDate;

  PersonalInfo({
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.dateOfBirth,
    this.nationality,
    this.documentNumber,
    this.issuingCountry,
    this.expiryDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      if (middleName != null) 'middle_name': middleName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth.toIso8601String(),
      if (nationality != null) 'nationality': nationality,
      if (documentNumber != null) 'document_number': documentNumber,
      if (issuingCountry != null) 'issuing_country': issuingCountry,
      if (expiryDate != null) 'expiry_date': expiryDate!.toIso8601String(),
    };
  }
}

class AddressInfo {
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String? state;
  final String postalCode;
  final String country;

  AddressInfo({
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    this.state,
    required this.postalCode,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      'address_line1': addressLine1,
      if (addressLine2 != null) 'address_line2': addressLine2,
      'city': city,
      if (state != null) 'state': state,
      'postal_code': postalCode,
      'country': country,
    };
  }
}

class DocumentUpload {
  final DocumentType type;
  final String frontImageUrl;
  final String? backImageUrl;

  DocumentUpload({
    required this.type,
    required this.frontImageUrl,
    this.backImageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString().split('.').last,
      'front_image_url': frontImageUrl,
      if (backImageUrl != null) 'back_image_url': backImageUrl,
    };
  }
}

class TransactionLimitsCheck {
  final bool allowed;
  final KYCLevel currentLevel;
  final KYCLevel? requiredLevel;
  final TransactionLimits limits;
  final String message;

  TransactionLimitsCheck({
    required this.allowed,
    required this.currentLevel,
    this.requiredLevel,
    required this.limits,
    required this.message,
  });

  factory TransactionLimitsCheck.fromJson(Map<String, dynamic> json) {
    return TransactionLimitsCheck(
      allowed: json['allowed'],
      currentLevel: KYCStatus._parseKYCLevel(json['current_level']),
      requiredLevel: json['required_level'] != null
          ? KYCStatus._parseKYCLevel(json['required_level'])
          : null,
      limits: TransactionLimits.fromJson(json['limits']),
      message: json['message'] ?? '',
    );
  }
}
