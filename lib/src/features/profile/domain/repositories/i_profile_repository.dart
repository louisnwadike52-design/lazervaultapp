import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';
import '../entities/user_preferences.dart';

abstract class IProfileRepository {
  // Get user profile
  Future<Either<Failure, Map<String, dynamic>>> getUserProfile();

  // Update user profile
  Future<Either<Failure, User>> updateUserProfile({
    String? firstName,
    String? lastName,
    String? username,
    String? phoneNumber,
    String? language,
    String? currency,
    String? country,
    String? profilePicture,
  });

  // Update password
  Future<Either<Failure, void>> updatePassword({
    required String currentPassword,
    required String newPassword,
  });

  // Search users by name, username, email, or phone (unified search when searchType is empty)
  // offset enables load-more pagination (skip already-fetched rows); 0 = first page.
  Future<List<UserSearchResultEntity>> searchUsers({
    required String query,
    int limit = 10,
    int offset = 0,
    String searchType = '', // "username", "name", "phone", "email", or "" for unified search
  });

  /// Upload a new profile picture, persist the resulting public URL on
  /// the user, and return the updated [User].
  ///
  /// Exactly one of [file] or ([bytes] + [filename]) must be provided.
  Future<Either<Failure, User>> uploadProfilePicture({
    File? file,
    Uint8List? bytes,
    String? filename,
  });

  /// Clear the user's existing profile picture (auth-service stores ""
  /// in `users.profile_picture`).
  Future<Either<Failure, User>> removeProfilePicture();

  // Update preferences
  Future<Either<Failure, UserPreferences>> updatePreferences({
    bool? pushNotifications,
    bool? emailNotifications,
    bool? smsNotifications,
    bool? darkMode,
    String? language,
    String? currency,
    List<String>? preferredCountries,
    String? activeCountry,
  });
}
