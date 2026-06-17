import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'insurance_entity.dart';

/// Insurance product categories surfaced by MyCover.ai's
/// /v2/products/categories endpoint. Every backend category MUST have
/// a matching enum value so `fromString` is lossless — collapsing
/// unknown categories into `.health` (the previous default) caused
/// users tapping Health to land on Agency Banking and vice-versa
/// because three categories all resolved to the same enum value.
enum InsuranceProductCategory {
  auto,
  health,
  travel,
  gadget,
  home,
  life,
  creditLife,
  agencyBanking,
  marine,
  package,
  content,
  personalAccident,
  other; // catch-all for any future category we haven't enumerated yet

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
      case InsuranceProductCategory.creditLife:
        return 'Credit Life';
      case InsuranceProductCategory.agencyBanking:
        return 'Agency Banking';
      case InsuranceProductCategory.marine:
        return 'Marine';
      case InsuranceProductCategory.package:
        return 'Package';
      case InsuranceProductCategory.content:
        return 'Content';
      case InsuranceProductCategory.personalAccident:
        return 'Personal Accident';
      case InsuranceProductCategory.other:
        return 'Other';
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
      case InsuranceProductCategory.creditLife:
        return Icons.credit_card;
      case InsuranceProductCategory.agencyBanking:
        return Icons.account_balance;
      case InsuranceProductCategory.marine:
        return Icons.sailing;
      case InsuranceProductCategory.package:
        return Icons.inventory_2;
      case InsuranceProductCategory.content:
        return Icons.chair;
      case InsuranceProductCategory.personalAccident:
        return Icons.personal_injury;
      case InsuranceProductCategory.other:
        return Icons.category;
    }
  }

  /// Resolve a backend category name (e.g. "Auto", "Credit Life",
  /// "Agency Banking") to its enum. Returns [InsuranceProductCategory.other]
  /// for unknown names — explicit failure mode that callers can detect.
  /// Never silently aliases categories together.
  static InsuranceProductCategory fromString(String value) {
    switch (value.toLowerCase().replaceAll(' ', '_').replaceAll('-', '_')) {
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
      case 'credit_life':
        return InsuranceProductCategory.creditLife;
      case 'agency_banking':
        return InsuranceProductCategory.agencyBanking;
      case 'marine':
        return InsuranceProductCategory.marine;
      case 'package':
        return InsuranceProductCategory.package;
      case 'content':
        return InsuranceProductCategory.content;
      case 'personal_accident':
        return InsuranceProductCategory.personalAccident;
      default:
        return InsuranceProductCategory.other;
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
  /// MyCover.ai utility-list UUID powering this field's options when
  /// the values come from /v2/products/utility/{id}. Non-empty implies
  /// the Flutter form should fetch the picker from that endpoint
  /// instead of using [options].
  final String utilityId;
  /// Name of another field whose value scopes this field's utility
  /// query (e.g. vehicle_model depends on vehicle_make). Empty for
  /// independent selects.
  final String dependsOn;

  /// Per-item sub-fields for a structured (object-per-item) array field.
  /// e.g. benefit_details items are {benefit(select), sum_insured(monetary)};
  /// item_details items are {name, value, quantity, image_url, description}.
  /// Empty for non-array fields and for array fields where the widget
  /// should use its default cargo item shape.
  final List<InsuranceProductFormItemField> itemFields;

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
    this.utilityId = '',
    this.dependsOn = '',
    this.itemFields = const [],
  });

  @override
  List<Object?> get props => [name, label, type, required, options, defaultValue, utilityId, dependsOn, itemFields];
}

/// One sub-field of a structured-array item (see
/// [InsuranceProductFormField.itemFields]).
class InsuranceProductFormItemField extends Equatable {
  final String name;
  final String label;
  final String type; // "text" | "number" | "monetary" | "select" | "image"
  final bool required;
  final List<String> options;
  final String placeholder;

  const InsuranceProductFormItemField({
    required this.name,
    required this.label,
    required this.type,
    this.required = false,
    this.options = const [],
    this.placeholder = '',
  });

