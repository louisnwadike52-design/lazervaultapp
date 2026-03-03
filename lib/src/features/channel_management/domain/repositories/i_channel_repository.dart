import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/channel_registration.dart';
import '../entities/channel_pin_status.dart';

abstract class IChannelRepository {
  /// Get all channel registrations for the current user.
  Future<Either<Failure, List<ChannelRegistration>>> getChannelRegistrations();

  /// Register a new banking channel (sends OTP to phone number).
  Future<Either<Failure, String>> registerChannel({
    required String channelType,
    required String phoneNumber,
  });

  /// Verify OTP to activate a channel registration.
  Future<Either<Failure, ChannelRegistration>> verifyChannelOTP({
    required String channelType,
    required String otpCode,
  });

  /// Deactivate a banking channel.
  Future<Either<Failure, bool>> deactivateChannel({
    required String channelType,
  });

  /// Get PIN status for all channels.
  Future<Either<Failure, List<ChannelPinStatus>>> getChannelPins();

  /// Create a PIN for a specific channel.
  Future<Either<Failure, bool>> createChannelPin({
    required String channelType,
    required String pin,
    required String confirmPin,
  });

  /// Change a PIN for a specific channel.
  Future<Either<Failure, bool>> changeChannelPin({
    required String channelType,
    required String currentPin,
    required String newPin,
    required String confirmNewPin,
  });
}
