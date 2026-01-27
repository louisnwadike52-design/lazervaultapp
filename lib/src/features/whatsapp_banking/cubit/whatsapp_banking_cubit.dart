import 'package:flutter_bloc/flutter_bloc.dart';
import 'whatsapp_banking_state.dart';
import '../domain/usecases/get_link_status_usecase.dart';
import '../domain/usecases/initiate_linking_usecase.dart';
import '../domain/usecases/verify_linking_usecase.dart';
import '../domain/usecases/unlink_account_usecase.dart';
import '../domain/usecases/get_security_settings_usecase.dart';
import '../domain/usecases/update_security_settings_usecase.dart';

class WhatsAppBankingCubit extends Cubit<WhatsAppBankingState> {
  final GetLinkStatusUseCase _getLinkStatus;
  final InitiateLinkingUseCase _initiateLinking;
  final VerifyLinkingUseCase _verifyLinking;
  final UnlinkAccountUseCase _unlinkAccount;
  final GetSecuritySettingsUseCase _getSecuritySettings;
  final UpdateSecuritySettingsUseCase _updateSecuritySettings;

  WhatsAppBankingCubit({
    required GetLinkStatusUseCase getLinkStatus,
    required InitiateLinkingUseCase initiateLinking,
    required VerifyLinkingUseCase verifyLinking,
    required UnlinkAccountUseCase unlinkAccount,
    required GetSecuritySettingsUseCase getSecuritySettings,
    required UpdateSecuritySettingsUseCase updateSecuritySettings,
  })  : _getLinkStatus = getLinkStatus,
        _initiateLinking = initiateLinking,
        _verifyLinking = verifyLinking,
        _unlinkAccount = unlinkAccount,
        _getSecuritySettings = getSecuritySettings,
        _updateSecuritySettings = updateSecuritySettings,
        super(const WhatsAppBankingInitial());

  Future<void> loadStatus() async {
    if (isClosed) return;
    emit(const WhatsAppBankingLoading());
    final result = await _getLinkStatus();
    result.fold(
      (failure) {
        if (isClosed) return;
        // Not found means no linked account - show unlinked view
        if (failure.statusCode == 404 || failure.statusCode == 5) {
          emit(const WhatsAppBankingLoaded(user: null, settings: null));
        } else {
          emit(WhatsAppBankingError(failure.message));
        }
      },
      (user) {
        if (isClosed) return;
        emit(WhatsAppBankingLoaded(user: user, settings: null));
      },
    );
  }

  Future<void> initiateLinking(String phoneNumber) async {
    if (isClosed) return;
    emit(const WhatsAppBankingLoading());
    final result = await _initiateLinking(phoneNumber: phoneNumber);
    result.fold(
      (failure) {
        if (isClosed) return;
        emit(WhatsAppBankingError(failure.message));
      },
      (otpReference) {
        if (isClosed) return;
        emit(WhatsAppBankingOtpSent(
            otpReference: otpReference, phoneNumber: phoneNumber));
      },
    );
  }

  Future<void> verifyLinking(String phoneNumber, String otpCode) async {
    if (isClosed) return;
    emit(const WhatsAppBankingLoading());
    final result =
        await _verifyLinking(phoneNumber: phoneNumber, otpCode: otpCode);
    result.fold(
      (failure) {
        if (isClosed) return;
        emit(WhatsAppBankingError(failure.message));
      },
      (user) {
        if (isClosed) return;
        emit(WhatsAppBankingLinkingSuccess(user));
      },
    );
  }

  Future<void> unlinkAccount() async {
    if (isClosed) return;
    emit(const WhatsAppBankingLoading());
    final result = await _unlinkAccount();
    result.fold(
      (failure) {
        if (isClosed) return;
        emit(WhatsAppBankingError(failure.message));
      },
      (_) {
        if (isClosed) return;
        emit(const WhatsAppBankingUnlinkSuccess());
      },
    );
  }

  Future<void> loadSecuritySettings() async {
    if (isClosed) return;
    emit(const WhatsAppBankingLoading());
    final result = await _getSecuritySettings();
    result.fold(
      (failure) {
        if (isClosed) return;
        emit(WhatsAppBankingError(failure.message));
      },
      (settings) {
        if (isClosed) return;
        emit(WhatsAppBankingLoaded(settings: settings));
      },
    );
  }

  Future<void> updateSecuritySettings({
    required double dailyTransactionLimit,
    required double perTransactionLimit,
    required bool requirePinForAll,
    required double biometricThreshold,
  }) async {
    if (isClosed) return;
    emit(const WhatsAppBankingLoading());
    final result = await _updateSecuritySettings(
      dailyTransactionLimit: dailyTransactionLimit,
      perTransactionLimit: perTransactionLimit,
      requirePinForAll: requirePinForAll,
      biometricThreshold: biometricThreshold,
    );
    result.fold(
      (failure) {
        if (isClosed) return;
        emit(WhatsAppBankingError(failure.message));
      },
      (settings) {
        if (isClosed) return;
        emit(WhatsAppBankingSettingsUpdated(settings));
      },
    );
  }
}
