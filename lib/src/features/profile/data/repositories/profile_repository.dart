import 'dart:io';
import 'package:lazervault/src/features/recipients/data/datasources/lazervault_account_lookup.dart';
import 'package:lazervault/src/features/recipients/domain/services/account_number_augment.dart';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/authentication/domain/entities/postal_address.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/authentication/data/models/user_model.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/profile/data/models/user_preferences_model.dart';
import 'package:lazervault/src/features/profile/data/services/profile_picture_upload_service.dart';
import 'package:lazervault/src/features/profile/domain/entities/user_preferences.dart'
    as domain;
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

  /// Resolves a typed ACCOUNT NUMBER to its owner, so this search can answer
  /// one. auth-service's `users` table holds no account numbers — they live in
  /// `accounts`, a schema auth_role cannot see — so no `searchType` and no
  /// query shaping can produce that answer from the directory alone.
  ///
  /// SUPPLIED AS A GETTER, NOT AN INSTANCE, TO BREAK A DEPENDENCY CYCLE.
  /// LazervaultAccountLookup takes an IProfileRepository of its own (it
  /// enriches an account hit with the owner's @handle), so constructing one
  /// here would be circular and get_it would recurse forever on the first
  /// resolve. Deferring the lookup to call time means both objects exist
  /// before either is needed.
  ///
  /// Optional: when absent this search behaves exactly as it did before, so a
  /// wiring gap degrades to the old behaviour rather than to an error.
  final LazervaultAccountLookup? Function()? _accountLookup;

  ProfileRepositoryImpl({
    required UserServiceClient userServiceClient,
    required auth_grpc.AuthServiceClient authServiceClient,
    required GrpcCallOptionsHelper callOptionsHelper,
    required ProfilePictureUploadService profilePictureUploadService,
    LazervaultAccountLookup? Function()? accountLookup,
  })  : _userServiceClient = userServiceClient,
        _authServiceClient = authServiceClient,
        _callOptionsHelper = callOptionsHelper,
        _profilePictureUploadService = profilePictureUploadService,
        _accountLookup = accountLookup;

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
      final response =
          await _callOptionsHelper.executeWithTokenRotation(() async {
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
    /// OPTIONAL. NULL means "leave it alone"; a non-null value (including the
    /// empty string, which clears it) sets the companion flag so the server
    /// applies it. Without that distinction every save from every screen would
    /// erase a middle name, because proto3 sends "" for a field it does not
    /// know about.
    String? middleName,
    String? username,
    String? phoneNumber,
    String? language,
    String? currency,
    String? country,
    String? profilePicture,
    PostalAddress? address,
    /// ISO YYYY-MM-DD. Null or empty leaves the stored date alone — the server
    /// treats empty as "not touched" for the same reason updateAddress exists,
    /// so a name save can never blank someone's date of birth.
    String? dateOfBirth,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = user_pb.UpdateUserProfileRequest(
        firstName: firstName ?? '',
        lastName: lastName ?? '',
        middleName: middleName ?? '',
        updateMiddleName: middleName != null,
        username: username ?? '',
        phoneNumber: phoneNumber ?? '',
        language: language ?? '',
        currency: currency ?? '',
        country: country ?? '',
        profilePicture: profilePicture ?? '',
        // updateAddress is what makes an empty field mean "clear this line"
        // instead of "leave it alone". Without the flag the backend cannot
        // tell a deliberate deletion from a request that never mentioned the
        // address — and every other profile save would wipe it.
        updateAddress: address != null,
        addressLine1: address?.line1 ?? '',
        addressLine2: address?.line2 ?? '',
        addressCity: address?.city ?? '',
        addressState: address?.state ?? '',
        addressPostalCode: address?.postalCode ?? '',
        addressCountry: address?.country ?? '',
        dateOfBirth: dateOfBirth ?? '',
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
              contentType: ProfilePictureUploadService.contentTypeFor(filename),
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
    String searchType =
        '', // Empty for unified search across username, name, phone, email
  }) async {
    // Started BEFORE the directory call so the two run together: an
    // account-number query costs one round trip, not two in series. Resolved
    // through the getter so the cycle described on _accountLookup stays
    // broken. Never throws — a term that is not a live Lazervault account
    // simply answers null, which is the common case.
    LazervaultAccountLookup? lookup;
    try {
      lookup = _accountLookup?.call();
    } catch (_) {
      lookup = null; // a wiring problem must not break search
    }
    final accountFuture =
        AccountNumberAugment.start(lookup, query, offset: offset);

    try {
      final request = auth_pb.UserSearchRequest()
        ..query = query
        ..limit = limit
        ..offset = offset
        ..searchType = searchType;

      print(
          '[ProfileRepository] searchUsers: query="$query", limit=$limit, offset=$offset, searchType="$searchType"');
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

      print(
          '[ProfileRepository] searchUsers response: success=${response.success}, msg="${response.msg}", users=${response.users.length}');
      if (!response.success) {
        print('[ProfileRepository] User search failed: ${response.msg}');
        // An account-number hit still stands on its own: the directory
        // failing says nothing about whether that account exists.
        return AccountNumberAugment.merge<UserSearchResultEntity>(
          results: const <UserSearchResultEntity>[],
          match: await accountFuture,
          userIdOf: (r) => r.userId,
          map: _accountMatchToEntity,
        );
      }

      final directory = response.users
          .map((user) => UserSearchResultEntity(
                userId: user.userId,
                username: user.username,
                firstName: user.firstName,
                lastName: user.lastName,
                email: user.email,
                phoneNumber: user.phoneNumber,
                profilePicture: user.profilePicture,
                primaryAccountId:
                    user.hasPrimaryAccountId() ? user.primaryAccountId : null,
                emailMatchesSearchQuery: user.emailMatchesSearchQuery,
                phoneMatchesSearchQueryExact: user.phoneMatchesSearchQueryExact,
              ))
          .toList();

      // ALWAYS IN ADDITION, NEVER INSTEAD. The same digits can be a phone
      // number, and whoever typed them neither knows nor should have to say
      // which they meant, so both readings are offered. The account hit leads,
      // because an exact account match beats a substring of someone's phone.
      return AccountNumberAugment.merge<UserSearchResultEntity>(
        results: directory,
        match: await accountFuture,
        userIdOf: (r) => r.userId,
        map: _accountMatchToEntity,
      );
    } on GrpcError catch (e) {
      print(
          '[ProfileRepository] gRPC Error searching users: ${e.codeName} - ${e.message}');
      return _accountOnlyResult(await accountFuture);
    } catch (e) {
      print('[ProfileRepository] Error searching users: $e');
      return _accountOnlyResult(await accountFuture);
    }
  }

  /// The account hit alone, for when the directory call failed. A timeout on
  /// the directory is not evidence that the account does not exist, and
  /// dropping a confirmed account because an unrelated RPC was slow is how a
  /// payer concludes their payee is not on Lazervault.
  List<UserSearchResultEntity> _accountOnlyResult(
      LazervaultAccountMatch? match) {
    return AccountNumberAugment.merge<UserSearchResultEntity>(
      results: const <UserSearchResultEntity>[],
      match: match,
      userIdOf: (r) => r.userId,
      map: _accountMatchToEntity,
    );
  }

  static UserSearchResultEntity _accountMatchToEntity(
      LazervaultAccountMatch m) {
    final name = AccountNumberAugment.splitHolderName(m.holderName);
    return UserSearchResultEntity(
      userId: m.userId,
      username: m.username,
      firstName: name.first,
      lastName: name.last,
      email: '',
      phoneNumber: '',
      profilePicture: m.profilePicture,
      // The account the NUMBER names, which is not necessarily the payee's
      // primary one — a saved number often belongs to a family or business
      // account. Paying the wrong account of the right person is still wrong.
      primaryAccountId: m.accountId,
      isLazervault: true,
    );
  }
}
