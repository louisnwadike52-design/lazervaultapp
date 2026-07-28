import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/authentication/data/models/user_model.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/profile/data/models/user_preferences_model.dart';
import 'package:lazervault/src/features/profile/data/services/profile_picture_upload_service.dart';
import 'package:lazervault/src/features/profile/domain/entities/user_preferences.dart' as domain;
import 'package:lazervault/src/features/profile/domain/repositories/i_profile_repository.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';
import 'package:lazervault/src/generated/auth.pb.dart' as auth_pb;
import 'package:lazervault/src/generated/auth.pbgrpc.dart' as auth_grpc;
import 'package:lazervault/src/generated/user.pbgrpc.dart';
import 'package:lazervault/src/generated/user.pb.dart' as user_pb;

/// Sentinel value understood by auth-service.UpdateProfile to clear
/// `users.profile_picture`. Empty-string is a no-op for parity with
/// other partial-update fields, so we need an explicit marker.
const String _profilePictureRemoveSentinel = '__REMOVE__';

class ProfileRepositoryImpl implements IProfileRepository {
  final UserServiceClient _userServiceClient;
  final auth_grpc.AuthServiceClient _authServiceClient;
  final GrpcCallOptionsHelper _callOptionsHelper;
  final ProfilePictureUploadService _profilePictureUploadService;

  ProfileRepositoryImpl({
    required UserServiceClient userServiceClient,
    required auth_grpc.AuthServiceClient authServiceClient,
    required GrpcCallOptionsHelper callOptionsHelper,
    required ProfilePictureUploadService profilePictureUploadService,
  })  : _userServiceClient = userServiceClient,
        _authServiceClient = authServiceClient,
        _callOptionsHelper = callOptionsHelper,
        _profilePictureUploadService = profilePictureUploadService;

  @override
  Future<Either<Failure, Map<String, dynamic>>> getUserProfile() async {
    try {
      // Wrap in token rotation so a merely-expired access token is transparently
      // refreshed + the call retried once (matches budget/recipients/funds/etc.).
      // This is the session gate for biometric unlock — WITHOUT rotation here a
      // fingerprint/Face-ID login whose cached access token had expired would
      // fail at the gate ("Session expired") even though the refresh token is
      // still valid. `withAuth()` is computed INSIDE the closure so the retry
      // picks up the rotated access token, not the stale one.
      final request = user_pb.GetUserProfileRequest();
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return _userServiceClient.getUserProfile(
          request,
          options: callOptions,
        );
      });

