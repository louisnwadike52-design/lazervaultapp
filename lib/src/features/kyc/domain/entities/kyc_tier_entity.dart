import 'package:equatable/equatable.dart';

/// KYC Tier levels
enum KYCTier {
  unknown,
  tier1, // Basic - Phone/Email verified
  tier2, // Standard - ID verified (BVN/NIN)
  tier3, // Enhanced - Full KYC with address proof
}

/// KYC Verification status
enum KYCStatus {
  unknown,
  notStarted,
  inProgress,
  pendingReview,
  approved,
  rejected,
  expired,
}

/// ID Type for different countries
enum IDType {
  unknown,
  // Nigeria
  bvn,
  nin,
  driversLicense,
  internationalPassport,
  votersCard,
  // Ghana
  ghanaCard,
  // Kenya
  kenyaNationalId,
  kraPin,
  // South Africa
  saIdCard,
  saPassport,
  // UK
  ukPassport,
  ukDrivingLicense,
  // USA
  usSsn,
  usStateId,
  usPassport,
}

/// Extension to convert IDType to display name
extension IDTypeExtension on IDType {
  String get displayName {
    switch (this) {
      case IDType.bvn:
        return 'BVN';
      case IDType.nin:
        return 'NIN';
      case IDType.driversLicense:
        return "Driver's License";
      case IDType.internationalPassport:
        return 'International Passport';
      case IDType.votersCard:
        return "Voter's Card";
      case IDType.ghanaCard:
        return 'Ghana Card';
      case IDType.kenyaNationalId:
        return 'National ID';
      case IDType.kraPin:
        return 'KRA PIN';
      case IDType.saIdCard:
        return 'Smart ID Card';
      case IDType.saPassport:
        return 'Passport';
      case IDType.ukPassport:
        return 'Passport';
      case IDType.ukDrivingLicense:
        return "Driving License";
      case IDType.usSsn:
        return 'Social Security Number';
      case IDType.usStateId:
        return 'State ID';
      case IDType.usPassport:
        return 'Passport';
      default:
        return 'Unknown';
    }
  }
}

/// Document status
enum DocumentStatus {
  unknown,
  pendingUpload,
  uploaded,
  underReview,
  approved,
  rejected,
}

/// Country-specific KYC requirements
class CountryKYCRequirements extends Equatable {
  final String countryCode;
  final List<IDType> acceptedIdTypes;
  final List<IDType> mandatoryIdTypes;
  final bool addressProofRequired;
  final bool livenessCheckRequired;
  final int tier1DailyLimit;
  final int tier2DailyLimit;
  final int tier3DailyLimit;

  const CountryKYCRequirements({
    required this.countryCode,
    this.acceptedIdTypes = const [],
    this.mandatoryIdTypes = const [],
    this.addressProofRequired = false,
    this.livenessCheckRequired = false,
    this.tier1DailyLimit = 5000000, // 50,000 in kobo
    this.tier2DailyLimit = 50000000, // 500,000 in kobo
    this.tier3DailyLimit = 0, // Unlimited
  });

  @override
  List<Object?> get props => [
        countryCode,
        acceptedIdTypes,
        mandatoryIdTypes,
        addressProofRequired,
        livenessCheckRequired,
        tier1DailyLimit,
        tier2DailyLimit,
        tier3DailyLimit,
      ];
}

/// KYC Tier information
class KYCTierInfo extends Equatable {
  final KYCTier tier;
  final KYCStatus status;
  final String displayName;
  final String description;
  final List<String> benefits;
  final int dailyTransactionLimit;
  final int dailyReceiveLimit;
  final int maxBalance;
  final DateTime? verifiedAt;
  final DateTime? expiresAt;
  final bool isCurrent;
  final bool isLocked;

  const KYCTierInfo({
    required this.tier,
    required this.status,
    required this.displayName,
    required this.description,
    this.benefits = const [],
    required this.dailyTransactionLimit,
    required this.dailyReceiveLimit,
    required this.maxBalance,
    this.verifiedAt,
    this.expiresAt,
    this.isCurrent = false,
    this.isLocked = false,
  });

  /// Format limit as currency string
  String get dailyTransactionLimitDisplay {
    if (dailyTransactionLimit == 0) return 'Unlimited';
    return '₦${(dailyTransactionLimit / 100).toStringAsFixed(2)}';
  }

  String get dailyReceiveLimitDisplay {
    if (dailyReceiveLimit == 0) return 'Unlimited';
    return '₦${(dailyReceiveLimit / 100).toStringAsFixed(2)}';
  }

  String get maxBalanceDisplay {
    if (maxBalance == 0) return 'Unlimited';
    return '₦${(maxBalance / 100).toStringAsFixed(2)}';
  }

  @override
  List<Object?> get props => [
        tier,
        status,
        displayName,
        description,
        benefits,
        dailyTransactionLimit,
        dailyReceiveLimit,
        maxBalance,
        verifiedAt,
        expiresAt,
        isCurrent,
        isLocked,
      ];
}

/// Verification document
class VerificationDocument extends Equatable {
  final String id;
  final IDType documentType;
  final String documentUrl;
  final DocumentStatus status;
  final DateTime? uploadedAt;
  final DateTime? verifiedAt;
  final String? rejectionReason;

  const VerificationDocument({
    required this.id,
    required this.documentType,
    required this.documentUrl,
    required this.status,
    this.uploadedAt,
    this.verifiedAt,
    this.rejectionReason,
  });

