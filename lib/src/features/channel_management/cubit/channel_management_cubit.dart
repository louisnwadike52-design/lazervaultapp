import 'package:flutter_bloc/flutter_bloc.dart';
import 'channel_management_state.dart';
import '../domain/repositories/i_channel_repository.dart';

class ChannelManagementCubit extends Cubit<ChannelManagementState> {
  final IChannelRepository _repository;

  ChannelManagementCubit({required IChannelRepository repository})
      : _repository = repository,
        super(const ChannelManagementInitial());

  /// Load all channel registrations and PIN statuses.
  Future<void> loadChannels() async {
    if (isClosed) return;
    emit(const ChannelManagementLoading());

    final regResult = await _repository.getChannelRegistrations();
    final pinResult = await _repository.getChannelPins();

    regResult.fold(
      (failure) {
        if (isClosed) return;
        emit(ChannelManagementError(failure.message));
      },
      (registrations) {
        if (isClosed) return;
        pinResult.fold(
          (failure) {
            // PINs failed but registrations loaded - show what we have
            emit(ChannelManagementLoaded(
              registrations: registrations,
              pinStatuses: [],
            ));
          },
          (pins) {
            emit(ChannelManagementLoaded(
              registrations: registrations,
              pinStatuses: pins,
            ));
          },
        );
      },
    );
  }

  /// Register a new banking channel (sends OTP).
  Future<void> registerChannel({
    required String channelType,
    required String phoneNumber,
  }) async {
    if (isClosed) return;
    emit(const ChannelManagementLoading());

    final result = await _repository.registerChannel(
      channelType: channelType,
      phoneNumber: phoneNumber,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(ChannelManagementError(failure.message));
      },
      (maskedPhone) {
        if (isClosed) return;
        emit(ChannelOtpSent(
          channelType: channelType,
          maskedPhone: maskedPhone,
        ));
      },
    );
  }

  /// Verify OTP to activate a channel.
  Future<void> verifyOTP({
    required String channelType,
    required String otpCode,
  }) async {
    if (isClosed) return;
    emit(const ChannelManagementLoading());

    final result = await _repository.verifyChannelOTP(
      channelType: channelType,
      otpCode: otpCode,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(ChannelManagementError(failure.message));
      },
      (registration) {
        if (isClosed) return;
        emit(ChannelActivated(registration));
      },
    );
  }

  /// Deactivate a banking channel.
  Future<void> deactivateChannel({required String channelType}) async {
    if (isClosed) return;
    emit(const ChannelManagementLoading());

    final result = await _repository.deactivateChannel(
      channelType: channelType,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(ChannelManagementError(failure.message));
      },
      (_) {
        if (isClosed) return;
        emit(ChannelDeactivated(channelType));
      },
    );
  }

  /// Create a PIN for a specific channel.
  Future<void> createPin({
    required String channelType,
    required String pin,
    required String confirmPin,
  }) async {
    if (isClosed) return;
    emit(const ChannelManagementLoading());

    final result = await _repository.createChannelPin(
      channelType: channelType,
      pin: pin,
      confirmPin: confirmPin,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(ChannelManagementError(failure.message));
      },
      (_) {
        if (isClosed) return;
        emit(ChannelPinCreated(channelType));
      },
    );
  }

  /// Change a PIN for a specific channel.
  Future<void> changePin({
    required String channelType,
    required String currentPin,
    required String newPin,
    required String confirmNewPin,
  }) async {
    if (isClosed) return;
    emit(const ChannelManagementLoading());

    final result = await _repository.changeChannelPin(
      channelType: channelType,
      currentPin: currentPin,
      newPin: newPin,
      confirmNewPin: confirmNewPin,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(ChannelManagementError(failure.message));
      },
      (_) {
        if (isClosed) return;
        emit(ChannelPinChanged(channelType));
      },
    );
  }
}