      if (response.success && response.hasUser()) {
        final userModel = UserModel.fromProto(response.user);
        final preferencesModel = response.hasPreferences()
            ? UserPreferencesModel.fromProto(response.preferences)
            : UserPreferencesModel(
                userId: userModel.id,
                pushNotifications: true,
                emailNotifications: true,
                smsNotifications: false,
                darkMode: false,
                language: 'en',
                currency: 'GBP',
                country: 'United Kingdom',
              );

        return Right({
          'user': userModel,
          'preferences': preferencesModel,
        });
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to get user profile',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error getting user profile: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to get user profile',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error getting user profile: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, User>> updateUserProfile({
    String? firstName,
    String? lastName,
    String? username,
    String? phoneNumber,
    String? language,
    String? currency,
    String? country,
    String? profilePicture,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = user_pb.UpdateUserProfileRequest(
        firstName: firstName ?? '',
        lastName: lastName ?? '',
        username: username ?? '',
        phoneNumber: phoneNumber ?? '',
        language: language ?? '',
        currency: currency ?? '',
        country: country ?? '',
        profilePicture: profilePicture ?? '',
      );
      final response = await _userServiceClient.updateUserProfile(
        request,
        options: callOptions,
      );

      if (response.success && response.hasUser()) {
        final userModel = UserModel.fromProto(response.user);
        return Right(userModel);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to update user profile',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error updating user profile: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to update user profile',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error updating user profile: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, User>> uploadProfilePicture({
    File? file,
    Uint8List? bytes,
    String? filename,
  }) async {
    if (file == null && (bytes == null || filename == null)) {
      return Left(ServerFailure(
        message: 'No image provided.',
        statusCode: 400,
      ));
    }
    try {
      // 1. Upload bytes to storage via core-gateway proxy → returns
      //    the public URL we should stamp on the user record.
      final result = file != null
          ? await _profilePictureUploadService.uploadFromFile(file)
          : await _profilePictureUploadService.uploadBytes(
              bytes: bytes!,
              filename: filename!,
              contentType:
                  ProfilePictureUploadService.contentTypeFor(filename),
            );
      // 2. Persist the URL on auth-service.users.profile_picture.
      return await updateUserProfile(profilePicture: result.publicUrl);
    } on ProfilePictureUploadException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: 502));
    } catch (e) {
      print('Unexpected error uploading profile picture: $e');
      return Left(ServerFailure(
        message: 'Failed to upload profile picture.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, User>> removeProfilePicture() async {
    // Send the sentinel value through the existing UpdateProfile path —
    // auth-service interprets `__REMOVE__` as "clear this field".
    return updateUserProfile(profilePicture: _profilePictureRemoveSentinel);
  }

  @override
  Future<Either<Failure, void>> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = user_pb.UpdatePasswordRequest(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      final response = await _userServiceClient.updatePassword(
        request,
        options: callOptions,
      );

      if (response.success) {
        return const Right(null);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to update password',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error updating password: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to update password',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error updating password: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, domain.UserPreferences>> updatePreferences({
    bool? pushNotifications,
    bool? emailNotifications,
    bool? smsNotifications,
    bool? darkMode,
    String? language,
    String? currency,
    List<String>? preferredCountries,
    String? activeCountry,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = user_pb.UpdatePreferencesRequest(
        pushNotifications: pushNotifications ?? true,
        emailNotifications: emailNotifications ?? true,
        smsNotifications: smsNotifications ?? false,
        darkMode: darkMode ?? false,
        language: language ?? 'en',
        currency: currency ?? 'GBP',
        preferredCountries: preferredCountries ?? [],
        activeCountry: activeCountry ?? '',
      );
      final response = await _userServiceClient.updatePreferences(
        request,
        options: callOptions,
      );

      if (response.success && response.hasPreferences()) {
        final preferencesModel =
            UserPreferencesModel.fromProto(response.preferences);
        return Right(preferencesModel);
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to update preferences',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error updating preferences: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to update preferences',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error updating preferences: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<List<UserSearchResultEntity>> searchUsers({
    required String query,
    int limit = 10,
    int offset = 0,
    String searchType = '', // Empty for unified search across username, name, phone, email
  }) async {
    try {
      final request = auth_pb.UserSearchRequest()
        ..query = query
        ..limit = limit
        ..offset = offset
        ..searchType = searchType;

      print('[ProfileRepository] searchUsers: query="$query", limit=$limit, offset=$offset, searchType="$searchType"');
      // Bound the RPC with a gRPC deadline — withAuth() only sets metadata, no
      // timeout, so without this a hung search would never return and the
      // caller's loading spinner would be stuck. DeadlineExceeded is caught
      // below and surfaces as an empty result (graceful "no matches").
      final options = (await _callOptionsHelper.withAuth())
          .mergedWith(CallOptions(timeout: const Duration(seconds: 15)));
      final response = await _authServiceClient.searchUsers(
        request,
        options: options,
      );

      print('[ProfileRepository] searchUsers response: success=${response.success}, msg="${response.msg}", users=${response.users.length}');
      if (!response.success) {
        print('[ProfileRepository] User search failed: ${response.msg}');
        return [];
      }

      return response.users
          .map((user) => UserSearchResultEntity(
                userId: user.userId,
                username: user.username,
                firstName: user.firstName,
                lastName: user.lastName,
                email: user.email,
                phoneNumber: user.phoneNumber,
                profilePicture: user.profilePicture,
                primaryAccountId: user.hasPrimaryAccountId() ? user.primaryAccountId : null,
                emailMatchesSearchQuery: user.emailMatchesSearchQuery,
                phoneMatchesSearchQueryExact: user.phoneMatchesSearchQueryExact,
              ))
          .toList();
    } on GrpcError catch (e) {
      print('[ProfileRepository] gRPC Error searching users: ${e.codeName} - ${e.message}');
      return [];
    } catch (e) {
      print('[ProfileRepository] Error searching users: $e');
      return [];
    }
  }
}