  @override
  List<Object?> get props => [
        id,
        documentType,
        documentUrl,
        status,
        uploadedAt,
        verifiedAt,
        rejectionReason,
      ];
}

/// User KYC profile
class UserKYCProfile extends Equatable {
  final KYCStatus status;
  final KYCTier currentTier;
  final List<KYCTierInfo> tierInfo;
  final DateTime? lastUpdated;
  final String? rejectionReason;
  final List<VerificationDocument> documents;

  const UserKYCProfile({
    required this.status,
    required this.currentTier,
    this.tierInfo = const [],
    this.lastUpdated,
    this.rejectionReason,
    this.documents = const [],
  });

  /// Check if user can upgrade to next tier
  bool canUpgradeTo(KYCTier targetTier) {
    if (currentTier.index >= targetTier.index) return false;
    if (status == KYCStatus.inProgress || status == KYCStatus.pendingReview) {
      return false;
    }
    return true;
  }

  /// Get next tier to upgrade to
  KYCTier? get nextTier {
    if (currentTier == KYCTier.tier1) return KYCTier.tier2;
    if (currentTier == KYCTier.tier2) return KYCTier.tier3;
    return null;
  }

  /// Check if user is fully verified
  bool get isFullyVerified => status == KYCStatus.approved;

  /// Check if user has any pending verification
  bool get hasPendingVerification =>
      status == KYCStatus.inProgress || status == KYCStatus.pendingReview;

  /// Get display color for status
  String getStatusColor() {
    switch (status) {
      case KYCStatus.approved:
        return '#4CAF50'; // Green
      case KYCStatus.inProgress:
      case KYCStatus.pendingReview:
        return '#FF9800'; // Orange
      case KYCStatus.rejected:
        return '#F44336'; // Red
      case KYCStatus.expired:
        return '#E91E63'; // Pink
      default:
        return '#9E9E9E'; // Grey
    }
  }

  @override
  List<Object?> get props => [
        status,
        currentTier,
        tierInfo,
        lastUpdated,
        rejectionReason,
        documents,
      ];
}

/// ID Verification request
class IDVerificationRequest extends Equatable {
  final String userId;
  final IDType idType;
  final String idNumber;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String phoneNumber;

  const IDVerificationRequest({
    required this.userId,
    required this.idType,
    required this.idNumber,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [
        userId,
        idType,
        idNumber,
        firstName,
        lastName,
        dateOfBirth,
        phoneNumber,
      ];

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'id_type': idType.name,
      'id_number': idNumber,
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
      'phone_number': phoneNumber,
    };
  }

  /// Create from JSON
  factory IDVerificationRequest.fromJson(Map<String, dynamic> json) {
    return IDVerificationRequest(
      userId: json['user_id'] as String,
      idType: IDType.values.firstWhere(
        (e) => e.name == json['id_type'],
        orElse: () => IDType.unknown,
      ),
      idNumber: json['id_number'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      dateOfBirth: json['date_of_birth'] as String,
      phoneNumber: json['phone_number'] as String,
    );
  }
}

/// Document upload request
class DocumentUploadRequest extends Equatable {
  final String userId;
  final IDType documentType;
  final String? documentFrontUrl;
  final String? documentBackUrl;
  final String? selfieUrl;
  final String? proofOfAddressUrl;

  const DocumentUploadRequest({
    required this.userId,
    required this.documentType,
    this.documentFrontUrl,
    this.documentBackUrl,
    this.selfieUrl,
    this.proofOfAddressUrl,
  });

  @override
  List<Object?> get props => [
        userId,
        documentType,
        documentFrontUrl,
        documentBackUrl,
        selfieUrl,
        proofOfAddressUrl,
      ];

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'document_type': documentType.name,
      if (documentFrontUrl != null) 'document_front_url': documentFrontUrl,
      if (documentBackUrl != null) 'document_back_url': documentBackUrl,
      if (selfieUrl != null) 'selfie_url': selfieUrl,
      if (proofOfAddressUrl != null)
        'proof_of_address_url': proofOfAddressUrl,
    };
  }
}

/// KYC initiation response
class KYCInitiationResponse extends Equatable {
  final bool success;
  final String? sessionId;
  final List<String> requiredDocuments;
  final List<String> requiredFields;
  final String? redirectUrl;
  final String? errorMessage;

  const KYCInitiationResponse({
    required this.success,
    this.sessionId,
    this.requiredDocuments = const [],
    this.requiredFields = const [],
    this.redirectUrl,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        success,
        sessionId,
        requiredDocuments,
        requiredFields,
        redirectUrl,
        errorMessage,
      ];
}

/// Skip KYC response
class SkipKYCResponse extends Equatable {
  final bool success;
  final KYCTier assignedTier;
  final String message;
  final List<String> nextSteps;

  const SkipKYCResponse({
    required this.success,
    required this.assignedTier,
    required this.message,
    this.nextSteps = const [],
  });

  @override
  List<Object?> get props => [success, assignedTier, message, nextSteps];
}

/// ID Verification response
class VerifyIDResponse extends Equatable {
  final bool success;
  final String? message;
  final KYCStatus status;
  final KYCTier currentTier;
  final DateTime? verifiedAt;
  final String? reference;

  const VerifyIDResponse({
    required this.success,
    this.message,
    required this.status,
    required this.currentTier,
    this.verifiedAt,
    this.reference,
  });

  @override
  List<Object?> get props => [success, message, status, currentTier, verifiedAt, reference];
}
