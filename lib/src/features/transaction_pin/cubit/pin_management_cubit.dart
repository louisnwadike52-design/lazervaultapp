import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
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

  /// Converts any raw error (gRPC transport noise, "expected 200, got 502",
  /// status codes) into a clean, user-facing message. Never leak status codes.
  String _friendly(Object? e) {
    if (e is TimeoutException) {
      return 'The request timed out. Check your connection and try again.';
    }
    return sanitizeUserFacingError(e.toString());
  }

  /// Bound for every reset-flow RPC. Without a deadline a stalled call would
  /// leave the screen on [PinManagementLoading] forever — and because the reset
  /// screen blocks back-navigation while loading (PopScope), that would trap the
  /// user with no way out. On timeout the catch emits [PinManagementError],
  /// which clears the loading state and re-enables back.
  static const Duration _rpcTimeout = Duration(seconds: 20);

  Future<void> initialize() async {
    emit(PinManagementLoading());
    try {
      final hasPin = await _pinService.checkUserHasPin().timeout(_rpcTimeout);
      final channels =
          await _pinService.getPinOTPChannels().timeout(_rpcTimeout);
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
      emit(PinManagementError(message: _friendly(e)));
    }
  }

  Future<void> sendOTP({
    required String operationType,
    required String channel,
  }) async {
    emit(PinManagementLoading());
    try {
      final result = await _pinService
          .initiatePinOTP(
            operationType: operationType,
            channel: channel,
          )
          .timeout(_rpcTimeout);
      if (result.success) {
        emit(PinManagementOTPSent(
          channel: result.channel,
          maskedDestination: result.maskedDestination,
          expiresInSeconds: result.expiresInSeconds,
          cooldownSeconds: result.cooldownSeconds,
          operationType: operationType,
        ));
      } else {
        emit(PinManagementError(message: _friendly(result.message)));
      }
    } catch (e) {
      emit(PinManagementError(message: _friendly(e)));
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
      final result = await _pinService
          .verifyPinOTP(
            otpCode: otpCode,
            operationType: operationType,
            currentPin: currentPin,
            newPin: newPin,
            confirmNewPin: confirmNewPin,
          )
          .timeout(_rpcTimeout);
      if (result.success) {
        emit(PinManagementSuccess(
          message: result.message,
          operationType: operationType,
        ));
      } else {
        emit(PinManagementError(
          message: _friendly(result.message),
          remainingAttempts: result.remainingAttempts,
        ));
      }
    } catch (e) {
      emit(PinManagementError(message: _friendly(e)));
    }
  }

  Future<void> completeForgotPin({
    required String otpCode,
    required String newPin,
    required String confirmNewPin,
  }) async {
    emit(PinManagementLoading());
    try {
      final result = await _pinService
          .completeForgotPin(
            otpCode: otpCode,
            newPin: newPin,
            confirmNewPin: confirmNewPin,
          )
          .timeout(_rpcTimeout);
      if (result.success) {
        emit(PinManagementSuccess(
          message: result.message,
          operationType: 'reset',
        ));
      } else {
        emit(PinManagementError(
          message: _friendly(result.message),
          remainingAttempts: result.remainingAttempts,
        ));
      }
    } catch (e) {
      emit(PinManagementError(message: _friendly(e)));
    }
  }
}
