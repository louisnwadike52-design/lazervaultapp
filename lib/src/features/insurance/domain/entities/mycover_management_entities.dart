import 'package:equatable/equatable.dart';

/// MyCover Customer entity
class MyCoverCustomer extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String gender;
  final String dateOfBirth;
  final String createdAt;
  final String updatedAt;

  const MyCoverCustomer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.gender = '',
    this.dateOfBirth = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  String get fullName => '$firstName $lastName'.trim();

  @override
  List<Object?> get props => [id, firstName, lastName, email, phoneNumber, gender, dateOfBirth, createdAt, updatedAt];
}

/// MyCover Purchase entity
class MyCoverPurchase extends Equatable {
  final String id;
  final String appMode;
  final bool isRenewal;
  final String amount;
  final String customerId;
  final String distributorId;
  final String paymentChannel;
  final String paymentOption;
  final String policyId;
  final String productCategoryId;
  final String productId;
  final String providerId;
  final String countryId;
  final String currencyId;
  final String createdAt;
  final String updatedAt;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String policyNumber;
  final String certificateUrl;
  final bool policyIsActive;
  final String policyAmount;
  final String providerName;
  final String productName;
  final String productCategoryName;

  const MyCoverPurchase({
    required this.id,
    this.appMode = '',
    this.isRenewal = false,
    this.amount = '0',
    this.customerId = '',
    this.distributorId = '',
    this.paymentChannel = '',
    this.paymentOption = '',
    this.policyId = '',
    this.productCategoryId = '',
    this.productId = '',
    this.providerId = '',
    this.countryId = '',
    this.currencyId = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.customerName = '',
    this.customerEmail = '',
    this.customerPhone = '',
    this.policyNumber = '',
    this.certificateUrl = '',
    this.policyIsActive = false,
    this.policyAmount = '0',
    this.providerName = '',
    this.productName = '',
    this.productCategoryName = '',
  });

  @override
  List<Object?> get props => [id, policyIsActive, policyNumber, amount, productName, providerName, updatedAt];
}

/// MyCover Policy Detail entity
class MyCoverPolicyDetail extends Equatable {
  final String id;
  final String appMode;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String dateOfBirth;
  final String activationDate;
  final String startDate;
  final String expirationDate;
  final String amount;
  final bool isActive;
  final bool isSubmittedToProvider;
  final String customerId;
  final String productId;
  final String productCategoryId;
  final String providerId;
  final String purchaseId;
  final String policyNumber;
  final String certificateUrl;
  final String createdAt;
  final String updatedAt;
  final String providerName;
  final String productName;

  const MyCoverPolicyDetail({
    required this.id,
    this.appMode = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phoneNumber = '',
    this.dateOfBirth = '',
    this.activationDate = '',
    this.startDate = '',
    this.expirationDate = '',
    this.amount = '0',
    this.isActive = false,
    this.isSubmittedToProvider = false,
    this.customerId = '',
    this.productId = '',
    this.productCategoryId = '',
    this.providerId = '',
    this.purchaseId = '',
    this.policyNumber = '',
    this.certificateUrl = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.providerName = '',
    this.productName = '',
  });

  String get holderName => '$firstName $lastName'.trim();

  @override
  List<Object?> get props => [id, isActive, policyNumber, amount, productName, updatedAt];
}

/// MyCover Notification Preference entity
class MyCoverNotificationPref extends Equatable {
  final String key;
  final String category;
  final String label;
  final String description;
  final bool enabled;

  const MyCoverNotificationPref({
    required this.key,
    required this.category,
    required this.label,
    this.description = '',
    this.enabled = true,
  });

  MyCoverNotificationPref copyWith({bool? enabled}) {
    return MyCoverNotificationPref(
      key: key,
      category: category,
      label: label,
      description: description,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  List<Object?> get props => [key, category, label, description, enabled];
}

/// MyCover Claim entity (from provider API)
class MyCoverProviderClaim extends Equatable {
  final String id;
  final String status;
  final String type;
  final double amount;
  final String description;
  final String policyId;
  final String customerId;
  final String claimNumber;
  final List<String> documents;
  final String rejectionReason;
  final double approvedAmount;
  final String createdAt;
  final String updatedAt;

  const MyCoverProviderClaim({
    required this.id,
    this.status = '',
    this.type = '',
    this.amount = 0,
    this.description = '',
    this.policyId = '',
    this.customerId = '',
    this.claimNumber = '',
    this.documents = const [],
    this.rejectionReason = '',
    this.approvedAmount = 0,
    this.createdAt = '',
    this.updatedAt = '',
  });

  @override
  List<Object?> get props => [id, status, amount, approvedAmount, claimNumber, updatedAt];
}

/// MyCover Wallet Balance
class MyCoverWalletBalance extends Equatable {
  final double balance;
  final String currency;

  const MyCoverWalletBalance({
    required this.balance,
    this.currency = 'NGN',
  });

  @override
  List<Object?> get props => [balance, currency];
}

/// MyCover Insurance Refund Info
class InsuranceRefund extends Equatable {
  final String refundId;
  final String policyReference;
  final String status;
  final double amount;
  final String currency;
  final bool providerRefunded;
  final bool walletCredited;
  final String reason;
  final String failureReason;
  final String initiatedAt;
  final String completedAt;

  const InsuranceRefund({
    this.refundId = '',
    this.policyReference = '',
    this.status = '',
    this.amount = 0,
    this.currency = 'NGN',
    this.providerRefunded = false,
    this.walletCredited = false,
    this.reason = '',
    this.failureReason = '',
    this.initiatedAt = '',
    this.completedAt = '',
  });

  @override
  List<Object?> get props => [refundId, policyReference, status, amount, providerRefunded, walletCredited];
}
