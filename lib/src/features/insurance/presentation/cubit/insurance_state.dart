import 'package:equatable/equatable.dart';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_payment_entity.dart';
import '../../domain/entities/insurance_claim_entity.dart';

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

class InsuranceError extends InsuranceState {
  final String message;

  const InsuranceError(this.message);

  @override
  List<Object?> get props => [message];
} 