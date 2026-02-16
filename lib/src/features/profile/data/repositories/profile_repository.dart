import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/authentication/data/models/user_model.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/profile/data/models/user_preferences_model.dart';
import 'package:lazervault/src/features/profile/domain/entities/user_preferences.dart' as domain;
import 'package:lazervault/src/features/profile/domain/repositories/i_profile_repository.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';
import 'package:lazervault/src/generated/auth.pb.dart' as auth_pb;
import 'package:lazervault/src/generated/auth.pbgrpc.dart' as auth_grpc;
import 'package:lazervault/src/generated/user.pbgrpc.dart';
import 'package:lazervault/src/generated/user.pb.dart' as user_pb;

class ProfileRepositoryImpl implements IProfileRepository {
  final UserServiceClient _userServiceClient;
  final auth_grpc.AuthServiceClient _authServiceClient;
  final GrpcCallOptionsHelper _callOptionsHelper;

  ProfileRepositoryImpl({
    required UserServiceClient userServiceClient,
    required auth_grpc.AuthServiceClient authServiceClient,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _userServiceClient = userServiceClient,
        _authServiceClient = authServiceClient,
        _callOptionsHelper = callOptionsHelper;

  @override
  Future<Either<Failure, Map<String, dynamic>>> getUserProfile() async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = user_pb.GetUserProfileRequest();
      final response = await _userServiceClient.getUserProfile(
        request,
        options: callOptions,
      );

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
    String searchType = '', // Empty for unified search across username, name, phone, email
  }) async {
    try {
      final request = auth_pb.UserSearchRequest()
        ..query = query
        ..limit = limit
        ..searchType = searchType;

      print('[ProfileRepository] searchUsers: query="$query", limit=$limit, searchType="$searchType"');
      final options = await _callOptionsHelper.withAuth();
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
