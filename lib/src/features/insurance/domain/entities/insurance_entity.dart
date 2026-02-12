import 'package:equatable/equatable.dart';

enum InsuranceType {
  health,
  auto,
  home,
  life,
  travel,
  business,
  gadget,
}

enum InsuranceStatus {
  active,
  pending,
  expired,
  cancelled,
  suspended,
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