  @override
  List<Object?> get props => [name, label, type, required, options, placeholder];
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
    if (minPremium <= 0 && maxPremium <= 0) {
      return 'Get Quote';
    }
    final sym = _currencySymbolFor(currency);
    if (minPremium <= 0 && maxPremium > 0) {
      return 'From $sym${_formatAmount(maxPremium)}';
    }
    if (minPremium == maxPremium) {
      return '$sym${_formatAmount(minPremium)}';
    }
    return '$sym${_formatAmount(minPremium)} - $sym${_formatAmount(maxPremium)}';
  }

  // Lightweight currency-code → symbol mapping. Accepts BOTH the ISO
  // code ("NGN") and the full currency name MyCover sometimes returns
  // ("Nigerian Naira") because the backend normalises differently for
  // different product surfaces.
  static String _currencySymbolFor(String code) {
    final c = code.toLowerCase().trim();
    if (c == 'ngn' || c.contains('naira')) return '₦';
    if (c == 'usd' || c.contains('dollar')) return r'$';
    if (c == 'gbp' || c.contains('pound')) return '£';
    if (c == 'eur' || c.contains('euro')) return '€';
    if (c == 'ghs' || c.contains('cedi')) return '₵';
    if (c == 'kes' || c.contains('shilling')) return 'KSh';
    if (c == 'zar' || c.contains('rand')) return 'R';
    return '$code ';
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

/// Paginated wrapper for user policies (Slice 4).
///
/// Returned by getUserInsurancesPage on the repository. Uses the existing
/// GetUserInsurancesResponse.pagination on the wire (hasNext is the
/// authoritative "is there more" flag).
class UserInsurancesPage extends Equatable {
  final List<Insurance> insurances;
  final int totalItems;
  final int currentPage;
  final int totalPages;
  final bool hasMore;

  const UserInsurancesPage({
    required this.insurances,
    required this.totalItems,
    required this.currentPage,
    required this.totalPages,
    required this.hasMore,
  });

  @override
  List<Object?> get props =>
      [insurances, totalItems, currentPage, totalPages, hasMore];
}

/// Paginated wrapper for product listings (Slice 4).
///
/// Returned by getInsuranceProducts when callers opt into pagination. The
/// raw `List<InsuranceProduct>` shape is preserved on the existing
/// repository method for backwards compatibility — paginated callers use
/// getInsuranceProductsPage instead.
class InsuranceProductPage extends Equatable {
  final List<InsuranceProduct> products;
  final int total;
  final int page;
  final int limit;

  const InsuranceProductPage({
    required this.products,
    required this.total,
    required this.page,
    required this.limit,
  });

  bool get hasMore => page * limit < total;

  @override
  List<Object?> get props => [products, total, page, limit];
}

/// Purchase result from MyCover.ai
///
/// The first five fields come straight off the gRPC envelope. The remaining
/// optional fields are sourced from the nested `insurance` sub-message and
/// power the receipt screen (certificate download, premium echo, cover
/// period, sum insured).
class InsurancePurchaseResult extends Equatable {
  final String policyId;
  final String policyNumber;
  final String reference;
  final String status;
  final String providerReference;
  final String certificateUrl;
  final double? premium;
  final String currency;
  final double? coverageAmount;
  final DateTime? startDate;
  final DateTime? endDate;

  const InsurancePurchaseResult({
    required this.policyId,
    required this.policyNumber,
    required this.reference,
    required this.status,
    this.providerReference = '',
    this.certificateUrl = '',
    this.premium,
    this.currency = '',
    this.coverageAmount,
    this.startDate,
    this.endDate,
  });

  bool get isCompleted => status == 'completed' || status == 'active';
  bool get isPending => status == 'pending';
  bool get isFailed => status == 'failed';
  // Deferred completion: MyCover accepted the purchase but the policy
  // isn't confirmed yet (awaiting webhook / async). The receipt shows a
  // "confirming" state and resolves via the balance-WS, not a poll.
  bool get isProcessing =>
      status == 'processing' || status == 'pending' || status == 'awaiting_webhook';

  bool get hasCertificate => certificateUrl.isNotEmpty;

  @override
  List<Object?> get props => [policyId, reference, status];
}
