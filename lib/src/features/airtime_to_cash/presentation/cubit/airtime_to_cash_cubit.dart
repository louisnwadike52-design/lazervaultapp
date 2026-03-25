import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import '../../../../../core/services/account_manager.dart';
import '../../../../../core/services/secure_storage_service.dart';
import '../../domain/entities/network_rate.dart';
import '../../domain/repositories/airtime_to_cash_repository.dart';
import 'airtime_to_cash_state.dart';

class AirtimeToCashCubit extends Cubit<AirtimeToCashState> {
  final AirtimeToCashRepository repository;
  // ignore: unused_field
  final SecureStorageService _secureStorage;
  final AccountManager? _accountManager;

  AirtimeToCashCubit({
    required this.repository,
    required SecureStorageService secureStorage,
    AccountManager? accountManager,
  })  : _secureStorage = secureStorage,
        _accountManager = accountManager,
        super(AirtimeToCashInitial());

  /// Safe emit that checks isClosed before emitting to prevent
  /// errors when the cubit is disposed during async operations.
  void _safeEmit(AirtimeToCashState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  /// Fetch conversion rates for all supported networks.
  Future<void> loadRates() async {
    try {
      _safeEmit(AirtimeToCashRatesLoading());

      final rates = await repository.getRates();

      _safeEmit(AirtimeToCashRatesLoaded(rates: rates));
    } catch (e) {
      _safeEmit(AirtimeToCashRatesError(message: _friendlyErrorMessage(e)));
    }
  }

  /// Request OTP to verify phone ownership before conversion.
  Future<void> requestOTP(String phoneNumber, String network) async {
    try {
      _safeEmit(AirtimeToCashOTPRequesting());

      final result = await repository.requestOTP(
        phoneNumber: phoneNumber,
        network: network,
      );

      if (result.success) {
        _safeEmit(AirtimeToCashOTPSent(
          sessionId: result.sessionId,
          otpRequired: result.otpRequired,
          message: result.message,
        ));
      } else {
        _safeEmit(AirtimeToCashError(message: result.message));
      }
    } catch (e) {
      _safeEmit(AirtimeToCashError(message: _friendlyErrorMessage(e)));
    }
  }

  /// Verify the OTP code and obtain a session token for conversion.
  Future<void> verifyOTP(
    String otp,
    String sessionId,
    String phoneNumber,
    String network,
  ) async {
    try {
      _safeEmit(AirtimeToCashOTPVerifying());

      final result = await repository.verifyOTP(
        phoneNumber: phoneNumber,
        network: network,
        otp: otp,
        sessionId: sessionId,
      );

      if (result.verified) {
        _safeEmit(AirtimeToCashOTPVerified(sessionToken: result.sessionToken));
      } else {
        _safeEmit(AirtimeToCashError(message: result.message));
      }
    } catch (e) {
      _safeEmit(AirtimeToCashError(message: _friendlyErrorMessage(e)));
    }
  }

  /// Calculate estimated cash and emit ReviewReady for user confirmation.
  Future<void> prepareReview({
    required String phoneNumber,
    required String network,
    required double amount,
    required NetworkRate rate,
  }) async {
    try {
      final estimatedCash = rate.estimateCash(amount);

      // Guard against invalid calculation results
      if (estimatedCash.isNaN || estimatedCash.isInfinite || estimatedCash < 0) {
        _safeEmit(const AirtimeToCashError(message: 'Unable to calculate conversion amount. Please try again.'));
        return;
      }

      // Emit loading first to break Equatable deduplication when same params are re-submitted
      _safeEmit(AirtimeToCashInitial());
      _safeEmit(AirtimeToCashReviewReady(
        phoneNumber: phoneNumber,
        network: network,
        amount: amount,
        rate: rate,
        estimatedCash: estimatedCash,
      ));
    } catch (e) {
      _safeEmit(AirtimeToCashError(message: _friendlyErrorMessage(e)));
    }
  }

  /// Execute the airtime-to-cash conversion with progress steps.
  Future<void> processConversion({
    required String phoneNumber,
    required String network,
    required double amount,
    required String sessionToken,
    required String transactionId,
    required String verificationToken,
    String? sourceAccountId,
  }) async {
    try {
      _safeEmit(const AirtimeToCashProcessing(
        progress: 0.2,
        currentStep: 'Validating conversion...',
      ));

      await Future.delayed(const Duration(milliseconds: 500));
      _safeEmit(const AirtimeToCashProcessing(
        progress: 0.4,
        currentStep: 'Initiating airtime transfer...',
      ));

      // Set the selected account as active so gRPC metadata includes x-account-id
      if (sourceAccountId != null && _accountManager != null) {
        _accountManager!.setActiveAccount(sourceAccountId);
      }

      await Future.delayed(const Duration(milliseconds: 400));
      _safeEmit(const AirtimeToCashProcessing(
        progress: 0.6,
        currentStep: 'Transferring airtime...',
      ));

      final conversion = await repository.convert(
        phoneNumber: phoneNumber,
        network: network,
        amount: amount,
        sessionToken: sessionToken,
        transactionId: transactionId,
        verificationToken: verificationToken,
        idempotencyKey: transactionId,
      );

      _safeEmit(const AirtimeToCashProcessing(
        progress: 0.8,
        currentStep: 'Crediting your wallet...',
      ));

      await Future.delayed(const Duration(milliseconds: 300));

      if (conversion.isFailed) {
        _safeEmit(AirtimeToCashFailed(
          message: conversion.failureReason ?? 'Conversion failed',
        ));
      } else if (conversion.isPending) {
        // Server returned "processing" status — conversion went through but
        // wallet credit is pending (webhook will complete it).
        _safeEmit(AirtimeToCashProcessingPending(
          conversion: conversion,
          message:
              'Your conversion is being processed. You\'ll be notified when cash is credited to your wallet.',
        ));
      } else {
        _safeEmit(AirtimeToCashSuccess(
          conversion: conversion,
          newBalance: conversion.cashAmount,
        ));
      }
    } catch (e) {
      // Financial operations are NEVER queued offline - security tokens expire, balances change
      if (_isNetworkError(e)) {
        _safeEmit(const AirtimeToCashFailed(
          message:
              'No internet connection. Please check your network and try again.',
        ));
      } else if (e is TimeoutException) {
        _safeEmit(const AirtimeToCashFailed(
          message:
              'The request timed out. Please check your conversion history for the status.',
        ));
      } else {
        _safeEmit(AirtimeToCashFailed(message: _friendlyErrorMessage(e)));
      }
    }
  }

  /// Load conversion history.
  Future<void> loadHistory() async {
    try {
      _safeEmit(AirtimeToCashHistoryLoading());

      final conversions = await repository.getHistory();

      _safeEmit(AirtimeToCashHistoryLoaded(
        conversions: conversions,
        totalCount: conversions.length,
      ));
    } catch (e) {
      _safeEmit(AirtimeToCashError(message: _friendlyErrorMessage(e)));
    }
  }

  /// Reset to initial state.
  void reset() {
    _safeEmit(AirtimeToCashInitial());
  }

  // Network error detection (matches pattern used in airtime_cubit, tag_pay_cubit)
  bool _isNetworkError(dynamic error) {
    if (error is GrpcError) {
      return error.code == StatusCode.unavailable ||
          error.code == StatusCode.deadlineExceeded ||
          error.code == StatusCode.unknown;
    }
    if (error is TimeoutException) return true;
    final errorStr = error.toString().toLowerCase();
    return errorStr.contains('network') ||
        errorStr.contains('connection') ||
        errorStr.contains('timeout') ||
        errorStr.contains('unavailable') ||
        errorStr.contains('failed to connect') ||
        errorStr.contains('socket') ||
        errorStr.contains('unreachable');
  }

  // Convert technical errors to user-friendly messages with comprehensive gRPC mapping
  String _friendlyErrorMessage(dynamic error) {
    if (_isNetworkError(error)) {
      return 'No internet connection. Please check your network and try again.';
    }
    if (error is TimeoutException) {
      return 'The request timed out. Please check your conversion history for the status.';
    }
    if (error is GrpcError) {
      switch (error.code) {
        case StatusCode.permissionDenied:
          return 'Transaction not authorized. Please verify your PIN and try again.';
        case StatusCode.unauthenticated:
          return 'Your session has expired. Please log in again.';
        case StatusCode.invalidArgument:
          return 'Invalid conversion details. Please check and try again.';
        case StatusCode.resourceExhausted:
          return 'Too many requests. Please wait a moment and try again.';
        case StatusCode.notFound:
          return 'Service not available. Please try again later.';
        case StatusCode.deadlineExceeded:
          return 'The request timed out. Please try again.';
        case StatusCode.failedPrecondition:
          return error.message ?? 'This operation cannot be completed right now. Please check your account status.';
        case StatusCode.alreadyExists:
          return 'This conversion has already been submitted. Please check your conversion history.';
        case StatusCode.aborted:
          return 'The operation was interrupted. Please try again.';
        case StatusCode.internal:
          return 'Something went wrong on our end. Please try again later.';
        case StatusCode.unimplemented:
          return 'This feature is not yet available. Please try again later.';
        case StatusCode.dataLoss:
          return 'A data error occurred. Please contact support if this persists.';
        default:
          return error.message ?? 'Something went wrong. Please try again.';
      }
    }
    final msg = error.toString();
    if (msg.contains('Exception:')) {
      return msg.replaceFirst(RegExp(r'^Exception:\s*'), '');
    }
    return msg;
  }
}
