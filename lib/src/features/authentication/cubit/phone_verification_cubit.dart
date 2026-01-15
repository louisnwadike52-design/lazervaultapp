import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_verification_state.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/request_phone_verification_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/verify_phone_number_usecase.dart';

class PhoneVerificationCubit extends Cubit<PhoneVerificationState> {
  final RequestPhoneVerificationUseCase _requestPhoneVerificationUseCase;
  final VerifyPhoneNumberUseCase _verifyPhoneNumberUseCase;

  PhoneVerificationCubit({
    required RequestPhoneVerificationUseCase requestPhoneVerificationUseCase,
    required VerifyPhoneNumberUseCase verifyPhoneNumberUseCase,
  })  : _requestPhoneVerificationUseCase = requestPhoneVerificationUseCase,
        _verifyPhoneNumberUseCase = verifyPhoneNumberUseCase,
        super(PhoneVerificationInitial());

  // Update phone number
  void updatePhoneNumber(String phoneNumber) {
    if (state is PhoneVerificationInProgress) {
      if (isClosed) return;
      emit((state as PhoneVerificationInProgress)
          .copyWith(phoneNumber: phoneNumber));
    } else {
      if (isClosed) return;
      emit(PhoneVerificationInProgress(phoneNumber: phoneNumber));
    }
  }

  // Update verification code
  void updateVerificationCode(String code) {
    if (state is PhoneVerificationInProgress) {
      if (isClosed) return;
      emit((state as PhoneVerificationInProgress)
          .copyWith(verificationCode: code));
    } else {
      if (isClosed) return;
      emit(PhoneVerificationInProgress(verificationCode: code));
    }
  }

  // Request phone verification (send SMS)
  Future<void> requestPhoneVerification({required String phoneNumber}) async {
    if (isClosed) return;
    emit(PhoneVerificationSending());

    final result = await _requestPhoneVerificationUseCase.call(
      phoneNumber: phoneNumber,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        emit(PhoneVerificationFailure(message: failure.message));
        // Return to in-progress state with error
        emit(PhoneVerificationInProgress(
          phoneNumber: phoneNumber,
          errorMessage: failure.message,
        ));
      },
      (response) {
        if (response.success) {
          emit(PhoneVerificationCodeSent(
            message: response.message,
            verificationId: response.verificationId,
            expiresIn: response.expiresIn,
          ));
          // Transition to in-progress state for code entry
          emit(PhoneVerificationInProgress(
            phoneNumber: phoneNumber,
            successMessage: response.message,
          ));
        } else {
          emit(PhoneVerificationFailure(message: response.message));
          emit(PhoneVerificationInProgress(
            phoneNumber: phoneNumber,
            errorMessage: response.message,
          ));
        }
      },
    );
  }

  // Verify phone number
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required String verificationCode,
  }) async {
    if (isClosed) return;
    emit(PhoneVerificationVerifying());

    final result = await _verifyPhoneNumberUseCase.call(
      phoneNumber: phoneNumber,
      verificationCode: verificationCode,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        emit(PhoneVerificationFailure(message: failure.message));
        // Return to in-progress state with error
        emit(PhoneVerificationInProgress(
          phoneNumber: phoneNumber,
          verificationCode: verificationCode,
          errorMessage: failure.message,
        ));
      },
      (response) {
        if (response.success && response.isVerified) {
          emit(PhoneVerificationSuccess(message: response.message));
        } else {
          emit(PhoneVerificationFailure(message: response.message));
          emit(PhoneVerificationInProgress(
            phoneNumber: phoneNumber,
            verificationCode: verificationCode,
            errorMessage: response.message,
          ));
        }
      },
    );
  }

  // Resend verification code
  Future<void> resendVerificationCode({required String phoneNumber}) async {
    if (isClosed) return;
    emit(PhoneVerificationInProgress(
      phoneNumber: phoneNumber,
      isSending: true,
      successMessage: 'Resending verification code...',
    ));

    await requestPhoneVerification(phoneNumber: phoneNumber);
  }

  // Verification is now mandatory - no skip functionality
  // void skipVerification() {
  //   if (isClosed) return;
  //   emit(PhoneVerificationSkipped());
  // }

  // Reset state
  void reset() {
    if (isClosed) return;
    emit(PhoneVerificationInitial());
  }
}
