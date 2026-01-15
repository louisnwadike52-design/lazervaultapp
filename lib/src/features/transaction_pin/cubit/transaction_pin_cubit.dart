import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

/// Transaction PIN state
class TransactionPinState {
  final bool hasPin;
  final bool isLoading;
  final String? errorMessage;
  final int? remainingAttempts;
  final bool isLocked;
  final DateTime? lockedUntil;

  const TransactionPinState({
    this.hasPin = false,
    this.isLoading = false,
    this.errorMessage,
    this.remainingAttempts,
    this.isLocked = false,
    this.lockedUntil,
  });

  TransactionPinState copyWith({
    bool? hasPin,
    bool? isLoading,
    String? errorMessage,
    int? remainingAttempts,
    bool? isLocked,
    DateTime? lockedUntil,
  }) {
    return TransactionPinState(
      hasPin: hasPin ?? this.hasPin,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      remainingAttempts: remainingAttempts ?? this.remainingAttempts,
      isLocked: isLocked ?? this.isLocked,
      lockedUntil: lockedUntil ?? this.lockedUntil,
    );
  }
}

/// Transaction PIN cubit
class TransactionPinCubit extends Cubit<TransactionPinState> {
  final ITransactionPinService transactionPinService;

  TransactionPinCubit(this.transactionPinService)
      : super(const TransactionPinState());

  /// Check if user has PIN set up
  Future<void> checkUserHasPin() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final hasPin = await transactionPinService.checkUserHasPin();
      emit(state.copyWith(
        hasPin: hasPin,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Create a new transaction PIN
  Future<bool> createPin({
    required String pin,
    required String confirmPin,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final success = await transactionPinService.createPin(
        pin: pin,
        confirmPin: confirmPin,
      );

      if (success) {
        emit(state.copyWith(
          hasPin: true,
          isLoading: false,
        ));
        return true;
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to create PIN',
        ));
        return false;
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
      return false;
    }
  }

  /// Verify transaction PIN
  Future<TransactionPinVerificationResult?> verifyPin({
    required String pin,
    required String transactionId,
    required String transactionType,
    required double amount,
    required String currency,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final result = await transactionPinService.verifyPin(
        pin: pin,
        transactionId: transactionId,
        transactionType: transactionType,
        amount: amount,
        currency: currency,
      );

      emit(state.copyWith(
        isLoading: false,
        remainingAttempts: result.remainingAttempts,
        isLocked: result.isLocked,
        lockedUntil: result.lockedUntil,
      ));

      return result;
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
      return null;
    }
  }

  /// Validate a verification token
  Future<bool> validateToken({
    required String token,
    required String transactionId,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final isValid = await transactionPinService.validateToken(
        token: token,
        transactionId: transactionId,
      );

      emit(state.copyWith(isLoading: false));
      return isValid;
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
      return false;
    }
  }

  /// Change existing PIN
  Future<bool> changePin({
    required String currentPin,
    required String newPin,
    required String confirmNewPin,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final success = await transactionPinService.changePin(
        currentPin: currentPin,
        newPin: newPin,
        confirmNewPin: confirmNewPin,
      );

      emit(state.copyWith(isLoading: false));
      return success;
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
      return false;
    }
  }

  /// Reset forgotten PIN
  Future<bool> resetPin({
    required String verificationCode,
    required String newPin,
    required String confirmNewPin,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final success = await transactionPinService.resetPin(
        verificationCode: verificationCode,
        newPin: newPin,
        confirmNewPin: confirmNewPin,
      );

      emit(state.copyWith(isLoading: false));
      return success;
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
      return false;
    }
  }

  /// Clear error message
  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }
}
