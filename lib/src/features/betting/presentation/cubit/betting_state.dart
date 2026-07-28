import 'package:equatable/equatable.dart';
import '../../domain/entities/betting_entities.dart';

export '../../domain/entities/betting_entities.dart';

abstract class BettingState extends Equatable {
  const BettingState();

  @override
  List<Object?> get props => [];
}

class BettingInitial extends BettingState {
  const BettingInitial();
}

// ── Platforms ────────────────────────────────────────────────────────
class BettingPlatformsLoading extends BettingState {
  const BettingPlatformsLoading();
}

class BettingPlatformsLoaded extends BettingState {
  final List<BettingPlatform> platforms;
  const BettingPlatformsLoaded({required this.platforms});

  @override
  List<Object?> get props => [platforms];
}

class BettingPlatformsError extends BettingState {
  final String message;
  const BettingPlatformsError({required this.message});

  @override
  List<Object?> get props => [message];
}

// ── Account verification ─────────────────────────────────────────────
class BettingAccountVerifying extends BettingState {
  const BettingAccountVerifying();
}

class BettingAccountVerified extends BettingState {
  final BettingAccountVerification verification;
  const BettingAccountVerified({required this.verification});

  @override
  List<Object?> get props => [verification];
}

class BettingAccountVerifyError extends BettingState {
  final String message;
  const BettingAccountVerifyError({required this.message});

  @override
  List<Object?> get props => [message];
}

// ── Funding ──────────────────────────────────────────────────────────
class BettingFundingProcessing extends BettingState {
  final double progress;
  final String currentStep;
  const BettingFundingProcessing({
    this.progress = 0.1,
    this.currentStep = 'Payment Initiated',
  });

  @override
  List<Object?> get props => [progress, currentStep];
}

class BettingFundingSuccess extends BettingState {
  final BettingFundingResult result;
  const BettingFundingSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

class BettingFundingFailed extends BettingState {
  final String message;
  const BettingFundingFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

// ── History ──────────────────────────────────────────────────────────
class BettingHistoryLoading extends BettingState {
  const BettingHistoryLoading();
}

class BettingHistoryLoaded extends BettingState {
  final List<BettingFundingRecord> records;
  const BettingHistoryLoaded({required this.records});

  @override
  List<Object?> get props => [records];
}

class BettingHistoryError extends BettingState {
  final String message;
  const BettingHistoryError({required this.message});

  @override
  List<Object?> get props => [message];
}

// ── Beneficiaries ────────────────────────────────────────────────────
class BettingBeneficiariesLoading extends BettingState {
  const BettingBeneficiariesLoading();
}

class BettingBeneficiariesLoaded extends BettingState {
  final List<BettingBeneficiary> beneficiaries;
  const BettingBeneficiariesLoaded({required this.beneficiaries});

  @override
  List<Object?> get props => [beneficiaries];
}

class BettingBeneficiariesError extends BettingState {
  final String message;
  const BettingBeneficiariesError({required this.message});

  @override
  List<Object?> get props => [message];
}
