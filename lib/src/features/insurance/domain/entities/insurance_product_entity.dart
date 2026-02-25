import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Insurance product categories from MyCover.ai
enum InsuranceProductCategory {
  auto,
  health,
  travel,
  gadget,
  home,
  life,
  marine,
  personalAccident;

  String get displayName {
    switch (this) {
      case InsuranceProductCategory.auto:
        return 'Auto';
      case InsuranceProductCategory.health:
        return 'Health';
      case InsuranceProductCategory.travel:
        return 'Travel';
      case InsuranceProductCategory.gadget:
        return 'Gadget';
      case InsuranceProductCategory.home:
        return 'Home';
      case InsuranceProductCategory.life:
        return 'Life';
      case InsuranceProductCategory.marine:
        return 'Marine';
      case InsuranceProductCategory.personalAccident:
        return 'Personal Accident';
    }
  }

  IconData get icon {
    switch (this) {
      case InsuranceProductCategory.auto:
        return Icons.directions_car;
      case InsuranceProductCategory.health:
        return Icons.health_and_safety;
      case InsuranceProductCategory.travel:
        return Icons.flight;
      case InsuranceProductCategory.gadget:
        return Icons.devices;
      case InsuranceProductCategory.home:
        return Icons.home;
      case InsuranceProductCategory.life:
        return Icons.favorite;
      case InsuranceProductCategory.marine:
        return Icons.sailing;
      case InsuranceProductCategory.personalAccident:
        return Icons.personal_injury;
    }
  }

  static InsuranceProductCategory fromString(String value) {
    switch (value.toLowerCase().replaceAll(' ', '_')) {
      case 'auto':
        return InsuranceProductCategory.auto;
      case 'health':
        return InsuranceProductCategory.health;
      case 'travel':
        return InsuranceProductCategory.travel;
      case 'gadget':
        return InsuranceProductCategory.gadget;
      case 'home':
        return InsuranceProductCategory.home;
      case 'life':
        return InsuranceProductCategory.life;
      case 'marine':
        return InsuranceProductCategory.marine;
      case 'personal_accident':
        return InsuranceProductCategory.personalAccident;
      case 'package':
        return InsuranceProductCategory.personalAccident; // Map package to personalAccident
      case 'content':
        return InsuranceProductCategory.home; // Map content to home
      default:
        return InsuranceProductCategory.health;
    }
  }
}

/// Utility ID constants for auxiliary data lookups
class InsuranceUtilityIds {
  static const nigerianStates = 'e55de863-7d98-4236-bd61-40328cd7f7fc';
  static const vehicleMakes = 'fa2fb85f-9d1a-4652-a136-9da8e4c57c5c';
  static const vehicleModels = '86db5030-df01-4e2d-821b-e43e017f7e67';
}

/// Auxiliary data item from MyCover.ai utility endpoints
class AuxiliaryItem extends Equatable {
  final String label;
  final String value;

  const AuxiliaryItem({required this.label, required this.value});

  @override
  List<Object?> get props => [label, value];
}

/// Dynamic form field from MyCover.ai product
class InsuranceProductFormField extends Equatable {
  final String name;
  final String label;
  final String type; // "text", "number", "date", "select", "boolean", "email", "phone"
  final bool required;
  final List<String> options;
  final String defaultValue;
  final String validationRegex;
  final String placeholder;
  final String description;

  const InsuranceProductFormField({
    required this.name,
    required this.label,
    required this.type,
    this.required = false,
    this.options = const [],
    this.defaultValue = '',
    this.validationRegex = '',
    this.placeholder = '',
    this.description = '',
  });

  @override
  List<Object?> get props => [name, label, type, required, options, defaultValue];
}

/// Insurance product from MyCover.ai marketplace
class InsuranceProduct extends Equatable {
  final String id;
  final String name;
  final String description;
  final InsuranceProductCategory category;
  final String providerName;
  final String providerLogo;
  final double minPremium;
  final double maxPremium;
  final String currency;
  final List<String> benefits;
  final String termsUrl;
  final Map<String, String> metadata;
  final List<InsuranceProductFormField> formFields;
  final bool isActive;
  final String purchaseRoute;
  final String providerId;
  final double basePrice;
  final String howItWorks;
  final String fullBenefits;
  final bool isRenewable;
  final bool isClaimable;

  const InsuranceProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.providerName,
    this.providerLogo = '',
    required this.minPremium,
    required this.maxPremium,
    required this.currency,
    this.benefits = const [],
    this.termsUrl = '',
    this.metadata = const {},
    this.formFields = const [],
    this.isActive = true,
    this.purchaseRoute = '',
    this.providerId = '',
    this.basePrice = 0,
    this.howItWorks = '',
    this.fullBenefits = '',
    this.isRenewable = false,
    this.isClaimable = false,
  });

  String get premiumRange {
    if (minPremium == maxPremium) {
      return '$currency ${_formatAmount(minPremium)}';
    }
    return '$currency ${_formatAmount(minPremium)} - ${_formatAmount(maxPremium)}';
  }

  String _formatAmount(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)}K';
    }
    return amount.toStringAsFixed(0);
  }

  @override
  List<Object?> get props => [id, name, category, providerName, isActive];
}

/// Insurance category metadata
class InsuranceCategoryInfo extends Equatable {
  final String id;
  final String name;
  final String icon;
  final String description;
  final int productCount;

  const InsuranceCategoryInfo({
    required this.id,
    required this.name,
    this.icon = '',
    this.description = '',
    this.productCount = 0,
  });

  InsuranceProductCategory get category => InsuranceProductCategory.fromString(name);

  @override
  List<Object?> get props => [id, name, productCount];
}

/// Quote result from MyCover.ai
class InsuranceQuote extends Equatable {
  final String quoteId;
  final String productId;
  final double premium;
  final String currency;
  final String coverageSummary;
  final List<String> coverageItems;
  final DateTime? validUntil;
  final Map<String, String> quoteDetails;

  const InsuranceQuote({
    required this.quoteId,
    required this.productId,
    required this.premium,
    required this.currency,
    this.coverageSummary = '',
    this.coverageItems = const [],
    this.validUntil,
    this.quoteDetails = const {},
  });

  bool get isExpired =>
      validUntil != null && DateTime.now().isAfter(validUntil!);

  @override
  List<Object?> get props => [quoteId, productId, premium, currency, validUntil];
}

/// Purchase result from MyCover.ai
class InsurancePurchaseResult extends Equatable {
  final String policyId;
  final String policyNumber;
  final String reference;
  final String status;
  final String providerReference;

  const InsurancePurchaseResult({
    required this.policyId,
    required this.policyNumber,
    required this.reference,
    required this.status,
    this.providerReference = '',
  });

  bool get isCompleted => status == 'completed';
  bool get isPending => status == 'pending';
  bool get isFailed => status == 'failed';

  @override
  List<Object?> get props => [policyId, reference, status];
}
