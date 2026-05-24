import 'package:equatable/equatable.dart';

// Lifecycle states the user can see on a claim. The first six are the
// canonical Flutter tabs; the rest mirror MyCover's mid-flight stages
// (per docs/MYCOVER_AI_PRODUCT_REFERENCE.md) so the adjuster's progress
// is visible instead of every mid-flight state collapsing to under_review.
enum ClaimStatus {
  submitted,
  underReview,
  approved,
  rejected,
  settled,
  cancelled,
  // Mid-flight (also rolled into the "Under Review" tab on the list
  // screen — but rendered with their specific label on the row).
  documented,
  inspectionSubmitted,
  repairEstimateRequested,
  repairEstimateProvided,
  offerSent,
  offerAccepted,
  offerRejected,
  paid, // alias for settled used by some providers
}

enum ClaimType {
  medical,
  accident,
  theft,
  fire,
  naturalDisaster,
  liability,
  death,
  disability,
  other,
}

extension ClaimStatusExtension on ClaimStatus {
  String get displayName {
    switch (this) {
      case ClaimStatus.submitted:
        return 'Submitted';
      case ClaimStatus.underReview:
        return 'Under Review';
      case ClaimStatus.approved:
        return 'Approved';
      case ClaimStatus.rejected:
        return 'Rejected';
      case ClaimStatus.settled:
        return 'Settled';
      case ClaimStatus.cancelled:
        return 'Cancelled';
      case ClaimStatus.documented:
        return 'Documented';
      case ClaimStatus.inspectionSubmitted:
        return 'Inspection Submitted';
      case ClaimStatus.repairEstimateRequested:
        return 'Repair Estimate Requested';
      case ClaimStatus.repairEstimateProvided:
        return 'Repair Estimate Provided';
      case ClaimStatus.offerSent:
        return 'Offer Sent';
      case ClaimStatus.offerAccepted:
        return 'Offer Accepted';
      case ClaimStatus.offerRejected:
        return 'Offer Rejected';
      case ClaimStatus.paid:
        return 'Paid';
    }
  }

  // Mid-flight states roll into the Under Review tab for filtering, but
  // their per-row label still surfaces the specific stage.
  bool get isUnderReviewFamily {
    switch (this) {
      case ClaimStatus.underReview:
      case ClaimStatus.documented:
      case ClaimStatus.inspectionSubmitted:
      case ClaimStatus.repairEstimateRequested:
      case ClaimStatus.repairEstimateProvided:
      case ClaimStatus.offerSent:
      case ClaimStatus.offerAccepted:
        return true;
      default:
        return false;
    }
  }
}

extension ClaimTypeExtension on ClaimType {
  String get displayName {
    switch (this) {
      case ClaimType.medical:
        return 'Medical';
      case ClaimType.accident:
        return 'Accident';
      case ClaimType.theft:
        return 'Theft';
      case ClaimType.fire:
        return 'Fire';
      case ClaimType.naturalDisaster:
        return 'Natural Disaster';
      case ClaimType.liability:
        return 'Liability';
      case ClaimType.death:
        return 'Death';
      case ClaimType.disability:
        return 'Disability';
      case ClaimType.other:
        return 'Other';
    }
  }
}

class InsuranceClaim extends Equatable {
  final String id;
  final String claimNumber;
  final String insuranceId;
  final String policyNumber;
  final ClaimType type;
  final ClaimStatus status;
  final String title;
  final String description;
  final double claimAmount;
  final double? approvedAmount;
  final String currency;
  final DateTime incidentDate;
  final String incidentLocation;
  final List<String> attachments;
  final List<String> documents;
  final Map<String, dynamic> additionalInfo;
  final String? rejectionReason;
  final DateTime? settlementDate;
  final String? settlementDetails;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;

  const InsuranceClaim({
    required this.id,
    required this.claimNumber,
    required this.insuranceId,
    required this.policyNumber,
    required this.type,
    required this.status,
    required this.title,
    required this.description,
    required this.claimAmount,
    this.approvedAmount,
    required this.currency,
    required this.incidentDate,
    required this.incidentLocation,
    required this.attachments,
    required this.documents,
    required this.additionalInfo,
    this.rejectionReason,
    this.settlementDate,
    this.settlementDetails,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  bool get isApproved => status == ClaimStatus.approved;
  bool get isRejected => status == ClaimStatus.rejected;
  bool get isSettled => status == ClaimStatus.settled;
  bool get isPending => status == ClaimStatus.submitted || status == ClaimStatus.underReview;

  InsuranceClaim copyWith({
    String? id,
    String? claimNumber,
    String? insuranceId,
    String? policyNumber,
    ClaimType? type,
    ClaimStatus? status,
    String? title,
    String? description,
    double? claimAmount,
    double? approvedAmount,
    String? currency,
    DateTime? incidentDate,
    String? incidentLocation,
    List<String>? attachments,
    List<String>? documents,
    Map<String, dynamic>? additionalInfo,
    String? rejectionReason,
    DateTime? settlementDate,
    String? settlementDetails,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
  }) {
    return InsuranceClaim(
      id: id ?? this.id,
      claimNumber: claimNumber ?? this.claimNumber,
      insuranceId: insuranceId ?? this.insuranceId,
      policyNumber: policyNumber ?? this.policyNumber,
      type: type ?? this.type,
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
      claimAmount: claimAmount ?? this.claimAmount,
      approvedAmount: approvedAmount ?? this.approvedAmount,
      currency: currency ?? this.currency,
      incidentDate: incidentDate ?? this.incidentDate,
      incidentLocation: incidentLocation ?? this.incidentLocation,
      attachments: attachments ?? this.attachments,
      documents: documents ?? this.documents,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      settlementDate: settlementDate ?? this.settlementDate,
      settlementDetails: settlementDetails ?? this.settlementDetails,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        claimNumber,
        insuranceId,
        policyNumber,
        type,
        status,
        title,
        description,
        claimAmount,
        approvedAmount,
        currency,
        incidentDate,
        incidentLocation,
        attachments,
        documents,
        additionalInfo,
        rejectionReason,
        settlementDate,
        settlementDetails,
        createdAt,
        updatedAt,
        userId,
      ];
} 