import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/channel_management/data/models/channel_registration_model.dart';
import 'package:lazervault/src/features/channel_management/data/models/channel_pin_status_model.dart';
import 'package:lazervault/src/features/channel_management/domain/entities/channel_registration.dart';
import 'package:lazervault/src/features/channel_management/domain/entities/channel_pin_status.dart'
    as entity;
import 'package:lazervault/src/features/channel_management/domain/repositories/i_channel_repository.dart';
import 'package:lazervault/src/generated/transaction_pin.pbgrpc.dart';
import 'package:lazervault/src/generated/transaction_pin.pb.dart' as pin_pb;
import 'package:lazervault/src/generated/transaction_pin.pbenum.dart' as pin_enum;

class ChannelRepositoryImpl implements IChannelRepository {
  final TransactionPinServiceClient _pinClient;
  final GrpcCallOptionsHelper _callOptionsHelper;
  final SecureStorageService _secureStorage;

  ChannelRepositoryImpl({
    required TransactionPinServiceClient pinClient,
    required GrpcCallOptionsHelper callOptionsHelper,
    required SecureStorageService secureStorage,
  })  : _pinClient = pinClient,
        _callOptionsHelper = callOptionsHelper,
        _secureStorage = secureStorage;

  Future<String> _getUserId() async {
    final userId = await _secureStorage.getUserId();
    if (userId == null || userId.isEmpty) {
      throw const ServerFailure(
          message: 'User not authenticated', statusCode: 401);
    }
    return userId;
  }

  @override
  Future<Either<Failure, List<ChannelRegistration>>>
      getChannelRegistrations() async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final userId = await _getUserId();
      final request = pin_pb.GetChannelRegistrationsRequest(userId: userId);
      final response = await _pinClient.getChannelRegistrations(request,
          options: callOptions);
      final registrations = response.registrations
          .map((r) => ChannelRegistrationModel.fromProto(r))
          .toList();
      return Right(registrations);
    } on ServerFailure catch (e) {
      return Left(e);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to get channel registrations',
          statusCode: e.code));
    } catch (e) {
      return Left(
          ServerFailure(message: 'An unexpected error occurred', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, String>> registerChannel({
    required String channelType,
    required String phoneNumber,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final userId = await _getUserId();
      final request = pin_pb.CreateChannelRegistrationRequest(
        userId: userId,
        channelType: channelType,
        phoneNumber: phoneNumber,
      );
      final response = await _pinClient.createChannelRegistration(request,
          options: callOptions);
      if (response.success) {
        return Right(response.maskedPhone);
      }
      return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Channel registration failed',
          statusCode: 400));
    } on ServerFailure catch (e) {
      return Left(e);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to register channel',
          statusCode: e.code));
    } catch (e) {
      return Left(
          ServerFailure(message: 'An unexpected error occurred', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, ChannelRegistration>> verifyChannelOTP({
    required String channelType,
    required String otpCode,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final userId = await _getUserId();
      final request = pin_pb.VerifyChannelOTPRequest(
        userId: userId,
        channelType: channelType,
        otpCode: otpCode,
      );
      final response =
          await _pinClient.verifyChannelOTP(request, options: callOptions);
      if (response.success && response.hasRegistration()) {
        return Right(
            ChannelRegistrationModel.fromProto(response.registration));
      }
      return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'OTP verification failed',
          statusCode: 400));
    } on ServerFailure catch (e) {
      return Left(e);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to verify OTP', statusCode: e.code));
    } catch (e) {
      return Left(
          ServerFailure(message: 'An unexpected error occurred', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, bool>> deactivateChannel({
    required String channelType,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final userId = await _getUserId();
      final request = pin_pb.DeactivateChannelRequest(
        userId: userId,
        channelType: channelType,
      );
      final response =
          await _pinClient.deactivateChannel(request, options: callOptions);
      if (response.success) {
        return const Right(true);
      }
      return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Deactivation failed',
          statusCode: 400));
    } on ServerFailure catch (e) {
      return Left(e);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to deactivate channel',
          statusCode: e.code));
    } catch (e) {
      return Left(
          ServerFailure(message: 'An unexpected error occurred', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<entity.ChannelPinStatus>>> getChannelPins() async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final userId = await _getUserId();
      final request = pin_pb.GetUserChannelPinsRequest(userId: userId);
      final response =
          await _pinClient.getUserChannelPins(request, options: callOptions);
      final pins = response.channelPins
          .map((p) => ChannelPinStatusModel.fromProto(p))
          .toList();
      return Right(pins);
    } on ServerFailure catch (e) {
      return Left(e);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to get channel PINs',
          statusCode: e.code));
    } catch (e) {
      return Left(
          ServerFailure(message: 'An unexpected error occurred', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, bool>> createChannelPin({
    required String channelType,
    required String pin,
    required String confirmPin,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final userId = await _getUserId();
      final deviceInfo = DeviceInfoPlugin();
      String deviceId = 'unknown';
      String deviceName = 'Unknown Device';
      try {
        final iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? 'ios-unknown';
        deviceName = iosInfo.name;
      } catch (_) {
        try {
          final androidInfo = await deviceInfo.androidInfo;
          deviceId = androidInfo.id;
          deviceName = '${androidInfo.manufacturer} ${androidInfo.model}';
        } catch (_) {}
      }

      final request = pin_pb.CreateTransactionPinRequest(
        userId: userId,
        pin: pin,
        confirmPin: confirmPin,
        deviceId: deviceId,
        deviceName: deviceName,
        channelType: _channelTypeToProto(channelType),
      );
      final response = await _pinClient.createTransactionPin(request,
          options: callOptions);
      if (response.success) {
        return const Right(true);
      }
      return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to create PIN',
          statusCode: 400));
    } on ServerFailure catch (e) {
      return Left(e);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to create channel PIN',
          statusCode: e.code));
    } catch (e) {
      return Left(
          ServerFailure(message: 'An unexpected error occurred', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, bool>> changeChannelPin({
    required String channelType,
    required String currentPin,
    required String newPin,
    required String confirmNewPin,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final userId = await _getUserId();
      final request = pin_pb.ChangeTransactionPinRequest(
        userId: userId,
        currentPin: currentPin,
        newPin: newPin,
        confirmNewPin: confirmNewPin,
        channelType: _channelTypeToProto(channelType),
      );
      final response = await _pinClient.changeTransactionPin(request,
          options: callOptions);
      if (response.success) {
        return const Right(true);
      }
      return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to change PIN',
          statusCode: 400));
    } on ServerFailure catch (e) {
      return Left(e);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to change channel PIN',
          statusCode: e.code));
    } catch (e) {
      return Left(
          ServerFailure(message: 'An unexpected error occurred', statusCode: 500));
    }
  }

  static pin_enum.PinChannelType _channelTypeToProto(String channelType) {
    switch (channelType) {
      case 'whatsapp':
        return pin_enum.PinChannelType.PIN_CHANNEL_WHATSAPP;
      case 'telephony':
        return pin_enum.PinChannelType.PIN_CHANNEL_TELEPHONY;
      default:
        return pin_enum.PinChannelType.PIN_CHANNEL_APP;
    }
  }
}
