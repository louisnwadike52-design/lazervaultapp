import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

// States
abstract class PinManagementState extends Equatable {
  const PinManagementState();
  @override
  List<Object?> get props => [];
}

class PinManagementInitial extends PinManagementState {}

class PinManagementLoading extends PinManagementState {}

class PinManagementReady extends PinManagementState {
  final bool hasPin;
  final List<OTPChannelInfo> channels;
  final String recommendedChannel;

  const PinManagementReady({
    required this.hasPin,
    required this.channels,
    required this.recommendedChannel,
  });

  @override
  List<Object?> get props => [hasPin, channels, recommendedChannel];
}

class PinManagementOTPSent extends PinManagementState {
  final String channel;
  final String maskedDestination;
  final int expiresInSeconds;
  final int cooldownSeconds;
  final String operationType;

  const PinManagementOTPSent({
    required this.channel,
    required this.maskedDestination,
    required this.expiresInSeconds,
    required this.cooldownSeconds,
    required this.operationType,
  });

  @override
  List<Object?> get props => [channel, maskedDestination, expiresInSeconds, cooldownSeconds, operationType];
}

class PinManagementSuccess extends PinManagementState {
  final String message;
  final String operationType;

  const PinManagementSuccess({
    required this.message,
    required this.operationType,
  });

  @override
  List<Object?> get props => [message, operationType];
}

class PinManagementError extends PinManagementState {
  final String message;
  final int? remainingAttempts;

  const PinManagementError({
    required this.message,
    this.remainingAttempts,
  });

  @override
  List<Object?> get props => [message, remainingAttempts];
}

// Cubit
class PinManagementCubit extends Cubit<PinManagementState> {
  final ITransactionPinService _pinService;

  PinManagementCubit(this._pinService) : super(PinManagementInitial());

  Future<void> initialize() async {
    emit(PinManagementLoading());
    try {
      final hasPin = await _pinService.checkUserHasPin();
      final channels = await _pinService.getPinOTPChannels();
      String recommended = '';
      for (final ch in channels) {
        if (ch.isVerified && ch.isAvailable) {
          recommended = ch.type;
          break;
        }
      }
      emit(PinManagementReady(
        hasPin: hasPin,
        channels: channels,
        recommendedChannel: recommended,
      ));
    } catch (e) {
      emit(PinManagementError(message: e.toString()));
    }
  }

  Future<void> sendOTP({
    required String operationType,
    required String channel,
  }) async {
    emit(PinManagementLoading());
    try {
      final result = await _pinService.initiatePinOTP(
        operationType: operationType,
        channel: channel,
      );
      if (result.success) {
        emit(PinManagementOTPSent(
          channel: result.channel,
          maskedDestination: result.maskedDestination,
          expiresInSeconds: result.expiresInSeconds,
          cooldownSeconds: result.cooldownSeconds,
          operationType: operationType,
        ));
      } else {
        emit(PinManagementError(message: result.message));
      }
    } catch (e) {
      emit(PinManagementError(message: e.toString()));
    }
  }

  Future<void> verifyOTPAndExecute({
    required String otpCode,
    required String operationType,
    String? currentPin,
    required String newPin,
    required String confirmNewPin,
  }) async {
    emit(PinManagementLoading());
    try {
      final result = await _pinService.verifyPinOTP(
        otpCode: otpCode,
        operationType: operationType,
        currentPin: currentPin,
        newPin: newPin,
        confirmNewPin: confirmNewPin,
      );
      if (result.success) {
        emit(PinManagementSuccess(
          message: result.message,
          operationType: operationType,
        ));
      } else {
        emit(PinManagementError(
          message: result.message,
          remainingAttempts: result.remainingAttempts,
        ));
      }
    } catch (e) {
      emit(PinManagementError(message: e.toString()));
    }
  }

  Future<void> completeForgotPin({
    required String otpCode,
    required String newPin,
    required String confirmNewPin,
  }) async {
    emit(PinManagementLoading());
    try {
      final result = await _pinService.completeForgotPin(
        otpCode: otpCode,
        newPin: newPin,
        confirmNewPin: confirmNewPin,
      );
      if (result.success) {
        emit(PinManagementSuccess(
          message: result.message,
          operationType: 'reset',
        ));
      } else {
        emit(PinManagementError(
          message: result.message,
          remainingAttempts: result.remainingAttempts,
        ));
      }
    } catch (e) {
      emit(PinManagementError(message: e.toString()));
    }
  }
}
