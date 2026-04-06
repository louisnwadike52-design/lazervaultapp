import 'package:equatable/equatable.dart';
import '../../domain/entities/airtime_to_cash_conversion.dart';
import '../../domain/entities/network_rate.dart';
import '../../domain/repositories/airtime_to_cash_repository.dart';

abstract class AirtimeToCashState extends Equatable {
  const AirtimeToCashState();

  @override
  List<Object?> get props => [];
}

class AirtimeToCashInitial extends AirtimeToCashState {}

// Rates states
class AirtimeToCashRatesLoading extends AirtimeToCashState {}

class AirtimeToCashRatesLoaded extends AirtimeToCashState {
  final List<NetworkRate> rates;

  const AirtimeToCashRatesLoaded({required this.rates});

  @override
  List<Object?> get props => [rates];
}

class AirtimeToCashRatesError extends AirtimeToCashState {
  final String message;

  const AirtimeToCashRatesError({required this.message});

  @override
  List<Object?> get props => [message];
}

// OTP request states
class AirtimeToCashOTPRequesting extends AirtimeToCashState {}

class AirtimeToCashOTPSent extends AirtimeToCashState {
  final String sessionId;
  final bool otpRequired;
  final String message;
  final String destinationPhone; // VTU Africa: phone to transfer to
  final String providerName; // "airtimetocash" or "vtuafrica"

  const AirtimeToCashOTPSent({
    required this.sessionId,
    required this.otpRequired,
    required this.message,
    this.destinationPhone = '',
    this.providerName = '',
  });

  @override
  List<Object?> get props => [sessionId, otpRequired, message, destinationPhone, providerName];
}

// OTP verification states
class AirtimeToCashOTPVerifying extends AirtimeToCashState {}

class AirtimeToCashOTPVerified extends AirtimeToCashState {
  final String sessionToken;
  final String sessionId; // Added for Automation API

  const AirtimeToCashOTPVerified({
    required this.sessionToken,
    required this.sessionId,
  });

  @override
  List<Object?> get props => [sessionToken, sessionId];
}

// Quota check states
class AirtimeToCashCheckingQuota extends AirtimeToCashState {}

class AirtimeToCashQuotaChecked extends AirtimeToCashState {
  final bool available;
  final double maxAmount;
  final String message;

  const AirtimeToCashQuotaChecked({
    required this.available,
    required this.maxAmount,
    required this.message,
  });

  @override
  List<Object?> get props => [available, maxAmount, message];
}

// Service verification states
class AirtimeToCashVerifying extends AirtimeToCashState {}

class AirtimeToCashServiceVerified extends AirtimeToCashState {
  final String providerName;
  final String destinationPhone;
  final String network;
  final bool requiresTransfer;
  final String message;

  const AirtimeToCashServiceVerified({
    required this.providerName,
    required this.destinationPhone,
    required this.network,
    required this.requiresTransfer,
    required this.message,
  });

  @override
  List<Object?> get props => [providerName, destinationPhone, network, requiresTransfer, message];
}

// Provider info states
class AirtimeToCashProviderInfoLoaded extends AirtimeToCashState {
  final String providerName;
  final bool requiresOTP;
  final bool requiresTransfer;
  final String displayName;
  final List<ProviderStatusInfo> providers;

  const AirtimeToCashProviderInfoLoaded({
    required this.providerName,
    required this.requiresOTP,
    required this.requiresTransfer,
    required this.displayName,
    required this.providers,
  });

  @override
  List<Object?> get props => [providerName, requiresOTP, requiresTransfer, displayName, providers];
}

// Review state
class AirtimeToCashReviewReady extends AirtimeToCashState {
  final String phoneNumber;
  final String network;
  final double amount;
  final NetworkRate rate;
  final double estimatedCash;

  const AirtimeToCashReviewReady({
    required this.phoneNumber,
    required this.network,
    required this.amount,
    required this.rate,
    required this.estimatedCash,
  });

  @override
  List<Object?> get props => [phoneNumber, network, amount, rate, estimatedCash];
}

// Processing states
class AirtimeToCashProcessing extends AirtimeToCashState {
  final double progress;
  final String currentStep;

  const AirtimeToCashProcessing({
    this.progress = 0.1,
    this.currentStep = 'Initializing conversion...',
  });

  AirtimeToCashProcessing copyWith({
    double? progress,
    String? currentStep,
  }) {
    return AirtimeToCashProcessing(
      progress: progress ?? this.progress,
      currentStep: currentStep ?? this.currentStep,
    );
  }

  @override
  List<Object?> get props => [progress, currentStep];
}

class AirtimeToCashSuccess extends AirtimeToCashState {
  final AirtimeToCashConversion conversion;
  final double newBalance;

  const AirtimeToCashSuccess({
    required this.conversion,
    required this.newBalance,
  });

  @override
  List<Object?> get props => [conversion, newBalance];
}

class AirtimeToCashFailed extends AirtimeToCashState {
  final String message;

  const AirtimeToCashFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

// History states
class AirtimeToCashHistoryLoading extends AirtimeToCashState {}

class AirtimeToCashHistoryLoaded extends AirtimeToCashState {
  final List<AirtimeToCashConversion> conversions;
  final int totalCount;

  const AirtimeToCashHistoryLoaded({
    required this.conversions,
    required this.totalCount,
  });

  @override
  List<Object?> get props => [conversions, totalCount];
}

// Processing pending state (conversion submitted but wallet credit pending via webhook)
class AirtimeToCashProcessingPending extends AirtimeToCashState {
  final AirtimeToCashConversion conversion;
  final String message;

  const AirtimeToCashProcessingPending({
    required this.conversion,
    required this.message,
  });

  @override
  List<Object?> get props => [conversion, message];
}

// Generic error state
class AirtimeToCashError extends AirtimeToCashState {
  final String message;

  const AirtimeToCashError({required this.message});

  @override
  List<Object?> get props => [message];
}
