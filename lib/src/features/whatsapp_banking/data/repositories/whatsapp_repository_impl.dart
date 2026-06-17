import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/whatsapp_banking/domain/entities/whatsapp_user.dart';
import 'package:lazervault/src/features/whatsapp_banking/domain/entities/security_settings.dart';
import 'package:lazervault/src/features/whatsapp_banking/domain/repositories/i_whatsapp_repository.dart';
import 'package:lazervault/src/features/whatsapp_banking/data/models/whatsapp_user_model.dart';
import 'package:lazervault/src/features/whatsapp_banking/data/models/security_settings_model.dart';
import 'package:lazervault/src/generated/whatsapp.pbgrpc.dart' hide SecuritySettings, WhatsAppUser;
import 'package:lazervault/src/generated/whatsapp.pb.dart' as whatsapp_pb;

class WhatsAppRepositoryImpl implements IWhatsAppRepository {
  final WhatsAppServiceClient _serviceClient;
  final GrpcCallOptionsHelper _callOptionsHelper;

  WhatsAppRepositoryImpl({
    required WhatsAppServiceClient serviceClient,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _serviceClient = serviceClient,
        _callOptionsHelper = callOptionsHelper;

  @override
  Future<Either<Failure, WhatsAppUser>> getLinkStatus() async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = whatsapp_pb.GetLinkStatusRequest();
      final response =
          await _serviceClient.getLinkStatus(request, options: callOptions);
      if (response.hasWhatsappUser()) {
        return Right(WhatsAppUserModel.fromProto(response.whatsappUser));
      }
      return Left(ServerFailure(
          message: 'No WhatsApp account linked', statusCode: 404));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to get link status',
          statusCode: e.code));
    } catch (e) {
      return Left(ServerFailure(
          message: 'An unexpected error occurred', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, String>> initiateLinking(
      {required String phoneNumber}) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request =
          whatsapp_pb.InitiateLinkingRequest(phoneNumber: phoneNumber);
      final response =
          await _serviceClient.initiateLinking(request, options: callOptions);
      return Right(response.otpReference);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to initiate linking',
          statusCode: e.code));
    } catch (e) {
      return Left(ServerFailure(
          message: 'An unexpected error occurred', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, WhatsAppUser>> verifyLinking(
      {required String phoneNumber, required String otpCode}) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = whatsapp_pb.VerifyLinkingRequest(
          phoneNumber: phoneNumber, otpCode: otpCode);
      final response =
          await _serviceClient.verifyLinking(request, options: callOptions);
      if (response.success && response.hasWhatsappUser()) {
        return Right(WhatsAppUserModel.fromProto(response.whatsappUser));
      }
      return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Verification failed',
          statusCode: 400));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to verify linking',
          statusCode: e.code));
    } catch (e) {
      return Left(ServerFailure(
          message: 'An unexpected error occurred', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, bool>> unlinkAccount() async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = whatsapp_pb.UnlinkAccountRequest();
      final response =
          await _serviceClient.unlinkAccount(request, options: callOptions);
      if (response.success) {
        return const Right(true);
      }
      return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Unlink failed',
          statusCode: 400));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to unlink account',
          statusCode: e.code));
    } catch (e) {
      return Left(ServerFailure(
          message: 'An unexpected error occurred', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, SecuritySettings>> getSecuritySettings() async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = whatsapp_pb.GetSecuritySettingsRequest();
      final response = await _serviceClient.getSecuritySettings(request,
          options: callOptions);
      if (response.hasSettings()) {
        return Right(SecuritySettingsModel.fromProto(response.settings));
      }
      return Left(ServerFailure(
          message: 'No security settings found', statusCode: 404));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to get security settings',
          statusCode: e.code));
    } catch (e) {
      return Left(ServerFailure(
          message: 'An unexpected error occurred', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, SecuritySettings>> updateSecuritySettings({
    required double dailyTransactionLimit,
    required double perTransactionLimit,
    required bool requirePinForAll,
    required double biometricThreshold,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = whatsapp_pb.UpdateSecuritySettingsRequest(
        dailyTransactionLimit: dailyTransactionLimit,
        perTransactionLimit: perTransactionLimit,
        requirePinForAll: requirePinForAll,
        biometricThreshold: biometricThreshold,
      );
      final response = await _serviceClient.updateSecuritySettings(request,
          options: callOptions);
      if (response.hasSettings()) {
        return Right(SecuritySettingsModel.fromProto(response.settings));
      }
      return Left(ServerFailure(
          message: 'Failed to update settings', statusCode: 500));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to update security settings',
          statusCode: e.code));
    } catch (e) {
      return Left(ServerFailure(
          message: 'An unexpected error occurred', statusCode: 500));
    }
  }
}
