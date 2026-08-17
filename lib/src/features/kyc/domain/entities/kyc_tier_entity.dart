import 'package:equatable/equatable.dart';
part 'kyc_tier_entity_widgets.dart';


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
