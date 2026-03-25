import 'package:equatable/equatable.dart';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_payment_entity.dart';
import '../../domain/entities/insurance_claim_entity.dart';
import '../../domain/entities/mycover_management_entities.dart';

abstract class InsuranceState extends Equatable {
  const InsuranceState();

  @override
  List<Object?> get props => [];
}

class InsuranceInitial extends InsuranceState {}

class InsuranceLoading extends InsuranceState {}

class InsurancesLoaded extends InsuranceState {
  final List<Insurance> insurances;
  final List<InsurancePayment> recentPayments;
  final List<InsurancePayment> overduePayments;
  final Map<String, dynamic> statistics;

  const InsurancesLoaded({
    required this.insurances,
    required this.recentPayments,
    required this.overduePayments,
    required this.statistics,
  });

  @override
  List<Object?> get props => [insurances, recentPayments, overduePayments, statistics];
}

class InsuranceDetailsLoaded extends InsuranceState {
  final Insurance insurance;
  final List<InsurancePayment> payments;
  final List<InsuranceClaim> claims;

  const InsuranceDetailsLoaded({
    required this.insurance,
    required this.payments,
    required this.claims,
  });

  @override
  List<Object?> get props => [insurance, payments, claims];
}

class InsuranceCreated extends InsuranceState {
  final Insurance insurance;

  const InsuranceCreated(this.insurance);

  @override
  List<Object?> get props => [insurance];
}

class InsuranceUpdated extends InsuranceState {
  final Insurance insurance;

  const InsuranceUpdated(this.insurance);

  @override
  List<Object?> get props => [insurance];
}

class InsuranceDeleted extends InsuranceState {
  final String insuranceId;

  const InsuranceDeleted(this.insuranceId);

  @override
  List<Object?> get props => [insuranceId];
}

class PaymentProcessing extends InsuranceState {
  final InsurancePayment payment;
  final String step;
  final double progress;

  const PaymentProcessing({
    required this.payment,
    required this.step,
    required this.progress,
  });

  @override
  List<Object?> get props => [payment, step, progress];
}

class PaymentCompleted extends InsuranceState {
  final InsurancePayment payment;
  final String receiptUrl;

  const PaymentCompleted({
    required this.payment,
    required this.receiptUrl,
  });

  @override
  List<Object?> get props => [payment, receiptUrl];
}

class PaymentFailed extends InsuranceState {
  final InsurancePayment payment;
  final String error;

  const PaymentFailed({
    required this.payment,
    required this.error,
  });

  @override
  List<Object?> get props => [payment, error];
}

class ClaimSubmitted extends InsuranceState {
  final InsuranceClaim claim;

  const ClaimSubmitted(this.claim);

  @override
  List<Object?> get props => [claim];
}

class ClaimsLoaded extends InsuranceState {
  final List<InsuranceClaim> claims;

  const ClaimsLoaded(this.claims);

  @override
  List<Object?> get props => [claims];
}

class InsuranceSearchResults extends InsuranceState {
  final List<Insurance> results;
  final String query;

  const InsuranceSearchResults({
    required this.results,
    required this.query,
  });

  @override
  List<Object?> get props => [results, query];
}

class ClaimUpdated extends InsuranceState {
  final InsuranceClaim claim;

  const ClaimUpdated(this.claim);

  @override
  List<Object?> get props => [claim];
}

class InsuranceError extends InsuranceState {
  final String message;

  const InsuranceError(this.message);

  @override
  List<Object?> get props => [message];
}

// ===== MyCover Management States =====

class MyCoverCustomersLoaded extends InsuranceState {
  final List<MyCoverCustomer> customers;
  final int total;
  final int currentPage;
  final bool hasMore;

  const MyCoverCustomersLoaded({
    required this.customers,
    required this.total,
    this.currentPage = 1,
    this.hasMore = false,
  });

  @override
  List<Object?> get props => [customers, total, currentPage, hasMore];
}

class MyCoverCustomerDetailLoaded extends InsuranceState {
  final MyCoverCustomer customer;
  final List<MyCoverPolicyDetail> policies;
  final List<MyCoverPurchase> purchases;

  const MyCoverCustomerDetailLoaded({
    required this.customer,
    required this.policies,
    required this.purchases,
  });

  @override
  List<Object?> get props => [customer, policies, purchases];
}

class MyCoverPurchasesLoaded extends InsuranceState {
  final List<MyCoverPurchase> purchases;
  final int total;
  final int currentPage;
  final bool hasMore;

  const MyCoverPurchasesLoaded({
    required this.purchases,
    required this.total,
    this.currentPage = 1,
    this.hasMore = false,
  });

  @override
  List<Object?> get props => [purchases, total, currentPage, hasMore];
}

class MyCoverPurchaseDetailLoaded extends InsuranceState {
  final MyCoverPurchase purchase;

  const MyCoverPurchaseDetailLoaded(this.purchase);

  @override
  List<Object?> get props => [purchase];
}

class MyCoverProviderClaimsLoaded extends InsuranceState {
  final List<MyCoverProviderClaim> claims;
  final int total;
  final int currentPage;
  final bool hasMore;

  const MyCoverProviderClaimsLoaded({
    required this.claims,
    required this.total,
    this.currentPage = 1,
    this.hasMore = false,
  });

  @override
  List<Object?> get props => [claims, total, currentPage, hasMore];
}

class MyCoverProviderClaimDetailLoaded extends InsuranceState {
  final MyCoverProviderClaim claim;

  const MyCoverProviderClaimDetailLoaded(this.claim);

  @override
  List<Object?> get props => [claim];
}

class CreditLifeClaimFiled extends InsuranceState {
  final String claimId;
  final String claimNumber;
  final String status;

  const CreditLifeClaimFiled({
    required this.claimId,
    required this.claimNumber,
    required this.status,
  });

  @override
  List<Object?> get props => [claimId, claimNumber, status];
}

class MyCoverNotificationPrefsLoaded extends InsuranceState {
  final List<MyCoverNotificationPref> preferences;

  const MyCoverNotificationPrefsLoaded(this.preferences);

  @override
  List<Object?> get props => [preferences];
}

class MyCoverNotificationPrefsUpdated extends InsuranceState {}

class MyCoverWalletBalanceLoaded extends InsuranceState {
  final MyCoverWalletBalance walletBalance;

  const MyCoverWalletBalanceLoaded(this.walletBalance);

  @override
  List<Object?> get props => [walletBalance];
}

class InsuranceRefundRequested extends InsuranceState {
  final InsuranceRefund refund;

  const InsuranceRefundRequested(this.refund);

  @override
  List<Object?> get props => [refund];
}

class InsuranceRefundStatusLoaded extends InsuranceState {
  final InsuranceRefund refund;

  const InsuranceRefundStatusLoaded(this.refund);

  @override
  List<Object?> get props => [refund];
}

