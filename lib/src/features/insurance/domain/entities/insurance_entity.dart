import 'package:equatable/equatable.dart';

enum InsuranceType {
  health,
  auto,
  home,
  life,
  travel,
  business,
  gadget,
  // Used when the backend sends an opaque identifier (e.g. raw
  // marketplace product UUID) or an empty string. Renders as the
  // neutral "Insurance" label rather than misclassifying as Health.
  other,
}

enum InsuranceStatus {
  active,
  pending,
  expired,
  cancelled,
  suspended,
  // In-flight purchase states from the marketplace saga. Surfacing
  // them so the user sees "Processing…" / "Refunding…" instead of a
  // generic "Pending" or — worse — silence until the row flips to
  // terminal. Wire-name strings match insurance_purchases.status.
  processing,
  awaitingWebhook,
  refundPending,
  refunded,
  refundFailed,
  manualReview,
}

extension InsuranceTypeExtension on InsuranceType {
  String get displayName {
    switch (this) {
      case InsuranceType.health:
        return 'Health Insurance';
      case InsuranceType.auto:
        return 'Auto Insurance';
      case InsuranceType.home:
        return 'Home Insurance';
      case InsuranceType.life:
        return 'Life Insurance';
      case InsuranceType.travel:
        return 'Travel Insurance';
      case InsuranceType.business:
        return 'Business Insurance';
      case InsuranceType.gadget:
        return 'Gadget Insurance';
      case InsuranceType.other:
        return 'Insurance';
    }
  }

  String get icon {
    switch (this) {
      case InsuranceType.health:
        return '🏥';
      case InsuranceType.auto:
        return '🚗';
      case InsuranceType.home:
        return '🏠';
      case InsuranceType.life:
        return '👤';
      case InsuranceType.travel:
        return '✈️';
      case InsuranceType.business:
        return '🏢';
      case InsuranceType.gadget:
        return '📱';
      case InsuranceType.other:
        return '🛡️';
    }
  }
}

extension InsuranceStatusExtension on InsuranceStatus {
  String get displayName {
    switch (this) {
      case InsuranceStatus.active:
        return 'Active';
      case InsuranceStatus.pending:
        return 'Pending';
      case InsuranceStatus.expired:
        return 'Expired';
      case InsuranceStatus.cancelled:
        return 'Cancelled';
      case InsuranceStatus.suspended:
        return 'Suspended';
      case InsuranceStatus.processing:
        return 'Processing';
      case InsuranceStatus.awaitingWebhook:
        return 'Awaiting Provider';
      case InsuranceStatus.refundPending:
        return 'Refunding';
      case InsuranceStatus.refunded:
        return 'Refunded';
      case InsuranceStatus.refundFailed:
        return 'Refund Failed';
      case InsuranceStatus.manualReview:
        return 'Under Manual Review';
    }
  }

  // Short hint shown beneath the status pill — helps the user
  // understand what's actually happening without an ops call.
  String get hint {
    switch (this) {
      case InsuranceStatus.processing:
        return 'Awaiting provider confirmation. Refresh in a moment.';
      case InsuranceStatus.awaitingWebhook:
        return 'Provider notification pending. Reconciler verifies every few minutes.';
      case InsuranceStatus.refundPending:
        return 'Your payment is being returned. Funds usually land within 5 minutes.';
      case InsuranceStatus.refundFailed:
        return 'We couldn\'t refund automatically. Our team is on it.';
      case InsuranceStatus.manualReview:
        return 'Our ops team is reviewing this purchase.';
      case InsuranceStatus.refunded:
        return 'Funds were returned to your wallet.';
      default:
        return '';
    }
  }

  // Terminal = no further state transitions are expected. The
  // detail screen uses this to decide whether to show the polling
  // "in flight" badge or just the static status.
  bool get isTerminal {
    switch (this) {
      case InsuranceStatus.active:
      case InsuranceStatus.expired:
      case InsuranceStatus.cancelled:
      case InsuranceStatus.refunded:
      case InsuranceStatus.manualReview:
        return true;
      default:
        return false;
    }
  }
}

class Insurance extends Equatable {
  final String id;
  final String policyNumber;
  final String policyHolderName;
  final String policyHolderEmail;
  final String policyHolderPhone;
  final InsuranceType type;
  final String provider;
  final String providerLogo;
  final double premiumAmount;
  final double coverageAmount;
  final String currency;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime nextPaymentDate;
  final InsuranceStatus status;
  final List<String> beneficiaries;
  final Map<String, dynamic> coverageDetails;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;

  const Insurance({
    required this.id,
    required this.policyNumber,
    required this.policyHolderName,
    required this.policyHolderEmail,
    required this.policyHolderPhone,
    required this.type,
    required this.provider,
    required this.providerLogo,
    required this.premiumAmount,
    required this.coverageAmount,
    required this.currency,
    required this.startDate,
    required this.endDate,
    required this.nextPaymentDate,
    required this.status,
    required this.beneficiaries,
    required this.coverageDetails,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  bool get isActive => status == InsuranceStatus.active;
  bool get isExpired => status == InsuranceStatus.expired || DateTime.now().isAfter(endDate);
  bool get isPaymentDue => DateTime.now().isAfter(nextPaymentDate);
  
  int get daysUntilExpiry => endDate.difference(DateTime.now()).inDays;
  int get daysUntilPayment => nextPaymentDate.difference(DateTime.now()).inDays;

  Insurance copyWith({
    String? id,
    String? policyNumber,
    String? policyHolderName,
    String? policyHolderEmail,
    String? policyHolderPhone,
    InsuranceType? type,
    String? provider,
    String? providerLogo,
    double? premiumAmount,
    double? coverageAmount,
    String? currency,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? nextPaymentDate,
    InsuranceStatus? status,
    List<String>? beneficiaries,
    Map<String, dynamic>? coverageDetails,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
  }) {
    return Insurance(
      id: id ?? this.id,
      policyNumber: policyNumber ?? this.policyNumber,
      policyHolderName: policyHolderName ?? this.policyHolderName,
      policyHolderEmail: policyHolderEmail ?? this.policyHolderEmail,
      policyHolderPhone: policyHolderPhone ?? this.policyHolderPhone,
      type: type ?? this.type,
      provider: provider ?? this.provider,
      providerLogo: providerLogo ?? this.providerLogo,
      premiumAmount: premiumAmount ?? this.premiumAmount,
      coverageAmount: coverageAmount ?? this.coverageAmount,
      currency: currency ?? this.currency,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      nextPaymentDate: nextPaymentDate ?? this.nextPaymentDate,
      status: status ?? this.status,
      beneficiaries: beneficiaries ?? this.beneficiaries,
      coverageDetails: coverageDetails ?? this.coverageDetails,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        policyNumber,
        policyHolderName,
        policyHolderEmail,
        policyHolderPhone,
        type,
        provider,
        providerLogo,
        premiumAmount,
        coverageAmount,
        currency,
        startDate,
        endDate,
        nextPaymentDate,
        status,
        beneficiaries,
        coverageDetails,
        description,
        createdAt,
        updatedAt,
        userId,
      ];
} 